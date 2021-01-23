export default class DateDTO {
    public chosenIdea: string;
    public otherIdeas: string[];
    public path: string;
    constructor(chosenIdea: string, otherIdeas: string[], path: string) {
        this.chosenIdea = chosenIdea;
        this.otherIdeas = otherIdeas;
        this.path = path;
    }
}