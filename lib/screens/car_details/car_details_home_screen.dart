import 'dart:async';
import 'dart:isolate';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:real_time_chart/real_time_chart.dart';

class CarDetailsHomeScreen extends StatefulWidget {
  const CarDetailsHomeScreen({super.key});

  @override
  State<CarDetailsHomeScreen> createState() => _CarDetailsHomeScreenState();
}

class _CarDetailsHomeScreenState extends State<CarDetailsHomeScreen> {
  Stream<double>? _stream;
  late Isolate _isolate;

  @override
  void initState() {
    super.initState();
    _initializeIsolate();
  }

  Future<void> _initializeIsolate() async {
    final receivePort = ReceivePort();
    _isolate = await Isolate.spawn(_generateData, receivePort.sendPort);
    setState(() {
      _stream = receivePort.asBroadcastStream().cast<double>();
    });
  }

  static void _generateData(SendPort sendPort) {
    final random = Random();
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      sendPort.send(random.nextInt(100).toDouble());
    });
  }

  @override
  void dispose() {
    _isolate.kill(priority: Isolate.immediate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _stream == null
            ? const CircularProgressIndicator()
            : RealTimeGraph(
                speed: 5,
                updateDelay: const Duration(milliseconds: 50),
                stream: _stream!,
                graphColor: Colors.redAccent,
                graphStroke: 3,
                displayMode: ChartDisplay.points,
              ),
      ),
    );
  }
}
