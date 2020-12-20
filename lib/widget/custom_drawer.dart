import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(128, 0, 128, 3),
            Colors.white
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        ),
      )
    );
    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack()
        ],
      )
    );
  }
}