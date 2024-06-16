  import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/constants_fonts.dart';
import 'package:dating_made_better/providers/first_screen_state_providers.dart';
import 'package:dating_made_better/screens/login_or_signup_screen.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/utils/internal_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future<dynamic> deletionWidget(BuildContext context) {
    return showDialog(
                        context: context,
                        barrierColor: Colors.transparent.withOpacity(0.8),
                        builder: (context) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Dialog(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                elevation: 16,
                                child: ListView(
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    SizedBox(
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.825,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top:
                                                      marginWidth64(context)),
                                              padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    marginWidth32(context),
                                                vertical:
                                                    marginHeight64(context),
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    style: GoogleFonts.acme(
                                                      fontSize:
                                                          fontSize48(context),
                                                      color: headingColor,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                    softWrap: true,
                                                    "It saddens us to witness your stumbling come to a halt in discovering more incredible individuals!",
                                                  ),
                                                  SizedBox(
                                                      height: marginHeight128(
                                                          context)),
                                                  Text(
                                                      style: GoogleFonts.acme(
                                                        fontSize: fontSize96(
                                                            context),
                                                        color: headingColor,
                                                      ),
                                                      textAlign:
                                                          TextAlign.left,
                                                      softWrap: true,
                                                      "Click on the ✅ to delete.")
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                    Container(
                                      height: marginHeight64(context),
                                      color: Colors.transparent
                                          .withOpacity(0.925),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                          iconSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              10,
                                          icon: const Icon(Icons.close),
                                          onPressed: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop("");
                                          },
                                        ),
                                        IconButton(
                                          iconSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              10,
                                          icon: const Icon(
                                            Icons.check,
                                          ),
                                          onPressed: () {
                                            deleteUserApi().then((_) =>
                                                deleteSecureData(authKey)
                                                    .then((value) {
                                                  Provider.of<FirstScreenStateProviders>(
                                                          context,
                                                          listen: false)
                                                      .setActiveScreenMode(
                                                          ScreenMode.landing);
                                                  Navigator.pushNamed(context,
                                                      AuthScreen.routeName);
                                                }));
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        });
  }