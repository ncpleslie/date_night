export default class DateRequest {
    public dateIdeas: string[];
    public isPublic: boolean;
    constructor(dateIdeas: string[], isPublic = true) {
        this.dateIdeas = dateIdeas;
        this.isPublic = isPublic;
    }
}