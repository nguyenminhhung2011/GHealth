import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gold_health/apps/pages/list_plan_screen/selectAmountFood.dart';

import '../../../template/misc/colors.dart';

class ActivityHistory extends StatelessWidget {
  const ActivityHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<int> _list = [for (int i = 1; i <= 140; i++) i];

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: 500,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Activity History',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Day 1',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.primaryColor1),
                    child: const Text(
                      'Start Over',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 210,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      offset: const Offset(2, 3),
                      blurRadius: 20,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      offset: const Offset(-2, -3),
                      blurRadius: 20,
                    )
                  ],
                ),
                child: MasonryGridView.count(
                  crossAxisCount: 6,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  itemCount: _list.length,
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/calendar.png',
                            height: 30,
                            width: 30,
                          ),
                          Text(
                            '${_list[index]}',
                            style: const TextStyle(
                              color: AppColors.primaryColor1,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            const RichTextCustom(
                size: 17, title: 'Calories Consume(kCal): ', data: 2000),
            const RichTextCustom(
                size: 17, title: 'Calories Burned(kCal): ', data: 3000),
            Row(
              children: const [
                RichTextCustom(size: 17, title: 'Steps: ', data: 2930),
                Spacer(),
                RichTextCustom(size: 17, title: 'Waters(ml): ', data: 3000),
              ],
            ),
            Row(
              children: const [
                RichTextCustom(size: 17, title: 'Sleep(hour): ', data: 8),
                Spacer(),
                RichTextCustom(size: 17, title: 'Fasting(hour): ', data: 3),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
