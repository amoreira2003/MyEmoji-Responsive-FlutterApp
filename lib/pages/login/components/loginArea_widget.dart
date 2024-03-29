import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../responsive.dart';
import 'login_elements.dart';

class LogInArea extends StatelessWidget {
  const LogInArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Expanded(
      flex: 4,
      child: Container(
        width: width,
        decoration: const BoxDecoration(
          color: grayColor,
        ),
        child: Center(
            child: Container(
          width: Responsive.returnSize(context, 400, 550, 700),
          height: Responsive.returnSize(context, 500, 550, 700),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 4),
                    spreadRadius: 1,
                    blurRadius: 4,
                    color: Color.fromARGB(25, 0, 0, 0))
              ]),
          child: const LogInAreaElements(),
        )),
      ),
    );
  }
}
