import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/features/login/views/components/otp_dialog.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:chad_ai/shared/widgets/custom_button.dart';
import 'package:chad_ai/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/icons/icon_park_solid.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';

class SignUpDialog extends StatelessWidget {
  const SignUpDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: 520.h,
          width: 350.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            color: MainColor.primary,
          ),
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 35).w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign Up',
                style: CustomTextStyle.w600.copyWith(
                  fontSize: 40.sp,
                  letterSpacing: -1,
                ),
              ),
              SizedBox(height: 25.w),
              CustomTextField(
                hintText: 'Username',
                iconifyIcon: IconParkSolid.people,
              ),
              SizedBox(height: 10.w),
              CustomTextField(
                hintText: 'Email',
                iconifyIcon: MaterialSymbols.mail,
              ),
              SizedBox(height: 10.w),
              CustomTextField(
                hintText: 'Password',
                iconifyIcon: Majesticons.key,
                needObscure: true,
              ),
              SizedBox(height: 10.w),
              CustomTextField(
                hintText: 'Re-type Password',
                iconifyIcon: Majesticons.key,
                needObscure: true,
              ),
              SizedBox(height: 10.w),
              CustomTextField(
                hintText: 'PIN',
                iconifyIcon: Majesticons.key,
                needObscure: true,
              ),
              SizedBox(height: 25.w),
              Row(
                children: [
                  CustomButton(
                    onPress: () {
                      Get.back();
                    },
                    title: 'No',
                    buttonWidth: 142,
                  ),
                  Spacer(),
                  CustomButton(
                    onPress: () {
                      Get.dialog(OtpDialog());
                    },
                    title: 'Yes',
                    buttonWidth: 142,
                    buttonColor: MainColor.black,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
