#!/bin/bash
# drae -- uso del diccionario de la RAE en consola

version=0.11
es_verbo? () {
 #echo "Parámetros pasados a la función: $*"
 verbo=`echo $1 | grep "Conjugación de" `
 if [ "$?" != 0 ]; then # no es verbo
 	cat <<-error-verbo
Error: verbo no detectado.
También puede ser: un problema en la red o de esta aplicación misma.
Verifique que tiene la última versión o informe de error en:
<https://github.com/jacob-mf/drae>
<https://gitlab.com/caldez/drae>
Disculpe las molestias. Gracias
error-verbo
exit 1
 fi
}

test_carga () {
 if [ "$?" != 0 ]; then # error en carga
    cat <<-error-carga
Error en la carga desde el servidor del diccionario.
Problema de red o de esta aplicación misma.
Verifique que tiene la última versión o informe de error en:
<https://github.com/jacob-mf/drae>
<https://gitlab.com/caldez/drae>
Disculpe las molestias. Gracias
error-carga
exit 1
 fi
}

test_error_url () {
    if  [[ ! -s '/tmp/.pb.txt' ]]; then # salida vacía
      echo "Salida errónea..."
      long=${#in} # longitud de la cadena
      ((long--)) # decremento
      if [[ ! ${in,,} == "$in" ]]; then  # hay mayúsculas
         in=${in,,}
         echo Probando ahora con $in
         drae $in
         exit 0
      else if [[ ${in:long} == 'a' ]] ; then # último caracter es 'a'
         #${in:long}='o' # error no cambia palabra
         in=${in/%a/o} # cambia si termina en 'a' u 'o'
         echo Probando ahora con $in
         drae $in
         exit 0
      else if [[ ${in:long} == 'o' ]] || [[ ${in:long} == 'e' ]] || [[ ${in:long} == 's' ]]; then
         in=${in/%?/''} # eliminamos último carácter e, o ó s
         echo Probando ahora con $in
         drae $in
         exit 0
      else
           cat<<-error-palabra
Error en la búsqueda desde el servidor del diccionario.
Problema aún sin solucionar.
Verifique que tiene la última versión o informe de error en:
<https://github.com/jacob-mf/drae>
<https://gitlab.com/caldez/drae>
Disculpe las molestias. Gracias
error-palabra
           exit 1
       fi
          exit 3
      fi
      fi
    fi
}

# Conjugaciones #
if [ "$1" = "-c" ]; then
in="$2"
fu="#conjugacion"
elinks -dump 'http://dle.rae.es/'${in}${fu}'' > /tmp/.conjugacion.txt
sed '/Todos los derechos reservados/q0' /tmp/.conjugacion.txt > /tmp/.conj.txt
conjugacion=`sed '1,27d' /tmp/.conj.txt`
es_verbo? "$conjugacion"
sed '1,27d' /tmp/.conj.txt > /tmp/.conjugacion.txt
conjugacion=`grep 'Conjugación de .*' /tmp/.conjugacion.txt -A 100`
more <<-conjtexto
$conjugacion
conjtexto
rm /tmp/.conj.txt /tmp/.conjugacion.txt

# Palabras segun primeras letras #
else if [ "$1" = "-e" ]; then
in="$2?m=31"
elinks -dump 'http://dle.rae.es/'${in}'' > /tmp/.emp.txt
sed '/Todos los derechos reservados/q0' /tmp/.emp.txt > /tmp/.e.txt
lema_emp=`sed '1,27d' /tmp/.e.txt`
more <<-etexto
$lema_emp
etexto
rm /tmp/.emp.txt /tmp/.e.txt

# Generar palabras (lemas) según últimas letras #
else if [ "$1" = "-t" ]; then
in="$2?m=32"
elinks -dump 'http://dle.rae.es/'${in}'' > /tmp/.ult.txt
sed '/Todos los derechos reservados/q0' /tmp/.ult.txt > /tmp/.t.txt
lema_term=`sed '1,27d' /tmp/.t.txt`
more <<-ttexto
$lema_term
ttexto
rm /tmp/.ult.txt /tmp/.t.txt

# Palabras según las letras que contengan, lemas que contienen las letras #
else if [ "$1" = "-C" ]; then
in="$2?m=33"
elinks -dump 'http://dle.rae.es/'${in}'' > /tmp/.termina.txt
sed '/Todos los derechos reservados/q0' /tmp/.termina.txt > /tmp/.c.txt
lema_incl=`sed '1,27d' /tmp/.c.txt`
more <<-ctexto
$lema_incl
ctexto
rm /tmp/.termina.txt /tmp/.c.txt

# Help
else if [[ "$1" == "--help"  ]]; then
cat <<-ayuda
DRAE $version, the Spanish RAE dictionary from the console.
 * Real Academia Española (Spanish Royal Academy)

Usage: drae [OPTION] [WORD]
 Output the dictionary defnition of the selected WORD (just one)
 (some options do not require any WORD as param).

Available options in the current version:

   WORD         output the word defnition, if exists,
                     or give hints of other(s) probably related

   -A           output the an aleatory (random) word definition entry
   -a WORD      output  anagram(s) of the entered word (other ones
                     that contain the same letters).
   -C [LETTERS] output words (lemmas) so contains
                     the requested letters.
   -p           output the word ('palabra') of the day by the RAE
   -e [LETTERS] output word(s) that begins ('empezar')
                     in the introduced letters
   -t [LETTERS] output word(s) that end ('terminen')
                     on the entered letters
   -c [VERB]    output possible conjugations of the entry verb

   --ayuda      show same help in Spanish
   --help       output this help info again
   --version    output program version

Samples:
    drae albos       output the RAE dictionary entry of the
                     word "albo, ba", though plural form was requested
    drae -e cada     output Spanish word(s) that starts on: "cada"

This applications is based on old 'drae' one and the project:
 <https://github.com/sardach/rae-cli>
 Both big inspirations of this project, so we want to
 honour them their authors here. Thanks a lot!
All the definitions are property of the Royal Spanish Academy.
If you wish you can report aboout errors, suggestions in:
 <https://github.com/jacob-mf/drae>
 <https://gitlab.com/caldez/drae>
Cheers!
ayuda

# Ayuda #
else if [[ "$1" ==  "--ayuda" ]]; then
cat <<-ayuda
DRAE $version, el Diccionario español de la RAE desde la consola.
 * Real Academia Española

Modo de empleo: drae [OPCIÓN] [PALABRA]
 Muestra la definición del diccionario acerca de la PALABRA (máximo una)
 introducida (algunas opciones no requieren del párametro PALABRA).

Opciones disponibles en la versión actual:

   PALABRA      muestra la definición de la palabra, si existe,
                     o muestra otras que pudieran estar relacionadas

   -A           muestra la definición de una palabra al azar
   -a PALABRA   muestra anagramas de la palabra (otras palabras
                     formadas con las mismas letras).
   -C [LETRAS]  muestra palabras (lemas) que contengan
                     las letras introducidas.
   -p           muestra la palabra del día de la RAE
   -e [LETRAS]  muestra palabras que empiecen en las letras dadas
   -t [LETRAS]  muestra palabras que terminen con las letras dadas
   -c [VERBO]   muestra las posibles conjugaciones del verbo

   --ayuda      muestra ésta misma pantalla
   --help       muestra la ayuda en idioma inglés
   --version    muestra la versión instalada del programada

Ejemplos:
    drae albos       se muestra a la entrada del diccionario de la
                     palabra "albo, ba", aunque se consulte el plural
    drae -e cada     se enumeran palabras que empiezan por: "cada"

Aplicación basada en otra antigua 'drae' y en el proyecto:
 <https://github.com/sardach/rae-cli>
 Inspiraciones ambas de esta aplicación, y a cuyos autores queremos
 homenajear aquí. Muchas gracias.
Todas las definiciones son propiedad de la Real Academia Española.
Si lo desea puede informar sobre errores y sugerencias en:
 <https://github.com/jacob-mf/drae>
 <https://gitlab.com/caldez/drae>
¡Salud!
ayuda

# version
else if [ "$1" = "--version" ]; then
cat <<-version
DRAE, versión $version
Copyright (C) 2020 Cáldez Soluciones, Corp.
Licencia GPLv3+: GPL de GNU versión 3 o posterior
 <http://gnu.org/licenses/gpl.html>

Esto es software libre, es libre para modificar y redistribuirlo.
No hay NINGUNA GARANTÍA, a la extensión permitida por la ley.
version


# Sin Argumentos #
else if [ "$1" = "" ]; then
cat <<-noarg
Se requieren argumentos para usar esta aplicación.
Teclee «drae --ayuda» para mas información.
También puede introducir ahora una palabra a buscar.
 Si no introduce una palabra (pulsa simplemente la tecla "ENTRAR"),
 el programa terminará.
noarg
read -p "Introduce palabra a buscar: " pal
 if [[ $pal = "" ]]; then # salida del programa
    exit 1
 else
   drae $pal  # búsqueda de nueva palabra
 fi

# Anagramas #
else if [ "$1" = "-a" ]; then
in="$2"
fu="anagram"
elinks -dump 'https://dle.rae.es/'${in}'?m='${fu}'' > /tmp/.anagrama.txt
sed '/Todos los derechos reservados/q0' /tmp/.anagrama.txt > /tmp/.anag.txt
anagrama=`sed '1,28d' /tmp/.anag.txt`
more <<-anag
Anagramas de la palabra "$in" en el diccionario de la RAE:
$anagrama
anag
rm /tmp/.anagrama.txt /tmp/.anag.txt

# Aleatorio #
else if [ "$1" = "-A" ]; then
elinks -dump https://dle.rae.es/?m=random > /tmp/.random.txt
sed '/Todos los derechos reservados/q0' /tmp/.random.txt > /tmp/.pa.txt
azar=`sed '1,27d' /tmp/.pa.txt`
rm /tmp/.random.txt /tmp/.pa.txt
more <<-pa
Palabra aleatoria del diccionario RAE:$azar
pa

# Palabra del Día #
else if [ "$1" = "-p" ]; then
elinks -no-references -no-numbering -dump https://dle.rae.es/?m=wotd > /tmp/.wotd.txt
sed '/Todos los derechos reservados/q0' /tmp/.wotd.txt > /tmp/.pa.txt
wotd=`sed '1,27d' /tmp/.pa.txt`
rm /tmp/.wotd.txt /tmp/.pa.txt
more <<-pdd
Palabra del dia:$wotd
pdd

# Opción no contemplada
else if [[ "$1" == -* ]]; then
more <<-opcion-no-valida
Lo siento. La opción $1 no está disponible.
Consulte «drae --ayuda» para consultar las opciones posibles.
Salud
opcion-no-valida
exit 2

# Definiciones # acceso a /tmp
else if [ "$1" != "" ]; then # sin parámetros
in="$1"
fu="?w"
elinks -no-references -no-numbering -dump 'http://dle.rae.es/'${fu}'='${in} > /tmp/.pc.txt
test_carga
sed '/Todos los derechos reservados/q0' /tmp/.pc.txt > /tmp/.pa.txt
sed '1,27d' /tmp/.pa.txt > /tmp/.pb.txt
more /tmp/.pb.txt
test_error_url
rm /tmp/.pa.txt /tmp/.pc.txt /tmp/.pb.txt

fi fi fi fi fi fi fi fi fi fi fi fi fi

exit 0
