import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbase_project/app/widgets/custom_text_form_field.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  SignupView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'SignUp',
                          textStyle: const TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                          speed: const Duration(milliseconds: 2000),
                        ),
                      ],
                      repeatForever: true,
                      pause: const Duration(milliseconds: 1000),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              CustomTextFormField(
                controller: controller.nameController,
                labelText: "Name",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                controller: controller.emailController,
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
                    controller: controller.passwordController,
                    labelText: "Password",
                    obscureText: controller.isPasswordHidden.value,
                    suffixIcon: IconButton(
                      icon: Icon(controller.isPasswordHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  )),
              SizedBox(height: 20),
              Obx(() => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.all(15),
                    ),
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              controller.signup();
                            }
                          },
                    child: controller.isLoading.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "SignUp",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  )),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.purple),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
