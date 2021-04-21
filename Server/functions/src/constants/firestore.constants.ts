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
    
    public static readonly REPORT = {
        DB_NAME: 'report',
        LIMIT: 1,
    }

    public static readonly ROOM = {
        DB_NAME: 'get_a_room',
        LIMIT: 1,
    }
}