import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/features/chat/views/components/chat_widget.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatDetailView extends StatelessWidget {
  const ChatDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MainColor.primary,
        title: Text(
          'Chat Details',
          style: CustomTextStyle.w500.copyWith(fontSize: 22.sp),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            height: 1.0,
            color: Colors.grey,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: MainColor.primary),
        child: Center(
          child: ChatWidget(),
        ),
      ),
    );
  }
}
