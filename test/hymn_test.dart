import 'package:test/test.dart';
import 'package:gac_hymnal_app/providers/hymn_book_provider.dart';
import 'package:gac_hymnal_app/model/hymn.dart';
import 'package:collection/collection.dart';

void main() {
  group('TESTING HYMN DATA INTEGRITY ', () {
    List<int> num = [];
    List<Hymn> testHymnList = HymnBookProvider().hymnList;
    List<Hymn> yorubatestChorus =
        testHymnList.where((hymn) => hymn.chorusYoruba != null).toList();
    List<Hymn> englishtestChorus =
        testHymnList.where((hymn) => hymn.chorusEnglish != null).toList();

    test('Testing the integrity of hymn number arrangement', () {
      List<int> number = List.generate(testHymnList.length, (index) {
        int value = index + 1;

        return value;
      });

      List<int> hymnNumber = List.generate(testHymnList.length, (index) {
        int value = int.parse(testHymnList[index].id);
        if (num.contains(value) || value > 500) {}
        num.add(value);
        return value;
      });

      expect(const IterableEquality().equals(number, hymnNumber), true);
    });
    test("Testing for number of Hymns", () {
      //Change
      expect(testHymnList.length, 500);
    });
    test('Testing Hymn(English & Yoruba) verses Length', () {
      bool tes = testHymnList.every((element) {
        if (element.versesEnglish.length == element.versesYoruba.length) {
          return true;
        } else {
          // print(
          //     "Hymn ${element.id}, Yoruba Verses Length ${element.versesYoruba.length} & English Verses Length ${element.versesEnglish.length}");
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
          // print("The defaulting hymn number is ${element.id}");
          return false;
        }
      });

      expect(test, true);
    });
  });
}
