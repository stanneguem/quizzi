import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quizzi/controllers/themecontroler.dart';
import 'package:quizzi/models/theme/appcolors.dart';
import 'package:quizzi/models/theme/clair.dart';

import '../../models/theme/sombre.dart';
import 'PLAYERSETUPSCREEN.dart';

class Homescreen extends StatelessWidget {
  final ThemeController themeController = Get.find<ThemeController>();
  Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeController.isDark.value ?  darkTheme.scaffoldBackgroundColor : lightTheme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 390,
            left: 120,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                  color: themeController.isDark.value ?  darkTheme.cardColor : lightTheme.cardColor,
                  shape: BoxShape.circle
              ),
            ),
          ),
          Positioned(
            top: 405,
            left: 80,
            child: Container(
              margin: EdgeInsets.only(left: 55),
              padding: EdgeInsets.all(35),
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                color: themeController.isDark.value ?  darkTheme.cardColor : lightTheme.cardColor,
              ),
              child: SvgPicture.asset("assets/images/sword-svgrepo-com (2).svg", color: Colors.white,),
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: Container(
              margin: EdgeInsets.only(left: 55),
              padding: EdgeInsets.all(15),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: themeController.isDark.value ?  darkTheme.cardColor : lightTheme.cardColor,
              ),
              child: SvgPicture.asset("assets/images/setting3-svgrepo-com.svg", color: Colors.white,),
            ),
          ),
          Positioned(
            top: 50,
            right: 80,
            child: Container(
              margin: EdgeInsets.only(left: 55),
              padding: EdgeInsets.all(15),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                color: themeController.isDark.value ?  darkTheme.cardColor : lightTheme.cardColor,
              ),
              child: SvgPicture.asset("assets/images/library.svg", color: Colors.white,),
            ),
          ),
          Positioned(
            top: 139,
            left: 40,
            child: Container(
              margin: EdgeInsets.only(left: 55),
              padding: EdgeInsets.all(5),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                color: themeController.isDark.value ?  darkTheme.scaffoldBackgroundColor : lightTheme.scaffoldBackgroundColor,
              ),
              child: SvgPicture.asset("assets/images/sword-svgrepo-com (3).svg", color: Colors.white,),
            ),
          ),
          Positioned(
            top: 135,
            right: 105,
            child: Container(
              margin: EdgeInsets.only(left: 55),
              padding: EdgeInsets.all(5),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                color: themeController.isDark.value ?  darkTheme.scaffoldBackgroundColor : lightTheme.scaffoldBackgroundColor,
              ),
              child: SvgPicture.asset("assets/images/sword-svgrepo-com (3).svg", color: Colors.white,),
            ),
          ),

          Positioned(
            bottom: 90,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 25),
              width: 350,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  boutonWidget("COMMENCER", Icons.play_circle, Colors.green, 200, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GameSetupPage(),));
                  },),
                ],
              ),
            ),
          ),
          Positioned(
              top: 140,
              left: 140,
          child: RichText(text: TextSpan(
            children: [
              TextSpan(text: "QUI",style: themeController.isDark.value ?  darkTheme.textTheme.titleLarge : lightTheme.textTheme.titleLarge,),
              TextSpan(text: "ZZI",style: themeController.isDark.value ?  darkTheme.textTheme.titleMedium : lightTheme.textTheme.titleMedium,)
            ]
          ))),
          Positioned(
              top: 210,
              left: 10,
              child: SizedBox(
                width: 390,
                  height: 200,
                  child: Text("Quizzi est un jeu de quiz amusant et interactif où tu peux tester ta culture générale, seul ou avec des amis, et transformer n’importe quelle soirée en un moment inoubliable",textAlign: TextAlign.center ,style: themeController.isDark.value ?  darkTheme.textTheme.bodyMedium : lightTheme.textTheme.bodyMedium,))),
        ],
      ),
    );
  }

  Widget boutonWidget(String titre, IconData icone, Color couleur, double size, Function() tap){
    return GestureDetector(
      onTap: tap,
      child: Container(
        width: size,
        height: 70,
        decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 0.9,
                  offset: Offset(1, 0.1),
                  spreadRadius: 1
              )
            ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(titre, style: themeController.isDark.value ?  darkTheme.textTheme.bodyLarge : lightTheme.textTheme.bodyLarge,)
          ],
        ),
      ),
    );
  }

}

