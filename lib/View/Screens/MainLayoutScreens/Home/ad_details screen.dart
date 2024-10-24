import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Utilities/icons.dart';
import 'package:sell_buy/View/Screens/MainLayoutScreens/Home/components/images_page_view_widget.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/custom_shimmer_widget.dart';
import 'package:sell_buy/view/widgets/utilities_widgets/text_Component.dart';

import '../../../../Controllers/ad_services_controller.dart';
import '../../../../Controllers/home_controller.dart';
import '../../../../Model/ad_model.dart';
import '../../../../Services/number_formater.dart';
import '../../../../Utilities/my_strings.dart';
import '../../../../Utilities/themes.dart';
import '../../../Widgets/utilities_widgets/icon_button_component.dart';

class AdDetailsScreen extends StatefulWidget {
  final AdModel ad;
  final String adId;

  const AdDetailsScreen({Key? key, required this.ad, required this.adId})
      : super(key: key);

  @override
  State<AdDetailsScreen> createState() => _AdDetailsScreenState();
}

class _AdDetailsScreenState extends State<AdDetailsScreen> {
  final homeController = Get.put(HomeController());
  final adServicesController = Get.put(AdServicesController());
  bool isClosingPage = false;
  int viewsCount = 0;

  @override
  void initState() {
    super.initState();

    // Call the asynchronous method without awaiting inside initState
    _initializeAdDetails();
  }

  void _initializeAdDetails() async {
    // Check if category and userId are valid before calling the function

    adServicesController.onInit();
    if (homeController.userId != null && widget.ad.category.isNotEmpty) {
      adServicesController.addViewToAd(
        adId: widget.adId,
        userId: homeController.userId!,
        categoryCollection: widget.ad.category, adCollectionType: usersAddsCollectionKey,
      );
      adServicesController.addAdToRecentlyViewed(adModel: widget.ad);
    } else {
      // Log or handle the case where the category or userId is invalid
      print('Error: categoryCollection or userId is null/empty');
    }

    // Fetch views count asynchronously and set the state
    int count = await adServicesController.getViewsCount(
            adId: widget.adId, categoryCollection: widget.ad.category, adCollectionType: usersAddsCollectionKey,) ??
        0;

    setState(() {
      viewsCount = count;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        return GetBuilder<AdServicesController>(builder: (_) {
          return WillPopScope(
            onWillPop: () async {
              setState(() {
                isClosingPage = !isClosingPage;
              });
              if (isClosingPage) Navigator.pop(context);
              return isClosingPage;
            },
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    setState(() {
                      isClosingPage = !isClosingPage;
                    });
                    if (isClosingPage) Navigator.pop(context);
                  },
                  icon: Icon(IconBroken.Arrow___Right_2),
                ),
                actions: [
                  adServicesController.isAddingToFavourites.value
                      ? IconButton(
                          onPressed: () {},
                          icon: CustomShimmer(
                            child: Icon(Icons.heart_broken),
                            baseColor: baseColorShimmer,
                            highlightColor: grey,
                          ))
                      : adServicesController.isAdFavourite(widget.adId)
                          ? IconButton(
                              onPressed: () {
                                adServicesController.removeAdFromFavourites(
                                  adId: widget.adId,
                                  userId: homeController.userId!,
                                );
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                adServicesController.addAdToFavourites(
                                    adModel: widget.ad,
                                    userId: homeController.userId ?? "");
                              },
                              icon: Icon(
                                IconBroken.Heart,
                              ),
                            )
                ],
                title: Text('Ad Details'.tr),
              ),
              body: Directionality(
                textDirection: Get.locale?.languageCode == "ar"
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Page View Widget to display images
                      ImagePageViewWidget(
                        imageUrls: widget.ad.imageUrls,
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          TextIcon(
                            text:
                                "${NumberFormatter.formatter(viewsCount.toString()) ?? viewsCount.toString()} " +
                                    "view".tr,
                            icon: Icons.visibility_outlined,
                          ),
                          SizedBox(width: 10),
                          TextIcon(
                              text: adServicesController.timePassed(
                                  widget.ad.createdAt.millisecondsSinceEpoch),
                              icon: IconBroken.Time_Circle),
                        ],
                      ),
                      // Ad Title and Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Get.width * .7,
                                child: TextComponent(
                                  text: widget.ad.title,
                                  size: 20,
                                  maxLines: 3,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextComponent(
                                  text: ' ${widget.ad.price} SA ',
                                  size: 18,
                                  color: mainColor.withOpacity(0.7),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Ad Description
                      TextComponent(
                        text: "مواصفات الاعلان".tr,
                        size: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextComponent(
                          text: widget.ad.description,
                          size: 18,
                          fontWeight: FontWeight.w400,
                          color: grey,
                          maxLines: 8,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Ad Location
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.red),
                            SizedBox(width: 5),
                            SizedBox(
                              width: Get.width * .7,
                              child: TextComponent(
                                text: widget.ad.location,
                                size: 16,
                                maxLines: 2,
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      // Ad Posted Time
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.access_time, color: Colors.grey),
                            SizedBox(width: 5),
                            Text(
                              adServicesController.timePassed(
                                  widget.ad.createdAt.millisecondsSinceEpoch),
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      // Contact Info (Owner Name and Phone Number)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextComponent(
                              text: 'Owner: '.tr + '${widget.ad.ownerName}',
                              size: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                      SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
              // Contact via WhatsApp Button
              floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.ad.ownerWhatsappNum.isEmpty
                      ? SizedBox.shrink()
                      : IconButtonComponent(
                          iconPath:  "assets/Icons/whatsapp.png",
                          // Replace with your icon path
                          title: "whatsapp".tr,
                          function: () {
                            homeController
                                .openWhatsApp(widget.ad.ownerWhatsappNum);
                          },
                    h : Get.height * .06,
                    w : Get.width * .44,
                          shadowColor:
                          Colors.black12.withOpacity(0.5), color:  Color(0xff00b950), // Optional shadow color
                        ),
                  SizedBox(width: 20),
                  widget.ad.ownerPhoneNum.isEmpty
                      ? SizedBox.shrink()
                      :
                  IconButtonComponent(
                    iconPath:  "assets/Icons/call.png",
                    // Replace with your icon path
                    title: "Call".tr,
                    function: () {
                      homeController
                          .openCall(widget.ad.ownerPhoneNum);
                    },
                    h : Get.height * .06,
                    w : Get.width * .44,
                    shadowColor:
                    Colors.black12.withOpacity(0.5), color:  Colors.blueAccent, // Optional shadow color
                  )

                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            ),
          );
        });
      },
    );
  }
}

Widget TextIcon({required String text, required IconData icon}) {
  return Row(
    children: [
      Icon(
        icon,
        color: Colors.grey,
      ),
      SizedBox(width: 5),
      TextComponent(
          text: text,
          size: 12,
          color: Colors.black54,
          fontWeight: FontWeight.normal),
    ],
  );
}
