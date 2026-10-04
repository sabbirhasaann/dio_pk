import 'package:flutter/material.dart';

import 'networking/api_client.dart';
import 'models/post.dart';

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
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    client = ApiClient();
    getPosts();
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
      final _posts = (response.data as List).map(
        (json) {
          return Post.fromJson(json);
        },
      ).toList();

      setState(() {
        posts = _posts;
      });
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: Stack(
        children: [
          if (posts.isEmpty) ...[
            Positioned(
              top: 10,
              right: 10,
              child: Center(
                child: Text('No posts found!'),
              ),
            ),
          ],

          if (posts.isNotEmpty) ...[
            ListView.builder(
              itemCount: posts.length,
              itemBuilder: (ctx, index) {
                final post = posts[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4.0,
                  ),
                  child: Card(
                    elevation: 1,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          post.userId.toString(),
                        ),
                      ),
                      title: Text(post.title),
                      subtitle: Text(
                        post.body,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                        ),
                        textAlign: TextAlign.justify,
                        maxLines: 1,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
          
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
