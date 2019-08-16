# Reporte de costos por el uso de Servicios de Gestión de Base de Datos

- [Reporte de costos por el uso de Servicios de Gestión de Base de Datos](#reporte-de-costos-por-el-uso-de-servicios-de-gesti%c3%b3n-de-base-de-datos)
  - [Introducción <a name="intro"></a>](#introducci%c3%b3n-a-name%22intro%22a)
  - [1. Amazon Relational Database Service (RDS)](#1-amazon-relational-database-service-rds)



## Introducción <a name="intro"></a>

Para la realización de este proyecto que consiste en el desarrollo de un programa que mantenga un registro concreto y robusto del mantenimiento otorgado a la maquinaria existente en el gimnasio y que permita la manipulación general de los datos ya existentes, una de las sugerencias propuestas es diseñar y crear una base de datos que albergue las especificaciones particulares de cada una de las herramientas que el gimnasio ofrece junto con los registros constantes que se realizarán paulatinamente. Entre otras, el uso de bases de datos ofrece ciertas ventajas sobre la utilización de archivos:

1. Acceso concurrente: Las bases de datos permiten a los usuarios compartir información centralizada, esto permite que se trabaje sobre el mismo conjunto de datos al mismo tiempo desde diferentes localizaciones.
2. Control de redundancia: Al centralizar la información en una base de datos se previene la existencia de duplicados de la información que podría ocasionar problemas.
3. Rápido acceso a la información: La información es obtenida rapida y fácilmente, lo que agiliza el trabajo y permite ofrecer un mejor servicio.
4. Incrementa la productividad: La información se encontrará estructurada de una manera específica que el programa utilizará, lo cual significa que los usuarios no tendrán que preocuparse por cómo es que está estructurada la información y podrán concentrarse más en tener el trabajo finalizado.
5. Seguridad en la información: Una base de datos puede tener ciertas partes definidas en usuarios, por lo cual se puede limitar el acceso a ciertas partes dependiendo del usuario que esté accediendo a ella. De esta manera, la seguridad y la confidencialidad siempre estarán garantizadas.

&ensp;&ensp;Dado que se requiere que esta base de datos ofrezca servicios constantes a una más de una persona y ante la ausencia de un servidor propio, es posible utilizar servicios *online* que provean a la aplicación de un servicio de gestión de bases de datos constante. Un Sistema de Gestión de Base de Datos es un software que sirve de interfaz entre una base de datos y los programas que la utilizan. A continuación, son presentadas algunas alternativas para utilizarse junto con sus restricciones y precios.


## 1. Amazon Relational Database Service (RDS)

De acuerdo con la descripción misma de Amazon, Amazon RDS es un servicio que facilita la configuración, operación y escalamiento de bases de datos en la nube; de estos servicios, los dos primeros son requeridos para la construcción de este proyecto. Amazon provee un ambiente perfectamente optimizado donde ellos mismos se encargan de tareas que serían necesarias de hacer manualmente con un servidor propio. El servicio de Amazon es fácil de administrar, altamente escalable, durable, rápido, seguro y su preciación sigue un modelo de *pay-as-you-go*, lo que significa que no hay una cuota mínima, sino que se paga dependiendo de lo que se utilice.

&ensp;&ensp;Amazon ofrece un nivel gratuito (*free-tier*) para nuevos usuarios de AWS (*Amazon Web Services*), este nivel incluye 750 horas gratuitas de Amazon RDS al mes por un año, 20 gigabytes de almacenamiento y 20 gigabytes para copias de seguridad. Esto significa que el primer año de operación estaría cubierto sin costo, en cuanto el servicio gratuito finalice, se entrará en el modelo *pay-as-you-go*, lo que garantiza que no habrá cobros elevados en ningún momento, sino que se mantendrá un pago constante ya que la base de datos, presumiblemente, no requerirá cambios abruptos.

&ensp;&ensp;El 