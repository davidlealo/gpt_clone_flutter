import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/form_data_provider.dart';

class ChatDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FormDataProvider>(
      builder: (context, formData, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chat:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: formData.chatHistory.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      formData.chatHistory[index],
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
