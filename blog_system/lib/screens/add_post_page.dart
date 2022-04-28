// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:blog_system/validation/form_validators.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final GlobalKey<FormState> _key = GlobalKey();
  final title = TextEditingController();
  final body = TextEditingController();

  final String createPost =
      '''mutation CreatePost(\$title: String!, \$body: String!) {
            createPost(input: { title: \$title, body: \$body }) {
              id
              title
              body
            }
        }
     ''';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Adicione um post'),
        ),
        body: Container(
          margin: const EdgeInsets.all(20),
          child: Form(
            key: _key,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextFormField(
                  controller: title,
                  decoration: const InputDecoration(hintText: 'Título'),
                  keyboardType: TextInputType.text,
                  maxLength: 65,
                  validator: (title) => Validators.validateTitle(title!),
                ),
                TextFormField(
                  controller: body,
                  decoration:
                      const InputDecoration(hintText: 'Fale sobre algo'),
                  keyboardType: TextInputType.text,
                  maxLength: 700,
                  validator: (body) => Validators.validateBody(body!),
                ),
                Mutation(
                  options: MutationOptions(
                      document: gql(createPost),
                      onCompleted: (result) {
                        print("Completed");
                      }),
                  builder: (RunMutation runMutation, QueryResult? result) {
                    return ElevatedButton(
                      onPressed: () {
                        runMutation({
                          'title': title.text,
                          'body': body.text,
                        });
                        setState(() {
                          sendForm();
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('Postar'),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  sendForm() {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
    }
  }
}
