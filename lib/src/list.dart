import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class animat_list extends StatefulWidget {
  @override
  _animat_listState createState() => _animat_listState();
}

class _animat_listState extends State<animat_list> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<String> items_list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated List'),
      ),
      body: AnimatedList(
        key: listKey,
        initialItemCount: items_list.length,
        itemBuilder: (context, index, animation) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 150),
            child: SlideAnimation(
              verticalOffset: 50,
              child: FadeInAnimation(
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Item ${items_list[index]}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.remove_circle,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _removeItem(index);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          addItem();
        },
      ),
    );
  }

  void addItem() {
    final int newIndex = items_list.length;
    items_list.add((newIndex + 1).toString());
    listKey.currentState?.insertItem(newIndex);
  }

  void _removeItem(int index) {
    final removedItem = items_list[index];
    items_list.removeAt(index);
    listKey.currentState?.removeItem(
      index,
      (context, animation) {
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 500),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: SizeTransition(
                sizeFactor: animation,
                child: Container(
                  height: 50,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Item $removedItem',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.remove_circle,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
