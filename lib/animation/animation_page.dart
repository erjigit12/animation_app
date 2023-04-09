// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({Key? key}) : super(key: key);

  @override
  _AnimationPageState createState() => _AnimationPageState();
}

bool isFullMode = false;
Duration duration = const Duration(seconds: 2);

class _AnimationPageState extends State<AnimationPage> {
  Future<void> changeMood(int value) async {
    await Future.delayed(duration);
    if (value == 0) {
      setState(() {
        isFullMode = true;
      });
    } else {
      setState(() {
        isFullMode = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await Future<void>.delayed(duration);
      },
    );
    changeMood(0);
  }

  @override
  Widget build(BuildContext context) {
    List<Color> lightBgColors = [
      const Color(0xFF8C2480),
      const Color(0xFFCE587D),
      const Color(0xFFFF9485),
    ];

    List<Color> darkBgColors = [
      const Color(0xFF0D1441),
      const Color(0xFF283584),
      const Color(0xFF376AB2),
    ];

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: AnimatedContainer(
        width: width,
        height: height,
        curve: Curves.easeInOut,
        duration: duration,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isFullMode ? lightBgColors : darkBgColors,
          ),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              left: 0,
              right: 0,
              bottom: isFullMode ? 370 : -170,
              duration: duration,
              child: SvgPicture.asset(
                'assets/sun.svg',
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: -45,
              child: Image.asset(
                'assets/land_tree_light.png',
                height: 430,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: width * 0.9,
              height: 60,
              margin: const EdgeInsets.fromLTRB(20, 60, 20, 0),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DefaultTabController(
                length: 2,
                child: TabBar(
                  onTap: (value) {
                    changeMood(value);
                  },
                  indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.white,
                  labelStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  tabs: const [
                    Tab(
                      text: 'Кун',
                    ),
                    Tab(
                      text: 'Тун  ',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
