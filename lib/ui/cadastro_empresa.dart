import 'dart:io';
import 'package:flutter/material.dart';
import 'package:widget/empresa/empresa.dart';

class CadastroEmpresa extends StatefulWidget {
  final Empresa empresa;
  CadastroEmpresa({this.empresa});
  @override
  _CadastroEmpresaState createState() => _CadastroEmpresaState();

}
class _CadastroEmpresaState extends State<CadastroEmpresa>{
  final _nameEmpresa = TextEditingController();
  final _cnpjEmpresa = TextEditingController();
  final _enderecoEmpresa = TextEditingController();
  final _cepEmpresa = TextEditingController();
  final _estadoEmpresa = TextEditingController();
  final _cidadeEmpresa = TextEditingController();
  final _emailEmpresa = TextEditingController();
  final _telefoneEmpresa = TextEditingController();
  final _imgEmpresa = TextEditingController();

  final _nameFocus = FocusNode();

  bool _userEdited = false;
  Empresa _editedEmpresa;// = Empresa();

  @override
  void initSate() {
    super.initState();

    if(widget.empresa == null){
      _editedEmpresa = Empresa();
    } else {
      _editedEmpresa = Empresa.FromMap((widget.empresa.toMap()));
      _nameEmpresa.text = _editedEmpresa.name;
      _cnpjEmpresa.text = _editedEmpresa.cnpj;
      _enderecoEmpresa.text = _editedEmpresa.endereco;
      _cepEmpresa.text = _editedEmpresa.cep;
      _estadoEmpresa.text = _editedEmpresa.cidade;
      _cidadeEmpresa.text = _editedEmpresa.cidade;
      _emailEmpresa.text = _editedEmpresa.email;
      _telefoneEmpresa.text = _editedEmpresa.telefone;
      _imgEmpresa.text = _editedEmpresa.img;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(_editedEmpresa.name ?? "Novo Empresa"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(_editedEmpresa.name != null && _editedEmpresa.name.isNotEmpty) {
            Navigator.pop(context, _editedEmpresa);
          } else {
            FocusScope.of(context).requestFocus(_nameFocus);
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
                          image: _editedEmpresa.img != null ?
                          FileImage(File(_editedEmpresa.img)) :
                          AssetImage("images/foto_padrao.jpg")
                      )
                  ),
                ),
              ),
              TextField(
                controller: _nameEmpresa,
                focusNode: _nameFocus,
                decoration: InputDecoration(labelText: "Nome"),
                onChanged: (text){
                  _userEdited = true;
                  setState(() {
                    _editedEmpresa.name = text;
                  });
                },
              ),
              TextField(
                controller: _cnpjEmpresa,
                decoration: InputDecoration(labelText: "CNPJ"),
                onChanged: (text){
                  _userEdited = true;
                  _editedEmpresa.cnpj = text;
                },
              ),
              TextField(
                controller: _enderecoEmpresa,
                decoration: InputDecoration(labelText: "Endereço"),
                onChanged: (text){
                  _userEdited = true;
                  _editedEmpresa.endereco = text;
                },
              ),
              TextField(
                controller: _cepEmpresa,
                decoration: InputDecoration(labelText: "CEP"),
                onChanged: (text){
                  _userEdited = true;
                  _editedEmpresa.endereco = text;
                },
              ),
              TextField(
                controller: _estadoEmpresa,
                decoration: InputDecoration(labelText: "Estado"),
                onChanged: (text){
                  _userEdited = true;
                  _editedEmpresa.estado = text;
                },
              ),
              TextField(
                controller: _cidadeEmpresa,
                decoration: InputDecoration(labelText: "Cidade"),
                onChanged: (text){
                  _userEdited = true;
                  _editedEmpresa.cidade = text;
                },
              ),
              TextField(
                controller: _emailEmpresa,
                decoration: InputDecoration(labelText: "Email"),
                onChanged: (text){
                  _userEdited = true;
                  _editedEmpresa.email = text;
                },
              ),
              TextField(
                controller: _telefoneEmpresa,
                decoration: InputDecoration(labelText: "Telefone"),
                onChanged: (text){
                  _userEdited = true;
                  _editedEmpresa.telefone = text;
                },
              ),
            ]
        ),
      ),
    );
  }
}