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
  bool isArInitialized = false;
  String? errorMessage;

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
            enablePlaneRenderer: true,
            enableUpdateListener: true,
          ),
          if (!isArInitialized)
            Container(
              color: Colors.black54,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              ),
            ),
          if (errorMessage != null)
            Container(
              color: Colors.black54,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    errorMessage!,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
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
                        errorMessage != null
                            ? 'Erro: $errorMessage'
                            : !isArInitialized
                            ? 'Inicializando AR...'
                            : !planeDetected
                            ? 'Aponte para o chão até detectar uma superfície'
                            : !modelPlaced
                            ? 'Toque na superfície ou no botão para posicionar'
                            : 'Móvel posicionado com sucesso',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (isArInitialized && planeDetected && !modelPlaced && errorMessage == null) ? _placeModel : null,
                    child: Text(
                        modelPlaced ? 'Móvel Posicionado' : 'Posicionar Móvel'
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
    print('AR Core View Created');
    try {
      arCoreController = controller;
      setState(() {
        isArInitialized = true;
        errorMessage = null;
      });

      arCoreController.onPlaneTap = _handlePlaneTap;
      arCoreController.onPlaneDetected = (ArCorePlane plane) {
        print('Plane detected: ${plane.type}');
        if (plane.type == ArCorePlaneType.HORIZONTAL_UPWARD_FACING) {
          if (!planeDetected) {
            setState(() {
              planeDetected = true;
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
                content: Text('Superfície detectada! Agora você pode posicionar o móvel.'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        }
      };
    } catch (e) {
      print('Erro ao inicializar AR: $e');
      setState(() {
        errorMessage = 'Erro ao inicializar AR: $e';
      });
    }
  }

  void _placeModel() {
    if (!modelPlaced && planeDetected && isArInitialized && errorMessage == null) {
      try {
        print('Attempting to place model: ${widget.modeloPath}');
        if (detectedPlanePosition != null) {
          _addModelOnFloor(detectedPlanePosition!);
        } else {
          _addModelNode();
        }

        setState(() {
          modelPlaced = true;
        });
      } catch (e) {
        print('Erro ao posicionar móvel: $e');
        setState(() {
          errorMessage = 'Erro ao posicionar o móvel: $e';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao posicionar o móvel. Tente novamente.')),
        );
      }
    }
  }

  void _addModelNode() {
    try {
      print('Adding model node with path: ${widget.modeloPath}');
      final modelNode = ArCoreReferenceNode(
        name: 'modelo_${widget.nomeMovel}',
        objectUrl: widget.modeloPath,
        position: vector.Vector3(0, 0, -1.0),
        rotation: vector.Vector4(0, 0, 0, 0),
        scale: vector.Vector3(0.1, 0.1, 0.1), // Reduzindo a escala para 0.1
      );

      arCoreController.addArCoreNodeWithAnchor(modelNode);
      print('Modelo adicionado com sucesso');
    } catch (e) {
      print('Erro ao adicionar modelo: $e');
      rethrow;
    }
  }

  void _addModelOnFloor(vector.Vector3 planePosition) {
    try {
      print('Adding model on floor with path: ${widget.modeloPath}');
      final modelNode = ArCoreReferenceNode(
        name: 'modelo_${widget.nomeMovel}',
        objectUrl: widget.modeloPath,
        position: vector.Vector3(
          planePosition.x,
          planePosition.y,
          planePosition.z
        ),
        rotation: vector.Vector4(0, 0, 0, 0),
        scale: vector.Vector3(0.1, 0.1, 0.1), // Reduzindo a escala para 0.1
      );

      arCoreController.addArCoreNodeWithAnchor(modelNode);
      print('Modelo adicionado no chão com sucesso');
    } catch (e) {
      print('Erro ao adicionar modelo no chão: $e');
      rethrow;
    }
  }

  void _handlePlaneTap(List<ArCoreHitTestResult> hits) {
    if (!modelPlaced && hits.isNotEmpty && isArInitialized && errorMessage == null) {
      final hit = hits.first;
      if (hit.pose != null && hit.pose.translation != null) {
        _addModelAtHit(hit);
        setState(() {
          modelPlaced = true;
        });
      }
    }
  }

  void _addModelAtHit(ArCoreHitTestResult hit) {
    try {
      if (hit.pose.translation == null) {
        print('Translation é nulo, não é possível posicionar o modelo');
        return;
      }

      print('Adding model at hit with path: ${widget.modeloPath}');
      final hitPosition = hit.pose.translation!;
      final modelNode = ArCoreReferenceNode(
        name: 'modelo_tap_${widget.nomeMovel}',
        objectUrl: widget.modeloPath,
        position: vector.Vector3(
          hitPosition.x,
          hitPosition.y,
          hitPosition.z
        ),
        rotation: hit.pose.rotation,
        scale: vector.Vector3(0.1, 0.1, 0.1), // Reduzindo a escala para 0.1
      );

      arCoreController.addArCoreNode(modelNode);
      print('Modelo adicionado no ponto tocado');
    } catch (e) {
      print('Erro ao adicionar modelo no ponto tocado: $e');
      rethrow;
    }
  }

  @override
  void dispose() {
    if (isArInitialized) {
      arCoreController.dispose();
    }
    super.dispose();
  }
}