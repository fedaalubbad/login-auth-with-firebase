import 'dart:io';

import 'package:auth_login_app/views/contacts/backend/contact_firebase.dart';
import 'package:auth_login_app/views/contacts/models/contact_model.dart';
import 'package:auth_login_app/views/contacts/views/contactsPage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../custom_button.dart';
import '../custom_textFeild.dart';

class SignUpScreen extends StatefulWidget{
  SignUpScreen();
  @override
  SignUpScreenState createState() {
    return SignUpScreenState();
  }
}

class SignUpScreenState extends State<SignUpScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   // getContacts();
  // }
  String name = '',
      image = 'assets/images/profile_add.png',
      email = '',
      password = '',
      confirmPassword = '';
  double height = 0.0,
      weight = 0.0;
  final _passwordContraller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  File _image;
  final picker = ImagePicker();

// تنفذ عند اختيارأو التقاط الصورة
  Future getImage(ImageSource src) async {
    final pickedFile = await picker.getImage(source: src);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No Image selected!');
      }
    });
  }

  saveName(String value) {
    this.name = value;
  }

  saveEmail(String value) {
    this.email = value;
  }

  savePassword(String value) {
    this.password = value;
  }



  validateEmail(String email) {
    if (email.length < 6) {
      return 'email is too short';
    } else if (!email.contains('@')) {
      return 'wrong email syntax!';
    }
  }

  validateName(String name) {
    if (name.length == 0) {
      return 'enter your name!';
    }
    else if (name.length < 5) {
      return 'name is too short!';
    }
  }

  validatePass(String pass) {
    if (pass.length < 10) {
      return 'phone is too short!';
    }
  }

  validateMatchPass(String pass) {
    if (pass.length == 0) {
      return 'enter confirm password!';
    } else if (pass != _passwordContraller.text) {
      return 'password not matched try again!';
    }
  }

  saveForm(BuildContext context) async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
   ContactModel contactModel=ContactModel(
       file: _image,
       name: name,
       email:email,
       phoneNo: password
   );
    ContactsFirebaseHelper.helper.addContact(contactModel);

    }
  }
  List<ContactModel>contacts;

  getContacts()async{
    contacts= await ContactsFirebaseHelper.helper.getAllContacts();
    // setState(() {
    //
    // });
  }
  update(ContactModel contactModel)async{
    ContactsFirebaseHelper.helper.editContact(contactModel);
    await getContacts();
    setState(() {

    });

  }
  delete(ContactModel contactModel)async{
    ContactsFirebaseHelper.helper.deleteContact(contactModel);
    await getContacts();
    setState(() {

    });

  }
  // void buildToast(String msg,BuildContext context) =>
  //     Toast.show(msg, context,
  //         duration: Toast.LENGTH_LONG,
  //         textColor: Colors.red,
  //         backgroundColor: Colors.amber,
  //         backgroundRadius: 5,
  //         gravity: Toast.CENTER);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      // appBar: AppBar(title: Text("SignUp"),),
      body: Padding(
        padding: const EdgeInsets.only(
           left: 12,right: 12,bottom: 12, top: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text(
              //   'Please Sign Up ',
              //   style: TextStyle(
              //     fontSize: 24,
              //   ),
              // ),
              SizedBox(
                height: size.height * 0.03,
              ),
              InkWell(
                onTap: showAlert,
                child: Stack(children: [
                  CircleAvatar(radius:50,backgroundImage: _image==null?AssetImage(image):FileImage(_image),),
                  Positioned(
                    bottom: 3,right: 3,
                      child: Icon(Icons.add_a_photo_sharp,color: Colors.pink,)
                  )
                ],),
              ),

              SizedBox(
                height: size.height * 0.03,
              ),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('enter contact name',style: TextStyle(color: Colors.blue),),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Material(
                      elevation: 10.0,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      child: CustomTextfield(
                          isPassword: false,
                          label: name,
                          save: saveName,
                          validator: validateName,
                          hint: "Name",
                          icon: Icon(Icons.edit),
                          type: TextInputType.text,),
                    ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                    Text('enter contact email',style: TextStyle(color: Colors.blue),),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Material(
                      elevation: 10.0,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      child: CustomTextfield(
                          isPassword: false,
                          label: email,
                          save: saveEmail,
                          validator: validateEmail,
                          hint: "Email",
                          icon: Icon(Icons.email),
                          type: TextInputType.emailAddress,
                      ),
                    ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                    Text('enter contact Number',style: TextStyle(color: Colors.blue),),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                Material(
                  elevation: 10.0,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                  child: CustomTextfield(
                    isPassword: false,
                    label: password,
                    save: savePassword,
                    validator: validatePass,
                    type: TextInputType.number,
                    hint: "Number",
                     passwordContraller: _passwordContraller,),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),

                // Material(
                //   elevation: 10.0,
                //   color:Colors.white,
                //   borderRadius: BorderRadius.circular(30.0),
                //   child: CustomTextfield(
                //     isPassword: true,
                //     label: confirmPassword,
                //     save: saveConfirmPassword,
                //     validator: validateMatchPass,
                //     type: TextInputType.visiblePassword,
                //     hint: "confirmPassword",),
                // ),
                //     SizedBox(
                //       height: size.height * 0.04,
                //     ),
                  Custom_Button('ADD', saveForm),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Custom_Button('Get Contacts', goContactsScreen),
                    SizedBox(
                      height: size.height * 0.04,
                    ),

                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
  //////////////////////////////////////////////////alert to choose image
showAlert(){
  var ad =AlertDialog(
    title: Text('choose image from!'),
    content: Container(
      height: 150,
      child: Column(
        children: [
          Divider(color: Colors.black,),
          Container(
            width: 300,
            color: Colors.teal,
            child: ListTile(
              title: Text('Gallery'),
              leading: Icon(Icons.image),
              onTap: (){
                Navigator.of(context).pop();
                getImage(ImageSource.gallery);
              },
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: 300,
            color: Colors.teal,
            child: ListTile(
              title: Text('Camera'),
              leading: Icon(Icons.camera_alt),
              onTap: (){
                Navigator.of(context).pop();
                getImage(ImageSource.camera);
              },
            ),
          ),
        ],
      ),
    ),
  );
  showDialog(builder: (context) => ad, context: context);
}


goContactsScreen()async{
   contacts =await ContactsFirebaseHelper.helper.getAllContacts();
  Navigator.push(context, MaterialPageRoute(builder:(context){
      return ContactPage(contacts,update,delete);
    }));
}

}