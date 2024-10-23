import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Controllers/home_controller.dart';
import 'package:sell_buy/Model/ad_model.dart';
import 'package:sell_buy/Model/commercial_ad_model.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/free_ad_space.dart';
import '../../../../Utilities/icons.dart';
import '../../../Widgets/utilities_widgets/custom_loader_component.dart';
import '../Commercial/page_view_commercial_ads_screen.dart';
import '../Home/components/add_card.dart';

class SearchScreen extends StatelessWidget {
  final homeController = Get.put(HomeController());

  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Section for regular ads
            _buildRegularAdsSection(),
            // Free ad space
            FreeAdSpace(
              width: Get.width,
              height: Get.height * 0.19,
            ),
            SizedBox(height: 8),
            // Section for commercial ads
            _buildCommercialAdsSection(),
          ],
        ),
      ),
    );
  }

  // Method to build the section for regular ads
  Widget _buildRegularAdsSection() {
    return GetBuilder<HomeController>(
      builder: (_) {
        // Ensure the data is not null or empty
        if (homeController.adsPerCategory == null || homeController.adsPerCategory.isEmpty) {
          return Center(child: LinearProgressIndicator()); // Show loading indicator
        }

        // Perform the search
        List<AdModel> filteredAds = homeController.searchFilteredAds;

        // Check for empty results
        if (filteredAds.isEmpty && homeController.randomAds.isEmpty) {
          return Center(child: Text('No results found'));
        }

        // If no filtered ads, show random ads
        if (filteredAds.isEmpty) {
          return _buildRandomAdsList();
        }

        // Build the ListView for filtered ads
        return _buildFilteredAdsList(filteredAds);
      },
    );
  }

  // Method to build the ListView for random ads
  Widget _buildRandomAdsList() {
    return SizedBox(
      height: Get.height * 0.33,
      width: Get.width,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: homeController.randomAds.length,
        itemBuilder: (context, index) {
          return AdCard(item: homeController.randomAds[index]);
        },
      ),
    );
  }

  // Method to build the ListView for filtered ads
  Widget _buildFilteredAdsList(List<AdModel> filteredAds) {
    return SizedBox(
      height: Get.height * 0.33,
      width: Get.width,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: filteredAds.length,
        itemBuilder: (context, index) {
          return AdCard(item: filteredAds[index]);
        },
      ),
    );
  }

  // Method to build the section for commercial ads
  Widget _buildCommercialAdsSection() {
    return GetBuilder<HomeController>(
      builder: (_) {
        // Filtered commercial ads
        List<CommercialAdModel> filteredCommercialAds = homeController.getFilteredCommercialAds();

        // Check for empty results
        if (filteredCommercialAds.isEmpty) {
          return Center(child: Text('No results found'));
        }

        // Build the GridView for commercial ads
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              childAspectRatio: 0.75,
            ),
            itemCount: filteredCommercialAds.length,
            itemBuilder: (context, index) {
              return _buildCommercialAdCard(filteredCommercialAds[index]);
            },
          ),
        );
      },
    );
  }

  // Method to build a commercial ad card
  Widget _buildCommercialAdCard(CommercialAdModel ad) {
    return GestureDetector(
      onTap: () {
        Get.to(() => PgeViewCommercialAds(
          commercialAds: [ad], // Pass the selected ad only
          currentIndex: 0, // Current index set to 0 as we are passing only one ad
        ));
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ad Image
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0, right: 4.0, left: 4.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.network(
                    ad.imagePath,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child; // Image is fully loaded
                      }
                      // Show circular progress indicator until the image loads
                      return Center(child: LoaderComponent(color: Colors.black54));
                    },
                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                      // Fallback widget when image loading fails
                      return Icon(Icons.image_not_supported);
                    },
                  ),
                ),
              ),
            ),
            // Action Buttons (WhatsApp & Call)
            _buildAdActionButtons(),
          ],
        ),
      ),
    );
  }

  // Method to build the action buttons for commercial ads
  Widget _buildAdActionButtons() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[300],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Image.asset("assets/Icons/whatsapp.png", width: 25, height: 25),
            onPressed: () {
              // WhatsApp action
            },
          ),
          IconButton(
            icon: Icon(IconBroken.Call, color: Colors.blue),
            onPressed: () {
              // Call action
            },
          ),
        ],
      ),
    );
  }
}
