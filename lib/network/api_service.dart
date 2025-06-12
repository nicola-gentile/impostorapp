import 'package:http/http.dart' as http;
import 'package:impostorapp/network/service.dart';
import 'dart:convert';

class ApiService extends Service{

  Future<http.Response> createRoom(String ownerName) async {
    final url = Uri.parse('${Service.baseUrl}/room');
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'owner_name': ownerName}),
    );
  }

  Future<http.Response> createUser(String userName, String roomCode) async {
    final url = Uri.parse('${Service.baseUrl}/user');
    print(url);
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_name': userName,
        'room_code': roomCode,
      }),
    );
  }

  Future<http.Response> start(int ownerId) async {
    final url = Uri.parse('${Service.baseUrl}/start');
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'owner_id': ownerId}),
    );
  }

  Future<http.Response> end(int ownerId) async {
    final url = Uri.parse('${Service.baseUrl}/end');
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'owner_id': ownerId}),
    );
  }

  Future<http.Response> close(int ownerId) async {
    final url = Uri.parse('${Service.baseUrl}/close');
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'owner_id': ownerId}),
    );
  }

}