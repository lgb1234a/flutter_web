import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/homeCubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../category/categoryPage.dart';

class AuthorInfoPage extends StatefulWidget {
  const AuthorInfoPage({super.key});

  @override
  _AuthorInfoState createState() => _AuthorInfoState();
}

class _AuthorInfoState extends State<AuthorInfoPage> {
  bool _categoryHovering = false;
  bool _githubHovering = false;
  bool _linkedInHovering = false;
  @override
  void initState() {
    super.initState();
  }

  void _clickedCategoryBtn() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CategoryPage()),
    );
  }

  void _clickedGithubBtn() {
    Uri url = Uri.parse('https://github.com/lgb1234a');
    launchUrl(url);
  }

  void _clickedLinkedInBtn() {
    Uri url = Uri.parse('https://www.linkedin.com/in/chenynle');
    launchUrl(url);
  }

  Widget _createBtn(String iconPath, String tip, VoidCallback onTapCallback,
      Function(bool) onHoverCallback) {
    return InkWell(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: onTapCallback,
        onHover: onHoverCallback,
        child: Tooltip(
          message: tip,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              iconPath,
              width: 40,
              height: 40,
            ),
          ),
        ));
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
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/avatar.png',
                  width: 120.w,
                  height: 120.w,
                ),
              ),
              const Text('阿勒勒勒勒🐌'),
              Container(
                height: 55.h,
              ),
              _createBtn(
                  _categoryHovering
                      ? 'assets/images/blog.gif'
                      : 'assets/images/blog_0.png',
                  '归档',
                  _clickedCategoryBtn,
                  (hovering) => setState(() {
                        _categoryHovering = hovering;
                      })),
              Container(
                height: 35.h,
              ),
              _createBtn(
                  _githubHovering
                      ? 'assets/images/github.gif'
                      : 'assets/images/github_0.png',
                  'Github',
                  _clickedGithubBtn,
                  (hovering) => setState(() {
                        _githubHovering = hovering;
                      })),
              Container(
                height: 35.h,
              ),
              _createBtn(
                  _linkedInHovering
                      ? 'assets/images/linkedin.gif'
                      : 'assets/images/linkedin_0.png',
                  '简历',
                  _clickedLinkedInBtn,
                  (hovering) => setState(() {
                        _linkedInHovering = hovering;
                      })),
              Container(
                height: 200.h,
              )
            ]);
      },
    );
  }
}
