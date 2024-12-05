import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextButtom extends StatelessWidget {
  const CustomTextButtom({
    super.key,
    required this.title,
    required this.icon,
    required this.ontap,
    this.color = MainColor.black,
  });

  final String icon;
  final String title;
  final VoidCallback ontap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MainColor.primary,
      child: InkWell(
        onTap: ontap,
        child: SizedBox(
          height: 40,
          child: Row(
            children: [
              Text(
                title,
                style: CustomTextStyle.w500.copyWith(color: color),
              ),
              Spacer(),
              Iconify(
                icon,
                size: 20.w,
                color: color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
