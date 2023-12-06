import 'package:flutter/material.dart';
import 'package:matrix_app_project/core/usecases/colors.dart';
import 'package:matrix_app_project/features/data/functions/user_data/get_user_data.dart';
import 'package:matrix_app_project/features/data/models/user.dart';
import 'package:matrix_app_project/features/presentaition/pages/profile_section/screen/profile_page.dart';
import 'package:matrix_app_project/features/presentaition/statemanagement/provider/get_user_profile/get_userdata_profile_provider.dart';
import 'package:matrix_app_project/features/presentaition/widgets/global/costum_appbar_widget.dart';

class FollowersList extends StatelessWidget {
  const FollowersList({super.key, required this.name, required this.followers});
  final String name;
  final List<dynamic>? followers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: blackClr)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView.builder(
          itemCount: followers?.length,
          itemBuilder: (context, index) {
            String? userId = followers?[index];
            return FutureBuilder<User?>(
              future: GetUserDataProvider().getUserDataDetailsProvider(userId!),
              builder: (context, followsnapshot) {
                if (followsnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!followsnapshot.hasData) {
                  return const Center(
                    child: Text('No data'),
                  );
                }
                return Column(
                  children: [
                    InkWell(
                      onTap:() {
                         Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProfilPage(uid: userId),
                    ));
                      }, 
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: const AssetImage(
                            'asset/images/fadeinImage.png',
                          ),
                          radius: 23,
                          child: ClipOval(
                            child: followsnapshot.data!.photoUrl != null
                                ? Image.network(
                                    followsnapshot.data!.photoUrl,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'asset/images/fadeinImage.png',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        title: Text(followsnapshot.data!.username ),
                        subtitle: Text(followsnapshot.data!.about ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
