import '../../domain/entities/post.dart';

class PostModel extends Post{
const  PostModel({super.id, required super.title, required super.body});

factory PostModel.fromJSON(Map<String,dynamic>json){
return PostModel(id: json['id'], title: json['title'],body: json['body'],);
}

Map<String,dynamic>toJSON(){
  return {
    'id':id,
    'title':title,
    'body':body
  };
}
}