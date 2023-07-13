part of 'post_cubit.dart';

enum PostStatus { initial, loading, success, failure }

final class PostState extends Equatable {
  const PostState({
    this.status = PostStatus.initial,
    this.posts = const <PostModel>[],
    this.filterPostList = const <PostModel>[],
    this.users = const <UserModel>[],
  });

  final PostStatus status;
  final List<PostModel> posts;
  final List<PostModel> filterPostList;
  final List<UserModel> users;

  PostState copyWith({
    PostStatus? status,
    List<PostModel>? post,
    List<PostModel>? filterPostList,
    List<UserModel>? user,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: post ?? this.posts,
      filterPostList: filterPostList ?? this.filterPostList,
      users: user ?? this.users,
    );
  }

  @override
  List<Object> get props => [status, posts, filterPostList, users];
}
