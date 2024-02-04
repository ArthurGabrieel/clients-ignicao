import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/config/theme/app_colors.dart';
import '../../../../shared/utils/build_text_field.dart';
import '../../../../shared/utils/date_to_string.dart';
import '../../domain/dto/search_client_dto.dart';
import '../bloc/clients_bloc.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisar'),
      ),
      body: BlocBuilder<ClientsBloc, ClientsState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
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
                  child: buildTextField(emailController, 'Email', false),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final dto = SearchClientDto(emailController.text);
                    BlocProvider.of<ClientsBloc>(context).add(
                      SearchClient(dto: dto),
                    );
                  },
                  child: const Text('Pesquisar'),
                ),
                const SizedBox(height: 100),
                if (state is Loading)
                  const CircularProgressIndicator()
                else if (state is Error)
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                else if (state is ClientFound)
                  Card(
                    shadowColor: AppColors.shadowColor,
                    elevation: 10,
                    margin: const EdgeInsets.all(16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ListTile(
                        title: Text(state.client.name,
                            style: const TextStyle(
                                fontSize: 26, color: AppColors.label)),
                        subtitle: Text(
                            'Email: ${state.client.email}\nCriado em: ${dateToString(state.client.createdAt)}',
                            style: const TextStyle(
                                fontSize: 16, color: AppColors.label)),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
