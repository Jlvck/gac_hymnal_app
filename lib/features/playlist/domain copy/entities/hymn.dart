import 'package:church/features/hymn/domain/entities/chorus.dart';
import 'package:church/features/hymn/domain/entities/tune.dart';
import 'package:church/features/hymn/domain/entities/verse.dart';

class Hymn {
  final List<Verse> verses;
  final ChorusEntities chorus;
  final Tune? verseTune;
  final Tune? chorusTune;
  final bool isFavourite;
  Hymn({
    required this.verses,
    required this.chorus,
    required this.verseTune,
    required this.chorusTune,
    this.isFavourite = false,
  });
}
