import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Controllers/create_ad_controller.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/text_Component.dart';

import '../../../../../Utilities/icons.dart';
import '../../../../../Utilities/themes.dart';
import '../../../../Widgets/utilities_widgets/button_component.dart';
import '../../../../Widgets/utilities_widgets/custom_filter_screen.dart';
import '../../../../Widgets/utilities_widgets/custom_text_from_field.dart';
import '../../Home/SubCategories/FiltersScreens/brand_filters_screen.dart';
import '../../Home/SubCategories/FiltersScreens/year_of_production_screen.dart';

class AddAdExtraDetails extends StatefulWidget {
  final String subCategoryId;

  AddAdExtraDetails({super.key, required this.subCategoryId});

  @override
  State<AddAdExtraDetails> createState() => _AddAdExtraDetailsState();
}

class _AddAdExtraDetailsState extends State<AddAdExtraDetails> {
  final _formKey = GlobalKey<FormState>();

  String? selectedYear, selectedBrand, selectedFuel, selectedType,  selectedStorage,deviceStatus,jobType ;
  String?    boatCustomType, accessoriesCustomType, sparePartsType,rooms_count;


  final adController = Get.put(CreateAdController());
  TextEditingController carCounterController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController fullSpecificationsController = TextEditingController();

  // Filters for subcategories
  final Map<String, List<String>> subCategoryFilters = {
    'Used Cars': ['brand', 'price', 'year', 'counter', "more_specifications","FuelType"],
    'Classic Cars': ["more_specifications"],
    // No additional filters
    'Scrap Cars': ["more_specifications"],
    // No additional filters
    'Wanted & Wanted for Purchase': [
      'price',
      'year',
      'counter',
      "FuelType",
      "more_specifications"
    ],
    'Motorcycles': ["more_specifications","price"],
    // Depends on last subcategories
    'Boats & Jet Skis': ['boat_custom_type', 'price', "more_specifications"],
    'Motor Services': ["more_specifications"],
    // Normal but last subcategories are normal
    'Spare Parts': ['spare_parts_type', 'price', "more_specifications"],
    'Vehicle Accessories': [
      'accessories_custom_type',
      'price' "more_specifications"
    ],
    'Vehicles & Equipment': [
      'type',
      'price',
      'year',
      'counter' "more_specifications"
    ],
    'Car Rental Offices': [
      'vehicle_type',
      'brand',
      'price',
      'year',
      'counter',
      "FuelType",
      "more_specifications"
    ],
    "Car Offices": [ "more_specifications", "brand", "price", "year", "counter"],
    'Food Trucks': ["more_specifications"],
    // Normal
    'Agencies': ["more_specifications"],
    // Normal
    'New Cars': ["more_specifications", "brand", "price", "year", "counter"],
    // Normal
    'Rentals': ['custom_type', 'brand', 'price', 'year', 'counter'],
    "real-estate-apartments": ["more_specifications", "rooms_count", "price"],
    "real-estate-commercial": ["more_specifications", "rooms_count", "price"],
    "real-estate-houses": ["more_specifications", "rooms_count", "price"],
    "electronics-accessories": [
      "more_specifications",
      "storageCapacity",
      "price",
      "deviceStatus"
    ],
    "electronics-laptops": [
      "more_specifications",
      "storageCapacity",
      "deviceStatus"
    ],
    "electronics-phones": [
      "more_specifications",
      "storageCapacity",
      "price",
      "deviceStatus"
    ],
    "home-appliances-cleaning": [
      "more_specifications",
    ],
    "home-appliances-kitchen": [
      "more_specifications",
    ],
    "home-appliances-laundry": [
      "more_specifications",
    ],
    "jobs-freelance": ["more_specifications", "jobType"],
    "jobs-full-time": ["more_specifications", "jobType"],
    "jobs-part-time": ["more_specifications", "jobType"],
    "books-educational": ["more_specifications"],
    "books-fictions": ["more_specifications"],
    "books-non-fiction": ["more_specifications"],
    "fashion-accessories": ["more_specifications"],
    "fashion-mens-clothing": ["more_specifications"],
    "fashion-womens-clothing": ["more_specifications"],
    "furniture-bedroom": ["more_specifications"],
    "furniture-living-room": ["more_specifications"],
    "furniture-office" : ["more_specifications"],
    "pets-accessories": ["more_specifications"],
    "pets-cats": ["more_specifications"],
    "pets-dogs": ["more_specifications"],
    "services-educational": ["more_specifications"],
    "services-home-repair": ["more_specifications"],
    "services-transport": ["more_specifications"],
    "travel-flights": ["more_specifications"],
    "travel-hotels": ["more_specifications"],
    "travel-tours": ["more_specifications"],
  };

  // Utility function to render specific filter widgets
  Widget buildFilterField(String filterKey) {
    switch (filterKey) {
      case 'brand':
        return buildOptionField(
          label: 'Brand'.tr,
          selectedValue: selectedBrand,
          onTap: () async {
            selectedBrand = await Get.to(() =>  CustomFilterScreen(title: "Brand", options: [
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
            ]));
            setState(() {});
          },
        );
      case 'price':
        return CustomTextFromField(
          controller: priceController,
          obscureText: false,
          hintText: "price".tr,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a price";
            }
            return null;
          },
          textInputType: TextInputType.number,
          suffixIcon: null,
        );
        case "FuelType":
        return buildOptionField(
          label: 'FuelType'.tr,
          selectedValue: selectedFuel,
          onTap: () async {
            selectedFuel = await Get.to(() => CustomFilterScreen(
                  title: 'FuelType',
                  options: ["gasoline", "diesel", "mixed", "electrical", "Flexible fuel", "Hydrogen fuel cell", "natural gas"],
                ));
            setState(() {});
          },
        ) ;
      case 'year':
        return buildOptionField(
          label: 'Year of Production'.tr,
          selectedValue: selectedYear,
          onTap: () async {
            selectedYear = await Get.to(() => YearOfProductionScreen(
                  allowMultipleSelection: false,
                ));
            setState(() {});
          },
        );
      case 'counter':
        return CustomTextFromField(
          controller: carCounterController,
          obscureText: false,
          hintText: "Counter".tr,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter the counter value";
            }
            return null;
          },
          textInputType: TextInputType.number,
          suffixIcon: null,
        );

      case "custom_type":
        return buildOptionField(
          label: 'type'.tr,
          selectedValue: selectedType,
          onTap: () async {
            selectedType = await Get.to(() => CustomFilterScreen(
                  title: 'type',
                  options: [
                    "Buses for rent",
                    "Cars",
                    "Equipment for rent",
                    "Boat rental",
                    "Bicycle rental",
                    "taxi",
                  ],
                ));
          },
        );
      case "accessories_custom_type":
        return buildOptionField(
          label: 'type'.tr,
          selectedValue: accessoriesCustomType,
          onTap: () async {
            accessoriesCustomType = await Get.to(() => CustomFilterScreen(
                  title: 'type',
                  options: [
                    "Car accessories",
                    "Automotive equipment",
                    "Car rims",
                    "Auto mix",
                    "Bicycle accessories",
                  ],
                ));      setState(() {

                }) ;
          },
        );
      case "spare_parts_type":
        return buildOptionField(
          label: 'type'.tr,
          selectedValue: sparePartsType,
          onTap: () async {
            sparePartsType = await Get.to(() => CustomFilterScreen(
                  title: 'type'.tr,
                  options: [
                    "car spare parts",
                    "large vehicle spare parts",
                    "machines and gears",
                    "Various marine equipment",
                    "bicycle spare parts",
                  ],
                ));      setState(() {

            });
          },
        );
      case "boat_custom_type":
        return buildOptionField(
          label: 'type'.tr,
          selectedValue:  boatCustomType,
          onTap: () async {
             boatCustomType = await Get.to(() => CustomFilterScreen(
                  title: 'type',
                  options: [
                    "Boats for Sale",
                    "Marine Trips",
                    "Jet Ski",
                    "Boats Wanted",
                  ],
                ));
          },
        );
      case "rooms_count":
        return buildOptionField(
          label: 'rooms_count'.tr,
          selectedValue: rooms_count,
          onTap: () async {
            rooms_count = await Get.to(() => CustomFilterScreen(
                  title: 'rooms_count',
                  options: [
                    "1",
                    "2",
                    "3",
                    "4",
                    "5",
                    "6",
                    "7",
                    "8",
                    "9",
                    "10",
                  ],
                ));
          },
        );
      case "storageCapacity":
        return buildOptionField(
          label: 'storageCapacity'.tr,
          selectedValue: selectedStorage,
          onTap: () async {
            selectedStorage = await Get.to(() => CustomFilterScreen(
                  title: 'storageCapacity'.tr,
                  options: [
                    "16 GB",
                    "32 GB",
                    "64 GB",
                    "128 GB",
                    "512 GB",
                    "1 TB",
                  ],
                ));
            setState(() {

            });
          },
        );
      case "deviceStatus":
        return buildOptionField(
          label: 'deviceStatus'.tr,
          selectedValue: deviceStatus,
          onTap: () async {
            deviceStatus = await Get.to(() => CustomFilterScreen(
                  title: 'deviceStatus'.tr,
                  options: [
                    "New",
                    "Used",
                  ],
                ));     setState(() {

            });
          },
        );
          case "jobType":
        return buildOptionField(
          label: 'jobType'.tr,
          selectedValue: jobType,
          onTap: () async {
            jobType = await Get.to(() => CustomFilterScreen(
                  title: 'jobType'.tr,
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
                ));     setState(() {

            });
          },
        );
      case "more_specifications":
        return CustomTextFromField(
          controller: fullSpecificationsController,
          obscureText: false,
          hintText: "Full Specifications".tr,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter the Full Specifications".tr;
            }
            return null;
          },
          textInputType: TextInputType.text,
          suffixIcon: null,
        );

      default:
        return SizedBox.shrink();
    }
  }

  Widget buildOptionField({
    required String label,
    String? selectedValue,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.all(0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54, width: .5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(selectedValue ?? label),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Fetch the required filters for the selected subcategory
    List<String> filters = subCategoryFilters[widget.subCategoryId] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: TextComponent(
          text: "Add Extra Details".tr,
          size: 18,
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Get.locale?.languageCode == 'en'
                ? IconBroken.Arrow___Left_2
                : IconBroken.Arrow___Right_2,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(4.0),
            children: [
              // Render dynamic filters based on subcategory
              for (String filter in filters)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildFilterField(filter),
                ),

              SizedBox(height: 20),

              // Submit Button
              ButtonComponent(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    adController.extraAdDetails = {
                      if (selectedYear != null && selectedYear!.isNotEmpty) 'Year of Production': selectedYear,
                      if (selectedBrand != null && selectedBrand!.isNotEmpty) 'Brand': selectedBrand,
                      if (priceController.text.isNotEmpty) 'price': priceController.text,
                      if (carCounterController.text.isNotEmpty) 'Counter': carCounterController.text,
                      if (selectedType != null && selectedType!.isNotEmpty) 'type': selectedType,
                      if (fullSpecificationsController.text.isNotEmpty) 'Full Specifications': fullSpecificationsController.text,
                      if (boatCustomType != null && boatCustomType!.isNotEmpty) 'boatCustomType': boatCustomType,
                      if (accessoriesCustomType != null && accessoriesCustomType!.isNotEmpty) 'accessoriesCustomType': accessoriesCustomType,
                      if (sparePartsType != null && sparePartsType!.isNotEmpty) 'sparePartsType': sparePartsType,
                      if (selectedStorage != null && selectedStorage!.isNotEmpty) 'storageCapacity': selectedStorage,
                      if (deviceStatus != null && deviceStatus!.isNotEmpty) 'deviceStatus': deviceStatus,
                      if (jobType != null && jobType!.isNotEmpty) 'jobType': jobType,
                      if (selectedFuel != null && selectedFuel!.isNotEmpty) 'FuelType': selectedFuel,
                      if (rooms_count != null && rooms_count!.isNotEmpty) 'rooms_count': rooms_count


                    };

                    debugPrint(adController.extraAdDetails.toString());
                    Navigator.pop(context, adController.extraAdDetails);
                  } else {
                    print("Form is invalid");
                  }
                },
                text: TextComponent(
                  text: "Create AD".tr,
                  size: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                width: Get.width * .9,
                backgroundColor: mainColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
