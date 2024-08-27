import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel_slider;
import 'package:carousel_slider/carousel_controller.dart' as carousel_controller;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
    @override
    _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    int _currentIndex = 0;

    final List<Widget> _pages = [
        Center(child: Text('Home Page')),
        Center(child: Text('Profile Page')),
        Center(child: Text('Settings Page')),
    ];

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
            title: Text('Home'),
            leading: Builder(
                builder: (BuildContext context) {
                    return IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {
                            Scaffold.of(context).openDrawer();
                        },
                    );
                },
            ),
        ),
            drawer: Drawer(
                child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                        DrawerHeader(
                            child: Text('Menu'),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                            ),
                        ),
                        ListTile(
                            title: Text('Home'),
                            onTap: () {
                                Navigator.pop(context);
                            },
                        ),
                        ListTile(
                            title: Text('Profile'),
                            onTap: () {
                                Navigator.pop(context);
                            },
                        ),
                        ListTile(
                            title: Text('Settings'),
                            onTap: () {
                                Navigator.pop(context);
                            },
                        ),
                    ],
                ),
            ),
            body: Column(
                children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                            decoration: InputDecoration(
                                hintText: 'Search...',
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                ),
                            ),
                        ),
                    ),
                    carousel_slider.CarouselSlider(
                        options: carousel_slider.CarouselOptions(
                            height: 200.0,
                            autoPlay: true,
                            enlargeCenterPage: true,
                        ),
                        items: [1, 2, 3, 4, 5].map((i) {
                            return Builder(
                                builder: (BuildContext context) {
                                    return Container(
                                        width: MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                                        decoration: BoxDecoration(
                                            color: Colors.amber,
                                        ),
                                        child: Center(
                                            child: Text(
                                                'Gallery Item $i',
                                                style: TextStyle(fontSize: 16.0),
                                            ),
                                        ),
                                    );
                                },
                            );
                        }).toList(),
                    ),
                    SizedBox(height: 20),
                    carousel_slider.CarouselSlider(
                        options: carousel_slider.CarouselOptions(
                            height: 200.0,
                            autoPlay: true,
                            enlargeCenterPage: true,
                        ),
                        items: [1, 2, 3, 4, 5].map((i) {
                            return Builder(
                                builder: (BuildContext context) {
                                    return Container(
                                        width: MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                        ),
                                        child: Center(
                                            child: Text(
                                                'Slider Item $i',
                                                style: TextStyle(fontSize: 16.0),
                                            ),
                                        ),
                                    );
                                },
                            );
                        }).toList(),
                    ),
                ],
            ),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) {
                    setState(() {
                        _currentIndex = index;
                    });
                },
                items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: 'Profile',
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings),
                        label: 'Settings',
                    ),
                ],
            ),
        );
    }
}