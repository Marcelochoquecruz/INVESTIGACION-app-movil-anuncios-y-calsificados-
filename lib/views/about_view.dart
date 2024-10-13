import 'package:flutter/material.dart';
import '../widgets/custom_navbar.dart'; // Asegúrate de importar tu CustomNavBar

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    // Definir colores dinámicos para el texto y el divisor
    Color primaryTextColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white // Color blanco para el tema oscuro
        : Colors.blue[800]!; // Color azul oscuro para el tema claro
    Color secondaryTextColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white70 // Color blanco claro para el tema oscuro
        : Colors.blue[600]!; // Color azul medio para el tema claro
    Color dividerColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey // Color gris para el divisor en tema oscuro
        : Colors.lightBlue[
            300]!; // Color celeste claro para el divisor en tema claro

    return Scaffold(
      appBar: const CustomNavBar(
          title: 'Acerca de Nosotros'), // Aplicar el CustomNavBar
      body: SingleChildScrollView(
        // Permitir el desplazamiento vertical
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Aplicación de Servicios a Domicilio',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Nuestra aplicación es una herramienta esencial que conecta '
                'a los usuarios con una variedad de servicios a domicilio. '
                'Con un diseño intuitivo y accesible, permite a los usuarios '
                'solicitar servicios de manera rápida y eficaz, ahorrando tiempo '
                'y esfuerzo. Ya sea que necesites reparaciones, limpieza o '
                'cualquier otro servicio, nuestra aplicación está diseñada para '
                'hacer tu vida más fácil. ¡Confía en nosotros para simplificar '
                'tu día a día!',
                style: TextStyle(
                  fontSize: 16,
                  color: secondaryTextColor,
                ),
              ),
              const SizedBox(height: 20),
              Divider(color: dividerColor), // Línea divisoria
              const SizedBox(height: 20),
              Text(
                'Sobre la Universidad Autónoma Tomás Frías',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'La Universidad Autónoma Tomás Frías es una institución '
                'educativa de prestigio en Bolivia, dedicada a la formación '
                'integral de profesionales competentes. Su compromiso con '
                'la excelencia académica y la investigación la posiciona '
                'como un referente en la educación superior.',
                style: TextStyle(
                  fontSize: 16,
                  color: secondaryTextColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Instituto de Investigación DICyT',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'El DICyT es el instituto de investigación de la Universidad '
                'Autónoma Tomás Frías, enfocado en promover y desarrollar '
                'proyectos innovadores que contribuyen al avance del conocimiento '
                'y a la solución de problemas en diversas áreas. Su labor es '
                'fundamental para el desarrollo académico y científico del país.',
                style: TextStyle(
                  fontSize: 16,
                  color: secondaryTextColor,
                ),
              ),
              const SizedBox(height: 20),
              Divider(color: dividerColor), // Línea divisoria
              const SizedBox(height: 20),
              Text(
                'Desarrollado e implementado por:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Universitario Marcelo Choque Cruz\n'
                'Estudiante de la Carrera de Ingeniería Informática\n'
                'Facultad de Ciencias Puras',
                style: TextStyle(
                  fontSize: 16,
                  color: secondaryTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
