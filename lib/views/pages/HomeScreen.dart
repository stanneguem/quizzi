import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'PLAYERSETUPSCREEN.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 150,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 35),
              padding: EdgeInsets.symmetric(vertical: 25),
              width: 340,
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.black, width: 0.1)
              ),
            ),
          ),
          Positioned(
            bottom: 190,
            left: 50,
            child: Container(
              margin: EdgeInsets.only(left: 55),
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle
              ),
            ),
          ),
          Positioned(
            bottom: 200,
            left: 60,
            child: Container(
              margin: EdgeInsets.only(left: 55),
              padding: EdgeInsets.all(35),
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle
              ),
              child: SvgPicture.asset(
                "assets/images/sword-svgrepo-com (2).svg",
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 120,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle
              ),
            ),
          ),
          Positioned(
            top: 80,
            left: 80,
            child: Container(
              margin: EdgeInsets.only(left: 55),
              padding: EdgeInsets.all(25),
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                color: Colors.green
              ),
              child: SvgPicture.asset("assets/images/sword-svgrepo-com (3).svg"),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  boutonWidget("Parametre", Icons.settings, Colors.green, 90, () {

                  },),
                  boutonWidget("Jouer", Icons.play_circle, Colors.green, 150, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GameSetupPage(),));
                  },),
                  boutonWidget("About", Icons.support_agent_outlined, Colors.green, 90, () {

                  },)
                ],
              ),
            ),
          ),
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
            color: couleur,
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
            Icon(icone),
            Text(titre)
          ],
        ),
      ),
    );
  }

}

