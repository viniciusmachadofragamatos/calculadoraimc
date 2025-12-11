// lib/main_parts/settings_page.dart
import 'package:flutter/material.dart';
import '../services/history_service.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('Limpar histórico'),
        onPressed: () async {
          final ok = await showDialog<bool>(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Confirmar'),
              content: const Text('Deseja limpar todo o histórico?'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Não')),
                TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Sim')),
              ],
            ),
          );
          if (ok == true) {
            await HistoryService().clear();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Histórico limpo')));
          }
        },
      ),
    );
  }
}
