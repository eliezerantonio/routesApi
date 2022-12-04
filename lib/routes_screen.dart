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

  List list = [];

  @override
  void initState() {
    super.initState();
    getRoutes();
  }

  Future<void> getRoutes() async {
    if (jsonDecode(await _localStorage.getItem('routes')) != null) {
      list = jsonDecode(await _localStorage.getItem('routes'));
      setState(() {});
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
              reverse: true,
              physics: const BouncingScrollPhysics(),
              itemCount: list.length,
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
                                  installationPoint!.containers)));
                    }),
                    title: Text(installationPoint!
                        .getWestType(installationPoint.typeWaste!)),
                    leading: Text(installationPoint.id == null ||
                            installationPoint.id == ''
                        ? '0'
                        : installationPoint.id! ?? ''),
                    subtitle: Text(installationPoint.streetLocal!),
                  ),
                );
              },
            )
          : const Center(
              child: Text('Sem dados para exibir'),
            ),
    );
  }
}
