## Lado Transmisor
Una señal senosoidal pura es muestreada utilizando una señal de muestreo en donde, para cada flanco positivo de esta última señal se toma una muestra de la señal analógica en ese momento de tiempo (*muestreo*)

Cuantización: asocia cada punto muestreado con un número binario de `n` bits. Por ejemplo, para 4 bits de resolución de cuantización, se tendrían 16 bits (niveles) discretos de cuantización.

**Nota:** *entre más bits sean usados, más fiel será la representación discreta de la señal analógica. La frecuencia de muestreo también beneficia la fidelidad de la señal*

Finalmente, se obtendrá una cadena de bits donde cada `n` bits se está representando un dato muestreado de la señal original.

**Nota**: La digitalización es el proceso de muestrear y cuantizar

## Lado Receptor
**Demodulación:** La longitud de palabra representa el número de bits que representan una señal muestreada. Una vez que se obtienen las *palabras* se obtiene...

Cuando ya se ha obtenido el nivel que le corresponde a cada palabra se suele aplicar un filtro que suaviza la señal para difuminar los picos que son generados como resultado de la digitalización.

## Procedimiento
1. Se conecta un cable coaxial con candado desde el Generador (*Dual function generator*) al Osciloscopio
2. Se ajusta el Generador a señal sinusoidal (1KHz)
3. Conectar el Generador al Codificador de PCM
4. En otro canal del Generador se generará también la señal de muestreo
5. Ambas señales generadas desde el Generador se enviarán al Codificador de PCM
6. El modulador se encargará de muestrear y cuantizar las señales
7. La señal ya codificada es entonces decodificada en un Decodificador de PCM
8. La señal decodificada es entonces desplegada en el mismo osciloscopio, en donde es posible observar que la señal toma la forma aproximadamente original, pero se pueden observar los muestreos y la hacen parecer una escalera, en lugar de una señal sinusoidal
9. Posteriormente, es utilizado un filtro que permitirá suavizar la imagen de tal manera que lucirá mucho más asemejada a la original