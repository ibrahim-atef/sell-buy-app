import '../Model/location_model.dart';

List<Governorate> saudiLocations = [
  Governorate(
    enName: 'Riyadh Region',
    arName: 'منطقة الرياض',
    regions: [
      Region(nameEn: 'Al Malaz', nameAr: 'الملز', districts: [
        District(nameEn: 'District 1', nameAr: 'الحي الاول'),
        District(nameEn: 'District 2', nameAr: 'الحي الثاني'),
        District(nameEn: 'District 3', nameAr: 'الحي الثالث'),
      ]),
      Region(nameEn: 'Al Nasim', nameAr: 'النظيم', districts: [
        District(nameEn: 'District 1', nameAr: 'الحي الاول'),
        District(nameEn: 'District 2', nameAr: 'الحي الثاني'),
        District(nameEn: 'District 3', nameAr: 'الحي الثالث'),
      ]),
      Region(nameEn: 'Al Olaya', nameAr: 'العليا', districts: [
        District(nameEn: 'District 1', nameAr: 'الحي الاول'),
        District(nameEn: 'District 2', nameAr: 'الحي الثاني'),
        District(nameEn: 'District 3', nameAr: 'الحي الثالث'),
      ]),
      Region(nameEn: 'Al Khaleej', nameAr: 'الخليج', districts: [
        District(nameEn: 'District 1', nameAr: 'الحي الاول'),
        District(nameEn: 'District 2', nameAr: 'الحي الثاني'),
      ]),
      Region(nameEn: 'Al Sulay', nameAr: 'السلي', districts: [
        District(nameEn: 'District 1', nameAr: 'الحي الاول'),
        District(nameEn: 'District 2', nameAr: 'الحي الثاني'),
      ]),
    ],
  ),
  Governorate(
    enName: 'Makkah Region',
    arName: 'منطقة مكة',
    regions: [
      Region(nameEn: 'Jeddah', nameAr: 'جدة', districts: [
        District(nameEn: 'Al Balad', nameAr: 'البلد'),
        District(nameEn: 'Al Khalidiya', nameAr: 'الخالدية'),
        District(nameEn: 'Al Safa', nameAr: 'الصفي'),
        District(nameEn: 'Al Hamra', nameAr: 'الحمراء'),
      ]),
      Region(nameEn: 'Makkah City', nameAr: 'مكة المكرمة', districts: [
        District(nameEn: 'Azizia', nameAr: 'العزيزية'),
        District(nameEn: 'Shara\'i', nameAr: 'الشرائع'),
        District(nameEn: 'Al Awali', nameAr: 'الأولى'),
        District(nameEn: 'Al Nassim', nameAr: 'النصيم'),
      ]),
      Region(nameEn: 'Taif', nameAr: 'الطائف', districts: [
        District(nameEn: 'Al Shifa', nameAr: 'الشفاء'),
        District(nameEn: 'Al Hada', nameAr: 'الحده'),
        District(nameEn: 'Al Salamah', nameAr: 'السلامة'),
      ]),
      Region(nameEn: 'Rabigh', nameAr: 'رابغ', districts: [
        District(nameEn: 'Central District', nameAr: 'المركز'),
        District(nameEn: 'Al Khumrah', nameAr: 'الخمرة'),
        District(nameEn: 'Al Shuaib', nameAr: 'الشعيب'),
      ]),
    ],
  ),
  Governorate(
    enName: 'Eastern Province',
    arName: 'المنطقة الشرقية',
    regions: [
      Region(nameEn: 'Dammam', nameAr: 'الدمام', districts: [
        District(nameEn: 'Al Faisaliyah', nameAr: 'الفيسالية'),
        District(nameEn: 'Al Shati', nameAr: 'الشاطئ'),
        District(nameEn: 'Al Rakah', nameAr: 'الرakah'),
      ]),
      Region(nameEn: 'Khobar', nameAr: 'الخبر', districts: [
        District(nameEn: 'Al Khobar North', nameAr: 'الخبر الشمالي'),
        District(nameEn: 'Al Khobar South', nameAr: 'الخبر الجنوبي'),
        District(nameEn: 'Al Aqrabiyah', nameAr: 'العقرابية'),
      ]),
      Region(nameEn: 'Dhahran', nameAr: 'الظهران', districts: [
        District(nameEn: 'Dhahran Hills', nameAr: 'تلال الظهران'),
        District(
            nameEn: 'Saudi Aramco Compound', nameAr: 'مجمع أرامكو السعودي'),
      ]),
      Region(nameEn: 'Jubail', nameAr: 'الجبيل', districts: [
        District(nameEn: 'Al Fanateer', nameAr: 'الفناتير'),
        District(
            nameEn: 'Jubail Industrial City', nameAr: 'مدينة الجبيل الصناعية'),
        District(nameEn: 'Al Nakheel', nameAr: 'النخيل'),
      ]),
    ],
  ),
  Governorate(
    enName: 'Asir Region',
    arName: 'منطقة عسير',
    regions: [
      Region(nameEn: 'Abha', nameAr: 'أبها', districts: [
        District(nameEn: 'Al Mansak', nameAr: 'المنسك'),
        District(nameEn: 'Al Khaldiyah', nameAr: 'الخالدية'),
        District(nameEn: 'Al Namas', nameAr: 'النماص'),
      ]),
      Region(nameEn: 'Khamis Mushait', nameAr: 'خميس مشيط', districts: [
        District(nameEn: 'Al Qadisiyah', nameAr: 'القادسية'),
        District(nameEn: 'Al Rawdah', nameAr: 'الروضة'),
        District(nameEn: 'Al Matar', nameAr: 'المطار'),
      ]),
      Region(nameEn: 'Al Namas', nameAr: 'النماص', districts: [
        District(nameEn: 'Al Saddah', nameAr: 'السدة'),
        District(nameEn: 'Al Qura', nameAr: 'القورة'),
      ]),
    ],
  ),
  Governorate(
    enName: 'Madinah Region',
    arName: 'منطقة المدينة المنورة',
    regions: [
      Region(nameEn: 'Madinah City', nameAr: 'المدينة المنورة', districts: [
        District(nameEn: 'Al Haram', nameAr: 'الحرم'),
        District(nameEn: 'Al Aqiq', nameAr: 'العقيق'),
        District(nameEn: 'Al Khalidiyah', nameAr: 'الخالدية'),
      ]),
      Region(nameEn: 'Yanbu', nameAr: 'ينبع', districts: [
        District(nameEn: 'Yanbu Industrial', nameAr: 'الصناعية ينبع'),
        District(nameEn: 'Yanbu Al Bahr', nameAr: 'ينبع البحر'),
        District(nameEn: 'Al Sharm', nameAr: 'الشرم'),
      ]),
      Region(nameEn: 'Badr', nameAr: 'بدر', districts: [
        District(nameEn: 'Central Badr', nameAr: 'مركز بدر'),
        District(nameEn: 'Al Qadimah', nameAr: 'القديمة'),
      ]),
    ],
  ),
  Governorate(
    enName: 'Northern Borders Region',
    arName: 'منطقة الحدود الشمالية',
    regions: [
      Region(nameEn: 'Arar', nameAr: 'عرعر', districts: [
        District(nameEn: 'Al Muhammadiyah', nameAr: 'المحمدية'),
        District(nameEn: 'Al Faisaliyah', nameAr: 'الفيسالية'),
        District(nameEn: 'Al Rawdah', nameAr: 'الروضة'),
      ]),
      Region(nameEn: 'Rafha', nameAr: 'رفحاء', districts: [
        District(nameEn: 'Central Rafha', nameAr: 'مركز رفحاء'),
        District(nameEn: 'Al Mansourah', nameAr: 'المنصورة'),
      ]),
      Region(nameEn: 'Turaif', nameAr: 'طريف', districts: [
        District(nameEn: 'Al Wurud', nameAr: 'الورود'),
        District(nameEn: 'Al Qadesiyah', nameAr: 'القديسية'),
      ]),
    ],
  ),
  Governorate(
    enName: 'Tabuk Region',
    arName: 'منطقة تبوك',
    regions: [
      Region(nameEn: 'Tabuk City', nameAr: 'تبوك', districts: [
        District(nameEn: 'Al Ammariya', nameAr: 'العمارية'),
        District(nameEn: 'Al Rabwah', nameAr: 'الربوة'),
        District(nameEn: 'Al Hamra', nameAr: 'الحمراء'),
      ]),
      Region(nameEn: 'Al Wajh', nameAr: 'الوجه', districts: [
        District(nameEn: 'Central Al Wajh', nameAr: 'المركز الوجه'),
        District(nameEn: 'Al Khadra', nameAr: 'الخضراء'),
      ]),
      Region(nameEn: 'Duba', nameAr: 'ضباء', districts: [
        District(nameEn: 'Duba Port', nameAr: 'ميناء ضباء'),
        District(nameEn: 'Al Murjan', nameAr: 'المرجان'),
      ]),
    ],
  ),
  Governorate(
    enName: 'Jizan Region',
    arName: 'منطقة جازان',
    regions: [
      Region(nameEn: 'Jizan City', nameAr: 'مدينة جازان', districts: [
        District(nameEn: 'Al Rawdah', nameAr: 'الروضة'),
        District(nameEn: 'Al Safa', nameAr: 'الصفا'),
        District(nameEn: 'Al Shati', nameAr: 'الشاطئ'),
      ]),
      Region(nameEn: 'Sabya', nameAr: 'صبيا', districts: [
        District(nameEn: 'Central Sabya', nameAr: 'مركز صبيا'),
        District(nameEn: 'Al Qunfudah', nameAr: 'القنفذة'),
      ]),
      Region(nameEn: 'Abu Arish', nameAr: 'أبو عريش', districts: [
        District(nameEn: 'Al Misfirah', nameAr: 'المسفيرة'),
        District(nameEn: "Al Badiyah", nameAr: 'البادية'),
      ]),
    ],
  ),
  Governorate(
    enName: 'Al Baha Region',
    arName: 'منطقة الباحة',
    regions: [
      Region(nameEn: 'Al Baha City', nameAr: 'مدينة الباحة', districts: [
        District(nameEn: 'Al Mansak', nameAr: 'المنسك'),
        District(nameEn: 'Al Shariah', nameAr: 'الشرائع'),
      ]),
      Region(nameEn: 'Baljurashi', nameAr: 'بلجرشي', districts: [
        District(nameEn: 'Central Baljurashi', nameAr: 'المركز بلجرشي'),
        District(nameEn: 'Al Hada', nameAr: 'الحده'),
      ]),
    ],
  ),
  Governorate(
    enName: 'Najran Region',
    arName: 'منطقة نجران',
    regions: [
      Region(nameEn: 'Najran City', nameAr: 'مدينة نجران', districts: [
        District(nameEn: 'Al Okhdood', nameAr: 'العقود'),
        District(nameEn: 'Al Faisaliyah', nameAr: 'الفيسالية'),
      ]),
      Region(nameEn: 'Sharurah', nameAr: 'شرورة', districts: [
        District(nameEn: 'Sharurah Center', nameAr: 'مركز شرورة'),
        District(nameEn: 'Al Yasmin', nameAr: 'اليسمن'),
      ]),
    ],
  ),
  Governorate(
    enName: 'Hail Region',
    arName: 'منطقة حائل',
    regions: [
      Region(nameEn: 'Hail City', nameAr: 'مدينة حائل', districts: [
        District(nameEn: 'Al Barzan', nameAr: 'البرزان'),
        District(nameEn: 'Al Khuzamah', nameAr: 'الخزامة'),
        District(nameEn: 'Al Muntazah', nameAr: 'المنطقة'),
      ]),
      Region(nameEn: 'Baqaa', nameAr: 'بقعاء', districts: [
        District(nameEn: 'Central Baqaa', nameAr: 'المركز بقعاء'),
        District(nameEn: 'Al Maghwat', nameAr: 'المغوات'),
      ]),
    ],
  ),
  Governorate(
    enName: 'Al Jouf Region',
    arName: 'منطقة الجوف',
    regions: [
      Region(nameEn: 'Sakaka', nameAr: 'سكاكا', districts: [
        District(nameEn: 'Al Rawdah', nameAr: 'الروضة'),
        District(nameEn: 'Al Faisaliyah', nameAr: 'الفيسالية'),
        District(nameEn: 'Al Salam', nameAr: 'السلام'),
      ]),
      Region(nameEn: 'Dumat Al Jandal', nameAr: 'دومة الجندل', districts: [
        District(
            nameEn: 'Central Dumat Al Jandal', nameAr: 'المركز دومة الجندل'),
        District(nameEn: 'Al Muntazah', nameAr: 'المنطقة'),
      ]),
    ],
  ),
];

// Assuming `saudiLocations` is a map with Governorate data.
