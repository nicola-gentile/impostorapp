import 'package:flutter/material.dart';
import 'package:flutter_http_sse/enum/request_method_type_enum.dart';
import 'package:flutter_http_sse/model/sse_response.dart';
import 'package:impostorapp/network/service.dart';
import 'package:flutter_http_sse/model/sse_request.dart';
import 'package:flutter_http_sse/client/sse_client.dart';

class SseService extends Service {

  final SSEClient _client = SSEClient();

  SseService() {
    if (Service.baseUrl.isEmpty) {
      throw Exception('SERVICE_BASE_URL is not set in .env file');
    }
  }

  Stream<SSEResponse> _connectSse(String url, {required Function(SSEResponse) onData, Function(String)? onError, VoidCallback? onDone}) {
    final request = SSERequest(
      requestType: RequestMethodType.get,
      url: url,
      onData: onData,
      onError: onError,
      onDone: onDone,
      retry: false, // Enables automatic reconnection
    );
    return _client.connect('main', request);
  }

  Stream<SSEResponse> connectSseOwner(int ownerId, {required Function(SSEResponse) onData, Function(String)? onError, VoidCallback? onDone}) {
    final url = Uri.parse('${Service.baseUrl}/sse/owner/$ownerId');
    return _connectSse(url.toString(), onData: onData, onError: onError, onDone: onDone);    
  }

  Stream<SSEResponse> connectSsePlayer(int userId, {required Function(SSEResponse) onData, Function(String)? onError, VoidCallback? onDone}) {
    final url = Uri.parse('${Service.baseUrl}/sse/user/$userId');
    return _connectSse(url.toString(), onData: onData, onError: onError, onDone: onDone);
  }

  void disconnect() {
    _client.close(connectionId: 'main');
  }

}