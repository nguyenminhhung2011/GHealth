import 'package:flutter/material.dart';

import '../../global_widgets/buttonMain.dart';
import '../../template/misc/colors.dart';

enum Gender {
  male,
  female,
}

class SelectGenderScreen extends StatefulWidget {
  const SelectGenderScreen({Key? key}) : super(key: key);

  @override
  State<SelectGenderScreen> createState() => _SelectGenderScreenState();
}

class _SelectGenderScreenState extends State<SelectGenderScreen> {
  Gender? _selecting;

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 30),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        height: heightDevice,
        width: widthDevice,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: heightDevice / 20),
            Row(
              children: [
                IconButton(
                  color: Colors.black,
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.only(right: 40),
                    alignment: Alignment.center,
                    child: Text(
                      'Select Your Gender',
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'Provide your gender so that we can choose the most conform exercise for you. ',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontSize: 12,
                  ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: widthDevice * 0.3,
                  width: widthDevice * 0.3,
                  decoration: BoxDecoration(
                    color: AppColors.mailColor,
                    border: _selecting == Gender.male
                        ? Border.all(width: 2.5, color: Colors.black)
                        : null,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selecting = Gender.male;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/Male.png',
                          width: 50,
                          height: 50,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            'Male',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sen',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: widthDevice * 0.3,
                  width: widthDevice * 0.3,
                  decoration: BoxDecoration(
                    color: AppColors.femailColor,
                    border: _selecting == Gender.female
                        ? Border.all(width: 2.5, color: Colors.black)
                        : null,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selecting = Gender.female;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/Female.png',
                          width: 50,
                          height: 50,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 6.0),
                          child: Text(
                            'Female',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sen',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: ButtonDesign(title: 'Next', press: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
