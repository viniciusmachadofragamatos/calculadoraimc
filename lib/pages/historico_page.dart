// lib/main_parts/history_page.dart
import 'package:calculadoraimc/model/registro.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/history_service.dart';


class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = HistoryService();
    return ValueListenableBuilder<List<ImcEntry>>(
      valueListenable: service.notifier,
      builder: (context, list, _) {
        if (list.isEmpty) {
          return const Center(child: Text('Nenhum histórico ainda'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: list.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, i) {
            final e = list[i];
            final dt = DateFormat('dd/MM/yyyy HH:mm').format(e.data);
            return Card(
              child: ListTile(
                title: Text('IMC: ${e.imc.toStringAsFixed(2)} — ${e.classificacao}'),
                subtitle: Text('Peso: ${e.peso} kg • Altura: ${e.altura} m\n$dt'),
              ),
            );
          },
        );
      },
    );
  }
}
