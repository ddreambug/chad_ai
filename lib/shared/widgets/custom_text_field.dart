import 'package:chad_ai/configs/themes/main_color.dart';
import 'package:chad_ai/features/chat/controllers/chat_controller.dart';
import 'package:chad_ai/features/login/controllers/login_controller.dart';
import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.iconifyIcon = '',
    this.hintText = '',
    this.obscureType = '',
    required this.controller,
    this.validator,
    this.isProfileEdit = false,
    this.customHeight = 50,
    this.isArea = false,
  });

  final TextEditingController controller;
  final String iconifyIcon;
  final String hintText;
  final String obscureType;
  final FormFieldValidator<String>? validator;
  final bool isProfileEdit;
  final bool isArea;
  final int customHeight;

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void validate() {
    setState(() {
      _errorText = widget.validator!(widget.controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: widget.customHeight.h,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: _isFocused
                  ? MainColor.purple
                  : MainColor.textGrey.withAlpha(90),
            ),
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                if (widget.iconifyIcon != '') ...{
                  Iconify(
                    widget.iconifyIcon,
                    color: _isFocused ? MainColor.purple : MainColor.textGrey,
                    size: 28.w,
                  ),
                  SizedBox(width: 15.w),
                },
                Expanded(
                  child: Obx(
                    () {
                      var isObscure = widget.isProfileEdit
                          ? ChatController.to.obscureStates[widget.obscureType]
                          : LoginController
                              .to.obscureStates[widget.obscureType];

                      var pinLength = widget.isProfileEdit
                          ? null
                          : LoginController.to.pinLength.value;

                      return TextFormField(
                        controller: widget.controller,
                        maxLines: widget.isArea ? 3 : 1,
                        obscureText:
                            widget.obscureType != '' ? isObscure! : false,
                        validator: widget.validator,
                        keyboardType: widget.obscureType == 'pin'
                            ? TextInputType.phone
                            : widget.isArea
                                ? TextInputType.multiline
                                : TextInputType.text,
                        maxLength: widget.obscureType == 'pin' ? 4 : null,
                        focusNode: _focusNode,
                        style: CustomTextStyle.w500.copyWith(fontSize: 16.sp),
                        onChanged: (value) {
                          validate();
                          widget.obscureType == 'pin'
                              ? LoginController.to.pinLength.value =
                                  widget.controller.text.length
                              : null;
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          counterText: '',
                          suffixText: widget.obscureType == 'pin'
                              ? '$pinLength/4'
                              : null,
                          hintText: widget.hintText,
                          hintStyle: CustomTextStyle.w500.copyWith(
                            fontSize: 16.sp,
                            color: MainColor.textGrey,
                          ),
                          errorStyle: CustomTextStyle.w500.copyWith(
                            fontSize: 0.sp,
                            height: -1,
                          ),
                          border: InputBorder.none,
                        ),
                      );
                    },
                  ),
                ),
                if (widget.obscureType != '') ...{
                  Obx(
                    () {
                      var isObscure = widget.isProfileEdit
                          ? ChatController.to.obscureStates[widget.obscureType]
                          : LoginController
                              .to.obscureStates[widget.obscureType];

                      return GestureDetector(
                        onTap: () {
                          widget.isProfileEdit
                              ? ChatController.to
                                  .toggleObscure(widget.obscureType)
                              : LoginController.to
                                  .toggleObscure(widget.obscureType);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: Iconify(
                            isObscure ?? true ? Ri.eye_line : Ri.eye_off_line,
                            color: MainColor.purple,
                            size: 28.w,
                          ),
                        ),
                      );
                    },
                  ),
                },
              ],
            ),
          ),
        ),
        if (_errorText != null)
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Text(
              _errorText!,
              style: CustomTextStyle.w500.copyWith(
                fontSize: 12.sp,
                color: Colors.red,
              ),
            ),
          ),
      ],
    );
  }
}
