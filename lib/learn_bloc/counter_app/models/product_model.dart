class ProductModel {
    int? id;
    String? title;
    double? price;
    String? description;
    Category? category;
    String? image;
    Rating? rating;

    ProductModel({
        this.id,
        this.title,
        this.price,
        this.description,
        this.category,
        this.image,
        this.rating,
    });

}

enum Category {
    ELECTRONICS,
    JEWELERY,
    MEN_S_CLOTHING,
    WOMEN_S_CLOTHING
}

class Rating {
    double? rate;
    int? count;

    Rating({
        this.rate,
        this.count,
    });

}
