import 'package:get/get.dart';

import '../data/models/progress.dart';

class CompareResultC extends GetxController {
  Map<String, dynamic> progress1 = {
    'id': '',
    'date': Get.arguments['date1'],
    'listImage': [for (int i = 0; i < 4; i++) 'assets/images/work4.png'],
  };
  Map<String, dynamic> progress2 = {
    'id': '',
    'date': Get.arguments['date2'],
    'listImage': [for (int i = 0; i < 4; i++) 'assets/images/work4.png'],
  };

  List<Progres> listProgres = Get.arguments['listProgess'];

  @override
  void onInit() {
    super.onInit();
    initAll();
  }

  bool checkSameDate(DateTime date1, DateTime date2) {
    bool check = (date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year);
    return check;
  }

  initAll() {
    for (var item in listProgres) {
      if (checkSameDate(item.date, progress1['date'])) {
        progress1 = {
          'id': item.id,
          'date': item.date,
          'listImage': item.image,
        };
      }
      if (checkSameDate(item.date, progress2['date'])) {
        progress2 = {
          'id': item.id,
          'date': item.date,
          'listImage': item.image,
        };
      }
    }
  }
}
