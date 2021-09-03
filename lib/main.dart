import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'libro.dart';
import 'libroScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LibriScreen(),
    );
  }
}

class LibriScreen extends StatefulWidget {
  @override
  _LibriScreenState createState() => _LibriScreenState();
}

class _LibriScreenState extends State<LibriScreen> {
  String risultato="";
  Icon icona=Icon(Icons.search);
  Widget widgetRicerca=Text("Libri");

  List<Libro> libri=<Libro>[];

  @override
  void initState() {
    cercaLibri("Flutter");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widgetRicerca,
        actions: [
          IconButton(
            onPressed:(){
              setState(() {
                if(this.icona.icon == Icons.search){
                  this.icona=Icon(Icons.cancel);
                  this.widgetRicerca=TextField(
                    textInputAction: TextInputAction.search,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                    onSubmitted: (testoRicerca){
                      cercaLibri(testoRicerca);
                    },
                  );
                }
                else{
                  setState(() {
                    this.icona=Icon(Icons.search);
                    widgetRicerca=Text("Libri");
                  });
                }
              });
            },
            icon: icona,
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: libri.length,
          itemBuilder: ((BuildContext context,int posizione){
            return Card(
              elevation: 2,
              child: ListTile(
                onTap: (){
                    MaterialPageRoute route=MaterialPageRoute(builder: (_)=>LibroScreen(libri[posizione]));
                    Navigator.push(context, route);
                  },
                leading: Image.network(libri[posizione].immagineCopertina),
                title: Text(libri[posizione].titolo),
                subtitle: Text(libri[posizione].autori),
              ),
            );
          })
      ),
    );
  }

  Future cercaLibri(String ricerca) async {
    final String url = "https://www.googleapis.com/books/v1/volumes?q=" + ricerca;
    try {
      http.get(Uri.parse(url)).then((res) {
        final resJson = jsonDecode(res.body);
        final libriMap = resJson['items'];
        libri = libriMap.map<Libro>((mappa) => Libro.fromMap(mappa)).toList();
        setState(() {
          risultato = res.body;
          libri = libri;
        });
      });
    }
    catch(errore){
      print(errore.toString());
      setState(() {
        risultato="";
      });
    }
    setState(() {
      risultato="Richiesta in corso";
    });
  }
}

