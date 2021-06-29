import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'get_latest_post_cubit.dart';
import 'locator.dart';
import 'category_screen.dart';
import 'favoutite_screen.dart';
import 'home_screen.dart';
import 'more_screen.dart';
import 'get_category_cubit.dart';


class MyApp extends StatelessWidget {
  final String link;
  final String name;
  final String about;

  MyApp({this.link, this.name, this.about});

  @override
  Widget build(BuildContext context) {
    String checkWeb = link.characters.last == '/'?link: link+'/';
    String url = 'https://public-api.wordpress.com/wp/v2/sites/'+checkWeb;
    locator(url);

    return MultiBlocProvider(
      providers: [
        BlocProvider<GetLatestPostCubit>(
          create: (_) => getIt.call(),
        ),
        BlocProvider<GetCategoryCubit>(
          create: (_) => getIt.call(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.indigo,
            scaffoldBackgroundColor: Colors.white
        ),
        home: LandingScreen(name, about),
        debugShowCheckedModeBanner: false,
        title: name,
      ),
    );
  }
}

class LandingScreen extends StatefulWidget {
  String name;
  String about;

  LandingScreen(this.name, this.about);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [
      HomeScreen(widget.name),
      CategoryScreen(),
      Favouriteposts(),
      More(widget.name, widget.about),
    ];

    return Scaffold(
      body: _children[index],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        onTap: (i) {
          setState(() {
            index = i;
          });
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.filter_list), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favourite'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'More'),
        ],
      ),
    );
  }
}