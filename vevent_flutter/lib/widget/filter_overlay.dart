import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vevent_flutter/bloc/event/event_bloc.dart';
import 'package:vevent_flutter/etc/filter.dart';

// ignore: must_be_immutable
class FilterOverlay extends StatefulWidget {
  final String uEmail;
  final String uRole;

  FilterOverlay({super.key, required this.uEmail, required this.uRole});
  @override
  _FilterOverlayState createState() => _FilterOverlayState();
}

class _FilterOverlayState extends State<FilterOverlay> {
  OverlayEntry? _overlayEntry;
  bool isShowOverlay = false;

  @override
  void initState() {
    // widget.sortSelected == "isNewest";
    super.initState();
  }

  // bool isSelected(){
  //   if (widget.sortSelected == "isNewest"){
  //   return true;
  //   }else{
  //     return false;
  //   }
  // }

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
          color: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.7,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(children: [
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: const Text(
                            "Filter",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          // color: Colors.amber.shade300,
                        ),
                        Positioned(
                          right: 16.0,
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: Color.fromRGBO(69, 32, 204, 0.2),
                            ),
                            child: IconButton(
                              onPressed: () {
                                _hideFilterOverlay();
                              },
                              icon: const Icon(Icons.close, size: 16),
                              padding: const EdgeInsets.all(8),
                              color: const Color.fromRGBO(69, 32, 204, 1),
                            ),
                          ),
                        ),
                      ]),
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                          // color: Colors.white,
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Sort by"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              OutlinedButton(
                                  onPressed: () {
                                    EventFilter.sortBySelected(SortBy.Desc);
                                  },
                                  style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 44, vertical: 12),
                                      side: BorderSide(
                                          color:  Colors.grey)),
                                  child: const Text("Newest",
                                      style: TextStyle(color: Colors.black))),
                              OutlinedButton(
                                  onPressed: () {
                                    // setState(() {
                                    //   sortSelected = "isOldest";
                                    //   debugPrint(sortSelected);
                                    // });
                                    EventFilter.sortBySelected(SortBy.Asc);
                                  },
                                  style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 44, vertical: 12),
                                      side: BorderSide(
                                          color:  Colors.grey)),
                                  child: const Text("Oldest",
                                      style: TextStyle(color: Colors.black))),
                            ],
                          ),
                        ],
                      )),
                      // เพิ่มรายการ filter ตามต้องการ
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 10,
                      color: Colors.grey.shade300,
                    )
                  ]),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(69, 32, 204, 0.2),
                            padding: const EdgeInsets.symmetric(horizontal: 52),
                            // fixedSize: Size.fromWidth(56)
                          ),
                          onPressed: () {
                            EventFilter.sortBySelected(
                                SortBy.Desc); // default of sortBy is Newest
                          },
                          child: const Text(
                            "Reset",
                            style: TextStyle(color: Colors.black),
                          )),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(69, 32, 204, 1),
                              // padding: EdgeInsets.symmetric(horizontal: 52),
                              // fixedSize: Size.fromWidth(56)
                            ),
                            onPressed: () {
                              _hideFilterOverlay();
                              context.read<EventBloc>().add(showEventList(
                                  uEmail: widget.uEmail,
                                  uRole: widget.uRole,
                                  selectedStatus: EventFilter.filterStatusBy,
                                  sortBy: EventFilter.sortBy));
                            },
                            child: const Text(
                              "Apply",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
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
