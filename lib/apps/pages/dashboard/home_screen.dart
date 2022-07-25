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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 126, 183, 229),
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
