import 'package:flutter/material.dart';

import 'networking/api_client.dart';
import 'errors/app_exception.dart';

class DioErrorDemoPage extends StatefulWidget {
  const DioErrorDemoPage({super.key});

  @override
  State<DioErrorDemoPage> createState() => _DioErrorDemoPageState();
}

class _DioErrorDemoPageState extends State<DioErrorDemoPage> {
  late final ApiClient apiClient;

  String _message = 'Press a button';
  bool _loading = false;

  Future<void> _loadValidPost() async {
    setState(() {
      _loading = true;
      _message = 'Loading...';
    });

    try {
      final response = await apiClient.getValidPost();
      setState(() {
        _message =
            '''
            Success

            Status: ${response.statusCode}
            
            Data: ${response.data}
            ''';
      });
    } on AppException catch (e) {
      setState(() {
        _message = e.message;
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _loadMissingPost() async {
    setState(() {
      _loading = true;
      _message = 'Loading...';
    });

    try {
      final response = await apiClient.getMissingPost();

      setState(() {
        _message =
            '''
            Success

            Status: ${response.statusCode}

            Data: ${response.data}
            ''';
      });
    } on AppException catch (e) {
      setState(() {
        _message = e.message;
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _triggerServerError() async {
    try {
      setState(() {
        _loading = true;
      });
      final response = await apiClient.triggerServerError();
      debugPrint(response.toString());
    } on AppException catch (e) {
      setState(() {
        _message = e.message;
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    apiClient = ApiClient();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dio Error Handling'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _loading ? null : _loadValidPost,
              child: const Text('Valid Request'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loading ? null : _loadMissingPost,
              child: const Text('404 Request'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loading ? null : _triggerServerError,
              child: const Text('Trigger Server Error'),
            ),
            const SizedBox(height: 24),
            if (_loading)
              const CircularProgressIndicator()
            else
              Expanded(
                child: SingleChildScrollView(
                  child: Text(_message),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
