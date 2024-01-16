import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/data/datasources/image_proker_datasource.dart';

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
              onPressed: () {
                // Perform the download logic here
                // For example, you can use a package like path_provider to get the app's documents directory
                // and copy the image file there.
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
