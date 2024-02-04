import 'package:flutter/material.dart';

Widget buildTextField(
    TextEditingController controller, String hint, bool obscureText) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
    ),
    child: TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 20),
        border: InputBorder.none,
      ),
      style: const TextStyle(color: Colors.black, fontSize: 18),
      onChanged: (value) {
        if (controller.text != value) {
          controller.text = value;
        }
      },
    ),
  );
}
