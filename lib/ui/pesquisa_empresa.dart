import 'dart:io';
import 'package:flutter/material.dart';
import 'package:widget/empresa/empresa.dart';
import 'cadastro_empresa.dart';

class PesquisaEmpresa extends StatefulWidget {
  @override
  _PesquisaEmpresaState createState() => _PesquisaEmpresaState();
}

class _PesquisaEmpresaState extends State<PesquisaEmpresa> {
  EmpresaItem itens = EmpresaItem();

  List<Empresa> empresa = List();

  @override
  void initState(){
    super.initState();
    itens.getAllEmpresa().then((list){
      print(list);
    });

    _getAllEmpresa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesquisa de Empresa"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showEmpresaPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: empresa.length,
          itemBuilder: (context, index) {
            return _empresaCard(context, index);
          }
      ),
      /*drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Pik Bom'),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
            ),
            ListTile(
              leading: Icon(Icons.icecream),
              title: Text('Sorvete'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Usuário'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.add_business),
              title: Text('Empresa'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.app_registration),
              title: Text('Estoque'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.add_shopping_cart),
              title: Text('Venda'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),*/
    );
  }

  Widget _empresaCard(BuildContext context, int index){
    return GestureDetector(
      child: Card(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: empresa[index].img != null ?
                          FileImage(File(empresa[index].img)) :
                          AssetImage("images/foto_padrao.jpg")
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      Text("Nome:" + empresa[index].name ?? "",
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      Text("CNPJ:" + empresa[index].cnpj ?? "",
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
      ),
      onTap: (){
        _showEmpresaPage(empresa: empresa[index]);
      },
    );
  }
  void _showEmpresaPage({Empresa empresa}) async {
    final recEmpresa = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => CadastroEmpresa(empresa: empresa,))
    );
    if (recEmpresa != null) {
      if(empresa != null) {
        await itens.updateEmpresa(recEmpresa);
      } else{
        await itens.saveEmpresa(recEmpresa);
      }
      _getAllEmpresa();
    }
  }

  void _getAllEmpresa() {
    itens.getAllEmpresa().then((list){
      setState(() {
        empresa = list;
      });
    });
  }
}
