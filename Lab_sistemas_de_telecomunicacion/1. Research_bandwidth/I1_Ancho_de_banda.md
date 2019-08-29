# Ancho de banda y capacidad de información

## Tabla de contenidos
  - [Resumen ejecutivo](#resumen-ejecutivo)
  - [Análisis teórico](#an%c3%a1lisis-te%c3%b3rico)
    - [Definición de ancho de banda.](#definici%c3%b3n-de-ancho-de-banda)
    - [Unidades de medición del ancho de banda.](#unidades-de-medici%c3%b3n-del-ancho-de-banda)
    - [Aplicación del concepto de ancho de banda.](#aplicaci%c3%b3n-del-concepto-de-ancho-de-banda)
    - [Capacidad de transmisión de información de un canal o línea y su relación con el ancho de banda de la misma, enfoque analógico y enfoque digital.](#capacidad-de-transmisi%c3%b3n-de-informaci%c3%b3n-de-un-canal-o-l%c3%adnea-y-su-relaci%c3%b3n-con-el-ancho-de-banda-de-la-misma-enfoque-anal%c3%b3gico-y-enfoque-digital)
    - [Unidades de medición de la cantidad de información transmitida (digital).](#unidades-de-medici%c3%b3n-de-la-cantidad-de-informaci%c3%b3n-transmitida-digital)
    - [Caso de estudio: “El sistema de comunicación Ethernet con par trenzado”, investigar ancho de banda y capacidad de transmisión de datos digitales a través de la línea Ethernet.](#caso-de-estudio-el-sistema-de-comunicaci%c3%b3n-ethernet-con-par-trenzado-investigar-ancho-de-banda-y-capacidad-de-transmisi%c3%b3n-de-datos-digitales-a-trav%c3%a9s-de-la-l%c3%adnea-ethernet)
    - [Efecto del ruido en el ancho de banda.](#efecto-del-ruido-en-el-ancho-de-banda)
    - [Concepto de relación de Señal a Ruido de un canal o línea de transmisión.](#concepto-de-relaci%c3%b3n-de-se%c3%b1al-a-ruido-de-un-canal-o-l%c3%adnea-de-transmisi%c3%b3n)
  - [Conclusiones](#conclusiones)
  - [Bibliografía](#bibliograf%c3%ada)

## Resumen ejecutivo
<!-- TODO: wheshing all the points -->

## Análisis teórico

### Definición de ancho de banda.
El concepto de ancho de banda ha sido definido de distintas maneras desde la concepción de dicha noción. De acuerdo con Wayne Tomasi (1994), el *ancho de banda* es una de las más signiticativas limitantes en el rendimiento de un sistema, junto con el *ruido*, y es definido como _«la banda de paso mínima (rango de frecuencias) requerida para propagar la información de la fuente a través del sistema»_. Por su parte, Ferrel Stremler (1982) define al ancho de banda W de un sistema como _«el intervalo de frecuencias **positivas** en que la magnitud `|H(ω)|` se mantiene dentro de determinado factor numérico»_. Douglas Comer (2015) diferencía al definir al ancho de banda entre 'ancho de banda analógica' y 'ancho de banda de red', define al primero como _«la diferencia entre la más alta y la más baja frecuencia de las partes constituyentes»_, mientras que asegura que la industria de redes computacionales suele referirse a la *velocidad de datos* cuando habla de *ancho de banda de red*. Finalmente, Rosengrant (2007) define al ancho de banda como «la capacidad de transmisión de información de un medio».

&ensp;&ensp;&ensp;&ensp;Todas estas definiciones difieren ligeramente dependiendo del enfoque con que los autores escriben o que atañe a sus obras, no obstante, es posible advertir un patrón formado en todas ellas, dado que todos afirman ─aunque en diferentes términos─ la existencia de un **rango o intervalo de frecuencias** mediante el cual se **transmite información** a través de un medio o sistema.

### Unidades de medición del ancho de banda.
La medición del ancho de banda puede variar según el contexto en el que se aplique.
Para señales analógicas, y estudio de señales, el ancho de banda es la diferencia entre la mayor y menor frecuencia de una onda. Esto es medido normalmente en hertz (Hz).
Por otro lado, el ancho de banda de red es medido normalmente en bits por segundo, pero también bytes por segundo es usado frecuentemente. Cabe recalcar que megabit y megabyte no son equivalentes, ya que 8 bits = 1 Byte.

Otra medida popular es el método 95% percentil. Éste permite medir el promedio de ancho de banda en un 95% de un periodo de tiempo especificado. Para éste método, el ancho de banda usado el 95% del tiempo es el ancho de banda real usado. El otro 5% son ráfagas de tráfico que son descartadas. Para obtenerlo, los datos son ordenados de menor a mayor, y el 5% más alto son ignorados. Posteriormente se realiza un promedio de los números restantes, y el resultado será el ancho de banda real.

Una medida distinta es el método de transferencia total, en el cual se mide la cantidad de datos que un dispositivo puede transferir en cierto periodo de tiempo. Usualmente se usan periodos largos, y no es muy común usarlo excepto para escenarios específicos.
Existen también otras estadísticas que nos pueden dar más información sobre el ancho de banda de una conexión:
- Máximo Teórico: La tasa de transmisión que la transferencia podría tener en escenarios ideales y bajo las circunstancias adecuadas. Es difícil que una red o una transmisión llegue al máximo teórico debido a limitaciones físicas, por lo que normalmente este dato se usa para fines de comparación cuando la instalación está siendo probada.
- Ancho de banda efectivo: Es el ancho de banda más rápido y estable que se puede alcanzar.
- Rendimiento: Mide la relación entre los datos que se están transmitiendo y el tiempo que toma mandarlos.
- Goodput: Mide la cantidad de datos relevantes que se están transmitiendo. Sirve para determinar la relación entre esos datos y las retransmisiones o pérdidas de paquetes.

### Aplicación del concepto de ancho de banda.
Según afirma Stremler (1982) es imposible construir un sistema de ancho de banda infinito debido a limitaciones físicas y, dado que uno de los objetivos principales cuando se transmite información es conseguir que ésta sea recibida sin distorsión, es preciso que «el ancho de banda de un sistema sea suficientemente amplio para pasar todas las frecuencias de información significativas» como bien asevera Tomasi (1994). Stanley and Jeffords (2006) proponen un ejemplo para ilustrar este hecho:  

> (...) asuma que un dado canal es una desigual línea de teléfoono que tiene una frecuencia de respuesta desde unos pocos cientos de hertz a algunos kilohertz. El canal puede ser adecuado para datos de voz simples, pero difícilmente serían suficientes para sonido de alta fidelidad o video de alta calidad.  
>    
> ─Stanley and Jeffords, 2006

Por lo tanto, es posible afirmar que la importancia del ancho de banda recae en su necesidad de ser considerada y determinada correcta y asertivamente, dado que el sistema depende de esa decisión para obtener resultados fidedignos en emisiones y recepciones de información.

### Capacidad de transmisión de información de un canal o línea y su relación con el ancho de banda de la misma, enfoque analógico y enfoque digital.
<!-- * waiting for Erick -->


### Unidades de medición de la cantidad de información transmitida (digital).
Para responder adecuadamente esta consulta es necesario recurrir a varios conceptos. El más importante de ellos es llamado *Capacidad de canal* que es «la velocidad límite de transmisión de información a través de un canal» según Stremler (1982), la definición de este concepto radica en la inversión del teorema de C. E. Shannon que establecería que «no es posible transmitir mensajes sin errores si R > C  ─donde R es la razón de entropía y C es la capacidad del canal─» (Stremler, 1982)

Para responder adecuadamente esta consulta es necesario recurrir a varios conceptos. El primero de ellos es llamado *Capacidad de la información* que es «el número de símbolos independientes que pueden pasarse, a través del sistema, en una unidad de tiempo determinada» (Tomasi, 1994). Debido a que el símbolo fundamental es el digito binario

### Caso de estudio: “El sistema de comunicación Ethernet con par trenzado”, investigar ancho de banda  y capacidad de transmisión de datos digitales a través de la línea Ethernet.
<!-- * waiting for Erick -->


### Efecto del ruido en el ancho de banda.
Wayne Tomasi (1994) define al ruido eléctrico como _«cualquier energía eléctrica no deseada presente en la pasabanda útil de un circuito de comunicaciones»_. Suele dividirse en dos grandes grupos: _correlacionado_ y _no correlacionado_, pertenece al primero si existe una relación entre la señal y el ruido y al segundo en el caso contrario. A depender de la fuente, existen algunos otras clasificaciones, entre las que destacan:
- Ruido externo
  - Ruido atmosférico
  - Ruido galáctico
  - Ruido solar
  - Ruido producido por el hombre
- Ruido interno
  - Ruido térmico
  - Ruido de disparo
  - Ruido de tiempo de tránsito

Si bien es cierto que la distorsión que el ruido puede provocar en una señal analógica depende ampliamente de su potencia en relación con la potencia de la misma señal, esta distorsión **también depende de la distribución espectral del ruido en relación con el ancho de banda** utilizado por el sistema que transmite esta señal. En general, la señal recibida estará compuesta de la señal originalmente enviada junto con todas las distorsiones adquiridas mientras ésta transitaba por su medio hasta su destino, de las cuales la mayoría son ocasionadas por ruido que si, como se ha mencionado antes, su distribución espectral coincide con el rango de frecuencias que el ancho de banda admite, entonces las señales que transiten por esa vía se verán más afectadas por estas **deformaciones**.

### Concepto de relación de Señal a Ruido de un canal o línea de transmisión.
<!-- * waiting for Erick -->

| DOC ID | T1   | T2   | T3   | T4   | T5   | T6   | T7   | T8   | T9   | T10  | T11  | T12  | T13  | T14  | T15  | T16  | T17  | T18  |
| ------ | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| D1     | .477 | .176 | .477 | .477 | .477 | .477 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    |
| D2     | 0    | 0    | 0    | 0    | 0    | 0    | .477 | .477 | .477 | .477 | .477 | .477 | .176 | 0    | 0    | 0    | 0    | 0    |
| D3     | 0    | .176 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | .176 | .477 | .477 | .477 | .477 | .477 |
| Query  | .477 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | .176 | 0    | .477 | 0    | 0    | 0    |

| DOC ID | T1   | T2   | T3   | T4   | T5   | T6   | T7   | T8   | T9   | T10  | T11  | T12  | T13  | T14  | T15  | T16  | T17  | T18  |
| ------ | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| D1     | .477 | .176 | .477 | .477 | .477 | .477 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    |
| D2     | 0    | 0    | 0    | 0    | 0    | 0    | .477 | .477 | .477 | .477 | .477 | .477 | .176 | 0    | 0    | 0    | 0    | kv0    |
| D3     | 0    | .176 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | .176 | .477 | .477 | .477 | .477 | .477 |
| Query  | .477 | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | .176 | 0    | .477 | 0    | 0    | 0    |

## Conclusiones
- as 
- asdas
- asd
  - sadkass
    - asjdk



- [ ] asdjaks
- [ ] 

# Heading


## Bibliografía
- Tomasi, W. (1994). *Fundamentals of electronic communications systems.* Englewood Cliffs, N.J.: Prentice Hall, pp.4, 5.
- Stremler, F. (1982). *Sistemas de comunicación*. Massachusetts: Fondo educativo interamericano, pp.115, 116.
- Comer, D. (2015). *Computer Networks and Internets.* 6th ed. Prentice Hall, p.99.
- Rosengrant, M. (2007). *Introduction to telecommunications.* Upper Saddle River, New Jersey: Pearson Prentice Hall.
- Stanley, W. and Jeffords, J. (2006). *Electronic communications: Principles and systems* Clifton Park: Thomson Delmar Learning, p.4.
- Proakis, J. and Saheli, M. (2014). *Fundamentals of communication systems*. 2nd ed. Boston: Pearson, p.664.
- Networks, P. and Psychz Networks (2019). *What is The 95th Percentile Bandwidth Metering?* .... [online] Psychz Networks. Available at: https://www.psychz.net/client/kb/en/what-is-the-95th-percentile-bandwidth-metering.html [Accessed 28 Aug. 2019].
- Veber. (2019). *What is Bandwidth and How is it Measured?*. [online] Available at: https://www.veber.co.uk/what-is-bandwidth-and-how-is-it-measured/ [Accessed 28 Aug. 2019].
- Paessler. (2019). *What is Bandwidth? - Definition and Details.* [online] Available at: https://www.paessler.com/it-explained/bandwidth [Accessed 28 Aug. 2019].
- Toppr-guides. (2019). *Bandwidth of Signals: Definition, Concepts, Applications, Videos, Examples.* [online] Available at: https://www.toppr.com/guides/physics/communication-systems/bandwidth-of-signals/ [Accessed 28 Aug. 2019].


<!-- To include later: "The basic limi tation that noise causes in a communication channel is not the reliability of communication, but on the speed of communication" Shannon (1948) by John Proakis -->
