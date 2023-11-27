import 'package:flutter/material.dart';

class DetaiScreen extends StatelessWidget {
  final String name;
  final String language;
  final String genre;
  final String runtime;

  final String summary;
  final String imgurl;

  final String releasedate;

  const DetaiScreen({
    Key? key,
    required this.name,
    required this.language,
    required this.genre,
    required this.runtime,
    required this.summary,
    required this.imgurl,
    required this.releasedate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          SizedBox(
              height: 250,
              child: Row(
                children: [
                  Container(
                      height: 240,
                      width: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(imgurl))),
                      child: const Text("")),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "Movie-$name",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Genre-$genre".substring(0, 14),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Langauge-$language",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Release-${releasedate.toString().substring(0, 10)}",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                        ),
                      ],
                    ),
                  )
                ],
              )),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Summary",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 23),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              summary.toString(),
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
