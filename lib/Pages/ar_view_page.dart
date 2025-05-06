import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import '../app_colors.dart';

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
  bool modelPlaced = false;
  bool planeDetected = false;
  vector.Vector3? detectedPlanePosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nomeMovel),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.background,
      ),
      body: Stack(
        children: [
          ArCoreView(
            onArCoreViewCreated: _onArCoreViewCreated,
            enableTapRecognizer: true,
            enablePlaneRenderer: true, // Habilita renderização de planos detectados
            enableUpdateListener: true, // Habilita listener para atualizações
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        !planeDetected
                            ? 'Aponte para o chão até detectar uma superfície'
                            : !modelPlaced
                            ? 'Toque na superfície ou no botão para posicionar'
                            : 'Cubo posicionado com sucesso',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: planeDetected && !modelPlaced ? _placeCube : null,
                    child: Text(
                        modelPlaced ? 'Cubo Posicionado' : 'Posicionar Cubo'
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.background,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      disabledBackgroundColor: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

    // Adiciona um listener para quando planos são detectados
    arCoreController.onPlaneTap = _handlePlaneTap;

    // Adiciona um listener para atualizações de planos
    arCoreController.onPlaneDetected = (ArCorePlane plane) {
      // Verifica se o plano detectado é horizontal (como o chão)
      if (plane.type == ArCorePlaneType.HORIZONTAL_UPWARD_FACING) {
        if (!planeDetected) {
          setState(() {
            planeDetected = true;
            // Armazena a posição do plano para uso posterior
            if (plane.centerPose != null && plane.centerPose!.translation != null) {
              detectedPlanePosition = vector.Vector3(
                  plane.centerPose!.translation!.x,
                  plane.centerPose!.translation!.y,
                  plane.centerPose!.translation!.z
              );
            }
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Superfície detectada! Agora você pode posicionar o cubo.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    };
  }

  void _placeCube() {
    if (!modelPlaced && planeDetected) {
      try {
        if (detectedPlanePosition != null) {
          _addCubeOnFloor(detectedPlanePosition!);
        } else {
          // Fallback para uma posição padrão se não tiver posição do plano
          _addCubeNode();
        }

        setState(() {
          modelPlaced = true;
        });
      } catch (e) {
        print('Erro ao posicionar cubo: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao posicionar o cubo. Tente novamente.')),
        );
      }
    }
  }

  void _addCubeNode() {
    // Cria um material com a cor do app
    final material = ArCoreMaterial(
      color: AppColors.primary,
      metallic: 0.5,
      roughness: 0.4,
    );

    // Cria um cubo com o material
    final cube = ArCoreCube(
      materials: [material],
      size: vector.Vector3(0.5, 0.5, 0.5),
    );

    // Cria o nó com o cubo - coloca a base no ponto de âncora
    // O y = -0.25 garante que a base do cubo fique no plano, já que o cubo tem altura 0.5
    final cubeNode = ArCoreNode(
      name: 'cubo_${widget.nomeMovel}',
      shape: cube,
      position: vector.Vector3(0, -0.25, -1.0),
      rotation: vector.Vector4(0, 0, 0, 0),
    );

    // Adiciona o nó à cena
    arCoreController.addArCoreNodeWithAnchor(cubeNode);

    print('Cubo adicionado com sucesso');
  }

  void _addCubeOnFloor(vector.Vector3 planePosition) {
    // Cria um material com a cor do app
    final material = ArCoreMaterial(
      color: AppColors.primary,
      metallic: 0.5,
      roughness: 0.4,
    );

    // Cria um cubo com o material
    final cube = ArCoreCube(
      materials: [material],
      size: vector.Vector3(0.5, 0.5, 0.5),
    );

    // Ajustamos o Y para que a base do cubo fique no plano
    // Como o cubo tem altura 0.5 e o ponto central está no meio,
    // adicionamos metade da altura (0.25) para elevar o centro
    // e fazer a base ficar no plano
    final position = vector.Vector3(
        planePosition.x,
        planePosition.y + 0.25, // Posiciona para que a base do cubo fique no chão
        planePosition.z
    );

    // Cria o nó com o cubo
    final cubeNode = ArCoreNode(
      name: 'cubo_${widget.nomeMovel}',
      shape: cube,
      position: position,
      rotation: vector.Vector4(0, 0, 0, 0),
    );

    // Adiciona o nó à cena
    arCoreController.addArCoreNodeWithAnchor(cubeNode);

    print('Cubo adicionado no chão com sucesso');
  }

  // Função para lidar com toques em planos detectados
  void _handlePlaneTap(List<ArCoreHitTestResult> hits) {
    if (!modelPlaced && hits.isNotEmpty) {
      final hit = hits.first;
      // Verificamos se a pose e a translation não são nulos
      if (hit.pose != null && hit.pose.translation != null) {
        _addCubeAtHit(hit);
        setState(() {
          modelPlaced = true;
        });
      }
    }
  }

  void _addCubeAtHit(ArCoreHitTestResult hit) {
    try {
      // Cria um material com a cor do app
      final material = ArCoreMaterial(
        color: AppColors.primary,
        metallic: 0.5,
        roughness: 0.4,
      );

      // Cria um cubo com o material
      final cube = ArCoreCube(
        materials: [material],
        size: vector.Vector3(0.5, 0.5, 0.5),
      );

      // Certifique-se de que hit.pose.translation não é nulo
      if (hit.pose.translation == null) {
        print('Translation é nulo, não é possível posicionar o cubo');
        return;
      }

      // Obtém a posição do ponto tocado
      final hitPosition = hit.pose.translation!;

      // Ajusta a posição Y para que a base do cubo fique exatamente no plano
      // Como o cubo tem altura 0.5 e o centroide está no meio, adicionamos 0.25 ao Y
      final adjustedPosition = vector.Vector3(
          hitPosition.x,
          hitPosition.y + 0.25, // Metade da altura do cubo
          hitPosition.z
      );

      // Cria o nó com o cubo no ponto onde o usuário tocou (com altura ajustada)
      final cubeNode = ArCoreNode(
        name: 'cubo_tap_${widget.nomeMovel}',
        shape: cube,
        position: adjustedPosition,
        rotation: hit.pose.rotation,
      );

      // Adiciona o nó à cena
      arCoreController.addArCoreNode(cubeNode);

      print('Cubo adicionado no ponto tocado, alinhado ao chão');
    } catch (e) {
      print('Erro ao adicionar cubo no ponto tocado: $e');
    }
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}