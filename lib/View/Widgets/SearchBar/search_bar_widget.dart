import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Utilities/icons.dart';

import '../utilities_widgets/custom_text_from_field.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextFromField(
      hintText: 'Search'.tr,
      prefixIcon: const Icon(
        IconBroken.Search,
        size: 20,
        color: Colors.grey,
      ),
      validator: (value) {},
      controller: TextEditingController(),
      textInputType: TextInputType.text,
      obscureText: false,
      maxLines: 1,
      enabled: true,
      inputColor: Colors.black54,
      suffixIcon: null,
    );
  }
}
