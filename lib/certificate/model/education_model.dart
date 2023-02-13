class EducationModel {
  String? educationId;
  String? educationImage;
  String? educationDate;
  String? educationLink;
  String? educationName;
  bool? educationDownloaded;

  EducationModel({
    this.educationImage,
    this.educationId,
    this.educationDate,
    this.educationLink,
    this.educationName,
    this.educationDownloaded,
  });

  Map<String, dynamic> todoMap() {
    var mapping = Map<String, dynamic>();
    mapping['education_id'] = educationId;
    mapping['education_image'] = educationImage;
    mapping['education_date'] = educationDate;
    mapping['education_link'] = educationLink;
    mapping['education_downloaded'] = educationName;
    mapping['education_name'] = educationDownloaded;

    return mapping;
  }

  factory EducationModel.fromJson(Map<String, dynamic> map) {
    return EducationModel(
      educationId:
          map['education_id'] ?? '',
      educationDate:
          map['education_date'] ?? '',
      educationLink:
          map['education_link'] ?? '',
      educationName:
          map['education_name'] ?? '',
      educationDownloaded:
      map['education_downloaded'] ?? false,
      educationImage:
          map['education_image'] ?? '',
    );
  }
}
