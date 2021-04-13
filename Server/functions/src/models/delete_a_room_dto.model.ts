export default class DeleteARoomDTO {
    public roomId: string;
    public response: string;

    constructor(roomId: string, response: string) {
        this.roomId = roomId;
        this.response = response;
    }
}