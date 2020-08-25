import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:happy_android_flutter/common/navigator.dart';
import 'package:happy_android_flutter/model/home_banner.dart';
import 'package:happy_android_flutter/util/screen.dart';

class HomeBannerView extends StatelessWidget {
  final List<HomeBannerModel> banners;

  HomeBannerView(this.banners);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 2,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
        ),
        items: banners.map((banner) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  AppNavigator.pushWeb(context, banner.url, banner.title);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: Screen.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    banner.imagePath),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.all(Radius.circular(3))),
                      ),
                      Opacity(
                        opacity: 0.1,
                        child: Container(
                          width: Screen.width,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3))),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
