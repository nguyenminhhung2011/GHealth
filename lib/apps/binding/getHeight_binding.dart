import 'package:get/get.dart';
import 'package:gold_health/apps/controls/getHeight_controller.dart';

class GetHeightB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetHeightC>(() => GetHeightC());
  }
}