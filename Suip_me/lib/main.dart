import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suip_me/sharedData.dart';

import 'home.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unsplash Photos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

// class PhotosScreen extends StatefulWidget {
//   @override
//   _PhotosScreenState createState() => _PhotosScreenState();
// }
//
// class _PhotosScreenState extends State<PhotosScreen> {
//   List<Photo> _photos = [];
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchRandomPhoto();
//   }
//
//   Future<void> _fetchRandomPhoto() async {
//     setState(() {
//       _isLoading = true;
//     });
//     final photo = await UnsplashApi.fetchRandomPhoto();
//     setState(() {
//       _photos = [photo];
//       _isLoading = false;
//     });
//   }
//
//   Future<void> _searchPhotos(String query) async {
//     setState(() {
//       _isLoading = true;
//     });
//     final photos = await UnsplashApi.searchPhotos(query);
//     setState(() {
//       _photos = photos;
//       _isLoading = false;
//     });
//   }
//
//   Future<void> _savePhoto(Photo photo) async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedPhotos = prefs.getStringList('savedPhotos') ?? [];
//     savedPhotos.add(photo.id);
//     await prefs.setStringList('savedPhotos', savedPhotos);
//   }
//
//   // Future<List<Photo>> _loadSavedPhotos() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   final savedPhotos = prefs.getStringList('savedPhotos') ?? [];
//   //   final photos = <Photo>[];
//   //   for (final id in savedPhotos) {
//   //     final photo = await UnsplashApi.fetchPhotoById(id);
//   //     if (photo != null) {
//   //       photos.add(photo);
//   //     }
//   //   }
//   //   return photos;
//   // }
//
//   void _viewSavedPhotos() {
//     // Navigator.of(context).push(
//     //   MaterialPageRoute(
//     //     // builder: (context) => SavedPhotosScreen(),
//     //   ),
//     // );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Unsplash Photos'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () async {
//               // final query = await showSearch(
//               //   context: context,
//               //   delegate: PhotosSearchDelegate(),
//               // );
//               // if (query != null && query.isNotEmpty) {
//               //   await _searchPhotos(query);
//               // }
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.save),
//             onPressed: _viewSavedPhotos,
//           ),
//         ],
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : GridView.count(
//         crossAxisCount: 2,
//         children: _photos
//             .map(
//               (photo) => Padding(
//             padding: EdgeInsets.all(8.0),
//             child: GestureDetector(
//               onTap: () async {
//                 await _savePhoto(photo);
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('Photo saved'),
//                     duration: Duration(seconds: 2),
//                   ),
//                 );
//               },
//               child: CachedNetworkImage(
//                 imageUrl: photo.url,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         )
//             .toList(),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _fetchRandomPhoto,
//         child: Icon(Icons.refresh),
//       ),
//     );
//   }
// }


