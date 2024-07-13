class GetCart {
  Result? result;
  int? statusCode;

  GetCart({this.result, this.statusCode});

  GetCart.fromJson(Map<String, dynamic> json) {
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
  int? customerId;
  String? createAt;
  String? lastUpdate;
  List<CartItems>? cartItems;

  Result(
      {this.id,
        this.customerId,
        this.createAt,
        this.lastUpdate,
        this.cartItems});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    createAt = json['createAt'];
    lastUpdate = json['lastUpdate'];
    if (json['cartItems'] != null) {
      cartItems = <CartItems>[];
      json['cartItems'].forEach((v) {
        cartItems!.add(new CartItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerId'] = this.customerId;
    data['createAt'] = this.createAt;
    data['lastUpdate'] = this.lastUpdate;
    if (this.cartItems != null) {
      data['cartItems'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartItems {
  int? id;
  int? cartId;
  int? quantity;
  ProductVariant? productVariant;

  CartItems({this.id, this.cartId, this.quantity, this.productVariant});

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartId = json['cartId'];
    quantity = json['quantity'];
    productVariant = json['productVariant'] != null
        ? new ProductVariant.fromJson(json['productVariant'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cartId'] = this.cartId;
    data['quantity'] = this.quantity;
    if (this.productVariant != null) {
      data['productVariant'] = this.productVariant!.toJson();
    }
    return data;
  }
}

class ProductVariant {
  int? id;
  int? productId;
  String? variantName;
  int? price;
  List<VariantValues>? variantValues;

  ProductVariant(
      {this.id,
        this.productId,
        this.variantName,
        this.price,
        this.variantValues});

  ProductVariant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    variantName = json['variantName'];
    price = json['price'];
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
    data['productId'] = this.productId;
    data['variantName'] = this.variantName;
    data['price'] = this.price;
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