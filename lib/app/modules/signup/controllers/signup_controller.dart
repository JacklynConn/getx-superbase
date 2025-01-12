import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:superbase_project/app/data/provider/superbase_provider.dart';

class SignupController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var box = GetStorage();

  final isLoading = false.obs;
  final isPasswordHidden = true.obs;

  void togglePasswordVisibility() => isPasswordHidden.toggle();

  Future<void> signup() async {
    try {
      isLoading.value = true;
      await SuperBaseProvider.instance.signup(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Get.snackbar(
        'Success',
        'Account created successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
