// Validation patterns
const String usernamePattern = r'^[a-zA-Z\u0600-\u06FF ]+$';
const String civilIdPattern = r'^[0-9]+$'; // Only digits
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
const String patientsCollectionKey = "patientsCollectionKey";
const String treatmentRequestsCollectionKey = "treatmentRequestsCollection";
const String healthInstitutionCollectionKey = "health_institutions";
const String fcmBaseUrl = "https://fcm.googleapis.com/fcm/send";
const String policyUrl = "https://www.termsfeed.com/live/2527adb9-67c7-4b28-b7a4-2d1c5cfcf343";


///---------------------------------------------------------------------------  topics to follow in messaging

// const String allDevicesTopic = "/topics/allDevices";
// const String allHealthInstitutionsTopic = "/topics/allHealthInstitutions";
// const String allUsersTopic = "/topics/allUsers";

/*

firebase scheme
///........................................................health_institutions
  /{institution_id}
    - name: string
    - email: string
    - address: string
    - phone: string
    - password: password
    /requests
      /{request_id}
        - patient_id: string
        - patient_name: string
        - status: string (e.g., pending, completed)
        - notes: string
        - created_at: timestamp
        - updated_at: timestamp
    /reports
      /{report_id}
        - date: date
        - number_of_treatments: int
        - details: string
    /statistics
      - total_treatments: int
      - monthly_data: array of { month: string, treatments: int }

---------------------------------------------------------------------------users
  /{user_id}
    - name: string
    - email: string
    - phone: string
    - phone: string
    - password: password
    /patients
      /{patient_id}
        - name: string
        - age: int
        - gender: string
        - health_conditions: array of strings
        - treatments: array of { treatment_id: string, status: string }

/----------------------------------------------------------------------treatments
  /{treatment_id}
    - name: string
    - description: string
    - institution_id: string
    - patient_id: string
    - status: string (e.g., requested, in_progress, completed)
    - created_at: timestamp
    - updated_at: timestamp


 */
