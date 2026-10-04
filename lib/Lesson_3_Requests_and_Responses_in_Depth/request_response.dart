import 'package:flutter/material.dart';

import 'networking/api_client.dart';
import 'models/post.dart';
import 'models/create_post.dart';

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

  int userId = 12;
  String title = "";
  String body = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  Future<void> createPost() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final request = CreatePost(
        userId: userId,
        title: title,
        body: body,
      );

      try {
        final response = await client.createPost(request);
        debugPrint(response.toString());
      } catch (e) {
        debugPrint(e.toString());
      }
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
                          post.id.toString(),
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
                      trailing: Text(
                        post.userId.toString(),
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
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 32,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: .spaceBetween,
                    mainAxisSize: .min,
                    spacing: 32,
                    children: [
                      Column(
                        spacing: 10,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              label: Text(
                                'UserId',
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Value mustn't be null";
                              }

                              if (value.contains(RegExp(r'[A-Z][a-z]'))) {
                                return "Value should be numberic value only";
                              }

                              return null;
                            },

                            onSaved: (newValue) {
                              setState(() {
                                userId = int.parse(newValue.toString());
                              });
                            },
                          ),

                          TextFormField(
                            decoration: InputDecoration(
                              label: Text(
                                'Title',
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == "") {
                                return "Value shouldn't be empty";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              setState(() {
                                title = newValue!;
                              });
                            },
                          ),

                          TextFormField(
                            decoration: InputDecoration(
                              label: Text(
                                'Body',
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignLabelWithHint: true,
                            ),
                            textAlignVertical: TextAlignVertical.top,
                            maxLines: 5,
                            validator: (value) {
                              if (value == "") {
                                return "Value shouldn't be empty";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              setState(() {
                                body = newValue!;
                              });
                            },
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: .end,
                        spacing: 10,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'),
                          ),

                          ElevatedButton(
                            onPressed: createPost,
                            child: Text('Create'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
