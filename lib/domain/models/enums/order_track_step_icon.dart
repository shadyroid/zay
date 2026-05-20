enum OrderTrackStepIcon {
  pending,
  confirmed,
  shipped,
  delivered,
  returned;

  factory OrderTrackStepIcon.fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'confirmed':
        return OrderTrackStepIcon.confirmed;
      case 'shipped':
        return OrderTrackStepIcon.shipped;
      case 'delivered':
        return OrderTrackStepIcon.delivered;
      case 'returned':
        return OrderTrackStepIcon.returned;
      default:
        return OrderTrackStepIcon.pending;
    }
  }
}
