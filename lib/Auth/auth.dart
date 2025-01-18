// lib/Auth/auth.dart

import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  // Replace these with your actual Supabase credentials
  static const String supabaseUrl = "https://zbtxqggezbkgthgldgbu.supabase.co";
  static const String supabaseAnonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpidHhxZ2dlemJrZ3RoZ2xkZ2J1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzcxMzkxNzIsImV4cCI6MjA1MjcxNTE3Mn0.5O3C6cutyW5PUjOKEiflHX_IBKOqIOUpQHsvgJj5z2s";

  // Create a single Supabase client instance
  static final SupabaseClient supabaseClient =
      SupabaseClient(supabaseUrl, supabaseAnonKey);

  /// Sign in a user with email and password
  static Future<void> signIn({
    required String email,
    required String password,
  }) async {
    final response = await supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
    if (response.session == null || response.user == null) {
      throw 'Sign-in failed';
    }
  }

  /// Sign up a user with email and password
  static Future<void> signUp({
    required String email,
    required String password,
  }) async {
    final response = await supabaseClient.auth.signUp(
      email: email,
      password: password,
    );
    if (response.user == null) {
      throw 'Sign-up failed';
    }
  }

  /// Sign out the currently logged-in user
  static Future<void> signOut() async {
    await supabaseClient.auth.signOut();
  }
}
