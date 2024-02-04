import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/clients/presentation/bloc/clients_bloc.dart';
import 'shared/config/routes/routes.dart';
import 'shared/config/theme/app_theme.dart';

class IgnicaoApp extends StatelessWidget {
  const IgnicaoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
        BlocProvider<ClientsBloc>(create: (_) => ClientsBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routes: Routes.routes,
      ),
    );
  }
}
