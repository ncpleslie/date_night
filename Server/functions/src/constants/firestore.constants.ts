export class FirestoreConstants {
    public static readonly DATES = {
        DB_NAME: 'dates',
        ORDER_BY: 'date',
        ORDER: "desc" as const,
        LIMIT: 6,
    }

    public static readonly RANDOM_IDEAS = {
        DB_NAME: 'random_ideas',
        LIMIT: 1,
    }

    public static readonly RESULT_IMAGE = {
        DB_NAME: 'result_images',
        LIMIT: 1,
    }

    public static readonly ROOM = {
        DB_NAME: 'get_a_room',
        LIMIT: 1,
    }
}