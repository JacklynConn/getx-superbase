import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superbase_project/app/routes/app_pages.dart';

class SuperBaseProvider {
  static SuperBaseProvider instance = SuperBaseProvider.privateConstructor();
  final storage = GetStorage();

  SuperBaseProvider.privateConstructor();

  final supabase = Supabase.instance.client;

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      if (user.session != null && GetUtils.isEmail(email)) {
        // Store user data
        await storage.write('user', {
          'email': email,
          'name': name,
          'id': user.user?.id,
        });
        Get.offAllNamed(Routes.HOME);
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
        // Store user data
        final userData = response.user?.userMetadata ?? {};
        await storage.write('user', {
          'email': response.user?.email,
          'name': userData['name'],
          'id': response.user?.id,
        });
        Get.offAllNamed(Routes.HOME);
      } else {
        throw 'Login failed';
      }
    } catch (e) {
      throw 'Login failed: $e';
    }
  }

  // Get user profile data
  Future<Map<String, dynamic>> getUserProfile() async {
    try {
      // First try to get from storage
      final storedUser = storage.read('user');
      if (storedUser != null) {
        return Map<String, dynamic>.from(storedUser);
      }

      final user = supabase.auth.currentUser;
      if (user == null) throw 'User not found';

      final userData = user.userMetadata ?? {};
      final userInfo = {
        'email': user.email,
        'name': userData['name'] ?? 'User',
        'id': user.id,
      };
      
      // Store for future use
      await storage.write('user', userInfo);
      return userInfo;
    } catch (e) {
      throw 'Failed to get user profile: $e';
    }
  }

  Future<void> logout() async {
    try {
      await supabase.auth.signOut();
      await storage.remove('user');
      Get.offAllNamed(Routes.SPLASH);
    } catch (e) {
      throw 'Logout failed: $e';
    }
  }
}
