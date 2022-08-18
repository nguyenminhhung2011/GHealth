import 'package:get/get.dart';
import 'package:gold_health/apps/controls/getOldController.dart';

import '../controls/fillProfilControls.dart';

class GetOldB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetOldC>(() => GetOldC());
  }
}
