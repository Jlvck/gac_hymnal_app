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

    test("Testing for number of Hymn", () {
      //Change
      expect(testHymnList.length, 370);
    });
    test('Testing Hymn(English & Yoruba) verses Length', () {
      bool tes = testHymnList.every((element) {
        if (element.versesEnglish.length == element.versesYoruba.length) {
          return true;
        } else {
          print(
              "Hymn ${element.id}, Yoruba Verses Length ${element.versesYoruba.length} & English Verses Length ${element.versesEnglish.length}");
          return false;
        }
      });
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
          print(element.id);
          return false;
        }
      });

      expect(test, true);
    });
  });
}
