# an-lisis-de-datos



## Aclaración

El dataset utilizado no contiene la estructura completa indicada por la consigna.

- La relación **Dim_Categorias → Dim_Productos** no pudo implementarse porque la tabla **Dim_Productos** no dispone del campo **id_categoria**, sino únicamente del nombre de la categoría.

- La medida **Ventas Online** se creó utilizando el campo **canal**. Si el dataset no contiene registros con valor **"Online"**, la medida devuelve **BLANK()**, lo cual es consistente con la información disponible.

Las demás relaciones, la tabla calendario y las medidas DAX fueron implementadas respetando la estructura real del modelo.
