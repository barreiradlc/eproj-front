import 'package:EPROJ/Objetos/Projeto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

class InicioState extends StatefulWidget {
  final listItems;
  final forgeJWT;
  InicioState(this.listItems, this.forgeJWT);

  @override
  Inicio createState() => Inicio();
}

class Inicio extends State<InicioState> {

  @override
  void initState() {
    super.initState();
    print('list');
    print(widget.listItems);
  }


  @override
  Widget build(BuildContext context) {
    
    getThumbnail(key) async {
    var urn = base64Url.encode(utf8.encode(key));
    var uri = 'https://developer.api.autodesk.com/modelderivative/v2/designdata/$urn/thumbnail';
    
    print('item');
    print(urn);

    http.Response res2 = await http.get(Uri.encodeFull(uri), 
      headers: {
        "Authorization": 'Bearer ${widget.forgeJWT}',
        "Content-Type": 'image/png'
    });

    var response = await res2;

      print('response');
      print(response);
      // setState(() {
        return Image.memory(response.bodyBytes);
      // });

      // print(widget.forgeJWT);

      return Icon(Icons.home, size: 50);
    }


    if (widget.listItems != null) {
      return Container(
        child: ListView.builder(
        // Let the ListView know how many items it needs to build.
        itemCount: widget.listItems['items'].length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          final item = widget.listItems['items'][index];

          Image thumbnail;

          getThumbnail(item['objectId']).then((res) {
            if(res != null){
              thumbnail = res;
            }
          });

          print(index);

          return Container(

            padding: EdgeInsets.symmetric(vertical: 10),
            margin: EdgeInsets.symmetric(vertical: 10),
            color: Colors.white,
            child: ListTile(
            leading: thumbnail != null ? thumbnail : Icon(Icons.home, size: 50),
            title: Text(item['objectKey']),
            subtitle: Text(item['objectKey']),
            onTap: () {
               Navigator.pushNamed(
                        context,
                        '/projetos',
                        arguments: Projeto(
                                                  item['objectKey'],
                                                  item['objectId']
                                                )
                                       );
                                    },
                                    )
                                  );
                                },
                              ));
                            }
                        
                            return Center(
                                child: Wrap(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(25),
                                      child: Text('Carregando'),
                                    ),
                                    CircularProgressIndicator(
                                        strokeWidth: 5, backgroundColor: Colors.white10),
                                  ],
                                )
                              ],
                            ));
                          }
                        }
                        
