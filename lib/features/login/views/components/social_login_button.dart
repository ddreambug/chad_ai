import 'package:chad_ai/constants/cores/assets/image_constant.dart';
import 'package:chad_ai/features/login/controllers/login_controller.dart';
import 'package:chad_ai/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomButton(
          onPress: () async {
            var login = await LoginController.to.signInWithGoogle(context);
            print('google button triggered $login');
          },
          platformIcon: ImageConstant.icGoogle,
          title: 'Google',
        ),
        Spacer(),
        CustomButton(
          onPress: () async {
            var login = await LoginController.to.signInWithFacebook(context);
            print('google button triggered $login');
          },
          platformIcon: ImageConstant.icFacebook,
          title: 'Facebook',
        ),
      ],
    );
  }
}
