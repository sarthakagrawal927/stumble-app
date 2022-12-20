import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          'Dating, made better!',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Center(
              child: CircleAvatar(
                maxRadius: 50,
                minRadius: 30,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(
                  'https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg',
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              color: Colors.amber,
              child: const Text(
                'Profile completion: ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Row(
              children: <Widget>[
                Container(
                  color: Colors.amber,
                  child: const Text(
                    'Name',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  color: Colors.amber,
                  child: const Text(
                    'Age',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  color: Colors.amber,
                  child: const Text(
                    'Verified',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
