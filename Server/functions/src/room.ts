import * as functions from 'firebase-functions';
import { rword } from 'rword';
import Admin from './admin';
import { FirestoreConstants } from './constants/firestore.constants';
import GetARoomDTO from './models/get_a_room_dto.model';
import PostARoomDTO from './models/post_a_room_dto.model'
import { HTTPMethod } from './enums/http_method.enum';
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
    try {
        const roomId = rword.generate();
        await firestore.collection(FirestoreConstants.ROOM.DB_NAME).doc(roomId as string).set({ chosenIdeas: [] });
        response.send(new GetARoomDTO(roomId as string));
    } catch (error) {
        response.status(500).send('Unable to create room');
        return;
    }
}

const postARoom = async (request: functions.Request, response: functions.Response) => {
    const roomId = request.body.roomId;
    const dateIdeas = request.body.dateIdeas;
    if (roomId && dateIdeas) {

        const roomRef = firestore.collection(FirestoreConstants.ROOM.DB_NAME).doc(roomId);
        let roomSnapshot: FirebaseFirestore.DocumentSnapshot<FirebaseFirestore.DocumentData>;

        try {
            roomSnapshot = await roomRef.get();
            if (!roomSnapshot.exists) {
                throw Error('Document not found');
            }

        } catch (error) {
            response.status(404).send('Unable to locate room.');
            return;
        }

        try {
            const currentDates = roomSnapshot.data()?.['chosenIdeas'];
            const newDateIdeas = [...currentDates, ...dateIdeas]
            await roomRef.update({ chosenIdeas: newDateIdeas });
            response.send(new PostARoomDTO(roomId, newDateIdeas));
            return;
        } catch (error) {
            response.status(500).send('Error updating room.');
            return;
        }
    }
    response.status(404).send('Please provide a roomId and dateIdeas array.');
}



