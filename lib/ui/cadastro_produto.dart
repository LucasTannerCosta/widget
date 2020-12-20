import 'dart:io';
import 'package:flutter/material.dart';
import 'package:widget/produto/produto_itens.dart';

class CadastroProduto extends StatefulWidget {
  final Produto produto;
  CadastroProduto({this.produto});
  @override
  _CadastroProdutoState createState() => _CadastroProdutoState();
}

class _CadastroProdutoState extends State<CadastroProduto>{
  final _nameProduto = TextEditingController();
  final _pesoProduto = TextEditingController();

  final _nameFocus = FocusNode();

  bool _userEdited = false;
  Produto _editedProduto = Produto();

  @override
  void initSate() {
    super.initState();

    if(widget.produto == null){
      _editedProduto = Produto();
    } else {
      _editedProduto = Produto.FromMap((widget.produto.toMap()));
      _nameProduto.text = _editedProduto.name;
      _pesoProduto.text = _editedProduto.peso;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(_editedProduto.name ?? "Novo Sorvete"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(_editedProduto.name != null && _editedProduto.name.isNotEmpty) {
            Navigator.pop(context, _editedProduto);
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
                      image: _editedProduto.img != null ?
                      FileImage(File(_editedProduto.img)) :
                      AssetImage("images/foto_padrao.jpg")
                  )
                ),
              ),
            ),
            TextField(
              controller: _nameProduto,
              focusNode: _nameFocus,
              decoration: InputDecoration(labelText: "Nome"),
              onChanged: (text){
                _userEdited = true;
                setState(() {
                  _editedProduto.name = text;
                });
              },
            ),
            TextField(
              controller: _pesoProduto,
              decoration: InputDecoration(labelText: "Peso"),
              onChanged: (text){
                _userEdited = true;
                _editedProduto.peso = text;
              },
              keyboardType: TextInputType.phone,
            ),
          ]
        ),
      ),
    );
  }
}