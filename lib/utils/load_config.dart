import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:github_trending/core/src/models/configuration.dart';

Future<Configuration> loadConfig() async {
  String configStr = await rootBundle.loadString('assets/config/config.json');
  Map config = json.decode(configStr);

  return new Configuration.fromJson(config);
}
