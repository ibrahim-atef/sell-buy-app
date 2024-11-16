import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Screens/MainLayoutScreens/Commercial/components/shimmer_commercial_ad_screen.dart';

class ListLoadingShimmer extends StatelessWidget {
  const ListLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          child: SizedBox(
            height: Get.height * 0.15,
            width: Get.width,
            child: Row(
              children: [
                CustomShimmer(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: const Color(0xFFE5E5EA),
                    ),
                    height: Get.height * 0.15,
                    width: Get.width * 0.4,
                  ),
                  baseColor: const Color(0xFFE5E5EA),
                  highlightColor: const Color(0xFFF5F5F5),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      CustomShimmer(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: const Color(0xFFE5E5EA),
                          ),
                          height: Get.height * 0.01,
                          width: Get.width * 0.5,
                        ),
                        baseColor: const Color(0xFFE5E5EA),
                        highlightColor: const Color(0xFFF5F5F5),
                      ),
                      SizedBox(height:5,),
                      CustomShimmer(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: const Color(0xFFE5E5EA),
                          ),
                          height: Get.height * 0.01,
                          width: Get.width * 0.5,
                        ),
                        baseColor: const Color(0xFFE5E5EA),
                        highlightColor: const Color(0xFFF5F5F5),
                      ),
                      SizedBox(height:5,),
                      CustomShimmer(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: const Color(0xFFE5E5EA),
                          ),
                          height: Get.height * 0.01,
                          width: Get.width * 0.5,
                        ),
                        baseColor: const Color(0xFFE5E5EA),
                        highlightColor: const Color(0xFFF5F5F5),
                      ),
                      SizedBox(height:5,),
                      CustomShimmer(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: const Color(0xFFE5E5EA),
                          ),
                          height: Get.height * 0.07,
                          width: Get.width * 0.5,
                        ),
                        baseColor: const Color(0xFFE5E5EA),
                        highlightColor: const Color(0xFFF5F5F5),
                      ),
                      SizedBox( height:5,),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
      itemCount: 9,
    );
  }
}
