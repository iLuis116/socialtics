import 'package:flutter/material.dart';
import 'package:instoo/models/productos.dart';
import 'package:instoo/screens/Detalles.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final List<Product> products = [
    Product(
      name: 'Flutter - Móvil: De cero a experto',
      price: 349.00,
      description:
          'Este curso representa años de esfuerzo y estudio en Dart y Flutter sintetizados en más de 50 horas de video bajo demanda que van desde las bases del lenguaje Dart, hasta todo lo necesario para crear aplicaciones en Flutter funcionales y atractivas visualmente. El curso no sólo pretende enseñarte Dart y Flutter, sino que aprendas a crear aplicaciones reales siguiendo el Doman Driven Design, una forma de programar y estructurar proyectos que nos permitan hacer aplicaciones fáciles de expandir y mantener, pasando por Clean Code y varios patrones que te ayudarán a que estés orgulloso del código que escribes.',
      imageUrl: 'https://img-c.udemycdn.com/course/750x422/2306140_8181_2.jpg',
      url: 'https://www.udemy.com/share/108tCU/',
      career: 'TIADSM - IDGS',
    ),
    Product(
        name: 'Curso Python: De Principiante a Avanzado',
        price: 600.00,
        description:
            '¿Listo para sumergirte en el mundo de la programación y desbloquear nuevas oportunidades profesionales? Python, el lenguaje de programación versátil y demandado en diversas industrias, es el lugar perfecto para comenzar. Nuestro curso te guiará desde los conceptos básicos de Python, enseñándote a configurar tu entorno de desarrollo y a escribir tus primeros scripts, hasta dominar estructuras de datos avanzadas y la programación orientada a objetos. Con una combinación de teoría y práctica, aprenderás a manejar datos con eficiencia, a utilizar herramientas de desarrollo como VSCode y Jupyter notebook, y a aplicar fundamentos de programación como tipos de datos, operadores, y estructuras de control. Además, profundizarás en temas avanzados como funciones anónimas, manejo de archivos, y mucho más, todo mientras construyes un proyecto final que demuestra tus habilidades adquiridas. Este curso está diseñado para motivarte a pensar como un verdadero programador, solucionar problemas complejos y prepararte para desafíos reales en el mundo de la tecnología. No importa si estás comenzando tu camino en la programación o buscas fortalecer tus habilidades en Python, este curso te proporcionará las herramientas necesarias para alcanzar tus metas. Te invitamos a unirte a nuestra comunidad de aprendizaje. Da el paso y comienza tu viaje hacia el dominio de Python, abriendo la puerta a infinitas posibilidades en tu carrera profesional. Inscríbete hoy y transforma tu futuro con la programación.',
        imageUrl:
            'https://img-c.udemycdn.com/course/750x422/3586896_04a0_18.jpg',
        url: 'https://www.udemy.com/share/103Jo4/',
        career: 'TIADSM - TIAEVND - IDGS - IEVND'),
    Product(
        name: 'Javascript: El Curso Completo, Práctico y desde Cero',
        price: 699.00,
        description:
            '¿Quieres aprender Javascript pero no sabes por dónde empezar? ¿Estás cansado de ver tutoriales aburridos y mal explicados? ¡Bienvenido a "Javascript: El Curso Completo, Práctico y desde Cero!" En este curso aprenderás a programar en Javascript desde lo más básico hasta un nivel intermedio/avanzado. ¡No importa si no sabes programar! Este curso está diseñado para que aprendas desde cero y paso a paso mediante ejemplos, prácticas y proyectos. Ya sea que quieras iniciar una carrera en el desarrollo web, encontrar trabajo o desarrollar tus propias aplicaciones, este curso es para ti. Curso de más de 33 horas de video y 180 temas esenciales de Javascript. Para el final del curso, serás un programador con los conocimientos y habilidades necesarios para crear tus propios sitios web y aplicaciones utilizando Javascript. ¿Qué vas a aprender en este curso? Iniciamos el curso con una sección en la que aprenderás los fundamentos esenciales de la programación y Javascript. Aprenderás conceptos básicos como variables, tipos de datos, operadores, condicionales, funciones, métodos, ciclos y muchos otros temas importantes. Después aprenderás cómo trabajar con el BOM (Browser Object Model) y el DOM (Document Object Model) para acceder y modificar el contenido HTML y CSS de páginas web, agregar, eliminar y modificar elementos HTML en tiempo real, detectar y responder a eventos, crear animaciones y efectos visuales, y mucho más. (Nota: No necesitas conocimientos previos de HTML ni CSS. Estos temas son recomendables, pero si no los conoces, no te preocupes, el curso está diseñado para que puedas seguirlo sin problemas). En el curso también veremos cómo trabajar con formularios para poder recibir información, procesarla y validarla en tiempo real. Por último, aprenderás qué son las API y cómo utilizarlas para comunicarte con servicios y servidores para obtener y cargar información externa. Javascript moderno En este curso, aprenderás código moderno, ya que el curso está actualizado a ES6 (Ecmascript 6), una importante actualización de JavaScript que agregó muchas características nuevas, como formas de declarar variables, funciones de tipo flecha, clases, módulos, promesas, operadores y mucho más. Curso práctico lleno de ejemplos y proyectos Durante el curso, aprenderás cómo construir 6 súper proyectos: Una galería completa de imágenes, llena de funcionalidades. Una página de productos de una tienda en línea, con carrito de compra. Un formulario interactivo por pasos y validaciones. Una aplicación para descubrir series y películas populares del momento en base al género y año. Una aplicación para registrar gastos personales del mes. Un portafolio de trabajos con efectos y animaciones.',
        imageUrl: 'https://img-c.udemycdn.com/course/750x422/5100716_97ab.jpg',
        url: 'https://www.udemy.com/share/108Enk/',
        career: 'TIADSM - TIAENVD - IDGS - IEVND'),
    Product(
        name: 'Creación de Videojuegos',
        price: 0.0,
        description:
            'En este temario podras encontrar todo lo necesario para aprender a crear videojuegos, desde como saber usar C# para videojuegos hasta el uso de la herramienta de Unity. Patrocinado por el Ing. Jose Luis NF',
        imageUrl:
            'https://www.industriaanimacion.com/wp-content/uploads/2021/11/Cover-9.jpg',
        url:
            'https://drive.google.com/drive/folders/182ZHv2anrbrmKUGtYgs2-h4D1BZQRwtN?usp=sharing',
        career: 'IDGS - IENVD'),
    Product(
        name: 'NextJs',
        price: 0.0,
        description: 'Descripción del Producto 5',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQeZqY1tA2oY-THWle1dDuI1kOsfK4_9sQtA&s',
        url:
            'https://drive.google.com/drive/folders/1YKV37gVJEwfpLyhlEU2RGAuRvCohHyWu?usp=sharing',
        career: 'TIADSM - IDGS'),
    Product(
        name: 'Java y Kotlin',
        price: 0.0,
        description: 'Descripción del Producto 6',
        imageUrl:
            'https://media.licdn.com/dms/image/v2/D4D12AQF1xVOdSSJmfA/article-cover_image-shrink_720_1280/article-cover_image-shrink_720_1280/0/1727440823449?e=2147483647&v=beta&t=yaN9k1QiR6zRSPhYFZX0GtbngV6QRO-1XxzEhklUQiA',
        url:
            'https://drive.google.com/drive/folders/1XrmY0Z0w5ZMTEK7OGURhmvITQwMD6ah5?usp=sharing',
        career: 'TIADSM - IDGS'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cursos de Programación'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWideScreen = constraints.maxWidth > 600;
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 39, 144, 134),
                  Color.fromARGB(255, 42, 52, 69),
                  Colors.blue,
                ],
                stops: [1, 0.3, 1],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isWideScreen
                      ? 4
                      : 2, // Cambia según el ancho de pantalla.
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: isWideScreen ? 0.9 : 0.8,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailScreen(product: product),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                product.imageUrl,
                                fit: BoxFit
                                    .contain, // Ajusta la imagen para evitar distorsión.
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            product.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 5),
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 14, color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
