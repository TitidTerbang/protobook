import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LibraryScreen extends StatefulWidget {
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  Position? currentPosition;
  String currentLocation = 'Memuat lokasi...';
  bool loading = false;
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};

  // Koordinat tetap untuk perpustakaan pemerintah
  final _perpustakaanPemerintah = LatLng(-7.972218034860499, 112.62250594970973);
  final _gramediaBasukiRahmat = LatLng(-7.98101952219401, 112.63026841544281);
  final _gramediaMog = LatLng(-7.977127454448862, 112.62351333707267);
  final _ummBookstore = LatLng(-7.920581709000431, 112.59421975859856);

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    setState(() {
      loading = true;
    });
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        throw Exception('Location service not enabled');
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permission denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permission denied forever');
      }
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      setState(() {
        currentPosition = position;
        currentLocation =
        "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
        loading = false;
        _addMarker(LatLng(position.latitude, position.longitude), "Lokasi Anda");
        _addMarker(_perpustakaanPemerintah, "Perpustakaan Pemerintah");
        _addMarker(_gramediaBasukiRahmat, "Gramedia Basuki Rahmat Malang");
        _addMarker(_gramediaMog, "Gramedia MOG Malang");
        _addMarker(_ummBookstore, "UMM Bookstore");
        print(currentLocation);
      });
    } catch (e) {
      setState(() {
        loading = false;
        currentLocation = 'Gagal mendapatkan lokasi: ${e.toString()}';
      });
    }
  }

  void _addMarker(LatLng position, String title) {
    _markers.add(
      Marker(
        markerId: MarkerId(title),
        position: position,
        infoWindow: InfoWindow(title: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perpustakaan Terdekat',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // KODE UNTUK CEK LOKASI USER ENJOY MY MEN
            // Text(
            //   currentLocation,
            //   style: GoogleFonts.montserrat(fontSize: 16),
            //   textAlign: TextAlign.center,
            // ),
            Text(
              'Daftar Perpustakaan Terdekat akan ditampilkan di sini.',
              style: GoogleFonts.montserrat(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 300,
              child: currentPosition != null
                  ? GoogleMap(
                      onMapCreated: (controller) {
                        _mapController = controller;
                      },
                      initialCameraPosition: CameraPosition(
                        target: LatLng(currentPosition!.latitude, currentPosition!.longitude),
                        zoom: 15.0,
                      ),
                      markers: _markers,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}

