import 'package:cat_register/screens/registered_pet_feed_screen/cubit/registered_pet_feed_screen_cubit.dart';
import 'package:cat_register/screens/registered_pet_feed_screen/registered_pet_feed_screen.dart';
import 'package:cat_register/widget/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());

  Bloc.observer = EchoCubitDelegate();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Register',
      theme: ThemeData(textTheme: GoogleFonts.interTextTheme()),
      home: BlocProvider(
        create:
            (BuildContext context) => RegisteredPetFeedScreenCubit()..init(),
        child: RegisteredPetFeedScreen(),
      ),
    );
  }
}

// class PetUploadPage extends StatefulWidget {
//   const PetUploadPage({super.key});

//   @override
//   _PetUploadPageState createState() => _PetUploadPageState();
// }

// class _PetUploadPageState extends State<PetUploadPage> {
//   XFile? _selectedImage;
//   Uint8List? _imageBytes;

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       final bytes = await pickedImage.readAsBytes();
//       setState(() {
//         _selectedImage = pickedImage;
//         _imageBytes = bytes;
//       });
//     }
//   }

//   Future<void> uploadPetForm({
//     required Uint8List imageBytes,
//     required String imageName,
//     required BuildContext context,
//   }) async {
//     final uri = Uri.parse('https://www.mettyznest.com/api/register/form');
//     final request = http.MultipartRequest('POST', uri);

//     // Add form fields
//     request.fields['pet_name'] = 'sed';
//     request.fields['user_name'] = 'nimo';
//     request.fields['pet_type'] = 'puppy';
//     request.fields['gender'] = 'Female';
//     request.fields['location'] = 'TN';

//     // Create image multipart
//     final imageFile = http.MultipartFile.fromBytes(
//       'image',
//       imageBytes,
//       filename: imageName,
//       contentType: MediaType('image', 'png'), // or jpg, jpeg
//     );

//     request.files.add(imageFile);

//     // Log what's being sent
//     print("🔍 Sending Fields:");
//     request.fields.forEach((k, v) => print(" - $k: $v"));

//     print("📎 Sending File:");
//     print(" - Field: ${imageFile.field}");
//     print(" - Filename: ${imageFile.filename}");
//     print(" - Type: ${imageFile.contentType}");

//     try {
//       final response = await request.send();
//       final body = await response.stream.bytesToString();
//       final json = jsonDecode(body);

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         print("✅ Upload successful");
//         print("📄 Response: $json");

//         final imageUrl = json['data']?['image'];
//         if (imageUrl != null) {
//           print("🖼 Uploaded image URL: $imageUrl");
//         } else {
//           print("ℹ️ No image URL returned.");
//         }

//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text('Upload successful')));
//       } else {
//         print("❌ Upload failed: ${json['errors'] ?? body}");
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text('Upload failed')));
//       }
//     } catch (e) {
//       print("❗ Exception during upload: $e");
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Something went wrong')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Upload Pet Info')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             _imageBytes != null
//                 ? Image.memory(_imageBytes!, height: 200)
//                 : Container(
//                   height: 200,
//                   color: Colors.grey[300],
//                   child: Center(child: Text("No image selected")),
//                 ),
//             const SizedBox(height: 16),
//             ElevatedButton(onPressed: _pickImage, child: Text("Pick Image")),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 uploadPetForm(
//                   imageBytes: _imageBytes!,
//                   imageName: _selectedImage!.name,
//                   context: context,
//                 );
//               },
//               child: Text("Upload"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
