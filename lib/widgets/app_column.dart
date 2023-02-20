// ignore_for_file: prefer_const_constructors

import 'package:ecomapp/widgets/smallfont.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'general_font.dart';
import 'icons_and_text.dart';

class app_column extends StatelessWidget {
  final String text;
  const app_column({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        // ignore: prefer_const_constructors
        general_font(text: text),
        SizedBox(height: 20),
        Row(
          children: [
            Wrap(
                children: List.generate(
                    5,
                    (index) => Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 89, 50, 50),
                          size: 15,
                        ))),
            SizedBox(width: 15),
            small_font(text: "4.7"),
            SizedBox(width: 15),
            small_font(text: "879 Reviews")
          ],
        ),
        SizedBox(height: 10),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              icons_and_text(
                  icon: Icons.circle,
                  text: "Nice",
                  color: Colors.black,
                  iconcolor: Color.fromARGB(255, 80, 18, 173)),
              icons_and_text(
                  icon: Icons.location_pin,
                  text: "1.8 km",
                  color: Colors.black,
                  iconcolor: Color.fromARGB(255, 89, 50, 50)),
              icons_and_text(
                  icon: Icons.access_time_rounded,
                  text: "28 Mins",
                  color: Colors.black,
                  iconcolor: Color.fromARGB(255, 14, 14, 91)),
            ])
      ],
    );
  }
}
