import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  final GestureTapCallback? onTap;

  const BackButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            "images/back.png"
          ),
        ),
      ),
    );
  }
}
