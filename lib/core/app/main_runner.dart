import 'dart:async';

import 'package:flutter/material.dart';
import 'package:note_proviante/core/app/logger.dart';

/// Класс для запуска приложения
mixin MainRunner {
  /// Запись собственных ошибок Flutter
  static void _amendFlutterError() {
    const log = Logger.logFlutterError;

    FlutterError.onError = log;
  }

  /// Запуск кода в собственной зоне логирования
  static T? _runZoned<T>(T Function() body) =>
      Logger.runLogging(() => runZonedGuarded(body, Logger.logZoneError));

  /// Запуск приложения
  static void run({required Future<Widget> Function() appBuilder}) {
    _runZoned(() async {
      _amendFlutterError();
      runApp(await appBuilder.call());
    });
  }
}
