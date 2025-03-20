import 'package:flutter/material.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/title_bar.dart';

class PhotoPreview extends StatelessWidget {
  final String? ossKey;
  final String? title;
  final String? path;

  PhotoPreview({
    this.ossKey,
    this.title,
    this.path,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: TitleBar(title: title ?? '预览'),
      body: Align(
        alignment: Alignment.center,
        child: LoadImage(
          ossKey,
          width: double.infinity,
          fit: BoxFit.fitWidth,
          holderFilePath: path,
        ),
      ),
    );
  }
}
