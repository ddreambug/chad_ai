import 'dart:developer';

import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/features/sign_up/controllers/sign_up_controller.dart';
import 'package:chad_ai/features/sign_up/views/components/otp_dialog.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:chad_ai/shared/widgets/app_info.dart';
import 'package:chad_ai/shared/widgets/custom_button.dart';
import 'package:chad_ai/shared/widgets/custom_text_field.dart';
import 'package:chad_ai/utils/enums/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/icon_park_solid.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: MainColor.primary,
      //   title: Text(
      //     'Sign Up',
      //     style: CustomTextStyle.w500.copyWith(fontSize: 22.sp),
      //   ),
      //   bottom: PreferredSize(
      //     preferredSize: Size.fromHeight(1.0),
      //     child: Divider(
      //       height: 1.0,
      //       color: Colors.grey,
      //     ),
      //   ),
      // ),
      body: Container(
        decoration: BoxDecoration(
          color: MainColor.primary,
        ),
        padding: const EdgeInsets.fromLTRB(20, 80, 20, 35).w,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Iconify(MaterialSymbols.arrow_back_ios_rounded),
                  ),
                  Text(
                    'Sign Up',
                    style: CustomTextStyle.w600.copyWith(
                      fontSize: 40.sp,
                      letterSpacing: -1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.w),
              Text(
                'Fill the form below to sign up!',
                style: CustomTextStyle.w400.copyWith(
                  fontSize: 16.sp,
                  color: MainColor.textGrey,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 10.w),
              CustomTextField(
                hintText: 'Name',
                controller: SignUpController.to.usernameController,
                iconifyIcon: IconParkSolid.people,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.w),
              CustomTextField(
                hintText: 'Email',
                controller: SignUpController.to.emailController,
                iconifyIcon: MaterialSymbols.mail,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!RegExp(
                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                  ).hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.w),
              CustomTextField(
                hintText: 'Password',
                controller: SignUpController.to.passwordController,
                iconifyIcon: Majesticons.key,
                obscureType: ObscureType.password.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  } else if (value.length < 8) {
                    return 'Must be at least 8 character';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.w),
              CustomTextField(
                hintText: 'Re-type Password',
                controller: SignUpController.to.rePasswordController,
                iconifyIcon: Majesticons.key,
                obscureType: ObscureType.rePassword.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please retype password';
                  } else if (value !=
                      SignUpController.to.passwordController.text) {
                    return 'Password didnt match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.w),
              CustomTextField(
                hintText: 'PIN',
                controller: SignUpController.to.pinController,
                iconifyIcon: Majesticons.key,
                obscureType: ObscureType.pin.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter PIN';
                  } else if (!RegExp(r"^\d{4}$").hasMatch(value) ||
                      value.length != 4) {
                    return 'PIN must be a 4-digit number';
                  }

                  return null;
                },
              ),
              SizedBox(height: 25.w),
              CustomButton(
                onPress: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    log('Sign Up form is valid!');
                    await SignUpController.to.sendEmailOtp();

                    Get.dialog(OtpDialog());
                  } else {
                    log('Sign Up form is invalid!');
                    PanaraInfoDialog.show(context,
                        message: 'Please recheck your input',
                        buttonText: 'Ok', onTapDismiss: () {
                      Get.back();
                    }, panaraDialogType: PanaraDialogType.warning);
                  }
                },
                title: 'Sign Up',
                buttonWidth: double.infinity,
                buttonColor: MainColor.black,
              ),
              Spacer(),
              Center(
                child: AppInfo(showVersion: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
