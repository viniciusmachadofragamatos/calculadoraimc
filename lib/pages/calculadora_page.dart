// lib/main_parts/calculator_page.dart  (ou incluir no main.dart)
import 'package:calculadoraimc/model/registro.dart';
import 'package:flutter/material.dart';
import '../model/imc.dart';
import '../services/history_service.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});
  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();
  String resultado = "";

  @override
  void dispose() {
    pesoController.dispose();
    alturaController.dispose();
    super.dispose();
  }
  //proteção contra usuarios brs que usam , sendo que o dartizinho só aceita . para double
  String normalizarNumero(String valor) {
    return valor.trim().replaceAll(',', '.'); 
  }

  Future<void> calcularImc() async {
    final peso = int.tryParse(pesoController.text.trim());
    final altura = double.tryParse(normalizarNumero(alturaController.text));


    if (peso == null || altura == null) {
      setState(() => resultado = "Valores inválidos!");
      return;
    }

    final imcModel = Imc(peso, altura);
    final valor = imcModel.calcular()!;
    final classificacao = imcModel.classificar() ?? '';

    // salva no histórico
    final entry = ImcEntry(
      peso: peso,
      altura: altura,
      imc: double.parse(valor.toStringAsFixed(2)),
      classificacao: classificacao,
    );
    await HistoryService().add(entry);

    setState(() {
      resultado = "IMC: ${valor.toStringAsFixed(2)}\n$classificacao";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Text('Calcule seu IMC', style: TextStyle(fontSize: 32)),
          const SizedBox(height: 16),
          TextField(
            controller: pesoController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Insira aqui seu peso',
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: alturaController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Insira aqui sua altura',
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: calcularImc, child: const Text('Calcular')),
          const SizedBox(height: 20),
          Text(resultado, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
