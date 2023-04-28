import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// provider is basically a wrapper around the InheritedWidgets
// one of the classes in provider is changeNotifier ChangeNotifierProvider<T extends ChangeNotifier>
// It listens to a ChangeNotifier extended by the model class, exposes it to its children and descendants, and rebuilds depends whenever notifyListeners is called
// To implement provider:
// (1). Create a class which will extended to ChangeNotifier, this Notifier is a Flutter inbuilt class Widget,
// this class “provides change notification to its listeners”. So you can listen to an instance of a ChangeNotifier and being notified when it changes.
// it wil have a properties & a method that will include "notifyingListeners()" method. this notifyingListeners enabled the class to notify it listener when the properties maintained
//changes. Note Since the property created in ref 1 need to be provided to other part of the app then ref 2 is required.
// (2). Wrap ChangeNotifierProvider Widget to the highest hierarchy of required, and it will take the data type which is the class created in ref 1
// (3). ChangeNotifierProvider has a required property called create, it takes an argument, context and return the data that we intend to provide to our app. This would be instance of an object.
// which is the class create  d in ref 1
// (4). To access the data, we use  Provider.of<Data>(context, listen: true).data); to provide data in to respective place we intend to.
// (5) instead of accessing the data with provider.of, you can use consumer. consumer is a widget which is wrap at the point you intend to call the data.
// it takes a datatype which is the class created at ref 1, it also have a builder which takes 3 argument, a. context = context of the build, b. = instance of the data class created in ref 1
// and c. a child = This is here for optimization,if you have a big widget that does not need the value exposed by the provider you can pass it as child and use it in the builder function,
// i.e data that does not need the data inside of the provider, so when the data gets updated, they don’t get re-created.

// return Consumer<CartModel>(
// builder: (context, cart, child) {
// return Text('Total price: ${cart.totalPrice}');
// },
// );

//Note: in case u want to use Consumer in a list view or grid view you can wrap the consumer like below.
// class TasksList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<TaskData>(
//         builder: (context, taskData, child) {
//       return ListView.builder(
//           itemBuilder: (context, index) {
//         final task = taskData.tasks[index];
//         return TaskTile(
//             taskTitle: task.name,
//             isChecked: task.isDone,
//             checkboxCallback: (checkboxState) {
//               taskData.updateTask(task);
//             },


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
      create:(context) => Data(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const MyText(),
          ),
          body: const Level1(),
        ),
      ),
    );
  }
}

class Level1 extends StatelessWidget {
  const Level1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Level2(),
    );
  }
}

class Level2 extends StatelessWidget {
  const Level2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        MyTextField(),
        Level3(),
      ],
    );
  }
}

class Level3 extends StatelessWidget {
  const Level3({super.key});

  @override
  Widget build(BuildContext context) {
    return

      // Text(
      //   Provider.of<Data>(context, listen: true).data);
      // // This is one way of accessing the data using provider.off and below is another way using consumer.

    Consumer<Data>(
      builder: (context,returnedData, child) => Text(
          returnedData.data
        ),
      );
  }
}

class MyText extends StatelessWidget {
  const MyText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(Provider.of<Data>(context, listen: false).data);
    // d listen property of provider.of is an optional property,by default its set as true. this means just
    // get the original assigned data but dont rebuild & re assigned newly entered value
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (newText) {
        Provider.of<Data>(context).changeString(newText);
      },
    );
  }
}
// The provider class the first thing to do
class Data extends ChangeNotifier {
  String data = 'Adams provider'; // the property data that would be consumed elsewhere

  void changeString(String newString) {  // method that would require changes when its needed
    data = newString;
    notifyListeners();
  }
}