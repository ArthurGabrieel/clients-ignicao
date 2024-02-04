import 'package:flutter/material.dart';

import 'app_widget.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  runApp(const IgnicaoApp());
}
