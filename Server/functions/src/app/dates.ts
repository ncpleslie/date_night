import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import Admin from './admin';
import DateRequest from '../models/date_request.model';
import DateDTO from '../models/date_dto.model';
import { StoredDate } from '../models/stored_date.model';
import { FirestoreConstants } from '../constants/firestore.constants';
import ErrorDTO from '../models/error_dto.model';

/**
 * Winning date decider.
 * @param request 
 * @param response 
 */
// TODO: Implement fuzzy matching
export const dates = async (request: functions.Request, response: functions.Response) => {

    const userId = await Admin.isAuthorizedUser(request);
    if (!userId) {
        response.status(401).send(new ErrorDTO('A valid logged in user token is required.', 401));
        return;
    }

    if (!request?.body?.dateIdeas) {
        response.status(400).send(new ErrorDTO('Invalid request. Ensure you have provided a valid array of date ideas.', 400));
        return;
    }

    const dateReq = new DateRequest(sanitize(request.body.dateIdeas), request.body.isPublic);
    let chosenIdea: string;

    // If duplicate, return dupe
    const dupeIndex = firstDupeIndex(dateReq.dateIdeas);

    // Remove all dupes
    dateReq.dateIdeas = [...new Set(dateReq.dateIdeas)];

    // Else return random
    if (dupeIndex === -1) {
        const randomIndex = getRandomInt(dateReq.dateIdeas.length)
        chosenIdea = dateReq.dateIdeas[randomIndex];
        dateReq.dateIdeas.splice(randomIndex, 1);
    } else {
        chosenIdea = dateReq.dateIdeas[dupeIndex];
        dateReq.dateIdeas.splice(dupeIndex, 1);
    }

    // Store in DB
    // TODO: SUPPORT PRIVATE MODE
    const storedDate = new StoredDate(chosenIdea, dateReq.dateIdeas, admin.firestore.Timestamp.now(), userId, dateReq.isPublic);
    try {
        const writeResult = await admin.firestore().collection(FirestoreConstants.DATES.DB_NAME).add(storedDate.toObject());
        const dateDTO = new DateDTO(chosenIdea, dateReq.dateIdeas, writeResult.path);
        functions.logger.info(`Dates successfully queried: ${dateDTO.chosenIdea}`);

        response.send(JSON.stringify(dateDTO));
    } catch (e) {
        functions.logger.error(e);
        response.status(500).send(new ErrorDTO('Unable to save to DB', 500));
        return;
    }
}

const sanitize = (list: string[]) => list.map((item) =>
    item.toLowerCase().trim()
);

const firstDupeIndex = (list: string[]) => list.findIndex(
    (item: string, index: number) => list.lastIndexOf(item) !== index
);

const getRandomInt = (max: number) => Math.floor(Math.random() * Math.floor(max));