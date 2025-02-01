import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/provider/superbase_provider.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getUserData();
    return Scaffold(
      appBar: _buildAppBar,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Obx(
              () => DrawerHeader(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.purple,
                      ),
                    ),
                    Text(
                      controller.userData['name'] ?? 'Loading...',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      controller.userData['email'] ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Get.toNamed('/profile');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                try {
                  await SuperBaseProvider.instance.logout();
                } catch (e) {
                  Get.snackbar('Error', e.toString());
                }
              },
            ),
          ],
        ),
      ),
      body: Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (controller.products.isEmpty) {
        return const Center(child: Text("No products available."));
      } else {
        return ListView.builder(
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final product = controller.products[index];
            return Card(
              child: ListTile(
                title: Text(product['name'] ?? 'No name'),
                subtitle: Text('Price: \$${product['price']}'),
                leading: product['image'] != null
                    ? Image.network(
                  product['image'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
                    : const Icon(Icons.image_not_supported),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Get.toNamed(Routes.EDITE_PRODUCT, arguments: product);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        controller.deleteProduct(product['id']);
                      },
                    ),
                  ],
                ),
                onTap: () {
                  Get.toNamed(Routes.PRODUCT_DETAIL, arguments: product);
                },
              ),
            );
          },
        );
      }
    }),
    );
  }
}

AppBar get _buildAppBar {
  return AppBar(
    title: const Text('Product'),
    centerTitle: true,
    actions: [
      IconButton(
        onPressed: () {
          Get.toNamed(Routes.UPLOAD_PRODUCT);
        },
        icon: Icon(Icons.add),
      ),
    ],
  );
}
