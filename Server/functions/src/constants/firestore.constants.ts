export class FirestoreConstants {
    public static readonly DATES = {
        DB_NAME: 'dates',
        ORDER_BY: 'date',
        ORDER: "desc" as const,
        LIMIT: 15,
    }

    public static readonly RANDOM_IDEAS = {
        DB_NAME: 'random_ideas',
        LIMIT: 1,
    }

    public static readonly RESULT_IMAGE = {
        DB_NAME: 'result_images',
        LIMIT: 1,
    }
}