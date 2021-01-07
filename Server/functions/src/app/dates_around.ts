import * as functions from 'firebase-functions';
import Admin from './admin';
import { FirestoreConstants } from '../constants/firestore.constants';
import { DatesAroundDTO } from '../models/dates_around_dto.model';
import { DateAround } from '../models/date_around.model';
const firestore = Admin.firestore;
/**
 * Dates of other user.
 * @param request 
 * @param response 
 */
export const datesAround = async (request: functions.Request, response: functions.Response) => {
    functions.logger.info('Dates Around queried');
    let snapshot: FirebaseFirestore.QuerySnapshot<FirebaseFirestore.DocumentData>;
    try {
        if (!request.query || !request.query.lastId) {
            snapshot = await getDatesAroundQuery.get();
        } else {
            const queryCursor = await firestore.collection(FirestoreConstants.DATES.DB_NAME).doc(request.query.lastId as string).get();
            snapshot = await getDatesAroundQuery.startAfter(queryCursor).get();
        }

        const datesAroundArray = dateAround(snapshot);
        response.send(new DatesAroundDTO(datesAroundArray));

    } catch (e) {
        functions.logger.error(e);
        response.status(500).send('Internal Server Error. Something went wrong on our end but it could\'ve been something in your request.');
    }
}

const dateAround = (payload: FirebaseFirestore.QuerySnapshot<FirebaseFirestore.DocumentData>) =>
    payload.docs.map(doc =>
        new DateAround(doc.data().chosenIdea, doc.data().otherIdeas, doc.data().date.toDate(), doc.id)
    );

const getDatesAroundQuery = firestore.collection(FirestoreConstants.DATES.DB_NAME).orderBy(FirestoreConstants.DATES.ORDER_BY, FirestoreConstants.DATES.ORDER).limit(FirestoreConstants.DATES.LIMIT);
