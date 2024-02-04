import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.isLogin});

  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FadeInUp(
                  duration: const Duration(milliseconds: 1000),
                  child: Text(
                    isLogin ? 'Login' : 'Cadastro',
                    style: const TextStyle(color: Colors.white, fontSize: 40),
                  )),
              const SizedBox(
                height: 10,
              ),
              FadeInUp(
                  duration: const Duration(milliseconds: 1300),
                  child: const Text(
                    'Ignição Digital',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
            ],
          ),
          const Spacer(),
          FadeInUp(
            duration: const Duration(milliseconds: 1100),
            child: Image.asset('assets/images/ignicao.jpeg', width: 100),
          ),
        ],
      ),
    );
  }
}
