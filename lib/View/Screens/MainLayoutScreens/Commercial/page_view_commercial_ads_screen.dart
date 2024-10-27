import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Model/commercial_ad_model.dart';
import 'package:sell_buy/view/widgets/utilities_widgets/text_Component.dart';

import '../../../../Controllers/ad_services_controller.dart';
import '../../../../Services/number_formater.dart';
import '../../../../Utilities/icons.dart';
import '../../../../Utilities/my_strings.dart';
import '../../../Widgets/utilities_widgets/icon_button_component.dart';

class PgeViewCommercialAds extends StatefulWidget {
  final List<CommercialAdModel> commercialAds;
  final int currentIndex;

  final PageController _pageController;

  PgeViewCommercialAds({
    required this.commercialAds,
    required this.currentIndex,
  }) : _pageController = PageController(
          initialPage: currentIndex, // Use currentIndex here
          viewportFraction: 0.84,
        );

  @override
  State<PgeViewCommercialAds> createState() => _PgeViewCommercialAdsState();
}

class _PgeViewCommercialAdsState extends State<PgeViewCommercialAds> {
  final adServicesController = Get.put(AdServicesController());

  @override
  void initState() {
    // TODO: implement initState
    adServicesController.updateViewsCount(
        adId: widget.commercialAds[widget.currentIndex].id,
        categoryCollection: widget.commercialAds[widget.currentIndex].category,
        adCollectionType: commercialsAddsCollectionKey
    );

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdServicesController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(IconBroken.Arrow___Right_2, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
                adServicesController.clearViewsCount();
              },
            ),
            actions: [
              // IconButton(
              //   icon: Icon(IconBroken.Download, color: Colors.white),
              //   onPressed: () async {
              //     // Get current image URL and download it
              //     int currentPage = widget._pageController.page?.toInt() ?? 0;
              //     String imageUrl = widget.commercialAds[currentPage].imagePath ?? '';
              //
              //     if (imageUrl.isNotEmpty) {
              //       await adServicesController.downloadImage(imageUrl);
              //     }
              //   },
              // ),
            ],
          ),
          backgroundColor: Colors.black,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // PageView for Images Only
              Expanded(
                child: PageView.builder(
                  itemCount: widget.commercialAds.length,
                  controller: widget._pageController,

                  // Use the initialized controller
                  clipBehavior: Clip.antiAlias,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index) {
                    // Modify page view events (e.g., track views)
                    adServicesController.addViewToAd(
                      adId: widget.commercialAds[index].id,
                      userId: adServicesController.userId,
                      categoryCollection: widget.commercialAds[index].category ?? '',
                      adCollectionType: commercialsAddsCollectionKey,
                    );
                    adServicesController.updateViewsCount(
                      adId: widget.commercialAds[index].id,
                      categoryCollection: widget.commercialAds[index].category ?? '',
                      adCollectionType: commercialsAddsCollectionKey,
                    );
                  },
                  itemBuilder: (context, index) {
                    final ad = widget.commercialAds[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          ad.imagePath ?? '',
                          height: Get.height * .6,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ), // Views Component Outside PageView
              _enhancedViewsComponent(
                "${NumberFormatter.formatter(adServicesController.viewsCount.toString()) ?? adServicesController.viewsCount.toString()} " +
                    "view".tr,
              ),
              SizedBox(height: Get.height * .12),

              // WhatsApp & Call Buttons Outside PageView
            ],
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              false // widget.ad.ownerWhatsappNum.isEmpty
                  ? SizedBox.shrink()
                  : IconButtonComponent(
                      iconPath: "assets/Icons/whatsapp.png",
                      title: "whatsapp".tr,
                      function: () {
                        String phoneNumber =
                            widget.commercialAds[widget._pageController.page?.toInt() ?? 0]
                                    .ownerWhatsappNum ??
                                '';
                        if (phoneNumber.isNotEmpty) {
                          adServicesController.openWhatsApp(phoneNumber);
                        }
                      },
                      h: Get.height * .06,
                      w: Get.width * .44,
                      shadowColor: Colors.black12.withOpacity(0.5),
                      color: Color(0xff00b950),
                    ),
              SizedBox(width: 20),
              false // widget.ad.ownerPhoneNum.isEmpty
                  ? SizedBox.shrink()
                  : IconButtonComponent(
                      iconPath: "assets/Icons/call.png",
                      title: "Call".tr,
                      function: () {
                        String phoneNumber =
                            widget.commercialAds[widget._pageController.page?.toInt() ?? 0]
                                    .ownerPhoneNum ??
                                '';
                        if (phoneNumber.isNotEmpty) {
                          adServicesController.openCall(phoneNumber);
                        }
                      },
                      h: Get.height * .06,
                      w: Get.width * .44,
                      shadowColor: Colors.black12.withOpacity(0.5),
                      color: Colors.blueAccent,
                    )
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  // Enhanced Views Component
  Widget _enhancedViewsComponent(String views) {
    return Container(
      width: Get.width * .5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.visibility_outlined, color: Colors.white),
          SizedBox(width: 5),
          TextComponent(
            text: views,
            size: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
