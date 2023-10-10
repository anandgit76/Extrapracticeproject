import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViktorScreen extends StatefulWidget {
  const ViktorScreen({super.key});

  @override
  State<ViktorScreen> createState() => _ViktorScreenState();
}

class _ViktorScreenState extends State<ViktorScreen> {
  @override
  Widget build(BuildContext context) {
    
    var size = MediaQuery.of(context).size;
    return Scaffold(
        bottomNavigationBar:ClipRRect(
    borderRadius: const BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0), ),
        child:BottomNavigationBar(
          elevation: 100,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey.shade100,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.white.withOpacity(.60),
          selectedFontSize:20,
          unselectedFontSize: 14,
          onTap: (value) {
            // Respond to item press.
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline,color: Colors.black,),
              label: "abc"
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.appleWhole,color: Colors.black,),
                label: "abc"
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.appleWhole,color: Colors.black,),
                label: "abc"
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.appleWhole,color: Colors.black,),
                label: "abc"
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.seedling,color: Colors.black,),
                label: "abc"
            ),
          ],
        )
        ),
    body: SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Container(
                child: const Padding(
                  padding: EdgeInsets.only(top: 50,right: 180),
                  child: Text("Hi Victor!",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                ),
              ),
              Container(
                height: size.height/25,
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: size.height,
                      width: size.width/5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)
                        )
                      ),
                      child: const Center(
                        child: Text("Creative"),
                      ),
                    ),Container(
                      height: size.height,
                      width: size.width/5,
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)
                        )
                      ),
                      child: const Center(
                        child: Text("Sports"),
                      ),
                    ),Container(
                      height: size.height,
                      width: size.width/5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)
                        )
                      ),
                      child: const Center(
                        child: Text("Social"),
                      ),
                    ),Container(
                      height: size.height,
                      width: size.width/5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)
                        )
                      ),
                      child: const Center(
                        child: Text("Events"),
                      ),
                    ),
                    const Icon(Icons.account_tree_outlined)
                  ],
                ),
              ),
               const SizedBox(
                height: 10,
              ),
              CalendarWeek(
                controller: CalendarWeekController(),
                height: 100,
                showMonth: true,
                minDate: DateTime.now().add(
                  const Duration(days: -365),
                ),
                maxDate: DateTime.now().add(
                  const Duration(days: 365),
                ),

                onDatePressed: (DateTime datetime) {
                  // Do something
                },
                onDateLongPressed: (DateTime datetime) {
                  // Do something
                },
                onWeekChanged: () {
                  // Do something
                },
                monthViewBuilder: (DateTime time) => const Align(
                  alignment: Alignment.center,
                  // child: Container(
                  //     margin: const EdgeInsets.symmetric(vertical: 4),
                  //     child: Text(
                  //       DateFormat.yMMMM().format(time),
                  //       overflow: TextOverflow.ellipsis,
                  //       textAlign: TextAlign.center,
                  //       style: TextStyle(
                  //           color: Colors.red, fontWeight: FontWeight.w600),
                  //     )),
                ),
                decorations: [
                  DecorationItem(
                      decorationAlignment: FractionalOffset.bottomRight,
                      date: DateTime.now(),
                      decoration: const Icon(
                        Icons.today,
                        color: Colors.green,
                      )),
                  DecorationItem(
                      date: DateTime.now().add(Duration(days: 3)),
                      decoration: Text(
                        'Holiday',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ],
              ),
             // SizedBox(height: 20,),
             // Expanded(
             //   child: ListView.separated(
             //       itemBuilder: (context,index){
             //         return ListTile(
             //           leading: Image.asset('assets/Bolt.png',height: 60,),
             //           title: const Text('Climbing',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
             //           subtitle: const Column(
             //             children: [
             //               Text('Improve all aspects of your\nphysical condition',style: TextStyle(fontSize: 13),),
             //               Row(
             //                 children: [
             //                 ],
             //               )
             //             ],
             //           ),
             //           trailing: ElevatedButton(
             //             onPressed: () {},
             //             // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
             //             style: ElevatedButton.styleFrom(
             //               backgroundColor: Colors.red,
             //                 elevation: 12.0,
             //                 textStyle: const TextStyle(color: Colors.white)),
             //             child: const Text('Book',style: TextStyle(color: Colors.white,fontSize: 15),),
             //           ),
             //
             //         );
             //       },
             //       separatorBuilder: (BuildContext context, int index) => const Divider(),
             //       itemCount: 3),
             // )
            ],
          ),
        ),
      ),
    ),
    );
  }
  Widget custom2({
    String? txt,
    String? txt1,
    VoidCallback? onTap,
    double? height,
    double? width,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 8, left: 10, right: 10),
        height: 40,
        child: ListTile(
          leading: Text(
            txt ?? "",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  txt1 ?? "",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              Icon(Icons.arrow_forward_sharp),
            ],
          ),
        ),
      ),
    );
  }

}
