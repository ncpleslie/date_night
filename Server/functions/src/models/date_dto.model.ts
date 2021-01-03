export default class DateDTO {
    public chosenIdea: string;
    public otherIdeas: string[];
    public path: string;
    public image: string;
    constructor(chosenIdea: string, otherIdeas: string[], path: string, image: string) {
        this.chosenIdea = chosenIdea;
        this.otherIdeas = otherIdeas;
        this.path = path;
        this.image = image;
    }
}