import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Controllers/home_controller.dart';
import 'package:sell_buy/Model/ad_model.dart';
import 'package:sell_buy/Model/commercial_ad_model.dart';
import '../Home/components/add_card.dart';

class SearchScreen extends StatelessWidget {
  final homeController = Get.put(HomeController());

  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (_) {
          // Ensure the data is not null or empty
          if (homeController.adsPerCategory == null ||
              homeController.adsPerCategory.isEmpty) {
            return Center(child: CircularProgressIndicator()); // Show loading indicator
          }

          String searchText = homeController.searchText.value;

          // Perform the search
          List<AdModel> filteredAds = homeController.adsPerCategory
              .expand((ads) => ads)
              .where((ad) =>
          ad.title.toLowerCase().contains(searchText.toLowerCase()) ||
              ad.description.toLowerCase().contains(searchText.toLowerCase()))
              .toList();

          List<CommercialAdModel> filteredCommercialAds = homeController
              .getFilteredCommercialAds()
              .where((ad) =>
              ad.category.toLowerCase().contains(searchText.toLowerCase()))
              .toList();

          // Combine both lists for display
          List<dynamic> combinedResults = [...filteredAds, ...filteredCommercialAds];

          // If there's no search text, show random ads
          if (searchText.isEmpty) {
            combinedResults = [
              ...homeController.randomAds,
              ...homeController.randomCommercialAds
            ];
          }

          // Check for empty results
          if (combinedResults.isEmpty) {
            return Center(child: Text('No results found'));
          }

          // Build the ListView
          return ListView.builder(
            itemCount: combinedResults.length,
            itemBuilder: (context, index) {
              final item = combinedResults[index];
              if (item is AdModel) {
                return AdCard(item: item); // Use the AdCard widget for regular ads
              } else if (item is CommercialAdModel) {
                return _buildAdCard(item); // Use the custom function for commercial ads
              }
              return SizedBox.shrink(); // Fallback if item type is unknown
            },
          );
        },
      ),
    );
  }

  Widget _buildAdCard(CommercialAdModel ad) {
    return GestureDetector(
      onTap: () {
        // Handle tap on commercial ad
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0, right: 4.0, left: 4.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image.network(
                    ad.imagePath ?? '', // Make sure ad.imagePath is not null
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child; // Image is fully loaded
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      return Icon(Icons.image_not_supported);
                    },
                  ),
                ),
              ),
            ),
            // Ad details and action buttons (add your details here)
          ],
        ),
      ),
    );
  }
}
