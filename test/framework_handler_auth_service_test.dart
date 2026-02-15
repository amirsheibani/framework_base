import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:framework_base/packages/framework_handler/lib/src/service/supabase_auth_service_handler.dart';

class _MockSupabaseClient extends Mock implements SupabaseClient {}

class _MockGoTrueClient extends Mock implements GoTrueClient {}

void main() {
  test('AuthService.isLoggedIn is false when currentUser is null', () {
    final supabase = _MockSupabaseClient();
    final auth = _MockGoTrueClient();

    when(() => supabase.auth).thenReturn(auth);
    when(() => auth.currentUser).thenReturn(null);

    final service = AuthService(supabaseClient: supabase);

    expect(service.currentUser, isNull);
    expect(service.isLoggedIn, isFalse);
  });

  test('AuthService.isLoggedIn is true when currentUser is not null', () {
    final supabase = _MockSupabaseClient();
    final auth = _MockGoTrueClient();

    final user = User(
      id: 'id',
      appMetadata: const {},
      userMetadata: const {},
      aud: 'authenticated',
      createdAt: DateTime.fromMillisecondsSinceEpoch(0).toIso8601String(),
    );

    when(() => supabase.auth).thenReturn(auth);
    when(() => auth.currentUser).thenReturn(user);

    final service = AuthService(supabaseClient: supabase);

    expect(service.currentUser, isNotNull);
    expect(service.isLoggedIn, isTrue);
  });
}
