import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Controllers/subcategories_controller.dart';
import '../../../../../Model/commercial_ad_model.dart';
import '../../../../../Utilities/icons.dart';
import '../../../../Widgets/utilities_widgets/custom_loader_component.dart';
import '../../Commercial/page_view_commercial_ads_screen.dart';

class CommercialAdsHorizontalForSub extends StatefulWidget {
  final String subcategoryId;
  final String categoryId;

  const CommercialAdsHorizontalForSub(
      {Key? key, required this.subcategoryId, required this.categoryId})
      : super(key: key);

  @override
  State<CommercialAdsHorizontalForSub> createState() =>
      _CommercialAdsHorizontalForSubState();
}

class _CommercialAdsHorizontalForSubState
    extends State<CommercialAdsHorizontalForSub> {
  final subCategoriesController = Get.put(SubCategoriesController());

  @override
  void initState() {
    subCategoriesController.getAllCommercialAdsForSubcategory(
        categoryId: widget.categoryId, subcategoryId: widget.subcategoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubCategoriesController>(
      builder: (_) {
        return subCategoriesController.commercialAdsPerSubcategory.length == 0
            ? SizedBox.shrink()
            : SizedBox(
                height: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: subCategoriesController
                                  .commercialAdsPerSubcategory.length ==
                              1
                          ? 1
                          : 2,
                      mainAxisExtent: Get.width * .5,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: subCategoriesController
                        .commercialAdsPerSubcategory.length,
                    itemBuilder: (context, index) {
                      return _buildAdCard(
                          subCategoriesController
                              .commercialAdsPerSubcategory[index],
                          function: () {
                        Get.to(() => PgeViewCommercialAds(
                              commercialAds: subCategoriesController
                                  .commercialAdsPerSubcategory,
                              currentIndex: index,
                            ));
                      });
                    },
                  ),
                ),
              );
      },
    );
  }

  Widget _buildAdCard(CommercialAdModel ad, {Function()? function}) {
    return GestureDetector(
      onTap: function,
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
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  child: Image.network(
                    ad.imagePath ?? '',
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child; // Image is fully loaded
                      }
                      // Show circular progress indicator until the image loads
                      return Center(
                        child: LoaderComponent(color: Colors.black54),
                      );
                    },
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      // Fallback widget when image loading fails
                      return Icon(Icons.image_not_supported);
                    },
                  ),
                ),
              ),
            ),

            // Action Buttons (WhatsApp & Call)
          ],
        ),
      ),
    );
  }
}
