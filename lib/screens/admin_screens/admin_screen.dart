import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kartek_demo/models/event_models/event_model.dart';
import 'package:kartek_demo/screens/event_screens/event_screen.dart';
import 'package:kartek_demo/utils/constants.dart';
import 'package:kartek_demo/utils/custom_theme.dart';
import 'package:kartek_demo/utils/extensions.dart';

import 'package:kartek_demo/witgets/custom_material_button.dart';

class AdminScreen extends StatefulWidget {
  static const String routeName = '/admin-screen';
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final ref = FirebaseFirestore.instance.collection('event').snapshots();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text('Admin Sayfası'),
        ),
        floatingActionButton: SizedBox(
          width: context.dynamicWidth(0.4),
          child: CustomMaterialButton(
              text: 'Event Ekle',
              tap: () async {
                Navigator.pushNamed(context, '/admin-add-event');
              },
              color: Colors.blue),
        ),
        body: StreamBuilder(
          stream: ref,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var docs = snapshot.data!.docs;
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  return AdminEventCard(
                    index: index,
                    model: EventModel(
                        name: docs[index]['name'],
                        date: docs[index]['date'],
                        place: docs[index]['place'],
                        price: docs[index]['price'],
                        img: docs[index]['img'],
                        desc: docs[index]['desc'],
                        address: docs[index]['address'],
                        event: docs[index]['eventType'],
                        phone: docs[index]['phone']),
                    size: size,
                    docs: docs,
                  );
                },
              );
            }
          },
        ));
  }
}

class AdminEventCard extends StatelessWidget {
  const AdminEventCard({
    super.key,
    required this.size,
    required this.docs,
    required this.model,
    required this.index,
  });

  final Size size;

  final EventModel model;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
          dragDismissible: false,
          motion: const ScrollMotion(),
          extentRatio: 0.41,
          children: [
            GestureDetector(
              onTap: () {
                FirebaseFirestore.instance
                    .collection('event')
                    .doc(docs[index].id)
                    .delete();
              },
              child: Container(
                  width: 70,
                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                  padding:
                      const EdgeInsets.only(bottom: AppConstant.smallPadding),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius:
                            BorderRadius.circular(AppConstant.smallPadding)),
                    child: Center(
                      child: GestureDetector(
                        child: const Icon(
                          Icons.delete,
                          size: 40,
                          color: CustomThemeData.whiteColor,
                        ),
                      ),
                    ),
                  )),
            ),
            const SizedBox(width: AppConstant.smallPadding),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/admin-edit-event',
                  arguments: [model, docs, index]),
              child: Container(
                  width: 70,
                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                  padding:
                      const EdgeInsets.only(bottom: AppConstant.smallPadding),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius:
                            BorderRadius.circular(AppConstant.smallPadding)),
                    child: Center(
                      child: GestureDetector(
                        child: const Icon(
                          Icons.settings,
                          size: 40,
                          color: CustomThemeData.whiteColor,
                        ),
                      ),
                    ),
                  )),
            ),
          ]),
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: context.dynamicWidth(0.05),
            vertical: context.dynamicWidth(0.04)),
        decoration: BoxDecoration(
            color: CustomThemeData.blackColorLight,
            borderRadius: BorderRadius.circular(AppConstant.smallPadding),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 0.8,
                  color: CustomThemeData.disabledColorDark),
            ]),
        height: 120,
        width: double.infinity,
        child: Row(
          children: [
            EventImagePart(
              size: size,
              img: model.img,
              price: model.price,
            ),
            EventDetailPart(
              size: size,
              name: model.name,
              date: model.date,
              event: model.event,
              place: model.place,
            ),
          ],
        ),
      ),
    );
  }
}
