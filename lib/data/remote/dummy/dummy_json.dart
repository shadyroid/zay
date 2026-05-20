import 'package:hedma/data/remote/dummy/dummy_html_content.dart';

class DummyJson {
  DummyJson._();

  static final Set<String> _favoriteProductIds = {'1', '2'};

  static const _categories = [
    {
      'id': 'all',
      'name': 'All Items',
      'iconUrl': 'https://api.iconify.design/lucide/layout-grid.svg',
    },
    {
      'id': 'shirts',
      'name': 'Shirts',
      'iconUrl': 'https://api.iconify.design/lucide/shirt.svg',
    },
    {
      'id': 'tshirt',
      'name': 'T-Shirt',
      'iconUrl': 'https://api.iconify.design/mdi/tshirt-crew-outline.svg',
    },
    {
      'id': 'pants',
      'name': 'Pants',
      'iconUrl': 'https://api.iconify.design/ph/pants.svg',
    },
  ];

  static const _products = [
    {
      'id': '1',
      'name': 'Linen TShirt',
      'price': '162.99',
      'shopId': '1',
      'categoryId': 'tshirt',
      'sizeId': 'l',
      'rating': '5.0',
      'imageUrl':
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=600&h=720&fit=crop',
    },
    {
      'id': '2',
      'name': 'Linen TShirt',
      'price': '162.99',
      'shopId': '1',
      'categoryId': 'tshirt',
      'sizeId': 'l',
      'rating': '5.0',
      'imageUrl':
          'https://images.unsplash.com/photo-1434389677669-e08b4cac3105?w=600&h=720&fit=crop',
    },
    {
      'id': '3',
      'name': 'Oxford Shirt',
      'price': '89.99',
      'shopId': '2',
      'categoryId': 'shirts',
      'sizeId': 'm',
      'rating': '4.8',
      'imageUrl':
          'https://images.unsplash.com/photo-1596755094514-f87e34085b2b?w=600&h=720&fit=crop',
    },
    {
      'id': '4',
      'name': 'Casual Shirt',
      'price': '59.99',
      'shopId': '2',
      'categoryId': 'shirts',
      'sizeId': 's',
      'rating': '4.6',
      'imageUrl':
          'https://images.unsplash.com/photo-1602810318383-9a6f1d8b8f0b?w=600&h=720&fit=crop',
    },
    {
      'id': '5',
      'name': 'Chino Pants',
      'price': '79.99',
      'shopId': '3',
      'categoryId': 'pants',
      'sizeId': 'xl',
      'rating': '4.9',
      'imageUrl':
          'https://images.unsplash.com/photo-1473966968600-fa801b279154?w=600&h=720&fit=crop',
    },
    {
      'id': '6',
      'name': 'Slim Pants',
      'price': '74.99',
      'shopId': '3',
      'categoryId': 'pants',
      'sizeId': 'xxl',
      'rating': '4.5',
      'imageUrl':
          'https://images.unsplash.com/photo-1624378439575-d8705ad7ae80?w=600&h=720&fit=crop',
    },
  ];

  static const _sizes = [
    {'id': 'm', 'label': 'M'},
    {'id': 's', 'label': 'S'},
    {'id': 'l', 'label': 'L'},
    {'id': 'xl', 'label': 'XL'},
    {'id': 'xxl', 'label': 'XXL'},
  ];

  static const _shops = [
    {
      'id': '1',
      'name': 'Moda Store',
      'description': 'Genuine products - Fast shipping',
      'about':
          'Moda a Brand Specializing In Selling Designer Products And Brands',
      'rating': '4.5',
      'reviewCount': 45,
      'iconUrl':
          'https://images.unsplash.com/photo-1560472354-b33ff0c44a43?w=64&h=64&fit=crop',
      'logoUrl':
          'https://images.unsplash.com/photo-1560472354-b33ff0c44a43?w=200&h=200&fit=crop',
      'bannerUrl':
          'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=800&h=400&fit=crop',
      'imageUrl':
          'https://images.unsplash.com/photo-1560472354-b33ff0c44a43?w=200&h=200&fit=crop',
    },
    {
      'id': '2',
      'name': 'Adidas',
      'description': 'Genuine products - Fast shipping',
      'about': 'Adidas offers sportswear and lifestyle products worldwide.',
      'rating': '4.5',
      'reviewCount': 45,
      'iconUrl':
          'https://api.iconify.design/simple-icons/adidas.svg?color=%23000000',
      'logoUrl':
          'https://api.iconify.design/simple-icons/adidas.svg?color=%23000000',
      'bannerUrl':
          'https://images.unsplash.com/photo-1483986413-4286c106bf20?w=800&h=400&fit=crop',
      'imageUrl':
          'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=200&h=200&fit=crop',
    },
    {
      'id': '3',
      'name': 'Nike',
      'description': 'Genuine products - Fast shipping',
      'about': 'Nike offers innovative athletic footwear and apparel.',
      'rating': '4.5',
      'reviewCount': 45,
      'iconUrl':
          'https://api.iconify.design/simple-icons/nike.svg?color=%23000000',
      'logoUrl':
          'https://api.iconify.design/simple-icons/nike.svg?color=%23000000',
      'bannerUrl':
          'https://images.unsplash.com/photo-1483986413-4286c106bf20?w=800&h=400&fit=crop',
      'imageUrl':
          'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=200&h=200&fit=crop',
    },
    {
      'id': '4',
      'name': 'Fila',
      'description': 'Genuine products - Fast shipping',
      'about': 'Fila offers sportswear and lifestyle fashion products.',
      'rating': '4.5',
      'reviewCount': 45,
      'iconUrl':
          'https://api.iconify.design/simple-icons/fila.svg?color=%23000000',
      'logoUrl':
          'https://api.iconify.design/simple-icons/fila.svg?color=%23000000',
      'bannerUrl':
          'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=800&h=400&fit=crop',
      'imageUrl':
          'https://images.unsplash.com/photo-1560472354-b33ff0c44a43?w=200&h=200&fit=crop',
    },
  ];

  static const _orders = [
    {
      'id': '23456',
      'status': 'Pending',
      'total': '290',
      'date': '03 March 2026',
      'itemCount': 1,
      'productName': 'Regular fit slogan',
      'productImageUrl':
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=200&h=200&fit=crop',
      'size': 'L',
      'quantity': 1,
    },
    {
      'id': '23457',
      'status': 'Confirmed',
      'total': '290',
      'date': '02 March 2026',
      'itemCount': 1,
      'productName': 'Regular Fit Polo',
      'productImageUrl':
          'https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?w=200&h=200&fit=crop',
      'size': 'L',
      'quantity': 1,
    },
    {
      'id': '23458',
      'status': 'Shipped',
      'total': '179.98',
      'date': '01 March 2026',
      'itemCount': 1,
      'productName': 'Regular fit slogan',
      'productImageUrl':
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=200&h=200&fit=crop',
      'size': 'M',
      'quantity': 1,
    },
    {
      'id': '23459',
      'status': 'Delivered',
      'total': '89.99',
      'date': '28 February 2026',
      'itemCount': 1,
      'productName': 'Regular Fit Polo',
      'productImageUrl':
          'https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?w=200&h=200&fit=crop',
      'size': 'L',
      'quantity': 1,
    },
    {
      'id': '23460',
      'status': 'Returned',
      'total': '64.98',
      'date': '25 February 2026',
      'itemCount': 1,
      'productName': 'Regular fit slogan',
      'productImageUrl':
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=200&h=200&fit=crop',
      'size': 'S',
      'quantity': 1,
    },
  ];

  static Map<String, dynamic> _success({
    Object? data,
    String? message,
    int? totalCount,
  }) {
    final json = <String, dynamic>{'statusCode': 200};
    if (message != null) json['message'] = message;
    if (data != null) json['data'] = data;
    if (totalCount != null) json['totalCount'] = totalCount;
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
          'phone': '+20 100 123 4567',
          'height': '',
          'weight': '',
          'location': '',
        },
      );

  static Map<String, dynamic> updateProfile() =>
      _success(message: 'profileSaved');

  static Map<String, dynamic> categories() => _success(data: _categories);

  static Map<String, dynamic> sizes() => _success(data: _sizes);

  static Map<String, dynamic> products({String? categoryId}) {
    final filtered = categoryId == null || categoryId == 'all'
        ? _products
        : _products
            .where((p) => p['categoryId'] == categoryId)
            .toList(growable: false);
    return _success(
      data: _productsWithFavorites(filtered.cast<Map<String, dynamic>>()),
      totalCount: categoryId == null || categoryId == 'all' ? 320 : filtered.length,
    );
  }

  static Map<String, dynamic> featuredProducts() => _success(
        data: _productsWithFavorites(
          _products.take(4).cast<Map<String, dynamic>>().toList(),
        ),
      );

  static Map<String, dynamic> _productWithFavorite(
    Map<String, dynamic> product,
  ) {
    final map = Map<String, dynamic>.from(product);
    map['isFavorite'] = _favoriteProductIds.contains(product['id']);
    return map;
  }

  static List<Map<String, dynamic>> _productsWithFavorites(
    List<Map<String, dynamic>> products,
  ) =>
      products.map(_productWithFavorite).toList();

  static List<Map<String, dynamic>> _defaultProductSizes() => [
        {
          'id': 's',
          'label': 'S',
          'measurements': [
            {'id': 'chest', 'label': 'Chest Width', 'value': '41'},
            {'id': 'length', 'label': 'Shirt Length', 'value': '72'},
            {'id': 'sleeve', 'label': 'Sleeve Length', 'value': '22'},
            {'id': 'shoulder', 'label': 'Shoulder Width', 'value': '18'},
          ],
        },
        {
          'id': 'm',
          'label': 'M',
          'measurements': [
            {'id': 'chest', 'label': 'Chest Width', 'value': '43'},
            {'id': 'length', 'label': 'Shirt Length', 'value': '74'},
            {'id': 'sleeve', 'label': 'Sleeve Length', 'value': '23'},
            {'id': 'shoulder', 'label': 'Shoulder Width', 'value': '19'},
          ],
        },
        {
          'id': 'l',
          'label': 'L',
          'measurements': [
            {'id': 'chest', 'label': 'Chest Width', 'value': '45'},
            {'id': 'length', 'label': 'Shirt Length', 'value': '76'},
            {'id': 'sleeve', 'label': 'Sleeve Length', 'value': '24'},
            {'id': 'shoulder', 'label': 'Shoulder Width', 'value': '20'},
          ],
        },
        {
          'id': 'xl',
          'label': 'XL',
          'measurements': [
            {'id': 'chest', 'label': 'Chest Width', 'value': '47'},
            {'id': 'length', 'label': 'Shirt Length', 'value': '78'},
            {'id': 'sleeve', 'label': 'Sleeve Length', 'value': '25'},
            {'id': 'shoulder', 'label': 'Shoulder Width', 'value': '21'},
          ],
        },
        {
          'id': 'xxl',
          'label': 'XXL',
          'measurements': [
            {'id': 'chest', 'label': 'Chest Width', 'value': '49'},
            {'id': 'length', 'label': 'Shirt Length', 'value': '80'},
            {'id': 'sleeve', 'label': 'Sleeve Length', 'value': '26'},
            {'id': 'shoulder', 'label': 'Shoulder Width', 'value': '22'},
          ],
        },
      ];

  static Map<String, dynamic> _enrichedProduct(String productId) {
    final product = Map<String, dynamic>.from(
      _products.cast<Map<String, dynamic>>().firstWhere(
            (item) => item['id'] == productId,
            orElse: () => _products.first,
          ),
    );
    final imageUrl = product['imageUrl'] as String?;
    product['imageUrls'] = [
      ?imageUrl,
      'https://images.unsplash.com/photo-1618354691373-d851c5c3a990?w=600&h=720&fit=crop',
      'https://images.unsplash.com/photo-1576566588028-4147f3842f27?w=600&h=720&fit=crop',
    ];
    product['description'] =
        'The name says it all, the right size slightly snugs the body leaving enough room for comfort in the sleeves and waist.';
    product['reviewCount'] = 45;
    product['shopName'] = product['shopId'] == '1'
        ? "MEN'S CLUB"
        : _shops.firstWhere(
            (s) => s['id'] == product['shopId'],
            orElse: () => _shops.first,
          )['name'];
    product['sellerCategories'] = 'MEN, TOP, T-SHIRTS, SUITS, ACCESSORIES';
    product['sizes'] = _defaultProductSizes();
    if (productId == '1') {
      product['name'] = 'Regular Fit Slogan';
      product['price'] = '299';
    }
    return product;
  }

  static Map<String, dynamic> productDetails(String productId) {
    return _success(data: _productWithFavorite(_enrichedProduct(productId)));
  }

  static Map<String, dynamic> reviews(String productId) => _success(
        data: [
          {
            'id': '1',
            'title': 'Good product, Value for money !',
            'comment':
                'The shirt is very good. I like it very much. I will buy it again. The quality is good and the price is reasonable.',
            'authorName': 'Sunny Vo',
            'rating': 3,
            'createdAt': '15 mins ago',
          },
          {
            'id': '2',
            'title': 'Great fit and quality',
            'comment':
                'Fits perfectly and the fabric feels premium. Delivery was fast.',
            'authorName': 'Ahmed Ali',
            'rating': 5,
            'createdAt': '2 days ago',
          },
        ],
      );

  static Map<String, dynamic> addReview(String productId) =>
      _success(message: 'reviewSubmitted');

  static Map<String, dynamic> tryProduct(String productId) => _success(
        data: {
          'imageUrl':
              'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=600&h=800&fit=crop',
        },
      );

  static Map<String, dynamic> favorites() => _success(
        data: _productsWithFavorites(
          _products
              .cast<Map<String, dynamic>>()
              .where((p) => _favoriteProductIds.contains(p['id']))
              .toList(),
        ),
      );

  static Map<String, dynamic> favorite(String productId) {
    _favoriteProductIds.add(productId);
    return _success(message: 'addedToFavorites');
  }

  static Map<String, dynamic> unfavorite(String productId) {
    _favoriteProductIds.remove(productId);
    return _success(message: 'removedFromFavorites');
  }

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
        .cast<Map<String, dynamic>>()
        .toList();
    return _success(data: _productsWithFavorites(products));
  }

  static List<Map<String, dynamic>> _cartItems() => [
        {
          'id': '1',
          'name': 'Regular fit slogan',
          'price': '290',
          'imageUrl': _products[0]['imageUrl'],
          'sizeLabel': 'L',
          'quantity': 1,
        },
        {
          'id': '3',
          'name': 'Oxford Shirt',
          'price': '210',
          'imageUrl': _products[2]['imageUrl'],
          'sizeLabel': 'M',
          'quantity': 1,
        },
      ];

  static Map<String, dynamic> cart() => _success(data: _cartItems());

  static Map<String, dynamic> removeFromCart(String productId) {
    final items =
        _cartItems().where((item) => item['id'] != productId).toList();
    return _success(data: items);
  }

  static Map<String, dynamic> createOrder() => _success(
        data: {
          'id': '1004',
          'status': 'Placed',
          'total': '500',
        },
        message: 'orderPlacedSuccess',
      );

  static Map<String, dynamic> checkout() =>
      _success(message: 'checkoutSuccess');

  static Map<String, dynamic> orders() => _success(data: _orders);

  static Map<String, dynamic> orderDetails(String orderId) {
    final order = Map<String, dynamic>.from(
      _orders.cast<Map<String, dynamic>>().firstWhere(
        (item) => item['id'] == orderId,
        orElse: () => _orders.first,
      ),
    );
    order.addAll({
      'customerName': 'Ahmed Ali',
      'customerAddress': 'Abbas El Akkad, Nasr City, Cairo',
      'customerPhone': '01002407809',
      'customerImageUrl':
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop',
      'subtotal': order['total'],
      'shipping': '0',
      'paymentMethod': 'cash',
      'summaryDate': '3-3-2026',
    });
    return _success(data: order);
  }

  static Map<String, dynamic> orderTrack() => _success(
        data: {
          'estimatedDelivery': 'Today, 4:30 PM',
          'steps': [
            {
              'titleKey': 'trackStepPending',
              'subtitleKey': 'trackStepPendingDesc',
              'timestamp': 'Nov 30, 10:30 AM',
              'state': 'completed',
              'icon': 'pending',
            },
            {
              'titleKey': 'trackStepConfirmed',
              'subtitleKey': 'trackStepConfirmedDesc',
              'timestamp': 'Nov 30, 12:15 PM',
              'state': 'completed',
              'icon': 'confirmed',
            },
            {
              'titleKey': 'trackStepShipped',
              'subtitleKey': 'trackStepShippedDesc',
              'timestamp': 'Nov 30, 2:45 PM',
              'state': 'upcoming',
              'icon': 'shipped',
            },
            {
              'titleKey': 'trackStepDelivered',
              'subtitleKey': 'trackStepDeliveredDesc',
              'timestamp': 'Expected at 4:15 PM',
              'state': 'upcoming',
              'icon': 'delivered',
            },
            {
              'titleKey': 'trackStepReturned',
              'subtitleKey': 'trackStepReturnedDesc',
              'timestamp': 'Expected at 4:30 PM',
              'state': 'upcoming',
              'icon': 'returned',
            },
          ],
        },
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
