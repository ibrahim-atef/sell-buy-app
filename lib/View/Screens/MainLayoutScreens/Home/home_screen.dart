import 'package:flutter/material.dart';
 import 'package:sell_buy/View/Screens/MainLayoutScreens/Home/components/category_list_view_adds.dart';

import '../../../../Model/ad_model.dart';
import '../../../Widgets/utilities_widgets/Home_loading_shimmer.dart';
import 'components/gridview_component.dart';

class HomeScreen extends StatelessWidget {
    HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: false
            ? HomeLoadingShimmer()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    HomeGridViewComponent(),

                  ],
                ),
              ),
      ),
    );
  }
}
