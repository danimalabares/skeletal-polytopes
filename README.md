INSTRUCCIONES

1. Se "clona" el repositorio a la computadora local.

2. Abrir terminal y correr

``latexmk -pdf two-polytopes.tex``

Eso crea el pdf. Para abrirlo (si no lo hace automáticamente) ``open two-polytopes.pdf``.

En caso de trabajar en el archivo .tex se puede compilar continuamente mediante 

``latexmk -pdf -pvc two-polytopes.tex``

3. Para borrar los ``byproducts'' de la compilación

``make clean``

(Eso también borra el pdf, que es mejor no guardar en el github porque usa memoria y no es necesario tenerlo aquí)
