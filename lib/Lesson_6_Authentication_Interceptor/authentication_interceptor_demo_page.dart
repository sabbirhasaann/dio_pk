import 'package:flutter/material.dart';

import 'auth/token_storage.dart';
import 'networking/api_client.dart';

class AuthenticationInterceptorDemoPage extends StatefulWidget {
  const AuthenticationInterceptorDemoPage({super.key});

  @override
  State<AuthenticationInterceptorDemoPage> createState() {
    return _AuthenticationInterceptorDemoPageState();
  }
}

class _AuthenticationInterceptorDemoPageState
    extends State<AuthenticationInterceptorDemoPage> {
  late final TokenStorage tokenStorage;
  late final ApiClient apiClient;

  String _result = 'No request yet';
  bool _loading = false;

  @override
  void initState() {
    super.initState();

    tokenStorage = InMemoryTokenStorage();
    apiClient = ApiClient(
      tokenStorage: tokenStorage,
    );
  }

  Future<void> _saveToken() async {
    await tokenStorage.saveAccessToken(
      'demo-access-token-123',
    );
    setState(() {
      _result =
          'Access token saved.\n\n'
          'demo-access-token-123';
    });
  }

  Future<void> _clearToken() async {
    await tokenStorage.clearAccessToken();
    setState(() {
      _result = 'Access token cleared.';
    });
  }

  Future<void> _sendRequest() async {
    setState(() {
      _loading = true;
      _result = 'Sending request...';
    });
    try {
      final response = await apiClient.getPost(10);
      setState(() {
        _result =
            '''
            Status: ${response.statusCode}
            ${response.data}
            ''';
      });
    } catch (e) {
      setState(() {
        _result = e.toString();
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
        title: const Text(
          'Authentication Interceptor',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _saveToken,
              child: const Text(
                'Save Access Token',
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _clearToken,
              child: const Text(
                'Clear Access Token',
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loading ? null : _sendRequest,
              child: const Text(
                'Send API Request',
              ),
            ),
            const SizedBox(height: 24),
            if (_loading)
              const Center(
                child: CircularProgressIndicator(),
              ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: SelectableText(
                  _result,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
