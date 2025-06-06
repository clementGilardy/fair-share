import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FairShareSettingsPage extends StatefulWidget {
  const FairShareSettingsPage({super.key});

  @override
  State<FairShareSettingsPage> createState() => _FairShareSettingsPageState();
}

class _FairShareSettingsPageState extends State<FairShareSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _revenu1Controller = TextEditingController();
  final TextEditingController _revenu2Controller = TextEditingController();

  // Variables pour stocker les valeurs originales
  String _originalRevenu1 = "0";
  String _originalRevenu2 = "0";

  // Variables pour suivre l'état de focus
  final FocusNode _focus1 = FocusNode();
  final FocusNode _focus2 = FocusNode();

  // Ajout d'un indicateur de chargement
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedValues();

    // Ajouter des listeners pour les événements de focus
    _focus1.addListener(_onFocusChange1);
    _focus2.addListener(_onFocusChange2);
  }

  @override
  void dispose() {
    _revenu1Controller.dispose();
    _revenu2Controller.dispose();
    _focus1.removeListener(_onFocusChange1);
    _focus2.removeListener(_onFocusChange2);
    _focus1.dispose();
    _focus2.dispose();
    super.dispose();
  }

  // Gestionnaire d'événements pour le focus du premier champ
  void _onFocusChange1() {
    if (_focus1.hasFocus) {
      // Quand le champ obtient le focus, vider le champ
      _originalRevenu1 = _revenu1Controller.text;
      _revenu1Controller.clear();
    } else {
      // Quand le champ perd le focus, vérifier s'il est vide
      if (_revenu1Controller.text.isEmpty) {
        // S'il est vide, restaurer la valeur originale
        _revenu1Controller.text = _originalRevenu1;
      }
    }
  }

  // Gestionnaire d'événements pour le focus du deuxième champ
  void _onFocusChange2() {
    if (_focus2.hasFocus) {
      // Quand le champ obtient le focus, vider le champ
      _originalRevenu2 = _revenu2Controller.text;
      _revenu2Controller.clear();
    } else {
      // Quand le champ perd le focus, vérifier s'il est vide
      if (_revenu2Controller.text.isEmpty) {
        // S'il est vide, restaurer la valeur originale
        _revenu2Controller.text = _originalRevenu2;
      }
    }
  }

  Future<void> _loadSavedValues() async {
    final prefs = await SharedPreferences.getInstance();

    // Préparer les valeurs avant de mettre à jour l'état
    final revenu1 = (prefs.getDouble('revenu1') ?? 0).toString();
    final revenu2 = (prefs.getDouble('revenu2') ?? 0).toString();

    // Mettre à jour les contrôleurs
    _revenu1Controller.text = revenu1;
    _revenu2Controller.text = revenu2;

    _originalRevenu1 = revenu1;
    _originalRevenu2 = revenu2;

    // Indiquer que le chargement est terminé
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveValues() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();

      final revenu1 = double.tryParse(_revenu1Controller.text) ?? 0;
      final revenu2 = double.tryParse(_revenu2Controller.text) ?? 0;

      await prefs.setDouble('revenu1', revenu1);
      await prefs.setDouble('revenu2', revenu2);

      _originalRevenu1 = _revenu1Controller.text;
      _originalRevenu2 = _revenu2Controller.text;

      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fair Share - Paramètres'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Revenus du couple',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _revenu1Controller,
                focusNode: _focus1,  // Associer le FocusNode
                decoration: const InputDecoration(
                  labelText: 'Revenu du premier conjoint',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.euro),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un montant';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _revenu2Controller,
                focusNode: _focus2,  // Associer le FocusNode
                decoration: const InputDecoration(
                  labelText: 'Revenu du deuxième conjoint',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.euro),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un montant';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              Center(
                child: ElevatedButton(
                  onPressed: _saveValues,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: const Text(
                    'Sauvegarder',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}