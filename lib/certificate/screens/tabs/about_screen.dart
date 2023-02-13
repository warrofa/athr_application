import 'package:flutter/material.dart';

import '../utils/Widgets.dart';
import '../views/my_text.dart';

class AboutScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Column(
          children: [

            MyText(
              "",
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w600,

            ),
            verticalSpace15,
             verticalSpace15,
          ],
        ));
  }
}
