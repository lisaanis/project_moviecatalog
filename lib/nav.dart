import 'package:flutter/material.dart';
import 'package:projectmoviecatalog/view/movie_discover.dart';
import 'package:projectmoviecatalog/view/movie_toprated.dart';
import 'package:projectmoviecatalog/view/movie_upcoming.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Discover(),
    Upcoming(),
    TopRated(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex),),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            title: Text("DISCOVER"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upcoming),
            title: Text("UPCOMING"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text("TOP RATED"),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
