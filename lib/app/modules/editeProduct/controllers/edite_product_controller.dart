import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/provider/superbase_provider.dart';

class EditeProductController extends GetxController {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final quantityController = TextEditingController();
  final imageFile = Rx<File?>(null);
  final selectSize = <String>[].obs;
  final selectColor = <String>[].obs;
  final isLoading = false.obs;
  final currentImageUrl = RxString(''); // Add this line

  @override
  void onInit() {
    super.onInit();
    final product = Get.arguments;
    if (product != null) {
      nameController.text = product['name'];
      priceController.text = product['price'].toString();
      descriptionController.text = product['description'];
      quantityController.text = product['quantity'].toString();
      selectSize.assignAll(List<String>.from(product['size']));
      selectColor.assignAll(List<String>.from(product['color']));
      if (product['image'] != null) {
        currentImageUrl.value = product['image']; // Store the image URL
      }
    }
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  Future<void> updateProduct(String productId) async {
    try {
      isLoading.value = true;
      String? imageUrl;
      if (imageFile.value != null) {
        final path = 'products/${DateTime.now().millisecondsSinceEpoch}';
        imageUrl = await SuperBaseProvider.instance
            .uploadImage(imageFile.value!, 'product_image', path);
      } else {
        // Keep the existing image URL if no new image is selected
        imageUrl =
            currentImageUrl.value.isNotEmpty ? currentImageUrl.value : null;
      }

      final product = {
        'name': nameController.text,
        'price': double.parse(priceController.text),
        'description': descriptionController.text,
        'image': imageUrl,
        'quantity': int.parse(quantityController.text),
        'size': selectSize,
        'color': selectColor,
      };
      await SuperBaseProvider.instance
          .updateProductInSupabase(productId, product);
      Get.snackbar('Success', 'Product updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update product: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
