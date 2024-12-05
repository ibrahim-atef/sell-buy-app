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
const String viewsCollectionKey = "views";
const String recentlyViewedCollectionKey = "recently_viewed";

/// adds collection types
const String usersAddsCollectionKey = "UsersAdds";
const String commercialsAddsCollectionKey = "CommercialsAdds";
const String categoriesCollectionKey = "categories";
const String subcategoriesCollectionKey = "subcategories";










const String fcmBaseUrl = "https://fcm.googleapis.com/fcm/send";
const String policyUrl = "https://sites.google.com/view/sellbuyapp/%D8%A7%D9%84%D8%B5%D9%81%D8%AD%D8%A9-%D8%A7%D9%84%D8%B1%D8%A6%D9%8A%D8%B3%D9%8A%D8%A9";


