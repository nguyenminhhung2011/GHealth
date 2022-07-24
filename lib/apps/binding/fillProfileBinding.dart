import 'package:get/get.dart';

import '../controls/fillProfilControls.dart';

class FillProfileB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FillProfileC>(() => FillProfileC());
  }
}
