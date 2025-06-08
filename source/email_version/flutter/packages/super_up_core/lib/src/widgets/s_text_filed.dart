import 'package:flutter/material.dart';
import 'package:super_up_core/super_up_core.dart';

class STextField extends StatelessWidget {
  final TextEditingController? controller;
  final String textHint;
  final String? labelText;
  final IconData? icon;
  final TextInputType? inputType;
  final bool obscureText;
  final bool autofocus;
  final int? maxLength;
  final int maxLines;
  final int? minLines;
  final bool autocorrect;
  final Widget? prefix;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  const STextField({
    super.key,
    required this.textHint,
    this.controller,
    this.labelText,
    this.icon,
    this.inputType,
    this.prefix,
    this.suffixIcon,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.onChanged,
    this.autofocus = false,
    this.autocorrect = true,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    // Define green theme color
    const Color primaryGreen = Color(0xFF4CAF50);

    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      obscureText: obscureText,
      maxLength: maxLength,
      maxLines: maxLines,
      minLines: minLines,
      autocorrect: autocorrect,
      autofocus: autofocus,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        hintText: textHint,
        labelText: labelText,
        prefixIcon: icon != null
            ? Icon(icon)
            : (prefix != null
                ? Container(
                    padding: const EdgeInsets.only(left: 5),
                    child: prefix,
                  )
                : null),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: context.isDark ? Colors.black26 : Colors.grey[400]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: primaryGreen,
            width: 2.0,
          ),
        ),
        filled: true,
        fillColor:
            context.isDark ? const Color(0xff363434) : Colors.grey.shade300,
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      ),
    );
  }
}
