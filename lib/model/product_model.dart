class ProductModel{
  String _name;
  String _actual_price;
  String _promation_price;
  String _image;
  bool _is_promotion;
  String _sub_catagorie;
  String _catagorie;
  String _about;



  ProductModel(this._name, this._actual_price, this._promation_price,this._image,this._about,this._catagorie,this._is_promotion,this._sub_catagorie);

  String get actual_price => _actual_price;

  set actual_price(String value) {
    _actual_price = value;
  }

  bool get is_promotion => _is_promotion;

  set is_promotion(bool value) {
    _is_promotion = value;
  }

  String get promation_price => _promation_price;

  set promation_price(String value) {
    _promation_price = value;
  }
  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get sub_catagorie => _sub_catagorie;

  set sub_catagorie(String value) {
    _sub_catagorie = value;
  }

  String get catagorie => _catagorie;

  set catagorie(String value) {
    _catagorie = value;
  }

  String get about => _about;

  set about(String value) {
    _about = value;
  }

  ProductModel.fromMap(Map snapshot):
        _name = snapshot['name'] ?? '',
        _actual_price=snapshot['actual_price']??'',
        _promation_price=snapshot['promotion_price']?? '',
        _image = snapshot['image'] ?? '',
        _about=snapshot['about']??'',
        _catagorie=snapshot['catagorie']??'',
        _is_promotion=snapshot['is_promotion'] ?? false,
        _sub_catagorie=snapshot['sub_catagorie']??'';
  toJson(){
    return {
      "name": name,
      "image":image,
      "promotion_price":promation_price,
      "is_promotion":is_promotion,
      "actual_price":actual_price,
      "catagorie":catagorie,
      "sub_catagories":sub_catagorie,
      "about":about,
    };
  }
}
