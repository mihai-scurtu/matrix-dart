import 'package:unittest/unittest.dart';
import 'package:matrix/matrix.dart';

void main() {
  test('Test default constructor', () {
    Matrix<int> matrix = new Matrix<int>(5, 4);

    expect(matrix.rows, equals(5));
    expect(matrix.columns, equals(4));
  });

  test('Test changing rows and columns', () {
    Matrix<int> matrix = new Matrix<int>(0, 0);

    matrix.rows = 5;
    expect(matrix.rows, equals(5));

    matrix.columns = 4;
    expect(matrix.columns, equals(4));

    // actual elements get allocated
    expect(matrix.get(4, 3), isNull);
  });

  test('Test setting and getting data', () {
    Matrix<int> matrix = new Matrix<int>(2, 2);

    matrix.set(0, 0, 1);
    matrix.set(0, 1, 2);
    matrix.set(1, 0, 3);
    matrix.set(1, 1, 4);

    expect(matrix.get(0, 0), equals(1));
    expect(matrix.get(0, 1), equals(2));
    expect(matrix.get(1, 0), equals(3));
    expect(matrix.get(1, 1), equals(4));
  });

  test('Test forEach', () {
    Matrix<int> matrix = new Matrix<int>(2, 2);

    matrix.set(0, 0, 0);
    matrix.set(0, 1, 1);
    matrix.set(1, 0, 2);
    matrix.set(1, 1, 3);

    int rows = 0;

    matrix.forEach((value, i, j) => matrix.set(i, j, value + 1), (row) => rows += 1);

    expect(rows, equals(2));

    expect(matrix.get(0, 0), equals(1));
    expect(matrix.get(0, 1), equals(2));
    expect(matrix.get(1, 0), equals(3));
    expect(matrix.get(1, 1), equals(4));
  });

  test('Test building from array', () {
    Matrix<int> matrix = new Matrix<int>.fromArray([[1], [3, 4]]);

    expect(matrix.get(0, 0), equals(1));
    expect(matrix.get(0, 1), isNull);
    expect(matrix.get(1, 0), equals(3));
    expect(matrix.get(1, 1), equals(4));
  });

//  test('Out cannot allocate out of bounds', () {
//    Matrix<String> matrix = new Matrix<String>(3, 4);
//
//    try {
//      expect(matrix.set(-1, 4, 'foo'), equals(1));
//    } catch(e) {};
//  });
}
