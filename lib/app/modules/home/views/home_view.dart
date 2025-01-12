import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Get.offAllNamed('/login');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Obx(() => DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.purple,
                  ),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        child: Icon(
                          Icons.person,
                          size: 50,
                        ),
                      ),
                      Text(
                        controller.userData['name'] ?? 'Loading...',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        controller.userData['email'] ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                )),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Get.toNamed('/profile');
              },
            ),
          ],
        ),
      ),      body: const Center(        child: Text(          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
