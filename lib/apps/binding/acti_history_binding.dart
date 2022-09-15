import 'package:get/get.dart';

import '../controls/acti_history_controller.dart';

class ActiHistoryB implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActiHistoriC>(() => ActiHistoriC());
  }
}
