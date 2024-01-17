import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/data/datasources/image_proker_datasource.dart';
import 'package:path_provider/path_provider.dart'; // Import the path_provider package

class ProgramKerjaImagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dokumentasi Program Kerja'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: programKerjaList.length,
        itemBuilder: (context, index) {
          ProgramKerja programKerja = programKerjaList[index];
          return GestureDetector(
            onTap: () {
              _showDownloadDialog(context, programKerja.imagePath);
            },
            child: Hero(
              tag: programKerja.imagePath, // Unique tag for hero animation
              child: Card(
                elevation: 5,
                margin: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          programKerja.imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        programKerja.nama,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDownloadDialog(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Download Image?'),
          content: Text('Do you want to download this image?'),
          actions: [
            TextButton(
              onPressed: () async {
                // Perform the download logic here
                // Get the app's documents directory
                Directory documentsDirectory = await getApplicationDocumentsDirectory();
                String destinationPath = '${documentsDirectory.path}/downloaded_image.png';

                // Copy the image file to the documents directory
                await File(imagePath).copy(destinationPath);

                // Notify the user that the download is complete
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Download complete!'),
                  ),
                );

                Navigator.of(context).pop();
              },
              child: Text('Download'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
