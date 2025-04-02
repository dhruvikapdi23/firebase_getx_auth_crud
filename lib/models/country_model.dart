class CountryModel {
  Name? name;
  List<String>? capital;
  String? region;
  Languages? languages;
  String? flag;
  int? population;
  Flags? flags;

  CountryModel(
      {this.name,
      this.capital,
      this.region,
      this.languages,
      this.flag,
      this.population,
      this.flags});

  CountryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    capital = json['capital']?.cast<String>();
    region = json['region'];
    languages = json['languages'] != null
        ? Languages.fromJson(json['languages'])
        : null;
    flag = json['flag'];
    population = json['population'];
    flags = json['flags'] != null ? Flags.fromJson(json['flags']) : null;
  }

  factory CountryModel.fromPlaceholderJson(dynamic json) {
    final name = json['name'] != null ? Name.fromJson(json['name']) : null;
    final capital = json['capital']?.cast<String>();
    final region = json['region'];
    final languages = json['languages'] != null
        ? Languages.fromJson(json['languages'])
        : null;
    final flag = json['flag'];
    final population = json['population'];
    final flags =
        json['flags'] != null ? Flags.fromJson(json['flags']) : null;
    return CountryModel(
      name: json["name"],
      capital: json["capital"],
      region: json["region"],
      languages: json["languages"],
      flag: flag,
      population: population,
      flags: flags,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['capital'] = capital;
    data['region'] = region;
    if (languages != null) {
      data['languages'] = languages!.toJson();
    }
    data['flag'] = flag;
    data['population'] = population;
    if (flags != null) {
      data['flags'] = flags!.toJson();
    }
    return data;
  }
}

class Name {
  String? common;
  String? official;
  NativeName? nativeName;

  Name({this.common, this.official, this.nativeName});

  Name.fromJson(Map<String, dynamic> json) {
    common = json['common'];
    official = json['official'];
    nativeName = json['nativeName'] != null
        ? NativeName.fromJson(json['nativeName'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['common'] = common;
    data['official'] = official;
    if (nativeName != null) {
      data['nativeName'] = nativeName!.toJson();
    }
    return data;
  }
}

class NativeName {
  Eng? eng;

  NativeName({this.eng});

  NativeName.fromJson(Map<String, dynamic> json) {
    eng = json['eng'] != null ? Eng.fromJson(json['eng']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (eng != null) {
      data['eng'] = eng!.toJson();
    }
    return data;
  }
}

class Eng {
  String? official;
  String? common;

  Eng({this.official, this.common});

  Eng.fromJson(Map<String, dynamic> json) {
    official = json['official'];
    common = json['common'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['official'] = official;
    data['common'] = common;
    return data;
  }
}

class Languages {
  String? eng;

  Languages({this.eng});

  Languages.fromJson(Map<String, dynamic> json) {
    eng = json['eng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eng'] = eng;
    return data;
  }
}

class Flags {
  String? png;
  String? svg;

  Flags({this.png, this.svg});

  Flags.fromJson(Map<String, dynamic> json) {
    png = json['png'];
    svg = json['svg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['png'] = png;
    data['svg'] = svg;
    return data;
  }
}
