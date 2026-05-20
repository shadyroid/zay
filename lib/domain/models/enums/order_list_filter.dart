enum OrderListFilter {
  all,
  active,
  completed,
  returned;

  String get translationKey => switch (this) {
        OrderListFilter.all => 'allOrders',
        OrderListFilter.active => 'activeOrders',
        OrderListFilter.completed => 'completedOrders',
        OrderListFilter.returned => 'returnedOrders',
      };
}
