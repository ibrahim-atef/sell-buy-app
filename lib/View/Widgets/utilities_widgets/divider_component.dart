import 'package:flutter/material.dart';

 import '../../../Utilities/themes.dart';

class DividerComponent extends StatelessWidget {
  const DividerComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: black,
      indent: 40,
      endIndent: 40,
      thickness: 0.4,
    );
  }
}
