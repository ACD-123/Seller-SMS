import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ElevetedButton extends StatelessWidget {
  ElevetedButton({
    Key? key,
    required this.buttonName,
    this.ontap,
    this.height = 50,
    this.width = double.maxFinite,
    this.fontSize = 18,
    this.color, // Single color
    this.gradientColors, // List of colors
    this.textColor = Colors.white, // Default text color
    this.borderColor, // Optional border color
    this.borderWidth = 0, // Optional border width (default to 0)
  }) : super(key: key);

  final String buttonName;
  final ontap;
  double? height, width, fontSize;
  Color? color; // Single colorp
  List<Color>? gradientColors; // List of colors
  Color textColor; // Text color
  Color? borderColor; // Optional border color
  double borderWidth; // Optional border width

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration;

    if (color != null) {
      // Use a single color
      decoration = BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: borderColor ??
              Colors.transparent, // Use borderColor or default to transparent
          width: borderWidth,
        ),
      );
    } else if (gradientColors != null) {
      // Use gradient colors
      decoration = BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors!,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: borderColor ??
              Colors.transparent, // Use borderColor or default to transparent
          width: borderWidth,
        ),
      );
    } else {
      
      decoration = BoxDecoration(
        color: Colors.white,
      
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: borderColor ??
              Colors.transparent,
          width: borderWidth,
        ),
      );
    }

    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: width,
        height: height,
        decoration: decoration,
        child: Center(
          child: Text(
            buttonName,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}