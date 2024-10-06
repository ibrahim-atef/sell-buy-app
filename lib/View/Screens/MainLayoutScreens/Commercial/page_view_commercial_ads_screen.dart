import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Model/commercial_ad_model.dart';
import 'package:sell_buy/view/widgets/utilities_widgets/text_Component.dart';

import '../../../../Services/number_formater.dart';
import '../../../../Utilities/icons.dart';
import '../../../Widgets/utilities_widgets/icon_button_component.dart';

class PgeViewCommercialAds extends StatelessWidget {
  final List<CommercialAdModel> commercialAds;

  PgeViewCommercialAds({Key? key, required this.commercialAds})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(IconBroken.Arrow___Right_2, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(IconBroken.Download, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          // PageView for Images Only
          Expanded(
            child: PageView.builder(
              itemCount: commercialAds.length,
              pageSnapping: false,
              padEnds: false,
              clipBehavior: Clip.antiAlias,

              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final ad = commercialAds[index];
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
          ),    // Views Component Outside PageView
          _enhancedViewsComponent("300 views"),
          SizedBox(height: 12),
          // WhatsApp & Call Buttons Outside PageView
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // WhatsApp action
                  },
                  icon: Icon(Icons.calendar_month, color: Colors.white),
                  label: Text('واتساب'),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Call action
                  },
                  icon: Icon(Icons.phone, color: Colors.white),
                  label: Text('اتصل الآن'),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        false  // widget.ad.ownerWhatsappNum.isEmpty
              ? SizedBox.shrink()
              : IconButtonComponent(
            iconPath:  "assets/Icons/whatsapp.png",
            // Replace with your icon path
            title: "whatsapp".tr,
            function: () {
              // homeController
              //     .openWhatsAppOrCall(widget.ad.ownerWhatsappNum);
            },
            h : Get.height * .06,
            w : Get.width * .44,
            shadowColor:
            Colors.black12.withOpacity(0.5), color:  Color(0xff00b950), // Optional shadow color
          ),
          SizedBox(width: 20),
       false   // widget.ad.ownerPhoneNum.isEmpty
              ? SizedBox.shrink()
              :
          IconButtonComponent(
            iconPath:  "assets/Icons/call.png",
            // Replace with your icon path
            title: "Call".tr,
            function: () {
              // homeController
              //     .openCall(widget.ad.ownerPhoneNum);
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
    );
  }

  // Enhanced Views Component
  Widget _enhancedViewsComponent(String views) {
    return Container(width: Get .width * .5,
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
          Icon(
            Icons.visibility_outlined,
            color: Colors.white,
          ),
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
