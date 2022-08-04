import 'package:flutter/material.dart';
import 'package:gold_health/apps/pages/mealPlanner/mealPlannerScreen.dart';

import '../../global_widgets/screenTemplate.dart';

class ComparisionScreen extends StatelessWidget {
  const ComparisionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenTemplate(
        child: Column(
          children: const [
            AppBarDesign(title: 'Comparision'),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
