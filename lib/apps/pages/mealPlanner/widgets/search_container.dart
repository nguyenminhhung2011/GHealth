import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../template/misc/colors.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    Key? key,
    required double widthDevice,
    required this.controller,
    required this.onTextChange,
  })  : _widthDevice = widthDevice,
        super(key: key);

  final double _widthDevice;
  final TextEditingController controller;
  final Function(String) onTextChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _widthDevice,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            offset: const Offset(2, 3),
            blurRadius: 20,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            offset: const Offset(-2, -3),
            blurRadius: 20,
          )
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/Search.svg',
            color: Colors.grey,
          ),
          const SizedBox(width: 5),
          SizedBox(
            width: _widthDevice - 150,
            //color: Colors.red,
            child: TextFormField(
              controller: controller,
              onChanged: onTextChange,
              decoration: const InputDecoration(
                hintText: 'Search Pancake',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/Filter.svg',
                color: AppColors.primaryColor1,
              ),
            ),
          )
        ],
      ),
    );
  }
}
