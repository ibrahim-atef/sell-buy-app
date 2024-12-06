import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Routes/routes.dart';
import 'package:sell_buy/Services/firestore_methods.dart';
import 'package:sell_buy/Utilities/icons.dart';
import 'package:sell_buy/View/Screens/MainLayoutScreens/CreateAd/external_screens/add_ad_extra_details.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/button_component.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/custom_text_from_field.dart';
import 'package:sell_buy/view/widgets/utilities_widgets/text_Component.dart';

import '../../../../Controllers/auth_controller.dart';
import '../../../../Controllers/create_ad_controller.dart';
import '../../../../Model/ad_model.dart';
import '../../../../Model/location_model.dart';
import '../../../../Utilities/my_strings.dart';
import '../../../../Utilities/themes.dart';
import 'external_screens/location_selection_screen.dart';

class CreateAdScreen extends StatefulWidget {
  const CreateAdScreen({Key? key}) : super(key: key);

  @override
  State<CreateAdScreen> createState() => _CreateAdScreenState();
}

class _CreateAdScreenState extends State<CreateAdScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final ownerWhatsappNumController = TextEditingController();
  final controller = Get.put(CreateAdController());
  final authController = Get.put(AuthController());
  late LocationModel _selectedLocationModel;

  Future<void> selectLocation() async {
    final selectedLocation = await Get.to(() => LocationSelectionScreen());
    if (selectedLocation != null) {
      setState(() {
        final governorate = selectedLocation['governorate'] as Governorate?;
        final region = selectedLocation['region'] as Region?;
        final district = selectedLocation['district'] as District?;

        // Display only the name based on locale
        final locale = Get.locale?.languageCode;
        addressController.text =
            "${locale == 'ar' ? governorate?.arName : governorate?.enName} - "
            "${locale == 'ar' ? region?.nameAr : region?.nameEn} - "
            "${locale == 'ar' ? district?.nameAr : district?.nameEn}";

        debugPrint(
            "${governorate!.enName} - ${region!.nameAr} - ${district!.nameAr}");
        // Store the full objects for saving later
        _selectedLocationModel = LocationModel(
            governorateArName: governorate.arName,
            governorateEnName: governorate.enName,
            regionArName: region!.nameAr,
            regionEnName: region.nameEn,
            districtArName: district!.nameAr,
            districtEnName: district.nameEn);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateAdController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: TextComponent(
                text: "Create Ad".tr,
                size: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold),
            leading: IconButton(
                icon: Icon(Get.locale?.languageCode == 'en'
                    ? IconBroken.Arrow___Left_2
                    : IconBroken.Arrow___Right_2),
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
                          Expanded(
                            child: TextComponent(
                              text: controller.getCategoryAndSubcategoryNames(),
                              size: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
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
                          .getImageFromDevice(); // Logic for image picking
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
                          height: controller.pickedImages!.isEmpty ? 0 : 200,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              int crossAxisCount = constraints.maxWidth ~/
                                  200; // Assuming each image has a width of 200
                              crossAxisCount = crossAxisCount > 0
                                  ? crossAxisCount
                                  : 2; // Ensure at least 1 column

                              if (controller.pickedImages!.length >= 3) {
                                crossAxisCount =
                                    2; // Set to 2 columns if more than 3 images
                              }

                              return GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 1,
                                ),
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.pickedImages!.length,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            image: FileImage(controller
                                                .pickedImages![index]),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: IconButton(
                                          onPressed: () {
                                            controller
                                                .removeImageFromImagesList(
                                                    index);
                                          },
                                          icon: const Icon(
                                              Icons.highlight_remove_rounded),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title Field
                  CustomTextFromField(
                    controller: titleController,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter title".tr;
                      }
                    },
                    hintText: 'title'.tr,
                    textInputType: TextInputType.text,
                    suffixIcon: Icon(IconBroken.Document),
                  ),

                  const SizedBox(height: 20),

                  // Price Field
                  CustomTextFromField(
                    controller: priceController,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the price'.tr;
                      }
                    },
                    hintText: 'price'.tr,
                    textInputType: TextInputType.number,
                    suffixIcon: Icon(IconBroken.Discount),
                  ),
                  const SizedBox(height: 20),

                  // Description Field
                  CustomTextFromField(
                    controller: descriptionController,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description'.tr;
                      }
                      return null;
                    },
                    hintText: 'description'.tr,
                    textInputType: TextInputType.multiline,
                    maxLines: 2,
                    suffixIcon: SizedBox.shrink(),
                  ),
                  SizedBox(height: 10),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: CustomTextFromField(
                      controller: ownerWhatsappNumController,
                      obscureText: false,
                      validator: (value) {
                        if (value!.isEmpty)
                          return 'Please enter phone number'.tr;
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

                  // Location Section

                  GestureDetector(
                    onTap: () {
                      selectLocation();
                    },
                    child: CustomTextFromField(
                      controller: addressController,
                      hintText: 'address'.tr,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter address'.tr;
                        }
                        return null;
                      },
                      obscureText: false,
                      textInputType: TextInputType.text,
                      suffixIcon: Icon(IconBroken.Location),
                      enabled: false,
                    ),
                  ),
                  const SizedBox(height: 20),

                  ButtonComponent(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (controller.selectedCategoryId == null ||
                            controller.selectedSubcategoryId == null ||
                            controller.selectedCategoryArName == null ||
                            controller.selectedSubcategoryArName == null) {
                          Get.snackbar("Error".tr,
                              "Please select category and subcategory".tr);
                        } else if (controller.pickedImages!.isEmpty) {
                          Get.snackbar("Error".tr,
                              'Please select at least one image.'.tr);
                        } else {
                          // Create the ad object with the form data
                          String whatsappPhoneNumber =
                              authController.countryCode.value +
                                  ownerWhatsappNumController.text;
                          AdModel ad = AdModel(
                              id: FireStoreMethods.usersAddsCollection.doc().id,
                              title: titleController.text.trim(),
                              description: descriptionController.text.trim(),
                              location: addressController.text.trim(),
                              imagePath: '',
                              imageUrls: [],
                              price: priceController.text.trim(),
                              postedTime: DateTime.now().toString(),
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
                              thirdSubCategory:
                                  controller.selectedLastSubcategoryId ?? "",
                              thirdSubCategoryArName:
                                  controller.selectedLastSubcategoryArName ??
                                      "",
                              locationModel: _selectedLocationModel);
                          debugPrint(
                              "selectedSubcategoryId: ${controller.selectedSubcategoryId}");
                          controller.extraAdDetails.keys.isEmpty
                              ? await Get.to(() => AddAdExtraDetails(
                                    subCategoryId:
                                        controller.selectedSubcategoryId!,
                                  ))
                              : null;
                          // Call the controller's method to upload the ad
                         
                          if (controller.extraAdDetails.keys.isEmpty) {
                            Get.snackbar(
                              "Error".tr,
                              "Please enter additional details".tr,
                            );
                            return;
                          }
                          ad.adExtraDetails = controller.extraAdDetails;
                          if (controller.isAddingAd.value == false) {
                            controller.uploadAd(ad);
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
