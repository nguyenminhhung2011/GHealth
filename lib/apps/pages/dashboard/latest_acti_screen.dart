import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../template/misc/colors.dart';

class LatestActiScreen extends StatelessWidget {
  const LatestActiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    // var widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            flex: (heightDevice / 10 * 1).round(),
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.primaryColor.withOpacity(0.2),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Hero(
                      tag: 'latest tag',
                      child: Text(
                        'Latest Activity',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              fontSize: 18,
                              fontFamily: "Sen",
                            ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.primaryColor.withOpacity(0.2),
                        ),
                        child: const Icon(
                          Icons.more_horiz,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: (heightDevice / 10 * 8).round(),
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      LatesActiContainer(
                        imagePath: 'assets/images/drinking.png',
                        title: 'About 3 minutes ago',
                        mainTitle: 'Drinking 300ml Water',
                        press: () {},
                      ),
                      const Divider(),
                      LatesActiContainer(
                        imagePath: 'assets/images/eating.png',
                        title: 'About 10 minutes ago',
                        mainTitle: 'Eat Snack (Fitbar)',
                        press: () {},
                      ),
                      const Divider(),
                      LatesActiContainer(
                        imagePath: 'assets/images/yoga.png',
                        title: 'About 3 hours ago',
                        mainTitle: 'Don\'t miss yout lowerbody workout',
                        press: () {},
                      ),
                      const Divider(),
                      LatesActiContainer(
                        imagePath: 'assets/images/fitness.png',
                        title: 'About 2 hours ago',
                        mainTitle: 'Ups, Your have missed your lowerbody',
                        press: () {},
                      ),
                      const Divider(),
                      LatesActiContainer(
                        imagePath: 'assets/images/yoga.png',
                        title: 'About 10 minutes ago',
                        mainTitle: 'Congratulations, You have finished A',
                        press: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LatesActiContainer extends StatelessWidget {
  final String mainTitle;
  final String title;
  final String imagePath;
  final Function() press;
  const LatesActiContainer(
      {Key? key,
      required this.mainTitle,
      required this.title,
      required this.imagePath,
      required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.5),
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  imagePath,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mainTitle,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: press,
            child: const Icon(Icons.more_vert, color: Colors.grey),
          )
        ],
      ),
    );
  }
}

class Line extends StatelessWidget {
  const Line({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 0.5,
      color: Colors.grey,
    );
  }
}
