export 'internet_service_stub.dart'
    if (dart.library.html) 'internet_service_web.dart'
    if (dart.library.io) 'internet_service_mobile.dart';
    