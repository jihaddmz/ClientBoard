import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

class HelperConstants {
  static final String adminName = dotenv.env['ADMIN_NAME'] ?? "";
  static final DateFormat dateTimeFormat = DateFormat("MMM dd, yyyy HH:mm:ss") ;
}