import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {

  static const Duration apiTimeout = Duration(seconds: 30);
  static const int splashDuration = 2;
  static const String defaultLanguage = "en";
  static const  defaultPhoneNumberLength = 9;
  static const  appRole = 'customer';




static  String apiVer= "/api/$apiVersion";

static  String dummyFoodImage= "https://www.foodiesfeed.com/wp-content/uploads/2023/06/burger-with-melted-cheese.jpg";

  // ========================env constants========================

  // App Config
  static final String appName = dotenv.env['APP_NAME'] ?? 'AppName';
  static final String appId = dotenv.env['APP_ID'] ?? 'com.ichef.app';

  // API
  static final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  static final String apiVersion = dotenv.env['API_VERSION'] ?? 'v1';
  static final String authToken = dotenv.env['AUTH_TOKEN'] ?? '';


  // Google Maps
  static final String googleMapsApiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';

  // App Update
  static final String forceUpdateVersion = dotenv.env['FORCE_UPDATE_VERSION'] ?? '1.0.0';
  static final String optionalUpdateVersion = dotenv.env['OPTIONAL_UPDATE_VERSION'] ?? '1.1.0';
  static final String updateMessage = dotenv.env['UPDATE_MESSAGE'] ?? '';

  // Localization
  static final String defaultLocale = dotenv.env['DEFAULT_LOCALE'] ?? 'en';
  static final String defaultTimezone = dotenv.env['DEFAULT_TIMEZONE'] ?? 'UTC';

// Optional: Feature Toggles, Firebase, Analytics
// Add more as needed...
}
