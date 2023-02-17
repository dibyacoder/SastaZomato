import 'package:ecomapp/widgets/general_font.dart';
import 'package:ecomapp/widgets/smallfont.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ecomapp/utils/dimensions.dart';

class expandable_text_widget extends StatefulWidget {
  final String text;
  const expandable_text_widget({super.key, required this.text});

  @override
  State<expandable_text_widget> createState() => _expandable_text_widgetState();
}

class _expandable_text_widgetState extends State<expandable_text_widget> {
  late String firsthalf;
  late String secondhalf;

  bool hidden_text = true;
  double textheight = dimensions.screenHeight / 5.63;

  @override
  void initState() {
    if (widget.text.length > textheight) {
      firsthalf = widget.text.substring(0, textheight.toInt());
      secondhalf =
          widget.text.substring(textheight.toInt() + 1, widget.text.length);
    } else {
      firsthalf = widget.text;
      secondhalf = "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: secondhalf.isEmpty
            ? small_font(text: firsthalf)
            : Column(
                children: [
                  small_font(
                    text: hidden_text
                        ? (firsthalf + "...")
                        : (firsthalf + secondhalf),
                    overflow: TextOverflow.clip,
                  ),
                  Material(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          hidden_text = !hidden_text;
                        });
                      },
                      child: Row(
                        children: [
                          small_font(
                            text: hidden_text ? "Show more" : "Show less",
                            color: Colors.teal,
                          ),
                          SizedBox(
                            width: dimensions.size10,
                          ),
                          Icon(
                            hidden_text
                                ? Icons.arrow_drop_down_sharp
                                : Icons.arrow_drop_up,
                            color: Colors.teal,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ));
  }
}
