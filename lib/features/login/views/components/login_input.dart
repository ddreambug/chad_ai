import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:chad_ai/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginInput extends StatelessWidget {
  const LoginInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomTextField(
          iconifyIcon: MaterialSymbols.mail,
          hintText: 'Email',
        ),
        SizedBox(height: 10.h),
        CustomTextField(
          iconifyIcon: Majesticons.key,
          hintText: 'Password',
          needObscure: true,
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
            onPressed: () {},
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
    );
  }
}
