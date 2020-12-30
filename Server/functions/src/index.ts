import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import DateRequest from './models/date_request.model';
import DateDTO from './models/date_dto.model';
import RandomDateDTO from './models/random_date_dto.model';
import { StoredDate } from './models/stored_date.model';
import { Firestore } from './enums/firestore.enum';

admin.initializeApp(functions.config().firebase);
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
// TODO: Implement fuzzy matching
export const date = functions.https.onRequest(async (request: functions.Request, response: functions.Response) => {
    if (!request.body || !request.body.dateIdeas) {
        response.status(400).send('Invalid request. Ensure you have provided a valid array of date ideas.');
        return;
    }

    const dateReq = new DateRequest(sanitize(request.body.dateIdeas));
    let chosenIdea: string;

    // If dupe, return dupe
    const dupeIndex = firstDupeIndex(dateReq.dateIdeas);
    // TODO: Remove all dupes

    // Else return random
    if (dupeIndex === -1) {
        const randomIndex = getRandomInt(dateReq.dateIdeas.length)
        chosenIdea = dateReq.dateIdeas[randomIndex];
        dateReq.dateIdeas.splice(randomIndex, 1);
    } else {
        chosenIdea = dateReq.dateIdeas[dupeIndex];
        dateReq.dateIdeas.splice(dupeIndex, 1);
    }

    // Store in DB
    const storedDate = new StoredDate(chosenIdea, dateReq.dateIdeas, admin.firestore.Timestamp.now());
    const writeResult = await admin.firestore().collection(Firestore.name).add(storedDate.toObject());
    const dateDTO = new DateDTO(chosenIdea, dateReq.dateIdeas, writeResult.path);
    functions.logger.info(`Dates successfully queried: ${dateDTO}`);
    response.send(JSON.stringify(dateDTO));
});

const sanitize = (list: string[]) => list.map((item) => item.toLowerCase().trim());

const firstDupeIndex = (list: string[]) => list.findIndex(
    (item: string, index: number) => list.lastIndexOf(item) !== index
);

const getRandomInt = (max: number) => Math.floor(Math.random() * Math.floor(max));

/**
 * Random date ideas.
 */
export const random = functions.https.onRequest(async (request: functions.Request, response: functions.Response) => {
    const randomDateDTO = new RandomDateDTO('Random Idea');
    functions.logger.info(`Random Idea successfully queried: ${randomDateDTO}`);
    response.send(JSON.stringify(randomDateDTO));
})