import 'package:skeleton/features/main_layout/presentation/features/my_ip/data/models/ip_model.dart';
import 'package:skeleton/features/main_layout/presentation/features/my_ip/domain/entities/ip_entity.dart';
import 'package:framework_base/framework_base.dart';
part 'ip_mapper.mapper.dart';

@Mapper()
abstract class IpMapper{

  @Mapping(source: 'ip', target: 'country')
  @Mapping(source: 'country', target: 'ip')
  IpEntity entityMapper(IpModel value);

  @Mapping(target: 'country',condition: 'value != null',expression: 'value.toUpperCase()')
  IpModel modelMapper(IpEntity value);
}
