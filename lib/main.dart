import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home/bloc/homeCubit.dart';
import 'home/homePage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async => runApp(const BlogApp(key: Key('app')));

class BlogApp extends StatefulWidget {
  const BlogApp({Key? key}) : super(key: key);

  @override
  _BlogAppState createState() => _BlogAppState();
}

class _BlogAppState extends State<BlogApp> {
  @override
  Widget build(BuildContext context) {
    //设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    return ScreenUtilInit(
        designSize: const Size(1920, 1080),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(
              // Define the default brightness and colors.
              brightness: Brightness.light,
              primaryColor: Colors.white,

              // Define the default font family.
              fontFamily: 'Georgia',

              // Define the default `TextTheme`. Use this to specify the default
              // text styling for headlines, titles, bodies of text, and more.
              textTheme: const TextTheme(
                headline1:
                    TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                headline6:
                    TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
              ),
            ),
            home: BlocProvider(
              create: (_) => HomeCubit(),
              child: HomePage(),
            ),
          );
        });
  }
}
