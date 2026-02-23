import 'package:framework_base/packages/framework_core/lib/core_framework.dart';
import 'package:framework_base/packages/framework_storage/lib/storage_framework.dart';
import 'package:injectable/injectable.dart';
import 'package:skeleton/features/main_layout/presentation/features/my_ip/data/data_sources/ip_data_source.dart';
import 'package:skeleton/features/main_layout/presentation/features/my_ip/data/mappers/ip_mapper.dart';
import 'package:skeleton/features/main_layout/presentation/features/my_ip/data/models/ip_model.dart';
import 'package:skeleton/features/main_layout/presentation/features/my_ip/domain/entities/ip_entity.dart';
import 'package:skeleton/features/main_layout/presentation/features/my_ip/domain/repositories/ip_repository.dart';

@Injectable(as: IpRepository)
class IpRepositoryImpl extends IpRepository {
  final IpDataSource _ipDataSource;
  final UnifiedStorage _storage;

  IpRepositoryImpl(this._ipDataSource, this._storage);

  static const StorageKey _cacheKey = StorageKey(
    namespace: 'my_ip',
    key: 'last_ip',
    target: StorageTarget.secure,
  );

  @override
  Future<Result<IpEntity>> getIp() async {
    try {
      final result = await _ipDataSource.getIp();
      final data = result.data;
      if (data != null) {
        await _storage.setJson(_cacheKey, data.toJson());
      }
      return Success(
        data: data != null ? IpMapperImpl().entityMapper(data) : null,
        message: result.message,
        meta: result.meta,
      );
    } catch (e, stackTrace) {
      try {
        final cached = await _storage.getJson(_cacheKey);
        if (cached != null) {
          final model = IpModel.fromJson(cached);
          return Success(
            data: IpMapperImpl().entityMapper(model),
            message: 'loaded_from_cache',
          );
        }
      } catch (_) {}
      return e.toResult<IpEntity>(stackTrace);
    }
  }
}
