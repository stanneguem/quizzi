import 'package:flutter/material.dart';
import 'dart:math';

class GameSetupPage extends StatefulWidget {
  const GameSetupPage({super.key});

  @override
  State<GameSetupPage> createState() => _GameSetupPageState();
}

class _GameSetupPageState extends State<GameSetupPage> {
  // Example categories (could come from DB)
  final List<Map<String, String>> _allCategories = [
    {'id': '1CT', 'title': 'Informatique'},
    {'id': '2CT', 'title': 'Santé'},
    {'id': '3CT', 'title': 'Art'},
    {'id': '4CT', 'title': 'Sport'},
    {'id': '5CT', 'title': 'Éducation'},
    {'id': '6CT', 'title': 'Finance'},
    {'id': '7CT', 'title': 'Musique'},
    {'id': '8CT', 'title': 'Cinéma'},
    {'id': '9CT', 'title': 'Voyage'},
    {'id': '10CT', 'title': 'Mode'},
  ];

  // number of players is limited to categories.length - 1 (reserve one category)
  late int _minPlayers;
  late int _maxPlayers;
  int _numberOfPlayers = 2;

  // Step management: 0 = count, 1 = players forms, 2 = review
  int _currentStep = 0;

  // PageController to show the player forms as pages
  final PageController _pageController = PageController();

  // Player models
  late List<PlayerFormModel> _players;

  @override
  void initState() {
    super.initState();
    _minPlayers = 1;
    _maxPlayers = max(1, _allCategories.length - 1);
    _numberOfPlayers = min(4, _maxPlayers); // default to 4 or less
    _initPlayers();
  }

  void _initPlayers() {
    _players = List.generate(_numberOfPlayers, (index) {
      return PlayerFormModel(
        id: 'p${index + 1}',
        nameController: TextEditingController(),
        selectedCategoryId: null,
      );
    });
    setState(() {});
  }

  void _changeNumberOfPlayers(int newCount) {
    if (newCount == _numberOfPlayers) return;
    final old = _players;
    final newList = <PlayerFormModel>[];

    // keep existing data when possible
    for (int i = 0; i < newCount; i++) {
      if (i < old.length) {
        newList.add(old[i]);
      } else {
        newList.add(PlayerFormModel(
          id: 'p${i + 1}',
          nameController: TextEditingController(),
          selectedCategoryId: null,
        ));
      }
    }

    // if categories were selected but now overflow, free the extra categories
    if (newCount < old.length) {
      // remove selections beyond newCount
      for (int i = newCount; i < old.length; i++) {
        old[i].selectedCategoryId = null;
      }
    }

    _numberOfPlayers = newCount;
    _players = newList;
    setState(() {});
  }

  List<String> _categoriesTaken() {
    return _players
        .map((p) => p.selectedCategoryId)
        .where((c) => c != null)
        .cast<String>()
        .toList();
  }

  List<Map<String, String>> _availableCategoriesForPlayer(int playerIndex) {
    final taken = _categoriesTaken();
    final mySelection = _players[playerIndex].selectedCategoryId;
    return _allCategories.where((cat) {
      if (mySelection != null && cat['id'] == mySelection) return true;
      return !taken.contains(cat['id']);
    }).toList();
  }

  bool _validatePlayers() {
    for (var p in _players) {
      if (p.nameController.text.trim().isEmpty) return false;
      if (p.selectedCategoryId == null) return false;
    }
    // also ensure uniqueness of categories
    final taken = _categoriesTaken();
    if (taken.length != taken.toSet().length) return false;
    return true;
  }

  void _onStartPressed() {
    if (!_validatePlayers()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Veuillez remplir tous les pseudos et choisir une catégorie unique.'),
      ));
      return;
    }

    // Build the configuration model
    final config = GameConfiguration(
      id: UniqueKey().toString(),
      players: _players
          .map((p) => PlayerConfiguration(
        id: p.id,
        name: p.nameController.text.trim(),
        categoryId: p.selectedCategoryId!,
      ))
          .toList(),
      createdAt: DateTime.now(),
    );

    // TODO: pass `config` to your game service to fetch questions and start the match
    // For demo, we'll print to console and show a dialog
    debugPrint('Game config: ${config.toString()}');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Partie prête'),
        content: Text('La partie est prête à démarrer pour ${config.players.length} joueurs.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  Widget _buildParticipantsStep() {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Container(
                alignment: Alignment.center,
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Text('Combien de participants ?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))
            ),
            const SizedBox(height: 8),
            Text('Maximum: $_maxPlayers (nombre de catégories - 1)'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Slider.adaptive(
                    min: _minPlayers.toDouble(),
                    max: _maxPlayers.toDouble(),
                    divisions: _maxPlayers - _minPlayers,
                    value: _numberOfPlayers.toDouble(),
                    label: '$_numberOfPlayers',
                    onChanged: (v) {
                      setState(() {
                        _numberOfPlayers = v.round();
                        _changeNumberOfPlayers(_numberOfPlayers);
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
            const SizedBox(height: 20),
            Text('Remarque : Deux joueurs ne peuvent pas choisir la même catégorie.',textAlign: TextAlign.center ,style: TextStyle(color: Colors.grey[600])),
          ],
        ),
        Positioned(
          left: 155,
          top: 0,
          child: Container(
            alignment: Alignment.center,
            height: 80,
            width: 80,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle
            ),
          ),
        ),
        Positioned(
          left: 160,
          top: 3,
          child: Container(
            alignment: Alignment.center,
            height: 70,
            width: 70,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle
            ),
            child: Text('$_numberOfPlayers'),
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerForm(int index) {
    final player = _players[index];
    final available = _availableCategoriesForPlayer(index);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(15)
            ),
            child: Text('Configuration du Joueur ${index + 1}',textAlign: TextAlign.center ,style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
          ),
          const SizedBox(height: 18),
          Text("Pseudo", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
          TextField(
            controller: player.nameController,
            decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
            ),
          ),
          const SizedBox(height: 18),
          DropdownButtonFormField<String>(
            value: player.selectedCategoryId,
            items: available
                .map((cat) => DropdownMenuItem<String>(
              value: cat['id'],
              child: Text(cat['title']!),
            ))
                .toList(),
            onChanged: (value) {
              setState(() {
                player.selectedCategoryId = value;
              });
            },
            decoration: InputDecoration(labelText: 'Catégorie', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayersStep() {
    return Column(
      children: [
        SizedBox(
          height: 560,
          child: PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _numberOfPlayers,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: SingleChildScrollView(
                  child: _buildPlayerForm(index),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    // jump to previous player
                    final p = _pageController.page!.toInt();
                    final prev = max(0, p - 1);
                    _pageController.jumpToPage(prev);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(25)
                    ),
                    width: 150,
                    height: 50,
                    child: Text('Retour', textAlign: TextAlign.center ,style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    // next player
                    final p = _pageController.page!.toInt();
                    final next = min(_numberOfPlayers - 1, p + 1);
                    _pageController.jumpToPage(next);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25)
                    ),
                    width: 150,
                    height: 50,
                    child: Text('Suivant joueur', textAlign: TextAlign.center ,style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        const Text('Récapitulatif', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ..._players.map((p) {
          final cat = _allCategories.firstWhere((c) => c['id'] == p.selectedCategoryId, orElse: () => {'title': '—'});
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: CircleAvatar(child: Text(p.id.replaceAll('p', ''))),
              title: Text(p.nameController.text.isEmpty ? '(Pseudo non défini)' : p.nameController.text),
              subtitle: Text('Catégorie: ${cat['title']}'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // go to player page
                  final idx = _players.indexOf(p);
                  setState(() {
                    _currentStep = 1;
                    _pageController.jumpToPage(idx);
                  });
                },
              ),
            ),
          );
        }).toList(),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  _currentStep = 1;
                });
              },
              child: const Text('Modifier'),
            ),
            ElevatedButton(
              onPressed: _onStartPressed,
              child: const Text('Commencer la partie'),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildParticipantsStep();
      case 1:
        return _buildPlayersStep();
      case 2:
        return _buildSummaryStep();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurer la partie'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Info'),
                  content: const Text('Choisissez le nombre de joueurs (max = catégories - 1), puis définissez le pseudo et la catégorie pour chaque joueur.'),
                  actions: [
                    TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Expanded(child: SingleChildScrollView(child: _buildStepContent())),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            if (_currentStep > 0)
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _currentStep = max(0, _currentStep - 1);
                    });
                  },
                  child: const Text('Retour'),
                ),
              ),
            if (_currentStep > 0) const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_currentStep < 2) {
                      _currentStep++;
                    } else {
                      _onStartPressed();
                    }
                  });
                },
                child: Text(_currentStep < 2 ? 'Suivant' : 'Commencer'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayerFormModel {
  final String id;
  final TextEditingController nameController;
  String? selectedCategoryId;

  PlayerFormModel({required this.id, required this.nameController, this.selectedCategoryId});
}

class GameConfiguration {
  final String id;
  final List<PlayerConfiguration> players;
  final DateTime createdAt;

  GameConfiguration({required this.id, required this.players, required this.createdAt});

  @override
  String toString() => 'GameConfiguration(id: $id, players: ${players.length}, createdAt: $createdAt)';
}

class PlayerConfiguration {
  final String id;
  final String name;
  final String categoryId;

  PlayerConfiguration({required this.id, required this.name, required this.categoryId});
}
