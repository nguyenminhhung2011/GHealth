import 'package:get/get.dart';
import 'package:gold_health/apps/controls/basic_info_controller.dart';
import 'package:gold_health/apps/controls/fill_profile_controller.dart';
import 'package:gold_health/apps/controls/get_old_controller.dart';

import '../controls/get_height_controller.dart';
import '../controls/get_weight_controller.dart';
import '../controls/select_duration_controller.dart';
import '../controls/select_gender_controller.dart';

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
