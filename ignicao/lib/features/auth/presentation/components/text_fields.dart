import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../../shared/config/theme/app_colors.dart';
import '../../../../shared/utils/build_text_field.dart';

class TextFields extends StatelessWidget {
  const TextFields({
    super.key,
    required this.nameTextController,
    required this.emailTextController,
    required this.passwordTextController,
    required this.isLogin,
  });

  final TextEditingController nameTextController;
  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 1400),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 20,
                offset: Offset(0, 10))
          ],
        ),
        child: Form(
          child: Column(
            children: <Widget>[
              AnimatedSize(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                child: !isLogin
                    ? buildTextField(nameTextController, 'Nome', false)
                    : const SizedBox.shrink(),
              ),
              buildTextField(emailTextController, 'Email', false),
              buildTextField(passwordTextController, 'Senha', true),
            ],
          ),
        ),
      ),
    );
  }
}
