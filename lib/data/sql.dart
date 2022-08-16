import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/models.dart';

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
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tablePlants ( 
  ${PlantFields.id} $idType, 
  ${PlantFields.title} $textType,
  ${PlantFields.dateReminder} $textType,
  ${PlantFields.description} $textType,
  ${PlantFields.image} $textType,
  ${PlantFields.createdTime} $textType,
  ${PlantFields.timeReminder} $textType,
  ${PlantFields.completed} $boolType,
  ${PlantFields.watering} $boolType,
  ${PlantFields.weeding} $boolType,
  ${PlantFields.sowing} $boolType,
  ${PlantFields.nurseryBed} $boolType,
  ${PlantFields.mulching} $boolType,
  ${PlantFields.potting} $boolType,
  ${PlantFields.gapFiling} $boolType,
  ${PlantFields.spraying} $boolType,
  ${PlantFields.fertilizing} $boolType,
  ${PlantFields.thinning} $boolType,
  ${PlantFields.pruning} $boolType,
  ${PlantFields.numberWatered} $integerType, 
  ${PlantFields.numberWeeded} $integerType, 
  ${PlantFields.startedPlants} $integerType,
  ${PlantFields.leftPlants} $integerType
  )
''');
  }

  Future<PlantModel> create(PlantModel plant) async {
    final db = await instance.database;

    final id = await db.insert(tablePlants, plant.toJson());
    return plant.copy(id: id);
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
