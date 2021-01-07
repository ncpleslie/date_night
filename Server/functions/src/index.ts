import * as functions from 'firebase-functions';
import Admin from './app/admin';
import { dates } from './app/dates';
import { randomIdea } from './app/random_idea';
import { datesAround } from './app/dates_around';
import { room } from './app/room';

Admin.firestore;
// TODO: Rate limit
export const dates_around = functions.https.onRequest(datesAround);
export const date = functions.https.onRequest(dates);
export const random = functions.https.onRequest(randomIdea);
export const get_a_room = functions.https.onRequest(room);