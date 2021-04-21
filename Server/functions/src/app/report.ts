import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { FirestoreConstants } from '../constants/firestore.constants';
import { HTTPMethod } from '../enums/http_method.enum';
import ErrorDTO from '../models/error_dto.model';
import Admin from './admin';

const firestore = Admin.firestore;

export const reportARoom = async (request: functions.Request, response: functions.Response) => {

    if (request.method !== HTTPMethod.POST) {
        response.status(405).send(new ErrorDTO('Must be a POST.', 405));
        return;
    }

    const userId = await Admin.isAuthorizedUser(request)
    if (!userId) {
        response.status(401).send(new ErrorDTO('A valid logged in user token is required.', 401));
        return;
    }

    if (await Admin.isRateLimited(userId)) {
        response.status(429).send(new ErrorDTO('Too many reports. Slow down, buddy.', 429));
        return;
    }

    const dateAroundId: string = request?.body?.dateAroundId;
    if (!dateAroundId) {
        response.status(400).send(new ErrorDTO('Date Around ID is missing.', 400));
        return;
    }

    const dateRef = firestore().collection(FirestoreConstants.DATES.DB_NAME).doc(dateAroundId);
    let dateSnapshot: FirebaseFirestore.DocumentSnapshot<FirebaseFirestore.DocumentData>;

    try {
        dateSnapshot = await dateRef.get();
        if (!dateSnapshot.exists) {
            response.status(400).send(new ErrorDTO('Bad request. Unable to locate date.', 400));
            return;
        }

        await firestore().collection(FirestoreConstants.REPORT.DB_NAME).doc().set({reporter: userId, offence: dateSnapshot.data(), time: admin.firestore.Timestamp.now() });
        response.status(200).send();

    } catch (error) {
        response.status(500).send(new ErrorDTO('Something went wrong.', 500));
        return;
    }
};