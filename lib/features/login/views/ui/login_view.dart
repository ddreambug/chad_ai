import 'package:chad_ai/shared/styles/custom_text_style.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Titid'),
      ),
      body: const Column(
        children: [
          Text(
            'children 2',
            style: CustomTextStyle.w100,
          ),
        ],
      ),
    );
  }
}
