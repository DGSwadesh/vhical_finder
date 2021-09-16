// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class EsriPage extends StatefulWidget {
//   static const String route = 'esri';

//   @override
//   _EsriPageState createState() => _EsriPageState();
// }

// class _EsriPageState extends State<EsriPage> {
//   late MapController mapController;

//   @override
//   void initState() {
//     super.initState();

//     mapController = MapController();
//   }

//   LatLng? _offsetToCrs(Crs crs, Offset offset, BoxConstraints constraints,
//       [LatLng? initCenter, double? initZoom]) {
//     var center = mapController.ready ? mapController.center : initCenter;
//     var zoom = mapController.ready ? mapController.zoom : initZoom;

//     if (center == null || zoom == null) {
//       return null;
//     }

//     // Get the widget's offset
//     var width = constraints.maxWidth;
//     var height = constraints.maxHeight;

//     // convert the point to global coordinates
//     var localPoint = CustomPoint(offset.dx, offset.dy);
//     var localPointCenterDistance =
//         CustomPoint((width / 2) - localPoint.x, (height / 2) - localPoint.y);
//     var mapCenter = crs.latLngToPoint(center, zoom);
//     var point = mapCenter - localPointCenterDistance;
//     return crs.pointToLatLng(point, zoom);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Esri')),
//       drawer: buildDrawer(context, EsriPage.route),
//       body: Padding(
//         padding: EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
//               child: Text('Esri'),
//             ),
//             Flexible(
//               child: LayoutBuilder(
//                 builder: (BuildContext context, BoxConstraints constraints) {
//                   print(
//                     _offsetToCrs(
//                       const Epsg3857(),
//                       Offset(12.0, 12.0),
//                       constraints,
//                       // optional center should be same as MapOptions' center
//                       // if not provided then _offsetToCrs will return null at very first build because mapController isn't ready
//                       LatLng(45.5231, -122.6765),
//                       // optional zoom should be same as MapOptions' zoom
//                       // if not provided then _offsetToCrs will return null at very first build because mapController isn't ready
//                       13.0,
//                     ),
//                   );

//                   return FlutterMap(
//                     mapController: mapController,
//                     options: MapOptions(
//                       crs: const Epsg3857(),
//                       center: LatLng(45.5231, -122.6765),
//                       zoom: 13.0,
//                       onTap: (l) {
//                         print(l);

//                         print(_offsetToCrs(
//                             const Epsg3857(), Offset(12.0, 12.0), constraints));
//                       },
//                     ),
//                     layers: [
//                       TileLayerOptions(
//                         urlTemplate:
//                             'https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

