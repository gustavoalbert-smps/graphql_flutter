import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  final String getPosts = """
  query MyQuery {
    posts {
      title
    }
  }
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(3, 161, 252, 0.7),
        title: const Text('Meu Blog'),
      ),
      body: Query(
        options: QueryOptions(document: gql(getPosts)),
        builder: (result, {fetchMore, refetch}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          List? posts = result.data?["posts"];

          return ListView.builder(
            itemCount: posts!.length,
            itemBuilder: (context, index) {
              final postsTitle = posts[index]["title"];
              return ListTile(
                contentPadding: const EdgeInsets.all(10),
                title: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  shadowColor: const Color.fromRGBO(136, 138, 140, 1),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(120, 120, 120, 1),
                          Color.fromRGBO(3, 161, 252, 0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: SizedBox(
                      width: 200,
                      height: 70,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Icon(
                              Icons.feed_outlined,
                              color: Color.fromRGBO(255, 255, 255, 1),
                              size: 30,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                postsTitle,
                                style: const TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.justify,
                                maxLines: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
