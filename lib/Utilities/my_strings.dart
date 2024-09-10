// Validation patterns
const String usernamePattern = r'^[a-zA-Z\u0600-\u06FF ]+$';

const String phonePattern = r'^\+?[0-9]{10,12}$'; // International phone number
const String emailPattern = r'^[^@]+@[^@]+\.[^@]+$'; // Basic email pattern
const String passwordPattern =
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$'; // Minimum 8 characters, at least one letter and one number

String arabic = 'Arabic';
String english = 'English';
const String KUid = "uid";
const String KRole = "role";

String ara = 'ar';
String ene = 'en';
const String usersCollectionKey = "users";

const String fcmBaseUrl = "https://fcm.googleapis.com/fcm/send";
const String policyUrl = "";


///---------------------------------------------------------------------------  topics to follow in messaging

// const String allDevicesTopic = "/topics/allDevices";
// const String allHealthInstitutionsTopic = "/topics/allHealthInstitutions";
// const String allUsersTopic = "/topics/allUsers";

