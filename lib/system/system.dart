import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';

import 'package:play_android/common/index.dart';
import 'package:play_android/system/model/system_model.dart';

class System extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SystemState();
  }
}

class _SystemState extends State<System> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<SystemModel> _systemList = [];
  List<SystemModel> _rightList = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    HttpResp resp = await HttpUtlis.get(Api.knowledgeTree);
    if (resp.status == Status.succeed) {
      List data = resp.data;
      List<SystemModel> listData =
          SystemModel.objectArrayWithKeyValuesArray(data);
      setState(() {
        _systemList = listData;
        _rightList = _systemList[_selectedIndex].children;
      });
    } else {
      BotToast.showText(text: KString.commonErrorMsg, align: Alignment.center);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('体系'),
      // ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            _buildLeftView(),
            _buildRightView(),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftView() {
    return Container(
      decoration: BoxDecoration(color: const Color(0xfdf5f5ff)),
      width: 120,
      child: ListView.builder(
        itemCount: _systemList.length,
        itemBuilder: (context, index) {
          SystemModel itemModel = _systemList[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
                _rightList = _systemList[_selectedIndex].children;
              });
            },
            child: Container(
              decoration: _selectedIndex == index
                  ? BoxDecoration(
                      color: const Color(0xAC4A4BFF),
                      border: Border(
                        left: BorderSide(
                            width: 4, color: Theme.of(context).primaryColor),
                      ),
                    )
                  : null,
              child: ListTile(
                title: Text(
                  itemModel.name,
                  style: _selectedIndex == index
                      ? TextStyle(color: Colors.white)
                      : null,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRightView() {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: const Color(0xEFEFEFFF),
        ),
        itemCount: _rightList.length,
        itemBuilder: (context, index) {
          SystemModel itemModel = _rightList[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteName.systemArticleList,
                arguments: {
                  'id': itemModel.id,
                  'name': itemModel.name,
                },
              );
            },
            child: ListTile(
              title: Text(itemModel.name),
            ),
          );
        },
      ),
    );
  }
}
