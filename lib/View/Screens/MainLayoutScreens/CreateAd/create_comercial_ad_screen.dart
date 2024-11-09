import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Routes/routes.dart';
import 'package:sell_buy/Services/firestore_methods.dart';
import 'package:sell_buy/Utilities/icons.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/button_component.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/custom_text_from_field.dart';
import 'package:sell_buy/view/widgets/utilities_widgets/text_Component.dart';

import '../../../../Controllers/auth_controller.dart';
import '../../../../Controllers/create_ad_controller.dart';
import '../../../../Model/ad_model.dart';
import '../../../../Model/commercial_ad_model.dart';
import '../../../../Utilities/my_strings.dart';
import '../../../../Utilities/themes.dart';

class CreateCommercialAdScreen extends StatefulWidget {
  const CreateCommercialAdScreen({Key? key}) : super(key: key);

  @override
  State<CreateCommercialAdScreen> createState() => _CreateCommercialAdScreenState();
}

class _CreateCommercialAdScreenState extends State<CreateCommercialAdScreen> {
  final _formKey = GlobalKey<FormState>();

  final ownerWhatsappNumController = TextEditingController();
  final controller = Get.put(CreateAdController());
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateAdController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: TextComponent(
                text: "Create Commercials Ad".tr,
                size: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold),
            leading: IconButton(
                icon: Icon(Get.locale?.languageCode == 'en' ? IconBroken.Arrow___Left_2 :IconBroken.Arrow___Right_2),
                onPressed: () => Get.back()),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  // Category Selector
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.CategorySelectionScreen);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 3))
                        ],
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextComponent(
                            text: controller.getCategoryAndSubcategoryNames(),
                            size: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          Icon(IconBroken.Arrow___Left_2),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Image Upload Section
                  InkWell(
                    onTap: () {
                      controller
                          .getOneImageFromDevice(); // Logic for image picking
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          child: ListTile(
                            leading: Icon(IconBroken.Image),
                            title: TextComponent(
                              text: "Add Image".tr,
                              color: Colors.black,
                              size: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: controller.pickedImage == null ? 0 : 200, // Show the container only if there's an image
                          child: controller.pickedImage != null
                              ? Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: FileImage(controller.pickedImage!), // Display the single picked image
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(
                                  onPressed: () {
                                    controller.removePickedImage(); // Handle removing the image
                                  },
                                  icon: const Icon(Icons.highlight_remove_rounded),
                                ),
                              ),
                            ],
                          )
                              : const SizedBox.shrink(), // Empty widget if no image is picked
                        )

                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title Field


                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: CustomTextFromField(
                      controller: ownerWhatsappNumController,
                      obscureText: false,
                      validator: (value) {
                        if (value!.isEmpty) return 'Please enter phone number'.tr;
                        if (!RegExp(phonePattern)
                            .hasMatch(authController.countryCode.value + value))
                          return 'Please enter a valid phone number'.tr;
                        return null;
                      },
                      hintText: 'whatsapp number'.tr,
                      textInputType: TextInputType.phone,
                      prefixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CountryCodePicker(
                            padding: EdgeInsets.zero,
                            flagWidth: Get.width * .045,
                            onChanged: (code) {
                              authController.updateCountryCode(code.dialCode!);
                            },
                            initialSelection: 'SA',
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 29,
                            color: mainColor.withOpacity(.3),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                      suffixIcon: SizedBox.shrink(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  ButtonComponent(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (controller.selectedCategoryId == null ||
                            controller.selectedSubcategoryId == null ||
                            controller.selectedCategoryArName == null ||
                            controller.selectedSubcategoryArName == null) {
                          Get.snackbar("Error".tr,
                              "Please select category and subcategory".tr);
                        } else {
                          // Create the ad object with the form data
                          String whatsappPhoneNumber =
                              authController.countryCode.value +
                                  ownerWhatsappNumController.text;
                          CommercialAdModel commercialAd = CommercialAdModel(
                            id: FireStoreMethods.usersAddsCollection.doc().id,

                            imagePath: '',


                            ownerName: 'Owner Name',
                            ownerID: 'Owner ID',
                            ownerPhoneNum: "00000000",
                            category:
                            controller.selectedCategoryId ?? 'Unknown',
                            subCategory:
                            controller.selectedSubcategoryId ?? 'Unknown',
                            createdAt: Timestamp.now(),
                            updatedAt: Timestamp.now(),
                            categoryNameAr:
                            controller.selectedCategoryArName ?? '',
                            selectedSubcategoryArName:
                            controller.selectedSubcategoryArName ?? '',
                            ownerWhatsappNum: whatsappPhoneNumber,
                          );

                          // Call the controller's method to upload the ad
                          if (controller.isAddingAd.value == false) {
                            controller.uploadCommercialAd(commercialAd);
                          }
                        }
                      }
                    },
                    width: Get.width,
                    text: Obx(() {
                      return controller.isAddingAd.value
                          ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: const LinearProgressIndicator(
                          color: Colors.white,
                          semanticsLabel: 'جاري المعالجة',
                        ),
                      )
                          : TextComponent(
                        text: "Create AD".tr,
                        size: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      );
                    }),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
