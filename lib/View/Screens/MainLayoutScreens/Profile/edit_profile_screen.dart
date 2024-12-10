import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Controllers/app_setting_controller.dart';
import 'package:sell_buy/Utilities/icons.dart';
import 'package:sell_buy/Utilities/themes.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/text_Component.dart';

import '../../../../Controllers/auth_controller.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final settingController = Get.put(AppSettingController());
  final authController = Get.put(AuthController());

  bool isEditingPhone = false; // Track if the phone number is in edit mode
  final phoneNumberController = TextEditingController(); // Controller for input field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile".tr),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(IconBroken.Arrow___Right_2),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            _buildSectionTitle('personal information'.tr, () {}, icon: null),
            _buildInfoRow(
              IconBroken.User,
              'user name'.tr,
              '${settingController.myData.value?.userName}',
              trailingIcon: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextComponent(
                  text: 'cant be changed'.tr,
                  size: 12,
                  color: white,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            _buildInfoRow(
              IconBroken.Message,
              'E-mail'.tr,
              '${settingController.myData.value?.email}',
              trailingIcon: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextComponent(
                  text: 'cant be changed'.tr,
                  size: 12,
                  color: white,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            _buildPhoneNumberField(), // Updated row for phone number
            SizedBox(height: 20),
            _buildSectionTitle('account settings'.tr, () {}),
            ListTile(
              leading: Icon(IconBroken.Logout),
              title: Text('Logout'.tr),
              trailing: Icon(IconBroken.Arrow___Left_2),
              onTap: () {
                authController.logout();
              },
            ),
            Spacer(),
            Center(
              child: Text(
                'Membersince:'.tr +
                    " " +
                    _formatDate(
                        settingController.myData.value?.registerDate!.millisecondsSinceEpoch ??
                            0),
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, final Function() onPressed, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          if (icon != null) Spacer(),
          if (icon != null)
            GestureDetector(
              onTap: onPressed,
              child: Icon(
                icon,
                color: Colors.blue,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String info, String label, {Widget? trailingIcon}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(info),
      subtitle: Text(label),
      trailing: trailingIcon == null ? SizedBox.shrink() : trailingIcon,
    );
  }

  Widget _buildPhoneNumberField() {
    return ListTile(
      leading: Icon(IconBroken.Call),
      title: isEditingPhone
          ? _buildEditablePhoneField() // Show TextFormField when editing
          : Text('phone number'.tr),
      subtitle: isEditingPhone
          ? null
          : Text('${settingController.myData.value?.phoneNumber ?? "No Phone Number"}'),
      trailing: IconButton(
        icon: Icon(isEditingPhone ? Icons.done : IconBroken.Edit_Square),
        onPressed: () async {
          if (isEditingPhone) {
            // Save phone number to Firestore
            await _savePhoneNumber();
          } else {
            // Enable edit mode
            setState(() {
              isEditingPhone = true;
              phoneNumberController.text = settingController.myData.value?.phoneNumber ?? '';
            });
          }
        },
      ),
    );
  }

  Widget _buildEditablePhoneField() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: TextFormField(
        controller: phoneNumberController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintText: 'Enter your phone number'.tr,
          border: OutlineInputBorder(),
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
        ),
      ),
    );
  }

  Future<void> _savePhoneNumber() async {
    final phoneNumber = phoneNumberController.text.trim();

    if (phoneNumber.isEmpty) {
      Get.snackbar('Error', 'Phone number cannot be empty'.tr);
      return;
    }

    try {
      await settingController.updatePhoneNumber(phoneNumber); // Update in Firestore
      Get.snackbar('Success', 'Phone number updated successfully'.tr);
      setState(() {
        isEditingPhone = false; // Exit edit mode
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to update phone number'.tr);
    }
  }

  String _formatDate(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return '${date.day}/${date.month}/${date.year}';
  }
}
