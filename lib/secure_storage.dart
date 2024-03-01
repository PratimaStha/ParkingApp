import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static final SharedPref _instance = SharedPref._internal();

  factory SharedPref() {
    return _instance;
  }

  SharedPref._internal();
  static SharedPreferences? _sharedPref;

  static init() async {
    _sharedPref = await SharedPreferences.getInstance();
  }

  static const _authToken = "auth_token";
  static const _id = "id";
  static const _firstTimeInApp = "first_time_in_app";
  static const _role = "role";
  static const _roles = "roles";
  static const _selectedProject = "selected_project";

  static resetCredentials() async {
    _inMemoryToken = null;
    await removeAuthToken();
    await _sharedPref?.remove(_id);
  }

  deleteCredentials() async {
    _inMemoryToken = null;
    await _sharedPref?.remove(_authToken);
    await _sharedPref?.remove(_id);
  }

  updateCredentials({String? token}) {
    _inMemoryToken = null;
    setAuthToken(token.toString());
  }

  //token
  static setAuthToken(String authToken) async =>
      await _sharedPref?.setString(_authToken, authToken);
  static String? get getSPToken => _sharedPref?.getString(_authToken);
  static removeAuthToken() async => await _sharedPref?.remove(_authToken);

  // Use a memory cache to avoid local storage access in each call
  static String? _inMemoryToken;

  static String? getToken() {
    // use in memory token if available
    if (_inMemoryToken?.isNotEmpty ?? false) return _inMemoryToken;

    // otherwise load it from local storage
    _inMemoryToken = getSPToken;

    return _inMemoryToken;
  }

  //first time in app
  static bool get firstTimeInApp =>
      _sharedPref?.getBool(_firstTimeInApp) ?? false;
  static setFirstTimeInApp() async =>
      await _sharedPref?.setBool(_firstTimeInApp, true);
  static removeFirstTime() async => await _sharedPref?.remove(_firstTimeInApp);

  //shared pref init
  static Future sharedPrefInit() async =>
      _sharedPref = await SharedPreferences.getInstance();

  static void setRole(String role) async {
    await _sharedPref?.setString(_role, role);
  }

  static String? get getRole => _sharedPref?.getString(_role);

  static void setId(String id) async {
    await _sharedPref?.setString(_id, id);
  }

  static String? get getId => _sharedPref?.getString(_id);

  static void setRoles(List<String>? roles) async {
    await _sharedPref?.setStringList(_roles, roles ?? []);
  }

  static List<String>? get getRoles => _sharedPref?.getStringList(_roles) ?? [];

  bool notLoggedIn() {
    return getSPToken == null;
  }

  static String? get getSelectedProject =>
      _sharedPref?.getString(_selectedProject);
}
