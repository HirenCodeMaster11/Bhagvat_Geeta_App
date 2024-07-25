class GitaModal {
  late int ChapterNumber;
  late List<VersesModal> Verses;
  late ChapterNameModal chapterNameModal;

  GitaModal(
      {required this.ChapterNumber,
      required this.Verses,
      required this.chapterNameModal});

  factory GitaModal.fromJson(Map m1) {
    return GitaModal(
      ChapterNumber: m1['Chapter'],
      Verses: (m1['Verses'] as List).map((e) => VersesModal.fromJson(e),).toList(),
      chapterNameModal: ChapterNameModal.fromJson(
        m1['ChapterName'],
      ),
    );
  }
}

class ChapterNameModal {
  late String Hindi, English, Gujarati, Sanskrit;

  ChapterNameModal(
      {required this.Hindi,
      required this.English,
      required this.Gujarati,
      required this.Sanskrit});

  factory ChapterNameModal.fromJson(Map m1) {
    return ChapterNameModal(
        Hindi: m1['Hindi'],
        English: m1['English'],
        Gujarati: m1['Gujarati'],
        Sanskrit: m1['Sanskrit']);
  }
}

class VersesModal {
  late int VerseNumber;
  late Language language;

  VersesModal({required this.VerseNumber, required this.language});

  factory VersesModal.fromJson(Map m1) {
    return VersesModal(
        VerseNumber: m1['VerseNumber'],
        language: Language.fromJson(m1['Text']));
  }
}

class Language {
  late String Hindi, English, Gujarati, Sanskrit;

  Language(
      {required this.Hindi,
      required this.English,
      required this.Gujarati,
      required this.Sanskrit});

  factory Language.fromJson(Map m1) {
    return Language(
        Hindi: m1['Hindi'],
        English: m1['English'],
        Gujarati: m1['Gujarati'],
        Sanskrit: m1['Sanskrit']);
  }
}
