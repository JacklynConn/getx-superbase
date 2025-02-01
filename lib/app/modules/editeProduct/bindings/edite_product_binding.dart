import 'package:get/get.dart';

import '../controllers/edite_product_controller.dart';

class EditeProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditeProductController>(
      () => EditeProductController(),
    );
  }
}
