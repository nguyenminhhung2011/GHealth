import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../template/misc/colors.dart';

class FakeData {
  static List<Map<String, dynamic>> calories = [
    {
      'day': 'Sun',
      '1': 50.0,
      '2': 100.0,
    },
    {
      'day': 'Mon',
      '1': 60.0,
      '2': 100.0,
    },
    {
      'day': 'Tue',
      '1': 30.0,
      '2': 100.0,
    },
    {
      'day': 'Wed',
      '1': 40.0,
      '2': 100.0,
    },
    {
      'day': 'Thu',
      '1': 70.0,
      '2': 100.0,
    },
    {
      'day': 'Fri',
      '1': 20.0,
      '2': 100.0,
    },
    {
      'day': 'Sat',
      '1': 40.0,
      '2': 100.0,
    },
  ];
  static List<Data> data = [
    Data(
        name: 'now',
        percents: (30.1 / 80.1 * 100).round().toDouble(),
        color: AppColors.primaryColor2,
        imagePath: 'assets/images/fitness.png'),
    Data(
      name: '',
      percents: (50 / 80.1 * 100).round().toDouble(),
      color: AppColors.primaryColor1,
      imagePath: 'assets/images/medal.png',
    )
  ];

  static List<Map<String, dynamic>> list_set = [
    {
      "time": 35,
      "name": "Warm Up",
      "image":
          "https://barbend.com/wp-content/uploads/2022/05/shutterstock_583754929-1.jpg",
    },
    {
      "time": 25,
      "name": "Jumping Jack",
      "image":
          "https://barbend.com/wp-content/uploads/2022/05/shutterstock_583754929-1.jpg",
    },
    {
      "time": 15,
      "name": "Skipping",
      "image":
          "https://barbend.com/wp-content/uploads/2022/05/shutterstock_583754929-1.jpg",
    },
    {
      "time": 65,
      "name": "Squats",
      "image":
          "https://barbend.com/wp-content/uploads/2022/05/shutterstock_583754929-1.jpg",
    },
    {
      "time": 45,
      "name": "Arm Raises",
      "image":
          "https://barbend.com/wp-content/uploads/2022/05/shutterstock_583754929-1.jpg",
    },
    {
      "time": 65,
      "name": "Rest and Drink",
      "image":
          "https://barbend.com/wp-content/uploads/2022/05/shutterstock_583754929-1.jpg",
    },
  ];

  static List<Map<String, dynamic>> lists = [
    {
      'id': 'meal 26',
      'name': 'Banana',
      'asset':
          'https://raw.githubusercontent.com/minhunsocute/Data-GHealth/main/ingredient_image/banana.png',
      'description': 'Banana is good for you',
      'time': 3,
      'timeCook': 0,
      'kCal': 110,
      'fats': 0,
      'proteins': 1,
      'carbs': 28,
      'steps': [],
      'listIngredient': [],
      'category': ['Salad'],
    },
    {
      'id': 'meal 27',
      'name': 'Chocolate Milk',
      'asset':
          'https://raw.githubusercontent.com/minhunsocute/Data-GHealth/main/ingredient_image/chocolateMilke.png',
      'description':
          'Chocolate milk is easy to make at home from scratch, and you don\'t need a bottle of chocolate syrup. This recipe is made with real cocoa powder and just a little sugar for sweetness. Both kids and adults are going to love its taste.',
      'time': 3,
      'timeCook': 3,
      'kCal': 193,
      'fats': 4,
      'proteins': 13,
      'carbs': 26,
      'steps': [
        'Gather the ingredients.',
        'Pour the milk into a glass and slowly add cocoa powder while blending with an immersion blender, spoon, or a small whisk. An immersion blender or a small whisk work best because they reduce the clumping of the cocoa powder.',
        'Add powdered sugar until well blended.',
        'Serve immediately or cover and place in the refrigerator until ready to drink. Enjoy.',
      ],
      'listIngredient': [],
      'category': ['Smooth'],
    },
    {
      'id': 'meal 28',
      'name': 'Apple Juice',
      'asset':
          'https://raw.githubusercontent.com/minhunsocute/Data-GHealth/main/ingredient_image/appleJuice.png',
      'description':
          'So, now that you know all about apple juice go ahead and make some today! If you are looking for a healthy beverage option that is quick and easy to make, apple juice is a perfect choice. It is easy to prepare and very refreshing. Have a cup of fresh apple juice for breakfast to start the day on a healthy note. You can also have a cup of apple juice before a workout session to get a quick boost of energy. Enjoy!',
      'time': 3,
      'timeCook': 10,
      'kCal': 189,
      'fats': 1,
      'proteins': 1,
      'carbs': 61,
      'steps': [
        'Wash the apples under running water',
        'Cut the apples into 4 pieces. Remove the seeds of the apples.',
        'Add the pieces of apples to the blender along with water, lemon, ginger, and mint leaves. Run the machine.',
        'Pass the apple juice through a strainer.',
        'Add honey for taste.',
        'Add ice and serve.',
      ],
      'listIngredient': [],
      'category': ['Smooth'],
    },
    {
      'id': 'meal 29',
      'name': 'Peanut Butter Toast',
      'asset':
          'https://raw.githubusercontent.com/minhunsocute/Data-GHealth/main/ingredient_image/PeanutButterToast.png',
      'description':
          'Need a quick and healthy breakfast idea? Toast up a slice a whole grain bread, spread on peanut butter or almond butter and top with your favorite toppings!',
      'time': 3,
      'timeCook': 5,
      'kCal': 175,
      'fats': 9,
      'proteins': 8,
      'carbs': 19,
      'steps': [
        'Toast bread.',
        'Spread on peanut butter, sprinkle on toppings and enjoy.',
      ],
      'listIngredient': [],
      'category': [
        'Cake',
        'Salad',
        'Smooth',
      ],
    },
    {
      'id': 'meal 30',
      'name': 'Healthy Trail Mix',
      'asset':
          'https://raw.githubusercontent.com/minhunsocute/Data-GHealth/main/ingredient_image/HealthyTrailMix.png',
      'description':
          'Learn how to make healthy trail mix with this foolproof method + 3 easy recipes. Trail mix is such an easy and delicious snack to make at home with just a few key ingredients.',
      'time': 3,
      'timeCook': 5,
      'kCal': 237,
      'fats': 14,
      'proteins': 6,
      'carbs': 24,
      'steps': [
        'Mix: Combine all ingredients together and enjoy.',
        'Store: Store leftover trail mix in a sealed jar or reusable storage bag. The omega and monster mix should keep for 1-2 weeks, the popcorn mix is best eaten in 1-2 days because the popcorn will lose it’s crunch.',
      ],
      'listIngredient': [],
      'category': ['Cake'],
    },
    {
      'id': 'meal 31',
      'name': 'Strawberry Banana Smoothie',
      'asset':
          'https://raw.githubusercontent.com/minhunsocute/Data-GHealth/main/ingredient_image/StrawberryBananaSmoothie.png',
      'description':
          'There’s nothing better than a classic strawberry banana smoothie! This one has Greek yogurt for an added protein boost.',
      'time': 3,
      'timeCook': 5,
      'kCal': 159,
      'fats': 1,
      'proteins': 7,
      'carbs': 34,
      'steps': [
        'Blend: Place all ingredients in a high-powered blender and blend until smooth and creamy. The honey is optional. You can make it without the honey, taste and then add it if you’d like the smoothie to be a little sweeter',
        'Serve: Enjoy immediately after making.',
      ],
      'listIngredient': [],
      'category': ['Smooth'],
    },
    {
      'id': 'meal 32',
      'name': 'Orange Juice',
      'asset':
          'https://raw.githubusercontent.com/minhunsocute/Data-GHealth/main/ingredient_image/OrangeJuice.png',
      'description':
          'How to make fresh-squeezed orange juice at home using one of three methods. This sugar-free orange juice (with pulp or without) uses just one ingredient and is packed with healthy vitamins and wonderful alone or as part of a juice blen',
      'time': 3,
      'timeCook': 5,
      'kCal': 266,
      'fats': 1,
      'proteins': 5,
      'carbs': 67,
      'steps': [
        'With A Juicer',
        'Prepare the oranges by first peeling them. Then, chop them into smaller parts to fit your juicer chute.',
        'Feed a few into your juicer chute at a time- voila.',
      ],
      'listIngredient': [],
      'category': ['Smooth'],
    },
    {
      'id': 'meal 33',
      'name': 'Healthy Apple Butter',
      'asset':
          'https://raw.githubusercontent.com/minhunsocute/Data-GHealth/main/ingredient_image/appleButter.png',
      'description':
          'This healthy homemade apple butter is made in the slow cooker without any added sugar. Enjoy as a spread on toast or stir into a warm bowl of oatmeal.',
      'time': 3,
      'timeCook': 7 * 60 + 15,
      'kCal': 51,
      'fats': 0,
      'proteins': 0,
      'carbs': 14,
      'steps': [
        'Place cored and sliced apples (not peeled) into a large slow cooker or crock-pot.',
        'Add apple cider vinegar (or water) and spices. Stir all ingredients together, cover and let it cook for 5-6 hours on low.',
        'The liquid will reduce and the apples will be very soft, dark in color and smell heavenly. Turn the slow cooker off and then use an immersion blender to puree the apples until smooth',
        'Once the apples are pureed, turn the slow cooker on high and heat the apple butter for 1-2 hours, uncovered. This will help it thicken and caramelize.',
        'Once the apple butter is the consistency you like, turn off the slow cooker and let the apple butter cool for 30 minutes before transferring into airtight containers for storage.',
        'For storage: apple butter will keep in the fridge for up to 3 weeks or up to a year the freezer.',
      ],
      'listIngredient': [],
      'category': ['Smooth'],
    },
    {
      'id': 'meal 34',
      'name': 'Chocolate Chip Almond Granola Bars',
      'asset':
          'https://raw.githubusercontent.com/minhunsocute/Data-GHealth/main/ingredient_image/chocolateChip.png',
      'description':
          'Make your own tasty granola bars at home! These chocolate chip almond granola bars are chewy, crispy and hold together perfectly.',
      'time': 3,
      'timeCook': 13,
      'kCal': 228,
      'fats': 12,
      'proteins': 3,
      'carbs': 31,
      'steps': [
        'Line an 8×8-inch square baking pan with parchment. I like to use binder clips to clamp the parchment down so the parchment stays in place.',
        'In a large mixing bowl, combine oats, cereal, 1/8 cup almonds and 1/8 cup chocolate chips. Set aside',
        'In a pot on medium heat, combine honey and coconut oil. Let mixture heat until it starts to bubble, stirring continuously. Once bubbling for 30 seconds, remove from heat and stir in salt and vanilla. Let cool for about 30 seconds to 1 minute.',
        'Pour honey mixture into the bowl with the dry ingredients and mix until well coated. The chocolate chips will likely melt a bit, this is okay and actually helps the bars hold together.',
        'Pour mixture into your parchment lined baking pan and lightly press the mixture so it’s even. Top with remaining chopped almonds and chocolate chips and really press the mixture down as much as possible. Skipping this step will result in crumbly bars.',
        'Set: Once bars are pressed down firmly, place pan in the fridge for 2 hours to allow the bars to cool and set up.',
        'Cut: Once the bars feel solid/hard to the touch, remove from the pan, place on a cutting board and slice into 10 bars. Serve immediately or save for later.',
        'To store: these bars will stay together best if you store them in the refrigerator. They will keep for 1 week in an airtight container in the fridge. For freezing, wrap them individually and store in the freezer for up to 2 months.',
      ],
      'listIngredient': [],
      'category': [
        'Rice',
        'Cake',
      ],
    }
  ];
  static List<String> dayList = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  static List<Map<String, dynamic>> list11 = [
    {
      'id': 1,
      'listMealBreak': ['meal 1', 'meal 25'],
      'listMealLunch': ['meal 17'],
      'listSnack': ['meal 26'],
      'listMealDinner': ['meal 24', 'meal 12'],
    },
    {
      'id': 2,
      'listMealBreak': ['meal 5', 'meal 28'],
      'listMealLunch': ['meal 16'],
      'listSnack': ['meal 29'],
      'listMealDinner': ['meal 19', 'meal 8'],
    },
    {
      'id': 3,
      'listMealBreak': ['meal 8', 'meal 25'],
      'listMealLunch': ['meal 13'],
      'listSnack': ['meal 30'],
      'listMealDinner': ['meal 24', 'meal 22', 'meal 27'],
    },
    {
      'id': 4,
      'listMealBreak': ['meal 1', 'meal 28'],
      'listMealLunch': ['meal 10', 'meal 23'],
      'listSnack': ['meal 29'],
      'listMealDinner': ['meal 14', 'meal 21', 'meal 25'],
    },
    {
      'id': 5,
      'listMealBreak': ['meal 7', 'meal 31'],
      'listMealLunch': ['meal 13'],
      'listSnack': ['meal 30'],
      'listMealDinner': ['meal 18', 'meal 27'],
    },
    {
      'id': 6,
      'listMealBreak': ['meal 2', 'meal 32'],
      'listMealLunch': ['meal 14', 'meal 5'],
      'listSnack': ['meal 33'],
      'listMealDinner': ['meal 15', 'meal 34'],
    },
    {
      'id': 7,
      'listMealBreak': ['meal 1', 'meal 31'],
      'listMealLunch': ['meal 19', 'meal 13'],
      'listSnack': ['meal 5'],
      'listMealDinner': ['meal 11', 'meal 10', 'meal 32'],
    },
  ];
}

class Data {
  final String name;
  final double percents;
  final Color color;
  final String imagePath;
  Data(
      {required this.imagePath,
      required this.name,
      required this.percents,
      required this.color});
}
//-------------------------------------------------------------------

  // getAllMeal() {
  //   _allMeal.bindStream(
  //     firestore.collection('meal').snapshots().map(
  //       (event) {
  //         List<Meal> result = [];
  //         for (var item in event.docs) {
  //           //print(1);
  //           result.add(Meal.fromSnap(item));
  //         }
  //         return result;
  //       },
  //     ),
  //   );
  //   update();
  // }


//-------------------------------------------------
  // getListMealBreakFast() async {
  //   _listMealBreakFast.bindStream(
  //     firestore.collection('meal').snapshots().map(
  //       (event) {
  //         List<Meal> result = [];
  //         for (var item in event.docs) {
  //           //print(1);
  //           Map<String, dynamic> temp = item.data();
  //           if (temp['time'] == 1) {
  //             result.add(Meal.fromSnap(item));
  //           }
  //         }
  //         return result;
  //       },
  //     ),
  //   );
  //   update();
  // }

  // getListMealLunch() async {
  //   _listMealLunch.bindStream(
  //     firestore.collection('meal').snapshots().map(
  //       (event) {
  //         List<Meal> result = [];
  //         for (var item in event.docs) {
  //           //print(1);
  //           Map<String, dynamic> temp = item.data();
  //           if (temp['time'] == 2) {
  //             result.add(Meal.fromSnap(item));
  //           }
  //         }
  //         return result;
  //       },
  //     ),
  //   );
  //   update();
  // }

  // getListMealDinner() async {
  //   _listMealSnack.bindStream(
  //     firestore.collection('meal').snapshots().map(
  //       (event) {
  //         List<Meal> result = [];
  //         for (var item in event.docs) {
  //           //print(1);
  //           Map<String, dynamic> temp = item.data();
  //           if (temp['time'] == 3) {
  //             result.add(Meal.fromSnap(item));
  //           }
  //         }
  //         return result;
  //       },
  //     ),
  //   );
  //   update();
  // }

  // getAllNutrtion() async {
  //   _listNutrition.bindStream(
  //     firestore
  //         .collection('users')
  //         .doc(AuthService.instance.currentUser!.uid)
  //         .collection('Nutrition')
  //         .snapshots()
  //         .map(
  //       (event) {
  //         List<Nutrition> result = [];
  //         for (var item in event.docs) {
  //           result.add(Nutrition.fromSnap(item));
  //         }
  //         return result;
  //       },
  //     ),
  //   );
  //   update();
  // }

  // getTimeEat() async {
  //   timeEat.bindStream(
  //     firestore
  //         .collection('users')
  //         .doc(AuthService.instance.currentUser!.uid)
  //         .collection('timeEat')
  //         .snapshots()
  //         .map((event) {
  //       List<DateTime> result = [];
  //       Map<String, dynamic> listTime = event.docs[0].data();
  //       for (var item in listTime['list']) {
  //         result.add(DateTime.fromMillisecondsSinceEpoch(item.seconds * 1000));
  //       }
  //       return result;
  //     }),
  //   );
  //   update();
  // }

//    getDataNutriPlan() async {
//   listDataNutriPlan
//       .bindStream(firestore.collection('PlanMeal').snapshots().map((event) {
//     List<Map<String, dynamic>> result = [
//       for (int i = 1; i <= 7; i++)
//         {
//           'id': i,
//           'kCal': 0,
//           'pro': 0,
//           'fats': 0,
//           'carbs': 0,
//         }
//     ];
//     for (var item in event.docs) {
//       var data = item.data();
//       result[data['id'] - 1]['kCal'] = data['listNutri'][0];
//       result[data['id'] - 1]['pro'] = data['listNutri'][1];
//       result[data['id'] - 1]['fats'] = data['listNutri'][2];
//       result[data['id'] - 1]['carbs'] = data['listNutri'][3];
//     }
//     return result;
//   }));
//   update();
// }


// final Rx<List<Meal>> _allMeal = Rx<List<Meal>>([]);
  // final Rx<List<Meal>> _listMealBreakFast = Rx<List<Meal>>([]);
  // final Rx<List<Meal>> _listMealLunch = Rx<List<Meal>>([]);
  // final Rx<List<Meal>> _listMealSnack = Rx<List<Meal>>([]);


   // <DateTime>[
  //   DateTime.now(),
  //   DateTime.now(),
  //   DateTime.now(),
  //   DateTime.now(),
  // ].obs;

    // Map<String, dynamic> getNutritionDateTime(DateTime date) {
  //   Map<String, dynamic> result = {
  //     'id': date.weekday,
  //     'kCal': 0,
  //     'carbs': 0,
  //     'pro': 0,
  //     'fats': 0,
  //   };
  //   for (var item in listNutrition) {
  //     if (item.dateTime.day == date.day &&
  //         item.dateTime.month == date.month &&
  //         item.dateTime.year == date.year) {
  //       result['kCal'] += item.amount * getMealId(item.id, allMeal).kCal;
  //       result['carbs'] += item.amount * getMealId(item.id, allMeal).carbs;
  //       result['pro'] += item.amount * getMealId(item.id, allMeal).proteins;
  //       result['fats'] += item.amount * getMealId(item.id, allMeal).fats;
  //     }
  //   }
  //   return result;
  // }

  // --> kcal, proteins, fats, carbo


  // pageController.animateToPage(
                              //     controller
                              //             .listSleepWithDate(controller
                              //                 .listDateTime[controller.onFocus]
                              //                 .weekday)
                              //             .isEmpty
                              //         ? 1
                              //         : 0,
                              //     duration: const Duration(milliseconds: 750),
                              //     curve: Curves.ease);
                              // pageIndex = pageIndex == 0 ? 1 : 0;

 // void scheduleAlarm(DateTime scheduledNotificationDateTime,
  //     {required bool isRepeating}) async {
  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     'alarm_notif',
  //     'alarm_notif',
  //     channelDescription: 'Channel for Alarm notification',
  //     icon: 'codex_logo',
  //     sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
  //     largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
  //   );

  //   var iOSPlatformChannelSpecifics = IOSNotificationDetails(
  //     sound: 'a_long_cold_sting.wav',
  //     presentAlert: true,
  //     presentBadge: true,
  //     presentSound: true,
  //   );
  //   var platformChannelSpecifics = NotificationDetails(
  //     android: androidPlatformChannelSpecifics,
  //     iOS: iOSPlatformChannelSpecifics,
  //   );

  //   if (isRepeating)
  //     await flutterLocalNotificationsPlugin.showDailyAtTime(
  //       0,
  //       'Office',
  //       'OK',
  //       Time(
  //         scheduledNotificationDateTime.hour,
  //         scheduledNotificationDateTime.minute,
  //         scheduledNotificationDateTime.second,
  //       ),
  //       platformChannelSpecifics,
  //     );
  //   else
  //     await flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       'Office',
  //       'Ok',
  //       tz.TZDateTime.from(scheduledNotificationDateTime, tz.local),
  //       platformChannelSpecifics,
  //       androidAllowWhileIdle: true,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime,
  //     );
  // }

  // void onSaveAlarm(bool _isRepeating) {
  //   DateTime? scheduleAlarmDateTime;
  //   if (_alarmTime!.isAfter(DateTime.now()))
  //     scheduleAlarmDateTime = _alarmTime;
  //   else
  //     scheduleAlarmDateTime = _alarmTime!.add(Duration(days: 1));

  //   var alarmInfo = AlarmInfo(
  //     alarmDateTime: scheduleAlarmDateTime,
  //     gradientColorIndex: _currentAlarms!.length,
  //     title: 'alarm',
  //   );
  //   _alarmHelper.insertAlarm(alarmInfo);
  //   if (scheduleAlarmDateTime != null) {
  //     scheduleAlarm(scheduleAlarmDateTime, alarmInfo,
  //         isRepeating: _isRepeating);
  //   }
  //   Navigator.pop(context);
  //   loadAlarms();
  // }

  // void deleteAlarm(int? id) {
  //   _alarmHelper.delete(id);
  //   //unsubscribe for notification
  //   loadAlarms();
  // }
