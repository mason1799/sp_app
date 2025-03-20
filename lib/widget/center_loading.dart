import 'package:flutter/cupertino.dart';

class CenterLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: CupertinoActivityIndicator(),
    );
  }
}
