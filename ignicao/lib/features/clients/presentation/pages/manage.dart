import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/config/theme/app_colors.dart';
import '../../../../shared/utils/build_text_field.dart';
import '../../domain/dto/register_dto.dart';
import '../bloc/clients_bloc.dart';
import '../components/client_card.dart';

class ManagePage extends StatefulWidget {
  const ManagePage({super.key});

  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    refresh();
  }

  Future<void> refresh() async {
    context.read<ClientsBloc>().add(FetchClients());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openRegisterDialog(
            context,
            nameTextController,
            emailTextController,
            passwordTextController,
          );
        },
        elevation: 10,
        foregroundColor: AppColors.cardBackground,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Gerenciar clientes'),
      ),
      body: BlocBuilder<ClientsBloc, ClientsState>(
        builder: (context, state) {
          if (state is Empty) {
            return const Center(child: Text('Nenhum cliente cadastrado'));
          } else if (state is Loading) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.primary,
            ));
          } else if (state is ClientsLoaded) {
            return ListView.builder(
              itemCount: state.clients.length,
              itemBuilder: (context, index) {
                return ClientCard(client: state.clients[index]);
              },
            );
          } else if (state is Error) {
            return Center(child: Text(state.message));
          } else {
            refresh();
            return const Center(child: Text('Erro desconhecido'));
          }
        },
      ),
    );
  }

  Future<void> openRegisterDialog(
    BuildContext context,
    TextEditingController nameController,
    TextEditingController emailController,
    TextEditingController passwordController,
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
                  final dto = RegisterDto(
                    name: nameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  context.read<ClientsBloc>().add(AddClient(dto: dto));
                  refresh();
                  nameTextController.clear();
                  emailTextController.clear();
                  passwordTextController.clear();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cadastrar',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
            title: Text(
              'Registrar cliente',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            content: Column(
              children: [
                Text(
                  'Deseja registrar um novo cliente?',
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
                        buildTextField(passwordController, 'Senha', true),
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
