import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class defultbutton extends StatelessWidget {
  const defultbutton(
      {super.key,
      required this.text,
      required this.press,
      required this.color});
  final String? text;
  final Function press;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: press as void Function()?,
        child: Container(
          margin: EdgeInsets.all(15),
          width: 150,
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border:
                Border.all(color: Color.fromARGB(255, 0, 157, 255), width: 1.5),
          ),
          child: Center(
            child: Text(text!,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(fontSize: 15)),
          ),
        ),
      ),
    );
  }
}
