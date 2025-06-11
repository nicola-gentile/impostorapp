import 'package:flutter_dotenv/flutter_dotenv.dart';


class Service {
  static final String baseUrl = dotenv.env['SERVICE_BASE_URL'] ?? '';
}