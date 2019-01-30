import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildPageContent(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.deepPurple,
      toolbarOpacity: 0.7,
      elevation: 0,
    );
  }

  Widget _buildPageContent() {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Created By Nick Leslie'),
            Text('All Rights Reserved'),
            Text('©')
          ],
        ),
      ),
    );
  }
}
