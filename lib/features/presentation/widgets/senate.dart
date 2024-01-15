import 'package:flutter/material.dart';

class SenatNeedsListWidget extends StatefulWidget {
  @override
  _SenatNeedsListWidgetState createState() => _SenatNeedsListWidgetState();
}

class _SenatNeedsListWidgetState extends State<SenatNeedsListWidget> {
  List<Map<String, dynamic>> senateNeeds = [
    {
      'category': 'Program Kerja Natal',
      'needs': [
        'Rencanakan acara khusus Natal.',
        'Dekorasikan area kampus dengan tema Natal.',
        'Undang pemimpin agama untuk memberikan sambutan Natal.'
      ],
    },
    {
      'category': 'Program Kerja Paskah',
      'needs': [
        'Organisasi kegiatan spesial Paskah.',
        'Susun acara ibadah khusus Paskah.',
        'Ajak mahasiswa untuk berpartisipasi dalam perayaan Paskah.'
      ],
    },
    {
      'category': 'Program Kerja Seminar Insight IT',
      'needs': [
        'Cari pembicara professional di bidang IT.',
        'Undang sponsor untuk mendukung acara.',
        'Pinjam ruangan dan fasilitas auditorium.'
      ],
    },
    {
      'category': 'Program Kerja Pelatihan',
      'needs': [
        'Identifikasi kebutuhan pelatihan untuk mahasiswa.',
        'Pilih topik pelatihan yang relevan.',
        'Atur jadwal dan fasilitator untuk setiap sesi pelatihan.'
      ],
    },
  ];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Kebutuhan Senat Mahasiswa",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: senateNeeds.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      senateNeeds[index]['category'] ?? '',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (senateNeeds[index]['needs'] != null &&
                            senateNeeds[index]['needs'].isNotEmpty)
                          for (int i = 0;
                              i < senateNeeds[index]['needs'].length;
                              i++)
                            Container(
                              margin: EdgeInsets.only(
                                  left: 16), // Adjust the left margin as needed
                              child: Text(
                                  '${i + 1}. ${senateNeeds[index]['needs'][i]}'),
                            ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                  padding: MaterialStateProperty.all(EdgeInsets.all(16)),
                ),
                onPressed: () {
                  _showAddItemModal(context);
                },
                child: Text(
                  'Tambah Kebutuhan',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddItemModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange),
                    padding: MaterialStateProperty.all(EdgeInsets.all(16)),
                  ),
                  onPressed: () {
                    setState(() {
                      senateNeeds.add({
                        'category': titleController.text,
                        'needs': [descriptionController.text],
                      });
                      titleController.clear();
                      descriptionController.clear();
                    });
                    Navigator.pop(context); // Close the modal
                  },
                  child: Text(
                    'Tambah List Kebutuhan Senat',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SenatNeedsListWidget(),
  ));
}
