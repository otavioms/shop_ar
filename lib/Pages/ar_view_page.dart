import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ArViewPage extends StatefulWidget {
  final String modeloPath;
  final String modelName;

  const ArViewPage({
    Key? key,
    required this.modeloPath,
    required this.modelName,
  }) : super(key: key);

  @override
  State<ArViewPage> createState() => _ArViewPageState();
}

class _ArViewPageState extends State<ArViewPage> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.modelName),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          ModelViewer(
            backgroundColor: const Color(0xFFEEEEEE),
            src: widget.modeloPath,
            alt: 'Um modelo 3D de ${widget.modelName}',
            ar: true,
            arModes: const ['scene-viewer'],
            autoRotate: true,
            cameraControls: true,
            disableZoom: false,
            onWebViewCreated: (_) {
              setState(() {
                _isLoading = false;
              });
            },
          ),
          if (_isLoading)
            Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
