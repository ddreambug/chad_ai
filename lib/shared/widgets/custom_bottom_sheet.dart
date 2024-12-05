import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    this.title = '',
    required this.widget,
    this.initSize = 0.55,
  });

  final String title;
  final Widget widget;
  final double initSize;
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.2,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: MainColor.primary,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 66, 66, 66),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(20.r),
                      ),
                    ),
                    width: 50,
                    height: 25.w,
                  ),
                  // Drag Handle
                  Padding(
                    padding: const EdgeInsets.only(top: 8).w,
                    child: Container(
                      width: 50.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: MainColor.primary,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                ],
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      SizedBox(height: 15.w),
                      if (title != '')
                        Text(
                          title,
                          style: CustomTextStyle.w500,
                        ),
                      Padding(
                        padding: EdgeInsets.all(30.r),
                        child: widget,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
