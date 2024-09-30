import 'package:flutter/material.dart';

class NavigatorButton extends StatelessWidget {
  const NavigatorButton(
      {super.key,
      required this.buttonTitle,
      required this.onPressed,
      this.allPadding = 10});

  final String buttonTitle;
  final Function() onPressed;
  final double allPadding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(allPadding),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: onPressed,
            child: Text(
              buttonTitle,
              style: const TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}
