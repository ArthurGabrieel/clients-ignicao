import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/config/routes/routes.dart';
import '../../../../shared/config/theme/app_colors.dart';
import '../../domain/dto/delete_client_dto.dart';
import '../../domain/entities/client_output.dart';
import '../bloc/clients_bloc.dart';

class ClientCard extends StatelessWidget {
  const ClientCard({super.key, required this.client});

  final ClientOutputEntity client;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      child: Dismissible(
        key: Key(client.id),
        direction: DismissDirection.endToStart,
        background: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.red,
          ),
          child: const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.delete, color: Colors.white),
            ),
          ),
        ),
        onDismissed: (direction) {
          final dto = DeleteClientDto(id: client.id);
          context.read<ClientsBloc>().add(DeleteClient(dto: dto));
        },
        child: Material(
          color: AppColors.cardBackground,
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(14),
          elevation: 10,
          child: SizedBox(
            height: 120,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  Routes.profile,
                  arguments: client,
                );
              },
              child: ListTile(
                title: Text(client.name, style: theme.textTheme.titleMedium),
                subtitle: Text(client.email,
                    style: theme.textTheme.labelMedium
                        ?.copyWith(color: AppColors.label)),
                trailing: Icon(Icons.edit, color: theme.iconTheme.color),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
