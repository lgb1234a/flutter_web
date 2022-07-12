import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home/bloc/homeCubit.dart';
import 'home/homePage.dart';

void main() => runApp(BlogApp());

class BlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => HomeCubit(),
        child: HomePage(),
      ),
    );
  }
}
