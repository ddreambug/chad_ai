import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/features/login/controllers/login_controller.dart';
import 'package:chad_ai/features/login/views/components/otp_dialog.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:chad_ai/shared/widgets/custom_button.dart';
import 'package:chad_ai/shared/widgets/custom_text_field.dart';
import 'package:chad_ai/utils/enums/enum.dart';
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
    final formKey = GlobalKey<FormState>();

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
          child: Form(
            key: formKey,
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
                  controller: LoginController.to.usernameController,
                  iconifyIcon: IconParkSolid.people,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.w),
                CustomTextField(
                  hintText: 'Email',
                  controller: LoginController.to.emailController,
                  iconifyIcon: MaterialSymbols.mail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    if (!RegExp(
                            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.w),
                CustomTextField(
                  hintText: 'Password',
                  controller: LoginController.to.passwordController,
                  iconifyIcon: Majesticons.key,
                  obscureType: ObscureType.password.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.w),
                CustomTextField(
                  hintText: 'Re-type Password',
                  controller: LoginController.to.rePasswordController,
                  iconifyIcon: Majesticons.key,
                  obscureType: ObscureType.rePassword.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please retype password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.w),
                CustomTextField(
                  hintText: 'PIN',
                  controller: LoginController.to.pinController,
                  iconifyIcon: Majesticons.key,
                  obscureType: ObscureType.pin.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter PIN';
                    }
                    return null;
                  },
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
                        if (formKey.currentState?.validate() ?? false) {
                          print('Sign Up form is valid!');
                          Get.dialog(OtpDialog());
                        } else {
                          print('Sign Up form is invalid!');
                        }
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
      ),
    );
  }
}