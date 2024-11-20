import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/features/login/controllers/login_controller.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:chad_ai/shared/widgets/custom_text_field.dart';
import 'package:chad_ai/utils/enums/enum.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginInput extends StatelessWidget {
  const LoginInput({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
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
            padding: EdgeInsets.only(right: 20.w),
            child: GestureDetector(
              onTap: () {
                print('Lupapassword');
              },
              child: Text(
                'Forgot Password?',
                style: CustomTextStyle.w600.copyWith(
                  fontSize: 16.sp,
                  color: MainColor.purple,
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
                } else {
                  print('Form is invalid!');
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
