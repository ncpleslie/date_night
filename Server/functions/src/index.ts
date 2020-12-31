import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import DateRequest from './models/date_request.model';
import DateDTO from './models/date_dto.model';
import RandomDateDTO from './models/random_date_dto.model';
import { StoredDate } from './models/stored_date.model';
import { FirestoreConstants } from './constants/firestore.constants';
import { DatesAroundDTO } from './models/dates_around_dto.model';

admin.initializeApp(functions.config().firebase);
const firestore = admin.firestore();

/**
 * Dates of other user.
 */
export const dates_around = functions.https.onRequest(async (request: functions.Request, response: functions.Response) => {
    functions.logger.info('Dates Around queried');
    if (!request.query || !request.query.lastId) {
        const initialSnapshot = await getDatesAroundQuery.get();
        response.send(initialSnapshot.docs.map(doc =>
            new DatesAroundDTO(doc.data().chosenIdea, doc.data().otherIdeas, doc.data().date.toDate(), doc.id)
        ));
        return;
    }
    const queryCursor = firestore.collection(FirestoreConstants.DB_NAME).doc(request.query.lastId as string);
    const paginatedSnapshot = await getDatesAroundQuery.startAfter(queryCursor).get();
    paginatedSnapshot.docs.forEach((doc) => {
        functions.logger.info(doc);
    })
    response.send(paginatedSnapshot.docs.map(doc =>
        new DatesAroundDTO(doc.data().chosenIdea, doc.data().otherIdeas, doc.data().date.toDate(), doc.id)
    ));
});

const getDatesAroundQuery = firestore.collection(FirestoreConstants.DB_NAME).orderBy(FirestoreConstants.ORDER_BY, FirestoreConstants.ORDER).limit(FirestoreConstants.LIMIT);

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
    const writeResult = await admin.firestore().collection(FirestoreConstants.DB_NAME).add(storedDate.toObject());
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