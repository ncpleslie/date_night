import 'package:flutter/material.dart';

class Results extends StatelessWidget {
  final String result;
  Results(this.result);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(result.toUpperCase(), style: TextStyle(fontSize: 86.0, fontWeight: FontWeight.bold),),
              SizedBox(height: 50.0,),
              Text('Sounds Like A Good Idea To Me', style: TextStyle(fontSize: 24.0))
            ],
          ),
        ),
      ),
    );
  }
}
