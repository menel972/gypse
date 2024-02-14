import 'package:shared_preferences/shared_preferences.dart';

/// A service class for accessing SharedPreferences.
class SharedPreferencesService {
  factory SharedPreferencesService() {
    return _instance;
  }

  SharedPreferencesService._internal();
  static final SharedPreferencesService _instance =
      SharedPreferencesService._internal();

  late SharedPreferences _sharedPreferences;

  /// Initializes the instance of SharedPreferences.
  Future<SharedPreferences> init() async {
    return _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Returns the instance of SharedPreferences.
  SharedPreferences get sharedPreferences => _sharedPreferences;
}
