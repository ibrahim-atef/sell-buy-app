class Category {
  final String id;
  final String name;
  final String? imagePath; // Optional image path
  final List<Subcategory> subcategories;

  Category({required this.id, required this.name, this.imagePath, this.subcategories = const []});

  // Method to return the image path or a default image
  String get image {
    return imagePath ?? 'path/to/default/image.png'; // Replace with your default image path
  }
}

class Subcategory {
  final String id;
  final String name;
  final String? imagePath; // Optional image path

  Subcategory({required this.id, required this.name, this.imagePath});
}
