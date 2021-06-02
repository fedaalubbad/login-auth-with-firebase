import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Custom_Button extends StatelessWidget{
  String title;
  Function function;
  Custom_Button(this.title,this.function);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: function,
      child: Material(
          elevation: 10.0,
          shadowColor: Colors.blue,
          color: Colors.pink,
          borderRadius: BorderRadius.circular(30.0),
          child: Container(
            width: size.width,
            // height: size.width * 0.15,
            height: size.height * 0.08,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )),

    );
  }

}