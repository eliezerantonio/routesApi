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
  TextEditingController textController = TextEditingController();

  late final ScrollController _scrollController;
  List list = [];
  bool max = false;
  InstallationPoint installationPoint = InstallationPoint();
  List<RouteElement> elements = [];

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pontos de Instalação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 44,
              child: TextField(
                controller: textController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                for (int i = 0; i < list.length; i++) {
                  elements.add(RouteElement.fromJson(list[i]));
                }

                for (var element in elements) {
                  for (var installationPoints in element.installationPoints
                      .where((element) => element.id == textController.text)) {
                    installationPoint = installationPoints;
                  }
                }

                setState(() {});
              },
              child: const Text('Buscar'),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              child: ListTile(
                onTap: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ContainersScreen(installationPoint!.containers!),
                    ),
                  );
                }),
                title: Text(installationPoint!.typeWaste != null
                    ? installationPoint!
                        .getWestType(installationPoint!.typeWaste!)
                    : ''),
                leading: Text(
                    installationPoint!.id == null || installationPoint!.id == ''
                        ? '0'
                        : installationPoint!.id!),
                subtitle: Text(installationPoint!.streetLocal != '' &&
                        installationPoint!.streetLocal != null
                    ? installationPoint!.streetLocal!
                    : ''),
              ),
            )
          ],
        ),
      ),
    );
  }
}
