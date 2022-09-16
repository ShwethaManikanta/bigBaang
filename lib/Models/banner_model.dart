class BannerModel {
  late String status;
  late String message;
  String? imageBaseurl;
  List<TopBanner>? topBanner;

  BannerModel(
      {required this.status,
      required this.message,
      required this.imageBaseurl,
      required this.topBanner});

  BannerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['topBanner'] != null) {
      topBanner = [];
      imageBaseurl = json['image_baseurl'];

      json['topBanner'].forEach((v) {
        topBanner!.add(TopBanner.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    if (topBanner != null) {
      data['image_baseurl'] = imageBaseurl;

      data['topBanner'] = topBanner!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OfferBannerModel {
  late String status;
  late String message;
  String? imageBaseurl;
  List<TopBanner>? topBanner;

  OfferBannerModel(
      {required this.status,
      required this.message,
      required this.imageBaseurl,
      required this.topBanner});

  OfferBannerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['topBanner'] != null) {
      topBanner = [];
      imageBaseurl = json['image_baseurl'];

      json['topBanner'].forEach((v) {
        topBanner!.add(TopBanner.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['image_baseurl'] = imageBaseurl;

    if (topBanner != null) {
      data['message'] = message;

      data['topBanner'] = topBanner!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopBanner {
  late String bannerImage;

  TopBanner({required this.bannerImage});

  TopBanner.fromJson(Map<String, dynamic> json) {
    bannerImage = json['banner_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['banner_image'] = bannerImage;
    return data;
  }
}
