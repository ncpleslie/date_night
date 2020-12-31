export class DatesAroundDTO {
    public chosenIdea: string;
    public otherIdeas: string[];
    public date: Date;
    public id: string;

    constructor(chosenIdea: string, otherIdeas: string[], date: Date, id: string) {
        this.chosenIdea = chosenIdea;
        this.otherIdeas = otherIdeas;
        this.date = date;
        this.id = id;
    }
}