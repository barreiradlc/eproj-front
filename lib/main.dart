import 'package:flutter/foundation.dart' show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';

import './Funcoes/UserData.dart';
// import './Telas/Cadastro.dart';
import './Telas/Home.dart';
import './Telas/Login.dart';
import 'Telas/Extras/Termos.dart';
import 'Telas/Projetos/TabBarDemo.dart';
// import 'Telas/Home/NovoProjetoPassoUm.dart';

void main() {
  // See https://github.com/flutter/flutter/wiki/Desktop-shells#target-platform-override
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(new Geral());

}

class Geral extends StatefulWidget {
  @override
  MyApp createState() => MyApp();
}

class MyApp extends State<Geral> {
  String jwt = '';
  String homePage = '/login';

  @override
  void initState(){
    super.initState();  
    void_getJWT()
      .then(( jwt ) {
        if (jwt == null){
          homePage = '/login';
        } else {
          homePage = '/home';
        }
        print(jwt);
        setState(() {
          this.jwt = jwt;
          this.homePage = homePage;
          // this.username = username;
        });
      });
  }
  

  var inicio = new Home();
  var login = new Login();
  // var cadastro = new Cadastro();
  var terms = new Termos();
  var projetos = new TabBarDemo();
  // var novo_um = new NovoProjetoPassoUm();

  @override
  Widget build(BuildContext context) {

    if (this.homePage != ''){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          // See https://github.com/flutter/flutter/wiki/Desktop-shells#fonts
          fontFamily: 'Roboto',
        ),
        // MaterialApp(
      // ROUTES
      // routes: {
      //   "/": (_) => new WebviewScaffold(
      //     url: "https://eproj.glideapp.io",
      //     // appBar: new AppBar(
      //     //   title: new Text("EPROJ"),
      //     // ),
      //   ),
      // },
      // ROUTES
    
        // initialRoute: this.homePage,   
        initialRoute: '/home',   
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/login': (context) => login,
          // '/cadastro': (context) => cadastro,
          '/terms': (context) => terms,
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/home': (context) => inicio,
          '/projetos': (context) => projetos,
          
          // '/novo_um': (context) => novo_um,

    
    
        },
        
      );



    } else {
      return CircularProgressIndicator();
    }
    

  }
}
