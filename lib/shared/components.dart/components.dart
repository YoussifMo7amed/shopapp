
// ignore_for_file: constant_identifier_names, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/layout/shop_layout/cubit/cubit.dart';
import 'package:shopapp/shared/cubit/cubit.dart';


Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required void Function() function,
  required String text,
}) =>
    Container(
        color: background,
        width: width,
        height: 50.0,
        child: MaterialButton(
          onPressed: function,
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ));
Widget dfaultFormField(
        {required TextEditingController controller,
        required TextInputType type,
        void Function(String)? onChange,
        void Function(String)? onsubmit,
        String? Function(String?)? validator,
        required String label,
        required IconData? prefix,
        bool ispassword = false,
        IconData? sufix,
        void Function()? ontap,
        void Function()? sufixFunction}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: ispassword,
      onChanged: onChange,
      onFieldSubmitted: onsubmit,
      validator: validator,
      onTap: ontap,
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefix),
          suffixIcon: sufix != null
              ? IconButton(onPressed: sufixFunction, icon: Icon(sufix))
              : null,
          border: const OutlineInputBorder()),
    );

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        Appcubit.get(context).deleteData(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
              color: const Color(0xff414452),
              borderRadius: BorderRadius.circular(50.0)),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 40.0,
                child: Text('${model['time']}'),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${model['title']}',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[400]),
                      ),
                      Text(
                        '${model['date']}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.blue,
                        ),
                      )
                    ]),
              ),
              const SizedBox(
                width: 15.0,
              ),
              IconButton(
                  onPressed: () {
                    Appcubit.get(context)
                        .updateData(status: 'done', id: model['id']);
                  },
                  icon: const Icon(
                    Icons.check_box,
                    color: Colors.blue,
                  )),
              IconButton(
                  onPressed: () {
                    Appcubit.get(context)
                        .updateData(status: 'Archived', id: model['id']);
                  },
                  icon: const Icon(
                    Icons.archive,
                    color: Colors.yellowAccent,
                  )),
            ],
          ),
        ),
      ),
    );

Widget tasksBuilder({
  required List<Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) {
          return buildTaskItem(tasks[index], context);
        },
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 20.0,
          ),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),
        itemCount: tasks.length,
      ),
      fallback: (context) => const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 100.0,
              color: Colors.grey,
            ),
            Text(
              'No Tasks Yet, Please Add Some Tasks',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );



Future<bool?> showToast({String? msg, ToastState? state}) =>
    Fluttertoast.showToast(
        msg: msg!,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: changeColor(state!),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { Success, Error, Warning }

Color? changeColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.Success:
      color = Colors.green;
      break;
    case ToastState.Error:
      color = Colors.red;
      break;
      case ToastState.Warning:
      color =Colors.amber;
      break;
      }
      return color;
}
void printFullText(String? text)
{
  final pattern = RegExp('.{1,888}');
  pattern.allMatches(text!).forEach((match)=>print(match.group(0)));
}

Widget buildListproduct( model,context,{bool isOldprice =true})=> SizedBox(
      height: 150,
     
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image(
                    image: NetworkImage(
                      model.image! ),
                    height: 120,
                    width: 120,
                  ),
                  if (model.discount != 0&&isOldprice)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: const Text(
                        'Discount',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    )
                ],
              ),
              const SizedBox(width: 20.0,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(fontSize: 14.0, height: 1.3),
                      ),
                const Spacer()
                 ,     Row(
                        children: [
                          Text(
                            '${model.price!.round()}',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.blue, height: 1.3),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          if (model.discount!= 0&&isOldprice)
                            Text(
                              '${model.oldPrice}',
                              style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                  height: 1.3),
                            ),
                          const Spacer(),
                          CircleAvatar(
                            
                            backgroundColor: shopcubit.get(context).favorites[model.id]!?Colors.red:Colors.grey,
                            child: IconButton(
                            color: Colors.white,
                                onPressed: () {
                                  shopcubit.get(context).ChangeFavorites(model.id!);
                                },
                                icon: const Icon(
                                  Icons.favorite_border_outlined,
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
      ),
    );
    void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
 