import 'package:auth_login_app/auth-helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class LoginAuth extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LoginAuthState();
  }

}
enum AuthMode{signUp,login}

class LoginAuthState extends State<LoginAuth>{

  final _formKey = GlobalKey<FormState>();
  // final GlobalKey<FormState>_formKey=GlobalKey();
  AuthMode _authMode=AuthMode.login;
  Map<String,String>_authData={
    'email':'',
    'pass':'',
  };

  var isLoading=false;
  final _passwordContraller =TextEditingController();

  void _switchMode(){
    if(_authMode==AuthMode.login){
      setState(() {
        _authMode=AuthMode.signUp;

      });
    }else{
      setState(() {
        _authMode=AuthMode.login;

      });
    }
  }
  void _submit(){
    setState(() {
      if(!_formKey.currentState.validate()){
        return ;
      }
      _formKey.currentState.save();
      AuthHelper.authHelper.login(_authData['email'], _authData['pass']);
      if(_authMode==AuthMode.login){
        if(!AuthHelper.authHelper.checkVerfied())
         AuthHelper.authHelper.emailVerfication();

      }else{
        AuthHelper.authHelper.register(_authData['email'], _authData['pass']);
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         actions: [IconButton(icon: Icon(Icons.logout), onPressed: () async{
           await AuthHelper.authHelper.logOut();
         })],
        title: Text("loginAuth"),
      ),
    body: Center(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (val){
                  if(val.isEmpty || !val.contains('@')){
                    return 'Invalid email';
                  } return null;
                },
                onSaved:(val){
                  _authData['email']=val;
                  print(_authData['email']);
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                controller: _passwordContraller,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                validator:(val){
                  if(val.isEmpty || val.length<=5){
                    return 'password too short!';
                  } return null;
                },
                onSaved:(val){
                  _authData['pass']=val;
                  print(_authData['pass']);
                },
              ),
              SizedBox(height: 10,),
              if(_authMode==AuthMode.signUp)
              TextFormField(
                decoration: InputDecoration(labelText: 'confirm Password'),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                validator: _authMode==AuthMode.signUp?
                ((val){
                  if(val!=_passwordContraller.text){
                    return 'password not match!';
                  } return null;
                }):null

              ),
              SizedBox(height: 10,),
              RaisedButton(
                child: Text(_authMode==AuthMode.login?'LOGIN':'SIGN UP'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 8),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).primaryTextTheme.button.color,
                onPressed: _submit,
              ),
              SizedBox(height: 10,),
              InkWell(onTap: (){
                AuthHelper.authHelper.resetPassword(_authData['email']);
              },
              child:Text('reset pass')),
              FlatButton(
                child: Text('${_authMode==AuthMode.login?'SIGN UP':'LOGIN'} instead'),
                padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 4),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                textColor: Theme.of(context).primaryColor,
                onPressed: _switchMode,
              )
            ],
          ),
        ),
      ),
    ),

    );
  }

}