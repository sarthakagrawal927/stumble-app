import 'package:dating_made_better/providers/socket.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void connectSocket(int userId, BuildContext context) {
  IO.Socket socket;
  socket = IO.io(
      baseURL,
      IO.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connect
          .setQuery({'userId': userId})
          .build());

  socket.connect();

  socket.onConnect((_) {
    print('Connected to server');
  });

  socket.on('newMessage', (data) {
    Provider.of<SocketProvider>(context, listen: false).incrementMessageCount();
  });

  socket.onDisconnect((_) {
    print('Disconnected from server');
  });
}
