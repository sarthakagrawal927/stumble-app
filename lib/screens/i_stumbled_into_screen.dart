import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/models/profile.dart';
import 'package:dating_made_better/providers/profile.dart';
import 'package:dating_made_better/stumbles_list_constants.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/widgets/common/profile_modal.dart';
import 'package:dating_made_better/widgets/top_app_bar.dart';
import 'package:flutter/material.dart';

class IStumbledIntoScreen extends StatefulWidget {
  static const routeName = '/i-stumbled-into-screen';
  const IStumbledIntoScreen({super.key});

  @override
  State<IStumbledIntoScreen> createState() => _IStumbledIntoScreenState();
}

class _IStumbledIntoScreenState extends State<IStumbledIntoScreen> {
  @override
  Widget build(BuildContext context) {
    final List<MiniProfile> listOfProfiles =
        ModalRoute.of(context)!.settings.arguments as List<MiniProfile>;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: const TopAppBar(),
      body: GridView.builder(
        itemCount: listOfProfiles.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () async {
              Profile profile;
              profile = await getUserApi(listOfProfiles[index].id)
                  .then((value) => profile = value!);
                  
              // ignore: use_build_context_synchronously
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ProfileModal(profile: profile);
                },
              );
            },
            child: Container(
              margin: EdgeInsets.all(MediaQuery.of(context).size.height / 64),
              alignment: Alignment.bottomLeft,
              decoration: imageBoxWidget(context, listOfProfiles[index]),
            ),
          );
        },
      ),
    );
  }
}
