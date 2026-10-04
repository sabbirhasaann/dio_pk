import 'package:flutter/material.dart';

import 'networking/api_client.dart';

class RequestResponse extends StatefulWidget {
  const RequestResponse({super.key});

  @override
  State<RequestResponse> createState() {
    return _RequestResponseState();
  }
}

class _RequestResponseState extends State<RequestResponse> {
  String message = "Request posts";
  bool isLoading = false;
  late final ApiClient client;

  @override
  void initState() {
    super.initState();
    client = ApiClient();
  }

  Future<void> getPosts() async {
    try {
      setState(() {
        isLoading = true;
      });

      final response = await client.getPosts();
      // debugPrint(response.toString());

      debugPrint('Status: ${response.statusCode}');
      debugPrint('Headers: ${response.headers}');
      // debugPrint('Data: ${response.data}');
    } on Exception catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: .end,
        crossAxisAlignment: .center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 32,
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: getPosts,
                child: isLoading
                    ? SizedBox(
                        height: 24,
                        width: 24,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : Text(message),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
