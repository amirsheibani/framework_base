import 'package:flutter_test/flutter_test.dart';
import 'package:framework_base/framework_base.dart';

void main() {
  group('Pagination', () {
    test('fromJson sets totalRecord', () {
      final p = Pagination.fromJson({'totalRecord': 100});
      expect(p.totalRecord, 100);
    });

    test('fromJsonForReport maps report-style keys', () {
      final p = Pagination.fromJsonForReport({
        'numberOfElements': 10,
        'number': 2,
        'totalElements': 50,
        'totalPages': 5,
      });
      expect(p.pageSize, 10);
      expect(p.page, 2);
      expect(p.totalItems, 50);
      expect(p.total, 5);
    });

    test('toJson includes only length and offset when set', () {
      final p = Pagination(length: 20, offset: 40);
      expect(p.toJson(), {'length': 20, 'offset': 40});
    });

    test('toJson omits null length and offset', () {
      final p = Pagination(page: 1);
      expect(p.toJson(), isEmpty);
    });

    test('toQueryParameters includes set fields with correct keys', () {
      final p = Pagination(
        page: 1,
        pageSize: 10,
        search: 'q',
        minPrice: '100',
        maxPrice: '200',
        stockStatus: true,
        hasPrice: true,
      );
      final q = p.toQueryParameters();
      expect(q['page'], 1);
      expect(q['page_size'], 10);
      expect(q['size'], 10);
      expect(q['search'], 'q');
      expect(q['min_price'], '100');
      expect(q['max_price'], '200');
      expect(q['stock_status'], true);
      expect(q['has_price'], true);
    });

    test('toQueryParameters omits null fields', () {
      final p = Pagination();
      expect(p.toQueryParameters(), isEmpty);
    });
  });
}
