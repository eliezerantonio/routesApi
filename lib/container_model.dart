// To parse required this JSON data, do
//
//     final route = routeFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

Route routeFromJson(String str) => Route.fromJson(json.decode(str));

String routeToJson(Route data) => json.encode(data.toJson());

class Route {
  Route({
    required this.routes,
  });

  List<RouteElement> routes;

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      routes: List<RouteElement>.from(
        json["Routes"].map(
          (x) => RouteElement.fromJson(x),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        "Routes": List<dynamic>.from(routes.map((x) => x.toJson())),
      };
}

class RouteElement {
  RouteElement({
    required this.id,
    required this.routeName,
    required this.installationPoints,
    required this.requestId,
    required this.mainRouteGuid,
    required this.code,
    required this.routeCode,
    required this.routeColor,
    required this.routeColorCode,
    required this.typeWaste,
    required this.flgDynamic,
    required this.flgHighVolume,
    required this.flgActive,
    required this.flgDeleted,
  });

  String id;
  String routeName;
  List<InstallationPoint> installationPoints;
  String requestId;
  String mainRouteGuid;
  String code;
  String routeCode;
  RouteColor? routeColor;
  RouteColorCode? routeColorCode;
  TypeWaste? typeWaste;
  bool flgDynamic;
  FlgHighVolume? flgHighVolume;
  bool flgActive;
  bool flgDeleted;

  factory RouteElement.fromJson(Map<String, dynamic> json) => RouteElement(
        id: json["ID"],
        routeName: json["RouteName"],
        installationPoints: List<InstallationPoint>.from(
            json["InstallationPoints"]
                .map((x) => InstallationPoint.fromJson(x))),
        requestId: json["RequestId"] ?? '',
        mainRouteGuid: json["MainRouteGuid"] ?? '',
        code: json["Code"],
        routeCode: json["RouteCode"],
        routeColor: json["RouteColor"] == null
            ? RouteColor.BLUE
            : routeColorValues.map[json["RouteColor"]],
        routeColorCode: json["RouteColorCode"] == null
            ? RouteColorCode.E70000
            : routeColorCodeValues.map[json["RouteColorCode"]],
        typeWaste: json["TypeWaste"] == null
            ? TypeWaste.PAPEL
            : typeWasteValues.map[json["TypeWaste"]],
        flgDynamic: json["FlgDynamic"],
        flgHighVolume: flgHighVolumeValues.map[json["FlgHighVolume"]],
        flgActive: json["FlgActive"],
        flgDeleted: json["FlgDeleted"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "RouteName": routeName,
        "InstallationPoints":
            List<dynamic>.from(installationPoints.map((x) => x.toJson())),
        "RequestId": requestId ?? '',
        "MainRouteGuid": mainRouteGuid ?? '',
        "Code": code,
        "RouteCode": routeCode,
        "RouteColor": routeColor == null
            ? RouteColor.BROWN
            : routeColorValues.reverse![routeColor],
        "RouteColorCode": routeColorCode == null
            ? RouteColorCode.E70000
            : routeColorCodeValues.reverse![routeColorCode],
        "TypeWaste": typeWaste == null
            ? TypeWaste.INDIFERENCIADO
            : typeWasteValues.reverse![typeWaste],
        "FlgDynamic": flgDynamic,
        "FlgHighVolume": flgHighVolumeValues.reverse![flgHighVolume],
        "FlgActive": flgActive,
        "FlgDeleted": flgDeleted,
      };
}

enum FlgHighVolume { F }

final flgHighVolumeValues = EnumValues({"f": FlgHighVolume.F});

class InstallationPoint {
  InstallationPoint({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.localNumber,
    required this.mainRouteGuid,
    required this.orderInRoute,
    required this.pointType,
    required this.streetLocal,
    required this.typeWaste,
    required this.colorCode,
    required this.containers,
    required this.drvObservations,
    required this.driverObservations,
  });

  String? id;
  String latitude;
  String longitude;
  String localNumber;
  String mainRouteGuid;
  String orderInRoute;
  PointType? pointType;
  String? streetLocal;
  TypeWaste? typeWaste;
  RouteColorCode? colorCode;
  List<ContainerModel> containers;
  String drvObservations;
  String driverObservations;

  factory InstallationPoint.fromJson(Map<String, dynamic> json) =>
      InstallationPoint(
        id: json["ID"] ?? '',
        latitude: json["Latitude"] ?? '',
        longitude: json["Longitude"] ?? '',
        localNumber: json["LocalNumber"] ?? '',
        mainRouteGuid: json["MainRouteGuid"] ?? '',
        orderInRoute: json["OrderInRoute"],
        pointType: pointTypeValues.map[json["PointType"]],
        streetLocal: json["StreetLocal"] ?? '',
        typeWaste: json["TypeWaste"] == null
            ? TypeWaste.EMBALAGENS
            : typeWasteValues.map[json["TypeWaste"]],
        colorCode: json["ColorCode"] == null
            ? RouteColorCode.FF8_C00
            : routeColorCodeValues.map[json["ColorCode"]],
        containers: List<ContainerModel>.from(
            json["Containers"].map((x) => ContainerModel.fromJson(x))),
        drvObservations: json["DrvObservations"] ?? '',
        driverObservations: json["driver_observations"] ?? '',
      );

  String getWestType(TypeWaste value) {
    switch (value) {
      case TypeWaste.EMBALAGENS:
        return 'Embalagens';

      case TypeWaste.INDIFERENCIADO:
        return 'Indiferenciado';

      case TypeWaste.INDIFERENCIADOS:
        return 'Indiferenciados';

      case TypeWaste.LEOS_ALIMENTARES_USADOS:
        return 'Óleos Alimentares Usados';
      case TypeWaste.ORGNICOS:
        return 'Orgânicos';
      case TypeWaste.PAPEL:
        return 'Papel';
      case TypeWaste.PAPEL_CARTO:
        return 'Papel Carto';
      case TypeWaste.PLSTICO_METAL:
        return 'PLSTICO_METAL';
      case TypeWaste.VIDRO:
        return 'Vidro';

      default:
        return '';
    }
  }

  Map<String, dynamic> toJson() => {
        "ID": id ?? null,
        "Latitude": latitude ?? null,
        "Longitude": longitude ?? null,
        "LocalNumber": localNumber ?? null,
        "MainRouteGuid": mainRouteGuid ?? null,
        "OrderInRoute": orderInRoute,
        "PointType": pointTypeValues.reverse![pointType],
        "StreetLocal": streetLocal ?? null,
        "TypeWaste":
            typeWaste == null ? null : typeWasteValues.reverse![typeWaste],
        "ColorCode":
            colorCode == null ? null : routeColorCodeValues.reverse![colorCode],
        "Containers": List<dynamic>.from(containers.map((x) => x.toJson())),
        "DrvObservations": drvObservations ?? null,
        "driver_observations": driverObservations ?? null,
      };
}

enum RouteColorCode {
  THE_009000,
  FFFF1_A,
  THE_0000_C3,
  THE_7_C7_C7_C,
  FF0000,
  THE_934_A00,
  E70000,
  FF8_C00
}



final routeColorCodeValues = EnumValues({
  "#e70000": RouteColorCode.E70000,
  "#FF0000": RouteColorCode.FF0000,
  "#ff8c00": RouteColorCode.FF8_C00,
  "#ffff1a": RouteColorCode.FFFF1_A,
  "#0000c3": RouteColorCode.THE_0000_C3,
  "#009000": RouteColorCode.THE_009000,
  "#7c7c7c": RouteColorCode.THE_7_C7_C7_C,
  "#934a00": RouteColorCode.THE_934_A00
});

class ContainerModel {
  ContainerModel({
    required this.id,
    required this.inventoryNumber,
    required this.localNumber,
    required this.model,
    required this.rfidHex,
    required this.typeWaste,
    required this.wasteTypeId,
    required this.wasteTypeColor,
    required this.wasteTypeColorName,
  });

  String id;
  String inventoryNumber;
  String localNumber;
  Model? model;
  String rfidHex;
  TypeWaste? typeWaste;
  String wasteTypeId;
  RouteColorCode? wasteTypeColor;
  WasteTypeColorName? wasteTypeColorName;

  factory ContainerModel.fromJson(Map<String, dynamic> json) => ContainerModel(
        id: json["ID"] ?? '',
        inventoryNumber: json["InventoryNumber"] ?? '',
        localNumber: json["LocalNumber"] ?? '',
        model: json["Model"] == null
            ? Model.CYCLEA
            : modelValues.map[json["Model"]],
        rfidHex: json["RFID_HEX"] ?? '',
        typeWaste: json["TypeWaste"] == null
            ? TypeWaste.PAPEL
            : typeWasteValues.map[json["TypeWaste"]],
        wasteTypeId: json["WasteTypeId"] ?? '',
        wasteTypeColor: json["WasteTypeColor"] == null
            ? RouteColorCode.FF0000
            : routeColorCodeValues.map[json["WasteTypeColor"]],
        wasteTypeColorName: json["WasteTypeColorName"] == null
            ? WasteTypeColorName.AZUL
            : wasteTypeColorNameValues.map[json["WasteTypeColorName"]],
      );

  String getWestType(TypeWaste value) {
    switch (value) {
      case TypeWaste.EMBALAGENS:
        return 'Embalagens';

      case TypeWaste.INDIFERENCIADO:
        return 'Indiferenciado';

      case TypeWaste.INDIFERENCIADOS:
        return 'Indiferenciados';

      case TypeWaste.LEOS_ALIMENTARES_USADOS:
        return 'Óleos Alimentares Usados';
      case TypeWaste.ORGNICOS:
        return 'Orgânicos';
      case TypeWaste.PAPEL:
        return 'Papel';
      case TypeWaste.PAPEL_CARTO:
        return 'Papel Carto';
      case TypeWaste.PLSTICO_METAL:
        return 'PLSTICO_METAL';
      case TypeWaste.VIDRO:
        return 'Vidro';

      default:
        return '';
    }
  }

  String getColorName(WasteTypeColorName value) {
    switch (value) {
      case WasteTypeColorName.AMARELO:
        return 'Amarelo';

      case WasteTypeColorName.AZUL:
        return 'Azul';

      case WasteTypeColorName.CINZENTO:
        return 'Cinzento';

      case WasteTypeColorName.LARANJA:
        return 'Laranja';

      case WasteTypeColorName.VERDE:
        return 'Verde';

      case WasteTypeColorName.VERDE_PINHO:
        return 'Verde Pinho';

      case WasteTypeColorName.VERMELHO:
        return 'Vermelho';

      default:
        return '';
    }
  }

  Map<String, dynamic> toJson() => {
        "ID": id ?? null,
        "InventoryNumber": inventoryNumber ?? null,
        "LocalNumber": localNumber ?? null,
        "Model": model == null ? null : modelValues.reverse![model],
        "RFID_HEX": rfidHex ?? null,
        "TypeWaste":
            typeWaste == null ? null : typeWasteValues.reverse![typeWaste],
        "WasteTypeId": wasteTypeId ?? null,
        "WasteTypeColor": wasteTypeColor == null
            ? null
            : routeColorCodeValues.reverse![wasteTypeColor],
        "WasteTypeColorName": wasteTypeColorName == null
            ? null
            : wasteTypeColorNameValues.reverse![wasteTypeColorName],
      };
}

enum Model {
  IGLOO,
  CYCLEA,
  IGLOO_TESTE,
  SUBTERRNEO_5,
  SUPERFICIE_METLICO,
  OLEO_METLICO,
  MOLOK,
  MODELO_PREMIUM
}

final modelValues = EnumValues({
  "Cyclea": Model.CYCLEA,
  "Igloo": Model.IGLOO,
  "Igloo Teste": Model.IGLOO_TESTE,
  "ModeloPremium": Model.MODELO_PREMIUM,
  "Molok": Model.MOLOK,
  "Oleão (metálico)": Model.OLEO_METLICO,
  "Subterrâneo 5": Model.SUBTERRNEO_5,
  "Superficie (metálico)": Model.SUPERFICIE_METLICO
});

enum TypeWaste {
  VIDRO,
  PLSTICO_METAL,
  PAPEL_CARTO,
  PAPEL,
  INDIFERENCIADOS,
  EMBALAGENS,
  INDIFERENCIADO,
  PILHAS,
  ORGNICOS,
  LEOS_ALIMENTARES_USADOS
}

final typeWasteValues = EnumValues({
  "Embalagens": TypeWaste.EMBALAGENS,
  "Indiferenciado": TypeWaste.INDIFERENCIADO,
  "Indiferenciados": TypeWaste.INDIFERENCIADOS,
  "Óleos Alimentares Usados": TypeWaste.LEOS_ALIMENTARES_USADOS,
  "Orgânicos": TypeWaste.ORGNICOS,
  "Papel": TypeWaste.PAPEL,
  "Papel/Cartão": TypeWaste.PAPEL_CARTO,
  "Pilhas": TypeWaste.PILHAS,
  "Plástico/Metal": TypeWaste.PLSTICO_METAL,
  "Vidro": TypeWaste.VIDRO
});

enum WasteTypeColorName {
  VERDE,
  AMARELO,
  CINZENTO,
  AZUL,
  VERMELHO,
  VERDE_PINHO,
  LARANJA
}

final wasteTypeColorNameValues = EnumValues({
  "Amarelo": WasteTypeColorName.AMARELO,
  "Azul": WasteTypeColorName.AZUL,
  "Cinzento": WasteTypeColorName.CINZENTO,
  "Laranja": WasteTypeColorName.LARANJA,
  "Verde": WasteTypeColorName.VERDE,
  "Verde Pinho": WasteTypeColorName.VERDE_PINHO,
  "Vermelho": WasteTypeColorName.VERMELHO
});

enum PointType { PONTO_DE_INSTALAO }

final pointTypeValues =
    EnumValues({"Ponto de Instalação": PointType.PONTO_DE_INSTALAO});

enum RouteColor { GREEN, YELLOW, BLUE, GREY, OTHER, BROWN }

final routeColorValues = EnumValues({
  "blue": RouteColor.BLUE,
  "brown": RouteColor.BROWN,
  "green": RouteColor.GREEN,
  "grey": RouteColor.GREY,
  "other": RouteColor.OTHER,
  "yellow": RouteColor.YELLOW
});

class EnumValues<T> {
  late Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
