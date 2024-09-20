import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Routes/routes.dart';
import 'package:sell_buy/Services/firestore_methods.dart';
import 'package:sell_buy/Utilities/icons.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/button_component.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/custom_text_from_field.dart';
import 'package:sell_buy/view/widgets/utilities_widgets/text_Component.dart';

import '../../../../Controllers/create_ad_controller.dart';
import '../../../../Model/ad_model.dart';

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

  final controller = Get.put(CreateAdController());

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
                icon: Icon(IconBroken.Arrow___Right_2),
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
                    suffixIcon: Icon(IconBroken.Location),
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
                  const SizedBox(height: 20),

                  // Location Section

                  CustomTextFromField(
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
                  ),
                  const SizedBox(height: 20),

                  ButtonComponent(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if ( controller.selectedCategoryId==null||controller.selectedSubcategoryId==null) {
                          Get.snackbar("Error".tr, "Please select category and subcategory".tr);
                        }else{                        // Create the ad object with the form data
                          ItemModel ad = ItemModel(
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
                            ownerPhoneNum :"00000000",
                            category: controller.selectedCategoryId ?? 'Unknown',
                            subCategory:
                            controller.selectedSubcategoryId ?? 'Unknown',
                            createdAt: Timestamp.now(),
                            updatedAt: Timestamp.now(),
                          );

                          // Call the controller's method to upload the ad
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
