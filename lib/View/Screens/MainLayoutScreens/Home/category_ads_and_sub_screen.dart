import 'package:flutter/material.dart';

class CategoryAdsAndSubsScreen extends StatelessWidget {
  final String categoryId;

  CategoryAdsAndSubsScreen({required this.categoryId});

  @override
  Widget build(BuildContext context) {
    debugPrint('Category ID: $categoryId');
    return Scaffold();
  }
}
