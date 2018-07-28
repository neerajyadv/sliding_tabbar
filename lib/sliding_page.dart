import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_app_slide_animation/sample_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREF_KEY_TAB_INDEX = "pref_key_tab_index";

class AllSessionsPage extends StatefulWidget {
  @override
  State createState() => new AllSessionsPageState();
}

class AllSessionsPageState extends State<AllSessionsPage>
    with TickerProviderStateMixin {
  TabController _controller;
  List<SamplePage> _rooms = [SamplePage(), SamplePage(), SamplePage(), SamplePage(), SamplePage(), SamplePage(), SamplePage(), SamplePage(), SamplePage()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setRooms(_rooms);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _saveTabIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("saveTabIndex: ${_controller?.index}");
    prefs.setInt(PREF_KEY_TAB_INDEX, _controller?.index);
  }

  Future<int> _restoreTabIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int tabIndex = prefs.getInt(PREF_KEY_TAB_INDEX);
    return tabIndex != null ? tabIndex : _controller?.index;
  }

  void setRooms(List<SamplePage> rooms) {
    setState(() {
      _rooms = rooms;

      _controller?.dispose();
      _controller = new TabController(vsync: this, length: _rooms.length);
      _controller.addListener(_saveTabIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_rooms.isEmpty) {
      return new Center(
        child: const CircularProgressIndicator(),
      );
    }

    _restoreTabIndex().then((int i) => _controller?.index = i);

    return new Scaffold(
      appBar: new PreferredSize(
        preferredSize: new Size.fromHeight(kTextTabBarHeight),
        child: new Material(
          color: Theme.of(context).primaryColor,
          elevation: 4.0,
          child: new TabBar(
            controller: _controller,
            isScrollable: true,
            tabs: _rooms.map((SamplePage room) => new Tab(text: room.name)).toList(),
          ),
        ),
      ),
      body: new TabBarView(
        controller: _controller,
        children: _rooms.map((SamplePage room) {
          return new SamplePage();
        }).toList(),
      ),
    );
  }
}