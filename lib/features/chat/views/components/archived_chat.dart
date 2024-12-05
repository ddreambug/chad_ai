import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArchivedChat extends StatelessWidget {
  const ArchivedChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: MainColor.primary),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15).w,
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, idx) {
            return Text('archived chat');
          },
        ),
      ),
    );
  }
}
