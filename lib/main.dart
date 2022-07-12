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
            home: BlocProvider(
              create: (_) => HomeCubit(),
              child: HomePage(),
            ),
          );
        });
  }
}
