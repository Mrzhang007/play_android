import 'dart:async';

import 'package:flutter/material.dart';

import 'package:play_android/home/model/home_banner_model.dart';

// MediaQuery.of(context).size 获取屏幕的宽高

typedef void OnBannerClick(HomeBannerModel item, int pageIndex);

class HomeBanner extends StatefulWidget {
  final List<HomeBannerModel> bannerDataList;
  final bool autoLoop;
  final OnBannerClick? bannerClick;

  HomeBanner({
    Key? key,
    required this.bannerDataList,
    this.autoLoop = false,
    this.bannerClick,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeBannerState();
  }
}

class _HomeBannerState extends State<HomeBanner> {
  Timer? _timer;
  int _currentPage = 0;

  final PageController _pageController = PageController(
    initialPage: 0, // 默认在第几个
    viewportFraction: 1, // 占屏幕多少，1为占满整个屏幕
    keepPage: true,
  );

  @override
  void initState() {
    super.initState();
    if (widget.autoLoop) {
      _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
        _currentPage = _currentPage + 1;
        _pageController.animateToPage(
          _currentPage % widget.bannerDataList.length,
          duration: Duration(microseconds: 300),
          curve: Curves.linear,
        );
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        height: 240,
        child: new Stack(
          // fit: StackFit.expand,  //未定位widget占满Stack整个空间
          children: [
            Container(
              child: PageView.builder(
                controller: _pageController,
                reverse: false,
                pageSnapping: true, // 是否分页 是否按页滚动 默认true
                physics:
                    BouncingScrollPhysics(), // 滚动的方式 默认 BouncingScrollPhysics 阻尼效果 ClampingScrollPhysics 水波纹效果
                itemCount: widget.bannerDataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildBannerItem(widget.bannerDataList[index], index);
                },
                onPageChanged: _onPageChanged,
              ),
            ),
            _buildPagination(),
          ],
        ));
  }

  void _onPageChanged(int pageIndex) {
    setState(() {
      _currentPage = pageIndex;
    });
  }

  Widget _buildBannerItem(HomeBannerModel item, int pageIndex) {
    return GestureDetector(
      child: new Image.network(
        item.imagePath,
        fit: BoxFit.fill,
      ),
      onTap: () {
        if (widget.bannerClick != null) {
          widget.bannerClick!(item, pageIndex);
        }
      },
    );
  }

  Widget _buildPagination() {
    List<Widget> pagination = [];
    for (var i = 0; i < widget.bannerDataList.length; i++) {
      pagination.add(Container(
        margin: EdgeInsets.all(2),
        height: 6,
        width: 6,
        decoration: BoxDecoration(
          color: (_currentPage == i) ? Colors.red : Colors.white,
          shape: BoxShape.circle,
        ),
      ));
    }
    return Positioned(
      bottom: 12,
      right: 16,
      child: new Row(children: pagination),
    );
  }
}
