import 'package:akkelny3/public.dart';
import 'package:akkelny3/screens/auth_screen.dart';
import 'package:akkelny3/welcome_pages/welcome_page1-2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with SingleTickerProviderStateMixin {
  int currentPage = 0;

  AnimationController _animationController;
  Animation _colorTween;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _colorTween = ColorTween(begin: Colors.white, end: mainColor)
        .animate(_animationController);
    _animationController.forward();
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    List<WelcomePage> _pages = [
      WelcomePage("Enter Your Address", welcomePic1),
      WelcomePage("Select Food Items", welcomePic2),
      WelcomePage("Delivery To Your Home ", welcomePic3)
    ];
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            PageView(
              controller: pageController,
              children: _pages,
              onPageChanged: (int page) {
                if (page == currentPage) {
                  _animationController.reverse();
                } else {
                  _animationController.forward();
                }
                currentPage = page;
                setState(() {});
              },
            ),
            dotsIndicator(_pages),
          ],
        ),
        floatingActionButton: skipButton(_pages),
      ),
    );
  }

  Stack dotsIndicator(List<WelcomePage> _pages) {
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 35),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < _pages.length; i++)
                if (i == currentPage) ...[activePage(true)] else
                  activePage(false)
            ],
          ),
        )
      ],
    );
  }

  Visibility skipButton(List<WelcomePage> _pages) {
    return Visibility(
      visible: currentPage == _pages.length - 1 ? true : false,
      child: FloatingActionButton(
        onPressed: () => goToAuth(),
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(26))),
        child: Icon(Icons.arrow_forward),
      ),
    );
  }

  void goToAuth() {
    Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
    saveSkipIntro();
  }

  Future saveSkipIntro() async {
    final shared = await SharedPreferences.getInstance();
    await shared.setBool("intro", true);
  }

  Widget activePage(bool isActive) {
    return AnimatedBuilder(
      animation: _colorTween,
      builder: (context, _) => AnimatedContainer(
        duration: Duration(seconds: 1),
        margin: EdgeInsets.symmetric(horizontal: 4),
        width: isActive ? 20 : 15,
        height: isActive ? 20 : 15,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: isActive ? _colorTween.value : Colors.white,
            border: Border.all(width: .5)),
      ),
    );
  }
}
