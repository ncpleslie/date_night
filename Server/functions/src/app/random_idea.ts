import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import Admin from './admin';
import RandomDateDTO from '../models/random_date_dto.model';
import { FirestoreConstants } from '../constants/firestore.constants';
import ErrorDTO from '../models/error_dto.model';
const firestore = Admin.firestore;
import cors from 'cors';

/**
 * Random date ideas.
 * @param request 
 * @param response 
 */
export const randomIdea = async (request: functions.Request, response: functions.Response) => {

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

        const db = firestore().collection(FirestoreConstants.RANDOM_IDEAS.DB_NAME);
        const snapshot = await getRandomIdea(db);
        const randomDateDTO = snapshot.docs.map(doc => new RandomDateDTO(doc.data().idea))[0];
        functions.logger.info(`Random Idea successfully queried: ${randomDateDTO.idea}`);
        response.send(randomDateDTO);
    });
}

async function getRandomIdea(db: FirebaseFirestore.CollectionReference<FirebaseFirestore.DocumentData>, input = '>=' as FirebaseFirestore.WhereFilterOp): Promise<FirebaseFirestore.QuerySnapshot<FirebaseFirestore.DocumentData>> {
    const key = db.doc().id;
    const snapshot = await db.where(admin.firestore.FieldPath.documentId(), input, key).limit(FirestoreConstants.RANDOM_IDEAS.LIMIT).get();
    if (snapshot.size > 0) return snapshot;
    return getRandomIdea(db, '<');
}
