import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konesp/res/colors.dart';

/// 封装下拉刷新与加载更多
class RefreshListView extends StatefulWidget {
  const RefreshListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.onRefresh,
    this.onLoadMore,
    this.hasMore = false,
    this.pageSize = 10,
    this.padding,
    this.itemExtent,
  });

  final RefreshCallback onRefresh;
  final LoadMoreCallback? onLoadMore;
  final int itemCount;
  final bool hasMore;
  final IndexedWidgetBuilder itemBuilder;

  /// 一页的数量，默认为10
  final int pageSize;

  /// padding属性使用时注意会破坏原有的SafeArea，需要自行计算bottom大小
  final EdgeInsetsGeometry? padding;
  final double? itemExtent;

  @override
  State<RefreshListView> createState() => _RefreshListViewState();
}

typedef RefreshCallback = Future<void> Function();
typedef LoadMoreCallback = Future<void> Function();

class _RefreshListViewState extends State<RefreshListView> {
  /// 是否正在加载数据
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification note) {
        if (note.metrics.pixels == note.metrics.maxScrollExtent && note.metrics.axis == Axis.vertical) {
          _loadMore();
        }
        return true;
      },
      child: RefreshIndicator(
        onRefresh: widget.onRefresh,
        child: ListView.builder(
          itemCount: widget.onLoadMore == null ? widget.itemCount : widget.itemCount + 1,
          padding: widget.padding,
          itemExtent: widget.itemExtent,
          itemBuilder: (BuildContext context, int index) {
            /// 不需要加载更多则不需要添加FootView
            if (widget.onLoadMore == null) {
              return widget.itemBuilder(context, index);
            } else {
              return index < widget.itemCount ? widget.itemBuilder(context, index) : MoreWidget(widget.itemCount, widget.hasMore, widget.pageSize);
            }
          },
        ),
      ),
    );
  }

  Future<void> _loadMore() async {
    if (widget.onLoadMore == null) {
      return;
    }
    if (_isLoading) {
      return;
    }
    if (!widget.hasMore) {
      return;
    }
    _isLoading = true;
    await widget.onLoadMore?.call();
    _isLoading = false;
  }
}

class MoreWidget extends StatelessWidget {
  const MoreWidget(this.itemCount, this.hasMore, this.pageSize, {super.key});

  final int itemCount;
  final bool hasMore;
  final int pageSize;

  @override
  Widget build(BuildContext context) {
    final TextStyle style = TextStyle(
      color: Colours.text_999,
      fontSize: 14,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (hasMore) const CupertinoActivityIndicator(),
          if (hasMore) SizedBox(width: 5),

          /// 只有一页的时候，就不显示FooterView了
          Text(hasMore ? '正在加载中...' : (itemCount < pageSize ? '' : '到底了~'), style: style),
        ],
      ),
    );
  }
}
