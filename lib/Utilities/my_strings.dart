// Validation patterns
const String usernamePattern = r'^[a-zA-Z\u0600-\u06FF ]+$';

const String phonePattern = r'^\+?[0-9]{10,12}$'; // International phone number
const String emailPattern = r'^[^@]+@[^@]+\.[^@]+$'; // Basic email pattern
const String passwordPattern =
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$'; // Minimum 8 characters, at least one letter and one number

String arabic = 'Arabic';
String english = 'English';
const String KUid = "uid";


String ara = 'ar';
String ene = 'en';
const String usersCollectionKey = "users";
const String favoritesCollectionKey = "favorites";
const String savedSearchesCollectionKey = "saved_searches";
const String reviewsCollectionKey = "reviews";

/// adds collection types
const String usersAddsCollectionKey = "UsersAdds";
const String commercialsAddsCollectionKey = "CommercialsAdds";










const String fcmBaseUrl = "https://fcm.googleapis.com/fcm/send";
const String policyUrl = "";


