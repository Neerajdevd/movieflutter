import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movieflutter/modal/moviemodal.dart';
import 'package:movieflutter/screens/detail.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  TextEditingController searchcontroller = TextEditingController();
  String? search = "";
  List<Temperatures> postmovies = [];

  Future<List<Temperatures>> getmovies() async {
    try {
      var response = await http
          .get(Uri.parse("https://api.tvmaze.com/search/shows?q=all"));
      var data = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        postmovies.clear();
        for (Map i in data) {
          postmovies.add(Temperatures.fromJson(i));
        }

        // ignore: avoid_print
        print(postmovies);

        return postmovies;
      } else {
        return postmovies;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (String? value) {
                  setState(() {
                    search = value.toString();
                  });
                },
                controller: searchcontroller,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide()),
                    hintText: "Search",
                    suffixIcon: const Icon(Icons.search)),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: FutureBuilder(
                  future: getmovies(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return const Text("Loading");
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            scrollDirection: Axis.horizontal,
                            itemCount: postmovies.length,
                            itemBuilder: (context, index) {
                              String moviename =
                                  postmovies[index].show!.name.toString();
                              if (searchcontroller.text.isEmpty) {
                                return InkWell(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    postmovies[index]
                                                        .show!
                                                        .image!
                                                        .medium
                                                        .toString()))),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(postmovies[index]
                                          .show!
                                          .name
                                          .toString())
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else {
                                        return DetaiScreen(
                                          name: postmovies[index]
                                              .show!
                                              .name
                                              .toString(),
                                          language: postmovies[index]
                                              .show!
                                              .language
                                              .toString(),
                                          genre: postmovies[index]
                                              .show!
                                              .genres
                                              .toString(),
                                          runtime: postmovies[index]
                                              .show!
                                              .runtime
                                              .toString(),
                                          summary: postmovies[index]
                                              .show!
                                              .summary
                                              .toString(),
                                          imgurl: postmovies[index]
                                              .show!
                                              .image!
                                              .original
                                              .toString(),
                                          releasedate: postmovies[index]
                                              .show!
                                              .premiered!
                                              .toString(),
                                        );
                                      }
                                    }));
                                  },
                                );
                              } else if (moviename
                                  .contains(searchcontroller.text)) {
                                return InkWell(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 180,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      postmovies[index]
                                                          .show!
                                                          .image!
                                                          .medium
                                                          .toString()))),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(moviename)
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else {
                                        return DetaiScreen(
                                          name: postmovies[index]
                                              .show!
                                              .name
                                              .toString(),
                                          language: postmovies[index]
                                              .show!
                                              .language
                                              .toString(),
                                          genre: postmovies[index]
                                              .show!
                                              .genres
                                              .toString(),
                                          runtime: postmovies[index]
                                              .show!
                                              .runtime
                                              .toString(),
                                          summary: postmovies[index]
                                              .show!
                                              .summary
                                              .toString(),
                                          imgurl: postmovies[index]
                                              .show!
                                              .image!
                                              .original
                                              .toString(),
                                          releasedate: postmovies[index]
                                              .show!
                                              .premiered!
                                              .toString(),
                                        );
                                      }
                                    }));
                                  },
                                );
                              } else {
                                return const SizedBox();
                              }
                            }),
                      );
                    }
                  })),
            )
          ],
        ),
      ),
    );
  }

  // void runfilter(String enterkeyword) {
  //   List<Map<String, dynamic>> results = [];
  //   if (enterkeyword.isEmpty) {
  //     results = postmovies.cast<Map<String, dynamic>>();
  //   } else {
  //     results = postmovies.cast<Map);

  //   }
  // }
}
