class ModelOrder {
  int? success;
  DataModelOrder? data;
  String? message;
  int? code;

  ModelOrder({this.success, this.data, this.message, this.code});

  ModelOrder.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new DataModelOrder.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }
}

class DataModelOrder {
  int? id;
  String? name;
  String? email;
  String? role;
  List<OrdersModelOrder>? orders;

  DataModelOrder({this.id, this.name, this.email, this.role, this.orders});

  DataModelOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    if (json['orders'] != null) {
      orders = <OrdersModelOrder>[];
      json['orders'].forEach((v) {
        orders!.add(new OrdersModelOrder.fromJson(v));
      });
    }
  }
}

class OrdersModelOrder {
  int? id;
  ShippingAddressModelOrder? shippingAddress;
  String? status;
  int? totalAmount;
  String? sessionId;
  String? createdAt;
  String? lastUpdate;
  List<OrderItemsModelOrder>? orderItems;

  OrdersModelOrder(
      {this.id,
        this.shippingAddress,
        this.status,
        this.totalAmount,
        this.sessionId,
        this.createdAt,
        this.lastUpdate,
        this.orderItems});

  OrdersModelOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shippingAddress = json['shipping_address'] != null
        ? new ShippingAddressModelOrder.fromJson(json['shipping_address'])
        : null;
    status = json['status'];
    totalAmount = json['total_amount'];
    sessionId = json['session_id'];
    createdAt = json['created_at'];
    lastUpdate = json['last_update'];
    if (json['orderItems'] != null) {
      orderItems = <OrderItemsModelOrder>[];
      json['orderItems'].forEach((v) {
        orderItems!.add(new OrderItemsModelOrder.fromJson(v));
      });
    }
  }
}

class ShippingAddressModelOrder {
  String? addressLine1;
  String? city;
  String? state;
  String? postalCode;

  ShippingAddressModelOrder({this.addressLine1, this.city, this.state, this.postalCode});

  ShippingAddressModelOrder.fromJson(Map<String, dynamic> json) {
    addressLine1 = json['address_line_1'];
    city = json['city'];
    state = json['state'];
    postalCode = json['postal_code'];
  }

}

class OrderItemsModelOrder {
  int? id;
  ProductModelOrder? product;
  int? quantity;

  OrderItemsModelOrder({this.id, this.product, this.quantity});

  OrderItemsModelOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ? new ProductModelOrder.fromJson(json['product']) : null;
    quantity = json['quantity'];
  }
}

class ProductModelOrder {
  int? id;
  String? name;
  String? description;
  int? price;
  String? isActive;
  String? cover;

  ProductModelOrder(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.isActive,
        this.cover});

  ProductModelOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    isActive = json['is_active'];
    cover = json['cover'];
  }
}
