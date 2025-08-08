import 'package:flutter/material.dart';
import 'Veiculo.dart';
import 'dart:convert';

class CarroWidget extends VeiculoWidget {
  final String marca;
  final bool isBlue;

  const CarroWidget({
    Key? key,
    required String nome,
    required double preco,
    required String descricao,
    required String imagemUrl,
    required VoidCallback onTap,
    required this.marca,
    required this.isBlue,
  }) : super(
          key: key,
          nome: nome,
          preco: preco,
          descricao: descricao,
          imagemUrl: imagemUrl,
          onTap: onTap,
        );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: const Color.fromARGB(255, 243, 239, 239),
        borderOnForeground: true,
        margin: const EdgeInsets.all(8),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween, //Deu espaçamento no nome e no clique para saber mais 
            children: [
              imagemUrl.startsWith('data:image/')
                  ? Image.memory(                                        //img armazenada na memória para quando clicar no widget mostrar a img 
                      base64Decode(imagemUrl.split(',').last),
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(                                        //pega a img e mostra 
                      imagemUrl,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
              Text(
                nome,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
               Text(
                descricao,
                textAlign: TextAlign.center,
                style: const TextStyle(
                decoration: TextDecoration.underline,  
                fontSize: 15,
                color: Color.fromRGBO(17, 85, 24, 1.0)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
