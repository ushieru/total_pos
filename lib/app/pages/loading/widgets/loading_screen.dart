import 'package:flutter/material.dart';
import 'package:total_pos/app/config/global_config.dart';

class LoadingScreen extends StatelessWidget {
  final String text;
  const LoadingScreen({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: GlobalConfig.principalColor,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text('Total POS',
                style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 50),
            const CircularProgressIndicator(color: Colors.white),
            Text(text,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))
          ])),
    );
  }
}
