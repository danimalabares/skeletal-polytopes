INSTRUCCIONES

1. Se "clona" el repositorio a la computadora local.

2. Abrir terminal y correr

``latexmk -pdf two-chiral.tex``

Eso crea el pdf. Para abrirlo (si no lo hace automáticamente) ``open two-chiral.pdf``.

En caso de trabajar en el archivo .tex se puede compilar continuamente mediante 

``latexmk -pdf -pvc two-chiral.tex``

3. Para borrar los "byproducts" de la compilación

``make clean``

(Eso también borra el pdf, que es mejor no guardar en el github porque usa memoria y no es necesario tenerlo aquí)

**El commit "Updated two-poytopex.tex", con número 91a75a2, contiene las
principales modificaciones que hice**.

**Por ahora dejé la referencia de los programas de GAP con el link al
repositorio de GitHub donde los subí originalmente. Como escribí en el texto,
otra opción es sólo poner que los disponibilizaremos "upon request". También
podemos ver si hay otra forma de publicarlos.**
