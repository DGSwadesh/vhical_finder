import 'package:get/get.dart';

class DemoController extends GetxController {
  var text = '1st text'.obs;

  initializeApplicationState() {
    Future.delayed(const Duration(seconds: 3), () {
      text.value = '2nd text';
    });
  }
}
