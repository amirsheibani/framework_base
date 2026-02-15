import 'package:flutter_test/flutter_test.dart';
import 'package:framework_base/framework_base.dart';

void main() {
  group('DevEnvironment', () {
    test('url returns baseUrl when apiVersion is empty', () {
      final env = DevEnvironment(
        baseUrl: 'https://api.example.com',
        apiVersion: '',
        mapToken: 't',
        appId: 'a',
        showRuntimeLog: false,
        showChucker: false,
        showPrettyLog: false,
        supabaseUrl: 'https://s.com',
        supabaseAnonKey: 'k',
      );
      expect(env.url, 'https://api.example.com');
    });

    test('url returns baseUrl/gateway/apiVersion/ when apiVersion is set', () {
      final env = DevEnvironment(
        baseUrl: 'https://api.example.com',
        apiVersion: 'v1',
        mapToken: 't',
        appId: 'a',
        showRuntimeLog: false,
        showChucker: false,
        showPrettyLog: false,
        supabaseUrl: 'https://s.com',
        supabaseAnonKey: 'k',
      );
      expect(env.url, 'https://api.example.com/gateway/v1/');
    });

    test('getters return passed values', () {
      final env = DevEnvironment(
        baseUrl: 'https://api.example.com',
        apiVersion: 'v1',
        mapToken: 'mt',
        appId: 'myapp',
        showRuntimeLog: true,
        showChucker: true,
        showPrettyLog: true,
        supabaseUrl: 'https://supabase.co',
        supabaseAnonKey: 'key',
      );
      expect(env.baseUrl, 'https://api.example.com');
      expect(env.apiVersion, 'v1');
      expect(env.mapToken, 'mt');
      expect(env.appId, 'myapp');
      expect(env.showRuntimeLog, true);
      expect(env.showChucker, true);
      expect(env.showPrettyLog, true);
      expect(env.supabaseUrl, 'https://supabase.co');
      expect(env.supabaseAnonKey, 'key');
    });
  });

  group('StageEnvironment', () {
    test('url builds gateway path like Dev', () {
      final env = StageEnvironment(
        baseUrl: 'https://stage.example.com',
        apiVersion: 'v2',
        mapToken: 't',
        appId: 'a',
        showRuntimeLog: false,
        showChucker: false,
        showPrettyLog: false,
        supabaseUrl: 'https://s.com',
        supabaseAnonKey: 'k',
      );
      expect(env.url, 'https://stage.example.com/gateway/v2/');
    });
  });

  group('ProdEnvironment', () {
    test('url builds gateway path', () {
      final env = ProdEnvironment(
        baseUrl: 'https://prod.example.com',
        apiVersion: 'v1',
        mapToken: 't',
        appId: 'a',
        showRuntimeLog: false,
        showChucker: false,
        showPrettyLog: false,
        supabaseUrl: 'https://s.com',
        supabaseAnonKey: 'k',
      );
      expect(env.url, 'https://prod.example.com/gateway/v1/');
    });
  });
}
