use cobis
go

delete from cl_errores 
where numero in (70326,70327,70328,70329,70330,70331,70332,70333,
				 70334,70335,70336,70337,70338,70339,70340,70341)

insert into cl_errores values(70326,1,'No existen respuestas del cliente')
insert into cl_errores values(70327,1,'Error en al insertar datos en la tabla cl_neg_cliente')
insert into cl_errores values(70328,1,'No existe un formulario vigente')
insert into cl_errores values(70329,1,'Existen más de un formulario con estado Activo')
insert into cl_errores values(70330,1,'No existe secciones para el formulario')
insert into cl_errores values(70331,1,'No exiten preguntas del formulario')
insert into cl_errores values(70332,1,'No exiten preguntas tipo tabla para el formulario')
insert into cl_errores values(70333,1,'No existe respuesta relacionadas al formulario')
insert into cl_errores values(70334,1,'No existe informacion relacionada a la pregunta')
insert into cl_errores values(70335,1,'La suma de los ingresos semanales del cliente no esta en el rango permitido')
insert into cl_errores values(70336,1,'La suma de los gastos semanales del cliente no esta en el rango permitido')
insert into cl_errores values(70337,1,'Las diferencia entre ingresos y gastos, es muy pequeña, no llegan a los')
insert into cl_errores values(70338,1,'Falta capturar (digitalizar) Comprobante de ingreso tipo <tipo del ingreso>')
insert into cl_errores values(70339,1,'El valor a solicitar debe ser múltiplo de 100 pesos.')
insert into cl_errores values(70340,1,'La periodicidad seleccionada no es válida en este ciclo.')
insert into cl_errores values(70341,1,'El plazo seleccionado no es válida en este ciclo.')

go
