library z_grouped_list;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'utils/utils.dart';
import 'package:collection/collection.dart';

//ignore: must_be_immutable
class PaginableGroupedList<T, E> extends StatefulWidget {
  /// your data list
  final List<T> items;

  /// The item you need to sort by
  /// A Function which maps an element to its grouped value
  /// example: fetch the year integer of your data , and return this integer
  final E Function(T) sortBy;

  /// item widget
  final Widget Function(BuildContext, T) itemBuilder;

  /// group separator widget
  final Widget Function(E) groupSeparatorBuilder;

  /// how many items horizontally in a grid
  int? crossAxisCount;

  /// pass in a custom gridDelegate
  SliverGridDelegate? gridDelegate;

  /// Should organize in a descending order?
  /// true by default
  bool descendingOrder;

  late bool _isGrid;
  final bool sortEnable;
  static final List _sortHeaders = [];

  /// It takes an async function which will be executed when the scroll is almost at the end.
  final Future<void> Function() loadMore;
  final bool? isLastPage;

  /// It takes a widget which will be displayed at the bottom of the scrollview to indicate the user that
  /// the async function we passed to the `loadMore` parameter is being executed.
  final Widget progressIndicatorWidget;

  /// It takes a function which contains two parameters, one being of type `Exception` and other of type
  /// `Function()`. It returns a widget which will be displayed at the bottom of the scrollview when an
  /// exception occurs in the async function which we passed to the `loadMore` parameter.
  ///
  /// The parameter with type `Exception` will contain the exception which occured while executing the
  /// function passed to the parameter `loadMore` if exception occured, and the parameter with type `Function()`
  /// will contain the same function which we passed to the `loadMore` parameter.
  final Widget Function(Exception exception, void Function() tryAgain) errorIndicatorWidget;

  ///Normal List View
  PaginableGroupedList(
      {Key? key,
        required this.items,
        required this.sortBy,
        required this.itemBuilder,
        required this.groupSeparatorBuilder,
        required this.isLastPage,
        required this.loadMore,
        required this.progressIndicatorWidget,
        required this.errorIndicatorWidget,
        this.sortEnable = true,
        this.descendingOrder = true})
      : super(key: key) {
    _isGrid = false;
  }

  /// Grid List
  PaginableGroupedList.grid(
      {Key? key,
        required this.items,
        required this.sortBy,
        required this.itemBuilder,
        required this.groupSeparatorBuilder,
        this.crossAxisCount,
        this.gridDelegate,
        required this.isLastPage,
        required this.loadMore,
        required this.progressIndicatorWidget,
        required this.errorIndicatorWidget,
        this.sortEnable = true,
        this.descendingOrder = true})
      : super(key: key) {
    _isGrid = true;
    assert(crossAxisCount != null || gridDelegate != null);
  }

  @override
  State<PaginableGroupedList<T, E>> createState() => _PaginableGroupedListState<T, E>();
}

class _PaginableGroupedListState<T, E> extends State<PaginableGroupedList<T,E>> {
  late ValueNotifier<LastItem> valueNotifier;

  late bool isValueNotifierDisposed;

  late bool isLoadMoreBeingCalled;

  late Exception exception;

  void tryAgain() => performPagination();

  Future<void> performPagination() async {
    if(widget.isLastPage==false){
      valueNotifier.value = LastItem.progressIndicator;
      isLoadMoreBeingCalled = true;
      try {
        await widget.loadMore();
        isLoadMoreBeingCalled = false;
        if (!isValueNotifierDisposed) {
          valueNotifier.value = LastItem.emptyContainer;
        }
      } on Exception catch (exception) {
        this.exception = exception;
        if (!isValueNotifierDisposed) {
          valueNotifier.value = LastItem.errorIndicator;
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    valueNotifier = ValueNotifier(LastItem.emptyContainer);
    isValueNotifierDisposed = false;
    isLoadMoreBeingCalled = false;
  }

  @override
  void dispose() {
    valueNotifier.dispose();
    isValueNotifierDisposed = true;
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    _generateHeaderList();

    return groupWidget(context);
  }

  /// Main Widget - (Header & Group)
  Widget groupWidget(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (ScrollUpdateNotification scrollUpdateNotification) {
        if (isAlmostAtTheEndOfTheScroll(scrollUpdateNotification) &&
            isScrollingDownwards(scrollUpdateNotification)) {
          if (!isLoadMoreBeingCalled) {
            performPagination();
          }
        }
        return false;
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (var header in PaginableGroupedList._sortHeaders)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //header
                  widget.groupSeparatorBuilder(header),
                  //group
                  widget._isGrid
                      ? sliverList(getGroupByHeader(header))
                      : normalList(getGroupByHeader(header)),
                ],
              ),
            buildFooter()
          ],
        ),
      ),
    );
  }

  Widget buildFooter(){
    return ValueListenableBuilder<LastItem>(
      valueListenable: valueNotifier,
      builder: (context, value, child) {
        if (value == LastItem.emptyContainer) {
          return Container(
            key: keyForEmptyContainerWidgetOfPaginableListView,
          );
        } else if (value == LastItem.errorIndicator) {
          return widget.errorIndicatorWidget(exception, tryAgain);
        }
        return widget.progressIndicatorWidget;
      },
    );
  }

  // Your Group Widget
  Widget normalList(List currentGroup) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        // use count of group items
        itemCount: currentGroup.length,
        itemBuilder: (context, index) {
          return widget.itemBuilder(context, currentGroup[index]);
        });
  }

  // Your Group Widget
  Widget sliverList(List currentGroup) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        slivers: [
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              // use count of group items
              childCount: currentGroup.length,
                  (context, index) {
                return widget.itemBuilder(context, currentGroup[index]);
              },
            ),
            gridDelegate: widget.gridDelegate ??
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.crossAxisCount ?? 1,
                  childAspectRatio: 2 / 3.2,
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 15,
                ),
          )
        ],
      ),
    );
  }

  // List of headers
  void _generateHeaderList() {
    PaginableGroupedList._sortHeaders.clear();
    var temp = groupBy(widget.items, (e) => widget.sortBy(e));
    List<E> keysList = temp.keys.toList();
    PaginableGroupedList._sortHeaders.addAll(keysList);

    if(widget.sortEnable) {
      //arrange headers
      PaginableGroupedList._sortHeaders.sort((a, b) {
        return widget.descendingOrder ? b.compareTo(a) : a.compareTo(b);
      });
    }
  }

  // List of groups
  getGroupByHeader(var header) {
    List currentGroup = [];

    for (var item in widget.items) {
      if (widget.sortBy(item) == header) {
        currentGroup.add(item);
      }
    }

    return currentGroup;
  }
}