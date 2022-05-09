import 'package:flutter/material.dart';
import 'package:school_project_ibdb/product/circle_avatar/custom_circle_avatar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/enum/padding_values.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        centerTitle: true,
      ),
      body: Padding(
          padding: PaddingValues.min.rawValues(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About",
                style: Theme.of(context).textTheme.headline3,
              ),
              Text("This project made for school project.", style: Theme.of(context).textTheme.bodyText1),
              const Divider(),
              Text("Project Authors:", style: Theme.of(context).textTheme.headline6),
              Card(
                child: GestureDetector(
                  onTap: () async {
                    const url = "https://www.linkedin.com/in/-ruchan-adiguzel/";
                    if (await canLaunchUrl(Uri.parse(url))) {
                      launchUrl(Uri.parse(url));
                    }
                  },
                  child: ListTile(
                    leading: CustomCircleAvatar(
                        avatarUrl:
                            "https://assetstorev1-prd-cdn.unity3d.com/key-image/f6f9239f-792f-4952-a089-e121a9e19f71.jpg"),
                    title: const Text("Rüçhan Adıgüzel"),
                    subtitle: const Text("Mobile programmer, 3D artist"),
                  ),
                ),
              ),
              Card(
                child: GestureDetector(
                  onTap: () {},
                  child: ListTile(
                    leading: CustomCircleAvatar(
                        avatarUrl:
                            "https://previews.123rf.com/images/blauananas/blauananas1504/blauananas150400006/38995330-polygonal-illustration-of-deer.jpg?fj=1"),
                    title: const Text("Ibrahim geyik"),
                    subtitle: const Text("Boş gezenin boş kalfası"),
                  ),
                ),
              ),
              Card(
                child: GestureDetector(
                  onTap: () {},
                  child: ListTile(
                    leading: CustomCircleAvatar(
                      avatarUrl: null,
                    ),
                    title: const Text("Ferhat"),
                    subtitle: const Text("don't know"),
                  ),
                ),
              ),
              Card(
                child: GestureDetector(
                  onTap: () {},
                  child: ListTile(
                    leading: CustomCircleAvatar(
                      avatarUrl: null,
                    ),
                    title: const Text("aybars "),
                    subtitle: const Text("don't know"),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
