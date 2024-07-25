import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/models.dart';
import 'data.dart';

class PlantDatabase {
  static final PlantDatabase instance = PlantDatabase._init();

  static Database? _database;

  PlantDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('plants.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const blobType = 'BLOB NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tablePlants ( 
  ${PlantFields.id} $idType, 
  ${PlantFields.title} $textType,
  ${PlantFields.dateReminder} $textType,
  ${PlantFields.description} $textType,
  ${PlantFields.image} $blobType,
  ${PlantFields.createdTime} $textType,
  ${PlantFields.timeReminder} $textType,
  ${PlantFields.numberWatered} $integerType, 
  ${PlantFields.numberWeeded} $integerType, 
  ${PlantFields.startedPlants} $integerType,
  ${PlantFields.leftPlants} $integerType,
  ${PlantFields.soldPlants} $integerType,
  ${PlantFields.transplantedPlants} $integerType
  )
''');
  }

  Future<PlantModel> create(PlantModel plant) async {
    final db = await instance.database;

    plant.id = await db.insert(tablePlants, plant.toJson());
    return plant.copy(id: plant.id);
  }

  Future<PlantModel> readPlant(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tablePlants,
      columns: PlantFields.values,
      where: '${PlantFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return PlantModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<PlantModel>> readAllPlants() async {
    final db = await instance.database;

    const orderBy = '${PlantFields.createdTime} ASC';

    final result = await db.query(tablePlants, orderBy: orderBy);

    return result.map((json) => PlantModel.fromJson(json)).toList();
  }

  Future<int> update(PlantModel plant) async {
    final db = await instance.database;

    return db.update(
      tablePlants,
      plant.toJson(),
      where: '${PlantFields.id} = ?',
      whereArgs: [plant.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tablePlants,
      where: '${PlantFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}