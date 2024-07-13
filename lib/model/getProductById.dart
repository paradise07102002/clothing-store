class GetProductById {
  Result? result;
  int? statusCode;

  GetProductById({this.result, this.statusCode});

  GetProductById.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
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
  List<ProductVariants>? productVariants;

  Result(
      {this.id,
        this.name,
        this.description,
        this.categoryId,
        this.price,
        this.thumbnail,
        this.productVariants});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    categoryId = json['categoryId'];
    price = json['price'];
    thumbnail = json['thumbnail'];
    if (json['productVariants'] != null) {
      productVariants = <ProductVariants>[];
      json['productVariants'].forEach((v) {
        productVariants!.add(new ProductVariants.fromJson(v));
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
    if (this.productVariants != null) {
      data['productVariants'] =
          this.productVariants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductVariants {
  int? id;
  String? variantName;
  int? price;
  int? quantity;
  List<VariantValues>? variantValues;

  ProductVariants(
      {this.id,
        this.variantName,
        this.price,
        this.quantity,
        this.variantValues});

  ProductVariants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    variantName = json['variantName'];
    price = json['price'];
    quantity = json['quantity'];
    if (json['variantValues'] != null) {
      variantValues = <VariantValues>[];
      json['variantValues'].forEach((v) {
        variantValues!.add(new VariantValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['variantName'] = this.variantName;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    if (this.variantValues != null) {
      data['variantValues'] =
          this.variantValues!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VariantValues {
  int? productVariantId;
  int? optionId;
  int? optionValueId;
  OptionValue? optionValue;

  VariantValues(
      {this.productVariantId,
        this.optionId,
        this.optionValueId,
        this.optionValue});

  VariantValues.fromJson(Map<String, dynamic> json) {
    productVariantId = json['productVariantId'];
    optionId = json['optionId'];
    optionValueId = json['optionValueId'];
    optionValue = json['optionValue'] != null
        ? new OptionValue.fromJson(json['optionValue'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productVariantId'] = this.productVariantId;
    data['optionId'] = this.optionId;
    data['optionValueId'] = this.optionValueId;
    if (this.optionValue != null) {
      data['optionValue'] = this.optionValue!.toJson();
    }
    return data;
  }
}

class OptionValue {
  String? thumbnail;
  String? value;

  OptionValue({this.thumbnail, this.value});

  OptionValue.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumbnail'] = this.thumbnail;
    data['value'] = this.value;
    return data;
  }
}