import 'package:arrivo_task/app/post/cubit/post_cubit.dart';
import 'package:arrivo_task/app/post/model/post_model.dart';
import 'package:arrivo_task/app/post/model/user_model.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsDataSource extends DataTableSource {
  PostsDataSource({
    this.filterPostList,
    this.users,
    this.context,
  });

  final List<PostModel>? filterPostList;
  final List<UserModel>? users;
  final BuildContext? context;

  @override
  DataRow getRow(int index, [Color? color]) {
    List<String> userName = [];
    for (var post in filterPostList!) {
      for (var user in users!) {
        if (post.userId == user.id) {
          userName.add(user.name.toString());
        }
      }
    }
    return DataRow2.byIndex(
      index: index,
      onSelectChanged: (val) {
        context!.read<PostCubit>().onSelect(index, val!);
      },
      selected: filterPostList![index].selected,
      cells: [
        DataCell(Text(filterPostList![index].id.toString())),
        DataCell(Text(userName[index])),
        DataCell(Text(filterPostList![index].title.toString())),
        DataCell(Text(filterPostList![index].body.toString())),
      ],
    );
  }

  @override
  int get rowCount => filterPostList!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
