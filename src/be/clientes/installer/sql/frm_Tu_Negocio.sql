use cobis
go

declare @w_id_frm 			int,
		@w_frm	   			varchar(30),
		@w_id_seccion_dt	int,
		@w_id_seccion_in	int,
		@w_id_seccion_ga	int,
		@w_id_seccion_ci	int,
		@w_version_frm		int,
		@w_id_pregunta		int,
		@w_id_cat_pregunta	int,
		@w_id_tabla			int,
		@w_id_catalogo		int

select @w_frm='Tu Negocio'


select 	@w_id_frm		=	ne_id_formulario,
		@w_version_frm	=	ne_vers_formulario
from  cl_frm_negocio 
where ne_nombre_formulario=@w_frm 
and ne_estado_version='P'

--Elimina informacion previa
delete from cl_frm_pregunta_tabla where pt_formulario = @w_id_frm
delete from cl_frm_catalogo_pregunta where cp_id_form = @w_id_frm
delete from cl_frm_preguntas where pe_formulario = @w_id_frm
delete from cl_frm_seccion where se_id_formulario = @w_id_frm
delete from cl_frm_negocio where ne_id_formulario= @w_id_frm

--Inserta Formulario
select @w_version_frm = isnull(@w_version_frm,0) +1 
select @w_id_frm = isnull(max(ne_id_formulario),0) +1 from cl_frm_negocio

insert into cl_frm_negocio values(@w_id_frm, @w_version_frm, @w_frm, 'P',80,getDate(),'admuser')

--Inserta Secciones
select @w_id_seccion_dt = isnull(max(se_id_seccion),0) +1 from cl_frm_seccion

insert into cl_frm_seccion values(@w_id_frm,@w_version_frm,@w_id_seccion_dt,'DATOS GENERALES DEL NEGOCIO','DATOS GENERALES DEL NEGOCIO','IN;RE')
select @w_id_seccion_in = @w_id_seccion_dt +1
insert into cl_frm_seccion values(@w_id_frm,@w_version_frm,@w_id_seccion_in,'INGRESOS','INGRESOS','IN;RE')
select @w_id_seccion_ga = @w_id_seccion_in +1
insert into cl_frm_seccion values(@w_id_frm,@w_version_frm,@w_id_seccion_ga,'GASTOS','GASTOS','IN;RE')
select @w_id_seccion_ci = @w_id_seccion_ga +1
insert into cl_frm_seccion values(@w_id_frm,@w_version_frm,@w_id_seccion_ci,'CALIDAD DE LA INVESTIGACION','CALIDAD DE LA INVESTIGACION','RE')

--Inserta Preguntas seccion Datos Generales
select @w_id_pregunta = isnull(max(pe_pregunta),0) +1 from cl_frm_preguntas
insert into cl_frm_preguntas values(@w_id_pregunta,@w_id_seccion_dt,@w_id_frm,@w_version_frm,'1. PROPIEDAD DEL NEGOCIO','PROPIEDAD DEL NEGOCIO','C','N')
	
	--catalogo de respuestas
	select @w_id_cat_pregunta = isnull(max(cp_id_cat_resp),0) +1 from cl_frm_catalogo_pregunta
	select @w_id_catalogo = isnull (max(cp_catalogo),0)+ 1 from cl_frm_catalogo_pregunta
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'PR','PROPIO',20)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1 from cl_frm_catalogo_pregunta
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'SF','SOCIOS FAMILIARES',15)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1 from cl_frm_catalogo_pregunta
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'SN','SOCIOS NO FAMILIARES',10)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1 from cl_frm_catalogo_pregunta
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'AM','AMBOS',5)

select @w_id_pregunta = @w_id_pregunta +1
insert into cl_frm_preguntas values(@w_id_pregunta,@w_id_seccion_dt,@w_id_frm,@w_version_frm,'2. ¿CUANTOS SOCIOS CONFORMAN EL NEGOCIO?','¿CUANTOS SOCIOS CONFORMAN EL NEGOCIO?','C','N')

	--catalogo de respuestas
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	select @w_id_catalogo = @w_id_catalogo + 1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'0','0',20)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'1','1-2',10)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'3','3-5',5)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'6','MAS DE 5',0)

select @w_id_pregunta = @w_id_pregunta +1
insert into cl_frm_preguntas values(@w_id_pregunta,@w_id_seccion_dt,@w_id_frm,@w_version_frm,'3. TIPO DE LOCAL','TIPO DE LOCAL','C','N')
	
	--catalogo de respuestas
	select @w_id_catalogo = @w_id_catalogo + 1
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'FI','FIJO',20)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'SF','SEMI FIJO (ANCLADO)',10)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'AM','AMBULANTE',0)
	
select @w_id_pregunta = @w_id_pregunta +1
insert into cl_frm_preguntas values(@w_id_pregunta,@w_id_seccion_dt,@w_id_frm,@w_version_frm,'4. PROPIEDAD DEL LOCAL','PROPIEDAD DEL LOCAL','C','N')

	--catalogo de respuestas
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	select @w_id_catalogo = @w_id_catalogo + 1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'PR','PROPIO',20)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'RE','RENTADO',10)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'PR','PRESTADO',0)

select @w_id_pregunta = @w_id_pregunta +1
insert into cl_frm_preguntas values(@w_id_pregunta,@w_id_seccion_dt,@w_id_frm,@w_version_frm,'5. ANTIGUEDAD DEL NEGOCIO (COMPROBABLE)','ANTIGUEDAD DEL NEGOCIO(COMPROBABLE)','C','N')

	--catalogo de respuestas
	select @w_id_catalogo = @w_id_catalogo + 1
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'6','MAS DE 5 AÑOS',20)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'4','4-5 AÑOS',15)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'2','1-3 AÑOS',5)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'1','MENOS DE 1 AÑO',0)

select @w_id_pregunta = @w_id_pregunta +1
insert into cl_frm_preguntas values(@w_id_pregunta,@w_id_seccion_dt,@w_id_frm,@w_version_frm,'6. ¿CUANTOS EMPLEADOS TIENE?','¿CUANTOS EMPLEADOS TIENE?','C','N')

	--catalogo de respuestas
	select @w_id_catalogo = @w_id_catalogo + 1
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'6','MAS DE 5',20)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'4','03-05',15)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'2','01-02',10)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'1','0',0)
	
select @w_id_pregunta = @w_id_pregunta +1
insert into cl_frm_preguntas values(@w_id_pregunta,@w_id_seccion_dt,@w_id_frm,@w_version_frm,'7. ¿CUENTA CON RFC?','¿CUENTA CON RFC?','C','N')

	--catalogo de respuestas
	select @w_id_catalogo = @w_id_catalogo + 1
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'S','SI',20)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'N','NO',0)


select @w_id_pregunta = @w_id_pregunta +1
insert into cl_frm_preguntas values(@w_id_pregunta,@w_id_seccion_dt,@w_id_frm,@w_version_frm,'8. ¿CUANTOS DIAS A LA SEMANA ABRE EL NEGOCIO?','¿CUANTOS DIAS A LA SEMANA ABRE EL NEGOCIO?','C','N')

	--catalogo de respuestas
	select @w_id_catalogo = @w_id_catalogo + 1
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'7','06-07',20)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'5','04-05',10)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'3','MENOS DE 4',5)

select @w_id_pregunta = @w_id_pregunta +1
insert into cl_frm_preguntas values(@w_id_pregunta,@w_id_seccion_dt,@w_id_frm,@w_version_frm,'9. ¿CUANTAS HORAS AL DIA SE ENCUENTRA ABIERTO EL NEGOCIO?','¿CUANTAS HORAS AL DIA SE ENCUENTRA ABIERTO EL NEGOCIO?','C','N')

	--catalogo de respuestas
	select @w_id_catalogo = @w_id_catalogo + 1
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'10','DE 10 EN ADELANTE',20)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'9','06-09',10)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'5','MENOS DE 6',0)
	
select @w_id_pregunta = @w_id_pregunta +1
insert into cl_frm_preguntas values(@w_id_pregunta,@w_id_seccion_dt,@w_id_frm,@w_version_frm,'10. ¿CUANTOS CREDITOS TIENE VIGENTES?','¿CUANTOS CREDITOS TIENE VIGENTES?','C','N')

	--catalogo de respuestas
	select @w_id_catalogo = @w_id_catalogo + 1
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'0','0',20)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'1','1',15)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'2','2',5)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'3','3',5)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'4','MAS DE 3',0)


select @w_id_pregunta = @w_id_pregunta +1
insert into cl_frm_preguntas values(@w_id_pregunta,@w_id_seccion_dt,@w_id_frm,@w_version_frm,'11. ¿TIENE AUTO?¿CUANTOS AÑOS TIENE DE USO?','¿TIENE AUTO?¿CUANTOS AÑOS TIENE DE USO?','C','N')

	--catalogo de respuestas
	select @w_id_catalogo = @w_id_catalogo + 1
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'3','SI, MENOS DE 3 AÑOS',20)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'4','SI, ENTRE 3 Y 4 AÑOS',15)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'5','SI, MAS DE 5 AÑOS',10)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'N','NO',0)


select @w_id_pregunta = @w_id_pregunta +1
insert into cl_frm_preguntas values(@w_id_pregunta,@w_id_seccion_dt,@w_id_frm,@w_version_frm,'12. ¿CON CUANTOS PROVEEDORES TRABAJA?','¿CON CUANTOS PROVEEDORES TRABAJA?','C','N')

	--catalogo de respuestas
	select @w_id_catalogo = @w_id_catalogo + 1
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'5','5 O MAS',20)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'4','03-04',15)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'2','01-02',10)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'0','0',0)

select @w_id_pregunta = @w_id_pregunta +1
insert into cl_frm_preguntas values(@w_id_pregunta,@w_id_seccion_dt,@w_id_frm,@w_version_frm,'13. ¿CUANTOS DIAS DE CREDITO LE DAN SUS PROVEEDORES?','¿CUANTOS DIAS DE CREDITO LE DAN SUS PROVEEDORES?','C','N')

	--catalogo de respuestas
	select @w_id_catalogo = @w_id_catalogo + 1
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'60','DE 60 EN ADELANTE',20)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'30','DE 30 A 60',15)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'15','DE 15 A 30',10)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'14','MENOS DE 15',0)

select @w_id_pregunta = @w_id_pregunta +1
insert into cl_frm_preguntas values(@w_id_pregunta,@w_id_seccion_dt,@w_id_frm,@w_version_frm,'14. ¿A QUE DESTINARA EL CREDITO QUE LE OTORGUEMOS?','¿A QUE DESTINARA EL CREDITO QUE LE OTORGUEMOS?','C','N')

	--catalogo de respuestas
	select @w_id_catalogo = @w_id_catalogo + 1
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'CM','COMPRA DE MAQUINARIA',20)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'CE','COMPRA DE EQUIPO DE TRANSPORTE',15)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'15','CAPITAL DE TRABAJO',10)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'14','OTRO',0)

select @w_id_pregunta = @w_id_pregunta +1
insert into cl_frm_preguntas values(@w_id_pregunta,@w_id_seccion_dt,@w_id_frm,@w_version_frm,'15. ¿CUENTA CON REGISTRO DE SUS INGRESOS Y GASTOS?','¿CUENTA CON REGISTRO DE SUS INGRESOS Y GASTOS?','C','N')

	--catalogo de respuestas
	select @w_id_catalogo = @w_id_catalogo + 1
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'S','SI',20)
	select @w_id_cat_pregunta = @w_id_cat_pregunta +1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'N','NO',0)
	
select @w_id_pregunta = @w_id_pregunta +1
insert into cl_frm_preguntas values(@w_id_pregunta,@w_id_seccion_dt,@w_id_frm,@w_version_frm,'16. ¿CUAL ES EL MONTO QUE SOLICITARA?','¿CUAL ES EL MONTO QUE SOLICITARA?','M','N')
select @w_id_pregunta = @w_id_pregunta +1
insert into cl_frm_preguntas values(@w_id_pregunta,@w_id_seccion_dt,@w_id_frm,@w_version_frm,'17. ¿PERIODICIDAD DEL PAGO DEL PRESTAMO?','¿PERIODICIDAD DEL PAGO DEL PRESTAMO?','C','N')

	--catalogo de respuestas
	select @w_id_catalogo = @w_id_catalogo + 1
	select @w_id_cat_pregunta = @w_id_cat_pregunta + 1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'S','SEMANAL',null)
	select @w_id_cat_pregunta = @w_id_cat_pregunta + 1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'C','CATORCENAL',null)
	select @w_id_cat_pregunta = @w_id_cat_pregunta + 1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'M','MENSUAL',null)

select @w_id_pregunta = @w_id_pregunta + 1
insert into cl_frm_preguntas values(@w_id_pregunta,@w_id_seccion_dt,@w_id_frm,@w_version_frm,'18. ¿CUAL ES EL PLAZO QUE LE GUSTARIA SOLICITAR?','¿CUAL ES EL PLAZO QUE LE GUSTARIA SOLICITAR?','C','N')

	--catalogo de respuestas
	select @w_id_catalogo = @w_id_catalogo + 1
	select @w_id_cat_pregunta = @w_id_cat_pregunta + 1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'4','4 MESES',null)
	select @w_id_cat_pregunta = @w_id_cat_pregunta + 1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'5','5 MESES',null)
	select @w_id_cat_pregunta = @w_id_cat_pregunta + 1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'6','6 MESES',null)
	select @w_id_cat_pregunta = @w_id_cat_pregunta + 1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'8','8 MESES',null)
	
--Inserta Preguntas seccion Ingresos
select @w_id_pregunta = @w_id_pregunta + 1
insert into cl_frm_preguntas values(@w_id_pregunta,@w_id_seccion_in,@w_id_frm,@w_version_frm,'','INGRESOS','T','N')

	--catalogo de respuestas
	select @w_id_catalogo = @w_id_catalogo + 1
	select @w_id_cat_pregunta = @w_id_cat_pregunta + 1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'LI','LIBRO DE INGRESOS',null)
	select @w_id_cat_pregunta = @w_id_cat_pregunta + 1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'FA','FACTURAS',null)
	select @w_id_cat_pregunta = @w_id_cat_pregunta + 1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'NR','NOTAS DE REMISION',null)
		
		--Crea tabla
	select @w_id_tabla = isnull(max(pt_tabla),0) + 1 from cl_frm_pregunta_tabla
	insert into cl_frm_pregunta_tabla values(@w_id_frm,@w_id_pregunta,@w_id_tabla,'TIPO DE INGRESO','C',@w_id_catalogo,'S')
	select @w_id_tabla = @w_id_tabla+1
	insert into cl_frm_pregunta_tabla values(@w_id_frm,@w_id_pregunta,@w_id_tabla,'SEMANA 1','M',null,'S')
	select @w_id_tabla = @w_id_tabla+1
	insert into cl_frm_pregunta_tabla values(@w_id_frm,@w_id_pregunta,@w_id_tabla,'SEMANA 2','M',null,'S')
	select @w_id_tabla = @w_id_tabla+1
	insert into cl_frm_pregunta_tabla values(@w_id_frm,@w_id_pregunta,@w_id_tabla,'SEMANA 3','M',null,'S')
	select @w_id_tabla = @w_id_tabla+1
	insert into cl_frm_pregunta_tabla values(@w_id_frm,@w_id_pregunta,@w_id_tabla,'SEMANA 4','M',null,'S')
	
--Inserta Preguntas seccion Gastos
select @w_id_pregunta = @w_id_pregunta + 1
insert into cl_frm_preguntas values(@w_id_pregunta,@w_id_seccion_ga,@w_id_frm,@w_version_frm,'','GASTOS','T','N')

	--catalogo de respuestas
	select @w_id_catalogo = @w_id_catalogo + 1
	select @w_id_cat_pregunta = @w_id_cat_pregunta + 1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'RE','RENTA',null)
	select @w_id_cat_pregunta = @w_id_cat_pregunta + 1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'LU','LUZ',null)
	select @w_id_cat_pregunta = @w_id_cat_pregunta + 1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'AG','AGUA',null)
	select @w_id_cat_pregunta = @w_id_cat_pregunta + 1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'GA','GAS',null)
	select @w_id_cat_pregunta = @w_id_cat_pregunta + 1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'TE','TELEFONO',null)
	select @w_id_cat_pregunta = @w_id_cat_pregunta + 1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'NO','NOMINA',null)
	select @w_id_cat_pregunta = @w_id_cat_pregunta + 1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'RA','RAYAS',null)
	select @w_id_cat_pregunta = @w_id_cat_pregunta + 1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'HO','HOGAR',null)
	select @w_id_cat_pregunta = @w_id_cat_pregunta + 1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'PP','PAGO DE PRESTAMOS',null)
		
	--Crea tabla
	select @w_id_tabla = isnull(max(pt_tabla),0) + 1 from cl_frm_pregunta_tabla
	insert into cl_frm_pregunta_tabla values(@w_id_frm,@w_id_pregunta,@w_id_tabla,'TIPO DE GASTO','C',@w_id_catalogo,'S')
	select @w_id_tabla = @w_id_tabla+1
	insert into cl_frm_pregunta_tabla values(@w_id_frm,@w_id_pregunta,@w_id_tabla,'SEMANA 1','M',null,'S')
	select @w_id_tabla = @w_id_tabla+1
	insert into cl_frm_pregunta_tabla values(@w_id_frm,@w_id_pregunta,@w_id_tabla,'SEMANA 2','M',null,'S')
	select @w_id_tabla = @w_id_tabla+1
	insert into cl_frm_pregunta_tabla values(@w_id_frm,@w_id_pregunta,@w_id_tabla,'SEMANA 3','M',null,'S')
	select @w_id_tabla = @w_id_tabla+1
	insert into cl_frm_pregunta_tabla values(@w_id_frm,@w_id_pregunta,@w_id_tabla,'SEMANA 4','M',null,'S')
	
--Inserta Preguntas seccion Calida de Investigacion
select @w_id_pregunta = @w_id_pregunta + 1
insert into cl_frm_preguntas values(@w_id_pregunta,@w_id_seccion_ci,@w_id_frm,@w_version_frm,'1. ¿LOS ERRORES ENCONTRADOS SON BLOQUEANTES?','¿LOS ERRORES ENCONTRADOS SON BLOQUEANTES?','C','N')
	
		--catalogo de respuestas
	select @w_id_catalogo = @w_id_catalogo + 1
	select @w_id_cat_pregunta = @w_id_cat_pregunta + 1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'S','SI',-999)
	select @w_id_cat_pregunta = @w_id_cat_pregunta + 1
	insert into cl_frm_catalogo_pregunta values(@w_id_cat_pregunta,@w_id_frm,@w_id_pregunta,@w_id_catalogo,'N','NO',0)

go

insert into cl_frm_seccion_ctrl values(1,1,1,'INVESTIGAR NEGOCIO','S','S')
insert into cl_frm_seccion_ctrl values(2,1,2,'INVESTIGAR NEGOCIO','S','S')
insert into cl_frm_seccion_ctrl values(3,1,3,'INVESTIGAR NEGOCIO','S','S')
insert into cl_frm_seccion_ctrl values(4,1,4,'INVESTIGAR NEGOCIO','S','S')
go