import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_android_flutter/api/home.dart';
import 'package:happy_android_flutter/model/home_banner.dart';
import 'package:happy_android_flutter/pages/home/home_banner_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<HomeBannerModel> _banners;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initHomeData();
  }

  Future<void> initHomeData() async {
    var banners = await ApiHome.getHomeBanner(context: context, params: {});
    print(banners);
    setState(() {
      _banners = banners;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_banners == null) {
      return CupertinoActivityIndicator();
    }
    return Scaffold(
      /*appBar: AppBar(
        title: Text('首页'),
        elevation: 0,
      ),*/
      body: HomeBannerView(_banners),
    );
  }
}
