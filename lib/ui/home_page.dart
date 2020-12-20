import 'dart:io';
import 'package:flutter/material.dart';
import 'package:widget/produto/produto_itens.dart';
import 'cadastro_produto.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProdutoItem itens = ProdutoItem();

  List<Produto> produto = List();

  @override
 // void inistate() {
   // super.initState();
 // }

  @override
  void initState(){
    super.initState();

    /*Produto p = Produto();
    p.name = "Teste33";
    p.peso = "50";
    itens.saveProduto(p);
    print("Inicio");*/
    itens.getAllProduto().then((list){
      print(list);
    });
    print("Fim");
    _getAllProduto();

   // itens.deleteProduto('Teste');
    itens.getAllProduto().then((list){
      print(list);
    });

    _getAllProduto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesquisa de Sorvete"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showProdutoPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: produto.length,
        itemBuilder: (context, index) {
          return _produtoCard(context, index);
        }
      ),
    );
  }
  Widget _produtoCard(BuildContext context, int index){
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
                      image: produto[index].img != null ?
                      FileImage(File(produto[index].img)) :
                          AssetImage("images/foto_padrao.jpg")
                  )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Text("Nome:" + produto[index].name ?? "",
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Text("Peso: " + produto[index].peso ?? "",
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ),
      onTap: (){
        _showProdutoPage(produto: produto[index]);
      },
    );
  }
  void _showProdutoPage({Produto produto}) async {
    final recProduto = await Navigator.push(context,
      MaterialPageRoute(builder: (context) => CadastroProduto(produto: produto,))
    );
    if (recProduto != null) {
      if(produto != null) {
        await itens.updateProduto(recProduto);
      } else{
        await itens.saveProduto(recProduto);
      }
        _getAllProduto();
    }
  }

  void _getAllProduto() {
    itens.getAllProduto().then((list){
      setState(() {
        produto = list;
      });
    });
  }
}
