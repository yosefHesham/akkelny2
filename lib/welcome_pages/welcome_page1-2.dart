import 'package:akkelny3/public.dart';
import 'package:flutter/material.dart';
import 'package:shape_of_view/shape_of_view.dart';

class WelcomePage extends StatelessWidget {
  final String mainText;
  final String welcomePic;
  WelcomePage(this.mainText, this.welcomePic);
  @override
  Widget build(BuildContext context) {
    var responsive = MediaQuery.of(context).size;
    return Column(
      children: [
        arcBuilder(responsive),
        SizedBox(
          height: 20,
        ),
        Text(
          mainText,
          style: TextStyle(
              color: mainColor, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        textWelcome(),
      ],
    );
  }

  Widget arcBuilder(Size responsive) {
    return ShapeOfView(
      clipBehavior: Clip.hardEdge,
      shape: ArcShape(
          height: 40,
          direction: ArcDirection.Outside,
          position: ArcPosition.Bottom),
      child: Container(
        height: responsive.height * .5,
        width: double.infinity,
        child: Align(
          child: Image.asset(
            this.welcomePic,
            width: responsive.width * .7,
          ),
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [firstColor, secondColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
      ),
    );
  }

  Widget textWelcome() {
    return Container(
      child: Text(
        welcomeText,
        textAlign: TextAlign.center,
        style: TextStyle(color: Color(0xf5b5858).withOpacity(1), fontSize: 20),
        softWrap: true,
      ),
    );
  }
}
