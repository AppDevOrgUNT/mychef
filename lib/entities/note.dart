//this is the placeholder class made to store the data collected from the website
class Note {
  String title;
  String text;

  Note(this.title, this.text);

  //this takes in the map that was converted from the json
  Note.fromJson(Map<String, dynamic> json){
    //Things worth noting:
    //The names inside the [] have to be exactly whats displayed on the API
    //The map is dynamic, so any numbers will automatically be ints, characters chars and so on
    title = json['title'];
    //Converting the ID into a string was necessary for the code to work
    text = json['id'].toString();
  }

  //placeholder function to check if custom messages could be displayed
  Note.ifFails(String ti, String te){
    title = ti;
    text = te;
  }
}