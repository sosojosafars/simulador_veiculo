import 'package:flutter/material.dart';
import 'widgets/Carro.dart';
import 'widgets/Moto.dart';
import 'widgets/Caminhao.dart';
import 'widgets/Calculadora.dart';

void main() {
  runApp(const FinanciamentoApp());
}

class FinanciamentoApp extends StatelessWidget {
  const FinanciamentoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Financiamento de Veículos',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
        useMaterial3: true,
      ),
      home: const VeiculoHomePage(
        title: 'Financiamento de Veículos',
      ),
    );
  }
}

class VeiculoHomePage extends StatelessWidget {
  final String title;

  const VeiculoHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Financiamento de Veículos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),

      //Corpo da tela com uma lista (pode rolar caso tenha muitos widgets)
      body: ListView(
        children: [
          Row(
            //// Distribui igualmente os cards
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Usado SizedBox para definir tamanho fixo dos elementos
              SizedBox(
                width: 400,
                height: 400,
                child: CarroWidget(
                  nome: 'Maverick 2025',
                  preco: 239990.00,
                  descricao: 'Clique para saber mais',
                  imagemUrl: 'assets/images/maverick.jpg',
                  marca: '',
                  isBlue: true,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      // Vai para a tela de cálculo ao clicar no widget
                      builder: (context) => const Calculadora(
                        imagemUrl: 'assets/images/maverick.jpg',
                        precoVeiculo: 239990.00,
                        nome: 'Maverick 2025',
                        marca: 'Ford',
                        descricao: 'Picape moderna com design robusto.',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 400,
                height: 400,
                child: MotoWidget(
                  nome: 'Moto Big Trail',
                  preco: 115000.00,
                  descricao: 'Clique para saber mais',
                  imagemUrl: 'assets/images/moto.jpg',
                  tipo: '',
                  isRed: false,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Calculadora(
                        imagemUrl: 'assets/images/moto.jpg',
                        precoVeiculo: 115000.00,
                        nome: 'Moto Big Trail',
                        marca: 'BMW',
                        descricao: 'Uma moto potente e ágil.',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 400,
                height: 400,
                child: CaminhaoWidget(
                  nome: 'Truck',
                  preco: 800000.00,
                  descricao: 'Clique para saber mais',
                  imagemUrl: 'assets/images/truck.jpg',
                  tamanho: 0,
                  isWhite: true,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Calculadora(
                        imagemUrl: 'assets/images/truck.jpg',
                        precoVeiculo: 800000.00,
                        nome: 'Truck',
                        marca: 'Volvo',
                        descricao: 'Caminhão robusto para transporte pesado.',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
