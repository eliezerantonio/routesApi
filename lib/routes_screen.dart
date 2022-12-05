import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'container_model.dart';
import 'containers_screen.dart';

class RoutesScreen extends StatefulWidget {
  const RoutesScreen({super.key});

  @override
  State<RoutesScreen> createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {
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

      index = 10;
      //criando InfiniteScroll

      //em cada requisição recebemos muitos resultados
      //se exibir tudo de uma vez teremos uma queda de performance
      //então vamos exibir 10  resultados de cada vez


      _scrollController.addListener(() {

        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
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
      body: list.isNotEmpty
          ? ListView.builder(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              itemCount: index,
              itemBuilder: (BuildContext context, int index) {
                final RouteElement element = RouteElement.fromJson(list[index]);
                InstallationPoint? installationPoint;

                for (int i = 0; i < element.installationPoints.length; i++) {
                  installationPoint = element.installationPoints[i];
                }

                return Card(
                  child: ListTile(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ContainersScreen(
                                  installationPoint!.containers!)));
                    }),
                    title: Text(installationPoint!.getWestType(installationPoint.typeWaste!)),
                    leading: Text(installationPoint.id == null || installationPoint.id == '' ? '0'
                        : installationPoint.id! ?? ''),
                    subtitle: Text(installationPoint.streetLocal!),
                  ),
                );
              },
            )
          : const Center(child: Text('Sem dados para exibir')),
    );
  }
}
