class Student{
  String studentId;
  String studentName;
  int studentScores;

  Student({
    this.studentId,
    this.studentName,
    this.studentScores
  });

  factory Student.fromJson(Map<String, dynamic> parsedJson){
    return Student(
        studentId: parsedJson['id'],
        studentName : parsedJson['name'],
        studentScores : parsedJson ['score']
    );
  }
}

class BBSinfo{
  int id;
  String title;
  String author;
  String board;
  String link;
  BBSinfo({
    this.id,
    this.author,
    this.board,
    this.link,
    this.title
  });
  factory BBSinfo.fromJson(Map<String, dynamic> parsedJson){
    return BBSinfo(
      id: parsedJson['id'],
      title: parsedJson['title'],
      author: parsedJson['author'],
      board: parsedJson['board'],
      link: parsedJson['link']
    );
  }
}