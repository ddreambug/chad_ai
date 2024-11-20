import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/features/login/controllers/login_controller.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.iconifyIcon = '',
    this.hintText = '',
    this.obscureType = '',
    required this.controller,
    this.validator,
  });

  final TextEditingController controller;
  final String iconifyIcon;
  final String hintText;
  final String obscureType;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: MainColor.textGrey.withAlpha(90)),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          children: [
            Iconify(
              iconifyIcon,
              color: MainColor.textGrey,
              size: 28.w,
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Obx(
                () {
                  var isObscure = LoginController.to.obscureStates[obscureType];
                  var pinLength = LoginController.to.pinLength.value;

                  return TextFormField(
                    controller: controller,
                    obscureText: obscureType != '' ? isObscure! : false,
                    validator: validator,
                    maxLength: obscureType == 'pin' ? 4 : null,
                    style: CustomTextStyle.w500.copyWith(fontSize: 16.sp),
                    onChanged: (value) => obscureType == 'pin'
                        ? LoginController.to.pinLength.value =
                            controller.text.length
                        : null,
                    decoration: InputDecoration(
                      isDense: true,
                      counterText: '',
                      suffixText: obscureType == 'pin' ? '$pinLength/4' : null,
                      hintText: hintText,
                      hintStyle: CustomTextStyle.w500.copyWith(
                        fontSize: 16.sp,
                        color: MainColor.textGrey,
                      ),
                      errorStyle: CustomTextStyle.w500.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  );
                },
              ),
            ),
            if (obscureType != '') ...{
              Obx(
                () {
                  var isObscure = LoginController.to.obscureStates[obscureType];

                  return GestureDetector(
                    onTap: () {
                      LoginController.to.toggleObscure(obscureType);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: Iconify(
                        isObscure ?? true ? Ri.eye_line : Ri.eye_off_line,
                        color: MainColor.purple,
                        size: 28.w,
                      ),
                    ),
                  );
                },
              ),
            }
          ],
        ),
      ),
    );
  }
}
