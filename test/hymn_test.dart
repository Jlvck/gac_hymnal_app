// ignore_for_file: deprecated_member_use, depend_on_referenced_packages

import 'package:test/test.dart';
import 'package:church/providers/hymn_book_provider.dart';
import 'package:church/model/hymn.dart';
// import 'package:collection/equality.dart';

void main() {
  group('TESTING HYMN DATA INTEGRITY ', () {
    List<Hymn> testHymnList = HymnBookProvider().hymnList;
    List<Hymn> yorubatestChorus =
        testHymnList.where((hymn) => hymn.chorusYoruba != null).toList();
    List<Hymn> englishtestChorus =
        testHymnList.where((hymn) => hymn.chorusEnglish != null).toList();
    test('Testing Hymn(English & Yoruba) verses Length', () {
      bool tes = testHymnList.every((element) =>
          element.versesEnglish.length == element.versesYoruba.length);
      expect(tes, true);
    });

    test('check for number of hymn chorus', () {
      bool test = yorubatestChorus.length == englishtestChorus.length;
      expect(test, true);
    });
    test('check Hymn Chorus integrity', () {
      bool test = testHymnList.every((element) {
        if ((element.chorusEnglish == null && element.chorusYoruba == null) ||
            (element.chorusEnglish != null && element.chorusYoruba != null)) {
          return true;
        } else {
          return false;
        }
      });

      expect(test, true);
    });
  });
}
