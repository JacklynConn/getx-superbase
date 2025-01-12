import 'package:get/get.dart';
import '../../../data/provider/superbase_provider.dart';

class LoginController extends GetxController {
  final togglePasswordVisibility = true.obs;
  final isLoading = false.obs;

  void togglePassword() {
    togglePasswordVisibility.value = !togglePasswordVisibility.value;
  }

  Future<void> handleLogin(String email, String password) async {
    try {
      isLoading.value = true;
      await SuperBaseProvider.instance.login(email, password);
      Get.offAllNamed('/home'); // Navigate to home after successful login
    } catch (e) {
      Get.snackbar(
        'Error',
        'Login failed: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
