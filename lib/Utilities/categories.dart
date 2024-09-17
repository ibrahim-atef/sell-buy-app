import '../Model/categories_model.dart';

List<Category> categories = [
  // Electronics Category
  Category(
    id: 'electronics',
    name: 'Electronics',
    imagePath: 'assets/CategoriesImgs/electronics.jpg',
    subcategories: [
      Subcategory(id: 'electronics-phones', name: 'Phones', imagePath: 'assets/CategoriesImgs/phones.png'),
      Subcategory(id: 'electronics-computers', name: 'Computers', imagePath: 'assets/CategoriesImgs/computers.png'),
      Subcategory(id: 'electronics-tablets', name: 'Tablets', imagePath: 'assets/CategoriesImgs/tablets.png'),
      Subcategory(id: 'electronics-smartwatches', name: 'Smart Watches', imagePath: 'assets/CategoriesImgs/smartwatches.png'),
      Subcategory(id: 'electronics-cameras', name: 'Cameras', imagePath: 'assets/CategoriesImgs/cameras.png'),
      Subcategory(id: 'electronics-accessories', name: 'Accessories', imagePath: 'assets/CategoriesImgs/accessories.png'),
    ],
  ),

  // Real Estate Category
  Category(
    id: 'real-estate',
    name: 'REAL_ESTATE',
    imagePath: 'assets/CategoriesImgs/real-estate.png',
    subcategories: [
      Subcategory(id: 'real-estate-apartments', name: 'Apartments', imagePath: 'assets/CategoriesImgs/apartments.png'),
      Subcategory(id: 'real-estate-houses', name: 'Houses', imagePath: 'assets/CategoriesImgs/houses.png'),
      Subcategory(id: 'real-estate-land', name: 'Land', imagePath: 'assets/CategoriesImgs/land.png'),
      Subcategory(id: 'real-estate-offices', name: 'Offices', imagePath: 'assets/CategoriesImgs/offices.png'),
      Subcategory(id: 'real-estate-commercial-shops', name: 'Commercial Shops', imagePath: 'assets/CategoriesImgs/commercial-shops.png'),
    ],
  ),

  // Cars Category
  Category(
    id: 'cars',
    name: 'Cars',
    imagePath: 'assets/CategoriesImgs/cars.png',
    subcategories: [
      Subcategory(id: 'cars-sedans', name: 'Sedans', imagePath: 'assets/CategoriesImgs/sedans.png'),
      Subcategory(id: 'cars-suvs', name: 'SUVs', imagePath: 'assets/CategoriesImgs/suvs.png'),
      Subcategory(id: 'cars-motorbikes', name: 'Motorbikes', imagePath: 'assets/CategoriesImgs/motorbikes.png'),
      Subcategory(id: 'cars-classic', name: 'Classic Cars', imagePath: 'assets/CategoriesImgs/classic-cars.png'),
      Subcategory(id: 'cars-scrap', name: 'Scrap Cars', imagePath: 'assets/CategoriesImgs/scrap-cars.png'),
      Subcategory(id: 'cars-spare-parts', name: 'Spare Parts', imagePath: 'assets/CategoriesImgs/spare-parts.png'),
    ],
  ),

  // Camping Category
  Category(
    id: 'camping',
    name: 'Camping',
    imagePath: 'assets/CategoriesImgs/camping.png',
    subcategories: [
      Subcategory(id: 'camping-tents', name: 'Tents', imagePath: 'assets/CategoriesImgs/tents.png'),
      Subcategory(id: 'camping-sleeping-bags', name: 'Sleeping Bags', imagePath: 'assets/CategoriesImgs/sleeping-bags.png'),
      Subcategory(id: 'camping-gear', name: 'Camping Gear', imagePath: 'assets/CategoriesImgs/camping-gear.png'),
      Subcategory(id: 'camping-backpacks', name: 'Backpacks', imagePath: 'assets/CategoriesImgs/backpacks.png'),
    ],
  ),

  // Services Category
  Category(
    id: 'services',
    name: 'Services',
    imagePath: 'assets/CategoriesImgs/services.png',
    subcategories: [
      Subcategory(id: 'services-cleaning', name: 'Cleaning', imagePath: 'assets/CategoriesImgs/cleaning.png'),
      Subcategory(id: 'services-moving', name: 'Moving', imagePath: 'assets/CategoriesImgs/moving.png'),
      Subcategory(id: 'services-home-repair', name: 'Home Repair', imagePath: 'assets/CategoriesImgs/home-repair.png'),
      Subcategory(id: 'services-tech', name: 'Tech Services', imagePath: 'assets/CategoriesImgs/tech-services.png'),
      Subcategory(id: 'services-medical', name: 'Medical Services', imagePath: 'assets/CategoriesImgs/medical-services.png'),
    ],
  ),

  // Contracting Category
  Category(
    id: 'contracting',
    name: 'Contracting',
    imagePath: 'assets/CategoriesImgs/contracting.png',
    subcategories: [
      Subcategory(id: 'contracting-plumbing', name: 'Plumbing', imagePath: 'assets/CategoriesImgs/plumbing.png'),
      Subcategory(id: 'contracting-electrical', name: 'Electrical Work', imagePath: 'assets/CategoriesImgs/electrical.png'),
      Subcategory(id: 'contracting-carpentry', name: 'Carpentry', imagePath: 'assets/CategoriesImgs/carpentry.png'),
      Subcategory(id: 'contracting-roofing', name: 'Roofing', imagePath: 'assets/CategoriesImgs/roofing.png'),
    ],
  ),

  // Gifts Category
  Category(
    id: 'gifts',
    name: 'Gifts',
    imagePath: 'assets/CategoriesImgs/gifts.png',
    subcategories: [
      Subcategory(id: 'gifts-flowers', name: 'Flowers', imagePath: 'assets/CategoriesImgs/flowers.png'),
      Subcategory(id: 'gifts-baskets', name: 'Gift Baskets', imagePath: 'assets/CategoriesImgs/gift-baskets.png'),
      Subcategory(id: 'gifts-custom', name: 'Custom Gifts', imagePath: 'assets/CategoriesImgs/custom-gifts.png'),
      Subcategory(id: 'gifts-jewelry', name: 'Jewelry', imagePath: 'assets/CategoriesImgs/jewelry.png'),
    ],
  ),

  // Fashion & Home Category
  Category(
    id: 'fashion-home',
    name: 'FASHION_HOME',
    imagePath: 'assets/CategoriesImgs/fashion-home.png',
    subcategories: [
      Subcategory(id: 'fashion-home-mens', name: 'Men\'s Clothing', imagePath: 'assets/CategoriesImgs/men-clothes.png'),
      Subcategory(id: 'fashion-home-womens', name: 'Women\'s Clothing', imagePath: 'assets/CategoriesImgs/women-clothes.png'),
      Subcategory(id: 'fashion-home-accessories', name: 'Accessories', imagePath: 'assets/CategoriesImgs/accessories-fashion.png'),
      Subcategory(id: 'fashion-home-decor', name: 'Home Decor', imagePath: 'assets/CategoriesImgs/home-decor.png'),
    ],
  ),

  // Animals Category
  Category(
    id: 'animals',
    name: 'Animals',
    imagePath: 'assets/CategoriesImgs/animals.png',
    subcategories: [
      Subcategory(id: 'animals-dogs', name: 'Dogs', imagePath: 'assets/CategoriesImgs/dogs.png'),
      Subcategory(id: 'animals-cats', name: 'Cats', imagePath: 'assets/CategoriesImgs/cats.png'),
      Subcategory(id: 'animals-birds', name: 'Birds', imagePath: 'assets/CategoriesImgs/birds.png'),
      Subcategory(id: 'animals-fish', name: 'Fish', imagePath: 'assets/CategoriesImgs/fish.png'),
      Subcategory(id: 'animals-reptiles', name: 'Reptiles', imagePath: 'assets/CategoriesImgs/reptiles.png'),
    ],
  ),

  // Miscellaneous Category
  Category(
    id: 'miscellaneous',
    name: 'Miscellaneous',
    imagePath: 'assets/CategoriesImgs/miscellaneous.png',
    subcategories: [
      Subcategory(id: 'miscellaneous-art', name: 'Art', imagePath: 'assets/CategoriesImgs/art.png'),
      Subcategory(id: 'miscellaneous-antiques', name: 'Antiques', imagePath: 'assets/CategoriesImgs/antiques.png'),
      Subcategory(id: 'miscellaneous-books', name: 'Books', imagePath: 'assets/CategoriesImgs/books.png'),
      Subcategory(id: 'miscellaneous-music-instruments', name: 'Music Instruments', imagePath: 'assets/CategoriesImgs/music-instruments.png'),
    ],
  ),

  // Jobs Category
  Category(
    id: 'jobs',
    name: 'Jobs',
    imagePath: 'assets/CategoriesImgs/jobs.png',
    subcategories: [
      Subcategory(id: 'jobs-admin', name: 'Administrative', imagePath: 'assets/CategoriesImgs/admin-jobs.png'),
      Subcategory(id: 'jobs-technical', name: 'Technical', imagePath: 'assets/CategoriesImgs/tech-jobs.png'),
      Subcategory(id: 'jobs-engineering', name: 'Engineering', imagePath: 'assets/CategoriesImgs/engineering-jobs.png'),
      Subcategory(id: 'jobs-medical', name: 'Medical', imagePath: 'assets/CategoriesImgs/medical-jobs.png'),
      Subcategory(id: 'jobs-education', name: 'Education', imagePath: 'assets/CategoriesImgs/teaching-jobs.png'),
    ],
  ),

  // Furniture Category
  Category(
    id: 'furniture',
    name: 'Furniture',
    imagePath: 'assets/CategoriesImgs/furniture.png',
    subcategories: [
      Subcategory(id: 'furniture-bedroom', name: 'Bedroom', imagePath: 'assets/CategoriesImgs/bedroom.png'),
      Subcategory(id: 'furniture-living-room', name: 'Living Room', imagePath: 'assets/CategoriesImgs/living-room.png'),
      Subcategory(id: 'furniture-office', name: 'Office Furniture', imagePath: 'assets/CategoriesImgs/office-furniture.png'),
      Subcategory(id: 'furniture-outdoor', name: 'Outdoor Furniture', imagePath: 'assets/CategoriesImgs/outdoor-furniture.png'),
    ],
  ),
];
