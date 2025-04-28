import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<dynamic> post = [];
  bool load = true;
  String errosShowingMessageinUi = '';

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        setState(() {
          post = json.decode(response.body);
          load = false;
        });
      } else {
        setState(() {
          errosShowingMessageinUi = 'Failed to load posts. Status code: ${response.statusCode}';
          load = false;
        });
      }
    } catch (e) {
      setState(() {
        errosShowingMessageinUi = 'Error: $e';
        load = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')), // optional: good to add AppBar
      body: load
          ? const Center(child: CircularProgressIndicator())
          : errosShowingMessageinUi.isNotEmpty
              ? Center(child: Text(errosShowingMessageinUi))
              : ListView.builder(
                  itemCount: post.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(post[index]['title']),
                      subtitle: Text(post[index]['body']),
                    );
                  },
                ),
    );
  }
}
