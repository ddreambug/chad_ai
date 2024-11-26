import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:chad_ai/configs/themes/main_color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPress,
    this.platformIcon = '',
    required this.title,
    this.buttonHeight = 56,
    this.buttonWidth = 174,
    this.buttonColor = MainColor.buttonGrey,
  });

  final void Function() onPress;
  final String platformIcon;
  final String title;
  final double buttonHeight;
  final double buttonWidth;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight.w,
      width: buttonWidth.w,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            buttonColor,
          ),
        ),
        onPressed: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (platformIcon != '') ...{
              Image.asset(
                platformIcon,
                height: 22.w,
                width: 24.w,
              ),
            },
            SizedBox(width: 5.w),
            Text.rich(
              TextSpan(
                style: CustomTextStyle.w600.copyWith(
                  fontSize: 16.sp,
                  color: buttonColor == MainColor.buttonGrey
                      ? MainColor.black
                      : MainColor.white,
                ),
                text: title,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
