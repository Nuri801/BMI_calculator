import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  RoundIconButton(
      {required this.icon,
        required this.onPressed,
        required this.onLongPressed,
        required this.onTapUp,
        required this.onTapCancel,
      });

  final IconData icon;
  final void Function()? onPressed;
  final void Function(TapDownDetails)? onLongPressed;
  final void Function(TapUpDetails)? onTapUp;
  final void Function()? onTapCancel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF4C4F5E),
        ),
        width: 56,
        height: 56,
        child: Center(
          child: Icon(icon),
        ),
      ),
      onTap: onPressed,
      onTapDown: onLongPressed,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
    );
  }
}