import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _heightDevice = MediaQuery.of(context).size.height;
    var _widthDevice = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 10,
        left: 10,
        right: 10,
      ),
      height: _heightDevice,
      width: _widthDevice,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: ListTile(
              isThreeLine: true,
              title: Text(
                'Welcome :))',
                style: Theme.of(context).textTheme.headline5,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {},
              ),
              subtitle: Text(
                'Hoang Truong',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Container(
                    height: _heightDevice * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue[300],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'BMI (Body Mass Index)',
                              style: TextStyle(
                                fontFamily: 'Sen',
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              'You have a normal weight',
                              style: TextStyle(
                                fontFamily: 'Sen',
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            ),
                            InkWell(
                              child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                alignment: Alignment.center,
                                height: 30,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.purple.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Text(
                                  'View More',
                                  style: TextStyle(
                                    fontFamily: 'Sen',
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onTap: () {},
                            )
                          ],
                        ),
                        Container(
                          width: 120,
                          height: 120,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25, bottom: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 196, 215, 231),
                    ),
                    padding: const EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
                    height: _heightDevice * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Today Target',
                          style: TextStyle(
                              fontFamily: 'Sen',
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            height: 40,
                            width: 110,
                            decoration: BoxDecoration(
                              color: Colors.blue[500]!.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Text(
                              'Check',
                              style: TextStyle(
                                fontFamily: 'Sen',
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onTap: () {},
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Activity Status',
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 196, 215, 231),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
