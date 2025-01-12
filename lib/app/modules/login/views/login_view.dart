import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbase_project/app/widgets/custom_text_form_field.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final List<MaterialColor> colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  static const colorizeTextStyle = TextStyle(
    fontSize: 50.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'Horizon',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.login,
              size: 60,
              color: Colors.purple,
            ),
            SizedBox(
              child: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Welcome',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                  ColorizeAnimatedText(
                    'to',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                  ColorizeAnimatedText(
                    'Login',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
                onTap: () {
                  print("Tap Event");
                },
              ),
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              controller: emailController,
              labelText: "Email",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!GetUtils.isEmail(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Obx(() => CustomTextFormField(
                  controller: passwordController,
                  labelText: "Password",
                  obscureText: controller.togglePasswordVisibility.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.togglePasswordVisibility.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: controller.togglePassword,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                )),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.all(15),
                    ),
                    onPressed: () {
                      if (emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty) {
                        controller.handleLogin(
                          emailController.text,
                          passwordController.text,
                        );
                      } else {
                        Get.snackbar(
                          'Error',
                          'Please fill all fields',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    child: Obx(
                      () => controller.isLoading.value
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                Get.toNamed('/signup');
              },
              child: Text("Don't have an account? Sign up"),
            ),
          ],
        ),
      ),
    );
  }
}
