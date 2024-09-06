import 'package:flutter/material.dart';

/*
  MODO DE USO:
  - Crear el controller
  final CustomAnimatedListController<String> _controller = CustomAnimatedListController();

  - En el constructor del controller se pueden modificar las animaciones al
    agregar o eliminar, el tiempo de duración y el widget que se mostrará cuando
    se elimina un elemento
    final CustomAnimatedListController<String> _controllerList = CustomAnimatedListController(
      addAnimatedListGITransition: CustomAnimatedListTransition.FadeTransition,
      removeAnimatedListGITransition: CustomAnimatedListTransition.RotationTransition,
      addDuration: Duration(milliseconds: 1000),
      removeDuration: Duration(milliseconds: 500),
      removePlaceholder: Text("Me estoy borrando")
    );

  - Usar como widget
  CustomAnimatedListWidget<String>(
    controller: _controller,
    builder: (context, index) {
      return ListTile(
        title: Text(_controller.getItem(index)),
        subtitle: Text(index.toString()),
      );
    },
  )

  - Usar el controller para adicionar y eliminar elementos
  _controller.addItem("Hola mundo");
  _controller.removeItem(0);
*/

typedef CustomAnimatedListBuilder = Widget Function(
    BuildContext context, int index);

enum CustomAnimatedListTransition {
  NoTransition,
  FadeTransition,
  SizeTransition,
  RotationTransition,
  ScaleTransition,
  SlideTransitionUp,
  SlideTransitionDown,
  SlideTransitionLeft,
  SlideTransitionRight,
}

Widget getTransition(
    {required CustomAnimatedListTransition animatedListGITransition,
    required Widget child,
    required Animation<double> animation}) {
  switch (animatedListGITransition) {
    case CustomAnimatedListTransition.NoTransition:
      return child;
    case CustomAnimatedListTransition.FadeTransition:
      return FadeTransition(
        key: UniqueKey(),
        opacity: animation,
        child: child,
      );
    case CustomAnimatedListTransition.SizeTransition:
      return SizeTransition(
        key: UniqueKey(),
        sizeFactor: animation,
        child: child,
      );
    case CustomAnimatedListTransition.RotationTransition:
      return RotationTransition(
        key: UniqueKey(),
        turns: animation,
        child: child,
      );

    case CustomAnimatedListTransition.ScaleTransition:
      return ScaleTransition(
        key: UniqueKey(),
        scale: animation,
        child: child,
      );
    case CustomAnimatedListTransition.SlideTransitionUp:
    case CustomAnimatedListTransition.SlideTransitionDown:
    case CustomAnimatedListTransition.SlideTransitionRight:
    case CustomAnimatedListTransition.SlideTransitionLeft:
      double dx = 0, dy = 0;
      if (animatedListGITransition ==
          CustomAnimatedListTransition.SlideTransitionLeft)
        dx = 0.25;
      else if (animatedListGITransition ==
          CustomAnimatedListTransition.SlideTransitionRight)
        dx = -0.25;
      else if (animatedListGITransition ==
          CustomAnimatedListTransition.SlideTransitionUp)
        dy = 0.25;
      else
        dy = -0.25;
      return SlideTransition(
        key: UniqueKey(),
        position: animation.drive(
          Tween<Offset>(
            begin: Offset(dx, dy),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.linearToEaseOut)),
        ),
        child: child,
      );
  }
}

class CustomAnimatedListController<T> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  GlobalKey<AnimatedListState> get key => _key;
  List<T> _items = [];
  List<T> get items => _items;

  CustomAnimatedListController({
    this.addDuration = const Duration(milliseconds: 600),
    this.removeDuration = const Duration(milliseconds: 600),
    this.removePlaceholder = const SizedBox(width: 40, height: 40),
    this.addAnimatedListGITransition =
        CustomAnimatedListTransition.SizeTransition,
    this.removeAnimatedListGITransition =
        CustomAnimatedListTransition.SizeTransition,
  });

  final Duration addDuration;
  final CustomAnimatedListTransition addAnimatedListGITransition;
  final Duration removeDuration;
  final CustomAnimatedListTransition removeAnimatedListGITransition;
  final Widget removePlaceholder;

  void addAll(List<T> newItems) {
    if (newItems.isEmpty) return;
    final startIndex = _items.length;
    _items.addAll(newItems);
    if (_key.currentState != null) {
      _key.currentState!
          .insertAllItems(startIndex, newItems.length, duration: addDuration);
    }
  }

  void addItem(T item) {
    _items.add(item);
    if (_key.currentState != null) {
      _key.currentState!.insertItem(_items.length - 1, duration: addDuration);
    }
  }

  void insertItem(int index, T item) {
    if (index >= _items.length) {
      addItem(item);
      return;
    }
    if (index < 0) index = 0;
    _items.insert(index, item);
    if (_key.currentState != null) {
      _key.currentState!.insertItem(index, duration: addDuration);
    }
  }

  void replaceAll(List<T> newItems) {
    clear();
    addAll(newItems);
  }

  void mergeBegin(List<T> newItems) {
    _merge(newItems, 0);
  }

  void mergeEnd(List<T> newItems) {
    _merge(newItems, 1);
  }

  void mergeInOrder(List<T> newItems) {
    _merge(newItems, -1);
  }

  void _merge(List<T> newItems, int orderType) {
    if (newItems.isEmpty) {
      clear();
      return;
    }
    if (_items.isEmpty) {
      addAll(newItems);
      return;
    }
    if (_items.length == newItems.length) {
      bool isEquals = true;
      for (var i = 0; i < _items.length; ++i) {
        if (_items[i] != newItems[i]) {
          isEquals = false;
          break;
        }
      }
      if (isEquals) {
        return;
      }
    }
    List<bool> existList = List.filled(newItems.length, false);
    for (int i = 0; i < _items.length; i++) {
      T item = getItem(i);
      final index = newItems.indexOf(item);
      if (index == -1) {
        removeItem(i);
        i--;
      } else {
        existList[index] = true;
      }
    }
    if (_items.length == newItems.length) return;
    for (int i = 0; i < newItems.length; i++) {
      if (existList[i]) continue;
      /*
      orderType
      0 - al inicio
      1 - al final
      other - en el orden
      */
      if (orderType == 0) {
        insertItem(0, newItems[i]);
      } else if (orderType == 0) {
        addItem(newItems[i]);
      } else {
        insertItem(i, newItems[i]);
      }
    }
  }

  void removeItem(int index) {
    if (_key.currentState != null) {
      _key.currentState!.removeItem(index, (context, animation) {
        return getTransition(
            animatedListGITransition: removeAnimatedListGITransition,
            child: removePlaceholder,
            animation: animation);
      }, duration: removeDuration);
    }
    _items.removeAt(index);
  }

  void clear() {
    if (_key.currentState != null) {
      _key.currentState!.removeAllItems(
          (context, animation) => getTransition(
              animatedListGITransition: removeAnimatedListGITransition,
              child: removePlaceholder,
              animation: animation),
          duration: removeDuration);
    }
    _items.clear();
  }

  T getItem(int index) => _items[index % _items.length];
}

// ignore: must_be_immutable
class CustomAnimatedListWidget<T> extends StatelessWidget {
  CustomAnimatedListWidget(
      {Key? key,
      this.scrollController,
      this.physics,
      this.items = const [],
      required this.controller,
      required this.builder})
      : super(key: key) {
    controller.mergeInOrder(items);
  }

  final ScrollController? scrollController;
  final ScrollPhysics? physics;
  final List<T> items;
  late CustomAnimatedListController<T> controller;
  final CustomAnimatedListBuilder builder;

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
        physics: physics,
        shrinkWrap: true,
        controller: scrollController,
        key: controller.key,
        initialItemCount: controller.items.length,
        itemBuilder: (context, index, animation) {
          return getTransition(
              animatedListGITransition: controller.addAnimatedListGITransition,
              child: builder(context, index),
              animation: animation);
        });
  }
}
