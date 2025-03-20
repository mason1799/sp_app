import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/advance_refresh_list.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/search_widget.dart';
import 'package:konesp/widget/title_bar.dart';

import 'contract_list_logic.dart';

class ContractListPage extends StatelessWidget {
  final logic = Get.find<ContractListLogic>();
  final state = Get.find<ContractListLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.focusScope?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: TitleBar(title: '我的合同'),
        body: GetBuilder<ContractListLogic>(
          builder: (_) => AdvanceRefreshListView(
            itemCount: state.items.length + 1,
            onRefresh: () => logic.pull(),
            onLoadMore: () => logic.loadMore(),
            hasMore: state.hasMore,
            pageStatus: state.pageStatus,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
                  child: SearchWidget(
                    onSearch: logic.search,
                    controller: state.searchController,
                    hintText: '搜索合同',
                  ),
                );
              }
              final item = state.items[index - 1];
              return InkWell(
                onTap: () => logic.toDetail(item.id!),
                child: Container(
                  margin: EdgeInsets.only(top: index == 1 ? 0 : 10.w, left: 15.w, right: 15.w),
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.w),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.contractName ?? '',
                              style: TextStyle(
                                color: Colours.text_333,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 8.w),
                            Text(
                              '${item.contractStartDate} - ${item.contractEndDate}',
                              style: TextStyle(
                                color: Colours.text_333,
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(height: 8.w),
                            Row(
                              children: [
                                Text(
                                  '还有',
                                  style: TextStyle(
                                    color: Colours.text_333,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Text(
                                  '${item.expiryDate ?? '0'}天',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: (item.expiryDate ?? 0) > 60 ? Colours.text_333 : Colours.orange,
                                  ),
                                ),
                                Text(
                                  '到期',
                                  style: TextStyle(
                                    color: Colours.text_333,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      LoadSvgImage(
                        'arrow_right',
                        width: 14.w,
                        color: Colours.text_333,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
