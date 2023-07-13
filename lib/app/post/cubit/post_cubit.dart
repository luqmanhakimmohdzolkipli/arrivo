import 'dart:developer';

import 'package:arrivo_task/app/post/model/post_model.dart';
import 'package:arrivo_task/app/post/model/user_model.dart';
import 'package:arrivo_task/app/post/repository/post_repository.dart';
import 'package:arrivo_task/app/post/repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(const PostState());

  final UserRepository userRepository = UserRepository();
  final PostRepository postRepository = PostRepository();

  Future<void> fetchUser() async {
    emit(state.copyWith(status: PostStatus.loading));
    try {
      final List<UserModel> user = await userRepository.fetchAllUsers();
      emit(state.copyWith(
        status: PostStatus.success,
        user: user,
      ));
    } on Exception {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<void> fetchPost() async {
    emit(state.copyWith(status: PostStatus.loading));
    try {
      final List<PostModel> post = await postRepository.fetchAllPosts();
      emit(state.copyWith(
        status: PostStatus.success,
        post: post,
        filterPostList: post,
      ));
    } on Exception {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<void> fetchAllData() async {
    await fetchUser();
    await fetchPost();
  }

  void onSelect(int index, bool val) {
    final List<PostModel> updatedPosts = List.from(state.filterPostList);
    final PostModel updateSelectedPost =
        state.filterPostList[index].copyWith(selected: val);
    updatedPosts[index] = updateSelectedPost;
    emit(state.copyWith(filterPostList: updatedPosts));
  }

  Future<void> onDelete() async {
    emit(state.copyWith(status: PostStatus.loading));
    for (var post in state.posts) {
      if (post.selected == true) {
        try {
          await postRepository.deletePost(post.id!);
          emit(state.copyWith(status: PostStatus.success));
        } on Exception {
          emit(state.copyWith(status: PostStatus.failure));
        }
      }
    }
  }

  void onSearchSubmit(String val) {
    if (val.isEmpty) {
      emit(state.copyWith(filterPostList: state.posts));
    } else {
      emit(
        state.copyWith(
            filterPostList: state.posts
                .where(
                  (element) => element.title!.toLowerCase().contains(
                        val.toLowerCase(),
                      ),
                )
                .toList()),
      );
    }
  }
}
