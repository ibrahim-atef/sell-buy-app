import '../Model/categories_model.dart';

List<Category> categories = [
  // Electronics Category
  Category(
    id: 'electronics',
    name: 'Electronics',
    imagePath: 'assets/images/electronics.png',
    subcategories: [
      Subcategory(id: 'electronics-phones', name: 'Phones', imagePath: 'assets/images/phones.png'),
      Subcategory(id: 'electronics-computers', name: 'Computers', imagePath: 'assets/images/computers.png'),
      Subcategory(id: 'electronics-tablets', name: 'Tablets', imagePath: 'assets/images/tablets.png'),
      Subcategory(id: 'electronics-smartwatches', name: 'Smart Watches', imagePath: 'assets/images/smartwatches.png'),
      Subcategory(id: 'electronics-cameras', name: 'Cameras', imagePath: 'assets/images/cameras.png'),
      Subcategory(id: 'electronics-accessories', name: 'Accessories', imagePath: 'assets/images/accessories.png'),
    ],
  ),

  // Real Estate Category
  Category(
    id: 'real-estate',
    name: 'Real Estate',
    imagePath: 'assets/images/real-estate.png',
    subcategories: [
      Subcategory(id: 'real-estate-apartments', name: 'Apartments', imagePath: 'assets/images/apartments.png'),
      Subcategory(id: 'real-estate-houses', name: 'Houses', imagePath: 'assets/images/houses.png'),
      Subcategory(id: 'real-estate-land', name: 'Land', imagePath: 'assets/images/land.png'),
      Subcategory(id: 'real-estate-offices', name: 'Offices', imagePath: 'assets/images/offices.png'),
      Subcategory(id: 'real-estate-commercial-shops', name: 'Commercial Shops', imagePath: 'assets/images/commercial-shops.png'),
    ],
  ),

  // Cars Category
  Category(
    id: 'cars',
    name: 'Cars',
    imagePath: 'assets/images/cars.png',
    subcategories: [
      Subcategory(id: 'cars-sedans', name: 'Sedans', imagePath: 'assets/images/sedans.png'),
      Subcategory(id: 'cars-suvs', name: 'SUVs', imagePath: 'assets/images/suvs.png'),
      Subcategory(id: 'cars-motorbikes', name: 'Motorbikes', imagePath: 'assets/images/motorbikes.png'),
      Subcategory(id: 'cars-classic', name: 'Classic Cars', imagePath: 'assets/images/classic-cars.png'),
      Subcategory(id: 'cars-scrap', name: 'Scrap Cars', imagePath: 'assets/images/scrap-cars.png'),
      Subcategory(id: 'cars-spare-parts', name: 'Spare Parts', imagePath: 'assets/images/spare-parts.png'),
    ],
  ),

  // Camping Category
  Category(
    id: 'camping',
    name: 'Camping',
    imagePath: 'assets/images/camping.png',
    subcategories: [
      Subcategory(id: 'camping-tents', name: 'Tents', imagePath: 'assets/images/tents.png'),
      Subcategory(id: 'camping-sleeping-bags', name: 'Sleeping Bags', imagePath: 'assets/images/sleeping-bags.png'),
      Subcategory(id: 'camping-gear', name: 'Camping Gear', imagePath: 'assets/images/camping-gear.png'),
      Subcategory(id: 'camping-backpacks', name: 'Backpacks', imagePath: 'assets/images/backpacks.png'),
    ],
  ),

  // Services Category
  Category(
    id: 'services',
    name: 'Services',
    imagePath: 'assets/images/services.png',
    subcategories: [
      Subcategory(id: 'services-cleaning', name: 'Cleaning', imagePath: 'assets/images/cleaning.png'),
      Subcategory(id: 'services-moving', name: 'Moving', imagePath: 'assets/images/moving.png'),
      Subcategory(id: 'services-home-repair', name: 'Home Repair', imagePath: 'assets/images/home-repair.png'),
      Subcategory(id: 'services-tech', name: 'Tech Services', imagePath: 'assets/images/tech-services.png'),
      Subcategory(id: 'services-medical', name: 'Medical Services', imagePath: 'assets/images/medical-services.png'),
    ],
  ),

  // Contracting Category
  Category(
    id: 'contracting',
    name: 'Contracting',
    imagePath: 'assets/images/contracting.png',
    subcategories: [
      Subcategory(id: 'contracting-plumbing', name: 'Plumbing', imagePath: 'assets/images/plumbing.png'),
      Subcategory(id: 'contracting-electrical', name: 'Electrical Work', imagePath: 'assets/images/electrical.png'),
      Subcategory(id: 'contracting-carpentry', name: 'Carpentry', imagePath: 'assets/images/carpentry.png'),
      Subcategory(id: 'contracting-roofing', name: 'Roofing', imagePath: 'assets/images/roofing.png'),
    ],
  ),

  // Gifts Category
  Category(
    id: 'gifts',
    name: 'Gifts',
    imagePath: 'assets/images/gifts.png',
    subcategories: [
      Subcategory(id: 'gifts-flowers', name: 'Flowers', imagePath: 'assets/images/flowers.png'),
      Subcategory(id: 'gifts-baskets', name: 'Gift Baskets', imagePath: 'assets/images/gift-baskets.png'),
      Subcategory(id: 'gifts-custom', name: 'Custom Gifts', imagePath: 'assets/images/custom-gifts.png'),
      Subcategory(id: 'gifts-jewelry', name: 'Jewelry', imagePath: 'assets/images/jewelry.png'),
    ],
  ),

  // Fashion & Home Category
  Category(
    id: 'fashion-home',
    name: 'Fashion & Home',
    imagePath: 'assets/images/fashion-home.png',
    subcategories: [
      Subcategory(id: 'fashion-home-mens', name: 'Men\'s Clothing', imagePath: 'assets/images/men-clothes.png'),
      Subcategory(id: 'fashion-home-womens', name: 'Women\'s Clothing', imagePath: 'assets/images/women-clothes.png'),
      Subcategory(id: 'fashion-home-accessories', name: 'Accessories', imagePath: 'assets/images/accessories-fashion.png'),
      Subcategory(id: 'fashion-home-decor', name: 'Home Decor', imagePath: 'assets/images/home-decor.png'),
    ],
  ),

  // Animals Category
  Category(
    id: 'animals',
    name: 'Animals',
    imagePath: 'assets/images/animals.png',
    subcategories: [
      Subcategory(id: 'animals-dogs', name: 'Dogs', imagePath: 'assets/images/dogs.png'),
      Subcategory(id: 'animals-cats', name: 'Cats', imagePath: 'assets/images/cats.png'),
      Subcategory(id: 'animals-birds', name: 'Birds', imagePath: 'assets/images/birds.png'),
      Subcategory(id: 'animals-fish', name: 'Fish', imagePath: 'assets/images/fish.png'),
      Subcategory(id: 'animals-reptiles', name: 'Reptiles', imagePath: 'assets/images/reptiles.png'),
    ],
  ),

  // Miscellaneous Category
  Category(
    id: 'miscellaneous',
    name: 'Miscellaneous',
    imagePath: 'assets/images/miscellaneous.png',
    subcategories: [
      Subcategory(id: 'miscellaneous-art', name: 'Art', imagePath: 'assets/images/art.png'),
      Subcategory(id: 'miscellaneous-antiques', name: 'Antiques', imagePath: 'assets/images/antiques.png'),
      Subcategory(id: 'miscellaneous-books', name: 'Books', imagePath: 'assets/images/books.png'),
      Subcategory(id: 'miscellaneous-music-instruments', name: 'Music Instruments', imagePath: 'assets/images/music-instruments.png'),
    ],
  ),

  // Jobs Category
  Category(
    id: 'jobs',
    name: 'Jobs',
    imagePath: 'assets/images/jobs.png',
    subcategories: [
      Subcategory(id: 'jobs-admin', name: 'Administrative', imagePath: 'assets/images/admin-jobs.png'),
      Subcategory(id: 'jobs-technical', name: 'Technical', imagePath: 'assets/images/tech-jobs.png'),
      Subcategory(id: 'jobs-engineering', name: 'Engineering', imagePath: 'assets/images/engineering-jobs.png'),
      Subcategory(id: 'jobs-medical', name: 'Medical', imagePath: 'assets/images/medical-jobs.png'),
      Subcategory(id: 'jobs-education', name: 'Education', imagePath: 'assets/images/teaching-jobs.png'),
    ],
  ),

  // Furniture Category
  Category(
    id: 'furniture',
    name: 'Furniture',
    imagePath: 'assets/images/furniture.png',
    subcategories: [
      Subcategory(id: 'furniture-bedroom', name: 'Bedroom', imagePath: 'assets/images/bedroom.png'),
      Subcategory(id: 'furniture-living-room', name: 'Living Room', imagePath: 'assets/images/living-room.png'),
      Subcategory(id: 'furniture-office', name: 'Office Furniture', imagePath: 'assets/images/office-furniture.png'),
      Subcategory(id: 'furniture-outdoor', name: 'Outdoor Furniture', imagePath: 'assets/images/outdoor-furniture.png'),
    ],
  ),
];
