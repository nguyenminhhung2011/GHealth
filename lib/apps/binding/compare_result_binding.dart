import 'package:get/get.dart';
import '../controls/compare_result_controller.dart';

class CompareResultB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompareResultC>(() => CompareResultC());
  }
}
