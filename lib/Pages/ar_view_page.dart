import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ArViewPage extends StatefulWidget {
  final String modeloPath;
  final String nomeMovel;

  const ArViewPage({
    super.key,
    required this.modeloPath,
    required this.nomeMovel,
  });

  @override
  State<ArViewPage> createState() => _ArViewPageState();
}

class _ArViewPageState extends State<ArViewPage> {
  late ArCoreController arCoreController;
  bool modelPlaced = false; // Flag para verificar se o modelo foi posicionado

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
  }

  // Função que será chamada para posicionar o modelo quando o botão for pressionado
  void _placeModel() {
    if (!modelPlaced) {
      // Criação de um cubo simples
      final node = ArCoreCube(
        materials: [
          ArCoreMaterial(
            color: Colors.blue, // Cor do cubo
          ),
        ],
        size: vector.Vector3(0.5, 0.5, 0.5), // Tamanho do cubo
      );

      // Cria o nó do modelo
      final arNode = ArCoreNode(
        name: widget.nomeMovel,
        position: vector.Vector3(0.0, 0.0, -1.0),
        scale: vector.Vector3(0.5, 0.5, 0.5),
      );

      // Adiciona o cubo ao nó, utilizando o método correto para adicionar um objeto à cena
      arCoreController.addArCoreNodeWithAnchor(arNode); // Adiciona o nó com o cubo

      setState(() {
        modelPlaced = true; // Marca que o modelo foi colocado
      });
    }
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nomeMovel),
        backgroundColor: Colors.brown,
      ),
      body: Stack(
        children: [
          ArCoreView(
            onArCoreViewCreated: _onArCoreViewCreated,
            enableTapRecognizer: true,
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: _placeModel, // Chama a função para posicionar o modelo
                child: Text(
                  modelPlaced ? 'Modelo Posicionado' : 'Posicionar Modelo'
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
