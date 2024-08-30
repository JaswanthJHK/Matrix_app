import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';
import 'package:matrix_app_project/features/presentaition/pages/profile_section/screen/profile_page.dart';
import 'package:matrix_app_project/features/presentaition/pages/search_explore_section/screens/explore_screen.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/provider/search_provider/search_provider.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>with AutomaticKeepAliveClientMixin<SearchScreen> {
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
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProfilPage(uid: value.searchedList[index].uid),
                        ));
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        value.searchedList[index].photoUrl,
                      ),
                    ),
                    title: Text(value.searchedList[index].username),
                  ),
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ExploreScreen(),
                              ));
                        },
                        child: Image.network(
                          (snapshot.data! as dynamic).docs[index]['postUrl'],
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: RotationTransition(
                                  turns: AlwaysStoppedAnimation(loadingProgress
                                              .expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : 0),
                                  child: const CircularProgressIndicator(
                                    color: greyLite,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        }));
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
