/************************************************************************/
/*	Archivo:		    ad_trser.sql				                    */
/*	Base de datos:		cobis					                        */
/*	Producto:		    Admin					                        */
/************************************************************************/
/*				            IMPORTANTE				                    */
/*	Este programa es parte de los paquetes bancarios propiedad de	    */
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	        */
/*	"NCR CORPORATION".						                            */
/*	Su uso no autorizado queda expresamente prohibido asi como	        */
/*	cualquier alteracion o agregado hecho por alguno de sus		        */
/*	usuarios sin el debido consentimiento por escrito de la 	        */
/*	Presidencia Ejecutiva de MACOSA o su representante.		            */
/*				PROPOSITO				                                */
/*	Este script realiza las transacciones de servicio del ADMIN	        */
/*				MODIFICACIONES				                            */
/*	FECHA					AUTOR					RAZON				*/
/*  5/28/2012				DVE             Cambio de tipo de dato      */
/*                                          smallint -> int en campo    */
/*                                          ts_terminal en tabla        */
/*                                          ad_tran_servicio            */
/* 5/31/2012                ITO             Inclusion de la vista       */
/*                                          ts_desbloqueo_func          */
/* 2/24/2015                LMA             Inclusion de la vista       */
/* 2/24/2015                JGU             Inc.campos ad_tran_servicio */
/*                                          y vista ts_oficina          */
/* 12/04/2016               BBO             Migracion SYBASE-SQLServer FAL*/
/* 06/06/2016               RAL             Cambios oficina version BMI */
/* 24/06/2016               J.Hernandez     Ajuste Vesion Falabella     */
/*                                          cambio tipo de  dato nodo   */
/************************************************************************/

use cobis
go


/* ad_tran_servicio */
print '=====> ad_tran_servicio'
go
if exists(select name from sysobjects where name = 'ad_tran_servicio')
	drop table ad_tran_servicio
go

CREATE TABLE ad_tran_servicio (
	ts_tipo_transaccion		int             NOT NULL,
	ts_secuencia			int             NOT NULL,
	ts_clase			    char(1)         NOT NULL,
	ts_fecha			    datetime        NOT NULL,
    ts_ofi                  smallint        NULL, /*NOT NULL*/          
    ts_user                 login           NULL, /*NOT NULL*/              
    ts_term                 varchar(32)     NULL, /*NOT NULL*/          
    ts_srv                  varchar(30)     NULL, /*NOT NULL*/          
    ts_lsrv                 varchar(30)     NULL, /*NOT NULL*/          
	ts_severidad			int             NULL,
	ts_mensaje			    varchar (255)   null,
	ts_filial			    tinyint         NULL,
	ts_oficina			    smallint        NULL,
	ts_nodo				    smallint         NULL,
	ts_protocolo			char (1)        NULL,
	ts_tlink			    char (1)        NULL,
	ts_link				    tinyint         NULL,
	ts_secuencial			tinyint         NULL,
	ts_nombre			    descripcion     NULL,
	ts_nombre_ter			varchar(32)     NULL,
	ts_direccion			varchar (30)    NULL,
	ts_subdireccion			varchar (30)    NULL,
	ts_estado			    estado          NULL,
	ts_fecha_ult_mod		datetime        NULL,
	ts_base				    char (30)       NULL,
	ts_tamanio			    smallint        NULL,
	ts_fecha_reg			datetime        NULL,
	ts_registrador			smallint        NULL,
	ts_fecha_mod			datetime        NULL,
	ts_modificador			smallint        NULL,
	ts_autorizante			smallint        NULL,
	ts_horario			    tinyint         NULL,
	ts_tipo_horario			tinyint         NULL,
	ts_dia				    char (2)        NULL,
	ts_hr_inicio			datetime        NULL,
	ts_hr_fin			    datetime        NULL,
	ts_fecha_crea			datetime        NULL,
	ts_creador			    smallint        NULL,
	ts_25				    char(1)         NULL,
	ts_tcpip			    char(1)         NULL,
	ts_tipo				    char (1)        NULL,
	ts_descripcion			descripcion     NULL,
	ts_marca			    varchar (20)    NULL,
	ts_modelo			    varchar (20)    NULL,
	ts_num_serie			varchar (20)    NULL,
	ts_fecha_habil			datetime        NULL,
	ts_habilitante			smallint        NULL,
	ts_sis_operativo		tinyint         NULL,
	ts_terminal			    int             NULL, --DVE 5/28/2012
	ts_rol				    tinyint         NULL,
	ts_producto			    tinyint         NULL,
	ts_moneda			    tinyint         NULL,
	ts_procedure			int             NULL,
	ts_stored_procedure		varchar(30)     NULL,
	ts_base_datos			varchar(30)     NULL,
	ts_archivo			    varchar(14)     NULL,
	ts_transaccion			int             NULL,
	ts_nemonico			    char(4)         NULL,
	ts_desc_larga			varchar(255)    NULL,
	ts_filial_d			    tinyint         NULL,
	ts_oficina_d			smallint        NULL,
	ts_nodo_d			   smallint         NULL,
	ts_filial_h			    tinyint         NULL,
	ts_oficina_h			smallint        NULL,
	ts_nodo_h			   smallint         NULL,
	ts_nombre_f_d			descripcion     NULL,
	ts_nombre_o_d			descripcion     NULL,
	ts_nombre_n_d			descripcion     NULL,
	ts_nombre_f_h			descripcion     NULL,
	ts_nombre_o_h			descripcion     NULL,
	ts_nombre_n_h			descripcion     NULL,
	ts_prioridad			char(1)         NULL,
	ts_filial_p			    tinyint         NULL,
	ts_oficina_p			smallint        NULL,
	ts_nodo_p			   smallint         NULL,
	ts_filial_a			    tinyint         NULL,
	ts_oficina_a			smallint        NULL,
	ts_nodo_a			   smallint         NULL,
	ts_nombre_f_p			descripcion     NULL,
	ts_nombre_o_p			descripcion     NULL,
	ts_nombre_n_p			descripcion     NULL,
	ts_nombre_f_a			descripcion     NULL,
	ts_nombre_o_a			descripcion     NULL,
	ts_nombre_n_a			descripcion     NULL,
	ts_filial_i			    tinyint	        NULL,
	ts_oficina_i			smallint        NULL,
	ts_nodo_i			   smallint         NULL,
	ts_nombre_f_i			descripcion     NULL,
	ts_nombre_o_i			descripcion     NULL,
	ts_nombre_n_i			descripcion     NULL,
	ts_version			    varchar (12)    NULL,
	ts_release			    varchar (12)    NULL,
	ts_propietario			descripcion     NULL,
	ts_tipo_link			char (1)        NULL,
	ts_login			    varchar(30)     NULL,
	ts_fecha_asig			datetime        NULL,
	ts_clave			    varchar (30)    NULL,
	ts_fecha_aut			datetime        NULL,
    ts_parametro            descripcion     NULL,
    ts_nemon                char(3)         NULL,
    ts_char                 varchar(30)     NULL,
    ts_tinyint              tinyint         NULL,
    ts_smallint             smallint        NULL,
    ts_int                  int             NULL,
    ts_money                money           NULL,
    ts_money2      			money           null,
    ts_money3      			money           null,
    ts_money4      			money           null,
    ts_datetime             datetime        NULL,
    ts_float                float           NULL,
	ts_tabla			    descripcion     NULL,
	ts_plazo			    smallint        NULL,
	ts_codigocat			char(10)        NULL,
	ts_zona				    char(3)         NULL,
	ts_costo			    money           NULL,
	ts_reg_nat			    char(2)         NULL,
	ts_reg_ope			    char(2)         NULL,
	ts_direc			    direccion       NULL,
	ts_numero			    numero          NULL,
	ts_nemdef			    char(6)         NULL,
	ts_sexo				    sexo            NULL,
	ts_offset 			    varbinary(32)   NULL,	-- ARO:23/01/2001  CRYPWD
    ts_regional             varchar(10)     NULL,
    ts_tip_punt_at          varchar(10)     NULL,
    ts_obs_horario          varchar(120)    NULL,
    ts_cir_comunic          varchar(10)     NULL,
    ts_nomb_encarg          varchar(64)     NULL,
    ts_ci_encarg            varchar(20)     NULL,
    ts_tipo_horar           varchar(10)     NULL,
    ts_jefe_agenc           int             NULL,
    ts_cod_fie_asf          varchar(10)     NULL,
    ts_fec_aut_asf          datetime        NULL,
    ts_sector               varchar(10)     NULL,
    ts_funcionar            smallint        NULL,
    ts_depart_pais          catalogo        NULL,
    ts_provincia            int             NULL,
    -- GEOREFERENCIACION
    ts_lat_coord            char(1)         NULL,
    ts_lat_grad             float         NULL,
    ts_lat_min              float         NULL,
    ts_lat_seg              float         NULL,
    ts_long_coord           char(1)         NULL,
    ts_long_grad            float         NULL,
    ts_long_min             float         NULL,
    ts_long_seg             float         NULL,
    ts_ambito_sec           int             NULL,
    ts_ambito_cargo         varchar(10)     NULL,
    ts_ambito_tipo_amb      varchar(10)     NULL,
    ts_ambito_amb           varchar(10)     NULL,
    ts_ambito_est           varchar(1)      NULL,  
    ts_ambito_tmp_user      login           NULL,
    ts_ambito_tmp_ssn       int             NULL,
    ts_ambito_tmp_ofi       smallint        NULL,
    ts_ambito_tmp_fecha     datetime        NULL,
    ts_reg_ambito_sec	    int             NULL,
	ts_subregional          varchar(10)     NULL, 
	ts_fu_cedula            varchar(13)     NULL,
	ts_fu_causa_bloqueo     catalogo        NULL
	
)
go


/************************************************************************/
/* 'Vistas */
print '=====> Vistas de la transaccion de servicio '
go

/* ts_x25_config */
print '=====> ts_x25_config'
go

CREATE view ts_x25_config (
	      secuencia, tipo_transaccion, clase, fecha,
	      oficina_s, usuario, terminal_s, srv, lsrv,
	      filial, oficina, nodo, protocolo, tlink,
	      link, secuencial, nombre, direccion,
	      subdireccion, estado, fecha_ult_mod)
as
	select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
	       ts_filial, ts_oficina, ts_nodo, ts_protocolo, ts_tlink,
	       ts_link, ts_secuencial, ts_nombre, ts_direccion,
	       ts_subdireccion, ts_estado, ts_fecha_ult_mod
	  from ad_tran_servicio
	 where ts_tipo_transaccion = 501
	    or ts_tipo_transaccion = 502
	    or ts_tipo_transaccion = 503
go


/* ts_base_datos */
print '=====> ts_base_datos'
go

CREATE VIEW ts_base_datos (
	       secuencia, tipo_transaccion, clase, fecha,
	       oficina_s, usuario, terminal_s, srv, lsrv,
	       filial, oficina, nodo, base,
	       tamanio, fecha_reg, registrador, fecha_mod,
	       modificador, estado, fecha_ult_mod)
as
	select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
	       ts_filial, ts_oficina, ts_nodo, ts_base,
	       ts_tamanio, ts_fecha_reg, ts_registrador, ts_fecha_mod,
	       ts_modificador, ts_estado, ts_fecha_ult_mod
	  from ad_tran_servicio
	 where ts_tipo_transaccion = 504
	    or ts_tipo_transaccion = 505
	    or ts_tipo_transaccion = 506
go


/* ts_horario */
print '=====> ts_horario'
go

CREATE VIEW ts_horario (
	     secuencia, tipo_transaccion, clase, fecha,
	     oficina_s, usuario, terminal_s, srv, lsrv,
	     horario, tipo_horario, secuencial, dia,
	     hr_inicio, hr_fin, fecha_crea, creador,
             estado, fecha_ult_mod)
as
	select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
	       ts_horario, ts_tipo_horario, ts_secuencial, ts_dia,
	       ts_hr_inicio, ts_hr_fin, ts_fecha_crea, ts_creador, 
	       ts_estado, ts_fecha_ult_mod
	  from ad_tran_servicio
	 where ts_tipo_transaccion = 507
	    or ts_tipo_transaccion = 508
	    or ts_tipo_transaccion = 509
go


/* ts_x25 */
print '=====> ts_x25'
go

CREATE VIEW ts_x25 (
	     secuencia, tipo_transaccion, clase, fecha,
	     oficina_s, usuario, terminal_s, srv, lsrv,
	     filial, oficina, nodo, x25, tlink,
	     link, estado, fecha_ult_mod)
as
      select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	     ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
	     ts_filial, ts_oficina, ts_nodo, ts_25, ts_tlink,
	     ts_link, ts_estado, ts_fecha_ult_mod
	from ad_tran_servicio
       where ts_tipo_transaccion = 510
	  or ts_tipo_transaccion = 511
	  or ts_tipo_transaccion = 512
go


/* ts_tcpip */
print '=====> ts_tcpip'
go

CREATE	VIEW ts_tcpip (
	     secuencia, tipo_transaccion, clase, fecha,
	     oficina_s, usuario, terminal_s, srv, lsrv,
	     filial, oficina, nodo, tcpip, tlink,
	     link, estado, fecha_ult_mod
)as
      select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	     ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
	     ts_filial, ts_oficina, ts_nodo, ts_tcpip, ts_tlink,
	     ts_link, ts_estado, ts_fecha_ult_mod
	from ad_tran_servicio
       where ts_tipo_transaccion = 513
	  or ts_tipo_transaccion = 514
	  or ts_tipo_transaccion = 515
go

/* ts_link */
print '=====> ts_link'
go

CREATE VIEW ts_link (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	filial, oficina, nodo, tipo, link,
	descripcion, estado, fecha_ult_mod
)
as
  select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	 ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
	 ts_filial, ts_oficina, ts_nodo, ts_tipo, ts_link,
	 ts_descripcion, ts_estado, ts_fecha_ult_mod
    from ad_tran_servicio
   where ts_tipo_transaccion = 516
      or ts_tipo_transaccion = 517
      or ts_tipo_transaccion = 518
go

/* ts_nodo */
print '=====> ts_nodo'
go

CREATE VIEW ts_nodo (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	nodo, marca, modelo, tipo, num_serie, fecha_reg,
	fecha_habil, registrador, habilitante, estado, fecha_ult_mod
)
as
  select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	 ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
	 ts_nodo, ts_marca, ts_modelo, ts_archivo, ts_num_serie, ts_fecha_reg,
	 ts_fecha_habil, ts_registrador, ts_habilitante, ts_estado,
	 ts_fecha_ult_mod
    from ad_tran_servicio
   where ts_tipo_transaccion = 519
      or ts_tipo_transaccion = 520
      or ts_tipo_transaccion = 521
go


/* ts_nodo_oficina */
print '=====> ts_nodo_oficina'
go

CREATE VIEW ts_nodo_oficina (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	filial, oficina, nodo, sis_operativo, nombre,
	fecha_reg, registrador, fecha_habil, habilitante,
	terminal, estado, secuencial, fecha_ult_mod
)
as
  select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	 ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
	 ts_filial, ts_oficina, ts_nodo, ts_sis_operativo, ts_nombre,
	 ts_fecha_reg, ts_registrador, ts_fecha_habil, ts_habilitante,
	 ts_terminal, ts_estado, ts_secuencial, ts_fecha_ult_mod
    from ad_tran_servicio
   where ts_tipo_transaccion = 522
      or ts_tipo_transaccion = 523
      or ts_tipo_transaccion = 524
go


/* ts_pro_rol */
print '=====> ts_pro_rol'
go

CREATE VIEW ts_pro_rol (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	rol, producto, tipo, moneda, fecha_crea,
	autorizante, estado, fecha_ult_mod
)
as
  select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	 ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
	 ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_crea,
	 ts_autorizante, ts_estado, ts_fecha_ult_mod
    from ad_tran_servicio
   where ts_tipo_transaccion = 525
      or ts_tipo_transaccion = 526
      or ts_tipo_transaccion = 527
go

/* ts_procedure */
print '=====> ts_procedure'
go

CREATE VIEW ts_procedure (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	pprocedure, stored_procedure, base_datos,
	estado, fecha_ult_mod, archivo
)
as
  select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	 ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
	 ts_procedure, ts_stored_procedure, ts_base_datos,
	 ts_estado, ts_fecha_ult_mod, ts_archivo
    from ad_tran_servicio
   where ts_tipo_transaccion = 528
      or ts_tipo_transaccion = 529
      or ts_tipo_transaccion = 530
go

/* ts_protocolo */
print '=====> ts_protocolo'
go

CREATE VIEW ts_protocolo (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	protocolo, descripcion, estado, fecha_ult_mod
)
as
  select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	 ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
	 ts_protocolo, ts_descripcion, ts_estado, ts_fecha_ult_mod
    from ad_tran_servicio
   where ts_tipo_transaccion = 531
      or ts_tipo_transaccion = 532
      or ts_tipo_transaccion = 533
go

/* ts_pro_transaccion */
print '=====> ts_pro_transaccion'
go

CREATE VIEW ts_pro_transaccion (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	producto, tipo, moneda, transaccion,
	estado, fecha_ult_mod, procedimiento
)
as
  select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	 ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
	 ts_producto, ts_tipo, ts_moneda, ts_transaccion,
	 ts_estado, ts_fecha_ult_mod, ts_procedure
    from ad_tran_servicio
   where ts_tipo_transaccion = 534
      or ts_tipo_transaccion = 535
      or ts_tipo_transaccion = 536
go


/* ts_procedure_tran */
print '=====> ts_procedure_tran'
go

CREATE VIEW ts_procedure_tran (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	producto, tipo, moneda, transaccion, pprocedure,
	estado, fecha_ult_mod
)
as
  select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	 ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
	 ts_producto, ts_tipo, ts_moneda, ts_transaccion, ts_procedure,
	 ts_estado, ts_fecha_ult_mod
    from ad_tran_servicio
   where ts_tipo_transaccion = 537
      or ts_tipo_transaccion = 538
      or ts_tipo_transaccion = 539
go


/* ad_rol */
print '=====> ts_ad_rol'
go

CREATE VIEW ts_ad_rol (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	rol, filial, descripcion, fecha_crea, creador,
	estado, fecha_ult_mod, time_out,admin_seg,departamento, oficina
)
as
  select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	 ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
	 ts_rol, ts_filial, ts_descripcion, ts_fecha_crea, ts_creador,
	 ts_estado, ts_fecha_ult_mod, ts_modificador, ts_nombre_ter, ts_tamanio, ts_horario
    from ad_tran_servicio
   where ts_tipo_transaccion = 540
      or ts_tipo_transaccion = 541
      or ts_tipo_transaccion = 542
go

/* ts_directa */
print '=====> ts_directa'
go

CREATE VIEW ts_directa (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	filial_d, oficina_d, nodo_d, filial_h, oficina_h,
	nodo_h, protocolo, tlink, link, secuencial,
	prioridad, nombre_f_d, nombre_o_d, nombre_n_d,
	nombre_f_h, nombre_o_h, nombre_n_h,
	estado, fecha_ult_mod
)
as
  select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	 ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
	 ts_filial_d, ts_oficina_d, ts_nodo_d, ts_filial_h, ts_oficina_h,
	 ts_nodo_h, ts_protocolo, ts_tlink, ts_link, ts_secuencial,
	 ts_prioridad, ts_nombre_f_d, ts_nombre_o_d, ts_nombre_n_d,
	 ts_nombre_f_h, ts_nombre_o_h, ts_nombre_n_h,
	 ts_estado, ts_fecha_ult_mod
    from ad_tran_servicio
   where ts_tipo_transaccion = 543
      or ts_tipo_transaccion = 544
      or ts_tipo_transaccion = 545
go

/* ts_indirecta */
print '=====> ts_indirecta'
go

CREATE VIEW ts_indirecta (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	filial_d, oficina_d, nodo_d, filial_h,
	oficina_h, nodo_h, filial_p, oficina_p,
	nodo_p, filial_a, oficina_a, nodo_a, nombre_f_d,
	nombre_o_d, nombre_n_d, nombre_f_h, nombre_o_h,
	nombre_n_h, nombre_f_p, nombre_o_p, nombre_n_p,
	nombre_f_a, nombre_o_a, nombre_n_a, estado,
	fecha_ult_mod
)
as
  select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	 ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
	 ts_filial_d, ts_oficina_d, ts_nodo_d, ts_filial_h,
	 ts_oficina_h, ts_nodo_h, ts_filial_p, ts_oficina_p,
	 ts_nodo_p, ts_filial_a, ts_oficina_a, ts_nodo_a, ts_nombre_f_d,
	 ts_nombre_o_d, ts_nombre_n_d, ts_nombre_f_h, ts_nombre_o_h,
	 ts_nombre_n_h, ts_nombre_f_p, ts_nombre_o_p, ts_nombre_n_p,
	 ts_nombre_f_a, ts_nombre_o_a, ts_nombre_n_a, ts_estado,
	 ts_fecha_ult_mod
    from ad_tran_servicio
   where ts_tipo_transaccion = 546
      or ts_tipo_transaccion = 547
      or ts_tipo_transaccion = 548
go


/* ts_server_logico */
print '=====> ts_server_logico'
go

CREATE VIEW ts_server_logico (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	filial_i, oficina_i, nodo_i, filial_p, oficina_p,
	producto, tipo, moneda, fecha_reg, registrador,
	estado, fecha_ult_mod
)
as
  select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	 ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
	 ts_filial_i, ts_oficina_i, ts_nodo_i, ts_filial_p, ts_oficina_p,
	 ts_producto, ts_tipo, ts_moneda, ts_fecha_reg, ts_registrador,
	 ts_estado, ts_fecha_ult_mod
    from ad_tran_servicio
   where ts_tipo_transaccion = 549
      or ts_tipo_transaccion = 550
      or ts_tipo_transaccion = 551
go


/* ts_sis_operativo */
print '=====> ts_sis_operativo'
go

CREATE VIEW ts_sis_operativo (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	sis_operativo, descripcion, version, release,
	propietario, estado, fecha_ult_mod
)
as
  select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	 ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
	 ts_sis_operativo, ts_descripcion, ts_version, ts_release,
	 ts_propietario, ts_estado, ts_fecha_ult_mod
    from ad_tran_servicio
   where ts_tipo_transaccion = 552
      or ts_tipo_transaccion = 553
      or ts_tipo_transaccion = 554
go

/* ts_terminal */
print '=====> ts_terminal'
go

CREATE VIEW ts_terminal (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	filial, oficina, nodo, terminal, nombre, marca, tipo,
	modelo, fecha_reg, registrador, fecha_habil,
	habilitante, estado, fecha_ult_mod
)
as
  select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	 ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
	 ts_filial, ts_oficina, ts_nodo, ts_terminal, ts_nombre_ter, ts_marca, ts_tipo,
	 ts_modelo, ts_fecha_reg, ts_registrador, ts_fecha_habil,
	 ts_habilitante, ts_estado, ts_fecha_ult_mod
    from ad_tran_servicio
   where ts_tipo_transaccion = 555
      or ts_tipo_transaccion = 556
      or ts_tipo_transaccion = 557
go


/* ts_tlink */
print '=====> ts_tlink'
go

CREATE VIEW ts_tlink (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	tipo_link, descripcion, estado, fecha_ult_mod
)
as
  select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	 ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
	 ts_tipo_link, ts_descripcion, ts_estado, ts_fecha_ult_mod
    from ad_tran_servicio
   where ts_tipo_transaccion = 558
      or ts_tipo_transaccion = 559
      or ts_tipo_transaccion = 560
go

/* ts_transaccion */
print '=====> ts_transaccion'
go

CREATE VIEW ts_transaccion (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	transaccion, descripcion, nemonico, desc_larga,
	tipo_ejec, graba_log, off_line, tipo		--ADU: 2002-05-09
)
as
  select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	 ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
	 ts_transaccion, ts_descripcion, ts_archivo, ts_desc_larga,
	 ts_version, ts_prioridad, ts_tipo, ts_nombre_ter	--ADU: 2002-05-09
    from ad_tran_servicio
   where ts_tipo_transaccion = 561
      or ts_tipo_transaccion = 562
      or ts_tipo_transaccion = 563
go

/* ts_tr_autorizada */
print '=====> ts_tr_autorizada'
go

CREATE VIEW ts_tr_autorizada (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	producto, tipo, moneda, transaccion, rol,
	fecha_aut, autorizante, estado, fecha_ult_mod
)
as
  select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	 ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
	 ts_producto, ts_tipo, ts_moneda, ts_transaccion, ts_rol,
	 ts_fecha_aut, ts_autorizante, ts_estado, ts_fecha_ult_mod
    from ad_tran_servicio
   where ts_tipo_transaccion = 564
      or ts_tipo_transaccion = 565
      or ts_tipo_transaccion = 566
go


/* ts_usuario */
print '=====> ts_usuario'
go

CREATE VIEW ts_usuario (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	filial, oficina, nodo, login, fecha_asig,
	creador, estado, fecha_ult_mod, completo,
	fecha_ult_pwd
)
as
  select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	 ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
	 ts_filial, ts_oficina, ts_nodo, ts_login, ts_fecha_asig,
	 ts_creador, ts_estado,
         ts_fecha_ult_mod, ts_tipo, ts_fecha_aut
    from ad_tran_servicio
   where ts_tipo_transaccion = 567
      or ts_tipo_transaccion = 568
      or ts_tipo_transaccion = 569
go


/* ts_usuario_rol */
print '=====> ts_usuario_rol'
go


CREATE VIEW ts_usuario_rol (
	     secuencia,      tipo_transaccion,    clase,            fecha,
	     oficina_s,      usuario,             terminal_s,       srv,            lsrv,
	     login,          rol,                 tipo_horario,     fecha_aut,
	     autorizante,    estado,              fecha_ult_mod,    fecha_ini_rol,  fecha_cad_rol
)
as
  select ts_secuencia,   ts_tipo_transaccion, ts_clase,         ts_fecha,
	     ts_ofi,         ts_user,             ts_term,          ts_srv,         ts_lsrv,
	     ts_login,       ts_rol,              ts_tipo_horario,  ts_fecha_aut,
	     ts_autorizante, ts_estado,           ts_fecha_ult_mod, ts_hr_inicio,   ts_hr_fin

    from ad_tran_servicio
   where ts_tipo_transaccion in (570, 571, 572)
go


/* ts_parametro */
print '=====> ts_parametro'
go

CREATE VIEW ts_parametro (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
        parametro, nemonico, tipo, pa_char, pa_tinyint, pa_smallint, 
        pa_int, pa_money, pa_datetime, pa_float, producto
)
as
  select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	 ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
         ts_parametro, ts_nemonico, ts_tipo, ts_char, ts_tinyint, ts_smallint, 
         ts_int, ts_money, ts_datetime, ts_float, ts_nemon
    from ad_tran_servicio
   where ts_tipo_transaccion = 576 
      or ts_tipo_transaccion = 577 
go

/* ts_tipo_horario */
print '=====> ts_tipo_horario'
go

CREATE VIEW ts_tipo_horario (
	     secuencia, tipo_transaccion, clase, fecha,
	     oficina_s, usuario, terminal_s, srv, lsrv,
	     tipo, descripcion, ult_secuencial, creador,
             estado, fecha_ult_mod)
as
	select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
	       ts_tipo_horario, ts_descripcion, ts_secuencial, ts_creador, 
	       ts_estado, ts_fecha_ult_mod
	  from ad_tran_servicio
	 where ts_tipo_transaccion = 578
	    or ts_tipo_transaccion = 579
	    or ts_tipo_transaccion = 580
go


/* 'ts_val_tran' */
print '=====> ts_val_tran'
go

CREATE VIEW ts_val_tran (
                secuencia, tipo_transaccion, clase, fecha,
	        oficina_s, usuario, terminal_s, srv, lsrv,
		producto, tipo, moneda, transaccion,
		defa, va_int, va_smallint, va_float, va_money,
		categoria
) as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_producto, ts_tipo, ts_moneda, ts_transaccion,
       ts_nemonico, ts_int, ts_smallint, ts_float, ts_money,
       ts_prioridad
from   ad_tran_servicio
where  ts_tipo_transaccion = 593 
go

/* ts_vigencia */
print '=====> ts_vigencia'
go

CREATE VIEW ts_vigencia (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
        tabla, plazo
)
as
  select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	 ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
         ts_tabla, ts_plazo
    from ad_tran_servicio
   where ts_tipo_transaccion = 581 
      or ts_tipo_transaccion = 582 
      or ts_tipo_transaccion = 583 
go


/* ts_cat_prod */
print '=====> ts_cat_prod'
go

CREATE VIEW ts_cat_prod (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	producto,tabla
)
as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_nemon, ts_smallint
from   ad_tran_servicio
where  ts_tipo_transaccion = 586
or     ts_tipo_transaccion = 587
go


/* ts_catalogo */
print '=====> ts_catalogo'
go

CREATE VIEW ts_catalogo (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	tabla, codigo, valor, estado
)
as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_smallint, ts_codigocat, ts_descripcion, ts_estado
from   ad_tran_servicio
where  ts_tipo_transaccion = 584
or     ts_tipo_transaccion = 585
go


/* ts_pais */
print '=====> ts_pais'
go

CREATE VIEW ts_pais (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	pais, descripcion, abreviatura, nacionalidad, estado,
        continente
)
as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_smallint, ts_descripcion, ts_nemon, ts_parametro, ts_estado,
       ts_zona
from   ad_tran_servicio
where  ts_tipo_transaccion = 1515
or     ts_tipo_transaccion = 1516
go


/* ts_ciudad */
print '=====> ts_ciudad'
go

CREATE VIEW ts_ciudad (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	ciudad, descripcion, provincia, pais, estado, canton
)
as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_int, ts_descripcion, ts_procedure, ts_tamanio, ts_estado, ts_transaccion
from   ad_tran_servicio
where  ts_tipo_transaccion = 588 
or     ts_tipo_transaccion = 589
go


/* ts_moneda */
print '=====> ts_moneda'
go

CREATE VIEW ts_moneda (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	moneda, descripcion, pais, estado, decimales, simbolo, 
	mo_cod_ctaunico
)
as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_tinyint, ts_descripcion, ts_smallint, ts_estado, ts_prioridad,
       ts_nombre_ter, ts_protocolo
from   ad_tran_servicio
where  ts_tipo_transaccion = 1511
or     ts_tipo_transaccion = 1512
go


/* ts_rol */
print '=====> ts_rol'
go

CREATE VIEW ts_rol (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	rol, descripcion, estado
)
as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_prioridad, ts_descripcion, ts_estado
from   ad_tran_servicio
where  ts_tipo_transaccion = 540
or     ts_tipo_transaccion = 541
or     ts_tipo_transaccion = 542
go


/* ts_producto */
print '=====> ts_producto'
go

CREATE VIEW ts_producto (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	producto, descripcion, abreviatura, fecha_apertura, estado,
	tipo, saldo_minimo, costo
)
as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_smallint, ts_descripcion, ts_nemon, ts_fecha_crea, ts_estado,
       ts_prioridad, ts_money, ts_costo
from   ad_tran_servicio
where  ts_tipo_transaccion = 1519
or     ts_tipo_transaccion = 1520
go

/* ts_provincia */
print '=====> ts_provincia'
go

CREATE VIEW ts_provincia (
       secuencia,    tipo_transaccion,      clase,       fecha,
       oficina_s,    usuario,               terminal_s,  srv, 
       lsrv,         hora,                  provincia,   descripcion, 
       region_nat,   region_ope,            pais,        estado, 
       departamento
)
as
select ts_secuencia, ts_tipo_transaccion,   ts_clase,    ts_fecha,
       ts_ofi,       ts_user,               ts_term,     ts_srv, 
       ts_lsrv,      ts_fecha_ult_mod,      ts_smallint, ts_descripcion,
       ts_reg_nat,   ts_reg_ope,            ts_procedure,ts_estado, 
       ts_direccion
from   ad_tran_servicio
where  ts_tipo_transaccion = 1526
or     ts_tipo_transaccion = 1527
go

/* ts_parroquia */
print '=====> ts_parroquia'
go

CREATE VIEW ts_parroquia (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	parroquia, descripcion, tipo, ciudad, zona, estado
)
as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_int, ts_descripcion, ts_prioridad, ts_procedure, ts_zona,
       ts_estado

from   ad_tran_servicio
where  ts_tipo_transaccion = 1528  
or     ts_tipo_transaccion = 1529 
go


/* ts_pro_moneda */
print '=====> ts_pro_moneda'
go

CREATE VIEW ts_pro_moneda (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	producto, moneda, descripcion, fecha_aper,
	tipo, estado
)
as
 select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_int, ts_smallint, ts_descripcion, ts_fecha_crea,
       ts_tipo, ts_estado
from   ad_tran_servicio
where  ts_tipo_transaccion = 1524
or     ts_tipo_transaccion = 1525
go


/* ts_pro_oficina */
print '=====> ts_pro_oficina'
go

CREATE VIEW ts_pro_oficina (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	filial, oficina, producto, moneda,
	monto, fecha_aper, pro_mon, tipo
)
as
 select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_filial, ts_oficina, ts_int, ts_tinyint,
       ts_money, ts_fecha_crea, ts_producto, ts_prioridad
from   ad_tran_servicio
where  ts_tipo_transaccion = 1521
or     ts_tipo_transaccion = 1522
or     ts_tipo_transaccion = 1523
go


/* ts_pro_asociado */
print '=====> ts_pro_asociado'
go

CREATE VIEW ts_pro_asociado (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	base, btipo, asociado, atipo, fecha_reg, tipo
)
as
 select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
        ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
	ts_oficina, ts_prioridad, ts_int, ts_codigocat, ts_fecha_crea, ts_tipo
from   ad_tran_servicio
where  ts_tipo_transaccion = 1517 
or     ts_tipo_transaccion = 1518 
go


/* 'ts_def_tran' */
print '=====> ts_def_tran'
go

CREATE VIEW ts_def_tran (
                secuencia, tipo_transaccion, clase, fecha,
	        oficina_s, usuario, terminal_s, srv, lsrv,
                nemonico,descripcion, tdato
) as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_nemdef, ts_descripcion, ts_tabla
from   ad_tran_servicio
where  ts_tipo_transaccion = 593 
go

/* 'ts_distributivo' */
print '=====> ts_distributivo'
go

CREATE VIEW ts_distributivo (
                secuencia, tipo_transaccion, clase, fecha,
	        oficina_s, usuario, terminal_s, srv, lsrv,
                filial, oficina, departamento,
		cargo, secuencia_d, fecha_reg, estado, numero,
		vacante
) as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_filial, ts_oficina, ts_smallint,
       ts_procedure, ts_int, ts_fecha_crea, ts_estado, ts_tinyint,
       ts_tipo
from   ad_tran_servicio
where  ts_tipo_transaccion = 593 
go


/* ts_departamento */
print '=====> ts_departamento'
go

CREATE VIEW ts_departamento (secuencia, tipo_transaccion, clase, fecha,
	                     oficina_s, usuario, terminal_s, srv, lsrv,
                             departamento, filial, oficina,
                             descripcion, o_departamento, o_oficina, nivel) as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_smallint, ts_filial, ts_oficina,
       ts_descripcion, ts_procedure, ts_oficina_h, ts_tinyint
from   ad_tran_servicio
where  ts_tipo_transaccion = 591 
or     ts_tipo_transaccion = 592 
or     ts_tipo_transaccion = 592 
go


/* 'ts_oficina' */
print '=====> ts_oficina'
go

CREATE VIEW ts_oficina (
   secuencia,        tipo_transaccion,   clase,          fecha,             oficina_s,
   usuario,            terminal_s,     srv,              lsrv,             hora,
   filial,             oficina,        nombre,           direccion,        ciudad,
   telefono,           subtipo,        sucursal,         area,             regional,
   tipo_punto,         obs_horario,    circular_comun,   nombre_enc,       ci_encargado,
   horario,            tipo_horario,   jefe_agencia,     cod_fie_asfi,     fecha_aut_asfi,
   sector,             depart_pais,    provincia,        relacion_ofic,    sub_regional,
   barrio,             zona,           of_cob)--ADMIN CC0009 barrio   --RAL 06.06.2016 modificaciones en oficina version BMI
as
select ts_secuencia,    ts_tipo_transaccion,   ts_clase,         ts_fecha,         ts_ofi,
      ts_user,          ts_term,               ts_srv,           ts_lsrv,          ts_fecha_ult_mod,
      ts_filial,        ts_oficina,            ts_descripcion,   ts_direc,         ts_money,
      ts_int,           ts_tipo,               ts_procedure,     ts_char,          ts_oficina_p,   --RAL 06.06.2016 modificaciones en oficina version BMI
      ts_tip_punt_at,   ts_obs_horario,        ts_cir_comunic,   ts_nomb_encarg,   ts_ci_encarg,
      ts_horario,       ts_tipo_horar,         ts_jefe_agenc,    ts_cod_fie_asf,   ts_fec_aut_asf,
      ts_sector,        ts_depart_pais,        ts_provincia,     ts_tamanio,       ts_subregional,
	  ts_ambito_sec,    ts_oficina_a,          ts_oficina_i--ADMIN CC0009 barrio   --RAL 06.06.2016 modificaciones en oficina version BMI
from   ad_tran_servicio
where  ts_tipo_transaccion = 1513 
or     ts_tipo_transaccion = 1514 
go

/* 'ts_oficina_geo' */
print '=====> ts_oficina_geo'
go

CREATE VIEW ts_oficina_geo (
                            secuencia,       tipo_transaccion,    clase,            fecha,
                            oficina_s,       usuario,             terminal_s,       srv, 
                            lsrv,            hora,                oficina,          filial,
                            latitud_coord,   latitud_grados,      latitud_minutos,  latitud_segundos,
                            longitud_coord,  longitud_grados,     longitud_minutos, longitud_segundos)
                 as select  ts_secuencia,    ts_tipo_transaccion, ts_clase,         ts_fecha,
                            ts_ofi,          ts_user,             ts_term,          ts_srv,
                            ts_lsrv,         ts_fecha_ult_mod,    ts_oficina,       ts_filial, 
                            ts_lat_coord,    ts_lat_grad,         ts_lat_min,       ts_lat_seg,
                            ts_long_coord,   ts_long_grad,        ts_long_min,      ts_long_seg
from   ad_tran_servicio
where  ts_tipo_transaccion = 15391 
go

/* ts_filial */
print '=====> ts_filial'
go

CREATE VIEW ts_filial  (secuencia, tipo_transaccion, clase, fecha,
                        oficina_s, usuario, terminal_s, srv, lsrv,
			filial, nombre, rep_legal, direccion,
			actividad, estado, ruc) as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_filial, ts_descripcion, ts_tabla, ts_direc,
       ts_nombre_ter, ts_estado, ts_numero
from   ad_tran_servicio
where  ts_tipo_transaccion = 596 
or     ts_tipo_transaccion = 597 
go


/* ts_funcionario */
print '=====> ts_funcionario'
go

CREATE VIEW ts_funcionario (

   secuencia,            tipo_transaccion,      clase,         fecha,          oficina_s,
   usuario,              terminal_s,            srv,           lsrv,           login,
   funcionario,          nombre,                sexo,          dinero,         departamento,
   oficina,              cargo,                 secuencia_f,   jefe,           nivel,
   nomina,               clave,                 estado,        offset,         cedula,
   causa_bloqueo
)
as
select 
   ts_secuencia,         ts_tipo_transaccion,   ts_clase,      ts_fecha,       ts_ofi,
   ts_user,              ts_term,               ts_srv,        ts_lsrv,        ts_login,
   ts_smallint,          ts_descripcion,        ts_sexo,       ts_prioridad,   ts_procedure,
   ts_oficina,           ts_transaccion,        ts_int,        ts_plazo,       ts_tinyint,
   ts_terminal,          ts_clave,              ts_estado,     ts_offset,      ts_fu_cedula,
   ts_fu_causa_bloqueo
from   ad_tran_servicio
where  ts_tipo_transaccion = 598
or     ts_tipo_transaccion = 599
or     ts_tipo_transaccion = 1510
go

/* ts_funcionario_bloq */
print '=====> ts_funcionario_bloq'
go

CREATE VIEW ts_funcionario_bloq (secuencia, tipo_transaccion, clase, fecha,
                            oficina_s, usuario, terminal_s, srv, lsrv,
                            funcionario,estado,fec_inicio, fec_final
) as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_smallint, ts_estado,
       ts_fecha_crea, ts_fecha_habil
from   ad_tran_servicio
where  ts_tipo_transaccion = 500
go


/* ts_tabla */
print '=====> ts_tabla'
go

CREATE VIEW ts_tabla (
	secuencia, tipo_transaccion, clase, fecha,
        oficina_s, usuario, terminal_s, srv, lsrv,
        codigo, tabla, descripcion
)
as
select	ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
        ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
        ts_smallint, ts_clave, ts_descripcion
  from	ad_tran_servicio
 where	ts_tipo_transaccion = 1532
    or  ts_tipo_transaccion = 1533 
go


/* ts_feriados */
print '=====> ts_feriados'
go

CREATE VIEW ts_feriados (
	secuencia, tipo_transaccion, clase, fecha,
        oficina_s, usuario, terminal_s, srv, lsrv,
        feriado 
)
as
select	ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
        ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
        ts_datetime
  from	ad_tran_servicio
 where	ts_tipo_transaccion = 594
    or  ts_tipo_transaccion = 595 
go


/* ts_suc_correo */
print '=====> ts_suc_correo'
go
CREATE VIEW ts_suc_correo (
	secuencial, tipo_transaccion, clase, fecha,
	usuario, terminal, srv, lsrv,
	provincia,sucursal,descripcion,estado
)
as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_user, ts_term, ts_srv, ts_lsrv,
       ts_procedure,ts_horario,ts_descripcion,ts_estado
from   ad_tran_servicio
where  ts_tipo_transaccion = 1545
or     ts_tipo_transaccion = 1546
go


/* ts_error */
print '=====> ts_error'
go
CREATE VIEW ts_error (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	numero, severidad, mensaje
)
as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_int, ts_severidad, ts_mensaje 
from   ad_tran_servicio
where  ts_tipo_transaccion = 1534
and    ts_tipo_transaccion = 1535
and    ts_tipo_transaccion = 1536
go

/* ts_telefono_of */
print '=====> ts_telefono_of'
go
CREATE VIEW ts_telefono_of (
	secuencial, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	oficina, secuencia, valor, tipo_telefono	
)
as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_smallint, ts_tinyint, ts_archivo, ts_dia --JSA 11202012 INC-ADM-19218 ts_tcpip 
from   ad_tran_servicio
where  ts_tipo_transaccion = 1534
and    ts_tipo_transaccion = 1535
and    ts_tipo_transaccion = 1536
go


/* ts_nodo_nivel */
print '=====> ts_nodo_nivel'
go

CREATE VIEW ts_nodo_nivel (
	secuencia, tipo_transaccion, clase, fecha,
	filial, oficina, nodo, link, secuencial,
	nombre, rol, tamanio, terminal, fecha_ult_mod)
as
  select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	 ts_filial, ts_oficina, ts_nodo, ts_link, ts_secuencial,
	 ts_nombre, ts_rol, ts_tamanio, ts_terminal, 
         ts_fecha_ult_mod
    from ad_tran_servicio
   where ts_tipo_transaccion = 15125
      or ts_tipo_transaccion = 15126
      or ts_tipo_transaccion = 15127
go

/* ts_icono */
print '=====> ts_icono'
go

CREATE VIEW ts_icono (
	secuencia, tipo_transaccion, clase, fecha,
	link, secuencial, horario, nombre, rol, 
	tamanio, terminal, fecha_ult_mod)
as
  select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	 ts_link, ts_secuencial, ts_horario, ts_nombre, ts_rol, 
	 ts_tamanio, ts_terminal, ts_fecha_ult_mod
    from ad_tran_servicio
   where ts_tipo_transaccion = 15106
      or ts_tipo_transaccion = 15107
      or ts_tipo_transaccion = 15108
go

/* ts_nivel */
print '=====> ts_nivel'
go

CREATE VIEW ts_nivel (
	secuencia, tipo_transaccion, clase, fecha,
	link, nombre, fecha_ult_mod)
as
  select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	 ts_link, ts_nombre, ts_fecha_ult_mod
    from ad_tran_servicio
   where ts_tipo_transaccion = 15112
      or ts_tipo_transaccion = 15113
      or ts_tipo_transaccion = 15114
go

/* ts_mapa */
print '=====> ts_mapa'
go

CREATE VIEW ts_mapa (
	secuencia, tipo_transaccion, clase, fecha,
	link, nombre, descripcion, fecha_ult_mod)
as
  select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	 ts_link, ts_nombre, ts_descripcion, ts_fecha_ult_mod
    from ad_tran_servicio
   where ts_tipo_transaccion = 15118
      or ts_tipo_transaccion = 15119
      or ts_tipo_transaccion = 15120
go

/* ts_cat_icono */
print '=====> ts_cat_icono'
go

CREATE VIEW ts_cat_icono (
	secuencia, tipo_transaccion, clase, fecha,
	link, nombre, descripcion, fecha_ult_mod)
as
  select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	 ts_link, ts_nombre, ts_descripcion, ts_fecha_ult_mod
    from ad_tran_servicio
   where ts_tipo_transaccion = 15143
      or ts_tipo_transaccion = 15144
      or ts_tipo_transaccion = 15145
go

/* cc_tsoficial */

print '=====> cc_tsoficial'
go
CREATE VIEW cc_tsoficial (secuencia, tipo_transaccion, clase, tsfecha,
                          oficina, usuario, terminal, srv, lsrv,
			  reentry,origen,oficial, funcionario, 
			  ofi_superior, nivel, sector,ofi_sustituto
) as
select  ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
        ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
	ts_protocolo,ts_tlink,ts_tamanio,ts_registrador,ts_modificador,
	ts_nemon,ts_codigocat,ts_habilitante
from   ad_tran_servicio
where  ts_tipo_transaccion = 15150
or     ts_tipo_transaccion = 15151
or     ts_tipo_transaccion = 15155 
or     ts_tipo_transaccion = 15156 
go

/*********** TASAS REFERENCIALES ************/
/* ARO : 4 de Julio del 2000 */

print '=====> ts_tasas_referenciales'
go
CREATE VIEW ts_tasas_referenciales (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	tasa, descripcion, estado
)
as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_codigocat, ts_descripcion, ts_protocolo
from   ad_tran_servicio
where  ts_tipo_transaccion = 15188
or     ts_tipo_transaccion = 15189
go

print '=====> ts_caracteristicas_tasa'
go
CREATE VIEW ts_caracteristicas_tasa (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	tasa, modalidad,
        periodo, estado, rango, nro_tasas, num_periodo
)
as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_codigocat, ts_tlink,
       ts_link, ts_protocolo, ts_tcpip, ts_tamanio, ts_int
from   ad_tran_servicio
where  ts_tipo_transaccion = 15191
or     ts_tipo_transaccion = 15192
go

print '=====> ts_pizarra'
go
CREATE VIEW ts_pizarra (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
        cod_pizarra,moneda, valor, fecha_fin, fecha_inicio, 
        referencia, periodo, modalidad, tipo_valor, tipo_tasa, 
        rango_desde, rango_hasta, caracteristica, autoriza, usr_autoriza
)
as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_int, ts_tinyint, ts_float, ts_datetime, ts_fecha_aut, 
       ts_codigocat,ts_plazo, ts_25, ts_tcpip, ts_tipo, 
       ts_modificador, ts_autorizante, ts_tlink, ts_prioridad, ts_login
       
from   ad_tran_servicio
where  ts_tipo_transaccion = 15195
or     ts_tipo_transaccion = 15196
or     ts_tipo_transaccion = 15197
go

print '=====> ts_coap'
go
CREATE VIEW ts_coap (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
        num_tasa, cod_tipo_servicio, moneda,
        monto_inicial, monto_final, tasa_nominal,
        tasa_efectiva, fecha_inicio, fecha_final,
        rango_inicial, rango_final
)
as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_int, ts_procedure, ts_tinyint, 
       ts_money, ts_costo, ts_float, 
       ts_money2, ts_datetime, ts_fecha_aut,
       ts_smallint, ts_plazo       
from   ad_tran_servicio
where  ts_tipo_transaccion = 15200
or     ts_tipo_transaccion = 15201
or     ts_tipo_transaccion = 15202
go

print '=====> ts_divd'
go
CREATE VIEW ts_divd (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
      num_tasa, moneda, cod_mercado,
      fecha_ing, hora, tasa_compra, tasa_venta,
      tasa_compra_billete, tasa_venta_billete, costo_interno
)
as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_int, ts_tinyint, ts_horario,
       ts_hr_inicio, ts_hr_fin, ts_money, ts_costo,
       ts_money2, ts_money3, ts_money4
from   ad_tran_servicio
where  ts_tipo_transaccion = 15205
or     ts_tipo_transaccion = 15206
or     ts_tipo_transaccion = 15207
go

print '=====> ts_divf'
go
CREATE VIEW ts_divf (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
      num_registro, moneda, fecha_inicio,
      fecha_fin, plazo, tasa_compra,
      tasa_venta, funcionario, fecha_modificacion
)
as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_int, ts_tinyint, ts_datetime,
       ts_hr_fin, ts_smallint, ts_money, 
       ts_costo, ts_login, ts_fecha_ult_mod
from   ad_tran_servicio
where  ts_tipo_transaccion = 15210
or     ts_tipo_transaccion = 15211
or     ts_tipo_transaccion = 15212
go

print '=====> ts_reldo'
go
CREATE VIEW ts_reldo (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
      cod_moneda, fecha_inicial, fecha_final,
      valor, secuencial
)
as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_tinyint, ts_datetime, ts_fecha_ult_mod,
       ts_float, ts_int
from   ad_tran_servicio
where  ts_tipo_transaccion = 15216
or     ts_tipo_transaccion = 15217
or     ts_tipo_transaccion = 15218
go

/* ts_desbloqueo_func */ -- ITO 05/31/2012
print '=====> ts_desbloqueo_func'
go

CREATE VIEW ts_desbloqueo_func (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	filial, oficina, nodo, login, fecha_asig,
	creador, estado, fecha_out, 
	fecha_ult_mod, completo, fecha_ult_pwd
)
as
  select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
	 ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
	 ts_filial, ts_oficina, ts_nodo, ts_login, ts_fecha_asig,
	 ts_creador, ts_estado, ts_fecha_aut,
         ts_fecha_ult_mod, ts_tipo, ts_fecha_aut
    from ad_tran_servicio
   where ts_tipo_transaccion = 15914     
go

/********* FIN TASAS REFERENCIALES **********/
------------------------------------------------ HSBC -----------------------------------------------
create view ts_acceso_func_cen
         (secuencia,    tipo_transaccion,    clase,          fecha,
          oficina_s,    usuario,             terminal_s,     srv,
          lsrv,         filial,              menu_visitado,  libreria, 
          hora_visita)
as SELECT ts_secuencia, ts_tipo_transaccion, ts_clase,       ts_fecha, 
          ts_ofi,       ts_user,             ts_term,        ts_srv,
          ts_lsrv,      ts_filial,           ts_desc_larga,  ts_mensaje,
          ts_fecha_reg
FROM ad_tran_servicio
where ts_tipo_transaccion = 15298
GO 

print '=====> ts_barrio'
go

CREATE VIEW ts_barrio (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	barrio, descripcion, distrito, canton, estado
)
as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_int, ts_descripcion, ts_procedure, ts_transaccion, ts_estado
from   ad_tran_servicio
where  ts_tipo_transaccion = 15296  
or     ts_tipo_transaccion = 15303 
go

print '=====> ts_feriados_bcocentral'
go

CREATE VIEW ts_feriados_bcocentral (
	secuencia, tipo_transaccion, clase, fecha,
        oficina_s, usuario, terminal_s, srv, lsrv,
        feriado 
)
as
select	ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
        ts_ofi,       ts_user,             ts_term,   ts_srv, 
        ts_lsrv,      ts_datetime
  from	ad_tran_servicio
 where	ts_tipo_transaccion = 15400
    or  ts_tipo_transaccion = 15401
go

print '=====> ts_adm_seguridades'
go
create view ts_adm_seguridades (
   secuencia, 
   tipo_transaccion, 
   clase, 
   fecha,
   oficina_s, 
   usuario, 
   terminal_s, 
   srv,
   lsrv,
   
   tipo_objeto,    --P-agina, C-omponente O-peracion
   id_objeto,      --Codigo del tipo de objeto
   id_objeto_padre,--Objeto Padre (Nodo Arbol)
   rol_autorizado  --codigo del rol al que se autoriza el objeto
)
as
select ts_secuencia, 
       ts_tipo_transaccion, 
       ts_clase, 
       ts_fecha,
       ts_ofi, 
       ts_user, 
       ts_term, 
       ts_srv, 
       ts_lsrv,
       
       ts_tipo, 
       ts_desc_larga,
       ts_direc,
       ts_int
from ad_tran_servicio
where ts_tipo_transaccion = 15373
   or ts_tipo_transaccion = 15374
go

print '=====> ts_label'
go
create view ts_label (
   secuencia, 
   tipo_transaccion, 
   clase, 
   fecha,
   oficina_s, 
   usuario, 
   terminal_s, 
   srv,
   lsrv,
   
   id_label,       --Codigo del tipo de objeto
   label,          --Objeto Padre (Nodo Arbol)
   cultura
)
as
select ts_secuencia, 
       ts_tipo_transaccion, 
       ts_clase, 
       ts_fecha,
       ts_ofi, 
       ts_user, 
       ts_term, 
       ts_srv, 
       ts_lsrv,
       
       ts_int,
       ts_direc,
       ts_nombre_f_d
from ad_tran_servicio
where ts_tipo_transaccion = 15386
go


/* ts_serv_ofic */
print '=====> ts_serv_ofic'
go
CREATE VIEW ts_serv_ofic (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv, hora,
	oficina, filial, servicio
)
as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv, ts_fecha_ult_mod,
       ts_oficina, ts_filial, ts_codigocat
from   ad_tran_servicio
where  ts_tipo_transaccion = 15389 
or     ts_tipo_transaccion = 15389
go

/* ts_depart_pais */
print '=====> ts_depart_pais'
go

CREATE VIEW ts_depart_pais (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv,
	departamento, descripcion, mnemonico, pais, estado
)
as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_direccion, ts_descripcion, ts_subdireccion,ts_procedure, ts_estado
from   ad_tran_servicio
where  ts_tipo_transaccion = 15393
or     ts_tipo_transaccion = 15394
or     ts_tipo_transaccion = 15395
go

/* ts_municipio */
print '=====> ts_municipio'
go

CREATE VIEW ts_municipio (
	secuencia, tipo_transaccion, clase, fecha,
	oficina_s, usuario, terminal_s, srv, lsrv, hora,
	cod_municipio, descripcion, cod_provincia, estado
)
as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv, ts_fecha_ult_mod,
       ts_regional, ts_nomb_encarg, ts_provincia, ts_estado
from   ad_tran_servicio
where  ts_tipo_transaccion = 15396 
go


/*ts_ofic_func*/
print '=====> ts_ofic_func'
go
CREATE VIEW  ts_ofic_func(
       secuencia, tipo_transaccion, clase, fecha,
       oficina_s, usuario, terminal_s, srv, lsrv,
       hora,filial,oficina,funcionario) as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_fecha_ult_mod,ts_filial, ts_oficina,ts_funcionar
from   ad_tran_servicio
where  ts_tipo_transaccion = 15392 
go

/*ts_oficfunc_rol*/
print '=====> ts_oficfunc_rol'
go
CREATE VIEW  ts_oficfunc_rol(
   secuencia, tipo_transaccion, clase, fecha,
   oficina_s, usuario, terminal_s, srv, lsrv,
   hora,oficfunc,rol) 
as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
   ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
   ts_fecha_ult_mod,ts_severidad,ts_archivo
from ad_tran_servicio
where ts_tipo_transaccion = 15414
or ts_tipo_transaccion = 15416 
go


/*ts_canton*/
print '=====> ts_canton'
go
CREATE VIEW ts_canton (
   secuencia, tipo_transaccion, clase, fecha,
   oficina_s, usuario, terminal_s, srv, lsrv,
   hora,canton,descripcion,municipio,estado) 
as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
      ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
      ts_fecha_ult_mod,ts_provincia, ts_descripcion, ts_depart_pais, ts_estado    
from ad_tran_servicio
where ts_tipo_transaccion = 15397
or  ts_tipo_transaccion =  15398
go

















/*ts_ambito*/
print '=====> ts_depart_pais'
if exists (select * from sysobjects where name = 'ts_ambito')
    DROP VIEW ts_ambito
go
print '=====> ts_ambito'
go
CREATE VIEW ts_ambito (
   secuencia, tipo_transaccion, clase, fecha,
   oficina_s, usuario, terminal_s, srv, lsrv,
   sec_ambito, cargo, tipo_ambito, ambito, estado
)
as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv,
       ts_ambito_sec, ts_ambito_cargo, ts_ambito_tipo_amb,
       ts_ambito_amb, ts_ambito_est
from   ad_tran_servicio
where  ts_tipo_transaccion = 15406
or     ts_tipo_transaccion = 15407
or     ts_tipo_transaccion = 15408
or     ts_tipo_transaccion = 15409
go

print '=====> ts_ambito_tmp'
go
CREATE VIEW ts_ambito_tmp (
   secuencia, tipo_transaccion, clase, fecha,
   oficina_s, usuario, terminal_s, srv, lsrv

)
as
select ts_secuencia, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_ofi, ts_user, ts_term, ts_srv, ts_lsrv


from   ad_tran_servicio
where  ts_tipo_transaccion = 15411


go


print '=====> ts_conexion_login'
go
if exists (select * from sysobjects where name = 'ts_conexion_login')
    DROP VIEW ts_conexion_login
go
-- JMA - S0006-CC ts_conexion_login Control de cambio ADM-S0006-CC
CREATE VIEW ts_conexion_login (
   usuario, terminal, fecha, autenticacion, id_estado_usuario , observacion, 
   secuencia, servidor,tipo_transaccion,clase
)
as
select ts.ts_user, ts.ts_term, ts.ts_fecha,  ts.ts_char, ts.ts_estado ,  ts.ts_desc_larga , 
	ts.ts_secuencia, ts_srv ,ts_tipo_transaccion ,ts_clase   
	from ad_tran_servicio ts
	where  ts_tipo_transaccion = 15417
go

go
