import 'package:church/model/hymn.dart';

class Playlist {
  final String title;
  final List<HymnNotifier> hymns;
  Playlist(this.hymns, this.title);
}
