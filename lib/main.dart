import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String urlApi = "https://love-calculator.p.rapidapi.com/getPercentage?";

String mensagemFinal = "";
var porcentagem;


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Crolove'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String nome1 = "hullsem";
  String nome2 = "bolsonaro";
  var mensagem;

  getBuscar() async{
    http.Response resposta = await http.get(urlApi + "fname=$nome1&sname=$nome2",
    headers:{
      "x-rapidapi-host": "love-calculator.p.rapidapi.com",
		  "x-rapidapi-key": "2187087fe3msh1d1594de56fc096p1f19aajsndc0ab37b8107"
    }
    
    );
    
 
 
 setState(() {

    mensagem = jsonDecode(resposta.body);
    print(mensagem);

     mensagemFinal = mensagem["result"];
     porcentagem = mensagem["percentage"];

 Navigator.push(context, 
      
   MaterialPageRoute(builder:(context) => ResultadoPag()
   )

 );

 });
 
 
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          
            TextField(
              onChanged: (texto){
                nome1 = texto;
              },
          decoration: InputDecoration(
          labelText: 'Digite Seu nome:'
           ),
        ),
            TextField(
          onChanged: (texto){
            nome2 = texto; 
          },   
          decoration: InputDecoration(
          labelText: 'Digite o nome do seu crush:'
           ),
        ),
           
          
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed : (){
          getBuscar();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

  class ResultadoPag extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: Container(
            
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 Text(
                    porcentagem == null ? "error" : porcentagem + "%",
                    style: TextStyle(
                      fontSize: 50
                    ), 
            
                   ),
                  Text(
                      mensagemFinal == null ? "error" : mensagemFinal,
                      style: TextStyle(
                        fontSize: 25
                      )

                    )
        ],),
        
         ), 
        )
      );
    }
  }
