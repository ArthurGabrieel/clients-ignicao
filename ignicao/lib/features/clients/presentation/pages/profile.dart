import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/config/theme/app_colors.dart';
import '../../../../shared/utils/build_text_field.dart';
import '../../../../shared/utils/date_to_string.dart';
import '../../domain/dto/delete_client_dto.dart';
import '../../domain/dto/update_client_dto.dart';
import '../../domain/entities/client_output.dart';
import '../bloc/clients_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final client =
        ModalRoute.of(context)!.settings.arguments as ClientOutputEntity?;

    final nameTextController = TextEditingController(text: client!.name);
    final emailTextController = TextEditingController(text: client.email);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do cliente'),
      ),
      body: BlocBuilder<ClientsBloc, ClientsState>(
        builder: (context, state) {
          if (state is ClientLoaded) {
            Future.delayed(Duration.zero, () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cliente atualizado com sucesso!'),
                  backgroundColor: Colors.green,
                ),
              );
            });
          }
          if (state is ClientDeleted) {
            Future.delayed(Duration.zero, () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cliente excluído com sucesso!'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.of(context).pop();
            });
          }
          return Column(
            children: [
              Card(
                shadowColor: AppColors.shadowColor,
                elevation: 10,
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListTile(
                    title: Text(client.name,
                        style: const TextStyle(
                            fontSize: 26, color: AppColors.label)),
                    subtitle: Text(
                        'Email: ${client.email}\nCriado em: ${dateToString(client.createdAt)}',
                        style: const TextStyle(
                            fontSize: 16, color: AppColors.label)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('O que deseja fazer?',
                  style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 10, fixedSize: const Size(120, 40)),
                    onPressed: () async {
                      await openUpdateDialog(
                        context,
                        nameTextController,
                        emailTextController,
                        client,
                      );
                    },
                    child: const Text('Editar'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 10, fixedSize: const Size(120, 40)),
                    onPressed: () {
                      final dto = DeleteClientDto(id: client.id);
                      context.read<ClientsBloc>().add(DeleteClient(dto: dto));
                    },
                    child: const Text('Excluir'),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> openUpdateDialog(
    BuildContext context,
    TextEditingController nameController,
    TextEditingController emailController,
    ClientOutputEntity client,
  ) async {
    return showDialog(
      context: context,
      builder: (context) {
        return FadeInUp(
          duration: const Duration(milliseconds: 300),
          child: AlertDialog(
            actionsPadding: const EdgeInsets.only(right: 20, bottom: 20),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancelar',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              TextButton(
                onPressed: () {
                  final dto = UpdateClientDto(
                    id: client.id,
                    name: nameController.text,
                    email: emailController.text,
                  );
                  context.read<ClientsBloc>().add(UpdateClient(dto: dto));
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Salvar',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
            title: Text(
              'Editar cliente',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            content: Column(
              children: [
                Text(
                  'Deseja editar as informações do cliente?',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 16,
                        color: AppColors.label,
                      ),
                ),
                const SizedBox(height: 30),
                Container(
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
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        buildTextField(nameController, 'Nome', false),
                        buildTextField(emailController, 'Email', false),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
