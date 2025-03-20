import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/res/resource.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/title_bar.dart';

import 'help_logic.dart';

class HelpPage extends StatelessWidget {
  final state = Get.find<HelpLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar(title: '帮助中心'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.w),
              _Label(title: '新手入门'),
              SizedBox(height: 10.w),
              MasonryGridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.w,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => _RookieItem(
                  background: state.rookies[index].background!,
                  icon: state.rookies[index].icon!,
                  title: state.rookies[index].title,
                  titleColor: state.rookies[index].titleColor!,
                ),
                itemCount: state.rookies.length,
              ),
              SizedBox(height: 25.w),
              _Label(title: '使用仟帆'),
              SizedBox(height: 10.w),
              MasonryGridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.w,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => _FunctionItem(
                  icon: state.functions[index].icon!,
                  title: state.functions[index].title,
                ),
                itemCount: state.functions.length,
              ),
              SizedBox(height: 25.w),
              _Label(title: '故障诊断工具'),
              SizedBox(height: 10.w),
              MasonryGridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.w,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => _FunctionItem(
                  icon: state.tools[index].icon!,
                  title: state.tools[index].title,
                ),
                itemCount: state.tools.length,
              ),
              SizedBox(height: 25.w),
              _Label(title: '常见问题'),
              SizedBox(height: 10.w),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.w),
                child: ListView.separated(
                  itemCount: state.problems.length,
                  itemBuilder: (context, index) => _QaItem(
                    title: state.problems[index].title,
                  ),
                  separatorBuilder: (context, index) => divider,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                ),
              ),
              SizedBox(height: 15.w + ScreenUtil().bottomBarHeight),
            ],
          ),
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Colours.text_333,
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _QaItem extends StatelessWidget {
  const _QaItem({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      width: double.infinity,
      color: Colors.white,
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          color: Colours.text_666,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}

class _RookieItem extends StatelessWidget {
  const _RookieItem({
    required this.title,
    required this.titleColor,
    required this.background,
    required this.icon,
  });

  final String title;
  final Color titleColor;
  final Color background;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: (1.sw - 50.w) / 3,
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(8.w),
          ),
        ),
        Positioned(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15.w,
              color: titleColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          left: 10.w,
          top: 10.w,
        ),
        Positioned(
          child: LoadSvgImage(
            icon,
            width: 50.w,
          ),
          bottom: 0,
          left: 0,
          right: 0,
        ),
      ],
    );
  }
}

class _FunctionItem extends StatelessWidget {
  const _FunctionItem({
    required this.icon,
    required this.title,
  });

  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LoadSvgImage(
            icon,
            width: 25.w,
          ),
          SizedBox(height: 10.w),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colours.text_333,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
