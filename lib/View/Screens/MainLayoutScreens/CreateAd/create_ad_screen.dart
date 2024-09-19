import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Routes/routes.dart';
import 'package:sell_buy/Utilities/icons.dart';
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
  ItemModel _item = ItemModel(
    title: '',
    location: '',
    imagePath: '',
    price: '',
    description: '',
    category: '',
    subCategory: '',
    imageUrls: [],
    postedTime: '',
    ownerName: '',
    ownerID: '',
    isSuspended: false,
    createdAt: Timestamp.now(),
    updatedAt: Timestamp.now(),
    id: '',
  );
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
                          child: const ListTile(
                            leading: Icon(Icons.add),
                            title: Text("Add Image"),
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
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'العنوان'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال العنوان';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _item.title = value!;
                    },
                    onChanged: (value) {
                      _item.title = value;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Price Field
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'السعر'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال السعر';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _item.price = value!;
                    },
                    onChanged: (value) {
                      _item.price = value;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Description Field
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'الوصف'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال الوصف';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _item.description = value!;
                    },
                    onChanged: (value) {
                      _item.description = value;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Location Section
                  const Text('موقعك:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: () {
                      // Implement location picker functionality
                    },
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.location_pin, size: 40),
                          Text('شارع 12, الاحمدي'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Save Draft & Continue Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // Save Draft Logic
                          },
                          child: const Text('حفظ المسودة'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                            }
                          },
                          child: Obx(() {
                            return controller.isAddingAd.value
                                ? const CircularProgressIndicator()
                                : const Text('استكمل');
                          }),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
