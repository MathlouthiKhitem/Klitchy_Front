import 'package:flutter/material.dart';

class ProfileSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 100),
            Container(
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      // Code pour gérer le retour lorsque l'icône est cliquée
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Icon(
                        Icons.arrow_back_ios_rounded, // Icône de retour
                        color: Color(0xFF717579), // Couleur du texte
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Profile settings',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF717579), // Couleur du texte
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Color(0xFF006C81), // Couleur de l'arrière-plan
                      shape: BoxShape.circle, // Forme du conteneur (cercle)
                    ),
                    child: Icon(
                      Icons.person_outline_rounded, // Icône utilisateur (à remplacer par votre propre icône)
                      size: 80,
                      color: Colors.white, // Couleur de l'icône
                    ),
                  ),
                  SizedBox(height: 40,),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 24.0), // Add padding to ListTile content
                    title: Row(
                      children: [
                        Flexible(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter text',
                              prefixIcon: Icon(
                                Icons.person_2_outlined, // Use the user icon
                                color: Color(0xFF006C81),
                                // Set the icon color to #006C81
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF006C81)), // Change the border color when focused
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Divider(), // Ligne de séparation entre les deux parties
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
                    title: Row(
                      children: [
                        Flexible(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Phone', // Texte "Phone" à afficher en tant que hint
                              prefixIcon: Icon(
                                Icons.phone_sharp,
                                color: Color(0xFF006C81),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF006C81),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // Action à effectuer lorsque la carte est cliquée
                        print('Card clicked');
                      },
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Set the border radius
                        ),// Ombre de la carte
                        margin: EdgeInsets.all(20.0), // Marge autour de la carte
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                // Action pour le bouton TextButton
                              },
                              child: const Row(
                                children: [
                                  SizedBox(width: 20), // Espacement entre l'icône et le texte

                                  Icon(
                                    Icons.shopping_cart, // Icône pour les commandes (à remplacer par votre propre icône)
                                    color: Color(0xFF006C81), // Couleur de l'icône
                                  ),
                                  SizedBox(width: 30), // Espacement entre l'icône et le texte
                                  Text(
                                    'Orders',
                                    style: TextStyle(
                                      color: Color(0xFF717579),
                                      fontSize: 17// Couleur du texte
                                    ),
                                  ),
                                  SizedBox(width: 200,),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined, // Icône "back" (à remplacer par votre propre icône)
                                    color: Color(0xFF717579), // Couleur de l'icône
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Color(0xFF006C81), // Couleur de la ligne de séparation
                              thickness: 2, // Épaisseur de la ligne de séparation (2 pixels)
                              height: 20, // Hauteur de la ligne de séparation (20 pixels)
                              indent: 10, // Marge à gauche de la ligne de séparation (10 pixels)
                              endIndent: 10, // Marge à droite de la ligne de séparation (10 pixels)
                            ),

                            // Ligne de séparation
                            TextButton(
                              onPressed: () {
                                // Action pour le bouton TextButton
                              },
                              child: const Row(
                                children: [

                                  SizedBox(width: 20), // Espacement entre l'icône "back" et les autres éléments
                                  Icon(
                                    Icons.settings, // Icône "Settings" (à remplacer par votre propre icône)
                                    color: Color(0xFF006C81), // Couleur de l'icône
                                  ),
                                  SizedBox(width: 10), // Espacement entre les icônes
                                  Text(
                                    'Settings',
                                    style: TextStyle(
                                      color: Color(0xFF717579), // Couleur du texte
                                      fontSize: 17, // Taille du texte
                                    ),
                                  ),
                                  SizedBox(width: 200,),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined, // Icône "back" (à remplacer par votre propre icône)
                                    color: Color(0xFF717579), // Couleur de l'icône
                                  ),
                                ],
                              ),
                            ),


                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () {
                      // Action à effectuer lorsque le bouton est pressé
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(211, 56), // Dimensions fixes
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16), // Padding
                      primary: Color(0xFF006C81), // Couleur de fond
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16), // Bordure arrondie
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.logout_outlined, // Icône du bouton (à remplacer par votre propre icône)
                          color: Colors.white, // Couleur de l'icône
                        ),
                        SizedBox(width: 10), // Espacement entre l'icône et le texte
                        Text(
                          'Sign out',
                          style: TextStyle(
                            color: Colors.white, // Couleur du texte
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
