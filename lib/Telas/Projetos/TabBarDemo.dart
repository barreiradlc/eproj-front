import 'dart:convert';

import 'package:EPROJ/Objetos/Projeto.dart';
import 'package:flutter/material.dart';

class TabBarDemo extends StatefulWidget {
  @override
  TabBarDemoState createState() => TabBarDemoState();
}

class TabBarDemoState extends State<TabBarDemo> {

  @override
  void initState() {
    super.initState();
    print('list');
    // print(widget.listItems);
  }

  @override
  Widget build(BuildContext context){
    Projeto item = ModalRoute.of(context).settings.arguments;
    var urn = base64Url.encode(utf8.encode(item.id));
  
    print('urn');
    print(urn);

    return Container(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.attach_file)),
                Tab(icon: Icon(Icons.menu)),
                Tab(icon: Icon(Icons.table_chart)),
              ],
            ),
            title: Text(item.key),
          ),
          body: TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}