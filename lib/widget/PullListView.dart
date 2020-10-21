import 'package:createunion/widget/BasePage.dart';
import 'package:flutter/material.dart';
import 'package:createunion/utils/SizeUtils.dart';

class PullListView extends StatefulWidget {
  Widget Function(BuildContext context, int index, List list) itemBuilder;
  Function(_PullListViewState currentState, int page) getDataList;
  int size;
  Widget Function(BuildContext context, int index) separatorBuilder;
  EdgeInsetsGeometry padding;
  ScrollPhysics physics;

  PullListView(
      {@required this.itemBuilder,
      @required this.getDataList,
      this.separatorBuilder,
      this.padding,
      this.physics,
      this.size = 20,
      Key key})
      : super(key: key);

  @override
  _PullListViewState createState() => _PullListViewState();
}

class _PullListViewState extends State<PullListView> {
  //当前列表的状态0--没有更多，1上拉加载更多
  int currentListStatus = 0;
  Status mStatus = Status.LOADING;
  List dataList = [];
  ScrollController _scrollController = ScrollController();
  int page = 1;
  String errorCode = '';

  void onRefreshData(List list) {
    setState(() {
      if (page == 1) {
        dataList.clear();
        dataList.addAll(list);
      } else {
        dataList.addAll(list);
      }
      mStatus = dataList.length == 0 ? Status.EMPTY : Status.NONE;
      currentListStatus = list.length < widget.size ? 0 : 1;
    });
  }

  void onFail(e) {
    if (mounted) {
      setState(() {
        mStatus = Status.ERROR;
        errorCode = e is String ? e : e.message;
      });
    }
  }

  void showRefresh() {
    setState(() {
      mStatus = Status.LOADING;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          page++;
          widget.getDataList(this, page);
        });
      }
    });
    widget.getDataList(this, page);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
        child: BasePage(
            hint: errorCode,
            child: ListView.separated(
              physics: widget.physics ?? AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              controller: _scrollController,
              padding: widget.padding ?? EdgeInsets.zero,
              itemBuilder: _itemBuilder,
              itemCount: dataList.length + 1,
              separatorBuilder:
                  widget.separatorBuilder ?? (context, index) => Container(),
            ),
            status: mStatus),
        onRefresh: _refresh);
  }

  Future<Null> _refresh() async {
    setState(() {
      page = 1;
      widget.getDataList(this, page);
    });
  }

  Widget _itemBuilder(context, index) {
    if (index == dataList.length) {
      return more();
    } else {
      return widget.itemBuilder(context, index, dataList);
    }
  }

  Widget more() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10.px),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10.px),
            child: SizedBox(
                child: CircularProgressIndicator(strokeWidth: 3),
                width: currentListStatus == 1 ? 20.px : 0,
                height: currentListStatus == 1 ? 20.px : 0),
          ),
          Text(
            currentListStatus == 1 ? "上拉加载更多" : "没有更多数据了",
            style: TextStyle(color: Color(0xffcccccc), fontSize: 14.px),
          )
        ],
      ),
    );
  }
}
