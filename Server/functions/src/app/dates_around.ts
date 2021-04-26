import * as functions from 'firebase-functions';
import Admin from './admin';
import { FirestoreConstants } from '../constants/firestore.constants';
import { DatesAroundDTO } from '../models/dates_around_dto.model';
import { DateAround } from '../models/date_around.model';
import ErrorDTO from '../models/error_dto.model';
import cors from 'cors';

const firestore = Admin.firestore;
/**
 * Dates of other user.
 * @param request 
 * @param response 
 */
export const datesAround = async (request: functions.Request, response: functions.Response) => {
    functions.logger.info('Dates Around queried');
    
    const corsHandler = cors({ origin: true });
    corsHandler(request, response, async () => {

        const userId = await Admin.isAuthorizedUser(request);
        if (!userId) {
            response.status(401).send(new ErrorDTO('A valid logged in user token is required.', 401));
            return;
        }

        if (await Admin.isRateLimited(userId)) {
            response.status(429).send(new ErrorDTO('Too many requests. Slow down, buddy.', 429));
            return;
        }

        let datesSnapshot: FirebaseFirestore.QuerySnapshot<FirebaseFirestore.DocumentData>;

        try {
            if (!request?.query?.lastId) {
                datesSnapshot = await getDatesAroundQuery.get();
            } else {
                const queryCursor = await firestore().collection(FirestoreConstants.DATES.DB_NAME).doc(request.query.lastId as string).get();
                datesSnapshot = await getDatesAroundQuery.startAfter(queryCursor).get();
            }

            const datesAroundArray = dateAround(datesSnapshot);
            response.send(new DatesAroundDTO(datesAroundArray));

        } catch (e) {
            functions.logger.error(e);
            response.status(500).send(new ErrorDTO('Internal Server Error. Something went wrong on our end but it could\'ve been something in your request.', 500));
        }
    });
}

const dateAround = (payload: FirebaseFirestore.QuerySnapshot<FirebaseFirestore.DocumentData>) =>
    payload.docs.map(doc => new DateAround(doc.data().chosenIdea, doc.data().otherIdeas, doc.data().date.toDate(), doc.id));

const getDatesAroundQuery = firestore()
    .collection(FirestoreConstants.DATES.DB_NAME)
    .orderBy(FirestoreConstants.DATES.ORDER_BY, FirestoreConstants.DATES.ORDER)
    .where(FirestoreConstants.DATES.FILTER.FIRST, FirestoreConstants.DATES.FILTER.OPERATOR as FirebaseFirestore.WhereFilterOp, FirestoreConstants.DATES.FILTER.CONDITION)
    .limit(FirestoreConstants.DATES.LIMIT);
