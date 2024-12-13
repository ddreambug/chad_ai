import 'package:chad_ai/features/chat/controllers/chat_controller.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomTextRadio extends StatelessWidget {
  const CustomTextRadio({
    super.key,
    required this.title,
    required this.radioValue,
    required this.onChanged,
    this.svgImage = '',
  });

  final String svgImage;
  final String title;
  final int radioValue;
  final Function(int?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (onChanged != null) {
            onChanged!(radioValue);
          }
        },
        child: Container(
          constraints: BoxConstraints(maxHeight: 40.w),
          child: Row(
            children: [
              if (svgImage != '') ...{
                SvgPicture.asset(
                  svgImage,
                  width: 35.w,
                )
              },
              SizedBox(width: 10.w),
              Text(
                title,
                style: CustomTextStyle.w500.copyWith(fontSize: 20.sp),
              ),
              Spacer(),
              Transform.scale(
                scale: 0.6,
                child: Obx(() {
                  var groupValue = ChatController.to.languageRadioValue.value;
                  return Radio<int>(
                    value: radioValue,
                    groupValue: groupValue,
                    onChanged: (_) {},
                    activeColor: Colors.black,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
