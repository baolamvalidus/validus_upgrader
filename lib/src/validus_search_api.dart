/*
 * Copyright (c) 2018-2021 Larry Aasen. All rights reserved.
 */

import 'dart:async';
import 'dart:convert';
import 'package:version/version.dart';
import 'package:http/http.dart' as http;

class ValidusSearchAPI {

  /// Provide an HTTP Client that can be replaced for mock testing.
  http.Client? client = http.Client();

  bool debugEnabled = false;

  /// Look up by AWS S3 url
  Future<Map?> lookupByAws(String url) async {
    if (debugEnabled) {
      print('upgrader: download: $url');
    }

    try {
      final response = await client!.get(Uri.parse(url));
      if (debugEnabled) {
        print('upgrader: response statusCode: ${response.statusCode}');
      }

      final decodedResults = _decodeResults(response.body);
      return decodedResults;
    } catch (e) {
      print('upgrader: lookupByAws exception: $e');
      return null;
    }
  }


  Map? _decodeResults(String jsonResponse) {
    if (jsonResponse.isNotEmpty) {
      final decodedResults = json.decode(jsonResponse);
      if (decodedResults is Map) {
        final resultCount = decodedResults['resultCount'];
        if (resultCount == 0) {
          if (debugEnabled) {
            print(
                'upgrader.ValidusSearchAPI: results are empty: $decodedResults');
          }
        }
        return decodedResults;
      }
    }
    return null;
  }
}

class ValidusVersionResult {
  /// Return field bundleId from iTunes results.
  static String? bundleId(Map response) {
    String? value;
    try {
      value = response['results'][0]['bundleId'];
    } catch (e) {
      print('upgrader.ValidusVersionResult.bundleId: $e');
    }
    return value;
  }

  /// Return field currency from iTunes results.
  static String? currency(Map response) {
    String? value;
    try {
      value = response['results'][0]['currency'];
    } catch (e) {
      print('upgrader.ValidusVersionResult.currency: $e');
    }
    return value;
  }

  /// Return field description from iTunes results.
  static String? description(Map response) {
    String? value;
    try {
      value = response['results'][0]['description'];
    } catch (e) {
      print('upgrader.ValidusVersionResult.description: $e');
    }
    return value;
  }

  /// Return field min version from Aws config.
  static String? minVersion(Map response) {
    String? value;
    try {
      value = response['minVersion'];
    } catch (e) {
      print('upgrader.ValidusVersionResult.minVersion: $e');
    }
    return value;
  }

  /// Return field version from Aws config.
  static String? version(Map response) {
    String? value;
    try {
      value = response['storeVersion'];
    } catch (e) {
      print('upgrader.ValidusVersionResult.storeVersion: $e');
    }
    return value;
  }

  /// Return field version from Aws config.
  static String? appStoreListingURL(Map response) {
    String? value;
    try {
      value = response['appStoreUrl'];
    } catch (e) {
      print('upgrader.ValidusVersionResult.appStoreUrl: $e');
    }
    return value;
  }
}
