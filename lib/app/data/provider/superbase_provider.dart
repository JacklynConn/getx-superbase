import 'package:supabase_flutter/supabase_flutter.dart';

class SuperBaseProvider {
  static SuperBaseProvider instance = SuperBaseProvider.privateConstructor();

  SuperBaseProvider.privateConstructor();

  final supabase = Supabase.instance.client;

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );
      if (response.user != null) {
        print('User Created: ${response.user!.email}');
      } else {
        throw 'Signup failed';
      }
    } catch (e) {
      throw 'Signup failed: $e';
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.session != null) {
        print('Login Successful!');
      } else {
        throw 'Login failed';
      }
    } catch (e) {
      throw 'Login failed: $e';
    }
  }

  // Get user profile data
  
}
