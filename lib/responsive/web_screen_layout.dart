import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instoo/utils/colors.dart';
import 'package:instoo/utils/global_variables.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  PageController pageController = PageController();
  int _page = 0;
  bool _isNavBarExpanded =
      false; // Controla si el NavigationRail está expandido

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          // Diseño para pantallas grandes
          return Scaffold(
            body: Row(
              children: [
                // NavBar en el lado izquierdo con ocultamiento/despliegue
                MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      _isNavBarExpanded = true; // Expande el menú al enfocar
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      _isNavBarExpanded = false; // Colapsa el menú al salir
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: _isNavBarExpanded ? 250 : 72, // Ancho dinámico
                    child: NavigationRail(
                      selectedIndex: _page,
                      onDestinationSelected: navigationTapped,
                      extended: _isNavBarExpanded,
                      backgroundColor: mobileBackgroundColor,
                      selectedIconTheme: const IconThemeData(
                        color: Colors.purpleAccent,
                        size: 36, // Icono grande
                      ),
                      unselectedIconTheme: const IconThemeData(
                        color: Colors.grey,
                        size: 30, // Icono no seleccionado grande
                      ),
                      selectedLabelTextStyle: const TextStyle(
                        color: Colors.purpleAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelTextStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.home),
                          label: Text('Inicio'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.search),
                          label: Text('Buscar'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.add_circle),
                          label: Text('Publicar Foto'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.code_rounded),
                          label: Text('Cursos de Programación'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.person),
                          label: Text('Perfil'),
                        ),
                      ],
                    ),
                  ),
                ),
                // Contenido principal
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    onPageChanged: onPageChanged,
                    children: homeScreenItems,
                  ),
                ),
              ],
            ),
          );
        } else {
          // Diseño para pantallas pequeñas
          return Scaffold(
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: onPageChanged,
              children: homeScreenItems,
            ),
            bottomNavigationBar: CupertinoTabBar(
              backgroundColor: mobileBackgroundColor,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: _page == 0 ? Colors.purpleAccent : Colors.white,
                    size: 28,
                  ),
                  label: 'Inicio',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    color: _page == 1 ? Colors.lightBlueAccent : Colors.white,
                    size: 28,
                  ),
                  label: 'Buscar',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add_circle,
                    color: _page == 2 ? Colors.lightGreen : Colors.white,
                    size: 28,
                  ),
                  label: 'Publicar foto',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.code_rounded,
                    color: _page == 3 ? Colors.deepOrangeAccent : Colors.white,
                    size: 28,
                  ),
                  label: 'Cursos de programación',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: _page == 4 ? Colors.deepPurpleAccent : Colors.white,
                    size: 28,
                  ),
                  label: 'Perfil',
                ),
              ],
              onTap: navigationTapped,
            ),
          );
        }
      },
    );
  }
}
