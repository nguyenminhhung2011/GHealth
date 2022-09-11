import 'package:get/get.dart';
import 'package:gold_health/apps/controls/basic_controller/get_weight_controller.dart';

class GetWeightB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetWeightC>(() => GetWeightC());
  }
}
