enum OrderTrackStepState {
  completed,
  active,
  upcoming;

  factory OrderTrackStepState.fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'completed':
        return OrderTrackStepState.completed;
      case 'active':
        return OrderTrackStepState.active;
      default:
        return OrderTrackStepState.upcoming;
    }
  }
}
