// the following values are total value, not /100g value
// OCR process: Scan -> input total volume -> calculate total nutrients values -> store
class FoodProduct {
  String name;
  String category;
  double volumeOrweight;

  double energy = 0;
  double protein = 0;
  double totalFat = 0;
  double saturatedFat = 0;
  double transFat = 0;
  double carbohydrates = 0;
  double dietarytFibre = 0;
  double sugars = 0;
  double sodium = 0;

  double energy_100 = 0;
  double protein_100 = 0;
  double totalFat_100 = 0;
  double saturatedFat_100 = 0;
  double transFat_100 = 0;
  double carbohydrates_100 = 0;
  double dietarytFibre_100 = 0;
  double sugars_100 = 0;
  double sodium_100 = 0;

  String image;
  String grade;
  List<String> ingredients=[];

  double star = 0; //average rating by users

  FoodProduct({
    this.name,
    this.category,
    this.volumeOrweight,
    this.energy,
    this.protein,
    this.totalFat,
    this.saturatedFat,
    this.transFat,
    this.carbohydrates,
    this.dietarytFibre,
    this.sugars,
    this.sodium,
    this.energy_100,
    this.protein_100,
    this.totalFat_100,
    this.saturatedFat_100,
    this.transFat_100,
    this.carbohydrates_100,
    this.dietarytFibre_100,
    this.sugars_100,
    this.sodium_100,
    this.image,
    this.ingredients,
    this.grade,
    this.star,
  });



  FoodProduct copy(FoodProduct temp){
    this.name = temp.name;
    this.category = temp.category;
    this.volumeOrweight= temp.volumeOrweight;

    this.energy = temp.energy;
    this.protein = temp.protein;
    this.totalFat = temp.totalFat;
    this.saturatedFat = temp.saturatedFat;
    this.transFat = temp.transFat;
    this.carbohydrates = temp.carbohydrates;
    this.dietarytFibre = temp.dietarytFibre;
    this.sugars = temp.sugars;
    this.sodium = temp.sodium;

    this.image= temp.image;
    this.grade= temp.grade;
    this.ingredients = temp.ingredients;

    this.star = temp.star; //average rating by users
  }

  String getName(){
    return this.name;
  }

  ScoreArray calculateGrade() {
    //this function will calculate grade and change this.product.grade and return a score array object
    //the recommendation are follow hkgov https://www.cfs.gov.hk/english/nutrient/nutrient.php
    // and WWO standard https://www.who.int/news-room/fact-sheets/detail/healthy-diet
    // Different person have different recommend daily intake based on weight/height/sex.
    // To make a general grade for users to reference, the recommend maximum daily intake values in the following
    // are based on an average body weight of 65kg for men
    double maxCalories = 2400;
    double maxProtein =
        maxCalories * 0.15 / 4; //One gram of protein provides 4 kcal.
    double maxCarbohydrate =
        maxCalories * 0.75 / 4; //One gram of carbohydrate provides 4 kcal.
    double maxFat =
        maxCalories * 0.3 / 9; //Fat provides 9 kcal for each gram of fat.
    //these 3 values should added up to be 100% of max calories per day, but the percentage can varies,
    //For example, 100% calories = 15% Proteins+ 55% Carbohydrate +30% Fat
    //or 100% calories = 10% Proteins+ 70% Carbohydrate +20% Fat are also fine
    double minDietaryfibre = 25; //Not less than 25g per day.
    double maxSugars =
        maxCalories * 0.1 / 4; // One gram of sugar provides 4 kcal.
    double maxSaturatedfat = maxCalories * 0.1 / 9;
    double maxTransfat = maxCalories * 0.01 / 9;
    double maxSodium = 5000;
    ScoreArray scoreArray = new ScoreArray();
    this.calculateTotalNutrient();
    this.printproduct();

    if (this.sugars >= maxSugars * 0.3) {
      scoreArray.score = scoreArray.score - 1;
      scoreArray.cautions++;
      scoreArray.messagearray.add(Message(
          "Too Sweet: This product contains too much sugar", "cautions"));
    }
    if (this.sugars_100 == 0) {
      scoreArray.score = scoreArray.score + 2;
      scoreArray.cautions++;
      scoreArray.messagearray.add(Message("Unsweetened", "checks"));
    }
    if (this.transFat_100 > 0) {
      scoreArray.score = scoreArray.score - 1;
      scoreArray.cautions++;
      scoreArray.messagearray
          .add(Message("This product contains trans fat", "cautions"));
    }
    if (this.totalFat > maxFat * 0.3) {
      scoreArray.score = scoreArray.score - 2;
      scoreArray.cautions++;
      scoreArray.messagearray
          .add(Message("This product contains too much fat", "cautions"));
    }
    if (this.saturatedFat > maxSaturatedfat * 0.3) {
      scoreArray.score = scoreArray.score - 1;
      scoreArray.cautions++;
      scoreArray.messagearray.add(
          Message("This product contains too much saturated fat", "cautions"));
    }
    if (this.sodium > maxSodium * 0.3) {
      scoreArray.score = scoreArray.score - 2;
      scoreArray.cautions++;
      scoreArray.messagearray.add(Message(
          "Too Salty! This product contains too much salt", "cautions"));
    }
    if (this.dietarytFibre > minDietaryfibre * 0.3) {
      scoreArray.score = scoreArray.score + 2;
      scoreArray.checks++;
      scoreArray.messagearray
          .add(Message("Contains a lot of dietary Fibre!", "checks"));
    }
    test(String value) => value.contains("Sweetener");
    test1(String value) => value.contains("Sugar");
    if (this.ingredients.any(test) == false && this.sugars > 0 && this.ingredients.any(test1) == false) {
      scoreArray.score = scoreArray.score + 2;
      scoreArray.checks++;
      scoreArray.messagearray.add(Message(
          "No added sweetners: all sugars come from actual food", "checks"));
    }


    if (this.ingredients.length <= 5) {
      scoreArray.score = scoreArray.score + 2;
      scoreArray.checks++;
      scoreArray.messagearray.add(Message(
          "Minimally Processed: It has a very short ingredient list",
          "checks"));
    }
    this.grade = scoreArray.scoreToGrade();
    print("now grade= " + grade);
    return scoreArray;
  }

  String getGradeImage() {
    String gradeimage;
    print("calling getGradeImage() " + grade); //testing
    if (grade == "A") {
      gradeimage = "assets/images/A-minus.jpg";
    }
    if (grade == "B") {
      gradeimage = "assets/images/A-minus.jpg";
    }
    if (grade == "C") {
      gradeimage = "assets/images/A-minus.jpg";
    }
    if (grade == "D") {
      gradeimage = "assets/images/A-minus.jpg";
    }
    return gradeimage;
  }

  void calculateTotalNutrient() {
    if (this.energy == null) {
      this.energy = this.energy_100 * this.volumeOrweight / 100;
      this.protein = this.protein_100 * this.volumeOrweight / 100;
      this.totalFat = this.totalFat_100 * this.volumeOrweight / 100;
      this.saturatedFat = this.saturatedFat_100 * this.volumeOrweight / 100;
      this.transFat = this.transFat_100 * this.volumeOrweight / 100;
      this.carbohydrates = this.carbohydrates_100 * this.volumeOrweight / 100;
      this.dietarytFibre = this.dietarytFibre_100 * this.volumeOrweight / 100;
      this.sugars = this.sugars_100 * this.volumeOrweight / 100;
      this.sodium = this.sodium_100 * this.volumeOrweight / 100;
    }
    if (this.energy_100 == null) {
      this.energy_100 = this.energy / this.volumeOrweight;
      this.protein_100 = this.protein / this.volumeOrweight;
      this.totalFat_100 = this.totalFat / this.volumeOrweight;
      this.saturatedFat_100 = this.saturatedFat / this.volumeOrweight;
      this.transFat_100 = this.transFat / this.volumeOrweight;
      this.carbohydrates_100 = this.carbohydrates / this.volumeOrweight;
      this.dietarytFibre_100 = this.dietarytFibre / this.volumeOrweight;
      this.sugars_100 = this.sugars / this.volumeOrweight;
      this.sodium_100 = this.sodium / this.volumeOrweight;

    }
  }

  double getNutrientDouble(String temp) {
    double result = -1;
    if (temp == "energy") {
      result = this.energy;
    }
    if (temp == "protein") {
      result = this.protein;
    }
    if (temp == "totalFat") {
      result = this.totalFat;
    }
    if (temp == "saturatedFat") {
      result = this.saturatedFat;
    }
    if (temp == "transFat") {
      result = this.transFat;
    }
    if (temp == "carbohydrates") {
      result = this.carbohydrates;
    }
    if (temp == "sugars") {
      result = this.sugars;
    }
    if (temp == "sodium") {
      result = this.sodium;
    }
    return result;
  }

  String getNutrientImage(String temp) {
    String result = "not found";
    if (temp == "energy") {
      result = "assets/icons/calories.svg";
    }
    if (temp == "protein") {
      result = "assets/icons/protein.svg";
    }
    if (temp == "totalFat") {
      result = "assets/icons/fat.svg";
    }
    if (temp == "saturatedFat") {
      result = "assets/icons/fat.svg";
    }
    if (temp == "transFat") {
      result = "assets/icons/fat.svg";
    }
    if (temp == "carbohydrates") {
      result = "assets/icons/carb.svg";
    }
    if (temp == "sugars") {
      result = "assets/icons/carb.svg";
    }
    if (temp == "sodium") {
      result = "assets/icons/sodium.svg";
    }
    return result;
  }

  void printproduct() {
    print("printing " + this.name + '\n');

    print(this.energy.toString() + '\n');
    print(this.protein.toString() + '\n');
    print(this.totalFat.toString() + '\n');
    print(this.saturatedFat.toString() + '\n');
    print(this.transFat.toString() + '\n');
    print(this.carbohydrates.toString() + '\n');
    print(this.dietarytFibre.toString() + '\n');
    print(this.sugars.toString() + '\n');
    print(this.sodium.toString() + '\n');
    print("printing 100: " + this.name + '\n');
    print(this.energy_100.toString() + '\n');
    print(this.protein_100.toString() + '\n');
    print(this.totalFat_100.toString() + '\n');
    print(this.saturatedFat_100.toString() + '\n');
    print(this.transFat_100.toString() + '\n');
    print(this.carbohydrates_100.toString() + '\n');
    print(this.dietarytFibre_100.toString() + '\n');
    print(this.sugars_100.toString() + '\n');
    print(this.sodium_100.toString() + '\n');
  }



}

class ScoreArray {
  //this is a simple class to store all required information in scorepage
  String grade = "C";
  int checks = 0;
  int cautions = 0;
  int score = 6;
  List<Message> messagearray = [];

  String scoreToGrade() {
    print("calling scoreToGrade score=" + score.toString());
    if (score < 3) {
      grade = "D";
    }
    if (score > 3) {
      grade = "C";
    }
    if (score > 6) {
      grade = "B";
    }
    if (score > 9) {
      grade = "A";
    }
    return grade;
  }

}

class Message {
  String message;
  String type;

  Message(this.message, this.type);
}
