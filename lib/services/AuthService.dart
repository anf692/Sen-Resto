import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio _dio = Dio();
  final String baseUrl = 'http://localhost:8000/api';

  AuthService() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token');

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
        onError: (DioException e, handler) {
          // Tu peux gérer ici le rafraîchissement du token si besoin
          return handler.next(e);
        },
      ),
    );
  }

  
Future<Map<String, dynamic>> login(String email, String password) async {
  try {
    // print('Tentative de connexion avec: email=$email, password=$password'); // Debug
    Response response = await _dio.post(
      '$baseUrl/login',
      data: {'email': email, 'password': password},
    );
    // print('Réponse du serveur: ${response.data}'); // Debug
    return response.data;
  } on DioException catch (e) {
    // print('Erreur détaillée: ${e.response?.data}'); 
    throw Exception(e.response?.data['error'] ?? 'Échec de la connexion');
  }
}

  Future<Map<String, dynamic>> register(String username, String email, String password) async {
    try {
      Response response = await _dio.post(
        '$baseUrl/register',
        data: {'username': username, 'email': email, 'password': password},
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to register');
    }
  }
}
