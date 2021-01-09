export default class DateDTO {
    public chosenIdea: string;
    public otherIdeas: string[];
    public path: string;
    public imageUrl: string;
    constructor(chosenIdea: string, otherIdeas: string[], path: string, imageUrl: string) {
        this.chosenIdea = chosenIdea;
        this.otherIdeas = otherIdeas;
        this.path = path;
        this.imageUrl = imageUrl;
    }
}