class GetAllProduct {
  List<Result>? result;
  int? statusCode;

  GetAllProduct({this.result, this.statusCode});

  GetAllProduct.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Result {
  int? id;
  String? name;
  String? description;
  int? categoryId;
  int? price;
  String? thumbnail;
  List<ProductOptionValues>? productOptionValues;

  Result(
      {this.id,
        this.name,
        this.description,
        this.categoryId,
        this.price,
        this.thumbnail,
        this.productOptionValues});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    categoryId = json['categoryId'];
    price = json['price'];
    thumbnail = json['thumbnail'];
    if (json['productOptionValues'] != null) {
      productOptionValues = <ProductOptionValues>[];
      json['productOptionValues'].forEach((v) {
        productOptionValues!.add(new ProductOptionValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['categoryId'] = this.categoryId;
    data['price'] = this.price;
    data['thumbnail'] = this.thumbnail;
    if (this.productOptionValues != null) {
      data['productOptionValues'] =
          this.productOptionValues!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductOptionValues {
  int? optionId;
  int? optionValueId;
  OptionValue? optionValue;

  ProductOptionValues({this.optionId, this.optionValueId, this.optionValue});

  ProductOptionValues.fromJson(Map<String, dynamic> json) {
    optionId = json['optionId'];
    optionValueId = json['optionValueId'];
    optionValue = json['optionValue'] != null
        ? new OptionValue.fromJson(json['optionValue'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['optionId'] = this.optionId;
    data['optionValueId'] = this.optionValueId;
    if (this.optionValue != null) {
      data['optionValue'] = this.optionValue!.toJson();
    }
    return data;
  }
}

class OptionValue {
  int? id;
  int? optionId;
  String? value;
  String? thumbnail;
  int? price;

  OptionValue({this.id, this.optionId, this.value, this.thumbnail, this.price});

  OptionValue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    optionId = json['optionId'];
    value = json['value'];
    thumbnail = json['thumbnail'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['optionId'] = this.optionId;
    data['value'] = this.value;
    data['thumbnail'] = this.thumbnail;
    data['price'] = this.price;
    return data;
  }
}