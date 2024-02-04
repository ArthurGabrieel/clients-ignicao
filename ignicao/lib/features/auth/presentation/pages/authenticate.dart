import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared/config/routes/routes.dart';
import '../../../clients/domain/dto/register_dto.dart';
import '../../data/dto/login_dto.dart';
import '../bloc/auth_bloc.dart';
import '../components/header.dart';
import '../components/text_fields.dart';

class AuthenticatePage extends StatefulWidget {
  const AuthenticatePage({super.key});

  @override
  State<AuthenticatePage> createState() => _AuthenticatePageState();
}

class _AuthenticatePageState extends State<AuthenticatePage> {
  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isAllInputsFilled(bool isLogin) {
      bool valid = true;

      if (!isLogin) {
        if (nameTextController.text.isEmpty) {
          valid = false;
        }
      } else if (emailTextController.text.isEmpty) {
        valid = false;
      } else if (passwordTextController.text.isEmpty) {
        valid = false;
      }

      if (!valid) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor, preencha todos os campos!'),
            backgroundColor: Colors.red,
          ),
        );
      }

      return valid;
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.orange.shade900,
            Colors.orange.shade800,
            Colors.orange.shade400
          ]),
        ),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            bool isLogin = true;

            if (state is Logging) {
              isLogin = true;
            }

            if (state is Registering) {
              isLogin = false;
            }

            if (state is Error) {
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              });
            }

            if (state is Logged) {
              Future.delayed(Duration.zero, () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('email', emailTextController.text);
                if (mounted) {
                  Navigator.of(context).pushReplacementNamed(Routes.home);
                }
              });
            }

            if (state is Registered) {
              isLogin = true;
              Future.delayed(Duration.zero, () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cadastro realizado com sucesso!'),
                    backgroundColor: Colors.green,
                  ),
                );
              });
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 80),
                Header(isLogin: isLogin),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 60),
                            TextFields(
                              nameTextController: nameTextController,
                              emailTextController: emailTextController,
                              passwordTextController: passwordTextController,
                              isLogin: isLogin,
                            ),
                            const SizedBox(height: 60),
                            FadeInUp(
                                duration: const Duration(milliseconds: 1600),
                                child: MaterialButton(
                                  onPressed: () {
                                    if (!isAllInputsFilled(isLogin)) {
                                      return;
                                    }
                                    if (isLogin) {
                                      final dto = LoginDto(
                                        email: emailTextController.text,
                                        password: passwordTextController.text,
                                      );
                                      context
                                          .read<AuthBloc>()
                                          .add(LoginEvent(dto));
                                    } else {
                                      final dto = RegisterDto(
                                        name: nameTextController.text,
                                        email: emailTextController.text,
                                        password: passwordTextController.text,
                                      );
                                      context
                                          .read<AuthBloc>()
                                          .add(RegisterEvent(dto));
                                    }
                                  },
                                  height: 50,
                                  color: Colors.orange[900],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Center(
                                    child: Text(
                                      isLogin ? 'Entrar' : 'Cadastrar',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )),
                            const SizedBox(height: 60),
                            FadeInUp(
                              duration: const Duration(milliseconds: 1800),
                              child: TextButton(
                                onPressed: () {
                                  context
                                      .read<AuthBloc>()
                                      .add(ToogleAuthEvent(isLogin));
                                },
                                child: Text(
                                  isLogin
                                      ? 'Não tem uma conta? Cadastre-se'
                                      : 'Já tem uma conta? Faça login',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
