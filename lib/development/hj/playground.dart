import 'package:flutter/material.dart';

class HJPlayGround extends StatefulWidget {
  const HJPlayGround({super.key});

  @override
  State<HJPlayGround> createState() => _HJPlayGroundState();
}

class _HJPlayGroundState extends State<HJPlayGround> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HJ"),),
    );
  }
}
