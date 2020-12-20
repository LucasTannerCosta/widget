import 'package:flutter/material.dart';
import 'package:widget/screens/home_screen.dart';
import 'package:widget/ui/cadastro_produto.dart';
import 'package:widget/ui/home_page.dart';
import 'package:widget/ui/pesquisa_empresa.dart';
import 'package:widget/ui/pesquisa_usuario.dart';

//void main() => runApp(new MyApp());
void main() {

/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pik Bom",
      theme: ThemeData(
        primarySwatch: Colors.blue,
          primaryColor: Color.fromARGB(128, 0, 128, 0)
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen()
    );
  }*/
  runApp(MaterialApp(
    home: PesquisaUsuario(),
    //home: PesquisaEmpresa(),
    //home: HomePage(),
  ));
}