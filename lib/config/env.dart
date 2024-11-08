import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class Env {
  static Future<void> init() async {
    await dotenv.load();
  }

  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';
}
