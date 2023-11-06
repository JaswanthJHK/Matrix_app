import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/provider/search_provider/search_provider.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<SearchProvider>(context, listen: false).getAllUser();
    return Scaffold(
        backgroundColor: scffoldBackgroundClr,
        appBar: AppBar(
          backgroundColor: scffoldBackgroundClr,
          leading: const Icon(Icons.search),
          title: TextFormField(
            controller: Provider.of<SearchProvider>(context, listen: false)
                .searchController,
            decoration: const InputDecoration(
              fillColor: Colors.grey,
              labelText: 'Search here...',
            ),
            onChanged: (value) {
              Provider.of<SearchProvider>(context, listen: false)
                  .getSearchedList(value);
              log("tapped");
            },
          ),
        ),
        body: //Provider.of<SearchProvider>(context, listen: false)
            //     .searchedList
            //     .isNotEmpty
            // ?
            Consumer<SearchProvider>(builder: (context, value, child) {
          // return FutureBuilder(
          //     future: FirebaseFirestore.instance
          //         .collection('users')
          //         .where(
          //           'username',
          //           isGreaterThanOrEqualTo: searchController.text,
          //         )
          //         .get(),
          //    builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          //   return Center(
          //     child: Text('No matching user found'),
          //   );
          // }

          if (value.searchController.text.isNotEmpty) {
            return ListView.builder(
              itemCount: value.searchedList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      value.searchedList[index].photoUrl,
                    ),
                  ),
                  title: Text(value.searchedList[index].username),
                );
              },
            );
          }
          //   },
          // );
          // })
          else {
            return FutureBuilder(
              future: FirebaseFirestore.instance.collection('posts').get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return GridView.builder(
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        
                          (snapshot.data! as dynamic).docs[index]['postUrl'],fit: BoxFit.cover,),
                    ),
                  ),
                );
              },
            );
          }
        }));
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:matrix_app_project/core/usecases/colors.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController searchController = TextEditingController();
//   bool isShowUser = false;

//   @override
//   void dispose() {
//     super.dispose();
//     searchController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: scffoldBackgroundClr,
//       appBar: AppBar(
//         backgroundColor: scffoldBackgroundClr,
//         leading: Icon(Icons.search),
//         title: TextFormField(
//           controller: searchController,
//           decoration: InputDecoration(
//             fillColor: Colors.grey,
//             labelText: 'Search here...',
        
            
//           ),
//           onFieldSubmitted: (String _) {
//             setState(() {
//               isShowUser = true;
//             });
//           },
//         ),
//       ),
//       body: isShowUser
//           ? FutureBuilder(
//               future: FirebaseFirestore.instance
//                   .collection('users')
//                   .where(
//                     'username',
//                     isGreaterThanOrEqualTo: searchController.text,
//                   )
//                   .get(),
//              builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(
//               child: Text('No matching user found'),
//             );
//           }

//                 return ListView.builder(
//                   itemCount: (snapshot.data! as dynamic).docs.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       leading: CircleAvatar(
//                         backgroundImage: NetworkImage(
//                           (snapshot.data! as dynamic).docs[index]['photoUrl'],
//                         ),
//                       ),
//                       title: Text(
//                           (snapshot.data! as dynamic).docs[index]['username']),
//                     );
//                   },
//                 );
//               },
//             )
//           : FutureBuilder(
//               future: FirebaseFirestore.instance.collection('posts').get(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//                 return MasonryGridView.builder(
//                   itemCount: (snapshot.data! as dynamic).docs.length,
//                   gridDelegate:
//                       const SliverSimpleGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                   ),
//                   itemBuilder: (context, index) => Padding(
//                     padding: const EdgeInsets.all(2.0),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child: Image.network(
//                           (snapshot.data! as dynamic).docs[index]['postUrl']),
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
