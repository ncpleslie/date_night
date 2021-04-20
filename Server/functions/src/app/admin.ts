import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { FirebaseFunctionsRateLimiter } from "firebase-functions-rate-limiter";

admin.initializeApp(functions.config().firebase);
const _firestore = admin.firestore;
const _auth = admin.auth();
const _database = admin.database();

export default class Admin {
    public static readonly firestore = _firestore;
    public static readonly auth = _auth;

    private static readonly _perUserlimiter = FirebaseFunctionsRateLimiter.withRealtimeDbBackend(
        {
            name: "per_user_limiter",
            maxCalls: 10,
            periodSeconds: 15,
        },
        _database,
    );

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

    public static async isRateLimited(userId: string) {
        return await Admin._perUserlimiter.isQuotaExceededOrRecordUsage(userId);
    }
}