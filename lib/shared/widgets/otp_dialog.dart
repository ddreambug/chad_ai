import 'package:chad_ai/features/login/controllers/login_controller.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:chad_ai/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/features/sign_up/controllers/sign_up_controller.dart';

class OtpDialog extends StatelessWidget {
  const OtpDialog({
    super.key,
    this.isSignUp = false,
  });

  final bool isSignUp;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: isSignUp ? 350.w : 250.w,
          width: 330.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            color: MainColor.primary,
          ),
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 30).w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isSignUp ? 'OTP' : 'PIN',
                style: CustomTextStyle.w600.copyWith(
                  fontSize: 40.sp,
                  letterSpacing: -1,
                ),
              ),
              SizedBox(height: 10.h),
              Center(
                child: Pinput(
                  errorTextStyle: CustomTextStyle.w200.copyWith(
                    fontSize: 14.sp,
                    letterSpacing: 1,
                    color: MainColor.danger,
                  ),
                  defaultPinTheme: PinTheme(
                    height: 56.w,
                    width: 42.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(113, 187, 187, 187),
                      ),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  controller: isSignUp
                      ? SignUpController.to.otpTextController
                      : LoginController.to.pinController,
                  length: 4,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (isSignUp) {
                      if (value != SignUpController.to.otpValue.value) {
                        SignUpController.to.otpTextController.clear();
                        return "Wrong OTP Code!";
                      } else {
                        return null;
                      }
                    } else {
                      if (value != null &&
                          int.parse(value) != LoginController.to.userPin) {
                        LoginController.to.pinController.clear();
                        return 'Wrong Pin';
                      } else {
                        return null;
                      }
                    }
                  },
                  onCompleted: (value) {
                    if (isSignUp) {
                      SignUpController.to.onOtpComplete(context, value);
                    } else {
                      if (int.parse(value) == LoginController.to.userPin) {
                        LoginController.to.onPinValid();
                      }
                    }
                  },
                ),
              ),
              SizedBox(height: 15.h),
              if (isSignUp) ...{
                Obx(
                  () {
                    var email = SignUpController.to.emailValue.value;
                    return RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                'Check the OTP (one time password) to confirm your authenticity in ',
                            style: CustomTextStyle.w500.copyWith(
                              color: MainColor.black,
                              fontSize: 14.sp,
                            ),
                          ),
                          TextSpan(
                            text: email,
                            style: CustomTextStyle.w600.copyWith(
                              color: MainColor.black,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    CustomButton(
                      onPress: () {
                        Get.back();
                      },
                      title: 'Cancel'.tr,
                      buttonWidth: 142,
                    ),
                    Spacer(),
                    CustomButton(
                      onPress: () {
                        SignUpController.to.sendEmailOtp();
                      },
                      title: 'Resend',
                      buttonWidth: 142,
                      buttonColor: MainColor.black,
                    ),
                  ],
                )
              }
            ],
          ),
        ),
      ),
    );
  }
}
