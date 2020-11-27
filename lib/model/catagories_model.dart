class CatagoriesModel{
  String _image;
  String _name;

  CatagoriesModel(this._image, this._name);


  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
      CatagoriesModel.fromMap(Map snapshot):

        _image = snapshot['image'] ?? '',
        _name = snapshot['name'] ?? '';

  toJson(){
    return {
      "image":image,
      "name":name,
    };
  }

}