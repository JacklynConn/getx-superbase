import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/provider/superbase_provider.dart';
import '../../home/controllers/home_controller.dart';

class UploadProductController extends GetxController {
  //TODO: Implement UploadProductController
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final quantityController = TextEditingController();
  final imageFile = Rx<File?>(null);
  final selectSize = <String>[].obs;
  final selectColor = <String>[].obs;
  final isLoading = false.obs;

  //Pick Image
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  Future<void> uploadProduct() async {
    try {
      isLoading.value = true;
      if (imageFile.value == null) {
        Get.snackbar('Error', 'Please select an image');
        return;
      }
     if(selectSize.isEmpty || selectColor.isEmpty){
       Get.snackbar('Error', 'Please select size and color');
       return;
     }
     if(nameController.text.isEmpty || priceController.text.isEmpty || descriptionController.text.isEmpty){
       Get.snackbar('Error', 'Please fill all fields');
       return;
     }
      String? imageUrl;
     if(imageFile.value != null) {
       final path = 'products/${DateTime.now().millisecondsSinceEpoch}';
        imageUrl = await SuperBaseProvider.instance.uploadImage(imageFile.value!, 'product_image', path);
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
      await SuperBaseProvider.instance.saveProductToSupabase(product);
      Get.find<HomeController>().fetchProducts();
      Get.snackbar('Success', 'Product uploaded successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload product: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
