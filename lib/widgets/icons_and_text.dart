import 'package:ecomapp/widgets/smallfont.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class icons_and_text extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Color iconcolor;

  const icons_and_text(
      {super.key,
      required this.icon,
      required this.text,
      required this.color,
      required this.iconcolor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconcolor),
        SizedBox(width: 2),
        small_font(text: text, color: color)
      ],
    );
  }
}
