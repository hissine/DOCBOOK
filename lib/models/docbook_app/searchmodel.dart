class searchModel {
  String? message;
  late List<Doctors> doctors;
  int? totalDoc;

  searchModel({this.message, required this.doctors, this.totalDoc});

  searchModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['doctors'] != null) {
      doctors = <Doctors>[];
      json['doctors'].forEach((v) {
        doctors!.add(new Doctors.fromJson(v));
      });
    }
    totalDoc = json['totalDoc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.doctors != null) {
      data['doctors'] = this.doctors!.map((v) => v.toJson()).toList();
    }
    data['totalDoc'] = this.totalDoc;
    return data;
  }
}

class Doctors {
  String? sId;
  String? photo;
  String? region;
  String? specialty;
  List<Null>? calender;
  dynamic raiting;
  dynamic numReviews;
  String? userName;
  String? phone;
  String? birthDate;
  String? sT;
  String? city;

  Doctors(
      {this.sId,
      this.photo,
      this.region,
      this.specialty,
      this.calender,
      this.raiting,
      this.numReviews,
      this.userName,
      this.phone,
      this.birthDate,
      this.sT,
      this.city});

  Doctors.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    photo = json['photo'];
    region = json['region'];
    specialty = json['specialty'];

    raiting = json['raiting'];
    numReviews = json['numReviews'];
    userName = json['userName'];
    phone = json['phone'];
    birthDate = json['birthDate'];
    sT = json['__t'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['photo'] = this.photo;
    data['region'] = this.region;
    data['specialty'] = this.specialty;
    data['raiting'] = this.raiting;
    data['numReviews'] = this.numReviews;
    data['userName'] = this.userName;
    data['phone'] = this.phone;
    data['birthDate'] = this.birthDate;
    data['__t'] = this.sT;
    data['city'] = this.city;
    return data;
  }
}
