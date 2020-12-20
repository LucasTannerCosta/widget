import 'package:flutter/material.dart';
import 'package:widget/ui/home_page.dart';
import 'package:widget/ui/pesquisa_usuario.dart';
import 'package:widget/widget/custom_drawer.dart';

class HomeScreen extends StatelessWidget{
  final _pageCotroller = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageCotroller,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          //body: HomePage(),
          body: PesquisaUsuario(),
          drawer: CustomDrawer(),
        )
      ]
    );
  }
}