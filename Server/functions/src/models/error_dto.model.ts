export default class ErrorDTO {
    public error: string;
    public errorCode: number;

    constructor(error: string, errorCode: number) {
        this.error = error;
        this.errorCode = errorCode;
    }
}