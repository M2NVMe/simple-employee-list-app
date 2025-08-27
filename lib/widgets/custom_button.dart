import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum ButtonType { elevated, outlined, text }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // Nullable
  final Color backgroundColor;
  final Color textColor;
  final double textSize;
  final FontWeight fontWeight; // Added for custom font weight
  final ButtonType buttonType;
  final double borderWidth;
  final Color borderColor;
  final double buttonWidth;
  final double buttonHeight;
  final double borderRadius;
  final Widget? prefixIcon; // Added for optional icons

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed, // Make this nullable
    required this.backgroundColor,
    required this.textColor,
    required this.textSize,
    this.fontWeight = FontWeight.normal, // Default font weight
    required this.buttonType,
    required this.borderWidth,
    required this.borderColor,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.borderRadius,
    this.prefixIcon, // Initialize as optional
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = buttonType == ButtonType.elevated
        ? ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      textStyle: GoogleFonts.inter(
        fontSize: textSize,
        fontWeight: fontWeight, // Use the custom font weight
      ),
    )
        : OutlinedButton.styleFrom(
      side: BorderSide(width: borderWidth, color: borderColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      textStyle: GoogleFonts.inter(
        fontSize: textSize,
        fontWeight: fontWeight, // Use the custom font weight
      ),
    );

    final Widget buttonChild = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null) ...[
          prefixIcon!,
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: GoogleFonts.inter(
            color: textColor,
            fontSize: textSize,
            fontWeight: fontWeight, // Use the custom font weight
          ),
        ),
      ],
    );

    return SizedBox(
      width: buttonWidth, // Use SizedBox to apply custom width
      height: buttonHeight, // Use SizedBox to apply custom height
      child: buttonType == ButtonType.elevated
          ? ElevatedButton(
        style: buttonStyle,
        onPressed: onPressed ?? () {}, // Provide a default function
        child: buttonChild,
      )
          : OutlinedButton(
        style: buttonStyle,
        onPressed: onPressed ?? () {}, // Provide a default function
        child: buttonChild,
      ),
    );
  }
}
