import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shoexpress/screens/shoe_screen/shoe_screen.dart';
import 'package:shoexpress/screens/widgets/ui_constants.dart';

import '../../config/app_colors.dart';
import '../../config/assets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double whiteCircleScale = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
            child: Stack(
          children: [
            Padding(
              padding: UIConstants.paddingHor10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UIConstants.gapHeight20,
                  const Text(
                    "ShoExpress",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Stencil"),
                  ),
                  UIConstants.gapHeight10,
                  const Text(
                    "Mens Shoe Collection",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Stencil"),
                  ),
                  const Spacer(),
                  Center(
                    child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(AppColors.secondary)),
                        onPressed: () async {
                          setState(() {
                            whiteCircleScale = 8;
                          });
                          await Future.delayed(const Duration(milliseconds: 500));
                          ShoeAnimationSection.scrollTimer.cancel();
                          if (mounted) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ShoeScreen(),
                            ));
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("Shop Now"),
                            UIConstants.gapWidth10,
                            Icon(Icons.play_arrow)
                          ],
                        )),
                  ),
                  UIConstants.gapHeight10,
                ],
              ),
            ),
            Transform.translate(
                offset: Offset(size.width / 2, 0), child: const ShoeAnimationSection()),
            Transform.translate(
              offset: Offset(size.width / 2, 0),
              child: Center(
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInExpo,
                  scale: whiteCircleScale,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: const BoxDecoration(
                        color: Colors.white, borderRadius: UIConstants.borderRadiusCirc),
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}

class ShoeAnimationSection extends StatefulWidget {
  const ShoeAnimationSection({
    super.key,
  });
  static late Timer scrollTimer;

  @override
  State<ShoeAnimationSection> createState() => _ShoeAnimationSectionState();
}

class _ShoeAnimationSectionState extends State<ShoeAnimationSection> {
  double turns = 1 / 2;
  int currentScaledIndex = Assets.homeScreenShoes.length - 3;

  void animateScroll() {}

  @override
  void initState() {
    super.initState();
    ShoeAnimationSection.scrollTimer = Timer(const Duration(seconds: 2), () {
      setState(() {
        turns += 1 / 8;

        if (currentScaledIndex == 0) {
          currentScaledIndex = Assets.homeScreenShoes.length - 1;
        } else {
          currentScaledIndex--;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      duration: const Duration(seconds: 1),
      turns: turns,
      child: Center(
        child: Transform.scale(
          scale: 1.8,
          child: Stack(
              alignment: Alignment.center,
              children: List.generate(
                Assets.homeScreenShoes.length,
                (index) => Transform.rotate(
                  angle: ((1 * pi) / Assets.homeScreenShoes.length) * (index + 1),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedScale(
                        duration: const Duration(seconds: 1),
                        scale: index == currentScaledIndex ? 1.5 : 0.8,
                        child: AnimatedRotation(
                          duration: const Duration(seconds: 1),
                          turns: -turns,
                          child: Transform.rotate(
                            angle: -((1 * pi) / Assets.homeScreenShoes.length) * (index + 1),
                            child: Image.asset(
                              Assets.homeScreenShoes[index],
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      const SizedBox(
                        height: 100,
                        width: 100,
                      ),
                      const SizedBox(height: 50),
                      AnimatedScale(
                        duration: const Duration(seconds: 1),
                        scale: index == currentScaledIndex ? 1.5 : 0.8,
                        child: AnimatedRotation(
                          duration: const Duration(seconds: 1),
                          turns: -turns,
                          child: Transform.rotate(
                            angle: -((1 * pi) / Assets.homeScreenShoes.length) * (index + 1),
                            child: Image.asset(
                              Assets.homeScreenShoes[index],
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
