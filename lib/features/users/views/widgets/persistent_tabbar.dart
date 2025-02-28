import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoint.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class PersistentTabbar extends SliverPersistentHeaderDelegate {

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
        final isDark = isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        border: Border.symmetric(
          horizontal: BorderSide(
            color:isDark? Colors.grey.shade700 : Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
      child:  TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor:Theme.of(context).tabBarTheme.indicatorColor,
        labelPadding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
       // labelColor: Colors.black,
        tabs: const [
          //굳이 padding으로 icon 감싼 이유는..
          //indicatorSize TabBarIndicatorSize.label 로 적절한 크키로 표기가 안되어서서
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size24),
            child: Icon(Icons.grid_4x4_rounded),
          ),
    
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size24),
            child: FaIcon(FontAwesomeIcons.heart),
          ),
        ],
      ),
    );
  }

//무작위로 큰숫자하면. 실제 TabBArsize가 나옴
//해당사이즈 기준으로 다시입력하면 error 안남.
  @override
  double get maxExtent => 48.0;

  @override
  double get minExtent => 48.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
