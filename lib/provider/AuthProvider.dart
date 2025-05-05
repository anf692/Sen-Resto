import 'package:flutter/material.dart';
import 'package:sen_restau/services/AuthService.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  String? _token;
  String? _refreshToken;
  dynamic _user;

  dynamic get user => _user;

  String? get token => _token;
  String? get refreshToken => _refreshToken;

  AuthProvider() {
    _loadTokens();
   // logout();
  }

  Future<void> _loadTokens() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    _refreshToken = prefs.getString('refreshToken');
    notifyListeners();
  }


 Future<void> login(String email, String password) async {
  try {
    final response = await _authService.login(email, password);
    if (response['token'] != null && 
        response['token']['access'] != null && 
        response['token']['refresh'] != null) {
      _token = response['token']['access'];
      _refreshToken = response['token']['refresh'];
      
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token!);
      await prefs.setString('refreshToken', _refreshToken!);
      
      notifyListeners();
    } else {
      throw Exception('Réponse API invalide: Tokens manquants');
    }
  } catch (e) {
    // print('Erreur de connexion: $e');
    rethrow; // Important pour que la page puisse afficher l'erreur
  }
}

  Future<void> register(String username, String email, String password) async {
    final response = await _authService.register(username, email, password);
    _token = response['token']['access'];
    _refreshToken = response['token']['refresh'];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', _token!);
    await prefs.setString('refreshToken', _refreshToken!);
    notifyListeners();
  }

  Future<void> logout() async {
    _token = null;
    _refreshToken = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('refreshToken');
    notifyListeners();
  }

}
