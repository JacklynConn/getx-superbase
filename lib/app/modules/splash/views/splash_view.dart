import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Row(
          children: [
            Image(
              width: 200,
              height: 200,
              image: NetworkImage(
                'https://cdn.prod.website-files.com/655b60964be1a1b36c746790/655b60964be1a1b36c746d41_646dfce3b9c4849f6e401bff_supabase-logo-icon_1.png',
              ),
            ),
            CircularProgressIndicator(
              
            )
          ],
        ),
      ),
    );
  }
}
