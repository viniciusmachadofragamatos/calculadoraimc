import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/registro.dart';

class HistoryService {
  static const _kKey = 'imc_history';
  static final HistoryService _instance = HistoryService._internal();
  factory HistoryService() => _instance;
  HistoryService._internal();

  final ValueNotifier<List<ImcEntry>> notifier = ValueNotifier([]);

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();//shared_preferencesss
    final List<String>? list = prefs.getStringList(_kKey);
    if (list != null) {
      notifier.value = list.map((s) => ImcEntry.fromJson(s)).toList();
    } else {
      notifier.value = [];
    }
  }

  Future<void> add(ImcEntry entry) async {//funcao de adicionar 
    final prefs = await SharedPreferences.getInstance();//shared_preferencesss
    final current = List<String>.from(prefs.getStringList(_kKey) ?? []);
    current.insert(0, entry.toJson()); // insere no começo
    await prefs.setStringList(_kKey, current);
    notifier.value = current.map((s) => ImcEntry.fromJson(s)).toList();
  }

  Future<void> clear() async {//funcao de limpa
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kKey);
    notifier.value = [];
  }
}
