class BadWordFilter {
  static const List<String> _badWords = [
    // English
    'fuck',
    'shit',
    'bitch',
    'asshole',
    'dick',
    'pussy',
    'bastard',
    'motherfucker',

    // Hindi / Hinglish
    'madarchod',
    'behanchod',
    'bhosdike',
    'chutiya',
    'gandu',
    'harami',
    'kutta',
    'sala',
    'randi',
    'loude',
  ];

  static bool containsBadWords(String text) {
    final normalized = _normalize(text);

    for (final word in _badWords) {
      if (normalized.contains(word)) {
        return true;
      }
    }
    return false;
  }

  static String _normalize(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'[0@]'), 'o')
        .replaceAll(RegExp(r'[1!]'), 'i')
        .replaceAll(RegExp(r'[3]'), 'e')
        .replaceAll(RegExp(r'[4]'), 'a')
        .replaceAll(RegExp(r'[5$]'), 's')
        .replaceAll(RegExp(r'[7]'), 't')
        .replaceAll(RegExp(r'[^a-z]'), '')
        .replaceAll(RegExp(r'(.)\1{2,}'), r'\1');
  }
}
