import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthHelper{
  AuthHelper._();
  static AuthHelper authHelper=AuthHelper._();
  FirebaseAuth auth=FirebaseAuth.instance;
  register(String email,String password)async{
    try{
      UserCredential userCredential=await auth.createUserWithEmailAndPassword(email: email, password: password);
      String id=userCredential.user.uid;
      String token=await userCredential.user.getIdToken();
      print('user id=$id');
      print('user token=$token');
    }catch(error){
      print(error);
    }
  }
  login(String email,String password)async{
    try{
      UserCredential userCredential=await auth.signInWithEmailAndPassword(email: email, password: password);
      String id=userCredential.user.uid;
      String token=await userCredential.user.getIdToken();
      print('user id=$id');
      print('user token=$token');
    }catch(error){
      print(error);
    }
  }
  emailVerfication()async{
    User user = auth.currentUser;
    // if (!checkVerfied()) {
      await user.sendEmailVerification();
    // }
  }
bool checkVerfied(){
    User user = auth.currentUser;
    bool result =user.emailVerified ;
    return result;
  }
 bool checkUser(){
    return auth.currentUser!=null;
  }

  logOut()async{
    print('${checkUser()}');
    if(checkUser())
    await auth.signOut();
  }
  resetPassword(String email)async{
      await auth.sendPasswordResetEmail(email: email);
  }

}