import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationController extends GetxController {

  final box = GetStorage();

  bool hasToken() {
    final token = box.read('user');
    if (token != null) {
      return true;
    }
    return false;
  }
}
