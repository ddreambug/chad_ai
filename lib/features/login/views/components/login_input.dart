import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/features/login/controllers/login_controller.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:chad_ai/shared/widgets/custom_text_field.dart';
import 'package:chad_ai/utils/enums/enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class LoginInput extends StatelessWidget {
  const LoginInput({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            iconifyIcon: MaterialSymbols.mail,
            controller: LoginController.to.emailController,
            hintText: 'Email',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an email';
              }
              if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                  .hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(height: 10.h),
          CustomTextField(
            iconifyIcon: Majesticons.key,
            controller: LoginController.to.passwordController,
            hintText: 'Password',
            obscureType: ObscureType.password.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              return null;
            },
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: GestureDetector(
              onTap: () {
                Get.toNamed('/sign-up');
                LoginController.to.pinLength.value = 0;
              },
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Don’t have an account? ',
                      style: CustomTextStyle.w500.copyWith(
                        color: MainColor.textGrey,
                        fontSize: 16.sp,
                      ),
                    ),
                    TextSpan(
                      text: 'Sign Up',
                      style: CustomTextStyle.w600.copyWith(
                        color: MainColor.textGrey,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30.h),
            height: 56.w,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  print('Form is valid!');
                  LoginController.to.signIn(
                    email: LoginController.to.emailController.text,
                    password: LoginController.to.passwordController.text,
                    context: context,
                  );
                } else {
                  print('Form is invalid!');
                  PanaraInfoDialog.show(
                    context,
                    message: 'Check Your Input',
                    buttonText: 'ok',
                    onTapDismiss: () {
                      Get.back();
                    },
                    panaraDialogType: PanaraDialogType.warning,
                  );
                }
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(MainColor.purple),
              ),
              child: Text(
                'Login',
                style: CustomTextStyle.w600.copyWith(fontSize: 18.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
