import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp(functions.config().firebase);
const firestore = admin.firestore();

/**
 * Dates of other user.
 */
export const dates_around = functions.https.onRequest(async (request: functions.Request, response: functions.Response) => {
    functions.logger.info('Dates Around queried');
    functions.logger.info(request);

    if (!request.body.lastDateId) {
        const snapshot = await firestore.collection('datesAround').orderBy('datePosted', 'desc').limit(10).get();
        response.send(snapshot.docs.map(doc => doc.data()));
    } else {
        const snapshot = await firestore.collection('datesAround').orderBy('datePosted', 'desc').startAfter(request.body.lastDateId).limit(10).get();
        response.send(snapshot.docs.map(doc => doc.data()));
    }
});

/**
 * Winning date decider.
 */
export const date = functions.https.onRequest(async (request: functions.Request, response: functions.Response) => {
    functions.logger.info('Dates queried');
    functions.logger.info(request);
    response.send('');
})

/**
 * Random date ideas.
 */
export const random = functions.https.onRequest(async (request: functions.Request, response: functions.Response) => {
    functions.logger.info('Dates queried');
    functions.logger.info(request);
    response.send('');
})