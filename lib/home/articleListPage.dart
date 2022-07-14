import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: Theme.of(context).textTheme.headlineSmall),
      ),
    );
  }
}

class ArticleListPage extends StatelessWidget {
  Future<String> getTextData() async {
    String url =
        'https://raw.githubusercontent.com/mxstbr/markdown-test-file/master/TEST.md';
    var response = await http.get(Uri.parse(url));
    return response.body;
  }

  Widget _buildArticleThumb() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 55,
        ),
        const SectionTitle(title: '测试需求 1-1'),
        Card(
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: InkWell(
                  hoverColor: Colors.transparent,
                  onTap: () {},
                  child: FutureBuilder(
                      future: getTextData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return MarkdownBody(
                              styleSheetTheme:
                                  MarkdownStyleSheetBaseTheme.cupertino,
                              data: snapshot.data ?? '');
                        }
                        return Container();
                      })),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 0.6.sw,
        child: ListView(
          children: [_buildArticleThumb()],
        ));
  }
}
