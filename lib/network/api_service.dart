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
    final url = Uri.parse('${Service.baseUrl}/start');
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'owner_id': ownerId.toString()}),
    );
  }

  Future<http.Response> end(BigInt ownerId) async {
    final url = Uri.parse('${Service.baseUrl}/end');
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'owner_id': ownerId.toString()}),
    );
  }

  Future<http.Response> close(BigInt ownerId) async {
    final url = Uri.parse('${Service.baseUrl}/close');
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'owner_id': ownerId.toString()}),
    );
  }

}