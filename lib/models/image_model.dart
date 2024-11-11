class ImageModel {
  final String? imageUrl;
  final String? smallImageUrl;
  final String? largeImageUrl;

  ImageModel({
    this.imageUrl,
    this.smallImageUrl,
    this.largeImageUrl,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      imageUrl: json['image_url'],
      smallImageUrl: json['small_image_url'],
      largeImageUrl: json['large_image_url'],
    );
  }
}