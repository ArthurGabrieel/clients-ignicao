import 'package:flutter/material.dart';

import '../../../features/auth/presentation/pages/authenticate.dart';
import '../../../features/clients/presentation/pages/home.dart';
import '../../../features/clients/presentation/pages/manage.dart';
import '../../../features/clients/presentation/pages/profile.dart';
import '../../../features/clients/presentation/pages/update.dart';

class Routes {
  static const String authenticate = '/';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String manage = '/manage';
  static const String update = '/update';

  static Map<String, Widget Function(BuildContext)> get routes => {
        authenticate: (context) => const AuthenticatePage(),
        home: (_) => const HomePage(),
        profile: (_) => const ProfilePage(),
        manage: (context) => const ManagePage(),
        update: (context) => const UpdatePage(),
      };
}
