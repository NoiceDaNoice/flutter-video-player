import 'dart:convert';
import 'package:equatable/equatable.dart';

ResponseModel responseModelFromJson(String str) =>
    ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel extends Equatable {
  final int? resultCount;
  final List<Result>? results;

  ResponseModel({
    this.resultCount,
    this.results,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        resultCount: json["resultCount"] as int?,
        results: json["results"] == null
            ? null
            : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resultCount": resultCount,
        "results": results?.map((x) => x.toJson()).toList(),
      };

  @override
  List<Object?> get props => [resultCount, results];
}

class Result extends Equatable {
  final String? wrapperType;
  final String? kind;
  final int? artistId;
  final int? collectionId;
  final int? trackId;
  final String? artistName;
  final String? collectionName;
  final String? trackName;
  final String? collectionCensoredName;
  final String? trackCensoredName;
  final String? artistViewUrl;
  final String? collectionViewUrl;
  final String? trackViewUrl;
  final String? previewUrl;
  final String? artworkUrl30;
  final String? artworkUrl60;
  final String? artworkUrl100;
  final double? collectionPrice;
  final double? trackPrice;
  final DateTime? releaseDate;
  final String? collectionExplicitness;
  final String? trackExplicitness;
  final int? discCount;
  final int? discNumber;
  final int? trackCount;
  final int? trackNumber;
  final int? trackTimeMillis;
  final String? country;
  final String? currency;
  final String? primaryGenreName;

  Result({
    this.wrapperType,
    this.kind,
    this.artistId,
    this.collectionId,
    this.trackId,
    this.artistName,
    this.collectionName,
    this.trackName,
    this.collectionCensoredName,
    this.trackCensoredName,
    this.artistViewUrl,
    this.collectionViewUrl,
    this.trackViewUrl,
    this.previewUrl,
    this.artworkUrl30,
    this.artworkUrl60,
    this.artworkUrl100,
    this.collectionPrice,
    this.trackPrice,
    this.releaseDate,
    this.collectionExplicitness,
    this.trackExplicitness,
    this.discCount,
    this.discNumber,
    this.trackCount,
    this.trackNumber,
    this.trackTimeMillis,
    this.country,
    this.currency,
    this.primaryGenreName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        wrapperType: json["wrapperType"] as String?,
        kind: json["kind"] as String?,
        artistId: json["artistId"] as int?,
        collectionId: json["collectionId"] as int?,
        trackId: json["trackId"] as int?,
        artistName: json["artistName"] as String?,
        collectionName: json["collectionName"] as String?,
        trackName: json["trackName"] as String?,
        collectionCensoredName: json["collectionCensoredName"] as String?,
        trackCensoredName: json["trackCensoredName"] as String?,
        artistViewUrl: json["artistViewUrl"] as String?,
        collectionViewUrl: json["collectionViewUrl"] as String?,
        trackViewUrl: json["trackViewUrl"] as String?,
        previewUrl: json["previewUrl"] as String?,
        artworkUrl30: json["artworkUrl30"] as String?,
        artworkUrl60: json["artworkUrl60"] as String?,
        artworkUrl100: json["artworkUrl100"] as String?,
        collectionPrice: json["collectionPrice"]?.toDouble(),
        trackPrice: json["trackPrice"]?.toDouble(),
        releaseDate: json["releaseDate"] == null
            ? null
            : DateTime.parse(json["releaseDate"]),
        collectionExplicitness: json["collectionExplicitness"] as String?,
        trackExplicitness: json["trackExplicitness"] as String?,
        discCount: json["discCount"] as int?,
        discNumber: json["discNumber"] as int?,
        trackCount: json["trackCount"] as int?,
        trackNumber: json["trackNumber"] as int?,
        trackTimeMillis: json["trackTimeMillis"] as int?,
        country: json["country"] as String?,
        currency: json["currency"] as String?,
        primaryGenreName: json["primaryGenreName"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "wrapperType": wrapperType,
        "kind": kind,
        "artistId": artistId,
        "collectionId": collectionId,
        "trackId": trackId,
        "artistName": artistName,
        "collectionName": collectionName,
        "trackName": trackName,
        "collectionCensoredName": collectionCensoredName,
        "trackCensoredName": trackCensoredName,
        "artistViewUrl": artistViewUrl,
        "collectionViewUrl": collectionViewUrl,
        "trackViewUrl": trackViewUrl,
        "previewUrl": previewUrl,
        "artworkUrl30": artworkUrl30,
        "artworkUrl60": artworkUrl60,
        "artworkUrl100": artworkUrl100,
        "collectionPrice": collectionPrice,
        "trackPrice": trackPrice,
        "releaseDate": releaseDate?.toIso8601String(),
        "collectionExplicitness": collectionExplicitness,
        "trackExplicitness": trackExplicitness,
        "discCount": discCount,
        "discNumber": discNumber,
        "trackCount": trackCount,
        "trackNumber": trackNumber,
        "trackTimeMillis": trackTimeMillis,
        "country": country,
        "currency": currency,
        "primaryGenreName": primaryGenreName,
      };

  @override
  List<Object?> get props => [
        wrapperType,
        kind,
        artistId,
        collectionId,
        trackId,
        artistName,
        collectionName,
        trackName,
        collectionCensoredName,
        trackCensoredName,
        artistViewUrl,
        collectionViewUrl,
        trackViewUrl,
        previewUrl,
        artworkUrl30,
        artworkUrl60,
        artworkUrl100,
        collectionPrice,
        trackPrice,
        releaseDate,
        collectionExplicitness,
        trackExplicitness,
        discCount,
        discNumber,
        trackCount,
        trackNumber,
        trackTimeMillis,
        country,
        currency,
        primaryGenreName,
      ];
}
