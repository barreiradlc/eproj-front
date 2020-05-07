import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


import '../Telas/Home/Inicio.dart';
import '../Funcoes/UserData.dart';

class Home extends StatelessWidget {
  Widget build(BuildContext context) {
          
    return Scaffold(
        appBar: AppBar(
          title: Text('Croki', style: TextStyle(color: Colors.white))),
        body: HomeState(),
    );
  }
}

class HomeState extends StatefulWidget{
  


  @override
  Tabs createState() => Tabs();
}


class Tabs extends State<HomeState>{
  bool loading = true;
  String jwt = 'testeJWT';
  String username = '';

  var forgeJWT;
  var listItems;

  getForgeJWT() async {
    var forgeURI = 'http://eproj-teste.herokuapp.com/jwt';

    http.Response res2 = await http.get(Uri.encodeFull(forgeURI));

    var token = await jsonDecode(res2.body);

    print('token');
    print(token);
    print('token');

    setState(() {
      forgeJWT = token['access_token'];
    });

    return token;
  }

  getObjects(jwt) async {
    var bucket = 'e_proj_mvp_v2';
    var uri =
        'https://developer.api.autodesk.com/oss/v2/buckets/$bucket/objects';

    http.Response res2 = await http.get(Uri.encodeFull(uri), headers: {
      "Authorization": 'Bearer $forgeJWT',
      "Content-Type": 'application/json'
    });

    var items = await jsonDecode(res2.body);

    print('items');
    print(forgeJWT);
    print(items);
    print('items');

    setState(() {
      listItems = items;
      loading = false;
    });

    print('get objets per bucket');
  }

  @override
  void initState() {
    super.initState();
    getForgeJWT().then((res) {
      getObjects(res);
    });
  }

  @override
  Widget build(BuildContext context) {

    var drawerScaff = Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text("Bem Vindo " + this.username),
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              // image: DecorationImage(
              //   // image: bg,
              //   fit: BoxFit.cover,
              //   colorFilter: new ColorFilter.mode(
              //       Colors.black.withOpacity(0.6), BlendMode.dstATop),
              // ),
            ),
          ),
          ListTile(
            title: Text('Perfil'),
            onTap: () {
              print('perfil');
            },
          ),
          ListTile(
            title: Text('Sair'),
            onTap: () {
              print('sair');
            },
          )
        ],
      ),
    );


    // var user
    // setState(() {
    //   this.jwt = jwt;
    //   this.username = username;
    // });
    // print('out');
    // print(user);



    // if(loading){
    //       return Center(
    //         child: Wrap(
    //       children: <Widget>[
    //         Column(
    //           children: <Widget>[
    //             Container(
    //               padding: EdgeInsets.all(25),
    //               child: Text('Carregando'),
    //             ),
    //             CircularProgressIndicator(
    //                 strokeWidth: 5, backgroundColor: Colors.white10),
    //           ],
    //         )
    //       ],
    //     ));
    //   }


    // TODO: implement build
    return new Scaffold(
      // color: Colors.yellow,
      
      drawer: drawerScaff,
      body: DefaultTabController(
        length: 3,
        child: new Scaffold(
          body: TabBarView(
            children: [
              new Container(
                // color: Colors.yellow,
                child: InicioState(listItems, forgeJWT)
                // child: Text('Bem vindo ' + this.username)
              ),
              new Container(
                color: Colors.orange,
              ),
              new Container(
                color: Colors.lightGreen,
              )
              // new Container(
              //   color: Colors.red,
              // ),
              // new Container(
              //   color: Colors.orange,
              // )
            ],
          ),
          bottomNavigationBar: new TabBar(
            tabs: [
              Tab(
                icon: new Column(children: <Widget>[
                  Icon(Icons.home),
                  Text('Projetos')
                ],)
                  
              ),
              Tab(
                icon: new Column(children: <Widget>[
                  Icon(Icons.view_list),
                  Text('Materiais')
                ],)
              ),
              Tab(
                icon: new Column(children: <Widget>[
                  Icon(Icons.monetization_on),
                  Text('Cotações')
                ],)
              ),
              // Tab(
              //   icon: new Icon(Icons.format_paint),
              // ),
              // Tab(
              //   icon: new Icon(Icons.library_books),
              // )
            ],
            labelColor: Colors.green ,
            unselectedLabelColor: Colors.black38,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.only(top: 15, bottom: 15),
            labelPadding: EdgeInsets.only(top: 15),
            
            indicatorColor: Colors.transparent,
          ),
          backgroundColor: Colors.white10,
        ),
      ),
    );
  }
}
