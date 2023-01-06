import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../responsive.dart';

class Margin extends StatelessWidget {
  const Margin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      color: grayColor,
      height: Responsive.returnSize(context, 5, 10, 20),
    );
  }
}
