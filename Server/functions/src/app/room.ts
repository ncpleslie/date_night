import * as functions from 'firebase-functions';
import { rword } from 'rword';
import * as admin from 'firebase-admin';
import Admin from './admin';
import { FirestoreConstants } from '../constants/firestore.constants';
import GetARoomDTO from '../models/get_a_room_dto.model';
import PostARoomDTO from '../models/post_a_room_dto.model'
import { HTTPMethod } from '../enums/http_method.enum';
const firestore = Admin.firestore;

/**
 * Get or Post to a room.
 * @param request 
 * @param response 
 */
// TODO: Introduce friendly crypto-safe words for document ID
export const room = async (request: functions.Request, response: functions.Response) => {
    if (request.method === HTTPMethod.GET) {
        await getARoom(request, response);
        return;
    }

    if (request.method === HTTPMethod.POST) {
        await postARoom(request, response);
        return;
    }

    response.status(404);
}

const getARoom = async (request: functions.Request, response: functions.Response) => {
    const deviceId = request.query.deviceId;
    if (!deviceId) {
        response.status(400).send('Bad request. Please include a deviceId.');
        return;
    }

    try {
        const roomId = rword.generate();
        await firestore.collection(FirestoreConstants.ROOM.DB_NAME).doc(roomId as string).set({ chosenIdeas: [], deviceId: deviceId });
        response.send(new GetARoomDTO(roomId as string));
    } catch (error) {
        response.status(500).send('Unable to create room');
        return;
    }
}

const postARoom = async (request: functions.Request, response: functions.Response) => {
    const roomId: string = request.body.roomId;
    const dateIdeas: string[] = request.body.dateIdeas;
    if (roomId && dateIdeas) {

        const roomRef = firestore.collection(FirestoreConstants.ROOM.DB_NAME).doc(roomId);
        let roomSnapshot: FirebaseFirestore.DocumentSnapshot<FirebaseFirestore.DocumentData>;

        try {
            roomSnapshot = await roomRef.get();
            if (!roomSnapshot.exists) {
                throw Error('Document not found');
            }

        } catch (error) {
            response.status(400).send('Bad request. Unable to locate room.');
            return;
        }

        try {
            const roomData = roomSnapshot.data();
            const currentDates = roomData?.['chosenIdeas'];
            const newDateIdeas = [...currentDates, ...dateIdeas]
            await roomRef.update({ chosenIdeas: newDateIdeas });

            // Send FCM back to device to notify them if the ideas 
            // array already had stuff in it
            if (newDateIdeas.length > dateIdeas.length) {
                await sendFCM(roomData?.['deviceId'], roomId);
            }

            response.send(new PostARoomDTO(roomId, newDateIdeas));
            return;
        } catch (error) {
            response.status(500).send('Error updating room.');
            return;
        }
    }
    response.status(400).send('Bad request. Please provide a roomId and dateIdeas array.');
}

const sendFCM = async (deviceId: string, roomId: string) => {
    const message = {
        data: { roomId: roomId, type: '0' },
        token: deviceId,
    };

    try {
        await admin.messaging().send(message);
    } catch (e) {
        throw new Error('Unable to send FCM back');
    }
}


