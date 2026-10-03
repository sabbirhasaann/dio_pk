import 'package:flutter/material.dart';

import 'core/networking/api_client.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ApiClient client;

  int id = 10;

  @override
  void initState() {
    super.initState();
    client = ApiClient();
    debugPrint("Client initialized...");
    getPost(id);
  }

  Future<void> getPost(int id) async {
    try {
      final response = await client.getPost(id);
      debugPrint(response.toString());
      debugPrint("Response status code... ${response.statusCode}");
      debugPrint("Response data... ${response.data}");
      debugPrint("Reponse headers... ${response.headers}");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
