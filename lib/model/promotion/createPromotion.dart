class CreatePromotion {
  String? name;
  int? promotionTypeId;
  int? promotionValue;
  PromotionType? promotionType;

  CreatePromotion(
      {this.name,
        this.promotionTypeId,
        this.promotionValue,
        this.promotionType});

  CreatePromotion.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    promotionTypeId = json['promotionTypeId'];
    promotionValue = json['promotionValue'];
    promotionType = json['promotionType'] != null
        ? new PromotionType.fromJson(json['promotionType'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['promotionTypeId'] = this.promotionTypeId;
    data['promotionValue'] = this.promotionValue;
    if (this.promotionType != null) {
      data['promotionType'] = this.promotionType!.toJson();
    }
    return data;
  }
}

class PromotionType {
  String? title;

  PromotionType({this.title});

  PromotionType.fromJson(Map<String, dynamic> json) {
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    return data;
  }
}