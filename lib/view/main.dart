import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_map/constants/routes.dart';
import 'package:google_map/view/login.dart';
import 'package:google_map/view/map.dart';
import 'package:google_map/view/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,

    initialRoute: Routes.login,
    routes: {
      Routes.registration: (context) => RegistrationPage(),
      Routes.login: (context) => Loginpage(),
      Routes.map: (context) => MapPage(),


    },
    home: const AuthState(),
  ));
}





class AuthState extends StatelessWidget {
  const AuthState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          // if authenticated, redirect to home page
          if(snapshot.hasData){
            return const MapPage();
          }
          //if failed, show error message
          if(snapshot.hasError){
            return const Center(child: Text('Authentication Failed'),);
          }
          //while waiting, show circular progress indicator
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //else show login page
          return const Loginpage();
        },
    );
  }
}
