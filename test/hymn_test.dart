// ignore_for_file: deprecated_member_use, depend_on_referenced_packages

import 'package:test/test.dart';
import 'package:church/providers/hymn_book_provider.dart';
import 'package:church/model/hymn.dart';
import 'package:collection/equality.dart';

void main() {
  group('TESTING HYMN DATA INTEGRITY ', () {
    List<Hymn> testHymnList = HymnBookProvider().hymnList;
    List<Hymn> hymnListFalse =
        testHymnList.where((hymn) => hymn.isChorus == false).toList();
    List<Hymn> hymnListTrue =
        testHymnList.where((hymn) => hymn.isChorus == true).toList();

    test('testing for number of hymn', () {
      int hymnnumber = testHymnList.length;
      expect(hymnnumber, 500);
    });

    test('Testing the total number of true & false equals to 500', () {
      int totalnumber = hymnListTrue.length + hymnListFalse.length;
      expect(totalnumber, 500);
    });

    test('Testing integrity of false chorus Hymn', () {
      bool value = hymnListFalse
          .every((hymn) => const IterableEquality().equals(hymn.chorus, ['']));
      expect(value, true);
    });

    test('Testing Integrity of true chorus Hymn', () {
      bool value = hymnListTrue
          .every((hymn) => !const IterableEquality().equals(hymn.chorus, ['']));
      expect(value, true);
    });
    test('Testing the full HymnList', () {
      bool value = testHymnList.every((hymn) {
        if ((hymn.isChorus == true &&
                !const IterableEquality().equals(hymn.chorus, [''])) ||
            (hymn.isChorus == false &&
                const IterableEquality().equals(hymn.chorus, ['']))) {
          return true;
        } else {
          return false;
        }
      });

      expect(value, true);
    });
    test('checking for the integrity of hymn number arrangement', () {
      List<int> number = List.generate(500, (index) {
        int value = index + 1;
        return value;
      });

      List<int> hymnNumber = List.generate(testHymnList.length, (index) {
        int value = int.parse(testHymnList[index].id);
        return value;
      });

      // print(number.length);
      // print(number[0]);
      // print(number[499]);

      expect(const IterableEquality().equals(number, hymnNumber), true);
    });
  });
}
