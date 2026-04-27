import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_generator/features/main_layout/presentation/widgets/demo_app_alert.dart';
import 'package:form_generator/features/main_layout/presentation/widgets/demo_app_button.dart';
import 'package:form_generator/features/main_layout/presentation/widgets/demo_app_radio.dart';
import 'package:framework_base/framework_base.dart';
import 'package:hugeicons/hugeicons.dart';

import '../widgets/demo_app_avatar.dart';
import '../widgets/demo_app_switch.dart';
import '../widgets/demo_app_text_form_field.dart';

class MainLayout extends ConsumerStatefulWidget {
  const MainLayout({super.key});

  @override
  ConsumerState<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends ConsumerState<MainLayout> {
  late FormSchema schema;
  late FormStateController controller;

  int _index = -1;

  List<Widget> items = [];
  @override
  void initState() {
    super.initState();
    // items.add(DemoAppButton());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).backgroundSurface.main,
                padding: EdgeInsets.symmetric(horizontal: AppSize.small),
                child: DemoAppButton(),
            ),
            AppSize.small.gapHeight,
            Container(
              color: Theme.of(context).backgroundSurface.main,
              padding: EdgeInsets.symmetric(horizontal: AppSize.small),
                child: DemoAppTextFormField(),
            ),
            AppSize.small.gapHeight,
            Container(
              color: Theme.of(context).backgroundSurface.main,
              padding: EdgeInsets.symmetric(horizontal: AppSize.small),
              child: DemoAppAlert(),
            ),
            AppSize.small.gapHeight,
            Container(
              color: Theme.of(context).backgroundSurface.main,
              padding: EdgeInsets.symmetric(horizontal: AppSize.small),
              child: DemoAppAvatar(),
            ),
            AppSize.small.gapHeight,
            Container(
              color: Theme.of(context).backgroundSurface.main,
              padding: EdgeInsets.symmetric(horizontal: AppSize.small),
              child: DemoAppRadio(),
            ),
            AppSize.small.gapHeight,
            Container(
              color: Theme.of(context).backgroundSurface.main,
              padding: EdgeInsets.symmetric(horizontal: AppSize.small),
              child: DemoAppSwitch(),
            ),
          ],
        ),
      )



      // FutureBuilder(
      //   future: rootBundle.loadString('assets/json/form_schema.json'),
      //   builder: (BuildContext context, AsyncSnapshot snapshot) {
      //     if (snapshot.hasData) {
      //       schema = FormSchema.fromJson(json.decode(snapshot.data!));
      //       controller = FormStateController(schema);
      //       items.add(DynamicFormBuilder(schema: schema, controller: controller));
      //       return SingleChildScrollView(
      //         child: ExpansionPanelList(
      //           expansionCallback: (index, isOpen) {
      //             setState(() {
      //               _index = index;
      //             });
      //           },
      //           children: [
      //             _buildPanel("Button", 0),
      //             _buildPanel("DynamicFormBuilder", 1),
      //
      //           ],
      //         ),
      //       );
      //     } else {
      //       return Center(child: CircularProgressIndicator());
      //     }
      //   },
      // ),
    );


  }
  ExpansionPanel _buildPanel(String title, int index) {
    return ExpansionPanel(
      headerBuilder: (context, isOpen) {
        return ListTile(title: Text(title,style: Theme.of(context).textXLRegular,));
      },
      body:  items[index],
      isExpanded: _index != index,
    );
  }
}
