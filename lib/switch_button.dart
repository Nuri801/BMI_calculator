import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  SwitchButton({
    Key? key,
    required this.onTap,
    required this.unit,
  }) : super(key: key);

  final void Function()? onTap;
  final String unit;
  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      width: 55,
      child: TextButton(
        style: ButtonStyle(
          // foregroundColor: MaterialStateProperty.all(kActiveCardColor),
            backgroundColor: MaterialStateProperty.all(Color(0xFF4C4F5E)),
            overlayColor: MaterialStateProperty.all(Color(0xFF4C4F5E)),
            elevation: MaterialStateProperty.all(6)
        ),
        child: Text(
          widget.unit,
          style: TextStyle(
            // color: kBottomContainerColor,
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: widget.onTap,
      ),
    );
  }
}
