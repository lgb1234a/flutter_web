import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/homeCubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthorInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, bool>(
      builder: (context, state) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/avatar.png',
                width: 120.w,
                height: 120.w,
              ),
              FloatingActionButton(
                onPressed: () => print('---------'),
                child: const Icon(Icons.add),
              ),
            ]);
      },
    );
  }
}
