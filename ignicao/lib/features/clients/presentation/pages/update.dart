import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared/config/theme/app_colors.dart';
import '../../../../shared/utils/build_text_field.dart';
import '../../domain/dto/search_client_dto.dart';
import '../../domain/dto/update_password_dto.dart';
import '../bloc/clients_bloc.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  Future<void> getClient() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final dto = SearchClientDto(email!);
    if (mounted) {
      context.read<ClientsBloc>().add(SearchClient(dto: dto));
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<ClientsBloc>().add(Reset());
    getClient();
  }

  bool validateForm() {
    if (oldPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confirmNewPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    if (newPasswordController.text != confirmNewPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('As senhas não coincidem'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atualizar senha'),
      ),
      body: BlocBuilder<ClientsBloc, ClientsState>(
        builder: (context, state) {
          if (state is ClientUpdated) {
            Future.delayed(const Duration(milliseconds: 500), () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Senha atualizada com sucesso'),
                  backgroundColor: Colors.green,
                ),
              );
            });
          }
          if (state is Error) {
            Future.delayed(const Duration(milliseconds: 500), () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            });
          }
          return Padding(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              children: [
                const Text(
                    'Preencha os campos abaixo para alterar a sua senha.'),
                const SizedBox(height: 20),
                Form(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: AppColors.shadowColor,
                            blurRadius: 20,
                            offset: Offset(0, 10))
                      ],
                    ),
                    child: Column(
                      children: [
                        buildTextField(
                            oldPasswordController, 'Senha atual', true),
                        buildTextField(
                            newPasswordController, 'Nova senha', true),
                        buildTextField(confirmNewPasswordController,
                            'Confirme a nova senha', true),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (validateForm() && state is ClientFound) {
                      final dto = UpdatePasswordDto(
                        id: state.client.id,
                        password: newPasswordController.text,
                        oldPassword: oldPasswordController.text,
                      );
                      context.read<ClientsBloc>().add(UpdatePassword(dto: dto));
                      oldPasswordController.clear();
                      newPasswordController.clear();
                      confirmNewPasswordController.clear();
                    }
                  },
                  child: const Text('Atualizar'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
