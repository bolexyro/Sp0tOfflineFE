// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:spotoffline/core/data_state.dart';
// import 'package:spotoffline/features/library/presentation/providers/library_provider.dart';
// import 'package:spotoffline/features/library/presentation/widgets/track_card.dart';

// class LikedSongsScreen extends ConsumerStatefulWidget {
//   const LikedSongsScreen({super.key});

//   @override
//   ConsumerState<LikedSongsScreen> createState() => _LikedSongsScreenState();
// }

// class _LikedSongsScreenState extends ConsumerState<LikedSongsScreen> {
//   late final getLibraryFuture = ref.read(libraryProvider.notifier).getLibrary();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.black,
//                     Color.fromARGB(255, 48, 82, 110),
//                   ],
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   IconButton(
//                       icon: const Icon(Icons.arrow_back),
//                       onPressed: () => Navigator.of(context).pop()),
//                   const SizedBox(width: 20),
//                   const Text(
//                     "Liked Songs",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   )
//                 ],
//               ),
//             ),
//             Expanded(
//               child: FutureBuilder(
//                 future: getLibraryFuture,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }

//                   final dataState = snapshot.data!;

//                   if (dataState is DataException) {
//                     WidgetsBinding.instance.addPostFrameCallback((_) {
//                       ScaffoldMessenger.of(context).clearSnackBars();
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text(dataState.exceptionMessage!),
//                           backgroundColor: Colors.red,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                           margin: const EdgeInsets.symmetric(horizontal: 10)
//                               .copyWith(bottom: 10),
//                           behavior: SnackBarBehavior.floating,
//                         ),
//                       );
//                     });
//                     return const Center(
//                       child: Text("An error occurred"),
//                     );
//                   }

//                   final libraryState = ref.read(libraryProvider);

//                   // if (libraryState == null) {
//                   //   return const Center(
//                   //     child: Text('No liked songs'),
//                   //   );
//                   // }
//                   // return ListView.builder(
//                   //   itemBuilder: (context, index) =>
//                   //       TrackCard(track: libraryState.tracks[index]),
//                   //   itemCount: libraryState.tracks.length,
//                   // );
//                   return Center();
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
