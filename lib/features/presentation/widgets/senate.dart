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
        // padding: EdgeInsets.all(16.0),
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  16, 8, 0, 0), // Adjust the padding value as needed
              child: Text(
                "Kebutuhan Senat Mahasiswa",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: senateNeeds.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(senateNeeds[index]['category']),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      // padding: EdgeInsets.only(right: 16.0),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 16.0), // Add margin to the right
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.blue,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(left: 16.0),
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: 16.0), // Add margin to the right
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd) {
                        // Swipe right to delete
                        setState(() {
                          senateNeeds.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Deleted'),
                          ),
                        );
                      } else if (direction == DismissDirection.endToStart) {
                        // Swipe left to edit
                        _showEditItemModal(context, index);
                      }
                    },
                    child: ListTile(
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
                                    left:
                                        16), // Adjust the left margin as needed
                                child: Text(
                                    '${i + 1}. ${senateNeeds[index]['needs'][i]}'),
                              ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                  labelText: 'Description (Separate items with commas)',
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
                      String description = descriptionController.text;
                      List<String> needs =
                          description.split(',').map((e) => e.trim()).toList();

                      senateNeeds.add({
                        'category': titleController.text,
                        'needs': needs,
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

  void _showEditItemModal(BuildContext context, int index) {
    titleController.text = senateNeeds[index]['category'];
    descriptionController.text = senateNeeds[index]['needs'].join(', ');

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.3,
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      labelText: 'Description (Separate items with commas)',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                      padding: MaterialStateProperty.all(EdgeInsets.all(16)),
                    ),
                    onPressed: () {
                      setState(() {
                        String description = descriptionController.text;
                        List<String> needs = description
                            .split(',')
                            .map((e) => e.trim())
                            .toList();

                        senateNeeds[index]['category'] = titleController.text;
                        senateNeeds[index]['needs'] = needs;
                      });
                      titleController.clear();
                      descriptionController.clear();
                      Navigator.pop(context); // Close the modal
                    },
                    child: Text(
                      'Edit List Kebutuhan Senat',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
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
