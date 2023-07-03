import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shoexpress/config/app_colors.dart';
import 'package:shoexpress/screens/home_screen/home_screen.dart';
import 'package:shoexpress/screens/widgets/ui_constants.dart';

import '../../config/assets.dart';

class ShoeScreen extends StatelessWidget {
  const ShoeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false,
        );
        return Future(() => true);
      },
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: const [
                  _ShoeBG(),
                  _ShoePicture(),
                ],
              ),
              UIConstants.gapHeight20,
              Text(
                "Popular Right Now",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const _CatergoeriesSection(),
              const _ListSection()
            ],
          ),
        )),
      ),
    );
  }
}

class _ListSection extends StatefulWidget {
  const _ListSection();

  @override
  State<_ListSection> createState() => _ListSectionState();
}

class _ListSectionState extends State<_ListSection> {
  // int count = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Timer.periodic(Duration(milliseconds: 100), (timer) {
    //   if (count == Assets.homeScreenShoes.length - 1) {
    //     timer.cancel();
    //   } else {
    //     count++;
    //     log(count.toString());
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Column(
        children: List.generate(
          Assets.homeScreenShoes.length,
          (int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 500),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: ListTile(
                    leading: Image.asset(
                      Assets.homeScreenShoes[index],
                    ),
                    title: Text("Shoe Name $index"),
                    subtitle: const Text("Price: 1200Rs"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.favorite),
                        UIConstants.gapWidth10,
                        Icon(Icons.add_shopping_cart),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ShoeBG extends StatefulWidget {
  const _ShoeBG();

  @override
  State<_ShoeBG> createState() => _ShoeBGState();
}

class _ShoeBGState extends State<_ShoeBG> {
  Duration animDuration = const Duration(milliseconds: 200);
  double pos = 500;

  @override
  void initState() {
    super.initState();
    Future.delayed(animDuration).then(
      (value) => setState(() {
        pos = 0;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AnimatedPositioned(
      duration: animDuration,
      top: -pos,
      bottom: pos,
      child: Container(
        width: size.width,
        height: size.height / 2,
        decoration: const BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(50))),
      ),
    );
  }
}

class _ShoePicture extends StatefulWidget {
  const _ShoePicture();

  @override
  State<_ShoePicture> createState() => _ShoePictureState();
}

class _ShoePictureState extends State<_ShoePicture> {
  Duration animDuration = const Duration(milliseconds: 400);
  double pos = 500;
  double shadowScale = 4;
  double shadowOp = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(animDuration).then(
      (value) => setState(() {
        pos = 0;
        shadowScale = 1;
        shadowOp = 1;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height / 2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedOpacity(
            curve: accelerateEasing,
            duration: animDuration,
            opacity: shadowOp,
            child: AnimatedScale(
              duration: animDuration,
              curve: accelerateEasing,
              scale: shadowScale,
              child: Transform.translate(
                offset: const Offset(10, 20),
                child: Transform.scale(
                  scale: 1.1,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Image.asset(
                      Assets.shoeSample,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: animDuration,
            curve: accelerateEasing,
            top: -pos,
            bottom: pos,
            child: Image.asset(
              Assets.shoeSample,
            ),
          )
        ],
      ),
    );
  }
}

class _CatergoeriesSection extends StatelessWidget {
  const _CatergoeriesSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        ChoiceChip(
            elevation: 10, disabledColor: Colors.white, label: Text('Sneakers'), selected: false),
        ChoiceChip(
            elevation: 10,
            disabledColor: Colors.white,
            label: Text('Sport Shoes'),
            selected: false),
        ChoiceChip(
            elevation: 10, disabledColor: Colors.white, label: Text('Oxford'), selected: false),
        ChoiceChip(elevation: 10, disabledColor: Colors.white, label: Text('Sale'), selected: false)
      ],
    );
  }
}
