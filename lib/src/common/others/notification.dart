import 'dart:convert';
import 'dart:developer';

import 'package:chahel_web_1/src/app_details/app_details.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:http/http.dart' as http;

Future<void> sendFcmMessage({
  String? token,
  required String body,
  required String title,
  String? userId,
  String? image,
}) async {
  log("IMAGE :$image");
  final result = await obtainAuthenticatedClient();
  const url =
      'https://fcm.googleapis.com/v1/projects/${AppDetails.projectId}/messages:send';

  // Replace with your notification details
  final notification = <String, dynamic>{
    'title': title,
    'body': body,
    'image': image
  };

  // Construct the FCM message
  final message = <String, dynamic>{
    'message': {
      // 'token': 'allUsers',
      'topic': 'All',
      'notification': notification,
      // 'data': data,
    },
  };

  // Convert the message to JSON
  final jsonMessage = jsonEncode(message);

  // Make the POST request to send the FCM message
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${result.credentials.accessToken.data}',
    },
    body: jsonMessage,
  );

  // Check the response
  if (response.statusCode == 200) {
    log('FCM message sent successfully');
  } else {
    log('Failed to send FCM message. Status code: ${response.statusCode}');
    log('Response body: ${response.body}');
  }
}

Future<AuthClient> obtainAuthenticatedClient() async {
  final accountCredentials = ServiceAccountCredentials.fromJson({
    "type": "service_account",
    "project_id": "chahele-learning-app",
    "private_key_id": "96490bce5b1b2729cdb0cb7bd6308d211a319b69",
    "private_key":
        "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC+Gdf6wbxopmbh\n0yuBnF4AXPrsA+bsWaFaBsVb/c9qtXoVRg6ny1Qn1Fxev2CeBjcQT6bUSPlXWNh7\ntgskmZydUsYuoJJ2fWUke0YLPK1G+F5kY8gPSsR+EQZLOd+8AJ/yvWuZGK+JqJhj\ns/hFzuigkymesbjAEhd9eFzkR55yEbU6qGsOUgO72Nd21vGw6ttKSti/k8u5Q8ml\nS9CMnXZZykqDAIquzi6p7sF7jJ0hiw6jJKg3mpHgaS6KfJv+7okRWfDB5ffW8MrS\ns7rdSWZXmAAAbsoCAuqDWhB/Zqg8/eIQLxheTwfG7Hw82qADbTWMYwGHPWqcOZVT\ngqPLIe97AgMBAAECggEASvvRq/jgMt00Jq5PcmP11inW1eKiIycllGeoUGVYe8xS\nd/K21CvJKZ7DwqG1YA+uh5ILiZ+xLml+lqmTUp/+3TVps7mlm/RRQWcYlVUdOim8\nvdd38cQ5pkpb069j13ndnXdm6jAJCYEFfwpdi1eWfcQefhi2+ZgJSPYBmg+/6Vjw\nmGCMMbSt+f26Qmwp35nHslh7w1kOx/994XmXGfRfnIbGC63eyXmMHauRuw7W8ESO\noMAhnLTZ0/J9TkFv1VziNRHyNejxiTcJbufI4hXAenpyl3/M9wHd/3TL0uHZreGd\nehqCcUb1T7jT9pcgudVS5jY4nw/DssGQXaGoPnEosQKBgQD3ZcUc1uzBp1Jkgad1\nTE0nO6SffiUuOFWDy7gHZ/vNN7D4co9xYxyHokpypM+Vj0XSByEfDwtJE/LOo00N\nNNmws76P+XbhGxaoG7GP+7nZDL+DMoxfsJyg/b8S+oGYZCXhJelN/SQ3sycxAZLn\nPd9ffJ7Mlj9jIK3WXz6nUprxawKBgQDEtgsV56Wrx3jdTj1m2ytfxU4hLEVc1LaU\nO7ZaCjDCgD+wfFtOsJQUtuKb/NW84teTarvCbf2dSz0bgoX57E3rxW83pZuxYQUp\nwGjH0RcvIaZF7oQl6MZm0mu8IxmXnwREUYHxBgevhiKdJpoCJ25JnZKYDHwDi8Ex\nFJlVE+muMQKBgALztexoLB8LbhJA8cyWgn0rWwWELdFlXq/Z6HI+LWT/ex8bztZd\nhmOf7h98E/YG5aBh8WU7erj+gfExRaQYs1hGbMmvAlohRp3u5ql/KXKLkmVwXvht\nVREetf71+kHlQAZ1u1jw4lO/0YHmMOiNdnLfO83ZJRx7sVdTf53jgHHNAoGAMVSB\ntS2RY2GzkrQTO98MoojFThZfEqeZXdUXpr7VeYFV93lIIJSxnfw7Geku5J5yd1qV\n2W1h43dBzMtPs9wpsk2h1W+nerUc6VqCLFHoIX6rxu/IngUg9BoiwFyBB3/uPv+9\nuWbMuJzHw2cxygZ/ZuCoKY8/7le2zAshZK+Is5ECgYAxnFonBwmZiwtX5ex0LmME\nhKRi9LwZVPsL/a6lYqBw0SfZrGLeMx5sKW4bZKUQc6n4kOyYfYeXQjqktGCeY50v\nUuXlDRx8qEFYnb3qlVlD1IQoglnp8/VDPou7JxaJnVT+Yj5zwlFNrUW8+3koF8bA\n9pjEz8PNDkfX3ptuxzx35Q==\n-----END PRIVATE KEY-----\n",
    "client_email":
        "firebase-adminsdk-epzfy@chahele-learning-app.iam.gserviceaccount.com",
    "client_id": "103282383578002365114",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url":
        "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-epzfy%40chahele-learning-app.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  });
  const messagingScope = 'https://www.googleapis.com/auth/firebase.messaging';
  final scopes = [messagingScope];

  final AuthClient client =
      await clientViaServiceAccount(accountCredentials, scopes);

  return client;
}
