import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const _firstNameKey = 'firstName';
  static const _lastNameKey = 'lastName';
  static const _emailKey = 'email';
  static const _jobTitleKey = 'jobTitle';
  static const _addressKey = 'address';
  static const _genderKey = 'gender';

  static Future<void> saveUserData({
    required String firstName,
    required String lastName,
    required String email,
    required String jobTitle,
    required String address,
    required String gender,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('firstName', firstName);
    await prefs.setString('lastName', lastName);
    await prefs.setString('email', email);
    await prefs.setString('jobTitle', jobTitle);
    await prefs.setString('address', address);
    await prefs.setString('gender', gender);
  }

  static Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'firstName': prefs.getString('firstName') ?? '',
      'lastName': prefs.getString('lastName') ?? '',
      'email': prefs.getString('email') ?? '',
      'jobTitle': prefs.getString('jobTitle') ?? '',
      'address': prefs.getString('address') ?? '',
      'gender': prefs.getString('gender') ?? '',
    };
  }

  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_firstNameKey);
    await prefs.remove(_lastNameKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_jobTitleKey);
    await prefs.remove(_addressKey);
    await prefs.remove(_genderKey);
  }
}
