import 'package:flutter/material.dart';

import './networking/api_client.dart';

import 'package:dio_pk/Lesson_5_Dio_Interceptors/errors/app_exception.dart';

class DioInterceptors extends StatefulWidget {
  const DioInterceptors({super.key});

  @override
  State<DioInterceptors> createState() {
    return _DioInterceptorsState();
  }
}

class _DioInterceptorsState extends State<DioInterceptors> {
  String _message = 'Presse the button';
  bool _loading = false;

  late final ApiClient apiClient;
  int id = 1;

  @override
  void initState() {
    super.initState();
    apiClient = ApiClient();
  }

  Future<void> getPost() async {
    try {
      setState(() {
        _loading = true;
        _message = 'Sending request...';
      });

      final response = await apiClient.getPost(id);
      setState(() {
        _message = response.toString();
      });
    } on AppException catch (e) {
      debugPrint("Catch error...");
      setState(() {
        _message = e.message;
      });
    } catch (e, stackTrace) {
      debugPrint("Unexpected error!");
      debugPrint("Unexpected error fallback triggered!");
      debugPrint("Type of e: ${e.runtimeType}");
      debugPrint("e toString: $e");
      debugPrint(stackTrace.toString());
      setState(() {
        _message = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dio Interceptors',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: .center,
            children: [
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: _loading ? null : getPost,
                child: _loading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: const CircularProgressIndicator(
                          strokeWidth: 3,
                        ),
                      )
                    : Text(
                        'Request',
                      ),
              ),

              const SizedBox(
                height: 24,
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    _message,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
