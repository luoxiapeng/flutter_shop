class CategoryBigModel {
  String mallCategoryId;//类别编号
  String mallCategoryName;//类别名称
  List<dynamic> bxMallSubDto; //动态的类别列表
  String image;//类别图片
  Null comments;//列表描述

  CategoryBigModel({
    this.mallCategoryId,
    this.mallCategoryName,
    this.bxMallSubDto,
    this.image,
    this.comments
  });
  //工厂模式-用这种模式可以省略New关键字
  factory CategoryBigModel.formJson(dynamic json){
    return CategoryBigModel(
      mallCategoryId:json['mallCategoryId'],
      mallCategoryName:json['mallCategoryName'],
      bxMallSubDto: json['bxMallSubDto'],
      image:json['image'],
      comments:json['comments']
    );
  }

}
//给外层的data加一个数据模型，让每一项都初始化一下
class CategoryBigListModel {
  List <CategoryBigModel> data;
  CategoryBigListModel(this.data);
  factory CategoryBigListModel.formJson(dynamic json){
    return CategoryBigListModel(
        json.map((i)=>CategoryBigModel.formJson((i))).toList()
    );
  }
  
}