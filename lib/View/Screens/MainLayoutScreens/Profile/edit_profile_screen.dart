import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sell_buy/Controllers/app_setting_controller.dart';
import 'package:sell_buy/Utilities/icons.dart';
import 'package:sell_buy/Utilities/themes.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/text_Component.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final settingController = Get.put(AppSettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile ".tr),
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
            _buildSectionTitle('personal information'.tr, () {
              null;
            }, icon: IconBroken.Edit),
            _buildInfoRow(IconBroken.User, 'user name'.tr,
                '${settingController.myData.value?.userName}'),
            _buildInfoRow(IconBroken.Message, 'E-mail'.tr,
                '${settingController.myData.value?.email}'),
            _buildInfoRow(IconBroken.Call, 'phone number'.tr,
                '${settingController.myData.value?.phoneNumber}',
                trailingIcon: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.deepOrange.shade200,
                        borderRadius: BorderRadius.circular(4)),
                    child: TextComponent(
                        text: 'cant be changed'.tr,
                        size: 12,
                        color: white,
                        fontWeight: FontWeight.normal))),
            SizedBox(height: 20),
            _buildSectionTitle('account settings'.tr, () {}),
            ListTile(
              leading: Icon(IconBroken.Lock),
              title: Text('change password'.tr),
              trailing: Icon(IconBroken.Arrow___Left_2),
              onTap: () {
                // Navigate to change password screen
              },
            ),
            ListTile(
              leading: Icon(IconBroken.Logout),
              title: Text('Logout'.tr),
              trailing: Icon(IconBroken.Arrow___Left_2),
              onTap: () {
                // Handle logout logic
              },
            ),
            ListTile(
              leading: Icon(Icons.delete_forever, color: Colors.red),
              title: Text(
                'Delete my information and account'.tr,
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                // Handle account deletion
              },
            ),
            Spacer(),
            Center(
              child: Text(
                  'Member since:'.tr +" "+
                      _formatDate(settingController.myData
                              .value?.registerDate!.millisecondsSinceEpoch ??
                          0),
                  style: TextStyle(color: Colors.grey.shade600)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(
    String title,
    final Function() onPressed, {
    IconData? icon,
  }) {
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

  Widget _buildInfoRow(IconData icon, String info, String label,
      {Widget? trailingIcon}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(info),
      subtitle: Text(label),
      trailing: trailingIcon == null ? SizedBox.shrink() : trailingIcon,
    );
  }
}
 _formatDate(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    String formattedDate = '${date.day}/${date.month}/${date.year}';
    return formattedDate;
  }