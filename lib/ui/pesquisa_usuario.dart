import 'dart:io';
import 'package:flutter/material.dart';
import 'package:widget/usuario/usuario.dart';
import 'cadastro_usuario.dart';

class PesquisaUsuario extends StatefulWidget {
  @override
  _PesquisaUsuarioState createState() => _PesquisaUsuarioState();
}

class _PesquisaUsuarioState extends State<PesquisaUsuario> {
  UsuarioItem itens = UsuarioItem();

  List<Usuario> usuario = List();

  @override
  void initState(){
    super.initState();
    itens.getAllUsuario().then((list){
      print(list);
    });

    _getAllUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesquisa de Usuário"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showUsuarioPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: usuario.length,
          itemBuilder: (context, index) {
            return _usuarioCard(context, index);
          }
      ),
    );
  }

  Widget _usuarioCard(BuildContext context, int index){
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
                          image: usuario[index].img != null ?
                          FileImage(File(usuario[index].img)) :
                          AssetImage("images/foto_padrao.jpg")
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      Text("Loging:" + usuario[index].login ?? "",
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
        _showUsuarioPage(usuario: usuario[index]);
      },
    );
  }
  void _showUsuarioPage({Usuario usuario}) async {
    final recUsuario = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => CadastroUsuario(usuario: usuario,))
    );
    if (recUsuario != null) {
      if(usuario != null) {
        await itens.updateUsuario(recUsuario);
      } else{
        await itens.saveUsuario(recUsuario);
      }
      _getAllUsuario();
    }
  }

  void _getAllUsuario() {
    itens.getAllUsuario().then((list){
      setState(() {
        usuario = list;
      });
    });
  }
}
