import 'package:flutter/material.dart';

class HomeScreenController extends ChangeNotifier {
  double _xOffset = 0;
  double _scale = 1;
  bool _isTap = true;

  double get xOffset => _xOffset;
  double get scale => _scale;
  bool get isTap => _isTap;

  List<String> bannerList = [
    "https://media.licdn.com/dms/image/C4E12AQFiZaNmkVpsLg/article-cover_image-shrink_600_2000/0/1648539103440?e=2147483647&v=beta&t=3tTJ7pyWdmEwXrc2v35zTUyANfVCW_1y4BgkVqZZwmk",
    "https://elizyazilim.com/blog/wp-content/uploads/8_original-1032x628.jpeg",
  ];

  void menuButtonTap({required BuildContext context, required bool value}) {
    Size size = MediaQuery.of(context).size;
    _isTap = value;
    if (isTap) {
      _xOffset = 0;
      _scale = 1;
    } else {
      _xOffset = size.width / 1.55;
      _scale = 0.85;
    }

    notifyListeners();
  }
}
