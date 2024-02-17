import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vevent_flutter/bloc/event/event_bloc.dart';
import 'package:vevent_flutter/models/filter.dart';

class FilterOverlay extends StatefulWidget {
  final String uEmail;
  final String uRole;

  const FilterOverlay({super.key, required this.uEmail, required this.uRole});
  @override
  _FilterOverlayState createState() => _FilterOverlayState();
}

class _FilterOverlayState extends State<FilterOverlay> {
  OverlayEntry? _overlayEntry;
  bool isShowOverlay = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.filter_list,
        color: Color.fromRGBO(69, 32, 204, 1),
      ),
      onPressed: () {
        // เมื่อปุ่ม filter ถูกคลิก
        if (!isShowOverlay) {
          _showFilterOverlay(context);
        }
        isShowOverlay = !isShowOverlay;
      },
    );
  }

  void _showFilterOverlay(BuildContext context) {
    // สร้าง OverlayEntry
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        bottom: 0,
        right: 0,
        child: Material(
          // shadowColor: Colors.grey.shade300,
          color: Colors.transparent,
          child: Container(
          //   decoration: BoxDecoration(
           
          // borderRadius: BorderRadius.all(Radius.circular(12)),
          //   ),
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.7,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(children: [
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: Text(
                            "Filter",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          // color: Colors.amber.shade300,
                        ),
                        Positioned(
                          right: 16.0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(69, 32, 204, 0.4),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            child: IconButton(
                                onPressed: () {
                                  _hideFilterOverlay();
                                },
                                icon: Icon(Icons.close)),
                          ),
                        ),
                      ]),
                      SizedBox(height: 24,),
                      Container(
                        // color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Category"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OutlinedButton(
                                    onPressed: () {}, child: Text("All")),
                                OutlinedButton(
                                    onPressed: () {},
                                    child: Text("Volunteers")),
                                OutlinedButton(
                                    onPressed: () {}, child: Text("Education")),
                                OutlinedButton(
                                    onPressed: () {}, child: Text("Exercise")),
                                // OutlinedButton(onPressed: (){}, child: Text("Dance")),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                          // color: Colors.white,
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Sort by"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              OutlinedButton(
                                  onPressed: () {
                                    EventFilter.sortBySelected(SortBy.Desc);
                                  },
                                  child: Text("Newest"),
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 44, vertical: 12),
                                  )),
                              OutlinedButton(
                                  onPressed: () {
                                    EventFilter.sortBySelected(SortBy.Asc);
                                  },
                                  child: Text("Oldest"),
                                  style: OutlinedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 44, vertical: 12))),
                            ],
                          ),
                        ],
                      )),
                      // เพิ่มรายการ filter ตามต้องการ
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 1),
                      blurRadius: 10,
                      color: Colors.grey.shade300,
                    )
                  ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {
                            EventFilter.sortBySelected(
                                SortBy.Desc); // default of sortBy is Newest
                          },
                          child: Text("Reset")),
                      TextButton(
                          onPressed: () {
                            _hideFilterOverlay();
                            context.read<EventBloc>().add(showEventList(
                                uEmail: widget.uEmail,
                                uRole: widget.uRole,
                                selectedStatus: EventFilter.filterStatusBy,
                                sortBy: EventFilter.sortBy));
                          },
                          child: Text("Apply")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // เรียกใช้ OverlayEntry
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _hideFilterOverlay() {
    // ซ่อน OverlayEntry
    _overlayEntry?.remove();
  }
}