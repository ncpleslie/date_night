import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp(functions.config().firebase);
const _firestore = admin.firestore;
const _auth = admin.auth();

export default class Admin {
    public static readonly firestore = _firestore;
    public static readonly auth = _auth;

    public static async isAuthorizedUser(request: functions.Request): Promise<string | null> {
        if (!request?.headers?.authorization) {
            return null;
        }

        try {
            const response = await Admin.auth.verifyIdToken(request?.headers?.authorization?.replace('Bearer ', ''))
            return response?.uid;
        } catch (e) {
            functions.logger.error(e);
            return null;
        }
    }
}