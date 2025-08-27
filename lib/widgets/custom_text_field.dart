import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final Color hintTextColor;
  final Color borderColor;
  final Function(String) onChanged;
  final TextEditingController? controller;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double width;
  final double height; // Custom height
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines; // Minimum lines to ensure proper height when empty
  final bool readOnly;
  final VoidCallback? onTap;
  final TextAlign textAlign; // Horizontal alignment
  final TextAlignVertical? textAlignVertical; // Vertical alignment
  final EdgeInsetsGeometry? contentPadding; // Padding parameter

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.obscureText = false,
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    this.textColor = Colors.black87,
    this.hintTextColor = Colors.grey,
    this.borderColor = Colors.grey,
    required this.onChanged,
    this.controller,
    this.borderRadius = 30,
    this.margin = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.width = double.infinity,
    this.height = 50.0, // Default height
    this.keyboardType,
    this.maxLines = 1, // Set to the same value as minLines for fixed height
    this.minLines = 1, // Minimum lines to control height
    this.readOnly = false,
    this.onTap,
    this.textAlign = TextAlign.start, // Horizontal alignment (default: start)
    this.textAlignVertical = TextAlignVertical.center, // Vertical alignment (default: center)
    this.contentPadding, // Accept the padding parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width, // Custom width
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: GoogleFonts.inter(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor,
        ),
        onChanged: onChanged,
        keyboardType: keyboardType,
        maxLines: maxLines ?? minLines, // Fix the height by setting maxLines to minLines
        minLines: minLines ?? (height / 40).toInt(), // Minimum lines to ensure height
        readOnly: readOnly,
        onTap: onTap,
        textAlign: textAlign, // Horizontal text alignment
        textAlignVertical: textAlignVertical, // Vertical text alignment
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          labelStyle: GoogleFonts.inter(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: hintTextColor,
          ),
          hintStyle: GoogleFonts.inter(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: hintTextColor,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: contentPadding ?? EdgeInsets.symmetric(
            horizontal: 20,
            vertical: (height - 20) / 2, // Adjust vertical padding based on height
          ), // Use provided contentPadding or fallback to default padding
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor, width: 1),
          ),
        ),
      ),
    );
  }
}
