import * as admin from 'firebase-admin';

export class StoredDate {
    public chosenIdea: string;
    public date: admin.firestore.Timestamp;
    public otherIdeas: string[];
    public owner: string;
    public isPublic : boolean;

    constructor(chosenIdea: string, otherIdeas: string[], date: admin.firestore.Timestamp, owner: string, isPublic: boolean) {
        this.chosenIdea = chosenIdea;
        this.otherIdeas = otherIdeas;
        this.date = date;
        this.owner = owner;
        this.isPublic = isPublic;
    }

    public toObject(): { [key: string]: unknown } {
        return {
            'chosenIdea': this.chosenIdea,
            'date': this.date,
            'otherIdeas': this.otherIdeas,
            'owner': this.owner,
            'isPublic': this.isPublic,
        };
    }
}