import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final String hintText;
  final Function(String)? onChanged;
  final bool? passwordTextField;
  final TextInputType? keyboardType;
  final Border? border;
  const CustomTextField({
    super.key,
    this.labelText,
    required this.hintText,
    this.passwordTextField = false,
    this.onChanged,
    this.keyboardType,
    this.border,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hideText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: widget.border ?? Border.all(color: Colors.black, width: 0.5),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: TextField(
        onChanged: widget.onChanged,
        obscureText: widget.passwordTextField! ? hideText : false,
        keyboardType: widget.keyboardType,
        cursorColor: const Color(0xffcc6a96),
        decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.labelText,
          suffix: widget.passwordTextField!
              ? GestureDetector(
                  onTap: () {
                    hideText = !hideText;
                    setState(() {});
                  },
                  child: Icon(
                    hideText ? Icons.visibility : Icons.visibility_off,
                  ),
                )
              : null,
          labelStyle: const TextStyle(
            color: Color(0xffcc6a96),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
