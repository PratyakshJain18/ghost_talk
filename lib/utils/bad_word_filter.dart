class BadWordFilter {
  static bool containsBadWords(String text) {
    final lower = text.toLowerCase();

    final patterns = <RegExp>[


      RegExp(r'\bf[\W_]*u?[\W_]*c[\W_]*k+\b'),
      RegExp(r'\bs[\W_]*h[\W_]*i[\W_]*t+\b'),
      RegExp(r'\bb[\W_]*i[\W_]*t[\W_]*c[\W_]*h+\b'),
      RegExp(r'\ba[\W_]*s[\W_]*s+\b'),
      RegExp(r'\ba[\W_]*s[\W_]*s[\W_]*h[\W_]*o[\W_]*l[\W_]*e+\b'),
      RegExp(r'\bd[\W_]*i[\W_]*c[\W_]*k+\b'),
      RegExp(r'\bp[\W_]*u[\W_]*s[\W_]*s[\W_]*y+\b'),
      RegExp(r'\bb[\W_]*a[\W_]*s[\W_]*t[\W_]*a[\W_]*r[\W_]*d+\b'),
      RegExp(r'\bm[\W_]*o[\W_]*t[\W_]*h[\W_]*e[\W_]*r[\W_]*f[\W_]*u[\W_]*c[\W_]*k[\W_]*e[\W_]*r+\b'),


      RegExp(r'\bm[\W_]*a[\W_]*d[\W_]*a[\W_]*r[\W_]*c[\W_]*h[\W_]*o[\W_]*d+\b'),
      RegExp(r'\bb[\W_]*e[\W_]*h[\W_]*n[\W_]*c[\W_]*h[\W_]*o[\W_]*d+\b'),
      RegExp(r'\bb[\W_]*h[\W_]*o[\W_]*s[\W_]*d[\W_]*i[\W_]*k[\W_]*e+\b'),
      RegExp(r'\bc[\W_]*h[\W_]*u[\W_]*t[\W_]*i[\W_]*y[\W_]*a+\b'),
      RegExp(r'\bl[\W_]*a[\W_]*u[\W_]*d[\W_]*e+\b'),
      RegExp(r'\bg[\W_]*a[\W_]*n[\W_]*d[\W_]*u+\b'),
      RegExp(r'\bh[\W_]*a[\W_]*r[\W_]*a[\W_]*m[\W_]*i+\b'),
      RegExp(r'\bk[\W_]*u[\W_]*t[\W_]*t[\W_]*a+\b'),
      RegExp(r'\bs[\W_]*a[\W_]*l[\W_]*a+\b'),
      RegExp(r'\br[\W_]*a[\W_]*n[\W_]*d[\W_]*i+\b'),
    ];

    for (final pattern in patterns) {
      if (pattern.hasMatch(lower)) {
        return true;
      }
    }
    return false;
  }
}
