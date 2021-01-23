import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp(functions.config().firebase);
const _firestore = admin.firestore();
const _auth = admin.auth();

export default class Admin {
    public static readonly firestore = _firestore;
    public static readonly auth = _auth;
}

export const authorizeUser = async (request: functions.Request) => {
    if (!request?.headers?.authorization) {
        return false;
    }
    
    try {
        await Admin.auth.verifyIdToken(request?.headers?.authorization?.replace('Bearer ', ''))
        return true;
    } catch (e) {
        functions.logger.error(e);
        return false;
    }
}