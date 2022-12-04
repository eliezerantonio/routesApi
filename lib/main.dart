import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes_screen.dart';
import 'package:localstorage/localstorage.dart';
import 'package:url_launcher/url_launcher.dart';

import 'api.dart';
import 'routes_by_id_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocalStorage _localStorage = LocalStorage('same');

  final String _url =
      'https://api1.kentratech.com:8443/auth/realms/kforms-test/protocol/openid-connect/auth?client_id=kforms-demo-ui&redirect_uri=http%3A%2F%2F94.130.225.32%3A8089%2Fforms%2Fanswer%2F619d1a520cf11b00123c6b00&state=85ce57a1-9582-45d4-820e-a4e326886ebc&response_mode=fragment&response_type=code&scope=openid&nonce=92fa179d-6dd5-4fcb-8c9c-7aa544200315';

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(_url))) {
      throw 'Could not launch $_url';
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Pontos de instalação',
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () async {
                isLoading = true;
                setState(() {});
                final myRoutes = await ContainerApi.instance.execute();

                await _localStorage.setItem('routes',
                    json.encode(myRoutes.map((e) => e.toJson()).toList()));

                isLoading = false;
                setState(() {});
              },
              child: const Text('Salvar dados'),
            ),
            OutlinedButton(
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const RoutesScreen()));
              },
              child: const Text('Ver dados'),
            ),
            OutlinedButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const RoutesByIdScreen()));
              },
              child: const Text('Ver dados específicos'),
            ),
            ElevatedButton(
              onPressed: () async {
                _launchUrl();
              },
              child: const Text('Abrir Url'),
            ),
            if (isLoading) const Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    ));
  }
}
