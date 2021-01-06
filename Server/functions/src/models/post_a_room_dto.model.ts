export default class PostARoomDTO {
    public roomId: string;
    public chosenIdeas: string[];

    constructor(roomId: string, chosenIdeas: string[]) {
        this.roomId = roomId;
        this.chosenIdeas = chosenIdeas;
    }
}