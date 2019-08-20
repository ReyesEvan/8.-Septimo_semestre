# Reporte de precios por el uso de Servicios de Gestión de Base de Datos

Carlos Andrés Reyes Evangelista  
Ingeniería en Sistemas Computacionales  
Universidad de las Américas Puebla

## Tabla de contenidos

  - [Introducción](#introducci%c3%b3n)
  - [Alternativas online](#alternativas-online)
    - [1. Amazon Relational Database Service (RDS)](#1-amazon-relational-database-service-rds)
    - [2. Azure SQL Databases](#2-azure-sql-databases)
    - [3. Google Cloud SQL](#3-google-cloud-sql)
  - [Otras alternativas](#otras-alternativas)



## Introducción

Para la realización de este proyecto que consiste en el desarrollo de un programa que mantenga un registro concreto y robusto del mantenimiento otorgado a la maquinaria existente en el gimnasio y que permita la manipulación general de los datos ya existentes, una de las sugerencias propuestas es diseñar y crear una base de datos que albergue las especificaciones particulares de cada una de las herramientas que el gimnasio ofrece junto con los registros constantes que se realizarán paulatinamente. Entre otras, el uso de bases de datos ofrece ciertas ventajas sobre la utilización de archivos:

1. **Acceso concurrente:** Las bases de datos permiten a los usuarios compartir información centralizada, esto permite que se trabaje sobre el mismo conjunto de datos al mismo tiempo desde diferentes localizaciones.
2. **Control de redundancia:** Al centralizar la información en una base de datos se previene la existencia de duplicados de la información que podría ocasionar problemas.
3. Rápido acceso a la información: La información es obtenida rápida y fácilmente, lo que agiliza el trabajo y permite ofrecer un mejor servicio.
4. **Incrementa la productividad:** La información se encontrará estructurada de una manera específica que el programa utilizará, lo cual significa que los usuarios no tendrán que preocuparse por cómo es que está estructurada la información y podrán concentrarse más en tener el trabajo finalizado.
5. **Seguridad en la información:** Una base de datos puede tener ciertas partes definidas en usuarios, por lo cual se puede limitar el acceso a ciertas partes dependiendo del usuario que esté accediendo a ella. De esta manera, la seguridad y la confidencialidad siempre estarán garantizadas.

&ensp;&ensp;Dado que se requiere que esta base de datos ofrezca servicios constantes a una más de una persona y ante la ausencia de un servidor propio, es posible utilizar servicios *online* que provean a la aplicación de un servicio de gestión de bases de datos constante. Un Sistema de Gestión de Base de Datos es un software que sirve de interfaz entre una base de datos y los programas que la utilizan. A continuación, son presentadas algunas alternativas confiables, accesibles y seguras para utilizarse junto con sus ventajas y precios.

## Alternativas online

### 1. Amazon Relational Database Service (RDS)

De acuerdo con la descripción misma de Amazon, [Amazon RDS][rds] es un servicio que facilita la configuración, operación y escalamiento de bases de datos en la nube; de estos servicios, los dos primeros son requeridos para la construcción de este proyecto. Amazon provee un ambiente perfectamente optimizado donde ellos mismos se encargan de tareas que serían necesarias de hacer manualmente con un servidor propio. El servicio de Amazon es fácil de administrar, altamente escalable, durable, rápido, seguro y su fijación de precios sigue un modelo de *pay-as-you-go*, lo que significa que no hay una cuota mínima, sino que se paga dependiendo de lo que se utilice.

&ensp;&ensp;Amazon ofrece un nivel gratuito (*free-tier*) para nuevos usuarios de AWS (*Amazon Web Services*), este nivel incluye 750 horas gratuitas de Amazon RDS al mes por un año, 20 gigabytes de almacenamiento y 20 gigabytes para copias de seguridad. Esto significa que el primer año de operación estaría cubierto sin costo, en cuanto el servicio gratuito finalice, se entrará en el modelo *pay-as-you-go*, lo que garantiza que no habrá cobros elevados en ningún momento, sino que se mantendrá un pago constante ya que la base de datos, presumiblemente, no requerirá cambios abruptos.

&ensp;&ensp;El precio una vez que el nivel de prueba finalice será calculado basado únicamente en el consumo de recursos utilizados, sin que exista ninguna cuota mínima o compromiso a largo plazo.

![Cuotas de Amazon RDS][rds$]
Cuotas de Amazon RDS bajo demanda

La base de datos una vez terminada se estima que podrá ser almacenada bajo una instancia Micro o Small, cuando mucho. Lo cual requeriría un pago aproximado de $ 250 MXN al mes -es requerida un análisis más profundo y es posible disminuir aún más el precio reservando instancias por plazos largos, pero se ahondará en más detalles si este servicio es elegido-.  
[Haga clic aquí para obtener más información respecto al precio de Amazon RDS.][rdsinfo]

### 2. Azure SQL Databases

[Azure][azure] es la alternativa de Microsoft que, al igual que Amazon, provee un servicio para administrar bases de datos en línea y, de acuerdo con la página oficial del servicio: «ofrece una rentabilidad de la inversión de hasta el 212 %». El servicio de Azure presume ser fácil de migrar y escalar y, además, ofrece un aprendizaje automático integrado que permite optimizar el rendimiento y la seguridad. Al igual que Amazon, el servicio de Azure no requiere costos iniciales, ni compromisos a largo plazo. La fijación de precios de Azure también sigue un modelo que permite pagar únicamente por los recursos que se utilizan

&ensp;&ensp;Azure también ofrece un periodo de prueba gratuito por un año que incluye, entre otra variedad de recursos, 250 gigabytes para su uso libre en Bases de Datos SQL -muchísimo más de lo requerido para esta aplicación-. Además de esto, Azure regala a la cuenta un crédito de $ 3,900 MXN libres de ser gastados en su conjunto de aplicaciones durante el primer mes. En cuanto el primer mes finalice, se deberá cambiar a los precios de pago por uso, pero mientras no se excedan las cantidades gratuitas no se tendrá que pagar nada -lo cual, en teoría, no debería suceder para esta aplicación- durante los siguientes doce meses; cuando estos hayan finalizado se entrará también al modelo *pay-as-you-go* descrito anteriormente y mostrado en particular para Azure a continuación.

![Precios de Azure SQL][azure$]

&ensp;&ensp;Los precios de este último modelo varían mucho dependiendo de los recursos a utilizar; al realizar una revisión rápida de las alternativas, se encuentra que la configuración más adecuada dada las especificaciones del proyecto es una opción de Base de Datos Única, con un modelo de compra DTU a un nivel de servicio básico, que es uno de los precios más accesibles y, consecuentemente, con recursos más limitados. Siguiendo estas opciones, el pago mensual después de un año gratuito oscilaría entre los $ 100 MXN, aunque se requiere un análisis más profundo tanto de la aplicación propuesta como de los servicios, esta estimación funge como una vista previa de lo que podría costar.  
[Haga clic aquí para obtener más información respecto al precio de Azure SQL Database][azureinfo]

### 3. Google Cloud SQL

[Google Cloud SQL][cloud] es la alternativa de Google para administrar bases de datos en línea que, a grandes rasgos, ofrece con sus propias particularidades todas las ventajas que Amazon RDS y Azure en cuanto a facilidad de despliegue, escalabilidad y seguridad. Cloud SQL tampoco requiere pagos por adelantado ni compromisos a largo plazo y su fijación de precios también funciona pagando únicamente lo que se utilice, aunque puede optarse por un pago fijo por recursos fijos.

&ensp;&ensp;El periodo de prueba que Google ofrece también dura hasta doce meses y otorga un crédito de $ 300 USD. El periodo de prueba finaliza cuando los doce meses se cumplen o cuando el crédito otorgado es utilizado en su totalidad. Cuando éste finalice, no se hará ningún cargo automático, sino que se continuará en el plan estándar de Google en cuanto éste sea aceptado manualmente, del cual se muestran los precios a continuación:

![Precios de Cloud SQL][cloud$]

&ensp;&ensp;Después de una estimación rápida utilizando la [calculadora de precios de Google][calc] y apelando a los mínimos valores, el precio mensual oscilaría entre $ 140 y $ 200 MXN dependiendo de la calidad de almacenamiento y la cantidad de tiempo que la base de datos esté disponible. Si se elige esta opción, se realizaría un estudio más profundo para determinar si la cantidad puede ser disminuida reservando recursos e iterando parámetros.

## Otras alternativas

Si se prefiere no utilizar servicios online para la realización de esta base de datos, entonces será necesario utilizar un servidor propio, lo cual puede costar una cantidad considerable de dinero y tomará más tiempo el realizar la configuración, la cual requerirá de personal más experimentado para no estar expuesto a vulnerabilidades.

Una última alternativa es negociar y buscar un acuerdo con el departamento de Tecnologías de la Información de la universidad para que se entregue la aplicación y la base de datos y sean ellos quienes se encarguen de implementar la base de datos en sus propios servidores. Es una opción más económica, pero depende completamente de los términos que Tecnologías de la Información expongan.



[rds]: https://aws.amazon.com/rds/postgresql/
[rds$]: resources/amazonRDSondemand.png "Precios de Amazon RDS bajo demanda por instancia"
[rdsinfo]: https://aws.amazon.com/rds/postgresql/pricing/

[azure]: https://azure.microsoft.com/es-mx/services/sql-database/
[azureinfo]: https://azure.microsoft.com/es-mx/pricing/details/sql-database/single/
[azure$]: resources/azureSQLondemand.png "Precios de Azure SQL bajo demanda por base de datos única"

[cloud]: https://cloud.google.com/sql/
[calc]: https://cloud.google.com/products/calculator/
[cloud$]: resources/cloudSQLondemand.png "Precios de Google Cloud SQL bajo demanda"