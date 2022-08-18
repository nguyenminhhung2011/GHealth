import 'package:get/get.dart';
import 'package:gold_health/apps/controls/basic_controller/basic_info_controller.dart';
import 'package:gold_health/apps/controls/basic_controller/fill_profile_controller.dart';
import 'package:gold_health/apps/controls/basic_controller/get_old_controller.dart';

import '../controls/basic_controller/get_height_controller.dart';
import '../controls/basic_controller/get_weight_controller.dart';
import '../controls/basic_controller/select_duration_controller.dart';
import '../controls/basic_controller/select_gender_controller.dart';

class BasicInfoB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BasicInfoC>(() => BasicInfoC());
    Get.lazyPut<FillProfileC>(() => FillProfileC());
    Get.lazyPut<GetHeightC>(() => GetHeightC());
    Get.lazyPut<GetWeightC>(() => GetWeightC());
    Get.lazyPut<SelectDurationC>(() => SelectDurationC());
    Get.lazyPut<SelectGenderC>(() => SelectGenderC());
    Get.lazyPut<GetOldC>(() => GetOldC());
  }
}
