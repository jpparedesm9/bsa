use cobis 
go

--- ==========================	cl_frm_negocio
if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_FORMULARIO')
begin	
   drop index IDX_NEGOCIO_FORMULARIO on cl_frm_negocio
end
if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_VERSION')
begin	
   drop index IDX_NEGOCIO_VERSION on cl_frm_negocio
end

if object_id('cl_frm_negocio') is not null 
	drop table cobis..cl_frm_negocio
go
	create table cobis..cl_frm_negocio
		(
			ne_id_formulario     int not null,
			ne_vers_formulario   int not null,
			ne_nombre_formulario varchar(100),
			ne_estado_version    char(1),
			ne_calif_minima      smallint,
			ne_fecha_creacion    datetime,
			ne_usuario 			 varchar(60)			
		)
go
	create unique index IDX_NEGOCIO_FORMULARIO ON cl_frm_negocio(ne_id_formulario)
go
	create index IDX_NEGOCIO_VERSION ON cl_frm_negocio(ne_vers_formulario)
go

--- ==========================	cl_frm_seccion
if exists (select 1 from sys.indexes where name = 'IDX_SECCION_FORMUL')
begin	
   drop index IDX_SECCION_FORMUL on cl_frm_seccion
end

if exists (select 1 from sys.indexes where name = 'IDX_SECCION_VERSION')
begin	
   drop index IDX_SECCION_VERSION on cl_frm_seccion
end

if exists (select 1 from sys.indexes where name = 'IDX_SECCION')
begin	
   drop index IDX_SECCION on cl_frm_seccion
end

if exists (select 1 from sys.indexes where name = 'IDX_SECCION_1')
begin	
   drop index IDX_SECCION_1 on cl_frm_seccion
end

if object_id('cl_frm_seccion') is not null 
	drop table cobis..cl_frm_seccion
go
	create table cobis..cl_frm_seccion
		(
			se_id_formulario int not null,
			se_id_vers_form  int not null,
			se_id_seccion    int not null,
			se_etiqueta      varchar(100) not null,
			se_descripcion   varchar(254) null,
			se_mostrar		 varchar(64)  null		
		)
go

	create index IDX_SECCION_FORMUL  ON cl_frm_seccion(se_id_formulario)
go

	create index IDX_SECCION_VERSION ON cl_frm_seccion(se_id_vers_form)
go

	create index IDX_SECCION         ON cl_frm_seccion(se_id_seccion)
go

    create nonclustered index IDX_SECCION_1 on cl_frm_seccion(se_id_formulario,se_id_vers_form)
go   


--- ==========================	cl_frm_preguntas
if exists (select 1 from sys.indexes where name = 'IDX_FRM_PREGUNTA')
begin	
   drop index IDX_FRM_PREGUNTA on cl_frm_preguntas
end


if exists (select 1 from sys.indexes where name = 'IDX_FRM_SECCIONP')
begin	
   drop index IDX_FRM_SECCIONP on cl_frm_preguntas
end

if exists (select 1 from sys.indexes where name = 'IDX_FRM_FORM')
begin	
   drop index IDX_FRM_FORM on cl_frm_preguntas
end

if exists (select 1 from sys.indexes where name = 'IDX_FRM_VERSION')
begin	
   drop index IDX_FRM_VERSION on cl_frm_preguntas
end

if exists (select 1 from sys.indexes where name = 'IDX_FRM_PREGUNTAS_1')
begin	
   drop index IDX_FRM_PREGUNTAS_1 on cl_frm_preguntas
end

if object_id('cl_frm_preguntas') is not null 
	drop table cobis..cl_frm_preguntas
go
	create table cobis..cl_frm_preguntas
		(
			pe_pregunta     int not null,
			pe_seccion      int not null,
			pe_formulario   int not null,
			pe_version      int not null,
			pe_etiqueta     varchar(100) not null,
			pe_descripcion  varchar(254) null,
			pe_tipo_resp    char(1),
			pe_obligatoria  char(1),
			pe_registros	tinyint,
			pe_repetidos	char(1)
		)
go

	create unique index IDX_FRM_PREGUNTA ON cl_frm_preguntas(pe_pregunta)
go

	create index IDX_FRM_SECCIONP ON cl_frm_preguntas(pe_seccion)
go


	create index IDX_FRM_FORM ON cl_frm_preguntas(pe_formulario)
go

	create index IDX_FRM_VERSION ON cl_frm_preguntas(pe_version)
go

	create nonclustered index IDX_FRM_PREGUNTAS_1 on cl_frm_preguntas (pe_formulario, pe_version,pe_pregunta)
go


--- ==========================	cl_frm_pregunta_tabla
if exists (select 1 from sys.indexes where name = 'IDX_PE_TAB_FORMUL')
begin	
   drop index IDX_PE_TAB_FORMUL on cl_frm_pregunta_tabla
end
if exists (select 1 from sys.indexes where name = 'IDX_PE_TA_PREG')
begin	
   drop index IDX_PE_TA_PREG on cl_frm_pregunta_tabla
end

if exists (select 1 from sys.indexes where name = 'IDX_PE_TABLA')
begin	
   drop index IDX_PE_TABLA on cl_frm_pregunta_tabla
end

if exists (select 1 from sys.indexes where name = 'IDX_FRM_PREGUNTA_TABLA_1')
begin	
   drop index IDX_FRM_PREGUNTA_TABLA_1 on cl_frm_pregunta_tabla
end

if object_id('cl_frm_pregunta_tabla') is not null 
	drop table cobis..cl_frm_pregunta_tabla
go
	create table cobis..cl_frm_pregunta_tabla
		(
			pt_formulario     int not null,
			pt_pregunta_form  int not null,
			pt_tabla          int not null,
			pt_columna        varchar(60) not null,
			pt_tipo_dato      char(1) not null,
			pt_catalogo		  int null,
			pt_obligatoriedad char(1) not null
		)
go

	create index IDX_PE_TAB_FORMUL ON cl_frm_pregunta_tabla(pt_formulario)
go


	create index IDX_PE_TA_PREG    ON cl_frm_pregunta_tabla(pt_pregunta_form)
go


	create index IDX_PE_TABLA      ON cl_frm_pregunta_tabla(pt_tabla)
go


	create nonclustered index IDX_FRM_PREGUNTA_TABLA_1 on cl_frm_pregunta_tabla (pt_formulario, pt_pregunta_form,	pt_tabla)
go

--- ==========================	cl_frm_ente_respuesta
if exists (select 1 from sys.indexes where name = 'IDX_ENT')
begin	
   drop index IDX_ENT on cl_frm_ente_respuesta
end

if exists (select 1 from sys.indexes where name = 'IDX_ENT_RESPUESTA')
begin	
   drop index IDX_ENT_RESPUESTA on cl_frm_ente_respuesta
end

if exists (select 1 from sys.indexes where name = 'IDX_ENT_FORMULARIO')
begin	
   drop index IDX_ENT_FORMULARIO on cl_frm_ente_respuesta
end

if exists (select 1 from sys.indexes where name = 'IDX_ENT_VERSION')
begin	
   drop index IDX_ENT_VERSION on cl_frm_ente_respuesta
end

if exists (select 1 from sys.indexes where name = 'IDX_ENTE_PREGUNTA')
begin	
   drop index IDX_ENTE_PREGUNTA on cl_frm_ente_respuesta
end

if exists (select 1 from sys.indexes where name = 'IDX_FRM_ENTE_RESPUESTA_1')
begin	
   drop index IDX_FRM_ENTE_RESPUESTA_1 on cl_frm_ente_respuesta
end

if exists (select 1 from sys.indexes where name = 'IDX_FRM_ENTE_RESPUESTA_2')
begin	
   drop index IDX_FRM_ENTE_RESPUESTA_2 on cl_frm_ente_respuesta
end

if exists (select 1 from sys.indexes where name = 'IDX_FRM_ENTE_RESPUESTA_3')
begin	
   drop index IDX_FRM_ENTE_RESPUESTA_3 on cl_frm_ente_respuesta
end

if object_id('cl_frm_ente_respuesta') is not null 
	drop table cobis..cl_frm_ente_respuesta
go
	create table cobis..cl_frm_ente_respuesta
		(
			en_ente           int not null,
			en_respuesta_ente int not null, -- secuencial
			en_formulario  	  int not null,
			en_version        int not null,
			en_pregunta_form  int not null,
			en_respuesta      varchar(255) null,
			en_fecha_registro datetime not null,
			en_usuario        varchar(30) not null
		)
go


	create index IDX_ENT            ON cl_frm_ente_respuesta(en_ente)
go


	create index IDX_ENT_RESPUESTA  ON cl_frm_ente_respuesta(en_respuesta_ente)
go


	create index IDX_ENT_FORMULARIO ON cl_frm_ente_respuesta(en_formulario)
go


	create index IDX_ENT_VERSION    ON cl_frm_ente_respuesta(en_version)
go


	create index IDX_ENTE_PREGUNTA  ON cl_frm_ente_respuesta(en_pregunta_form)
go


	create nonclustered index IDX_FRM_ENTE_RESPUESTA_1 on cl_frm_ente_respuesta(en_ente,en_respuesta_ente,en_formulario,en_version)
go


	create nonclustered index IDX_FRM_ENTE_RESPUESTA_2 on cl_frm_ente_respuesta(en_ente,en_respuesta_ente,en_formulario,en_version,en_pregunta_form)
go


	create nonclustered index IDX_FRM_ENTE_RESPUESTA_3 on cl_frm_ente_respuesta(en_ente,en_formulario,en_version, en_pregunta_form)
go

--- ==========================	cl_frm_ente_resp_tabla

if exists (select 1 from sys.indexes where name = 'IDX_ENTE_RESP_ENTE')
begin	
   drop index IDX_ENTE_RESP_ENTE on cl_frm_ente_resp_tabla
end

if object_id('cl_frm_ente_resp_tabla') is not null 
	drop table cobis..cl_frm_ente_resp_tabla
go
	create table cobis..cl_frm_ente_resp_tabla
		(
			rt_ente      int not null,
         rt_fila        tinyint not null,
			rt_respuesta varchar(254) null,
         rt_formulario int not null,
         rt_version int not null,	
         rt_pregunta_form int not null,
         rt_id_columna int null
		)
go


	create index IDX_ENTE_RESP_ENTE ON cl_frm_ente_resp_tabla(rt_ente)
go

--- ==========================	cl_neg_cliente_prev

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_PREV')
begin	
   drop index IDX_NEGOCIO_PREV on cl_neg_cliente_prev
end

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_ENTE_PREV')
begin	
   drop index IDX_NEGOCIO_ENTE_PREV on cl_neg_cliente_prev
end
if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_DIRE_PREV')
begin	
   drop index IDX_NEGOCIO_DIRE_PREV on cl_neg_cliente_prev
end

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_FORM_PREV')
begin	
   drop index IDX_NEGOCIO_FORM_PREV on cl_neg_cliente_prev
end

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_VERS_PREV')
begin	
   drop index IDX_NEGOCIO_VERS_PREV on cl_neg_cliente_prev
end
if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_INST_PREV')
begin	
   drop index IDX_NEGOCIO_INST_PREV on cl_neg_cliente_prev
end

if object_id('cl_neg_cliente_prev') is not null 
	drop table cobis..cl_neg_cliente_prev
go
	create table cobis..cl_neg_cliente_prev
		(
			nc_negocio       	   int not null,
			nc_ente          	   int not null,
			nc_direccion     	   int null,
			nc_fecha_investigacion datetime not null,
			nc_ingreso       	   money null,
			nc_gasto               money null,
			nc_utilidad            money null,
			nc_calificacion  	   smallint not null,
			nc_estado        	   varchar(60)not null,
			nc_cap_pago      	   money null,
			nc_formulario    	   int not null,
			nc_version       	   int not null,
			nc_inst_proc     	   int null,
			nc_investigador  	   varchar(60) null,
			nc_verificador   	   varchar(60) null,
			CONSTRAINT AK_NEGOCIO_PREV UNIQUE (nc_negocio)
		)

go
	

	create index IDX_NEGOCIO_PREV ON cl_neg_cliente_prev(nc_negocio)
go


	create index IDX_NEGOCIO_ENTE_PREV ON cl_neg_cliente_prev(nc_ente)
go


	create index IDX_NEGOCIO_DIRE_PREV ON cl_neg_cliente_prev(nc_direccion)
go


	create index IDX_NEGOCIO_FORM_PREV ON cl_neg_cliente_prev(nc_formulario)
go


	create index IDX_NEGOCIO_VERS_PREV ON cl_neg_cliente_prev(nc_version)
go


	create index IDX_NEGOCIO_INST_PREV ON cl_neg_cliente_prev(nc_inst_proc)
go

--- ==========================	cl_neg_cliente_his
if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_HIS')
begin	
   drop index IDX_NEGOCIO_HIS on cl_neg_cliente_his
end

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_ENTE_HIS')
begin	
   drop index IDX_NEGOCIO_ENTE_HIS on cl_neg_cliente_his
end

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_DIRE_HIS')
begin	
   drop index IDX_NEGOCIO_DIRE_HIS on cl_neg_cliente_his
end

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_FORM_HIS')
begin	
   drop index IDX_NEGOCIO_FORM_HIS on cl_neg_cliente_his
end

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_VERS_HIS')
begin	
   drop index IDX_NEGOCIO_VERS_HIS on cl_neg_cliente_his
end

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_INST_HIS')
begin	
   drop index IDX_NEGOCIO_INST_HIS on cl_neg_cliente_his
end

if object_id('cl_neg_cliente_his') is not null 
	drop table cobis..cl_neg_cliente_his
go
	create table cobis..cl_neg_cliente_his
		(
			nc_negocio       	   int not null,
			nc_ente          	   int not null,
			nc_direccion     	   int not null,
			nc_fecha_investigacion datetime null,
			nc_ingreso       	   money null,
			nc_gasto               money null,
			nc_utilidad            money null,
			nc_calificacion  	   smallint not null,
			nc_estado        	   varchar(60)not null,
			nc_cap_pago      	   money null,
			nc_formulario    	   int not null,
			nc_version       	   int not null,
			nc_inst_proc     	   int null,
			nc_investigador  	   varchar(60) null,
			nc_verificador   	   varchar(60) null,
			nc_fecha_historico	   datetime not null
			CONSTRAINT AK_NEGOCIO_HIS UNIQUE (nc_negocio)
		)

go
	

	create index IDX_NEGOCIO_HIS ON cl_neg_cliente_his(nc_negocio)
go


	create index IDX_NEGOCIO_ENTE_HIS ON cl_neg_cliente_his(nc_ente)
go


	create index IDX_NEGOCIO_DIRE_HIS ON cl_neg_cliente_his(nc_direccion)
go


	create index IDX_NEGOCIO_FORM_HIS ON cl_neg_cliente_his(nc_formulario)
go


	create index IDX_NEGOCIO_VERS_HIS ON cl_neg_cliente_his(nc_version)
go


	create index IDX_NEGOCIO_INST_HIS ON cl_neg_cliente_his(nc_inst_proc)
go

--- ==========================	cl_neg_cliente

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO')
begin	
   drop index IDX_NEGOCIO on cl_neg_cliente
end

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_ENTE')
begin	
   drop index IDX_NEGOCIO_ENTE on cl_neg_cliente
end

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_DIRE')
begin	
   drop index IDX_NEGOCIO_DIRE on cl_neg_cliente
end

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_FORM')
begin	
   drop index IDX_NEGOCIO_FORM on cl_neg_cliente
end

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_VERS')
begin	
   drop index IDX_NEGOCIO_VERS on cl_neg_cliente
end

if exists (select 1 from sys.indexes where name = 'IDX_NEGOCIO_INST')
begin	
   drop index IDX_NEGOCIO_INST on cl_neg_cliente
end

if object_id('cl_neg_cliente') is not null 
	drop table cobis..cl_neg_cliente
go
	create table cobis..cl_neg_cliente
		(
			nc_negocio       	   int not null,
			nc_ente          	   int not null,
			nc_direccion     	   int not null,
			nc_fecha_investigacion datetime not null,
			nc_ingreso       	   money null,
			nc_gasto               money null,
			nc_utilidad            money null,
			nc_calificacion  	   smallint not null,
			nc_estado        	   varchar(60)not null,
			nc_cap_pago      	   money null,
			nc_formulario    	   int not null,
			nc_version       	   int not null,
			nc_inst_proc     	   int null,
			nc_investigador  	   varchar(60) not null,
			nc_verificador   	   varchar(60) null,
			CONSTRAINT AK_NEGOCIO UNIQUE (nc_negocio)
		)

go
	

	create index IDX_NEGOCIO ON cl_neg_cliente(nc_negocio)
go


	create index IDX_NEGOCIO_ENTE ON cl_neg_cliente(nc_ente)
go


	create index IDX_NEGOCIO_DIRE ON cl_neg_cliente(nc_direccion)
go


	create index IDX_NEGOCIO_FORM ON cl_neg_cliente(nc_formulario)
go


	create index IDX_NEGOCIO_VERS ON cl_neg_cliente(nc_version)
go


	create index IDX_NEGOCIO_INST ON cl_neg_cliente(nc_inst_proc)
go

--- ==========================	cl_frm_catalogo_pregunta

if object_id('cl_frm_catalogo_pregunta') is not null 
	drop table cobis..cl_frm_catalogo_pregunta
go
	create table cobis..cl_frm_catalogo_pregunta
		(
			cp_id_cat_resp      int not null,
			cp_id_form          int not null,
			cp_id_pregunta	    int not null,
			cp_catalogo			int not null,
			cp_codigo			varchar(64)not null,
			cp_valor			varchar(80)not null,
			cp_puntos			int	
		)

go
	
if exists (select 1 from sys.indexes where name = 'IDX_CATALOGO_PREGUNTA')
begin	
   drop index IDX_CATALOGO_PREGUNTA on cl_frm_catalogo_pregunta
end
	create index IDX_CATALOGO_PREGUNTA ON cl_frm_catalogo_pregunta(cp_id_cat_resp)
go
if exists (select 1 from sys.indexes where name = 'IDX_CATALOGO_PREGUNTA_1')
begin	
   drop index IDX_CATALOGO_PREGUNTA_1 on cl_frm_catalogo_pregunta
end
	create index IDX_CATALOGO_PREGUNTA_1 ON cl_frm_catalogo_pregunta(cp_id_form,cp_id_pregunta)
go

if exists (select 1 from sys.indexes where name = 'IDX_CATALOGO_PREGUNTA_2')
begin	
   drop index IDX_CATALOGO_PREGUNTA_2 on cl_frm_catalogo_pregunta
end
create nonclustered index IDX_CATALOGO_PREGUNTA_2 on cl_frm_catalogo_pregunta(cp_id_cat_resp, cp_id_form, cp_id_pregunta)
go   

--- ==========================	cl_frm_ente_respuesta_tmp

if exists (select 1 from sys.indexes where name = 'TMP_ENT')
begin	
   drop index TMP_ENT on cl_frm_ente_respuesta_tmp
end
if exists (select 1 from sys.indexes where name = 'TMP_ENT_RESPUESTA')
begin	
   drop index TMP_ENT_RESPUESTA on cl_frm_ente_respuesta_tmp
end

if exists (select 1 from sys.indexes where name = 'TMP_ENT_FORMULARIO')
begin	
   drop index TMP_ENT_FORMULARIO on cl_frm_ente_respuesta_tmp
end


if exists (select 1 from sys.indexes where name = 'TMP_ENT_VERSION')
begin	
   drop index TMP_ENT_VERSION on cl_frm_ente_respuesta_tmp
end
if exists (select 1 from sys.indexes where name = 'TMP_ENTE_PREGUNTA')
begin	
   drop index TMP_ENTE_PREGUNTA on cl_frm_ente_respuesta_tmp
end

if object_id('cl_frm_ente_respuesta_tmp') is not null 
	drop table cobis..cl_frm_ente_respuesta_tmp
go
		
	create table cl_frm_ente_respuesta_tmp
	(
		en_ente 			int not null,
		en_respuesta_ente 	int not null,
		en_formulario 		int not null,
		en_version 			int not null,
		en_pregunta_form 	int not null,
		en_respuesta 		varchar(255) null,
		en_fecha_registro 	datetime not null,
		en_usuario 			varchar(30) not null
	)

go


	create index TMP_ENT            ON cl_frm_ente_respuesta_tmp(en_ente)
go


	create index TMP_ENT_RESPUESTA  ON cl_frm_ente_respuesta_tmp(en_respuesta_ente)
go

	create index TMP_ENT_FORMULARIO ON cl_frm_ente_respuesta_tmp(en_formulario)
go

	create index TMP_ENT_VERSION    ON cl_frm_ente_respuesta_tmp(en_version)
go


	create index TMP_ENTE_PREGUNTA  ON cl_frm_ente_respuesta_tmp(en_pregunta_form)
go

--- ==========================	cl_frm_ente_resp_tabla_tmp
if exists (select 1 from sys.indexes where name = 'TMP_TB_ENTE')
begin	
   drop index TMP_TB_ENTE   on cl_frm_ente_resp_tabla_tmp
end

if exists (select 1 from sys.indexes where name = 'TMP_TB_FILA')
begin	
   drop index TMP_TB_FILA on cl_frm_ente_resp_tabla_tmp
end
if exists (select 1 from sys.indexes where name = 'TMP_TB_FORM')
begin	
   drop index TMP_TB_FORM on cl_frm_ente_resp_tabla_tmp
end

if exists (select 1 from sys.indexes where name = 'TMP_TB_VERSION')
begin	
   drop index TMP_TB_VERSION on cl_frm_ente_resp_tabla_tmp
end
if exists (select 1 from sys.indexes where name = 'TMP_TB_PREGUNTA')
begin	
   drop index TMP_TB_PREGUNTA on cl_frm_ente_resp_tabla_tmp
end

if object_id('cl_frm_ente_resp_tabla_tmp') is not null 
	drop table cobis..cl_frm_ente_resp_tabla_tmp
go
	
	create table cl_frm_ente_resp_tabla_tmp
	(	
		rt_ente 			int not null,
		rt_fila 			tinyint not null,
		rt_respuesta 		varchar(254) null,
		rt_formulario		int not null,
		rt_version 			int not null,	
		rt_pregunta_form 	int not null,
		rt_id_columna 		int null
	)


	create index TMP_TB_ENTE  ON cl_frm_ente_resp_tabla_tmp(rt_ente)
go

	create index TMP_TB_FILA  ON cl_frm_ente_resp_tabla_tmp(rt_fila)
go


	create index TMP_TB_FORM  ON cl_frm_ente_resp_tabla_tmp(rt_formulario)
go

	create index TMP_TB_VERSION  ON cl_frm_ente_resp_tabla_tmp(rt_version)
go


	create index TMP_TB_PREGUNTA  ON cl_frm_ente_resp_tabla_tmp(rt_pregunta_form)
go

--- ==========================	cl_frm_seccion_ctrl
if exists (select 1 from sys.indexes where name = 'cl_frm_seccion_ctrl_idx1')
begin	
   drop index cl_frm_seccion_ctrl_idx1   on cl_frm_seccion_ctrl
end
if exists (select 1 from sys.indexes where name = 'cl_frm_seccion_ctrl_idx2')
begin	
   drop index cl_frm_seccion_ctrl_idx2   on cl_frm_seccion_ctrl
end

if object_id('cl_frm_seccion_ctrl') is not null 
	drop table cobis..cl_frm_seccion_ctrl
go
		
	create table cl_frm_seccion_ctrl
	(
		sc_id	 			int not null,
		sc_frm_id		 	int not null,
		sc_seccion	 		int not null,
		sc_etapa 			varchar(64) null,
		sc_visible			char(1),
		sc_habilitado		char(1)
	)
	

	create index cl_frm_seccion_ctrl_idx1  ON cl_frm_seccion_ctrl(sc_frm_id)
go

	create index cl_frm_seccion_ctrl_idx2  ON cl_frm_seccion_ctrl(sc_frm_id,sc_seccion)
go
		