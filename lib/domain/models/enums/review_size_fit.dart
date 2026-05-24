enum ReviewSizeFit {
  narrow,
  wide,
  good,
}

extension ReviewSizeFitX on ReviewSizeFit {
  String get labelKey => switch (this) {
        ReviewSizeFit.narrow => 'sizeFitNarrow',
        ReviewSizeFit.wide => 'sizeFitWide',
        ReviewSizeFit.good => 'sizeFitGood',
      };

  String get apiValue => switch (this) {
        ReviewSizeFit.narrow => 'narrow',
        ReviewSizeFit.wide => 'wide',
        ReviewSizeFit.good => 'good',
      };
}
