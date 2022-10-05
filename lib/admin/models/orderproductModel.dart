class Orderproduct {
  String? Id;
  String? barcode;
  String? orderdate;
  String? orderstatus;
  int? totalquantity;
  int? tax;
  int? deliveryprice;
  int? totalAmount;
  int? discount;
  String? shippingDate;
  String? paymentmethod;
  String? paymentstatus;
  int? totalprofit;
  String? image;
  Delivery? delivery;
  Shippingaddress? shippingaddress;
  List<Orderitem>? orderitem;

  Orderproduct(
      {this.Id,
      this.barcode,
      this.orderdate,
      this.orderstatus,
      this.totalquantity,
      this.tax,
      this.deliveryprice,
      this.totalAmount,
      this.discount,
      this.shippingDate,
      this.paymentmethod,
      this.paymentstatus,
      required this.totalprofit,
      this.image,
      this.delivery,
      this.shippingaddress,
      this.orderitem});

  Orderproduct.fromJson(Map<String, dynamic> json) {
    Id = json['_id'];
    barcode = json['barcode'];
    orderdate = json['orderdate'];
    orderstatus = json['orderstatus'];
    totalquantity = json['totalquantity'];
    tax = json['tax'];
    deliveryprice = json['deliveryprice'];
    totalAmount = json['totalAmount'];
    discount = json['discount'];
    shippingDate = json['shippingDate'];
    paymentmethod = json['paymentmethod'];
    paymentstatus = json['paymentstatus'];
    totalprofit = int.parse(json['totalprofit']);
    image = json['image'];
    delivery = json['delivery'] != null
        ? new Delivery.fromJson(json['delivery'])
        : null;
    shippingaddress = json['shippingaddress'] != null
        ? new Shippingaddress.fromJson(json['shippingaddress'])
        : null;
    if (json['Orderitem'] != null) {
      orderitem = <Orderitem>[];
      json['Orderitem'].forEach((v) {
        orderitem!.add(new Orderitem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.Id;
    data['barcode'] = this.barcode;
    data['orderdate'] = this.orderdate;
    data['orderstatus'] = this.orderstatus;
    data['totalquantity'] = this.totalquantity;
    data['tax'] = this.tax;
    data['deliveryprice'] = this.deliveryprice;
    data['totalAmount'] = this.totalAmount;
    data['discount'] = this.discount;
    data['shippingDate'] = this.shippingDate;
    data['paymentmethod'] = this.paymentmethod;
    data['paymentstatus'] = this.paymentstatus;
    data['totalprofit'] = this.totalprofit;
    data['image'] = this.image;
    if (this.delivery != null) {
      data['delivery'] = this.delivery!.toJson();
    }
    if (this.shippingaddress != null) {
      data['shippingaddress'] = this.shippingaddress!.toJson();
    }
    if (this.orderitem != null) {
      data['Orderitem'] = this.orderitem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Delivery {
  String? title;
  int? price;
  String? estimateTime;

  Delivery({this.title, this.price, this.estimateTime});

  Delivery.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'];
    estimateTime = json['estimateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['price'] = this.price;
    data['estimateTime'] = this.estimateTime;
    return data;
  }
}

class Shippingaddress {
  String? fullName;
  String? phone;
  String? address;
  String? city;
  String? state;
  String? postal;
  String? country;
  bool? isDefault;

  Shippingaddress(
      {this.fullName,
      this.phone,
      this.address,
      this.city,
      this.state,
      this.postal,
      this.country,
      this.isDefault});

  Shippingaddress.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    phone = json['Phone'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    postal = json['postal'];
    country = json['country'];
    isDefault = json['isDefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['Phone'] = this.phone;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postal'] = this.postal;
    data['country'] = this.country;
    data['isDefault'] = this.isDefault;
    return data;
  }
}

class Orderitem {
  String? oid;
  String? productid;
  String? producttype;
  int? sellprice;
  int? buyprice;
  int? quantity;
  int? totalamount;
  int? discount;
  int? profile;
  String? itemStatus;
  String? expiredate;

  Orderitem(
      {this.oid,
      this.productid,
      this.producttype,
      this.sellprice,
      this.buyprice,
      this.quantity,
      this.totalamount,
      this.discount,
      this.profile,
      this.itemStatus,
      this.expiredate});

  Orderitem.fromJson(Map<String, dynamic> json) {
    oid = json['_id'];
    productid = json['productid'];
    producttype = json['producttype'];
    sellprice = json['sellprice'];
    buyprice = json['buyprice'];
    quantity = json['quantity'];
    totalamount = json['totalamount'];
    discount = json['discount'];
    profile = json['profile'];
    itemStatus = json['itemStatus'];
    expiredate = json['expiredate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.oid;
    data['productid'] = this.productid;
    data['producttype'] = this.producttype;
    data['sellprice'] = this.sellprice;
    data['buyprice'] = this.buyprice;
    data['quantity'] = this.quantity;
    data['totalamount'] = this.totalamount;
    data['discount'] = this.discount;
    data['profile'] = this.profile;
    data['itemStatus'] = this.itemStatus;
    data['expiredate'] = this.expiredate;
    return data;
  }
}
