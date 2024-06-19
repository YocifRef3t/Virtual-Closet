import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool? isLoading;
  final BoxBorder? border;
  final Color? backgroundColor;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.border,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading! ? null : onPressed,
      child: Container(
        width: double.maxFinite,
        height: 50,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor ?? const Color(0xffc10776),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isLoading!
                  ? const SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : const SizedBox(),
              SizedBox(width: isLoading! ? 16 : 0),
              Text(
                text,
                style: TextStyle(
                  color: isLoading!
                      ? Colors.grey
                      : border != null
                          ? Colors.black
                          : Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
