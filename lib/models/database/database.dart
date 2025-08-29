import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseModel {

  //ici on utilise le singleton pattern
  static final DatabaseModel _instance = DatabaseModel._internal();
  factory DatabaseModel() => _instance;
  DatabaseModel._internal();

  static Database? _db;

  // Nom et version de la base
  static const String _dbName = 'quizzi.db';
  static const int _dbVersion = 1;

  // Nom de la table categorie et colonnes
  static const String tableCategory = 'categories';
  static const String columnId = 'id';
  static const String columnTitre = 'titre';
  static const String columnDescription = 'description';

  // Nom de la table player et colonnes
  static const String tablePlayer = 'players';
  static const String playerId = 'id';
  static const String playerName = 'name';
  static const String playerScore = 'score';
  static const String playerCategoriesId = 'categorieId';

  // Nom de la table Question et colonnes
  static const String tableQuestion = 'questions';
  static const String questionId = 'id';
  static const String questionText = 'text';
  static const String questionCategorieId = 'questionCategorieId';
  static const String questionPoint = 'questionPoint';


  // Nom de la table Options et colonnes
  static const String tableOption = ' Options';
  static const String optionId = 'id';
  static const String optionText = 'text';
  static const String optionQuestionId = 'optionQuestionId';
  static const String optionIsCorrect = 'isCorrect';

  Future<Database> get database async {
    _db ??= await _initDb();
    return _db!;
  }


  Future<Database> _initDb() async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
        path,
        version: _dbVersion,
      onCreate: _creerDb,
    );
  }

  Future _creerDb(Database db, int version) async{
    //Table Categorie
    await db.execute('''
            CREATE TABLE $tableCategory (
        $columnId TEXT PRIMARY KEY,
        $columnTitre TEXT NOT NULL,
        $columnDescription TEXT NOT NULL
      )
    ''');

    //Table User
    await db.execute('''
            CREATE TABLE $tablePlayer (
        $playerId TEXT PRIMARY KEY,
        $playerName TEXT NOT NULL,
        $playerScore TEXT NOT NULL,
        $playerCategoriesId TEXT NOT NULL,
      )
    ''');

    //Table Questions
    await db.execute('''
            CREATE TABLE $tableQuestion (
        $questionId TEXT PRIMARY KEY,
        $questionText TEXT NOT NULL,
        $questionCategorieId TEXT NOT NULL,
        $questionPoint REAL NOT NULL,
      )
    ''');

    //Table Options
    await db.execute('''
            CREATE TABLE $tableOption (
        $optionId TEXT PRIMARY KEY,
        $optionText TEXT NOT NULL,
        $optionQuestionId TEXT NOT NULL,
        $optionIsCorrect INT NOT NULL,
      )
    ''');

    await insertDefaultCategories(db);
    await insertDefaultQuestionsAndOptions(db);
  }

  /// Méthode pour insérer les catégories par défaut
  Future<void> insertDefaultCategories(Database db) async {
    final defaultCategories = [
      {'id': '1CT', 'titre': 'Informatique', 'description': 'Technologies et programmation'},
      {'id': '2CT', 'titre': 'Santé', 'description': 'Bien-être et médecine'},
      {'id': '3CT', 'titre': 'Art', 'description': 'Peinture, sculpture et créations artistiques'},
      {'id': '4CT', 'titre': 'Sport', 'description': 'Activités physiques et compétitions'},
      {'id': '5CT', 'titre': 'Éducation', 'description': 'Apprentissage et formations'},
      {'id': '6CT', 'titre': 'Finance', 'description': 'Économie, bourse et investissements'},
      {'id': '7CT', 'titre': 'Musique', 'description': 'Art et instruments musicaux'},
      {'id': '8CT', 'titre': 'Cinéma', 'description': 'Films et critiques'},
      {'id': '9CT', 'titre': 'Voyage', 'description': 'Découvertes et aventures'},
      {'id': '10CT', 'titre': 'Mode', 'description': 'Tendances et habillement'},
      {'id': '11CT', 'titre': 'Cuisine', 'description': 'Recettes et gastronomie'},
      {'id': '12CT', 'titre': 'Science', 'description': 'Découvertes et innovations'},
      {'id': '13CT', 'titre': 'Politique', 'description': 'Actualités et débats'},
      {'id': '14CT', 'titre': 'Environnement', 'description': 'Écologie et climat'},
      {'id': '15CT', 'titre': 'Jeux Vidéo', 'description': 'Gaming et e-sport'},
      {'id': '16CT', 'titre': 'Littérature', 'description': 'Livres et romans'},
      {'id': '17CT', 'titre': 'Technologie', 'description': 'Nouvelles inventions et gadgets'},
      {'id': '18CT', 'titre': 'Entrepreneuriat', 'description': 'Business et startups'},
      {'id': '19CT', 'titre': 'Manga et Anime', 'description': 'Manga et Animes'},
    ];

    for (var cat in defaultCategories) {
      await db.insert(tableCategory, cat);
    }
  }

  Future<void> insertDefaultQuestionsAndOptions(Database db) async {
    // Structure attendue : liste de catégories, chacune avec 10 questions
    // Chaque question contient 4 options (une correcte).
    final data = <Map<String, dynamic>>[
      {
        'categoryId': '1CT', // Informatique
        'questions': [
          {
            'id': '1CT_Q1',
            'text': 'Quel langage est utilisé pour développer des apps Flutter ?',
            'point': 1.0,
            'options': [
              {'id': '1CT_Q1_O1', 'text': 'Dart', 'isCorrect': 1},
              {'id': '1CT_Q1_O2', 'text': 'Java', 'isCorrect': 0},
              {'id': '1CT_Q1_O3', 'text': 'Swift', 'isCorrect': 0},
              {'id': '1CT_Q1_O4', 'text': 'PHP', 'isCorrect': 0},
            ]
          },
          {
            'id': '1CT_Q2',
            'text': 'Quel code HTTP signifie « Not Found » ?',
            'point': 1.0,
            'options': [
              {'id': '1CT_Q2_O1', 'text': '404', 'isCorrect': 1},
              {'id': '1CT_Q2_O2', 'text': '200', 'isCorrect': 0},
              {'id': '1CT_Q2_O3', 'text': '500', 'isCorrect': 0},
              {'id': '1CT_Q2_O4', 'text': '302', 'isCorrect': 0},
            ]
          },
          {
            'id': '1CT_Q3',
            'text': 'Quelle commande Git sert à cloner un dépôt distant ?',
            'point': 1.0,
            'options': [
              {'id': '1CT_Q3_O1', 'text': 'git clone', 'isCorrect': 1},
              {'id': '1CT_Q3_O2', 'text': 'git pull', 'isCorrect': 0},
              {'id': '1CT_Q3_O3', 'text': 'git init', 'isCorrect': 0},
              {'id': '1CT_Q3_O4', 'text': 'git merge', 'isCorrect': 0},
            ]
          },
          {
            'id': '1CT_Q4',
            'text': 'Quelle requête SQL sélectionne toutes les lignes de la table users ?',
            'point': 1.0,
            'options': [
              {'id': '1CT_Q4_O1', 'text': 'SELECT * FROM users;', 'isCorrect': 1},
              {'id': '1CT_Q4_O2', 'text': 'GET * FROM users;', 'isCorrect': 0},
              {'id': '1CT_Q4_O3', 'text': 'SHOW TABLE users;', 'isCorrect': 0},
              {'id': '1CT_Q4_O4', 'text': 'FETCH ALL users;', 'isCorrect': 0},
            ]
          },
          {
            'id': '1CT_Q5',
            'text': 'Que signifie CSS ?',
            'point': 1.0,
            'options': [
              {'id': '1CT_Q5_O1', 'text': 'Cascading Style Sheets', 'isCorrect': 1},
              {'id': '1CT_Q5_O2', 'text': 'Creative Style System', 'isCorrect': 0},
              {'id': '1CT_Q5_O3', 'text': 'Coded Sheet Styles', 'isCorrect': 0},
              {'id': '1CT_Q5_O4', 'text': 'Central Style Source', 'isCorrect': 0},
            ]
          },
          {
            'id': '1CT_Q6',
            'text': 'La complexité temporelle de la recherche binaire est…',
            'point': 1.0,
            'options': [
              {'id': '1CT_Q6_O1', 'text': 'O(log n)', 'isCorrect': 1},
              {'id': '1CT_Q6_O2', 'text': 'O(n)', 'isCorrect': 0},
              {'id': '1CT_Q6_O3', 'text': 'O(n²)', 'isCorrect': 0},
              {'id': '1CT_Q6_O4', 'text': 'O(1)', 'isCorrect': 0},
            ]
          },
          {
            'id': '1CT_Q7',
            'text': 'Que signifie JSON ?',
            'point': 1.0,
            'options': [
              {'id': '1CT_Q7_O1', 'text': 'JavaScript Object Notation', 'isCorrect': 1},
              {'id': '1CT_Q7_O2', 'text': 'Java Standard Object Notation', 'isCorrect': 0},
              {'id': '1CT_Q7_O3', 'text': 'JavaScript Oriented Network', 'isCorrect': 0},
              {'id': '1CT_Q7_O4', 'text': 'Joined Style Object Name', 'isCorrect': 0},
            ]
          },
          {
            'id': '1CT_Q8',
            'text': 'À quoi sert une clé primaire (PRIMARY KEY) en base de données ?',
            'point': 1.0,
            'options': [
              {'id': '1CT_Q8_O1', 'text': 'Identifier de façon unique chaque ligne', 'isCorrect': 1},
              {'id': '1CT_Q8_O2', 'text': 'Comprimer les données', 'isCorrect': 0},
              {'id': '1CT_Q8_O3', 'text': 'Chiffrer les colonnes', 'isCorrect': 0},
              {'id': '1CT_Q8_O4', 'text': 'Accélérer uniquement les JOIN', 'isCorrect': 0},
            ]
          },
          {
            'id': '1CT_Q9',
            'text': 'Quelle est la taille d’une adresse IPv4 ?',
            'point': 1.0,
            'options': [
              {'id': '1CT_Q9_O1', 'text': '32 bits', 'isCorrect': 1},
              {'id': '1CT_Q9_O2', 'text': '16 bits', 'isCorrect': 0},
              {'id': '1CT_Q9_O3', 'text': '64 bits', 'isCorrect': 0},
              {'id': '1CT_Q9_O4', 'text': '128 bits', 'isCorrect': 0},
            ]
          },
          {
            'id': '1CT_Q10',
            'text': 'Quelle méthode HTTP est principalement utilisée pour récupérer des données ?',
            'point': 1.0,
            'options': [
              {'id': '1CT_Q10_O1', 'text': 'GET', 'isCorrect': 1},
              {'id': '1CT_Q10_O2', 'text': 'POST', 'isCorrect': 0},
              {'id': '1CT_Q10_O3', 'text': 'PUT', 'isCorrect': 0},
              {'id': '1CT_Q10_O4', 'text': 'DELETE', 'isCorrect': 0},
            ]
          },
        ],
      },
      {
        'categoryId': '2CT', // Santé
        'questions': [
          {
            'id': '2CT_Q1',
            'text': 'Quel organe pompe le sang dans tout le corps ?',
            'point': 1.0,
            'options': [
              {'id': '2CT_Q1_O1', 'text': 'Le cœur', 'isCorrect': 1},
              {'id': '2CT_Q1_O2', 'text': 'Le foie', 'isCorrect': 0},
              {'id': '2CT_Q1_O3', 'text': 'Le pancréas', 'isCorrect': 0},
              {'id': '2CT_Q1_O4', 'text': 'La rate', 'isCorrect': 0},
            ]
          },
          {
            'id': '2CT_Q2',
            'text': 'La température corporelle normale est d’environ…',
            'point': 1.0,
            'options': [
              {'id': '2CT_Q2_O1', 'text': '37°C', 'isCorrect': 1},
              {'id': '2CT_Q2_O2', 'text': '35°C', 'isCorrect': 0},
              {'id': '2CT_Q2_O3', 'text': '39°C', 'isCorrect': 0},
              {'id': '2CT_Q2_O4', 'text': '34°C', 'isCorrect': 0},
            ]
          },
          {
            'id': '2CT_Q3',
            'text': 'La principale source de vitamine D pour le corps humain est…',
            'point': 1.0,
            'options': [
              {'id': '2CT_Q3_O1', 'text': 'La synthèse cutanée via le soleil', 'isCorrect': 1},
              {'id': '2CT_Q3_O2', 'text': 'Le sel de table', 'isCorrect': 0},
              {'id': '2CT_Q3_O3', 'text': 'Le sucre', 'isCorrect': 0},
              {'id': '2CT_Q3_O4', 'text': 'Le poivre', 'isCorrect': 0},
            ]
          },
          {
            'id': '2CT_Q4',
            'text': 'Une pression artérielle « normale » est proche de…',
            'point': 1.0,
            'options': [
              {'id': '2CT_Q4_O1', 'text': '120/80 mmHg', 'isCorrect': 1},
              {'id': '2CT_Q4_O2', 'text': '90/40 mmHg', 'isCorrect': 0},
              {'id': '2CT_Q4_O3', 'text': '200/120 mmHg', 'isCorrect': 0},
              {'id': '2CT_Q4_O4', 'text': '60/30 mmHg', 'isCorrect': 0},
            ]
          },
          {
            'id': '2CT_Q5',
            'text': 'Le VIH est le virus responsable de…',
            'point': 1.0,
            'options': [
              {'id': '2CT_Q5_O1', 'text': 'La maladie du SIDA', 'isCorrect': 1},
              {'id': '2CT_Q5_O2', 'text': 'La rougeole', 'isCorrect': 0},
              {'id': '2CT_Q5_O3', 'text': 'La grippe', 'isCorrect': 0},
              {'id': '2CT_Q5_O4', 'text': 'La varicelle', 'isCorrect': 0},
            ]
          },
          {
            'id': '2CT_Q6',
            'text': 'Quels organes filtrent le sang et produisent l’urine ?',
            'point': 1.0,
            'options': [
              {'id': '2CT_Q6_O1', 'text': 'Les reins', 'isCorrect': 1},
              {'id': '2CT_Q6_O2', 'text': 'Les poumons', 'isCorrect': 0},
              {'id': '2CT_Q6_O3', 'text': 'Le foie', 'isCorrect': 0},
              {'id': '2CT_Q6_O4', 'text': 'L’estomac', 'isCorrect': 0},
            ]
          },
          {
            'id': '2CT_Q7',
            'text': 'Combien de dents possède en général un adulte ?',
            'point': 1.0,
            'options': [
              {'id': '2CT_Q7_O1', 'text': '32', 'isCorrect': 1},
              {'id': '2CT_Q7_O2', 'text': '20', 'isCorrect': 0},
              {'id': '2CT_Q7_O3', 'text': '28', 'isCorrect': 0},
              {'id': '2CT_Q7_O4', 'text': '36', 'isCorrect': 0},
            ]
          },
          {
            'id': '2CT_Q8',
            'text': 'Les antibiotiques sont efficaces contre…',
            'point': 1.0,
            'options': [
              {'id': '2CT_Q8_O1', 'text': 'Les bactéries', 'isCorrect': 1},
              {'id': '2CT_Q8_O2', 'text': 'Les virus', 'isCorrect': 0},
              {'id': '2CT_Q8_O3', 'text': 'Les parasites', 'isCorrect': 0},
              {'id': '2CT_Q8_O4', 'text': 'Les champignons', 'isCorrect': 0},
            ]
          },
          {
            'id': '2CT_Q9',
            'text': 'Que signifie l’acronyme IMC (BMI) ?',
            'point': 1.0,
            'options': [
              {'id': '2CT_Q9_O1', 'text': 'Indice de Masse Corporelle', 'isCorrect': 1},
              {'id': '2CT_Q9_O2', 'text': 'Indice de Métabolisme Cellulaire', 'isCorrect': 0},
              {'id': '2CT_Q9_O3', 'text': 'Indice Minéral Calcique', 'isCorrect': 0},
              {'id': '2CT_Q9_O4', 'text': 'Inspection Médicale Clinique', 'isCorrect': 0},
            ]
          },
          {
            'id': '2CT_Q10',
            'text': 'L’activité physique régulière permet notamment de…',
            'point': 1.0,
            'options': [
              {'id': '2CT_Q10_O1', 'text': 'Réduire le risque cardiovasculaire', 'isCorrect': 1},
              {'id': '2CT_Q10_O2', 'text': 'Augmenter la tension systématiquement', 'isCorrect': 0},
              {'id': '2CT_Q10_O3', 'text': 'Provoquer toujours une anémie', 'isCorrect': 0},
              {'id': '2CT_Q10_O4', 'text': 'Détruire la masse musculaire', 'isCorrect': 0},
            ]
          },
        ],
      },
      {
        'categoryId': '3CT', // Art
        'questions': [
          {
            'id': '3CT_Q1',
            'text': 'Qui a peint la Joconde (Mona Lisa) ?',
            'point': 1.0,
            'options': [
              {'id': '3CT_Q1_O1', 'text': 'Léonard de Vinci', 'isCorrect': 1},
              {'id': '3CT_Q1_O2', 'text': 'Michel-Ange', 'isCorrect': 0},
              {'id': '3CT_Q1_O3', 'text': 'Raphaël', 'isCorrect': 0},
              {'id': '3CT_Q1_O4', 'text': 'Botticelli', 'isCorrect': 0},
            ]
          },
          {
            'id': '3CT_Q2',
            'text': 'Claude Monet est une figure majeure de quel mouvement ?',
            'point': 1.0,
            'options': [
              {'id': '3CT_Q2_O1', 'text': 'L’Impressionnisme', 'isCorrect': 1},
              {'id': '3CT_Q2_O2', 'text': 'Le Cubisme', 'isCorrect': 0},
              {'id': '3CT_Q2_O3', 'text': 'Le Surréalisme', 'isCorrect': 0},
              {'id': '3CT_Q2_O4', 'text': 'Le Baroque', 'isCorrect': 0},
            ]
          },
          {
            'id': '3CT_Q3',
            'text': 'Qui a sculpté « Le Penseur » ?',
            'point': 1.0,
            'options': [
              {'id': '3CT_Q3_O1', 'text': 'Auguste Rodin', 'isCorrect': 1},
              {'id': '3CT_Q3_O2', 'text': 'Donatello', 'isCorrect': 0},
              {'id': '3CT_Q3_O3', 'text': 'Gian Lorenzo Bernini', 'isCorrect': 0},
              {'id': '3CT_Q3_O4', 'text': 'Henry Moore', 'isCorrect': 0},
            ]
          },
          {
            'id': '3CT_Q4',
            'text': 'Laquelle N’EST PAS une couleur primaire en peinture traditionnelle ?',
            'point': 1.0,
            'options': [
              {'id': '3CT_Q4_O1', 'text': 'Vert', 'isCorrect': 1},
              {'id': '3CT_Q4_O2', 'text': 'Rouge', 'isCorrect': 0},
              {'id': '3CT_Q4_O3', 'text': 'Bleu', 'isCorrect': 0},
              {'id': '3CT_Q4_O4', 'text': 'Jaune', 'isCorrect': 0},
            ]
          },
          {
            'id': '3CT_Q5',
            'text': 'Qui a peint « Guernica » ?',
            'point': 1.0,
            'options': [
              {'id': '3CT_Q5_O1', 'text': 'Pablo Picasso', 'isCorrect': 1},
              {'id': '3CT_Q5_O2', 'text': 'Salvador Dalí', 'isCorrect': 0},
              {'id': '3CT_Q5_O3', 'text': 'Joan Miró', 'isCorrect': 0},
              {'id': '3CT_Q5_O4', 'text': 'Paul Cézanne', 'isCorrect': 0},
            ]
          },
          {
            'id': '3CT_Q6',
            'text': 'Quelle technique utilise principalement de l’eau sur papier ?',
            'point': 1.0,
            'options': [
              {'id': '3CT_Q6_O1', 'text': 'L’aquarelle', 'isCorrect': 1},
              {'id': '3CT_Q6_O2', 'text': 'La gravure', 'isCorrect': 0},
              {'id': '3CT_Q6_O3', 'text': 'La mosaïque', 'isCorrect': 0},
              {'id': '3CT_Q6_O4', 'text': 'La marqueterie', 'isCorrect': 0},
            ]
          },
          {
            'id': '3CT_Q7',
            'text': 'La couleur complémentaire du bleu est…',
            'point': 1.0,
            'options': [
              {'id': '3CT_Q7_O1', 'text': 'Orange', 'isCorrect': 1},
              {'id': '3CT_Q7_O2', 'text': 'Vert', 'isCorrect': 0},
              {'id': '3CT_Q7_O3', 'text': 'Violet', 'isCorrect': 0},
              {'id': '3CT_Q7_O4', 'text': 'Jaune', 'isCorrect': 0},
            ]
          },
          {
            'id': '3CT_Q8',
            'text': 'Qui a peint le plafond de la chapelle Sixtine ?',
            'point': 1.0,
            'options': [
              {'id': '3CT_Q8_O1', 'text': 'Michel-Ange', 'isCorrect': 1},
              {'id': '3CT_Q8_O2', 'text': 'Raphaël', 'isCorrect': 0},
              {'id': '3CT_Q8_O3', 'text': 'Caravage', 'isCorrect': 0},
              {'id': '3CT_Q8_O4', 'text': 'Titien', 'isCorrect': 0},
            ]
          },
          {
            'id': '3CT_Q9',
            'text': 'La perspective linéaire sert principalement à…',
            'point': 1.0,
            'options': [
              {'id': '3CT_Q9_O1', 'text': 'Créer une illusion de profondeur', 'isCorrect': 1},
              {'id': '3CT_Q9_O2', 'text': 'Accélérer le séchage', 'isCorrect': 0},
              {'id': '3CT_Q9_O3', 'text': 'Renforcer les pigments', 'isCorrect': 0},
              {'id': '3CT_Q9_O4', 'text': 'Aplatir les volumes', 'isCorrect': 0},
            ]
          },
          {
            'id': '3CT_Q10',
            'text': 'Le « sfumato » est une technique associée à…',
            'point': 1.0,
            'options': [
              {'id': '3CT_Q10_O1', 'text': 'Léonard de Vinci', 'isCorrect': 1},
              {'id': '3CT_Q10_O2', 'text': 'Rembrandt', 'isCorrect': 0},
              {'id': '3CT_Q10_O3', 'text': 'Matisse', 'isCorrect': 0},
              {'id': '3CT_Q10_O4', 'text': 'Turner', 'isCorrect': 0},
            ]
          },
        ],
      },
      {
        'categoryId': '12CT', // Science
        'questions': [
          {
            'id': '12CT_Q1',
            'text': 'Quelle est la formule chimique de l’eau ?',
            'point': 1.0,
            'options': [
              {'id': '12CT_Q1_O1', 'text': 'H₂O', 'isCorrect': 1},
              {'id': '12CT_Q1_O2', 'text': 'CO₂', 'isCorrect': 0},
              {'id': '12CT_Q1_O3', 'text': 'O₂', 'isCorrect': 0},
              {'id': '12CT_Q1_O4', 'text': 'NaCl', 'isCorrect': 0},
            ]
          },
          {
            'id': '12CT_Q2',
            'text': 'Qui a formulé la loi universelle de la gravitation ?',
            'point': 1.0,
            'options': [
              {'id': '12CT_Q2_O1', 'text': 'Isaac Newton', 'isCorrect': 1},
              {'id': '12CT_Q2_O2', 'text': 'Albert Einstein', 'isCorrect': 0},
              {'id': '12CT_Q2_O3', 'text': 'Galilée', 'isCorrect': 0},
              {'id': '12CT_Q2_O4', 'text': 'Kepler', 'isCorrect': 0},
            ]
          },
          {
            'id': '12CT_Q3',
            'text': 'La vitesse de la lumière dans le vide est d’environ…',
            'point': 1.0,
            'options': [
              {'id': '12CT_Q3_O1', 'text': '300 000 km/s', 'isCorrect': 1},
              {'id': '12CT_Q3_O2', 'text': '3 000 km/s', 'isCorrect': 0},
              {'id': '12CT_Q3_O3', 'text': '30 000 km/s', 'isCorrect': 0},
              {'id': '12CT_Q3_O4', 'text': '3 000 000 km/s', 'isCorrect': 0},
            ]
          },
          {
            'id': '12CT_Q4',
            'text': 'La photosynthèse permet aux plantes de produire…',
            'point': 1.0,
            'options': [
              {'id': '12CT_Q4_O1', 'text': 'Du dioxygène (O₂)', 'isCorrect': 1},
              {'id': '12CT_Q4_O2', 'text': 'Du méthane (CH₄)', 'isCorrect': 0},
              {'id': '12CT_Q4_O3', 'text': 'Du sel (NaCl)', 'isCorrect': 0},
              {'id': '12CT_Q4_O4', 'text': 'De l’éthanol', 'isCorrect': 0},
            ]
          },
          {
            'id': '12CT_Q5',
            'text': 'Quelle est la charge du proton ?',
            'point': 1.0,
            'options': [
              {'id': '12CT_Q5_O1', 'text': 'Positive', 'isCorrect': 1},
              {'id': '12CT_Q5_O2', 'text': 'Négative', 'isCorrect': 0},
              {'id': '12CT_Q5_O3', 'text': 'Nulle', 'isCorrect': 0},
              {'id': '12CT_Q5_O4', 'text': 'Variable', 'isCorrect': 0},
            ]
          },
          {
            'id': '12CT_Q6',
            'text': 'Une solution avec pH < 7 est…',
            'point': 1.0,
            'options': [
              {'id': '12CT_Q6_O1', 'text': 'Acide', 'isCorrect': 1},
              {'id': '12CT_Q6_O2', 'text': 'Basique', 'isCorrect': 0},
              {'id': '12CT_Q6_O3', 'text': 'Neutre', 'isCorrect': 0},
              {'id': '12CT_Q6_O4', 'text': 'Saline', 'isCorrect': 0},
            ]
          },
          {
            'id': '12CT_Q7',
            'text': 'L’ADN est principalement…',
            'point': 1.0,
            'options': [
              {'id': '12CT_Q7_O1', 'text': 'Le support de l’information génétique', 'isCorrect': 1},
              {'id': '12CT_Q7_O2', 'text': 'Une protéine contractile', 'isCorrect': 0},
              {'id': '12CT_Q7_O3', 'text': 'Un lipide membranaire', 'isCorrect': 0},
              {'id': '12CT_Q7_O4', 'text': 'Un gaz noble', 'isCorrect': 0},
            ]
          },
          {
            'id': '12CT_Q8',
            'text': 'Quelle est la planète la plus proche du Soleil ?',
            'point': 1.0,
            'options': [
              {'id': '12CT_Q8_O1', 'text': 'Mercure', 'isCorrect': 1},
              {'id': '12CT_Q8_O2', 'text': 'Vénus', 'isCorrect': 0},
              {'id': '12CT_Q8_O3', 'text': 'Terre', 'isCorrect': 0},
              {'id': '12CT_Q8_O4', 'text': 'Mars', 'isCorrect': 0},
            ]
          },
          {
            'id': '12CT_Q9',
            'text': 'Quelle est l’unité SI de l’énergie ?',
            'point': 1.0,
            'options': [
              {'id': '12CT_Q9_O1', 'text': 'Le joule (J)', 'isCorrect': 1},
              {'id': '12CT_Q9_O2', 'text': 'Le watt (W)', 'isCorrect': 0},
              {'id': '12CT_Q9_O3', 'text': 'Le volt (V)', 'isCorrect': 0},
              {'id': '12CT_Q9_O4', 'text': 'L’ampère (A)', 'isCorrect': 0},
            ]
          },
          {
            'id': '12CT_Q10',
            'text': 'Quel gaz est le plus abondant dans l’atmosphère terrestre ?',
            'point': 1.0,
            'options': [
              {'id': '12CT_Q10_O1', 'text': 'L’azote (≈78%)', 'isCorrect': 1},
              {'id': '12CT_Q10_O2', 'text': 'Le dioxygène', 'isCorrect': 0},
              {'id': '12CT_Q10_O3', 'text': 'Le dioxyde de carbone', 'isCorrect': 0},
              {'id': '12CT_Q10_O4', 'text': 'L’argon', 'isCorrect': 0},
            ]
          },
        ],
      },
      {
        'categoryId': '15CT', // Jeux Vidéo
        'questions': [
          {
            'id': '15CT_Q1',
            'text': 'Quel studio/constructeur est associé à « The Legend of Zelda » ?',
            'point': 1.0,
            'options': [
              {'id': '15CT_Q1_O1', 'text': 'Nintendo', 'isCorrect': 1},
              {'id': '15CT_Q1_O2', 'text': 'Sony', 'isCorrect': 0},
              {'id': '15CT_Q1_O3', 'text': 'Microsoft', 'isCorrect': 0},
              {'id': '15CT_Q1_O4', 'text': 'Valve', 'isCorrect': 0},
            ]
          },
          {
            'id': '15CT_Q2',
            'text': 'Que signifie le sigle FPS (dans le genre de jeu) ?',
            'point': 1.0,
            'options': [
              {'id': '15CT_Q2_O1', 'text': 'First-Person Shooter', 'isCorrect': 1},
              {'id': '15CT_Q2_O2', 'text': 'Frames Per Second', 'isCorrect': 0},
              {'id': '15CT_Q2_O3', 'text': 'Fast Play Style', 'isCorrect': 0},
              {'id': '15CT_Q2_O4', 'text': 'Fight Puzzle System', 'isCorrect': 0},
            ]
          },
          {
            'id': '15CT_Q3',
            'text': 'Que signifie MMO ?',
            'point': 1.0,
            'options': [
              {'id': '15CT_Q3_O1', 'text': 'Massively Multiplayer Online', 'isCorrect': 1},
              {'id': '15CT_Q3_O2', 'text': 'Multi Map Offline', 'isCorrect': 0},
              {'id': '15CT_Q3_O3', 'text': 'Mega Match Option', 'isCorrect': 0},
              {'id': '15CT_Q3_O4', 'text': 'Mobile Mode Only', 'isCorrect': 0},
            ]
          },
          {
            'id': '15CT_Q4',
            'text': 'Quel moteur de jeu est très utilisé pour des productions AAA et indé ?',
            'point': 1.0,
            'options': [
              {'id': '15CT_Q4_O1', 'text': 'Unreal Engine', 'isCorrect': 1},
              {'id': '15CT_Q4_O2', 'text': 'Notch Engine', 'isCorrect': 0},
              {'id': '15CT_Q4_O3', 'text': 'CryPaint', 'isCorrect': 0},
              {'id': '15CT_Q4_O4', 'text': 'Direct3D', 'isCorrect': 0},
            ]
          },
          {
            'id': '15CT_Q5',
            'text': 'Quel studio a créé « Minecraft » ?',
            'point': 1.0,
            'options': [
              {'id': '15CT_Q5_O1', 'text': 'Mojang', 'isCorrect': 1},
              {'id': '15CT_Q5_O2', 'text': 'id Software', 'isCorrect': 0},
              {'id': '15CT_Q5_O3', 'text': 'Epic Games', 'isCorrect': 0},
              {'id': '15CT_Q5_O4', 'text': 'Activision', 'isCorrect': 0},
            ]
          },
          {
            'id': '15CT_Q6',
            'text': 'Le « ping » mesure principalement…',
            'point': 1.0,
            'options': [
              {'id': '15CT_Q6_O1', 'text': 'La latence réseau', 'isCorrect': 1},
              {'id': '15CT_Q6_O2', 'text': 'La résolution d’écran', 'isCorrect': 0},
              {'id': '15CT_Q6_O3', 'text': 'Le taux de rafraîchissement', 'isCorrect': 0},
              {'id': '15CT_Q6_O4', 'text': 'Le nombre de FPS', 'isCorrect': 0},
            ]
          },
          {
            'id': '15CT_Q7',
            'text': 'L’eSport correspond à…',
            'point': 1.0,
            'options': [
              {'id': '15CT_Q7_O1', 'text': 'La compétition de jeux vidéo', 'isCorrect': 1},
              {'id': '15CT_Q7_O2', 'text': 'Un périphérique audio', 'isCorrect': 0},
              {'id': '15CT_Q7_O3', 'text': 'Une patte graphique', 'isCorrect': 0},
              {'id': '15CT_Q7_O4', 'text': 'Un type de processeur', 'isCorrect': 0},
            ]
          },
          {
            'id': '15CT_Q8',
            'text': 'Un « Metroidvania » se caractérise par…',
            'point': 1.0,
            'options': [
              {'id': '15CT_Q8_O1', 'text': 'Exploration non linéaire et capacités débloquables', 'isCorrect': 1},
              {'id': '15CT_Q8_O2', 'text': 'Puzzles uniquement', 'isCorrect': 0},
              {'id': '15CT_Q8_O3', 'text': 'Courses de voitures', 'isCorrect': 0},
              {'id': '15CT_Q8_O4', 'text': 'Jeu musical', 'isCorrect': 0},
            ]
          },
          {
            'id': '15CT_Q9',
            'text': 'Que signifie VR ?',
            'point': 1.0,
            'options': [
              {'id': '15CT_Q9_O1', 'text': 'Réalité Virtuelle', 'isCorrect': 1},
              {'id': '15CT_Q9_O2', 'text': 'Vision Rapide', 'isCorrect': 0},
              {'id': '15CT_Q9_O3', 'text': 'Volume Rendu', 'isCorrect': 0},
              {'id': '15CT_Q9_O4', 'text': 'Vitesse Réseau', 'isCorrect': 0},
            ]
          },
          {
            'id': '15CT_Q10',
            'text': 'La Switch est une console de…',
            'point': 1.0,
            'options': [
              {'id': '15CT_Q10_O1', 'text': 'Nintendo', 'isCorrect': 1},
              {'id': '15CT_Q10_O2', 'text': 'Sega', 'isCorrect': 0},
              {'id': '15CT_Q10_O3', 'text': 'Atari', 'isCorrect': 0},
              {'id': '15CT_Q10_O4', 'text': 'NEC', 'isCorrect': 0},
            ]
          },
        ],
      },
      {
        'categoryId': '19CT', // Manga & Anime
        'questions': [
          {
            'id': '19CT_Q1',
            'text': 'Qui est l’auteur de « One Piece » ?',
            'point': 1.0,
            'options': [
              {'id': '19CT_Q1_O1', 'text': 'Eiichirō Oda', 'isCorrect': 1},
              {'id': '19CT_Q1_O2', 'text': 'Masashi Kishimoto', 'isCorrect': 0},
              {'id': '19CT_Q1_O3', 'text': 'Akira Toriyama', 'isCorrect': 0},
              {'id': '19CT_Q1_O4', 'text': 'Tite Kubo', 'isCorrect': 0},
            ]
          },
          {
            'id': '19CT_Q2',
            'text': 'Dans « Naruto », le village natal du héros est…',
            'point': 1.0,
            'options': [
              {'id': '19CT_Q2_O1', 'text': 'Konoha', 'isCorrect': 1},
              {'id': '19CT_Q2_O2', 'text': 'Suna', 'isCorrect': 0},
              {'id': '19CT_Q2_O3', 'text': 'Kiri', 'isCorrect': 0},
              {'id': '19CT_Q2_O4', 'text': 'Iwa', 'isCorrect': 0},
            ]
          },
          {
            'id': '19CT_Q3',
            'text': 'Le shinigami qui accompagne Light Yagami dans « Death Note » est…',
            'point': 1.0,
            'options': [
              {'id': '19CT_Q3_O1', 'text': 'Ryuk', 'isCorrect': 1},
              {'id': '19CT_Q3_O2', 'text': 'Rem', 'isCorrect': 0},
              {'id': '19CT_Q3_O3', 'text': 'L', 'isCorrect': 0},
              {'id': '19CT_Q3_O4', 'text': 'Mello', 'isCorrect': 0},
            ]
          },
          {
            'id': '19CT_Q4',
            'text': 'Le protagoniste principal de « L’Attaque des Titans » est…',
            'point': 1.0,
            'options': [
              {'id': '19CT_Q4_O1', 'text': 'Eren Yeager', 'isCorrect': 1},
              {'id': '19CT_Q4_O2', 'text': 'Levi Ackerman', 'isCorrect': 0},
              {'id': '19CT_Q4_O3', 'text': 'Mikasa Ackerman', 'isCorrect': 0},
              {'id': '19CT_Q4_O4', 'text': 'Armin Arlert', 'isCorrect': 0},
            ]
          },
          {
            'id': '19CT_Q5',
            'text': 'Quel cofondateur du studio Ghibli a réalisé « Le Voyage de Chihiro » ?',
            'point': 1.0,
            'options': [
              {'id': '19CT_Q5_O1', 'text': 'Hayao Miyazaki', 'isCorrect': 1},
              {'id': '19CT_Q5_O2', 'text': 'Isao Takahata', 'isCorrect': 0},
              {'id': '19CT_Q5_O3', 'text': 'Makoto Shinkai', 'isCorrect': 0},
              {'id': '19CT_Q5_O4', 'text': 'Mamoru Hosoda', 'isCorrect': 0},
            ]
          },
          {
            'id': '19CT_Q6',
            'text': 'Dans « Dragon Ball », la célèbre transformation de Goku est…',
            'point': 1.0,
            'options': [
              {'id': '19CT_Q6_O1', 'text': 'Super Saiyan', 'isCorrect': 1},
              {'id': '19CT_Q6_O2', 'text': 'Bankai', 'isCorrect': 0},
              {'id': '19CT_Q6_O3', 'text': 'Gear Second', 'isCorrect': 0},
              {'id': '19CT_Q6_O4', 'text': 'Sage Mode', 'isCorrect': 0},
            ]
          },
          {
            'id': '19CT_Q7',
            'text': 'Le héros de « Bleach » s’appelle…',
            'point': 1.0,
            'options': [
              {'id': '19CT_Q7_O1', 'text': 'Ichigo Kurosaki', 'isCorrect': 1},
              {'id': '19CT_Q7_O2', 'text': 'Sasuke Uchiha', 'isCorrect': 0},
              {'id': '19CT_Q7_O3', 'text': 'Gon Freecss', 'isCorrect': 0},
              {'id': '19CT_Q7_O4', 'text': 'Eren Yeager', 'isCorrect': 0},
            ]
          },
          {
            'id': '19CT_Q8',
            'text': 'Dans « My Hero Academia », les super-pouvoirs sont appelés…',
            'point': 1.0,
            'options': [
              {'id': '19CT_Q8_O1', 'text': 'Alters (Quirks)', 'isCorrect': 1},
              {'id': '19CT_Q8_O2', 'text': 'Nen', 'isCorrect': 0},
              {'id': '19CT_Q8_O3', 'text': 'Chakra', 'isCorrect': 0},
              {'id': '19CT_Q8_O4', 'text': 'Ki', 'isCorrect': 0},
            ]
          },
          {
            'id': '19CT_Q9',
            'text': 'Les frères protagonistes de « Fullmetal Alchemist » sont…',
            'point': 1.0,
            'options': [
              {'id': '19CT_Q9_O1', 'text': 'Edward et Alphonse', 'isCorrect': 1},
              {'id': '19CT_Q9_O2', 'text': 'Naruto et Sasuke', 'isCorrect': 0},
              {'id': '19CT_Q9_O3', 'text': 'Light et L', 'isCorrect': 0},
              {'id': '19CT_Q9_O4', 'text': 'Gon et Killua', 'isCorrect': 0},
            ]
          },
          {
            'id': '19CT_Q10',
            'text': 'Le genre « shōnen » vise principalement…',
            'point': 1.0,
            'options': [
              {'id': '19CT_Q10_O1', 'text': 'Les adolescents garçons', 'isCorrect': 1},
              {'id': '19CT_Q10_O2', 'text': 'Les jeunes filles (shōjo)', 'isCorrect': 0},
              {'id': '19CT_Q10_O3', 'text': 'Un public adulte (seinen)', 'isCorrect': 0},
              {'id': '19CT_Q10_O4', 'text': 'Les enfants en bas âge (kodomo)', 'isCorrect': 0},
            ]
          },
        ],
      },
      {
        'categoryId': '4CT', // Sport
        'questions': [
          {
            'id': '4CT_Q1',
            'text': 'Quel pays a remporté la Coupe du Monde de football 2018 ?',
            'point': 1.0,
            'options': [
              {'id': '4CT_Q1_O1', 'text': 'France', 'isCorrect': 1},
              {'id': '4CT_Q1_O2', 'text': 'Brésil', 'isCorrect': 0},
              {'id': '4CT_Q1_O3', 'text': 'Allemagne', 'isCorrect': 0},
              {'id': '4CT_Q1_O4', 'text': 'Espagne', 'isCorrect': 0},
            ]
          },
          {
            'id': '4CT_Q2',
            'text': 'Combien de joueurs y a-t-il dans une équipe de basketball sur le terrain ?',
            'point': 1.0,
            'options': [
              {'id': '4CT_Q2_O1', 'text': '5', 'isCorrect': 1},
              {'id': '4CT_Q2_O2', 'text': '6', 'isCorrect': 0},
              {'id': '4CT_Q2_O3', 'text': '7', 'isCorrect': 0},
              {'id': '4CT_Q2_O4', 'text': '4', 'isCorrect': 0},
            ]
          },
          {
            'id': '4CT_Q3',
            'text': 'Quel joueur de tennis détient le plus de titres du Grand Chelem ?',
            'point': 1.0,
            'options': [
              {'id': '4CT_Q3_O1', 'text': 'Novak Djokovic', 'isCorrect': 1},
              {'id': '4CT_Q3_O2', 'text': 'Roger Federer', 'isCorrect': 0},
              {'id': '4CT_Q3_O3', 'text': 'Rafael Nadal', 'isCorrect': 0},
              {'id': '4CT_Q3_O4', 'text': 'Andy Murray', 'isCorrect': 0},
            ]
          },
          {
            'id': '4CT_Q4',
            'text': 'Combien de minutes dure un match de football (hors prolongation) ?',
            'point': 1.0,
            'options': [
              {'id': '4CT_Q4_O1', 'text': '90 minutes', 'isCorrect': 1},
              {'id': '4CT_Q4_O2', 'text': '80 minutes', 'isCorrect': 0},
              {'id': '4CT_Q4_O3', 'text': '100 minutes', 'isCorrect': 0},
              {'id': '4CT_Q4_O4', 'text': '120 minutes', 'isCorrect': 0},
            ]
          },
          {
            'id': '4CT_Q5',
            'text': 'Quel pays a inventé le judo ?',
            'point': 1.0,
            'options': [
              {'id': '4CT_Q5_O1', 'text': 'Japon', 'isCorrect': 1},
              {'id': '4CT_Q5_O2', 'text': 'Chine', 'isCorrect': 0},
              {'id': '4CT_Q5_O3', 'text': 'Corée', 'isCorrect': 0},
              {'id': '4CT_Q5_O4', 'text': 'Thaïlande', 'isCorrect': 0},
            ]
          },
          {
            'id': '4CT_Q6',
            'text': 'Combien de joueurs composent une équipe de rugby à XV ?',
            'point': 1.0,
            'options': [
              {'id': '4CT_Q6_O1', 'text': '15', 'isCorrect': 1},
              {'id': '4CT_Q6_O2', 'text': '13', 'isCorrect': 0},
              {'id': '4CT_Q6_O3', 'text': '11', 'isCorrect': 0},
              {'id': '4CT_Q6_O4', 'text': '7', 'isCorrect': 0},
            ]
          },
          {
            'id': '4CT_Q7',
            'text': 'Quelle distance parcourt un marathon ?',
            'point': 1.0,
            'options': [
              {'id': '4CT_Q7_O1', 'text': '42,195 km', 'isCorrect': 1},
              {'id': '4CT_Q7_O2', 'text': '40 km', 'isCorrect': 0},
              {'id': '4CT_Q7_O3', 'text': '50 km', 'isCorrect': 0},
              {'id': '4CT_Q7_O4', 'text': '21,1 km', 'isCorrect': 0},
            ]
          },
          {
            'id': '4CT_Q8',
            'text': 'Dans quel sport utilise-t-on un volant ?',
            'point': 1.0,
            'options': [
              {'id': '4CT_Q8_O1', 'text': 'Badminton', 'isCorrect': 1},
              {'id': '4CT_Q8_O2', 'text': 'Tennis', 'isCorrect': 0},
              {'id': '4CT_Q8_O3', 'text': 'Baseball', 'isCorrect': 0},
              {'id': '4CT_Q8_O4', 'text': 'Squash', 'isCorrect': 0},
            ]
          },
          {
            'id': '4CT_Q9',
            'text': 'Quel est le surnom de l’équipe nationale de football du Brésil ?',
            'point': 1.0,
            'options': [
              {'id': '4CT_Q9_O1', 'text': 'La Seleção', 'isCorrect': 1},
              {'id': '4CT_Q9_O2', 'text': 'Les Bleus', 'isCorrect': 0},
              {'id': '4CT_Q9_O3', 'text': 'La Roja', 'isCorrect': 0},
              {'id': '4CT_Q9_O4', 'text': 'Les Diables Rouges', 'isCorrect': 0},
            ]
          },
          {
            'id': '4CT_Q10',
            'text': 'Combien de points vaut un panier à trois points au basketball ?',
            'point': 1.0,
            'options': [
              {'id': '4CT_Q10_O1', 'text': '3 points', 'isCorrect': 1},
              {'id': '4CT_Q10_O2', 'text': '2 points', 'isCorrect': 0},
              {'id': '4CT_Q10_O3', 'text': '1 point', 'isCorrect': 0},
              {'id': '4CT_Q10_O4', 'text': '4 points', 'isCorrect': 0},
            ]
          },
        ]
      },
      {
        'categoryId': '5CT', // Éducation
        'questions': [
          {
            'id': '3CT_Q1',
            'text': 'Quel est l’enseignement obligatoire jusqu’à 16 ans en France ?',
            'point': 1.0,
            'options': [
              {'id': '3CT_Q1_O1', 'text': 'L’école primaire et le collège', 'isCorrect': 1},
              {'id': '3CT_Q1_O2', 'text': 'Le lycée uniquement', 'isCorrect': 0},
              {'id': '3CT_Q1_O3', 'text': 'L’université', 'isCorrect': 0},
              {'id': '3CT_Q1_O4', 'text': 'La maternelle', 'isCorrect': 0},
            ]
          },
          {
            'id': '3CT_Q2',
            'text': 'Qu’est-ce qu’un MOOC ?',
            'point': 1.0,
            'options': [
              {'id': '3CT_Q2_O1', 'text': 'Cours en ligne ouvert à tous', 'isCorrect': 1},
              {'id': '3CT_Q2_O2', 'text': 'Diplôme universitaire', 'isCorrect': 0},
              {'id': '3CT_Q2_O3', 'text': 'Examen national', 'isCorrect': 0},
              {'id': '3CT_Q2_O4', 'text': 'Bibliothèque spécialisée', 'isCorrect': 0},
            ]
          },
          {
            'id': '3CT_Q3',
            'text': 'Quelle compétence est essentielle pour réussir au lycée ?',
            'point': 1.0,
            'options': [
              {'id': '3CT_Q3_O1', 'text': 'L’organisation personnelle', 'isCorrect': 1},
              {'id': '3CT_Q3_O2', 'text': 'La vitesse de lecture uniquement', 'isCorrect': 0},
              {'id': '3CT_Q3_O3', 'text': 'Le sport', 'isCorrect': 0},
              {'id': '3CT_Q3_O4', 'text': 'La cuisine', 'isCorrect': 0},
            ]
          },
          {
            'id': '3CT_Q4',
            'text': 'Quel diplôme sanctionne la fin du collège en France ?',
            'point': 1.0,
            'options': [
              {'id': '3CT_Q4_O1', 'text': 'Le brevet des collèges', 'isCorrect': 1},
              {'id': '3CT_Q4_O2', 'text': 'Le baccalauréat', 'isCorrect': 0},
              {'id': '3CT_Q4_O3', 'text': 'La licence', 'isCorrect': 0},
              {'id': '3CT_Q4_O4', 'text': 'Le CAP', 'isCorrect': 0},
            ]
          },
          {
            'id': '3CT_Q5',
            'text': 'Quel est l’objectif principal de l’éducation inclusive ?',
            'point': 1.0,
            'options': [
              {'id': '3CT_Q5_O1', 'text': 'Permettre à tous d’accéder à l’éducation', 'isCorrect': 1},
              {'id': '3CT_Q5_O2', 'text': 'Séparer les élèves selon leur niveau', 'isCorrect': 0},
              {'id': '3CT_Q5_O3', 'text': 'Supprimer les cours de langues', 'isCorrect': 0},
              {'id': '3CT_Q5_O4', 'text': 'Favoriser uniquement les meilleurs élèves', 'isCorrect': 0},
            ]
          },
        ],
      },
      {
        'categoryId': '6CT', // Finance
        'questions': [
          {
            'id': '4CT_Q1',
            'text': 'Que signifie le sigle « PIB » ?',
            'point': 1.0,
            'options': [
              {'id': '4CT_Q1_O1', 'text': 'Produit Intérieur Brut', 'isCorrect': 1},
              {'id': '4CT_Q1_O2', 'text': 'Plan d’Investissement Bancaire', 'isCorrect': 0},
              {'id': '4CT_Q1_O3', 'text': 'Produit International Bancaire', 'isCorrect': 0},
              {'id': '4CT_Q1_O4', 'text': 'Programme d’Intérêt Brut', 'isCorrect': 0},
            ]
          },
          {
            'id': '4CT_Q2',
            'text': 'Qu’est-ce qu’une action en bourse ?',
            'point': 1.0,
            'options': [
              {'id': '4CT_Q2_O1', 'text': 'Une part du capital d’une entreprise', 'isCorrect': 1},
              {'id': '4CT_Q2_O2', 'text': 'Un prêt bancaire', 'isCorrect': 0},
              {'id': '4CT_Q2_O3', 'text': 'Une obligation légale', 'isCorrect': 0},
              {'id': '4CT_Q2_O4', 'text': 'Une taxe gouvernementale', 'isCorrect': 0},
            ]
          },
          {
            'id': '4CT_Q3',
            'text': 'Quel est l’objectif principal de l’épargne ?',
            'point': 1.0,
            'options': [
              {'id': '4CT_Q3_O1', 'text': 'Mettre de l’argent de côté pour l’avenir', 'isCorrect': 1},
              {'id': '4CT_Q3_O2', 'text': 'Dépenser rapidement son argent', 'isCorrect': 0},
              {'id': '4CT_Q3_O3', 'text': 'Créer uniquement des dettes', 'isCorrect': 0},
              {'id': '4CT_Q3_O4', 'text': 'Investir dans des actions sans calcul', 'isCorrect': 0},
            ]
          },
          {
            'id': '4CT_Q4',
            'text': 'Quelle est la devise de réserve la plus utilisée dans le monde ?',
            'point': 1.0,
            'options': [
              {'id': '4CT_Q4_O1', 'text': 'Dollar américain', 'isCorrect': 1},
              {'id': '4CT_Q4_O2', 'text': 'Euro', 'isCorrect': 0},
              {'id': '4CT_Q4_O3', 'text': 'Yen japonais', 'isCorrect': 0},
              {'id': '4CT_Q4_O4', 'text': 'Livre sterling', 'isCorrect': 0},
            ]
          },
          {
            'id': '4CT_Q5',
            'text': 'Quel est le rôle principal d’une banque centrale ?',
            'point': 1.0,
            'options': [
              {'id': '4CT_Q5_O1', 'text': 'Gérer la politique monétaire d’un pays', 'isCorrect': 1},
              {'id': '4CT_Q5_O2', 'text': 'Ouvrir des comptes d’épargne uniquement', 'isCorrect': 0},
              {'id': '4CT_Q5_O3', 'text': 'Distribuer des prêts aux particuliers sans limite', 'isCorrect': 0},
              {'id': '4CT_Q5_O4', 'text': 'Créer des entreprises privées', 'isCorrect': 0},
            ]
          },
        ],
      },
      {
        'categoryId': '7CT', // Musique
        'questions': [
          {
            'id': '5CT_Q1',
            'text': 'Quel instrument a 88 touches et est utilisé dans la musique classique ?',
            'point': 1.0,
            'options': [
              {'id': '5CT_Q1_O1', 'text': 'Le piano', 'isCorrect': 1},
              {'id': '5CT_Q1_O2', 'text': 'La guitare', 'isCorrect': 0},
              {'id': '5CT_Q1_O3', 'text': 'Le violon', 'isCorrect': 0},
              {'id': '5CT_Q1_O4', 'text': 'La batterie', 'isCorrect': 0},
            ]
          },
          {
            'id': '5CT_Q2',
            'text': 'Qui est surnommé "le roi de la pop" ?',
            'point': 1.0,
            'options': [
              {'id': '5CT_Q2_O1', 'text': 'Michael Jackson', 'isCorrect': 1},
              {'id': '5CT_Q2_O2', 'text': 'Elvis Presley', 'isCorrect': 0},
              {'id': '5CT_Q2_O3', 'text': 'Prince', 'isCorrect': 0},
              {'id': '5CT_Q2_O4', 'text': 'Madonna', 'isCorrect': 0},
            ]
          },
          {
            'id': '5CT_Q3',
            'text': 'Quel genre musical est originaire de la Jamaïque ?',
            'point': 1.0,
            'options': [
              {'id': '5CT_Q3_O1', 'text': 'Le reggae', 'isCorrect': 1},
              {'id': '5CT_Q3_O2', 'text': 'Le jazz', 'isCorrect': 0},
              {'id': '5CT_Q3_O3', 'text': 'Le rock', 'isCorrect': 0},
              {'id': '5CT_Q3_O4', 'text': 'Le classique', 'isCorrect': 0},
            ]
          },
          {
            'id': '5CT_Q4',
            'text': 'Quel compositeur est célèbre pour "La Symphonie n°9" ?',
            'point': 1.0,
            'options': [
              {'id': '5CT_Q4_O1', 'text': 'Beethoven', 'isCorrect': 1},
              {'id': '5CT_Q4_O2', 'text': 'Mozart', 'isCorrect': 0},
              {'id': '5CT_Q4_O3', 'text': 'Bach', 'isCorrect': 0},
              {'id': '5CT_Q4_O4', 'text': 'Chopin', 'isCorrect': 0},
            ]
          },
          {
            'id': '5CT_Q5',
            'text': 'Quel style musical utilise principalement le DJ et les platines ?',
            'point': 1.0,
            'options': [
              {'id': '5CT_Q5_O1', 'text': 'La musique électronique', 'isCorrect': 1},
              {'id': '5CT_Q5_O2', 'text': 'Le classique', 'isCorrect': 0},
              {'id': '5CT_Q5_O3', 'text': 'Le jazz', 'isCorrect': 0},
              {'id': '5CT_Q5_O4', 'text': 'Le folk', 'isCorrect': 0},
            ]
          },
        ],
      },
      {
        'categoryId': '8CT', // Cinéma
        'questions': [
          {
            'id': '6CT_Q1',
            'text': 'Quel réalisateur a dirigé "Titanic" et "Avatar" ?',
            'point': 1.0,
            'options': [
              {'id': '6CT_Q1_O1', 'text': 'James Cameron', 'isCorrect': 1},
              {'id': '6CT_Q1_O2', 'text': 'Steven Spielberg', 'isCorrect': 0},
              {'id': '6CT_Q1_O3', 'text': 'Christopher Nolan', 'isCorrect': 0},
              {'id': '6CT_Q1_O4', 'text': 'Martin Scorsese', 'isCorrect': 0},
            ]
          },
          {
            'id': '6CT_Q2',
            'text': 'Quel film a remporté l’Oscar du meilleur film en 2020 ?',
            'point': 1.0,
            'options': [
              {'id': '6CT_Q2_O1', 'text': 'Parasite', 'isCorrect': 1},
              {'id': '6CT_Q2_O2', 'text': '1917', 'isCorrect': 0},
              {'id': '6CT_Q2_O3', 'text': 'Joker', 'isCorrect': 0},
              {'id': '6CT_Q2_O4', 'text': 'Once Upon a Time… in Hollywood', 'isCorrect': 0},
            ]
          },
          {
            'id': '6CT_Q3',
            'text': 'Quel est le studio derrière les films Marvel ?',
            'point': 1.0,
            'options': [
              {'id': '6CT_Q3_O1', 'text': 'Marvel Studios', 'isCorrect': 1},
              {'id': '6CT_Q3_O2', 'text': 'Warner Bros', 'isCorrect': 0},
              {'id': '6CT_Q3_O3', 'text': 'Pixar', 'isCorrect': 0},
              {'id': '6CT_Q3_O4', 'text': 'Universal', 'isCorrect': 0},
            ]
          },
          {
            'id': '6CT_Q4',
            'text': 'Quel acteur joue Tony Stark dans "Iron Man" ?',
            'point': 1.0,
            'options': [
              {'id': '6CT_Q4_O1', 'text': 'Robert Downey Jr.', 'isCorrect': 1},
              {'id': '6CT_Q4_O2', 'text': 'Chris Evans', 'isCorrect': 0},
              {'id': '6CT_Q4_O3', 'text': 'Chris Hemsworth', 'isCorrect': 0},
              {'id': '6CT_Q4_O4', 'text': 'Mark Ruffalo', 'isCorrect': 0},
            ]
          },
          {
            'id': '6CT_Q5',
            'text': 'Quel film est considéré comme le premier long-métrage d’animation de Disney ?',
            'point': 1.0,
            'options': [
              {'id': '6CT_Q5_O1', 'text': 'Blanche-Neige et les Sept Nains', 'isCorrect': 1},
              {'id': '6CT_Q5_O2', 'text': 'Pinocchio', 'isCorrect': 0},
              {'id': '6CT_Q5_O3', 'text': 'Cendrillon', 'isCorrect': 0},
              {'id': '6CT_Q5_O4', 'text': 'La Belle et la Bête', 'isCorrect': 0},
            ]
          },
        ],
      },
      {
        'categoryId': '9CT', // Voyage
        'questions': [
          {
            'id': '7CT_Q1',
            'text': 'Quelle ville est surnommée "la ville lumière" ?',
            'point': 1.0,
            'options': [
              {'id': '7CT_Q1_O1', 'text': 'Paris', 'isCorrect': 1},
              {'id': '7CT_Q1_O2', 'text': 'New York', 'isCorrect': 0},
              {'id': '7CT_Q1_O3', 'text': 'Rome', 'isCorrect': 0},
              {'id': '7CT_Q1_O4', 'text': 'Tokyo', 'isCorrect': 0},
            ]
          },
          {
            'id': '7CT_Q2',
            'text': 'Quel pays est célèbre pour ses pyramides ?',
            'point': 1.0,
            'options': [
              {'id': '7CT_Q2_O1', 'text': 'Égypte', 'isCorrect': 1},
              {'id': '7CT_Q2_O2', 'text': 'Mexique', 'isCorrect': 0},
              {'id': '7CT_Q2_O3', 'text': 'Inde', 'isCorrect': 0},
              {'id': '7CT_Q2_O4', 'text': 'Chine', 'isCorrect': 0},
            ]
          },
          {
            'id': '7CT_Q3',
            'text': 'Quel pays est surnommé "le pays du soleil levant" ?',
            'point': 1.0,
            'options': [
              {'id': '7CT_Q3_O1', 'text': 'Japon', 'isCorrect': 1},
              {'id': '7CT_Q3_O2', 'text': 'Chine', 'isCorrect': 0},
              {'id': '7CT_Q3_O3', 'text': 'Corée du Sud', 'isCorrect': 0},
              {'id': '7CT_Q3_O4', 'text': 'Thaïlande', 'isCorrect': 0},
            ]
          },
          {
            'id': '7CT_Q4',
            'text': 'Quel est le plus grand désert du monde ?',
            'point': 1.0,
            'options': [
              {'id': '7CT_Q4_O1', 'text': 'Le désert de l’Antarctique', 'isCorrect': 1},
              {'id': '7CT_Q4_O2', 'text': 'Le Sahara', 'isCorrect': 0},
              {'id': '7CT_Q4_O3', 'text': 'Le Gobi', 'isCorrect': 0},
              {'id': '7CT_Q4_O4', 'text': 'Le Kalahari', 'isCorrect': 0},
            ]
          },
          {
            'id': '7CT_Q5',
            'text': 'Quelle ville italienne est célèbre pour ses canaux ?',
            'point': 1.0,
            'options': [
              {'id': '7CT_Q5_O1', 'text': 'Venise', 'isCorrect': 1},
              {'id': '7CT_Q5_O2', 'text': 'Rome', 'isCorrect': 0},
              {'id': '7CT_Q5_O3', 'text': 'Florence', 'isCorrect': 0},
              {'id': '7CT_Q5_O4', 'text': 'Milan', 'isCorrect': 0},
            ]
          },
        ],
      },
      {
        'categoryId': '10CT', // Mode
        'questions': [
          {
            'id': '8CT_Q1',
            'text': 'Quelle marque est célèbre pour son logo à la pomme ?',
            'point': 1.0,
            'options': [
              {'id': '8CT_Q1_O1', 'text': 'Apple', 'isCorrect': 1},
              {'id': '8CT_Q1_O2', 'text': 'Gucci', 'isCorrect': 0},
              {'id': '8CT_Q1_O3', 'text': 'Nike', 'isCorrect': 0},
              {'id': '8CT_Q1_O4', 'text': 'Adidas', 'isCorrect': 0},
            ]
          },
          {
            'id': '8CT_Q2',
            'text': 'Qui est le créateur de la célèbre petite robe noire ?',
            'point': 1.0,
            'options': [
              {'id': '8CT_Q2_O1', 'text': 'Coco Chanel', 'isCorrect': 1},
              {'id': '8CT_Q2_O2', 'text': 'Christian Dior', 'isCorrect': 0},
              {'id': '8CT_Q2_O3', 'text': 'Yves Saint Laurent', 'isCorrect': 0},
              {'id': '8CT_Q2_O4', 'text': 'Karl Lagerfeld', 'isCorrect': 0},
            ]
          },
          {
            'id': '8CT_Q3',
            'text': 'Quel accessoire est emblématique de la marque Hermès ?',
            'point': 1.0,
            'options': [
              {'id': '8CT_Q3_O1', 'text': 'Le carré en soie', 'isCorrect': 1},
              {'id': '8CT_Q3_O2', 'text': 'Les baskets', 'isCorrect': 0},
              {'id': '8CT_Q3_O3', 'text': 'Le jean', 'isCorrect': 0},
              {'id': '8CT_Q3_O4', 'text': 'Le sac à dos', 'isCorrect': 0},
            ]
          },
          {
            'id': '8CT_Q4',
            'text': 'Quel tissu est fabriqué à partir de la plante de même nom ?',
            'point': 1.0,
            'options': [
              {'id': '8CT_Q4_O1', 'text': 'Le coton', 'isCorrect': 1},
              {'id': '8CT_Q4_O2', 'text': 'La soie', 'isCorrect': 0},
              {'id': '8CT_Q4_O3', 'text': 'Le lin', 'isCorrect': 0},
              {'id': '8CT_Q4_O4', 'text': 'La laine', 'isCorrect': 0},
            ]
          },
          {
            'id': '8CT_Q5',
            'text': 'Quelle tendance mode privilégie des vêtements larges et confortables ?',
            'point': 1.0,
            'options': [
              {'id': '8CT_Q5_O1', 'text': 'Le streetwear', 'isCorrect': 1},
              {'id': '8CT_Q5_O2', 'text': 'Le chic classique', 'isCorrect': 0},
              {'id': '8CT_Q5_O3', 'text': 'Haute couture', 'isCorrect': 0},
              {'id': '8CT_Q5_O4', 'text': 'Le minimalisme', 'isCorrect': 0},
            ]
          },
        ],
      },
      {
        'categoryId': '11CT', // Cuisine
        'questions': [
          {
            'id': '9CT_Q1',
            'text': 'Quel pays est célèbre pour ses sushis ?',
            'point': 1.0,
            'options': [
              {'id': '9CT_Q1_O1', 'text': 'Japon', 'isCorrect': 1},
              {'id': '9CT_Q1_O2', 'text': 'Chine', 'isCorrect': 0},
              {'id': '9CT_Q1_O3', 'text': 'Corée', 'isCorrect': 0},
              {'id': '9CT_Q1_O4', 'text': 'Thaïlande', 'isCorrect': 0},
            ]
          },
          {
            'id': '9CT_Q2',
            'text': 'Quelle herbe est souvent utilisée dans le pesto ?',
            'point': 1.0,
            'options': [
              {'id': '9CT_Q2_O1', 'text': 'Basilic', 'isCorrect': 1},
              {'id': '9CT_Q2_O2', 'text': 'Persil', 'isCorrect': 0},
              {'id': '9CT_Q2_O3', 'text': 'Coriandre', 'isCorrect': 0},
              {'id': '9CT_Q2_O4', 'text': 'Menthe', 'isCorrect': 0},
            ]
          },
          {
            'id': '9CT_Q3',
            'text': 'Quel ingrédient principal entre dans la composition de la ratatouille ?',
            'point': 1.0,
            'options': [
              {'id': '9CT_Q3_O1', 'text': 'Aubergine', 'isCorrect': 1},
              {'id': '9CT_Q3_O2', 'text': 'Riz', 'isCorrect': 0},
              {'id': '9CT_Q3_O3', 'text': 'Poulet', 'isCorrect': 0},
              {'id': '9CT_Q3_O4', 'text': 'Pomme de terre', 'isCorrect': 0},
            ]
          },
          {
            'id': '9CT_Q4',
            'text': 'Quel type de pâte est utilisé pour faire des lasagnes ?',
            'point': 1.0,
            'options': [
              {'id': '9CT_Q4_O1', 'text': 'Pâtes larges', 'isCorrect': 1},
              {'id': '9CT_Q4_O2', 'text': 'Spaghetti', 'isCorrect': 0},
              {'id': '9CT_Q4_O3', 'text': 'Macaronis', 'isCorrect': 0},
              {'id': '9CT_Q4_O4', 'text': 'Tagliatelles fines', 'isCorrect': 0},
            ]
          },
          {
            'id': '9CT_Q5',
            'text': 'Quel fromage est utilisé traditionnellement pour la pizza Margherita ?',
            'point': 1.0,
            'options': [
              {'id': '9CT_Q5_O1', 'text': 'Mozzarella', 'isCorrect': 1},
              {'id': '9CT_Q5_O2', 'text': 'Cheddar', 'isCorrect': 0},
              {'id': '9CT_Q5_O3', 'text': 'Gorgonzola', 'isCorrect': 0},
              {'id': '9CT_Q5_O4', 'text': 'Brie', 'isCorrect': 0},
            ]
          },
        ],
      },
      {
        'categoryId': '13CT', // Politique
        'questions': [
          {
            'id': '10CT_Q1',
            'text': 'Quel document établit les règles fondamentales d’un pays ?',
            'point': 1.0,
            'options': [
              {'id': '10CT_Q1_O1', 'text': 'La Constitution', 'isCorrect': 1},
              {'id': '10CT_Q1_O2', 'text': 'Le Code civil', 'isCorrect': 0},
              {'id': '10CT_Q1_O3', 'text': 'Le Traité', 'isCorrect': 0},
              {'id': '10CT_Q1_O4', 'text': 'Le Décret', 'isCorrect': 0},
            ]
          },
          {
            'id': '10CT_Q2',
            'text': 'Qui est élu pour représenter le peuple dans une démocratie ?',
            'point': 1.0,
            'options': [
              {'id': '10CT_Q2_O1', 'text': 'Le parlementaire', 'isCorrect': 1},
              {'id': '10CT_Q2_O2', 'text': 'Le dictateur', 'isCorrect': 0},
              {'id': '10CT_Q2_O3', 'text': 'Le maire', 'isCorrect': 0},
              {'id': '10CT_Q2_O4', 'text': 'Le juge', 'isCorrect': 0},
            ]
          },
          {
            'id': '10CT_Q3',
            'text': 'Quel type de régime se caractérise par la concentration du pouvoir ?',
            'point': 1.0,
            'options': [
              {'id': '10CT_Q3_O1', 'text': 'Autoritaire', 'isCorrect': 1},
              {'id': '10CT_Q3_O2', 'text': 'Démocratique', 'isCorrect': 0},
              {'id': '10CT_Q3_O3', 'text': 'Parlementaire', 'isCorrect': 0},
              {'id': '10CT_Q3_O4', 'text': 'Fédéral', 'isCorrect': 0},
            ]
          },
          {
            'id': '10CT_Q4',
            'text': 'Quel organisme international est dédié à la paix et la sécurité ?',
            'point': 1.0,
            'options': [
              {'id': '10CT_Q4_O1', 'text': 'L’ONU', 'isCorrect': 1},
              {'id': '10CT_Q4_O2', 'text': 'FMI', 'isCorrect': 0},
              {'id': '10CT_Q4_O3', 'text': 'OMC', 'isCorrect': 0},
              {'id': '10CT_Q4_O4', 'text': 'UE', 'isCorrect': 0},
            ]
          },
          {
            'id': '10CT_Q5',
            'text': 'Lequel est un droit fondamental en démocratie ?',
            'point': 1.0,
            'options': [
              {'id': '10CT_Q5_O1', 'text': 'Le droit de vote', 'isCorrect': 1},
              {'id': '10CT_Q5_O2', 'text': 'Le monopole', 'isCorrect': 0},
              {'id': '10CT_Q5_O3', 'text': 'La censure', 'isCorrect': 0},
              {'id': '10CT_Q5_O4', 'text': 'L’esclavage', 'isCorrect': 0},
            ]
          },
        ],
      },
      {
        'categoryId': '14CT', // Environnement
        'questions': [
          {
            'id': '11CT_Q1',
            'text': 'Quel gaz contribue le plus à l’effet de serre ?',
            'point': 1.0,
            'options': [
              {'id': '11CT_Q1_O1', 'text': 'CO2', 'isCorrect': 1},
              {'id': '11CT_Q1_O2', 'text': 'O2', 'isCorrect': 0},
              {'id': '11CT_Q1_O3', 'text': 'N2', 'isCorrect': 0},
              {'id': '11CT_Q1_O4', 'text': 'H2', 'isCorrect': 0},
            ]
          },
          {
            'id': '11CT_Q2',
            'text': 'Quel phénomène est causé par la déforestation ?',
            'point': 1.0,
            'options': [
              {'id': '11CT_Q2_O1', 'text': 'Érosion des sols', 'isCorrect': 1},
              {'id': '11CT_Q2_O2', 'text': 'Pluies acides', 'isCorrect': 0},
              {'id': '11CT_Q2_O3', 'text': 'Séismes', 'isCorrect': 0},
              {'id': '11CT_Q2_O4', 'text': 'Volcanisme', 'isCorrect': 0},
            ]
          },
          {
            'id': '11CT_Q3',
            'text': 'Quel est l’objectif principal des énergies renouvelables ?',
            'point': 1.0,
            'options': [
              {'id': '11CT_Q3_O1', 'text': 'Réduire les émissions de CO2', 'isCorrect': 1},
              {'id': '11CT_Q3_O2', 'text': 'Augmenter la pollution', 'isCorrect': 0},
              {'id': '11CT_Q3_O3', 'text': 'Produire des déchets nucléaires', 'isCorrect': 0},
              {'id': '11CT_Q3_O4', 'text': 'Réduire l’eau potable', 'isCorrect': 0},
            ]
          },
          {
            'id': '11CT_Q4',
            'text': 'Quel accord international vise à limiter le réchauffement climatique ?',
            'point': 1.0,
            'options': [
              {'id': '11CT_Q4_O1', 'text': 'Accord de Paris', 'isCorrect': 1},
              {'id': '11CT_Q4_O2', 'text': 'Accord de Kyoto', 'isCorrect': 0},
              {'id': '11CT_Q4_O3', 'text': 'Protocole de Montréal', 'isCorrect': 0},
              {'id': '11CT_Q4_O4', 'text': 'Traité de Versailles', 'isCorrect': 0},
            ]
          },
          {
            'id': '11CT_Q5',
            'text': 'Quel est le principal polluant des océans ?',
            'point': 1.0,
            'options': [
              {'id': '11CT_Q5_O1', 'text': 'Plastique', 'isCorrect': 1},
              {'id': '11CT_Q5_O2', 'text': 'Oxygène', 'isCorrect': 0},
              {'id': '11CT_Q5_O3', 'text': 'Sable', 'isCorrect': 0},
              {'id': '11CT_Q5_O4', 'text': 'Phosphore', 'isCorrect': 0},
            ]
          },
        ],
      },
      {
        'categoryId': '16CT', // Littérature
        'questions': [
          {
            'id': '12CT_Q1',
            'text': 'Qui a écrit "Les Misérables" ?',
            'point': 1.0,
            'options': [
              {'id': '12CT_Q1_O1', 'text': 'Victor Hugo', 'isCorrect': 1},
              {'id': '12CT_Q1_O2', 'text': 'Émile Zola', 'isCorrect': 0},
              {'id': '12CT_Q1_O3', 'text': 'Gustave Flaubert', 'isCorrect': 0},
              {'id': '12CT_Q1_O4', 'text': 'Alexandre Dumas', 'isCorrect': 0},
            ]
          },
          {
            'id': '12CT_Q2',
            'text': 'Quel genre littéraire est "Roméo et Juliette" ?',
            'point': 1.0,
            'options': [
              {'id': '12CT_Q2_O1', 'text': 'Tragédie', 'isCorrect': 1},
              {'id': '12CT_Q2_O2', 'text': 'Comédie', 'isCorrect': 0},
              {'id': '12CT_Q2_O3', 'text': 'Roman policier', 'isCorrect': 0},
              {'id': '12CT_Q2_O4', 'text': 'Essai', 'isCorrect': 0},
            ]
          },
          {
            'id': '12CT_Q3',
            'text': 'Quel auteur est célèbre pour "Harry Potter" ?',
            'point': 1.0,
            'options': [
              {'id': '12CT_Q3_O1', 'text': 'J.K. Rowling', 'isCorrect': 1},
              {'id': '12CT_Q3_O2', 'text': 'J.R.R. Tolkien', 'isCorrect': 0},
              {'id': '12CT_Q3_O3', 'text': 'George R.R. Martin', 'isCorrect': 0},
              {'id': '12CT_Q3_O4', 'text': 'Suzanne Collins', 'isCorrect': 0},
            ]
          },
          {
            'id': '12CT_Q4',
            'text': 'Quel est le thème principal de "1984" de George Orwell ?',
            'point': 1.0,
            'options': [
              {'id': '12CT_Q4_O1', 'text': 'La surveillance et la dictature', 'isCorrect': 1},
              {'id': '12CT_Q4_O2', 'text': 'L’amour romantique', 'isCorrect': 0},
              {'id': '12CT_Q4_O3', 'text': 'Les voyages dans le temps', 'isCorrect': 0},
              {'id': '12CT_Q4_O4', 'text': 'La cuisine', 'isCorrect': 0},
            ]
          },
          {
            'id': '12CT_Q5',
            'text': 'Quel terme désigne une œuvre poétique composée de 14 vers ?',
            'point': 1.0,
            'options': [
              {'id': '12CT_Q5_O1', 'text': 'Sonnet', 'isCorrect': 1},
              {'id': '12CT_Q5_O2', 'text': 'Haïku', 'isCorrect': 0},
              {'id': '12CT_Q5_O3', 'text': 'Épopée', 'isCorrect': 0},
              {'id': '12CT_Q5_O4', 'text': 'Ballade', 'isCorrect': 0},
            ]
          },
        ],
      },
      {
        'categoryId': '17CT', // Technologie
        'questions': [
          {
            'id': '13CT_Q1',
            'text': 'Quel est le langage utilisé pour créer des pages web ?',
            'point': 1.0,
            'options': [
              {'id': '13CT_Q1_O1', 'text': 'HTML', 'isCorrect': 1},
              {'id': '13CT_Q1_O2', 'text': 'Python', 'isCorrect': 0},
              {'id': '13CT_Q1_O3', 'text': 'C++', 'isCorrect': 0},
              {'id': '13CT_Q1_O4', 'text': 'Java', 'isCorrect': 0},
            ]
          },
          {
            'id': '13CT_Q2',
            'text': 'Quel système d’exploitation est développé par Microsoft ?',
            'point': 1.0,
            'options': [
              {'id': '13CT_Q2_O1', 'text': 'Windows', 'isCorrect': 1},
              {'id': '13CT_Q2_O2', 'text': 'Linux', 'isCorrect': 0},
              {'id': '13CT_Q2_O3', 'text': 'macOS', 'isCorrect': 0},
              {'id': '13CT_Q2_O4', 'text': 'Android', 'isCorrect': 0},
            ]
          },
          {
            'id': '13CT_Q3',
            'text': 'Qu’est-ce que l’IA ?',
            'point': 1.0,
            'options': [
              {'id': '13CT_Q3_O1', 'text': 'Intelligence Artificielle', 'isCorrect': 1},
              {'id': '13CT_Q3_O2', 'text': 'Interface Avancée', 'isCorrect': 0},
              {'id': '13CT_Q3_O3', 'text': 'Internet Adaptatif', 'isCorrect': 0},
              {'id': '13CT_Q3_O4', 'text': 'Intégration Automatique', 'isCorrect': 0},
            ]
          },
          {
            'id': '13CT_Q4',
            'text': 'Quelle entreprise fabrique l’iPhone ?',
            'point': 1.0,
            'options': [
              {'id': '13CT_Q4_O1', 'text': 'Apple', 'isCorrect': 1},
              {'id': '13CT_Q4_O2', 'text': 'Samsung', 'isCorrect': 0},
              {'id': '13CT_Q4_O3', 'text': 'Huawei', 'isCorrect': 0},
              {'id': '13CT_Q4_O4', 'text': 'Sony', 'isCorrect': 0},
            ]
          },
          {
            'id': '13CT_Q5',
            'text': 'Quel protocole est utilisé pour sécuriser les échanges sur Internet ?',
            'point': 1.0,
            'options': [
              {'id': '13CT_Q5_O1', 'text': 'HTTPS', 'isCorrect': 1},
              {'id': '13CT_Q5_O2', 'text': 'HTTP', 'isCorrect': 0},
              {'id': '13CT_Q5_O3', 'text': 'FTP', 'isCorrect': 0},
              {'id': '13CT_Q5_O4', 'text': 'SMTP', 'isCorrect': 0},
            ]
          },
        ],
      },
      {
        'categoryId': '18CT', // Entrepreneuriat
        'questions': [
          {
            'id': '14CT_Q1',
            'text': 'Qu’est-ce qu’un business plan ?',
            'point': 1.0,
            'options': [
              {'id': '14CT_Q1_O1', 'text': 'Un plan stratégique pour une entreprise', 'isCorrect': 1},
              {'id': '14CT_Q1_O2', 'text': 'Un document fiscal', 'isCorrect': 0},
              {'id': '14CT_Q1_O3', 'text': 'Une facture client', 'isCorrect': 0},
              {'id': '14CT_Q1_O4', 'text': 'Un manuel technique', 'isCorrect': 0},
            ]
          },
          {
            'id': '14CT_Q2',
            'text': 'Quel terme désigne la création d’une nouvelle entreprise ?',
            'point': 1.0,
            'options': [
              {'id': '14CT_Q2_O1', 'text': 'Entrepreneuriat', 'isCorrect': 1},
              {'id': '14CT_Q2_O2', 'text': 'Investissement', 'isCorrect': 0},
              {'id': '14CT_Q2_O3', 'text': 'Management', 'isCorrect': 0},
              {'id': '14CT_Q2_O4', 'text': 'Marketing', 'isCorrect': 0},
            ]
          },
          {
            'id': '14CT_Q3',
            'text': 'Quel financement est obtenu sans rembourser immédiatement ?',
            'point': 1.0,
            'options': [
              {'id': '14CT_Q3_O1', 'text': 'Subvention', 'isCorrect': 1},
              {'id': '14CT_Q3_O2', 'text': 'Prêt bancaire', 'isCorrect': 0},
              {'id': '14CT_Q3_O3', 'text': 'Emprunt obligataire', 'isCorrect': 0},
              {'id': '14CT_Q3_O4', 'text': 'Crowdlending', 'isCorrect': 0},
            ]
          },
          {
            'id': '14CT_Q4',
            'text': 'Quel document formalise la propriété d’une entreprise ?',
            'point': 1.0,
            'options': [
              {'id': '14CT_Q4_O1', 'text': 'Statuts de société', 'isCorrect': 1},
              {'id': '14CT_Q4_O2', 'text': 'Contrat de travail', 'isCorrect': 0},
              {'id': '14CT_Q4_O3', 'text': 'Facture', 'isCorrect': 0},
              {'id': '14CT_Q4_O4', 'text': 'Déclaration fiscale', 'isCorrect': 0},
            ]
          },
          {
            'id': '14CT_Q5',
            'text': 'Quel terme désigne la stratégie pour attirer et fidéliser les clients ?',
            'point': 1.0,
            'options': [
              {'id': '14CT_Q5_O1', 'text': 'Marketing', 'isCorrect': 1},
              {'id': '14CT_Q5_O2', 'text': 'Comptabilité', 'isCorrect': 0},
              {'id': '14CT_Q5_O3', 'text': 'Logistique', 'isCorrect': 0},
              {'id': '14CT_Q5_O4', 'text': 'Juridique', 'isCorrect': 0},
            ]
          },
        ],
      },
    ];

    // Insertion en BATCH (performant) + ignore si déjà présent
    final batch = db.batch();

    for (final cat in data) {
      final String categoryId = cat['categoryId'];
      final List questions = cat['questions'];

      for (final q in questions) {
        batch.insert(
          'questions',
          {
            'id': q['id'],
            'question_text': q['text'],
            'category_id': categoryId,
            'point': q['point'],
          },
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );

        final List options = q['options'];
        for (final o in options) {
          batch.insert(
            'options',
            {
              'id': o['id'],
              'question_id': q['id'],
              'option_text': o['text'],
              'is_correct': o['isCorrect'],
            },
            conflictAlgorithm: ConflictAlgorithm.ignore,
          );
        }
      }
    }

    await batch.commit(noResult: true);
  }

}