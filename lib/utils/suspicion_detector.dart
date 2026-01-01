bool looksSuspicious(String text) {
  final triggers = [
    'die',
    'kill',
    'hate',
    'worthless',
    'disgusting',
    'go away',
  ];

  final lower = text.toLowerCase();
  return triggers.any(lower.contains);
}
