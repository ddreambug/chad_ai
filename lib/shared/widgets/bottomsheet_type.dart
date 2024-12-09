import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:chad_ai/shared/widgets/custom_bottom_sheet.dart';
import 'package:chad_ai/shared/widgets/custom_text_buttom.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomsheetType {
  const BottomsheetType._();

  // Static method to return a list of reusable widgets
  static Widget allChat({
    required VoidCallback onArchive,
    required VoidCallback onDelete,
  }) {
    return CustomBottomSheet(
      title: 'Chat Settings',
      initSize: 0.45,
      widget: Column(
        children: [
          CustomTextButtom(
            title: 'Archive Chat',
            icon: Carbon.archive,
            ontap: onArchive,
          ),
          Divider(),
          CustomTextButtom(
            title: 'Delete Chat',
            icon: Carbon.trash_can,
            ontap: onDelete,
            color: MainColor.danger,
          ),
        ],
      ),
    );
  }

  static Widget archivedChat({
    required VoidCallback onDelete,
  }) {
    return CustomBottomSheet(
      title: 'Chat Settings',
      initSize: 0.35,
      widget: Column(
        children: [
          InkWell(
            onTap: onDelete,
            child: Row(
              children: [
                Text(
                  'Delete Chat',
                  style: CustomTextStyle.w500.copyWith(
                    color: MainColor.danger,
                  ),
                ),
                Spacer(),
                Iconify(
                  Carbon.trash_can,
                  size: 20.w,
                  color: MainColor.danger,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
