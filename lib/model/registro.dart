
import 'dart:convert';

class ImcEntry {
  final int peso;
  final double altura;
  final double imc;
  final String classificacao;
  final DateTime data;

  ImcEntry({
    required this.peso,
    required this.altura,
    required this.imc,
    required this.classificacao,
    DateTime? data,
  }) : data = data ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'peso': peso,
      'altura': altura,
      'imc': imc,
      'classificacao': classificacao,
      'data': data.toIso8601String(),
    };
  }

  factory ImcEntry.fromMap(Map<String, dynamic> map) {
    return ImcEntry(
      peso: map['peso'] as int,
      altura: (map['altura'] as num).toDouble(),
      imc: (map['imc'] as num).toDouble(),
      classificacao: map['classificacao'] as String,
      data: DateTime.parse(map['data'] as String),
    );
  }

  String toJson() => jsonEncode(toMap());

  factory ImcEntry.fromJson(String source) =>
      ImcEntry.fromMap(jsonDecode(source));
}
