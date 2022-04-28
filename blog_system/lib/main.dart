import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:blog_system/screens/home_page.dart';

import 'screens/add_post_page.dart';

void main() async {
  await initHiveForFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final HttpLink httpLink = HttpLink('https://graphqlzero.almansi.me/api');
  final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer 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');

  @override
  Widget build(BuildContext context) {
    final Link link = authLink.concat(httpLink);
    final ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: link,
        cache: GraphQLCache(
          store: InMemoryStore(),
        ),
      ),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Material App',
        home: const HomeScreen(),
        routes: {
          '/homepage': (context) => const HomeScreen(),
          '/add_post': (context) => const AddPost(),
        },
      ),
    );
  }
}
