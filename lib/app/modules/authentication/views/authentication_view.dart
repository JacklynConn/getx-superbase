import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:superbase_project/app/modules/home/views/home_view.dart';
import 'package:superbase_project/app/modules/login/views/login_view.dart';
import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  const AuthenticationView({super.key});
  @override
  Widget build(BuildContext context) {
    return controller.hasToken() ? HomeView() : LoginView();
  }
}
