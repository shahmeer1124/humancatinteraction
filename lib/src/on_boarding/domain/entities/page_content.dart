import 'package:equatable/equatable.dart';
import 'package:humancattranslate/core/res/media_res.dart';

class PageContent extends Equatable {
  const PageContent({
    required this.title,
    required this.image,
    required this.description,
  });
  const PageContent.first()
      : this(
          title: 'Welcome to Cat Interaction App',
          image: MediaRes.kitty,
          description:
              "This is the world's first app you can use for interacting with your cat or dog.",
        );
  const PageContent.second()
      : this(
          title: 'Understand your Cat',
          image: MediaRes.kitty2,
          description:
              'Many times we wonder what my pet is trying to say or what an animal is saying you can use this app now to understand what they are saying.',
        );
  const PageContent.third()
      : this(
          title: 'Become Friend with the cats.',
          image: MediaRes.kitty3,
          description:
              'Now you can talk with a cat by delivering a message to them in their language',
        );
  final String title;
  final String image;
  final String description;

  @override
  List<Object?> get props => [image, title, description];
}
