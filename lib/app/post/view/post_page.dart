import 'package:arrivo_task/app/post/cubit/post_cubit.dart';
import 'package:arrivo_task/app/post/model/post_model.dart';
import 'package:arrivo_task/app/post/model/user_model.dart';
import 'package:arrivo_task/app/table/table_data_source.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostCubit()..fetchAllData(),
      child: const PostView(),
    );
  }
}

class PostView extends StatelessWidget {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          if (state.status == PostStatus.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == PostStatus.failure) {
            return Center(
              child: Center(
                child: Text('something is wrong'),
              ),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ActionHeader(),
                Expanded(
                  child: PostList(
                    users: state.users,
                    filterPostList: state.filterPostList,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class ActionHeader extends StatefulWidget {
  const ActionHeader({super.key});

  @override
  State<ActionHeader> createState() => _ActionHeaderState();
}

class _ActionHeaderState extends State<ActionHeader> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _searchController,
              onFieldSubmitted: (val) =>
                  context.read<PostCubit>().onSearchSubmit(val),
              decoration: InputDecoration(
                hintText: 'Search by title',
                suffixIcon: Icon(
                  Icons.search,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () => context.read<PostCubit>().onDelete(),
          ),
        ],
      ),
    );
  }
}

class PostList extends StatefulWidget {
  const PostList({
    super.key,
    required this.users,
    required this.filterPostList,
  });

  final List<UserModel> users;
  final List<PostModel> filterPostList;

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _rowsPerPage1 = PaginatedDataTable.defaultRowsPerPage;

  @override
  Widget build(BuildContext context) {
    PostsDataSource tableSource = PostsDataSource(
      filterPostList: widget.filterPostList,
      users: widget.users,
      context: context,
    );
    int tableItemsCount = tableSource.rowCount;
    bool isRowCountLessDefaultRowsPerPage =
        widget.filterPostList.length < defaultRowsPerPage;
    _rowsPerPage =
        isRowCountLessDefaultRowsPerPage ? tableItemsCount : defaultRowsPerPage;
    return PaginatedDataTable2(
      rowsPerPage:
      isRowCountLessDefaultRowsPerPage ? _rowsPerPage : _rowsPerPage1,
      onRowsPerPageChanged: widget.filterPostList.length <= 10
          ? null
          : (rowCount) {
              setState(() {
                _rowsPerPage1 = rowCount!;
              });
            },
      minWidth: 600,
      columns: [
        DataColumn2(label: Text('Id'), size: ColumnSize.S),
        DataColumn2(label: Text('Posted By'), size: ColumnSize.L),
        DataColumn2(label: Text('Title'), size: ColumnSize.L),
        DataColumn2(label: Text('Body'), size: ColumnSize.L),
      ],
      source: tableSource,
    );
  }
}
