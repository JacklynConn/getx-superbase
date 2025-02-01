import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../data/provider/superbase_provider.dart';

class HomeController extends GetxController {
  final userData = {}.obs;
  final isLoading = false.obs;

  RxList<Map<String, dynamic>> products = RxList<Map<String, dynamic>>([]);

  @override
  void onInit() {
    super.onInit();
    getUserData();
    fetchProducts();
  }

  Future<void> getUserData() async {
    try {
      isLoading.value = true;
      final data = await SuperBaseProvider.instance.getUserProfile();
      userData.value = data;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch products from Supabase
  Future<void> fetchProducts() async {
    try {
      final data =
      await SuperBaseProvider.instance.supabase.from('products').select();
      products.assignAll(List<Map<String, dynamic>>.from(data));
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching products: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Delete a product from Supabase
  Future<void> deleteProduct(int id) async {
    try {
      // Find the product to delete
      final product = products.firstWhere((product) => product['id'] == id);
      final imagePath = product['image'];
      if (kDebugMode) {
        print('imagePath: $imagePath');
      }

      // Delete the product from the database
      await SuperBaseProvider.instance.supabase
          .from('products')
          .delete()
          .eq('id', id);

      if (imagePath != null && imagePath.isNotEmpty) {
        final bucket = 'product_image';
        final publicUrlPrefix = SuperBaseProvider.instance.supabase.storage
            .from(bucket)
            .getPublicUrl('');
        print('Public URL: $publicUrlPrefix');
        final filePath = imagePath.replaceFirst(publicUrlPrefix, '').trim();
        print('file path: $filePath');

        // Remove the file from the bucket
        final response = await SuperBaseProvider.instance.supabase.storage
            .from(bucket)
            .remove([filePath]);
        print('response: $response');
        print('response path: ${response.toString()}');
      }

      // Remove the product from the local list
      products.removeWhere((product) => product['id'] == id);
      Get.snackbar("Success", "Product deleted successfully.");
    } catch (e) {
      print('Error deleting product or image: $e');
      Get.snackbar("Error", "An error occurred while deleting the product: $e");
    }
  }

  // Update product details in Supabase
  Future<void> updateProduct(Map<String, dynamic> updatedProduct) async {
    try {
      final response = await SuperBaseProvider.instance.supabase
          .from('products')
          .update(updatedProduct)
          .eq('id', updatedProduct['id']);
      if (response.error != null) {
        Get.snackbar(
            "Error", "Failed to update product: ${response.error?.message}");
        return;
      }
      final index = products
          .indexWhere((product) => product['id'] == updatedProduct['id']);
      if (index != -1) {
        products[index] = updatedProduct;
      }
      Get.snackbar("Success", "Product updated successfully.");
    } catch (e) {
      Get.snackbar("Error", "An error occurred while updating the product: $e");
    }
  }

  // Setup real-time updates for products
  void setupRealtimeUpdates() {
    SuperBaseProvider.instance.supabase
        .from('products')
        .stream(primaryKey: ['id']).listen(
          (event) {
        products.assignAll(
          event.map((e) => e).toList(),
        );
      },
      onError: (error) {
        Get.snackbar("Error", "Real-time updates failed: $error");
      },
    );
  }
}
