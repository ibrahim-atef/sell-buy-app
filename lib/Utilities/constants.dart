const saudiLocations = {
  // Riyadh Region (الرياض)
  "Al Riyadh": {
    "Al Malaz": ["District 1", "District 2", "District 3"],
    "Al Nasim": ["District 1", "District 2", "District 3"],
    "Al Olaya": ["District 1", "District 2", "District 3"],
    "Al Khaleej": ["District 1", "District 2"],
    "Al Sulay": ["District 1", "District 2"],
  },
  "الرياض": {
    "الملز": ["الحي الأول", "الحي الثاني", "الحي الثالث"],
    "النظيم": ["الحي الأول", "الحي الثاني", "الحي الثالث"],
    "العليا": ["الحي الأول", "الحي الثاني", "الحي الثالث"],
    "الخليج": ["الحي الأول", "الحي الثاني"],
    "السلي": ["الحي الأول", "الحي الثاني"],
  },

  // Makkah Region (مكة)
  "Makkah": {
    "Jeddah": ["Al Balad", "Al Khalidiya", "Al Safa", "Al Hamra"],
    "Makkah City": ["Azizia", "Shara'i", "Al Awali", "Al Nassim"],
    "Taif": ["Al Shifa", "Al Hada", "Al Salamah"],
    "Rabigh": ["Central District", "Al Khumrah", "Al Shuaib"],
  },
  "مكة": {
    "جدة": ["البلد", "الخالدية", "الصفا", "الحمرا"],
    "مكة المكرمة": ["العزيزية", "الشرائع", "العوالي", "النظيم"],
    "الطائف": ["الشفا", "الهدا", "السلامة"],
    "رابغ": ["المنطقة المركزية", "الخمرة", "الشعيب"],
  },

  // Eastern Province (المنطقة الشرقية)
  "Eastern Province": {
    "Dammam": ["Al Faisaliyah", "Al Shati", "Al Rakah"],
    "Khobar": ["Al Khobar North", "Al Khobar South", "Al Aqrabiyah"],
    "Dhahran": ["Dhahran Hills", "Saudi Aramco Compound"],
    "Jubail": ["Al Fanateer", "Jubail Industrial City", "Al Nakheel"],
  },
  "المنطقة الشرقية": {
    "الدمام": ["الفيصلية", "الشاطئ", "الراكه"],
    "الخبر": ["الخبر الشمالية", "الخبر الجنوبية", "العقربية"],
    "الظهران": ["تلال الظهران", "مجمع أرامكو السعودية"],
    "الجبيل": ["الفناتير", "مدينة الجبيل الصناعية", "النخيل"],
  },

  // Asir Region (عسير)
  "Asir": {
    "Abha": ["Al Mansak", "Al Khaldiyah", "Al Namas"],
    "Khamis Mushait": ["Al Qadisiyah", "Al Rawdah", "Al Matar"],
    "Al Namas": ["Al Saddah", "Al Qura"],
  },
  "عسير": {
    "أبها": ["المنسك", "الخالدية", "النماص"],
    "خميس مشيط": ["القادسية", "الروضة", "المطار"],
    "النماص": ["السدّة", "القرة"],
  },

  // Madinah Region (المدينة المنورة)
  "Madinah": {
    "Madinah City": ["Al Haram", "Al Aqiq", "Al Khalidiyah"],
    "Yanbu": ["Yanbu Industrial", "Yanbu Al Bahr", "Al Sharm"],
    "Badr": ["Central Badr", "Al Qadimah"],
  },
  "المدينة المنورة": {
    "المدينة المنورة": ["الحرم", "العقيق", "الخالدية"],
    "ينبع": ["ينبع الصناعية", "ينبع البحر", "الشرم"],
    "بدر": ["بدر المركزية", "القديمة"],
  },

  // Northern Borders Region (الحدود الشمالية)
  "Northern Borders": {
    "Arar": ["Al Muhammadiyah", "Al Faisaliyah", "Al Rawdah"],
    "Rafha": ["Central Rafha", "Al Mansourah"],
    "Turaif": ["Al Qadesiyah", "Al Wurud"],
  },
  "الحدود الشمالية": {
    "عرعر": ["المحمدية", "الفيصلية", "الروضة"],
    "رفحاء": ["رفحاء المركزية", "المنصورة"],
    "طريف": ["القادسية", "الورود"],
  },

  // Tabuk Region (تبوك)
  "Tabuk": {
    "Tabuk City": ["Al Ammariya", "Al Rabwah", "Al Hamra"],
    "Al Wajh": ["Central Al Wajh", "Al Khadra"],
    "Duba": ["Duba Port", "Al Murjan"],
  },
  "تبوك": {
    "تبوك": ["العمارية", "الربوة", "الحمرا"],
    "الوجه": ["الوجه المركزية", "الخضراء"],
    "ضباء": ["ميناء ضباء", "المرجان"],
  },

  // Jizan Region (جازان)
  "Jizan": {
    "Jizan City": ["Al Rawdah", "Al Safa", "Al Shati"],
    "Sabya": ["Central Sabya", "Al Qunfudah"],
    "Abu Arish": ["Al Badiyah", "Al Misfirah"],
  },
  "جازان": {
    "مدينة جازان": ["الروضة", "الصفا", "الشاطئ"],
    "صبيا": ["صبيا المركزية", "القنفذة"],
    "أبو عريش": ["البادية", "المسفرة"],
  },

  // Al Baha Region (الباحة)
  "Al Baha": {
    "Al Baha City": ["Al Shariah", "Al Mansak"],
    "Baljurashi": ["Central Baljurashi", "Al Hada"],
  },
  "الباحة": {
    "مدينة الباحة": ["الشرائع", "المنسك"],
    "بلجرشي": ["بلجرشي المركزية", "الهدا"],
  },

  // Najran Region (نجران)
  "Najran": {
    "Najran City": ["Al Faisaliyah", "Al Okhdood"],
    "Sharurah": ["Sharurah Center", "Al Yasmin"],
  },
  "نجران": {
    "مدينة نجران": ["الفيصلية", "الأخدود"],
    "شرورة": ["مركز شرورة", "الياسمين"],
  },

  // Hail Region (حائل)
  "Hail": {
    "Hail City": ["Al Barzan", "Al Khuzamah", "Al Muntazah"],
    "Baqaa": ["Central Baqaa", "Al Maghwat"],
  },
  "حائل": {
    "مدينة حائل": ["البرزان", "الخزامى", "المنتزه"],
    "بقعاء": ["بقعاء المركزية", "المغواة"],
  },

  // Al Jouf Region (الجوف)
  "Al Jouf": {
    "Sakaka": ["Al Rawdah", "Al Faisaliyah", "Al Salam"],
    "Dumat Al Jandal": ["Central Dumat Al Jandal", "Al Muntazah"],
  },
  "الجوف": {
    "سكاكا": ["الروضة", "الفيصلية", "السلام"],
    "دومة الجندل": ["دومة الجندل المركزية", "المنتزه"],
  }
};
