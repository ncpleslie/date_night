import { DateAround } from "./date_around.model";

export class DatesAroundDTO {
    public date: number;
    public datesAround: DateAround[]

    constructor(datesAround: DateAround[], date = Date.now()) {
        this.date = date;
        this.datesAround = datesAround;
    }
}
