# Ancho de banda y capacidad de información

## Tabla de contenidos
  - [Resumen](#resumen)
  - [Análisis teórico](#analisis)
    - [Definición de ancho de banda.](#definicion)
    - [Unidades de medición del ancho de banda.](#unidades)
    - [Aplicación del concepto de ancho de banda.](#aplicacion)
    - [Capacidad de transmisión de información de un canal o línea y su relación con el ancho de banda de la misma, enfoque analógico y enfoque digital.](#capacidad)
    - [Unidades de medición de la cantidad de información transmitida (digital).](#transmitida)
    - [Caso de estudio: “El sistema de comunicación Ethernet con par trenzado”, investigar ancho de banda y capacidad de transmisión de datos digitales a través de la línea Ethernet.](#ethernet)
    - [Efecto del ruido en el ancho de banda.](#ruido)
    - [Concepto de relación de Señal a Ruido de un canal o línea de transmisión.](#concepto)
  - [Conclusiones](#conclusiones)
  - [Bibliografía](#bibliografia)

## Resumen
El presente reporte fue realizado para esclarecer y afianzar el dominio sobre el concepto de **ancho de banda**, su definición, su medición, su aplicación y su relación con otros conceptos entre los que destacan:

- Capacidad de canal
- Capacidad de información
- Ruido
- Línea o canal de transmisión

El carácter del presente reporte es meramente ilustrativo y neutral. La información obtenida en libros impresos y sitios web es referenciada y se alenta al lector a visitar los sitios originales de donde la información científica fue obtenida para respaldar las aseveraciones realizadas alrededor de las nociones expuestas en este trabajo.

## Análisis teórico<a name="analisis"></a>

### Definición de ancho de banda.<a name="definicion"></a>
El concepto de ancho de banda ha sido definido de distintas maneras desde la concepción de dicha noción. De acuerdo con Wayne Tomasi (1994), el *ancho de banda* es una de las más signiticativas limitantes en el rendimiento de un sistema, junto con el *ruido*, y es definido como _«la banda de paso mínima (rango de frecuencias) requerida para propagar la información de la fuente a través del sistema»_. Por su parte, Ferrel Stremler (1982) define al ancho de banda W de un sistema como _«el intervalo de frecuencias **positivas** en que la magnitud `|H(ω)|` se mantiene dentro de determinado factor numérico»_. Douglas Comer (2015) diferencía al definir al ancho de banda entre 'ancho de banda analógica' y 'ancho de banda de red', define al primero como _«la diferencia entre la más alta y la más baja frecuencia de las partes constituyentes»_, mientras que asegura que la industria de redes computacionales suele referirse a la *velocidad de datos* cuando habla de *ancho de banda de red*. Finalmente, Rosengrant (2007) define al ancho de banda como «la capacidad de transmisión de información de un medio».

&ensp;&ensp;&ensp;&ensp;Todas estas definiciones difieren ligeramente dependiendo del enfoque con que los autores escriben o que atañe a sus obras, no obstante, es posible advertir un patrón formado en todas ellas, dado que todos afirman ─aunque en diferentes términos─ la existencia de un **rango o intervalo de frecuencias** mediante el cual se **transmite información** a través de un medio o sistema.

### Unidades de medición del ancho de banda.<a name="unidades"></a>
La medición del ancho de banda puede variar según el contexto en el que se aplique.
Para señales analógicas, y estudio de señales, el ancho de banda es la diferencia entre la mayor y menor frecuencia de una onda. Esto es medido normalmente en hertz (Hz).
Por otro lado, el ancho de banda de red es medido normalmente en bits por segundo, pero también bytes por segundo es usado frecuentemente. Cabe recalcar que megabit y megabyte no son equivalentes, dado que un byte corresponde a ocho bits.

&ensp;&ensp;&ensp;&ensp;Otra medida popular es el método _95% percentil_. Éste permite medir el promedio de ancho de banda en un 95% de un periodo de tiempo especificado. Para éste método, el ancho de banda usado el 95% del tiempo es el ancho de banda real usado. El otro 5% son ráfagas de tráfico que son descartadas. Para obtenerlo, los datos son ordenados de menor a mayor, y el 5% más alto son ignorados. Posteriormente se realiza un promedio de los números restantes, y el resultado será el ancho de banda real.

&ensp;&ensp;&ensp;&ensp;Una medida distinta es el método de transferencia total, en el cual se mide la cantidad de datos que un dispositivo puede transferir en cierto periodo de tiempo. Usualmente se usan periodos largos, y no es muy común usarlo excepto para escenarios específicos.
Existen también otras estadísticas que nos pueden dar más información sobre el ancho de banda de una conexión:

- **Máximo teórico:** La tasa de transmisión que la transferencia podría tener en escenarios ideales y bajo las circunstancias adecuadas. Es difícil que una red o una transmisión llegue al máximo teórico debido a limitaciones físicas, por lo que normalmente este dato se usa para fines de comparación cuando la instalación está siendo probada.
- **Ancho de banda efectivo:** Es el ancho de banda más rápido y estable que se puede alcanzar.
- **Rendimiento:** Mide la relación entre los datos que se están transmitiendo y el tiempo que toma mandarlos.
- **Goodput:** Mide la cantidad de datos relevantes que se están transmitiendo. Sirve para determinar la relación entre esos datos y las retransmisiones o pérdidas de paquetes.

### Aplicación del concepto de ancho de banda.<a name="aplicacion"></a>
Según afirma Stremler (1982) es imposible construir un sistema de ancho de banda infinito debido a limitaciones físicas y, dado que uno de los objetivos principales cuando se transmite información es conseguir que ésta sea recibida sin distorsión, es preciso que «el ancho de banda de un sistema sea suficientemente amplio para pasar todas las frecuencias de información significativas» como bien asevera Tomasi (1994). Stanley and Jeffords (2006) proponen un ejemplo para ilustrar este hecho:  

> (...) asuma que un dado canal es una desigual línea de teléfono que tiene una frecuencia de respuesta desde unos pocos cientos de hertz a algunos kilohertz. El canal puede ser adecuado para datos de voz simples, pero difícilmente serían suficientes para sonido de alta fidelidad o video de alta calidad.  
>    
> ─Stanley and Jeffords, 2006

&ensp;&ensp;&ensp;&ensp;Por lo tanto, es posible afirmar que la importancia del ancho de banda recae en su necesidad de ser considerada y determinada correcta y asertivamente, dado que el sistema depende de esa decisión para obtener resultados fidedignos en emisiones y recepciones de información.

### Capacidad de transmisión de información de un canal o línea y su relación con el ancho de banda de la misma, enfoque analógico y enfoque digital.<a name="capacidad"></a>
Para poder explicar la relación entre el ancho de banda y la capacidad de transmisión de información de un canal, es necesario especificar los siguientes conceptos:
- **Ancho de banda de la señal:** El rango de frecuencias de la señal que se está transmitiendo. Está controlado por el transmisor.
- **Ancho de banda de canal:** Rango de anchos de banda permitidos en el canal de comunicación
- **Capacidad de canal:** Máxima tasa de velocidad a la que los datos pueden ser transmitidos en un canal.
<!-- - **Capacidad de canal:** «Velocidad límite de transmisión de información a través de un canal» (Stremler, 1982) -->

&ensp;&ensp;&ensp;&ensp;Al hablar de ondas analógicas, las técnicas más usadas de codificación, como *Binary Amplitude Shift Key* o *Binary Frequency Shift Key*, se basan en la alteración de una propiedad de una onda que es transmitida. Al ser aumentada la frecuencia de la onda, el tiempo de cada periodo es menor, por lo que se puede alcanzar así una mayor tasa de transmisión de datos.

&ensp;&ensp;&ensp;&ensp;De forma similar, las técnicas para codificación digital como *NRZ* o *Manchester Code* se basan en la representación de datos digitales por medio de pulsos que pueden ser modelados como funciones periódicas. Al tratarse igualmente de ondas, un aumento en la frecuencia representaría una disminución en el tiempo de cada periodo, o en caso de la transmisión digital, tiempo entre cada bit transmitido.

&ensp;&ensp;&ensp;&ensp;No obstante, debido a las limitaciones tecnológicas, es difícil aumentar de forma indefinida el ancho de banda, por lo que se trata de delimitar los rangos que los dispositivos ocupan para transmitir datos. Cada rango de frecuencias es llamado *canal*, y sirven para que varias señales puedan ser emitidas simultáneamente sin ser interrumpidas o atenuadas por ruido.

Las siguientes ecuaciones propuestas por Nyquist y Shannon son las que describen la capacidad de canal en diferentes escenarios:

- Escenario de transmisión de datos en canales sin ruido:
  <!-- - C = 2 * B * Lg M, donde C es la capacidad de canal, B es el máximo ancho de banda del canal, y M es el número de canales. -->
  - <img src="https://latex.codecogs.com/svg.latex?C=2B\lg&space;M" title="C=2B\lg M" />, donde C es la capacidad de canal, B es el máximo ancho de banda del canal, y M es el número de canales.
- Escenario de transmisión de datos en canales con ruido:
  <!-- - C = B lg (1 + SNR), donde B es el ancho de banda del canal y SNR es la relación *señal/ruido*. -->
  - <img src="https://latex.codecogs.com/svg.latex?C=B\lg&space;(1&space;&plus;&space;SNR)" title="C=B\lg (1 + SNR)" />, donde B es el ancho de banda del canal y SNR es la relación *señal/ruido*.

### Unidades de medición de la cantidad de información transmitida (digital).<a name="transmitida"></a>
Para responder adecuadamente esta consulta es necesario recurrir a varios conceptos. El primero de ellos es llamado *Capacidad de la información* que es «el número de símbolos independientes que pueden pasarse, a través del sistema, en una unidad de tiempo determinada» (Tomasi, 1994). Debido a que el símbolo fundamental es el dígito binario o también conocido como bit, la capacidad de la información suele ser expresada en _bits por segundo ─bps─_.
> En 1928, R. Hartley de los Laboratorios de Teléfonos Bell desarrolló una relación útil entre el ancho de banda, la línea de transmisión y la capacidad de información, expresada en la conocida Ley de Hartley:  
>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;<img src="https://latex.codecogs.com/svg.latex?I&space;\alpha&space;B&space;\times&space;T" title="I \alpha B \times T" />  
> Donde  
> <img src="https://latex.codecogs.com/svg.latex?\inline&space;I&space;=&space;capacidad\&space;de\&space;informacion\&space;(bps)" title="I = capacidad\ de\ informacion\ (bps)" />  
> <img src="https://latex.codecogs.com/svg.latex?\inline&space;B&space;=&space;ancho\&space;de\&space;banda&space;(Hz)" title="B = ancho\ de\ banda (Hz)" />  
> <img src="https://latex.codecogs.com/svg.latex?\inline&space;T&space;=&space;linea\&space;de\&space;transmision&space;(s)" title="T = linea\ de\ transmision (s)" />  
> ─Wayne Tomasi, 1994
<!-- > `I α B × T` -->


&ensp;&ensp;&ensp;&ensp;Es a partir de esta ecuación que el autor determina que «la capacidad de información es una función lineal del ancho de banda y de la línea de transmisión y es directamente proporcional a ambos». Esto significa que cualquier cambio en alguno de los parámetros ─sea ancho de banda o línea de transmisión─ repercutirá directamente en la capacidad de la información.

&ensp;&ensp;&ensp;&ensp;A partir del hecho de que la capacidad de información representa la máxima cantidad de símbolos que pueden ser transmitidos en determinado tiempo ─y se mide en _bits por segundo_ ─, la cantidad de información transmitida, en consecuencia, debería de ser cuantificada en bits ─o cualquiera de sus múltiplos─ y obtenida en función de la capacidad de información del sistema en cuestión y el tiempo que haya durado la transmisión.

### Caso de estudio: “El sistema de comunicación Ethernet con par trenzado”, investigar ancho de banda y capacidad de transmisión de datos digitales a través de la línea Ethernet.<a name="ethernet"></a>
<!-- * waiting for Erick -->


### Efecto del ruido en el ancho de banda<a name="ruido"></a>
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

&ensp;&ensp;&ensp;&ensp;Si bien es cierto que la distorsión que el ruido puede provocar en una señal analógica depende ampliamente de su potencia en relación con la potencia de la misma señal, esta distorsión **también depende de la distribución espectral del ruido en relación con el ancho de banda** utilizado por el sistema que transmite esta señal. En general, la señal recibida estará compuesta de la señal originalmente enviada junto con todas las distorsiones adquiridas mientras ésta transitaba por su medio hasta su destino, de las cuales la mayoría son ocasionadas por ruido que si, como se ha mencionado antes, su distribución espectral coincide con el rango de frecuencias que el ancho de banda admite, entonces las señales que transiten por esa vía se verán más afectadas por estas deformaciones.

### Concepto de relación de Señal a Ruido de un canal o línea de transmisión.<a name="concepto"></a>
<!-- * waiting for Erick -->


## Conclusiones
El concepto de ancho de banda representa una de las nociones más importantes tanto para la fundación de los cimientos sobre los cuales se erigieron los primeros sistemas de telecomunicaciones como para la evolución de los mismos hasta las épocas contemporáneas donde aún se mantiene como un concepto de alta relevancia y que debe de ser considerado con seriedad para conseguir sistemas de comunicación robustos que permitan transmisiones sin distorsión o con la menor de ellas posible. 

&ensp;&ensp;&ensp;&ensp;La principal importancia del ancho de banda radica en que «la capacidad para llevar información de un sistema de comunicación es proporcional a su ancho de banda», como lo asevera Tomasi (1994), lo cual implica que entre mayor sea el ancho de banda, mejor será la capacidad de ese sistema de transmitir información; sin embargo, elegir la mayor ancho de banda posible no es panacea, pues no sólo conlleva a una inversión económica acrecentada, sino que además, si la decisión no es tomada con prudencia, puede ocurrir que en lugar de mejorar el rendimiento del sistema se empeore, sobre todo por la observación mencionada en el apartado [Efecto del ruido en el ancho de banda](#ruido): los estragos que el ruido puede ocasionar en una señal tienen cierta relación con la distribución espectral del ruido, ergo, así como un ancho de banda mayor puede ampliar la cantidad de información útil que es posible transmitir, también puede abrir la posibilidad de que esta información se vea distorsionada por coincidir con más frecuencias que estén siendo afectadas por un ruido más grande del que el sistema esté listo para afrontar.


## Bibliografía<a name="bibliografia"></a>
- Tomasi, W. (1994). *Fundamentals of electronic communications systems.* Englewood Cliffs, N.J.: Prentice Hall, pp.4, 5.
- Stremler, F. (1982). *Sistemas de comunicación*. Massachusetts: Fondo educativo interamericano, pp.115, 116.
- Comer, D. (2015). *Computer Networks and Internets.* 6th ed. Prentice Hall, p.99.
- Rosengrant, M. (2007). *Introduction to telecommunications.* Upper Saddle River, New Jersey: Pearson Prentice Hall.
- Stanley, W. and Jeffords, J. (2006). *Electronic communications: Principles and systems* Clifton Park: Thomson Delmar Learning, p.4.
- Proakis, J. and Saheli, M. (2014). *Fundamentals of communication systems*. 2nd ed. Boston: Pearson, p.664.
- Networks, P. and Psychz Networks (2019). *What is The 95th Percentile Bandwidth Metering?* .... [online] Psychz Networks. Available at: [https://www.psychz.net](https://www.psychz.net/client/kb/en/what-is-the-95th-percentile-bandwidth-metering.html) [Accessed 28 Aug. 2019].
- Veber. (2019). *What is Bandwidth and How is it Measured?*. [online] Available at: [https://www.veber.co.uk](https://www.veber.co.uk/what-is-bandwidth-and-how-is-it-measured/) [Accessed 28 Aug. 2019].
- Paessler. (2019). *What is Bandwidth? - Definition and Details.* [online] Available at: [https://www.paessler.com](https://www.veber.co.uk/what-is-bandwidth-and-how-is-it-measured/) [Accessed 28 Aug. 2019].
- Toppr-guides. (2019). *Bandwidth of Signals: Definition, Concepts, Applications, Videos, Examples.* [online] Available at: [https://www.toppr.com](https://www.toppr.com) [Accessed 28 Aug. 2019].


<!-- To include later: "The basic limi tation that noise causes in a communication channel is not the reliability of communication, but on the speed of communication" Shannon (1948) by John Proakis -->
