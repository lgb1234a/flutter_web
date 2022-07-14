import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/homeCubit.dart';
import 'articleListPage.dart';
import 'authorInfoPage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber[100],
        // appBar: AppBar(title: const Text('Counter')),
        // body: BlocBuilder<HomeCubit, bool>(
        //   builder: (context, count) => Center(child: Text('$count')),
        // ),
        body: Stack(
          children: [
            Positioned(
                bottom: -309.h,
                left: 1327.w,
                child: Image.asset(
                  'assets/images/cat.png',
                  width: 711.w,
                  height: 948.h,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ArticleListPage(),
                AuthorInfoPage(),
              ],
            )
          ],
        ));
  }
}
