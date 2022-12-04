import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'container_model.dart';
import 'containers_screen.dart';

class RoutesByIdScreen extends StatefulWidget {
  const RoutesByIdScreen({super.key});

  @override
  State<RoutesByIdScreen> createState() => _RoutesByIdScreenState();
}

class _RoutesByIdScreenState extends State<RoutesByIdScreen> {
  final LocalStorage _localStorage = LocalStorage('same');

  late final ScrollController _scrollController;
  int index = 0;
  List list = [];
  bool max = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    getRoutes();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> getRoutes() async {
    if (jsonDecode(await _localStorage.getItem('routes')) != null) {
      list = jsonDecode(await _localStorage.getItem('routes'));

      setState(() {});
    }
    if (list.isNotEmpty) {
      //criando InfiniteScroll

//em cada requisição recebemos muitos resultados
//se exibir tudo de uma vez teremos uma queda de performance
//então vamos exibir 10  resultados de cada vez
      index = 10;

      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          if (index < list.length) {
            index = index + 10;
            setState(() {});
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pontos de Instalação'),
        ),
        body: Column(
          children: [],
        ));
  }
}
