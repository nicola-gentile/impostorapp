import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class ApiService {
  final String baseUrl;

  ApiService() : baseUrl = dotenv.env['API_BASE_URL'] ?? '' {
    if (baseUrl.isEmpty) {
      throw Exception('API_BASE_URL is not set in .env file');
    }
  }

  Future<http.Response> createRoom(String ownerName) async {
    final url = Uri.parse('$baseUrl/room');
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'owner_name': ownerName}),
    );
  }

  Future<http.Response> createUser(String userName, String roomCode) async {
    final url = Uri.parse('$baseUrl/user');
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_name': userName,
        'room_code': roomCode,
      }),
    );
  }

  Future<http.Response> start(BigInt ownerId) async {
    final url = Uri.parse('$baseUrl/start');
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'owner_id': ownerId.toString()}),
    );
  }

  Future<http.Response> end(BigInt ownerId) async {
    final url = Uri.parse('$baseUrl/end');
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'owner_id': ownerId.toString()}),
    );
  }

  Future<http.Response> close(BigInt ownerId) async {
    final url = Uri.parse('$baseUrl/close');
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'owner_id': ownerId.toString()}),
    );
  }




}