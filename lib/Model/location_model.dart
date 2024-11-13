class Governorate {
  final String enName;
  final String arName;
  final List<Region> regions;

  Governorate({required this.enName, required this.arName, required this.regions});

  // Factory constructor to create Governorate from map
  factory Governorate.fromMap( map) {
    var regionsList = <Region>[];
    if (map['regions'] != null) {
      map['regions'].forEach((v) {
        regionsList.add(Region.fromMap(v));
      });
    }
    return Governorate(
      enName: map['enName'] ?? '',
      arName: map['arName'] ?? '',
      regions: regionsList,
    );
  }

  // Convert Governorate to Map (if needed for other purposes like API calls)
  Map<String, dynamic> toMap() {
    return {
      'enName': enName,
      'arName': arName,
      'regions': regions.map((region) => region.toMap()).toList(),
    };
  }
}

class Region {
  final String nameEn;
  final String nameAr;
  final List<District> districts;

  Region({required this.nameEn, required this.nameAr, required this.districts});

  // Factory constructor to create Region from map
  factory Region.fromMap( map) {
    var districtsList = <District>[];
    if (map['districts'] != null) {
      map['districts'].forEach((v) {
        districtsList.add(District.fromMap(v));
      });
    }
    return Region(
      nameEn: map['nameEn'] ?? '',
      nameAr: map['nameAr'] ?? '',
      districts: districtsList,
    );
  }

  // Convert Region to Map
  Map<String, dynamic> toMap() {
    return {
      'nameEn': nameEn,
      'nameAr': nameAr,
      'districts': districts.map((district) => district.toMap()).toList(),
    };
  }
}

class District {
  final String nameEn;
  final String nameAr;

  District({required this.nameEn, required this.nameAr});

  // Factory constructor to create District from map
  factory District.fromMap( map) {
    return District(
      nameEn: map['nameEn'] ?? '',
      nameAr: map['nameAr'] ?? '',
    );
  }

  // Convert District to Map
  Map<String, dynamic> toMap() {
    return {
      'nameEn': nameEn,
      'nameAr': nameAr,
    };
  }
}
