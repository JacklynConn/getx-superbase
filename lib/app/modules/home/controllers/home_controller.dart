import 'package:get/get.dart';

class HomeController extends GetxController {
  final userData = {}.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  Future<void> getUserData() async {
    try {
      isLoading.value = true;
      // final data = await SuperBaseProvider.instance.getUserProfile();
      // userData.value = data;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
