import 'package:flutter/material.dart';

import 'core/networking/api_client.dart';
import './Lesson_3_Requests_and_Responses_in_Depth/request_response.dart';
import './Lesson_4_DioException_and_Production_Error_Handling/dio_error_demo_page.dart';
import './Lesson_5_Dio_Interceptors/dio_interceptors.dart';
import './Lesson_6_Authentication_Interceptor/authentication_interceptor_demo_page.dart';

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
    // debugPrint("Client initialized...");
    // getPost(id);
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

  final List<Map<String, dynamic>> screens = [
    {
      'title': 'Lesson 3 - Request and Response',
      'screen': RequestResponse(),
    },
    {
      'title': 'Lesson 4 - DioException and Production Error Handling',
      'screen': DioErrorDemoPage(),
    },
    {
      'title': 'Lesson 5 - Dio Interceptors',
      'screen': DioInterceptors(),
    },
    {
      'title': 'Lesson 6 - Authentication Interceptor',
      'screen': AuthenticationInterceptorDemoPage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: screens.length,
        itemBuilder: (context, index) {
          final item = screens[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8,
            ),
            child: Card(
              elevation: 4,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return item['screen'];
                      },
                    ),
                  );
                },
                title: Text(item['title']),
              ),
            ),
          );
        },
      ),
    );
  }
}
