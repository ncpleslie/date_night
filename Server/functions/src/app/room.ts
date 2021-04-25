import * as functions from 'firebase-functions';
import { rword } from 'rword';
import Admin from './admin';
import { FirestoreConstants } from '../constants/firestore.constants';
import GetARoomDTO from '../models/get_a_room_dto.model';
import PostARoomDTO from '../models/post_a_room_dto.model'
import { HTTPMethod } from '../enums/http_method.enum';
import ErrorDTO from '../models/error_dto.model';
import DeleteARoomDTO from '../models/delete_a_room_dto.model';

const firestore = Admin.firestore;

/**
 * Get or Post to a room.
 * @param request 
 * @param response 
 */
// TODO: Introduce friendly crypto-safe words for document ID
export const room = async (request: functions.Request, response: functions.Response) => {
    const userId = await Admin.isAuthorizedUser(request)
    if (!userId) {
        response.status(401).send(new ErrorDTO('A valid logged in user token is required.', 401));
        return;
    }

    if (await Admin.isRateLimited(userId)) {
        response.status(429).send(new ErrorDTO('Too many requests. Slow down, buddy.', 429));
        return;
    }

    if (request.method === HTTPMethod.GET) {
        await getARoom(request, response, userId);
        return;
    }

    if (request.method === HTTPMethod.POST) {
        await postARoom(request, response);
        return;
    }

    if (request.method === HTTPMethod.DELETE) {
        await deleteARoom(request, response, userId);
        return;
    }

    response.status(404);
}

const getARoom = async (request: functions.Request, response: functions.Response, userId: string) => {
    try {
        const roomId = (rword.generate(1, { length: '3-4' }) as string).toLowerCase();
        const currentTime = firestore.FieldValue.serverTimestamp();
        await firestore().collection(FirestoreConstants.ROOM.DB_NAME).doc(roomId).set({ chosenIdeas: [], owner: userId, created: currentTime });
        response.send(new GetARoomDTO(roomId));
        return;
    } catch (error) {
        functions.logger.error(error);

        response.status(500).send('Unable to create room');

        return;
    }
}

const postARoom = async (request: functions.Request, response: functions.Response) => {
    functions.logger.info('Post a room was called');
    const roomId: string = request?.body?.roomId;
    const dateIdeas: string[] = request?.body?.dateIdeas;

    if (roomId && dateIdeas) {
        const roomRef = firestore().collection(FirestoreConstants.ROOM.DB_NAME).doc(roomId.toLowerCase());
        let roomSnapshot: FirebaseFirestore.DocumentSnapshot<FirebaseFirestore.DocumentData>;

        try {
            roomSnapshot = await roomRef.get();
            if (!roomSnapshot.exists) {
                response.status(400).send(new ErrorDTO('Bad request. Unable to locate room.', 400));
                return;
            }

        } catch (error) {
            response.status(500).send(new ErrorDTO('Something went wrong.', 500));
            return;
        }

        try {
            const roomData = roomSnapshot.data();
            const currentDates = roomData?.['chosenIdeas'];
            const newDateIdeas = [...currentDates, ...dateIdeas]
            await roomRef.update({ chosenIdeas: newDateIdeas });

            response.send(new PostARoomDTO(roomId, newDateIdeas));

            return;
        } catch (error) {
            response.status(500).send(new ErrorDTO('Error updating room.', 500));
            return;
        }
    }

    response.status(400).send(new ErrorDTO('Bad request. Please provide a roomId and dateIdeas array.', 400));
}

const deleteARoom = async (request: functions.Request, response: functions.Response, uid: string) => {

    // TODO: Waiting x seconds and then delete room
    const roomId = request?.query?.roomId;

    if (roomId) {

        try {
            const snapshot = await firestore().collection(FirestoreConstants.ROOM.DB_NAME).doc(roomId as string).get();

            if (snapshot?.data()?.owner && snapshot?.data()?.owner === uid) {
                const roomRef = firestore().collection(FirestoreConstants.ROOM.DB_NAME).doc(roomId as string)

                // TODO: Determine if the function should wait a short period before deleting.

                await roomRef.delete();
            }

            response.send(new DeleteARoomDTO(roomId as string, 'Room scheduled for deletion.'));

            return;
        } catch (e) {
            functions.logger.error(e);
            response.status(500).send(new ErrorDTO('Internal Server Error. Unable to delete room', 500));
        }
    }

    response.status(400).send(new ErrorDTO('Bad request. Please provide a roomId.', 400));
}