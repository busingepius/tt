import "dart:math";

const one =
    "Management of protective fence: Time to time, repairing work of the fence may be needed.";

const two =
    "Management of roads and paths: To keep the roads and paths free from dust and mud, earth filling and lawn mowing may be needed.";

const three =
    "Management of irrigation and Drainage channels: Channels prepared in the nursery should be kept clean for the easy and quick flow of water by removing weeds and silts.";

const four =
    "Management of water sources: Care of the tube well, pond, etc., is to ensure water supply during need.";

const five =
    "Management of temporary plants: Optimum quantities of nutrients and irrigation water are to be plied to the seedlings, saplings, cuttings, layers, and grafts grown in the containers and in a different section of the nursery whenever required. Proper measures against pests and diseases are to be taken. Weeding, mulching, and training are common practices. Extra soil with a sufficient amount of organic matter may be needed to add with the growing media of containers and beds.";

const six =
    "Management permanent plants: For healthy growth and development, proper care and maintenance like pruning, manuring, irrigation, application of insecticides and fungicides against pests and diseases, etc., are to be taken for the permanent plants. To provide shade and to supply stock, scion, and other planting materials.";

const seven =
    "Management of planting material during marketing: At the beginning of the pick period of marketing, the planting material is kept ready for immediate sale in attractive condition. Carefully Ming of Seedling, grafts, layers, cutting, etc., is performed by the laborers.";

const eight =
    "Management of structure: Measures are to be taken to keep the nursery structure like a greenhouse, lath house, net house, polytunnel working shade, office storeroom, etc., in good working condition";

const nine =
    "Management of tools and equipment: To ensure high quality and the maximum quantity of work, the tools and equipment must always be kept in good condition (Sharpe and rust-free).";

const ten =
    "Management of staff: Cordial relations must be maintained with the staff to describe their duties and responsibilities properly, sincerely, and efficiently with inspiration.";

final List<String> hints = [
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten
];

String randomlyPickHint() {
  final random = Random();
  String element = hints[random.nextInt(hints.length)];
  return element;
}