import * as admin from 'firebase-admin';

export class StoredDate {
    public chosenIdea: string;
    public otherIdeas: string[];
    public date: admin.firestore.Timestamp;
    constructor(chosenIdea: string, otherIdeas: string[], date: admin.firestore.Timestamp) {
        this.chosenIdea = chosenIdea;
        this.otherIdeas = otherIdeas;
        this.date = date;
    }

    public toObject(): { [key: string]: unknown } {
        return {
            'chosenIdea': this.chosenIdea,
            'otherIdeas': this.otherIdeas,
            'date': this.date,
        };
    }
}