import * as functions from 'firebase-functions';
import Admin from './app/admin';
import { dates } from './app/dates';
import { randomIdea } from './app/random_idea';
import { datesAround } from './app/dates_around';
import { room } from './app/room';

const runtimeOpts: functions.RuntimeOptions = {
    timeoutSeconds: 30,
}

Admin.firestore;
// TODO: Rate limit
export const dates_around = functions.runWith(runtimeOpts).https.onRequest(datesAround);
export const date = functions.runWith(runtimeOpts).https.onRequest(dates);
export const random = functions.runWith(runtimeOpts).https.onRequest(randomIdea);
export const get_a_room = functions.runWith(runtimeOpts).https.onRequest(room);
