import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import DateRequest from './models/date_request.model';
import DateDTO from './models/date_dto.model';
import { StoredDate } from './models/stored_date.model';
import { FirestoreConstants } from './constants/firestore.constants';

/**
 * Winning date decider.
 * @param request 
 * @param response 
 */
// TODO: Implement fuzzy matching
export const dates = async (request: functions.Request, response: functions.Response) => {
    if (!request.body || !request.body.dateIdeas) {
        response.status(400).send('Invalid request. Ensure you have provided a valid array of date ideas.');
        return;
    }

    const dateReq = new DateRequest(sanitize(request.body.dateIdeas));
    let chosenIdea: string;

    // If dupe, return dupe
    const dupeIndex = firstDupeIndex(dateReq.dateIdeas);

    // Remove all dupes
    dateReq.dateIdeas = [...new Set(dateReq.dateIdeas)];

    // TODO: Filter out bad words

    // Else return random
    if (dupeIndex === -1) {
        const randomIndex = getRandomInt(dateReq.dateIdeas.length)
        chosenIdea = dateReq.dateIdeas[randomIndex];
        dateReq.dateIdeas.splice(randomIndex, 1);
    } else {
        chosenIdea = dateReq.dateIdeas[dupeIndex];
        dateReq.dateIdeas.splice(dupeIndex, 1);
    }

    // Get image
    const imageDB = admin.firestore().collection(FirestoreConstants.RESULT_IMAGE.DB_NAME);
    const randomImageSnapshot = await getRandomImage(imageDB);
    const randomImageUrl = randomImageSnapshot.docs[0].data()['url'];

    // Store in DB
    const storedDate = new StoredDate(chosenIdea, dateReq.dateIdeas, admin.firestore.Timestamp.now());
    try {
        const writeResult = await admin.firestore().collection(FirestoreConstants.DATES.DB_NAME).add(storedDate.toObject());
        const dateDTO = new DateDTO(chosenIdea, dateReq.dateIdeas, writeResult.path, randomImageUrl);
        functions.logger.info(`Dates successfully queried: ${dateDTO.chosenIdea}`);
        response.send(JSON.stringify(dateDTO));
    } catch (e) {
        functions.logger.error(e);
        response.status(500).send('Unable to save to DB');
    }
}

const sanitize = (list: string[]) => list.map((item) => item.toLowerCase().trim());

const firstDupeIndex = (list: string[]) => list.findIndex(
    (item: string, index: number) => list.lastIndexOf(item) !== index
);

const getRandomInt = (max: number) => Math.floor(Math.random() * Math.floor(max));

async function getRandomImage(db: FirebaseFirestore.CollectionReference<FirebaseFirestore.DocumentData>, input = '>=' as FirebaseFirestore.WhereFilterOp): Promise<FirebaseFirestore.QuerySnapshot<FirebaseFirestore.DocumentData>> {
    const key = db.doc().id;
    const snapshot = await db.where(admin.firestore.FieldPath.documentId(), input, key).limit(FirestoreConstants.RESULT_IMAGE.LIMIT).get();
    if (snapshot.size > 0) return snapshot;
    return getRandomImage(db, '<');
}