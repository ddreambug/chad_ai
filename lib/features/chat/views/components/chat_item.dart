import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.text,
    required this.isFromUser,
  });
  final String text;
  final bool isFromUser;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 350).w,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.5.r,
                color: MainColor.borderStroke,
              ),
              color: isFromUser
                  ? const Color.fromARGB(30, 98, 42, 116)
                  : const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.r),
                topRight: Radius.circular(40.r),
                bottomRight:
                    isFromUser ? Radius.circular(0.r) : Radius.circular(40.r),
                bottomLeft:
                    isFromUser ? Radius.circular(40.r) : Radius.circular(0.r),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 30,
            ).w,
            margin: const EdgeInsets.only(
              bottom: 15,
              left: 10,
              right: 10,
            ).w,
            child: MarkdownBody(
              data: text,
              styleSheet: MarkdownStyleSheet.fromTheme(
                ThemeData(
                  textTheme: TextTheme(
                    bodyMedium: CustomTextStyle.w400.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
