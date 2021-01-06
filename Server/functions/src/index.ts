import * as functions from 'firebase-functions';
import Admin from './admin';
import { dates } from './dates';
import { randomIdea } from './random_idea';
import { datesAround } from './dates_around';
import { room } from './room';

Admin.firestore;
// TODO: Rate limit
export const dates_around = functions.https.onRequest(datesAround);
export const date = functions.https.onRequest(dates);
export const random = functions.https.onRequest(randomIdea);
export const get_a_room = functions.https.onRequest(room);