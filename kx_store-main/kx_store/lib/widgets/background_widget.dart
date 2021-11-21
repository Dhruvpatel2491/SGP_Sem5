import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('images/green.png',height:200 ,),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
SizedBox(width: 10,),
            Image.asset('images/blue.png',height: 200,),
          ],
        ),
      ],
    );
  }
}
