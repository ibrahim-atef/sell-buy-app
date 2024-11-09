import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_shimmer_widget.dart';

class HomeLoadingShimmer extends StatelessWidget {
  final bool isOnlyCategories;

  const HomeLoadingShimmer({Key? key, this.isOnlyCategories = false})
      : super(key: key);

  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: Get.width,
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return CustomShimmer(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: const Color(0xFFE5E5EA),
                        ),
                      ),
                      baseColor: const Color(0xFFE5E5EA),
                      highlightColor: const Color(0xFFF5F5F5),
                    );
                  }),
            ),
            isOnlyCategories
                ? SizedBox.shrink()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: CustomShimmer(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: const Color(0xFFE5E5EA),
                            ),
                            width: 50,
                            height: 50,
                          ),
                          baseColor: const Color(0xFFE5E5EA),
                          highlightColor: const Color(0xFFF5F5F5),
                        ),
                        title: CustomShimmer(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: const Color(0xFFE5E5EA),
                            ),
                            width: 150,
                            height: 50,
                          ),
                          baseColor: const Color(0xFFE5E5EA),
                          highlightColor: const Color(0xFFF5F5F5),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
