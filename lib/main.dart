import 'package:auth_login_app/views/contacts/backend/contact_firebase.dart';
import 'package:auth_login_app/views/contacts/models/contact_model.dart';
import 'package:auth_login_app/views/contacts/views/contactsPage.dart';
import 'package:auth_login_app/views/sign_up.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:permission_handler/permission_handler.dart';

void main(){
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MaterialApp(home: App()));
}

class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
   Future<FirebaseApp> _initialization ;
  bool isLoading = false;

  bool _hasPermission;
  @override
  void initState() {
    super.initState();
    _initialization= Firebase.initializeApp().whenComplete(() {
      print("completed");
      _askPermissions();

      setState(() {});
    });
  }


  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus;
    while (permissionStatus != PermissionStatus.granted) {
      try {
        permissionStatus = await _getContactPermission();
        if (permissionStatus != PermissionStatus.granted) {
          _hasPermission = false;
          _handleInvalidPermissions(permissionStatus);
        } else {
          _hasPermission = true;
        }
      } catch (e) {
        if (await showPlatformDialog(
            context: context,
            builder: (context) {
              return PlatformAlertDialog(
                title: Text('Contact Permissions'),
                content: Text(
                    'We are having problems retrieving permissions.  Would you like to '
                        'open the app settings to fix?'),
                actions: [
                  PlatformDialogAction(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text('Close'),
                  ),
                  PlatformDialogAction(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text('Settings'),
                  ),
                ],
              );
            }) == true) {
          await openAppSettings();
        }
      }
    }

    // await Navigator.push(context,MaterialPageRoute(builder: (context)
    //    {
    //   return ContactPage();
    // })
    // );
  }

  Future<PermissionStatus> _getContactPermission() async {
    final status = await Permission.contacts.status;
    if (!status.isGranted) {
      final result = await Permission.contacts.request();
      return result;
    } else {
      return status;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      throw PlatformException(
          code: 'PERMISSION_DENIED',
          message: 'Access to location data denied',
          details: null);
    } else if (permissionStatus == PermissionStatus.restricted) {
      throw PlatformException(
          code: 'PERMISSION_DISABLED',
          message: 'Location data is not available on device',
          details: null);
    }
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error'),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
               return SignUpScreen();
          // return Scaffold(
          //   body: Stack(
          //     children: [
          //       Container(
          //         height: MediaQuery.of(context).size.height,
          //         width: MediaQuery.of(context).size.width,
          //         child: Center(
          //           child: ElevatedButton(
          //             child: Text('auth'),
                      // onPressed: () async {

                        // ProductsFirebaseHelper.helper.getAllProducts();
                        // List<Product> pro= await ProductsFirebaseHelper.helper.getAllProducts();
                        // print('listLength=${pro.length}');
                        // PickedFile pickedFile = await ImagePicker()
                        //     .getImage(source: ImageSource.camera);
                        // File file = File(pickedFile.path);
                        // Product product = Product(
                        //     descriptionAr: 'وصف',
                        //     descriptionEn: 'description',
                        //     file: file,
                        //     nameAr: 'اسم',
                        //     nameEn: 'name',
                        //     price: 50.2);
                        // ProductsFirebaseHelper.helper.addProduct(product);
                        // AuthHelper.authHelper.logout();
                        // AuthHelper.authHelper.saveUserInFirestore();
                        // print(FirebaseAuth.instance.currentUser.emailVerified);
                        // isLoading =
                        // AuthHelper.authHelper
                        //     .login('shady.samara@gmail.com', '1234567');
                //       },
                //     ),
                //   ),
                // ),
                // isLoading
                //     ? Positioned.fill(
                //     child: Align(
                //       alignment: Alignment.center,
                //       child: CircularProgressIndicator(),
                //     ))
                //     : Container()
              // ],
          //   ),
          // );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          body: Center(
            child: Text('Loading'),
          ),
        );
      },
    );
  }


}