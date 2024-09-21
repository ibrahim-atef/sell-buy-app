import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Controllers/create_ad_controller.dart';
import '../../../Widgets/utilities_widgets/Home_loading_shimmer.dart';
import 'components/gridview_component.dart';

class HomeScreen extends StatelessWidget {
    HomeScreen({super.key});
    final createAdController = Get.put(CreateAdController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CreateAdController>(builder: (_) { return Padding(
        padding: EdgeInsets.all(10),
        child: createAdController.isLoadingCategories.value
            ? HomeLoadingShimmer()
            : SingleChildScrollView(
          child: Column(
            children: [
              HomeGridViewComponent(),

            ],
          ),
        ),
      ); },),
    );
  }
}
