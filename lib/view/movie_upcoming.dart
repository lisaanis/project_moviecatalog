import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projectmoviecatalog/helper/shared_preferences.dart';
import 'package:projectmoviecatalog/view/login_page.dart';
import 'package:projectmoviecatalog/view/movie_detail.dart';

class Upcoming extends StatefulWidget {
  @override
  _UpcomingState createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  List upcomings = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchDiscover();
  }

  fetchDiscover() async {
    setState(() {
      isLoading = true;
    });
    var url =
        "https://api.themoviedb.org/3/movie/upcoming?api_key=5c13b3fd9afd739e4ba1f320e550b064";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var items = json.decode(response.body)['results'];
      setState(() {
        upcomings = items;
        isLoading = false;
      });
    } else {
      setState(() {
        upcomings = [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "UPCOMING",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () {
              SharedPreference().setLogout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                      (route) => false);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    if (upcomings.contains(null) || upcomings.length < 0 || isLoading) {
      return Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueGrey),
          ));
    }
    return ListView.builder(
        itemCount: upcomings.length,
        itemBuilder: (context, index) {
          return getCard(upcomings[index]);
        });
  }

  Widget getCard(item) {
    var id = item['id'];
    var namaFilm = item['title'];
    var sinopsis = item['overview'];
    var score = item['vote_average'];
    var release = item['release_date'];
    var poster = "https://image.tmdb.org/t/p/w500/" + item['poster_path'];
    var backPoster =  "https://image.tmdb.org/t/p/w500/" + item ['backdrop_path'];
    return Card(
        margin: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => MovieDetail(id : id, namaFilm : namaFilm, sinopsis : sinopsis, score : score, release : release, poster : poster, backPoster : backPoster))),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
            child: ListTile(
              title: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(poster.toString()),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(namaFilm.toString(),
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      SizedBox(height: 5),
                      Text(
                        "Release " + release.toString(),
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(height: 20),
                      Text("Sinopsis",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700)),
                      SizedBox(height: 5),
                      Container(
                        width: 335,
                        child: Text(
                          sinopsis.toString(),
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Raleway'),
                          textAlign: TextAlign.justify,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
