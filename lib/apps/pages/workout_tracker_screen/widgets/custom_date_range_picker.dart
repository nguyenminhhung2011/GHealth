// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../global_widgets/button_custom/Button_icon_gradient_color.dart';

// class CustomDateRangePicker extends StatelessWidget {
//   const CustomDateRangePicker({super.key, required this.dateRange});
//   final DateTimeRange dateRange;

//   @override
//   Widget build(BuildContext context) {
//     final start = dateRange.start;
//     final end = dateRange.end;
//     return SizedBox(
//       height: Get.mediaQuery.size.height*0.4,
//       width: Get.mediaQuery.size.width*0.8,
//       child: ButtonIconGradientColor(
//         title: ' Week',
//         icon: Icons.calendar_month,
//         press: () async {
//           await showDateRangePicker(
//             context: context,
//             firstDate: start,
//             lastDate: end,
//           );
         
//         },
//       ),
//     );
//   }
// }
