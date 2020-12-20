import 'dart:io';
import 'package:flutter/material.dart';
import 'package:widget/usuario/usuario.dart';

class CadastroUsuario extends StatefulWidget {
  final Usuario usuario;
  CadastroUsuario({this.usuario});
  @override
  _CadastroUsuarioState createState() => _CadastroUsuarioState();

}
class _CadastroUsuarioState extends State<CadastroUsuario>{
  final _loginUsuario = TextEditingController();
  final _senhaUsuario = TextEditingController();

  final _loginFocus = FocusNode();

  bool _userEdited = false;
  Usuario _editedUsuario = Usuario();

  @override
  void initSate() {
    super.initState();

    if(widget.usuario == null){
      _editedUsuario = Usuario();
    } else {
      _editedUsuario = Usuario.FromMap((widget.usuario.toMap()));
      _loginUsuario.text = _editedUsuario.login;
      _senhaUsuario.text = _editedUsuario.senha;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(_editedUsuario.login ?? "Novo Usuário"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(_editedUsuario.login != null && _editedUsuario.login.isNotEmpty) {
            Navigator.pop(context, _editedUsuario);
          } else {
            FocusScope.of(context).requestFocus(_loginFocus);
          }
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  width: 140.0,
                  height: 140.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: _editedUsuario.img != null ?
                          FileImage(File(_editedUsuario.img)) :
                          AssetImage("images/foto_padrao.jpg")
                      )
                  ),
                ),
              ),
              TextField(
                controller: _loginUsuario,
                focusNode: _loginFocus,
                decoration: InputDecoration(labelText: "Login"),
                onChanged: (text){
                  _userEdited = true;
                  setState(() {
                    _editedUsuario.login = text;
                  });
                },
              ),
              TextField(
                obscureText: true,
                controller: _senhaUsuario,
                decoration: InputDecoration(labelText: "Senha"),
                onChanged: (text){
                  _userEdited = true;
                  _editedUsuario.senha = text;
                },
                keyboardType: TextInputType.visiblePassword,
              ),
              
            ]
        ),
      ),
    );
  }
}