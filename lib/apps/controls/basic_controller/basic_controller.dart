import 'package:get/get.dart';
import 'package:gold_health/apps/controls/basic_controller/basic_info_controller.dart';

abstract class BasicController {
  final _parrentController = Get.find<BasicInfoC>();
  RxBool isLoading = false.obs;

  void changeTab(int value) {
    _parrentController.changeTab(value);
  }
}
