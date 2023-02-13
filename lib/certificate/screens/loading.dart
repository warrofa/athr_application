
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import '../Services/FactoryContract.dart';

class CertSplashScreen extends StatefulWidget {
  const CertSplashScreen({super.key});

  @override
  _CertSplashScreenState createState() => _CertSplashScreenState();
}

class _CertSplashScreenState extends State<CertSplashScreen> {

  
  @override
  void initState() {
    super.initState();

    routeTo();
  }

  routeTo() async {

     Future.delayed(const Duration(seconds: 2), () {
      debugPrint("value of prKey is ${prKey.toString()}");

      (prKey != null && prKey != "") ? 
       Navigator.pushNamed(context, "cert_home_screen") : Navigator.pushNamed(context, "cert_login_screen") ;
        
      
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<FactoryContract>(context);
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: const Center(
          child: CircularProgressIndicator(
          color: Colors.white,
        )),
      ),
    );
  }
}
