import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() => runApp(MaterialApp(home: PlantCarePage()));

class PlantCarePage extends StatefulWidget {
  @override
  _PlantCarePageState createState() => _PlantCarePageState();
}

class _PlantCarePageState extends State<PlantCarePage> {
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic>? _plantData;
  bool _isLoading = false;
  String? _error;

  final String apiKey = 'BNG97557q7Xp2JYBOQVsjqUabaWjCc2ud7ELCq1N0vf0CP9wu5'; // 🔑 أدخل مفتاحك هنا
  Set<String> _favorites = {};
  String? _currentPlantName;

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _favorites = prefs.getStringList('favorites')?.toSet() ?? {};
    });
  }

  Future<void> toggleFavorite(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_favorites.contains(name)) {
        _favorites.remove(name);
      } else {
        _favorites.add(name);
      }
      prefs.setStringList('favorites', _favorites.toList());
    });
  }

  Future<void> fetchPlantData(String query) async {
    setState(() {
      _isLoading = true;
      _plantData = null;
      _error = null;
    });

    final url = Uri.parse("https://api.plant.id/v2/identify");

    final body = json.encode({
      "api_key": apiKey,
      "images": [],
      "modifiers": ["crops-fast", "similar_images"],
      "plant_language": "en",
      "plant_details": ["common_names", "url", "name_authority", "wiki_description", "taxonomy", "synonyms", "watering", "growth_rate", "main_image"],
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['suggestions'] != null && data['suggestions'].isNotEmpty) {
          final suggestion = data['suggestions'][0];
          setState(() {
            _plantData = {
              'name': suggestion['plant_name'],
              'binomial_name': suggestion['plant_details']?['scientific_name'],
              'sun_requirements': suggestion['plant_details']?['sunlight']?.join(", "),
              'watering': suggestion['plant_details']?['watering'],
              'soil_ph': suggestion['plant_details']?['soil_ph'],
              'description': suggestion['plant_details']?['wiki_description']?['value'],
              'main_image_path': suggestion['plant_details']?['main_image']['url'],
            };
            _currentPlantName = suggestion['plant_name'];
          });
        } else {
          setState(() {
            _error = 'لم يتم العثور على معلومات عن هذه النبتة.';
          });
        }
      } else {
        setState(() {
          _error = 'حدث خطأ: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'فشل الاتصال: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String fakeTranslateToArabic(String text) {
    if (text.toLowerCase().contains("basil")) return "الريحان نبات عطري يُستخدم كثيرًا في الطهي.";
    if (text.toLowerCase().contains("mint")) return "النعناع نبات سريع النمو برائحة مميزة.";
    if (text.toLowerCase().contains("tomato")) return "الطماطم نبات يحتاج إلى ضوء الشمس وسقاية جيدة.";
    return "🌍 الترجمة التلقائية غير متوفرة لهذا النص حاليًا.";
  }

  Widget buildPlantCard() {
    if (_plantData == null) return SizedBox();

    return Card(
      margin: EdgeInsets.symmetric(vertical: 16),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_plantData!['main_image_path'] != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  _plantData!['main_image_path'],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            if (_currentPlantName != null)
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    _favorites.contains(_currentPlantName!) ? Icons.star : Icons.star_border,
                    color: Colors.orange,
                  ),
                  onPressed: () => toggleFavorite(_currentPlantName!),
                  tooltip: 'أضف إلى المفضلة',
                ),
              ),
            SizedBox(height: 12),
            if (_plantData!['name'] != null)
              Text("🌿 الاسم: ${_plantData!['name']}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            if (_plantData!['binomial_name'] != null)
              Text("🔬 الاسم العلمي: ${_plantData!['binomial_name']}"),
            SizedBox(height: 10),
            if (_plantData!['sun_requirements'] != null)
              Text("☀️ الإضاءة: ${_plantData!['sun_requirements']}"),
            if (_plantData!['watering'] != null)
              Text("💧 كمية المياه: ${_plantData!['watering']}"),
            if (_plantData!['soil_ph'] != null)
              Text("⚗️ pH التربة: ${_plantData!['soil_ph']}"),
            if (_plantData!['description'] != null)
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("📋 الوصف بالإنجليزية:\n${_plantData!['description']}"),
                    SizedBox(height: 10),
                    Text("📘 الترجمة العربية:\n${fakeTranslateToArabic(_plantData!['description'])}",
                      style: TextStyle(color: Colors.green.shade800),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("معلومات العناية بالنبات"),
        actions: [
          IconButton(
            icon: Icon(Icons.star),
            tooltip: 'المفضلات',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FavoritesPage(
                    favorites: _favorites,
                    onSelectPlant: (name) {
                      _controller.text = name;
                      fetchPlantData(name);
                    },
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "ادخل اسم النبتة (بالإنجليزية)",
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => fetchPlantData(_controller.text.trim()),
                ),
              ),
            ),
            if (_isLoading) ...[
              SizedBox(height: 20),
              CircularProgressIndicator(),
            ] else if (_error != null) ...[
              SizedBox(height: 20),
              Text(_error!, style: TextStyle(color: Colors.red)),
            ] else ...[
              buildPlantCard(),
            ],
          ],
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  final Set<String> favorites;
  final Function(String) onSelectPlant;

  const FavoritesPage({required this.favorites, required this.onSelectPlant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("النباتات المفضلة")),
      body: favorites.isEmpty
          ? Center(child: Text("لا توجد نباتات مفضلة بعد."))
          : ListView(
        children: favorites.map((plant) {
          return ListTile(
            title: Text(plant),
            leading: Icon(Icons.local_florist, color: Colors.green),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              onSelectPlant(plant);
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }
}
