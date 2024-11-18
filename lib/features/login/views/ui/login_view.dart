import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/features/login/views/components/login_divider.dart';
import 'package:chad_ai/features/login/views/components/login_header.dart';
import 'package:chad_ai/features/login/views/components/login_input.dart';
import 'package:chad_ai/features/login/views/components/social_login_button.dart';
import 'package:chad_ai/shared/widgets/app_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.primary,
      body: Padding(
        padding: EdgeInsets.fromLTRB(25.w, 80.w, 25.w, 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const LoginHeader(),
            SizedBox(height: 40.w),
            const LoginInput(),
            SizedBox(height: 30.w),
            const LoginDivider(),
            SizedBox(height: 30.w),
            const SocialLoginButton(),
            Spacer(),
            const AppInfo(),
          ],
        ),
      ),
    );
  }
}
