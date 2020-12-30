import * as functions from 'firebase-functions';
// import * as admin from 'firebase-admin';
import DateRequest from './models/date_request.model';
import DateResponse from './models/date_response.model';
import RandomDateResponse from './models/random_date_response.model';

// admin.initializeApp(functions.config().firebase);
// const firestore = admin.firestore();

// /**
//  * Dates of other user.
//  */
// export const dates_around = functions.https.onRequest(async (request: functions.Request, response: functions.Response) => {
//     functions.logger.info('Dates Around queried');
//     functions.logger.info(request);

//     if (!request.body.lastDateId) {
//         const snapshot = await firestore.collection('datesAround').orderBy('datePosted', 'desc').limit(10).get();
//         response.send(snapshot.docs.map(doc => doc.data()));
//     } else {
//         const snapshot = await firestore.collection('datesAround').orderBy('datePosted', 'desc').startAfter(request.body.lastDateId).limit(10).get();
//         response.send(snapshot.docs.map(doc => doc.data()));
//     }
// });

/**
 * Winning date decider.
 */
export const date = functions.https.onRequest(async (request: functions.Request, response: functions.Response) => {
    if (!request.body || !request.body.dateIdeas) {
        response.status(400).send('Invalid request. Ensure you have provided a valid array of date ideas.');
        return;
    }
    const dateReq = new DateRequest(request.body.dateIdeas);
    functions.logger.info('Dates queried');
    functions.logger.info(dateReq);

    // Flatten the arrays
    // If dupe, return dupe
    // Else return random
    // Store in DB
    const dateResponse = new DateResponse(dateReq.dateIdeas[0]);
    response.send(JSON.stringify(dateResponse));
    return;
});

/**
 * Random date ideas.
 */
export const random = functions.https.onRequest(async (request: functions.Request, response: functions.Response) => {
    functions.logger.info('Random Idea queried');
    functions.logger.info(request);
    const randomDateResponse = new RandomDateResponse('Random Idea');
    response.send(JSON.stringify(randomDateResponse));
})