import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:nfc_manager/nfc_manager.dart';

@module
abstract class NFCServiceModule {
  @lazySingleton
  NFCService provideNFCService() => NFCService();
}

class NFCService {
  final NfcManager nfcManager;
  final _controller = StreamController<(NfcAvailability,NfcTag)>.broadcast();

  Stream<(NfcAvailability,NfcTag)> get nfcStatus => _controller.stream;

  NFCService({NfcManager? nfcManager}) : nfcManager = nfcManager ?? NfcManager.instance;

  Future<void> startSession({Set<NfcPollingOption>? pollingOptions}) async {
    final availability = await nfcManager.checkAvailability();
    await nfcManager.startSession(
      onDiscovered: (tag) {
        _controller.add((availability, tag));
        nfcManager.stopSession();
      },
      pollingOptions: pollingOptions ??
          {
            NfcPollingOption.iso14443,
            NfcPollingOption.iso15693,
            NfcPollingOption.iso18092,
          },
    );
  }

  Future<void> stopSession() async {
    await nfcManager.stopSession();
  }

  void dispose() {
    _controller.close();
  }
}
