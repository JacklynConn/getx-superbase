import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superbase_project/app/modules/home/controllers/home_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/edite_product_controller.dart';

class EditProductView extends GetView<EditeProductController> {
  const EditProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(labelText: 'Product Name'),
                ),
                TextField(
                  controller: controller.priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: controller.descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: controller.quantityController,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Obx(() {
                    if (controller.imageFile.value != null) {
                      return Image.file(
                        controller.imageFile.value!,
                        fit: BoxFit.cover,
                      );
                    } else if (controller.currentImageUrl.value.isNotEmpty) {
                      return Image.network(
                        controller.currentImageUrl.value,
                        fit: BoxFit.cover,
                      );
                    } else {
                      return const Icon(
                        Icons.image,
                        size: 50,
                        color: Colors.grey,
                      );
                    }
                  }),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: controller.pickImage,
                  child: const Text('Pick Image'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final productId = Get.arguments['id'].toString(); // Convert id to String
                    controller.updateProduct(productId);
                    Get.toNamed(Routes.HOME);
                    Get.find<HomeController>().fetchProducts();
                  },
                  child: const Text('Update Product'),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}