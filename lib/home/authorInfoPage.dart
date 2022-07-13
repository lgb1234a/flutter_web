import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/homeCubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthorInfoPage extends StatelessWidget {
  void _clickedCategoryBtn() {}
  void _clickedGithubBtn() {}
  void _clickedLinkedInBtn() {}
  Widget _createBtn(String iconPath, String tip, VoidCallback callback) {
    return FloatingActionButton.small(
      onPressed: callback,
      tooltip: tip,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.w),
        child: Image.asset(
          iconPath,
          width: 60.w,
          height: 60.w,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, bool>(
      builder: (context, state) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.w),
                child: Image.asset(
                  'assets/images/avatar.png',
                  width: 120.w,
                  height: 120.w,
                ),
              ),
              Container(
                height: 15,
              ),
              _createBtn('assets/images/blog.gif', '归档', _clickedCategoryBtn),
              Container(
                height: 15,
              ),
              _createBtn(
                  'assets/images/github.gif', 'Github', _clickedGithubBtn),
              Container(
                height: 15,
              ),
              _createBtn(
                  'assets/images/linkedin.gif', '简历', _clickedLinkedInBtn),
            ]);
      },
    );
  }
}
