import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  String label;
  Function validator;
  Function save;
  bool isPassword;
  TextInputType type;
  Icon icon;
  String hint;
  TextEditingController contraller =TextEditingController();

  TextEditingController passwordContraller ;
  CustomTextfield(
  {this.isPassword = false, this.label, this.save, this.validator,this.icon,this.hint,this.type=TextInputType.text,this.passwordContraller});

  @override
  _CustomTextfieldState createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPassword,
      validator: (value) => widget.validator(value),
      onSaved: (value) => widget.save(value),
      // controller: widget.isPassword?widget.passwordContraller:widget.contraller,
      keyboardType: widget.type,
      decoration: InputDecoration(
          border:
          OutlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.symmetric(
              vertical: 20 * 0.75,
              horizontal: 20),
          labelText: widget.label,
          hintText: widget.hint,
          fillColor: Colors.white,
          // suffixIcon: widget.isPassword
          //     ? IconButton(
          //       icon: Icon(Icons.remove_red_eye),
          //   onPressed: () {
          //     widget.isPassword = !this.widget.isPassword;
          //     setState(() {});
          //   },
          // )
          //     : Container(
          //      child:widget.icon,
          //      width: 0,
          // )
    ),
    );
  }
}