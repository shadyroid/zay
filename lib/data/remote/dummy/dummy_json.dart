import 'package:hedma/data/remote/dummy/dummy_html_content.dart';

class DummyJson {
  DummyJson._();

  static const _products = [
    {
      'id': '1',
      'name': 'Wireless Headphones',
      'price': '49.99',
      'shopId': '1',
    },
    {
      'id': '2',
      'name': 'Smart Watch',
      'price': '129.99',
      'shopId': '1',
    },
    {
      'id': '3',
      'name': 'Running Shoes',
      'price': '89.99',
      'shopId': '2',
    },
    {
      'id': '4',
      'name': 'Coffee Maker',
      'price': '59.99',
      'shopId': '2',
    },
    {
      'id': '5',
      'name': 'Backpack',
      'price': '39.99',
      'shopId': '3',
    },
    {
      'id': '6',
      'name': 'Desk Lamp',
      'price': '24.99',
      'shopId': '3',
    },
  ];

  static const _shops = [
    {
      'id': '1',
      'name': 'Tech Hub',
      'description': 'Electronics & gadgets',
    },
    {
      'id': '2',
      'name': 'Urban Style',
      'description': 'Fashion & lifestyle',
    },
    {
      'id': '3',
      'name': 'Home Comfort',
      'description': 'Home & kitchen',
    },
  ];

  static const _orders = [
    {
      'id': '1001',
      'status': 'Delivered',
      'total': '179.98',
      'date': '2026-05-15',
      'itemCount': 2,
    },
    {
      'id': '1002',
      'status': 'Processing',
      'total': '89.99',
      'date': '2026-05-18',
      'itemCount': 1,
    },
    {
      'id': '1003',
      'status': 'Shipped',
      'total': '64.98',
      'date': '2026-05-19',
      'itemCount': 2,
    },
  ];

  static Map<String, dynamic> _success({Object? data, String? message}) {
    final json = <String, dynamic>{'statusCode': 200};
    if (message != null) json['message'] = message;
    if (data != null) json['data'] = data;
    return json;
  }

  static Map<String, dynamic> signIn() =>
      _success(data: {'token': 'dummy-auth-token'});

  static Map<String, dynamic> signUp() => signIn();

  static Map<String, dynamic> forgetPassword() =>
      _success(message: 'Code sent');

  static Map<String, dynamic> verification() => _success();

  static Map<String, dynamic> resetPassword() =>
      _success(message: 'resetPasswordSuccess');

  static Map<String, dynamic> logout() => _success();

  static Map<String, dynamic> profile() => _success(
        data: {
          'name': 'Ahmed Ali',
          'email': 'ahmed@ali.com',
          'phone': '',
          'height': '',
          'weight': '',
          'location': '',
        },
      );

  static Map<String, dynamic> updateProfile() =>
      _success(message: 'profileSaved');

  static Map<String, dynamic> products() => _success(data: _products);

  static Map<String, dynamic> featuredProducts() =>
      _success(data: _products.take(4).toList());

  static Map<String, dynamic> productDetails(String productId) {
    final product = _products.cast<Map<String, dynamic>>().firstWhere(
          (item) => item['id'] == productId,
          orElse: () => _products.first,
        );
    return _success(data: product);
  }

  static Map<String, dynamic> favorites() =>
      _success(data: _products.take(3).toList());

  static Map<String, dynamic> shops() => _success(data: _shops);

  static Map<String, dynamic> shopDetails(String shopId) {
    final shop = _shops.cast<Map<String, dynamic>>().firstWhere(
          (item) => item['id'] == shopId,
          orElse: () => _shops.first,
        );
    return _success(data: shop);
  }

  static Map<String, dynamic> shopProducts(String shopId) {
    final products = _products
        .where((item) => item['shopId'] == shopId)
        .toList();
    return _success(data: products);
  }

  static Map<String, dynamic> cart() =>
      _success(data: [_products[0], _products[2]]);

  static Map<String, dynamic> removeFromCart(String productId) {
    final items = [_products[0], _products[2]]
        .where((item) => item['id'] != productId)
        .toList();
    return _success(data: items);
  }

  static Map<String, dynamic> checkout() =>
      _success(message: 'checkoutSuccess');

  static Map<String, dynamic> orders() => _success(data: _orders);

  static Map<String, dynamic> orderDetails(String orderId) {
    final order = _orders.cast<Map<String, dynamic>>().firstWhere(
          (item) => item['id'] == orderId,
          orElse: () => _orders.first,
        );
    return _success(data: order);
  }

  static Map<String, dynamic> orderTrack() => _success(
        data: [
          'trackPlaced',
          'trackProcessing',
          'trackShipped',
          'trackDelivered',
        ],
      );

  static Map<String, dynamic> orderReturn() =>
      _success(message: 'returnSubmitted');

  static Map<String, dynamic> aboutUs() =>
      _success(data: DummyHtmlContent.aboutUs);

  static Map<String, dynamic> terms() => _success(data: DummyHtmlContent.terms);

  static Map<String, dynamic> privacy() =>
      _success(data: DummyHtmlContent.privacy);

  static Map<String, dynamic> sendMessage() =>
      _success(message: 'messageSent');
}
