import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Utilities/icons.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/text_Component.dart';
import '../../../../../Controllers/subcategories_controller.dart';
import '../../../../../Utilities/themes.dart';
import '../../../../Widgets/utilities_widgets/button_component.dart';
import '../../../../Widgets/utilities_widgets/custom_filter_screen.dart';
import '../../../../Widgets/utilities_widgets/custom_text_from_field.dart';
import '../SubCategories/FiltersScreens/year_of_production_screen.dart';

class DynamicCustomFiltersBarSection extends StatefulWidget {
  final Map<String, dynamic> adExtraDetails;


  DynamicCustomFiltersBarSection({super.key, required this.adExtraDetails, });

  @override
  State<DynamicCustomFiltersBarSection> createState() =>
      _DynamicCustomFiltersBarSectionState();
}

class _DynamicCustomFiltersBarSectionState
    extends State<DynamicCustomFiltersBarSection> {
  final subCategoriesController = Get.put(SubCategoriesController());

  // Filter values
  String? selectedYear,
      selectedBrand,
      selectedType,
      boatCustomType,
      selectedStorage,
      deviceStatus,
      jobType,
      selectedFuel,
      roomsCount,
      accessories_custom_type,
      spare_parts_type,
      storageCapacity;

  @override
  void initState() {
    super.initState();
  }

  /// Handles filter selection logic based on the filter key
  void _handleFilterSelection(BuildContext context, String filterKey) async {
    switch (filterKey.toLowerCase()) {
      case 'price':
        _openPriceModal(context);
        break;
      case 'counter':
        _openCounterModal(context);
        break;

      case 'year of production':
        selectedYear = await Get.to(() => YearOfProductionScreen(
              allowMultipleSelection: true,
            ));
        if (selectedYear != null) {
          subCategoriesController.appliedFilters['Year of Production'] =
              selectedYear!;
        }
        break;
      case "accessoriescustomtype":
        accessories_custom_type = await Get.to(() => CustomFilterScreen(
              title: "type",
              options: [
                "Car accessories",
                "Automotive equipment",
                "Car rims",
                "Auto mix",
                "Bicycle accessories",
              ],
            ));
        if (selectedType != null) {
          subCategoriesController.appliedFilters['accessoriesCustomType'] =
              accessories_custom_type!;
        }
        break;
      case "sparepartstype":
        spare_parts_type = await Get.to(() => CustomFilterScreen(
              title: "type",
              options: [
                "car spare parts",
                "large vehicle spare parts",
                "machines and gears",
                "Various marine equipment",
                "bicycle spare parts",
              ],
            ));
        if (selectedType != null) {
          subCategoriesController.appliedFilters['sparePartsType'] =
              spare_parts_type!;
        }
        break;
      case 'brand':
        selectedBrand = await Get.to(() => CustomFilterScreen(
              title: "Brand",
              options: [
                "Audi",
                "BMW",
                "Cadillac",
                "Chevrolet",
                "Chrysler",
                "Ford",
                "GMC",
                "Honda",
                "Hyundai",
                "Jaguar",
                "Kia",
                "Land Rover",
                "Lexus",
                "Lincoln",
                "Mercedes",
                "Mitsubishi",
                "Nissan",
                "Porsche",
              ],
            ));
        if (selectedBrand != null) {
          subCategoriesController.appliedFilters['Brand'] = selectedBrand!;
        }
        break;
      case "storagecapacity":
        storageCapacity = await Get.to(() => CustomFilterScreen(
              title: "storageCapacity",
              options: [
                "16 GB",
                "32 GB",
                "64 GB",
                "128 GB",
                "512 GB",
                "1 TB",
              ],
            ));
        if (storageCapacity != null) {
          subCategoriesController.appliedFilters['storagecapacity'] =
              storageCapacity!;
        }
        break;
      case "devicestatus":
        deviceStatus = await Get.to(() => CustomFilterScreen(
              title: "deviceStatus",
              options: [
                "New",
                "Used",
              ],
            ));
        if (deviceStatus != null) {
          subCategoriesController.appliedFilters['deviceStatus'] =
              deviceStatus!;
        }
        break;
      case "jobtype":
        jobType = await Get.to(() => CustomFilterScreen(
              title: "jobType",
              options: [
                "Part-Time Job",
                "Accounting",
                "Engineers",
                "Information Technology",
                "Medicine",
                "Restaurant Jobs",
                "Hospitality and Tourism",
                "Driver",
                "Legal",
                "Other Jobs",
                "Marketing",
                "Human Resources",
                "Cashier",
                "Assistant or Secretary",
                "Sales",
                "Service Jobs",
              ],
            ));
        if (jobType != null) {
          subCategoriesController.appliedFilters['jobType'] = jobType!;
        }
        break;

      case 'boatcustomtype':
        boatCustomType = await Get.to(() => CustomFilterScreen(
              title: "type",
              options: [
                "Boats for Sale",
                "Marine Trips",
                "Jet Ski",
                "Boats Wanted",
              ],
            ));
        if (boatCustomType != null) {
          subCategoriesController.appliedFilters['boatCustomType'] =
              boatCustomType!;
        }
        break;

      case 'fueltype':
        selectedFuel = await Get.to(() => CustomFilterScreen(
              title: "Fuel Type",
              options: [
                "gasoline",
                "diesel",
                "mixed",
                "electrical",
                "Flexible fuel",
                "Hydrogen fuel cell",
                "natural gas"
              ],
            ));
        if (selectedFuel != null) {
          subCategoriesController.appliedFilters['FuelType'] = selectedFuel!;
        }
        break;

      case 'rooms_count':
        roomsCount = await Get.to(() => CustomFilterScreen(
              title: "rooms_count",
              options: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"],
            ));
        if (roomsCount != null) {
          subCategoriesController.appliedFilters['rooms_count'] = roomsCount!;
        }
        break;

      default:
        // Handle other filter keys;
        print('Filter key not found: $filterKey');
        break;
    }

    _applyFilters();
  }

  /// Applies selected filters to the ads
  void _applyFilters() {
    if (subCategoriesController.appliedFilters.isNotEmpty) {
      subCategoriesController.filterAds(
        subCategoriesController.appliedFilters
            .map((key, value) => MapEntry(key, value.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filterKeys = widget.adExtraDetails.keys
        .where((key) => key != "Full Specifications")
        .toList(); // Filter out "Full Specifications"
    if ((filterKeys.isEmpty &&
        widget.adExtraDetails.keys.contains("Full Specifications")) ) {
      return SizedBox
          .shrink(); // Don't show anything if only "Full Specifications" exists
    }
    return SizedBox(
      width: Get.width,
      height: Get.height * 0.07,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 8),
              scrollDirection: Axis.horizontal,
              itemCount: filterKeys.length,
              itemBuilder: (BuildContext context, int index) {
                final key = filterKeys[index];
                return _buildFilterItem(
                  context: context,
                  title: key,
                  onTap: () => _handleFilterSelection(context, key.toLowerCase()),
                );
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              subCategoriesController.clearFilters();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterItem({
    required BuildContext context,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Get.height * 0.05,
        margin: const EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            TextComponent(
              text: title.tr,
              color: Colors.black,
              size: 14,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.black,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  void _openPriceModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: Get.height * .33,
          child: Card(
            margin: EdgeInsets.all(0),
            elevation: .2,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(IconBroken.Close_Square),
                      ),
                      TextComponent(
                        text: "price".tr,
                        size: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                  Divider(
                    thickness: .4,
                    color: Colors.grey[400],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: Get.width * .4,
                        height: Get.height * .07,
                        child: CustomTextFromField(
                          controller:
                              subCategoriesController.minPriceController,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid price'.tr;
                            }
                            return null;
                          },
                          hintText: "Min",
                          textInputType: TextInputType.number,
                          suffixIcon: null,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * .4,
                        height: Get.height * .07,
                        child: CustomTextFromField(
                          controller:
                              subCategoriesController.maxPriceController,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid price'.tr;
                            }
                            return null;
                          },
                          hintText: "Max",
                          textInputType: TextInputType.number,
                          suffixIcon: null,
                        ),
                      ),
                    ],
                  ),
                  ButtonComponent(
                    onPressed: () {
                      // Fetch the input values
                      double minPrice = double.tryParse(
                            subCategoriesController.minPriceController.text,
                          ) ??
                          0.0; // Default to 0 if parsing fails
                      double maxPrice = double.tryParse(
                            subCategoriesController.maxPriceController.text,
                          ) ??
                          double
                              .infinity; // Default to infinity if parsing fails

                      // Apply the filtering logic
                      subCategoriesController.filterAds({
                        'price': '$minPrice-$maxPrice',
                      });

                      Get.back();
                    },
                    text: TextComponent(
                      text: "viewResults".tr,
                      size: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    width: Get.width * .9,
                    backgroundColor: Colors.blueAccent,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildSB() {
    return SizedBox(height: Get.height * .01);
  }

  void _openCounterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: Get.height * .33,
          child: Card(
            margin: EdgeInsets.all(0),
            elevation: .2,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Header Row with Close Button and Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(IconBroken.Close_Square),
                      ),
                      TextComponent(
                        text: "Counter".tr,
                        size: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                  Divider(
                    thickness: .4,
                    color: Colors.grey[400],
                  ),
                  // Input Fields for Min and Max Counter
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Minimum Counter Input
                      SizedBox(
                        width: Get.width * .4,
                        height: Get.height * .07,
                        child: CustomTextFromField(
                          controller:
                              subCategoriesController.minPriceController,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid counter value'.tr;
                            }
                            return null;
                          },
                          hintText: "Min Counter",
                          textInputType: TextInputType.number,
                          suffixIcon: null,
                        ),
                      ),
                      // Maximum Counter Input
                      SizedBox(
                        width: Get.width * .4,
                        height: Get.height * .07,
                        child: CustomTextFromField(
                          controller:
                              subCategoriesController.maxPriceController,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid counter value'.tr;
                            }
                            return null;
                          },
                          hintText: "Max Counter",
                          textInputType: TextInputType.number,
                          suffixIcon: null,
                        ),
                      ),
                    ],
                  ),
                  // Apply Filter Button
                  ButtonComponent(
                    onPressed: () {
                      // Parse and validate inputs
                      double minCounter = double.tryParse(
                            subCategoriesController.minPriceController.text,
                          ) ??
                          0.0; // Default to 0 if parsing fails
                      double maxCounter = double.tryParse(
                            subCategoriesController.maxPriceController.text,
                          ) ??
                          double
                              .infinity; // Default to infinity if parsing fails

                      // Apply filtering logic
                      subCategoriesController.filterAds({
                        'counter': '$minCounter-$maxCounter',
                      });

                      // Close the modal and notify the user
                      Get.back();
                      Get.snackbar(
                        "Filter Applied",
                        "Filtered ads by counter range: $minCounter - $maxCounter",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    text: TextComponent(
                      text: "viewResults".tr,
                      size: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    width: Get.width * .9,
                    backgroundColor: Colors.blueAccent,
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
