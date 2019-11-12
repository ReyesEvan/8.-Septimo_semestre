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


Objetivo: 
Conocer y manejar los parámetros en modulación PCM en señales de audio.
Material necesario:
Fuente de telecomunicaciones de LabVolt.
Rack para módulos de codificación. 
Módulo PCM Encoder
Módulo PCM Decoder.
Módulo Low Pass Filter
Modulo Dual Function generator.
Cables BNC-BNC

Desarrollo:

-Configure el Módulo  generador de Funciones para obtener una señal sinusoidal de 1khz en la salida A.
- Configure el Módulo  generador de Funciones para obtener una señal de sincronía de 10Khz en la salida B, la cual funcionará como señal de muestreo.
-Observe cada señal en el osciloscopio.
-Inyecte las señales anteriores en el módulo codificador PCM en Audio Input y Clock input, respectivamente.
-En el canal 1 del osciloscopio observe la señal a la salida del Modulador PCM, esta deberá ser un tren de pulsos no uniformes (data).
-En el canal dos del osciloscopio observe la señal de salida EOC (end of conversion) de modulador PCM.
-Inyecte la salida paralela del módulo PCM encoder a la entrada del Módulo PCM decoder.
-Observe en el osciloscopio la salida del módulo decodificador.
-Filtre esta última señal usando el módulo Low Pass Filter y observe en el osciloscopio la señal filtrada.
-Compare con la señal sinusoidal original.
-Saque conclusiones.
-Reporte en el formato acordado todas las señales registradas.
