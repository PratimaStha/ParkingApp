import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_parking/core/development/console.dart';
import 'package:flutter_parking/pages/style.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRPage extends StatefulWidget {
  const QRPage({super.key, required this.data});

  final String data;

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  final TextEditingController _textController = TextEditingController(text: '');
  final GlobalKey _qrkey = GlobalKey();
  bool dirExists = false;
  dynamic externalDir = '/storage/emulated/0/Download/Qr_code';

  Future<void> _captureAndSavePng() async {
    try {
      RenderRepaintBoundary boundary =
          _qrkey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);

      //Drawing White Background because Qr Code is Black
      final whitePaint = Paint()..color = Colors.white;
      final recorder = PictureRecorder();
      final canvas = Canvas(recorder,
          Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()));
      canvas.drawRect(
          Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
          whitePaint);
      canvas.drawImage(image, Offset.zero, Paint());
      final picture = recorder.endRecording();
      final img = await picture.toImage(image.width, image.height);
      ByteData? byteData = await img.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      //Check for duplicate file name to avoid Override
      String fileName = 'qr_code';
      int i = 1;
      while (await File('$externalDir/$fileName.png').exists()) {
        fileName = 'qr_code_$i';
        i++;
      }

      // Check if Directory Path exists or not
      dirExists = await File(externalDir).exists();
      //if not then create the path
      if (!dirExists) {
        await Directory(externalDir).create(recursive: true);
        dirExists = true;
      }

      final file = await File('$externalDir/$fileName.png').create();
      await file.writeAsBytes(pngBytes);

      if (!mounted) return;
      const snackBar = SnackBar(content: Text('QR code saved to gallery'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      if (!mounted) return;
      const snackBar = SnackBar(content: Text('Something went wrong!!!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    consolelog("QrData :: :: ${widget.data}");
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Generator'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Center(
            child: RepaintBoundary(
              key: _qrkey,
              child: QrImageView(
                data: widget.data,
                version: QrVersions.auto,
                size: 250.0,
                gapless: true,
                errorStateBuilder: (ctx, err) {
                  return const Center(
                    child: Text(
                      'Something went wrong!!!',
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          RawMaterialButton(
            onPressed: _captureAndSavePng,
            fillColor: AppColors.primaryColor,
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
            child: const Text(
              'Export',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
