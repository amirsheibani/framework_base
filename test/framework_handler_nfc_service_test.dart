import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nfc_manager/nfc_manager.dart';

import 'package:framework_base/packages/framework_service/lib/src/nfc_service_handler.dart';

class _MockNfcManager extends Mock implements NfcManager {}

void main() {
  test('NFCService emits availability and discovered tag', () async {
    final nfcManager = _MockNfcManager();

    final tag = NfcTag(data: const <String, dynamic>{});

    void Function(NfcTag)? onDiscovered;

    when(() => nfcManager.checkAvailability())
        .thenAnswer((_) async => NfcAvailability.enabled);

    when(
      () => nfcManager.startSession(
        onDiscovered: any(named: 'onDiscovered'),
        pollingOptions: any(named: 'pollingOptions'),
      ),
    ).thenAnswer((invocation) async {
      onDiscovered = invocation.namedArguments[#onDiscovered] as void Function(NfcTag);
    });

    when(() => nfcManager.stopSession()).thenAnswer((_) async {});

    final service = NFCService(nfcManager: nfcManager);

    final emitted = <(NfcAvailability, NfcTag)>[];
    final sub = service.nfcStatus.listen(emitted.add);

    await service.startSession();

    expect(onDiscovered, isNotNull);
    onDiscovered!(tag);

    await Future<void>.delayed(const Duration(milliseconds: 10));

    expect(emitted, hasLength(1));
    expect(emitted.first.$1, NfcAvailability.enabled);
    expect(emitted.first.$2, tag);

    verify(() => nfcManager.stopSession()).called(1);

    await sub.cancel();
    service.dispose();
  });
}
