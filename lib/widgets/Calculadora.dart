import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Calculadora extends StatefulWidget {
  final double precoVeiculo;
  final String nome;
  final String marca;
  final String descricao;
  final String imagemUrl;

  const Calculadora({
    super.key,
    required this.precoVeiculo,
    required this.nome,
    required this.marca,
    required this.descricao,
    required this.imagemUrl,
  });

  @override
  State<Calculadora> createState() => CalculadoraState();
}

class CalculadoraState extends State<Calculadora> {
  final entradaController = TextEditingController();
  final prazoController = TextEditingController();

  String valorFinanciado = "0.00";
  String valorParcela = "0.00";
  static const double _jurosMensal = 0.02;

  // // Função de cálculo do financiamento
  void _calcularFinanciamento() {
    try {
      final double entrada = double.parse(entradaController.text);
      final int prazoMeses = int.parse(prazoController.text);

      // if e else para verificar se os valores são válidos
      if (entrada < 0 || prazoMeses <= 0) {
        setState(() {
          valorFinanciado = "    |    Entrada e Prazo devem ser positivos.";
          valorParcela = "0.00";
        });
        return;
      }

      // if e else para verificar se a entrada é maior que o preço do veículo

      if (entrada > widget.precoVeiculo) {
        setState(() {
          valorFinanciado =
              "    |    Entrada não pode ser maior que o preço do veículo.";
          valorParcela = "0.00";
        });
        return;
      }

      final double valorFinanciadoCalculado = widget.precoVeiculo - entrada;
      final double jurosAplicado =
          valorFinanciadoCalculado * _jurosMensal * prazoMeses;
      final double valorTotalAPagar = valorFinanciadoCalculado + jurosAplicado;
      final double valorParcelaCalculado = valorTotalAPagar / prazoMeses;

      // Atualiza os valores no estado
      setState(() {
        valorFinanciado = valorFinanciadoCalculado.toStringAsFixed(2);
        valorParcela = valorParcelaCalculado.toStringAsFixed(2);
      });
    } catch (e) {
      setState(() {
        valorFinanciado =
            "    |    Erro: Dados inválidos, verifique os campos.";
        valorParcela = "0.00";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Financiamento de Veículos',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      // 'SingleChildScrollView' permite rolar a tela quando os widgets forem maiores que o tamanho da tela
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Detalhes do Veículo',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 22),
                          Image.asset(
                            widget.imagemUrl,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 16),
                          Text('Nome: ${widget.nome}',
                              style: TextStyle(fontSize: 18)),
                          Text('Preço: ${widget.precoVeiculo}',
                              style: TextStyle(fontSize: 18)),
                          Text('Marca: ${widget.marca}',
                              style: TextStyle(fontSize: 18)),
                          Text('Descrição: ${widget.descricao}',
                              style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                  height: 200,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              const Text(
                                'Calculadora',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Preço: R\$ ${widget.precoVeiculo.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 17, 85, 24),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                controller: entradaController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                decoration: const InputDecoration(
                                  labelText: 'Valor de Entrada (R\$)',
                                  border: OutlineInputBorder(),
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                controller: prazoController,
                                decoration: const InputDecoration(
                                  labelText: 'Prazo de Meses (até 24)',
                                  border: OutlineInputBorder(),
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _calcularFinanciamento,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 17, 85, 24),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 30),
                                ),
                                child: const Text(
                                  'Calcular financiamento',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Resultado:',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Valor Financiado: R\$ $valorFinanciado',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Valor da Parcela (c/ juros de 2% a.m.): R\$ $valorParcela',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    entradaController.dispose();
    prazoController.dispose();
    super.dispose();
  }
}
