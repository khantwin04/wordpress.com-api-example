import 'package:flutter/material.dart';
import 'builder/builder.dart';

void main() {
  WidgetsFlutterBinding();
  runApp(MyApp(
    name: 'My App',
    link: 'khantwinblog.wordpress.com',
    about: 'My App',
  ));

}
