import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../Utilities/themes.dart';

class ShimmerCommercialAdScreen extends StatelessWidget {
  const ShimmerCommercialAdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Shimmer for Category List (Horizontal ListView)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5, // Simulate 5 shimmer items
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: CustomShimmer(
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        // Shimmer for Ads Grid
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.75,
              ),
              itemCount: 6, // Simulate 6 shimmer ads
              itemBuilder: (context, index) {
                return CustomShimmer(
                  child: _buildShimmerAdCard(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to build Shimmer AdCard
  Widget _buildShimmerAdCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shimmer for Ad Image
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Container(
                color: Colors.grey[300],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shimmer for Ad Title
                Container(
                  height: 16,
                  width: 100,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 4),
                // Shimmer for Ad Description
                Container(
                  height: 12,
                  width: 150,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Shimmer for Action Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  color: Colors.grey[300],
                ),
                Container(
                  height: 30,
                  width: 30,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Shimmer Effect Widget
class CustomShimmer extends StatelessWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;

  const CustomShimmer({
    Key? key,
    required this.child,
    this.baseColor = Colors.grey,
    this.highlightColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColorShimmer,
      highlightColor: highlightColorShimmer,
      child: child,
    );
  }
}
