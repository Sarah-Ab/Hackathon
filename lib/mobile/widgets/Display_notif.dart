import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/mobile/screens/welcome_pagemobile.dart';

import '../../ColorCustom.dart';


class Display_notif extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

        return MaterialApp(
            theme: ThemeData(
              primarySwatch: colorCustom,
            ),
            home: Scaffold(
                appBar: AppBar(
                  title: const Text('info'),
                ),
                body:

                ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: titremsg.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      //color: Colors.amber[colorCodes[index]],
                      child: Center(
                        child: Column(
                          children: [
                            Text('titre ${titremsg[index]}'),
                            Text('description ${descmsg[index]}')

                          ],
                        ),

                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context,
                      int index) => const Divider(),
                )
            )
        );
        }

}
