/********************************************************************************************/ 
/*   Script para creacion de tablas                                                         */ 
/*   de la base de datos de : cobis                                                         */                                                                                                                                                                  
/********************************************************************************************/ 
  
use cobis                
go 
  
  
print 'ba_aprobacion'                  
Create table ba_aprobacion(                   
       ap_sarta                           int                NOT NULL,                                                                                                                                                                                          
       ap_fecha                           datetime           NOT NULL,                                                                                                                                                                                          
       ap_login                           descripcion        NOT NULL)                                                                                                                                                                                          
go 
  
print 'ba_batch'                       
Create table ba_batch(                        
       ba_batch                           int                NOT NULL,                                                                                                                                                                                          
       ba_nombre                          descripcion        NOT NULL,                                                                                                                                                                                          
       ba_descripcion                     varchar(255)       NULL,                                                                                                                                                                                              
       ba_lenguaje                        char(3)            NOT NULL,                                                                                                                                                                                          
       ba_fecha_creacion                  datetime           NOT NULL,                                                                                                                                                                                          
       ba_producto                        tinyint            NOT NULL,                                                                                                                                                                                          
       ba_tipo_batch                      char(1)            NOT NULL,                                                                                                                                                                                          
       ba_sec_corrida                     smallint           NOT NULL,                                                                                                                                                                                          
       ba_ente_procesado                  descripcion        NULL,                                                                                                                                                                                              
       ba_arch_resultado                  varchar(255)       NULL,                                                                                                                                                                                              
       ba_arch_fuente                     varchar(255)       NOT NULL,                                                                                                                                                                                          
       ba_frec_reg_proc                   int                NULL,                                                                                                                                                                                              
       ba_impresora                       varchar(255)       NULL,                                                                                                                                                                                              
       ba_serv_destino                    varchar(24)        NULL,                                                                                                                                                                                              
       ba_reproceso                       char(1)            NOT NULL,                                                                                                                                                                                          
       ba_path_fuente                     varchar(255)       NULL,                                                                                                                                                                                              
       ba_path_destino                    varchar(255)       NULL)                                                                                                                                                                                              
go 
  
print 'ba_corrida'                     
Create table ba_corrida(                      
       co_corrida_id                      smallint           NOT NULL,                                                                                                                                                                                          
       co_sarta                           int                NOT NULL,                                                                                                                                                                                          
       co_estado                          char(1)            NOT NULL,                                                                                                                                                                                          
       co_fecha_proceso                   datetime           NOT NULL,                                                                                                                                                                                          
       co_ssn                             int                NULL,                                                                                                                                                                                              
       co_login                           login              NULL)                                                                                                                                                                                              
go 
  
print 'ba_enlace'                      
Create table ba_enlace(                       
       en_sarta                           int                NOT NULL,                                                                                                                                                                                          
       en_batch_inicio                    int                NOT NULL,                                                                                                                                                                                          
       en_secuencial_inicio               smallint           NOT NULL,                                                                                                                                                                                          
       en_batch_fin                       int                NULL,                                                                                                                                                                                              
       en_secuencial_fin                  smallint           NULL,                                                                                                                                                                                              
       en_tipo_enlace                     char(1)            NULL,                                                                                                                                                                                              
       en_puntos                          varchar(50)        NULL,                                                                                                                                                                                              
       en_entre_lotes                     char(1)            NOT NULL)                                                                                                                                                                                          
go 
  
print 'ba_enlace_exec'                 
Create table ba_enlace_exec(                  
       en_sarta                           int                NOT NULL,                                                                                                                                                                                          
       en_batch_inicio                    int                NOT NULL,                                                                                                                                                                                          
       en_secuencial_inicio               smallint           NOT NULL,                                                                                                                                                                                          
       en_batch_fin                       int                NULL,                                                                                                                                                                                              
       en_secuencial_fin                  smallint           NULL,                                                                                                                                                                                              
       en_tipo_enlace                     char(1)            NULL,                                                                                                                                                                                              
       en_puntos                          varchar(50)        NULL)                                                                                                                                                                                              
go 
  
print 'ba_enlace_log'                  
Create table ba_enlace_log(                   
       en_sarta                           int                NOT NULL,                                                                                                                                                                                          
       en_batch_inicio                    int                NOT NULL,                                                                                                                                                                                          
       en_secuencial_inicio               smallint           NOT NULL,                                                                                                                                                                                          
       en_batch_fin                       int                NULL,                                                                                                                                                                                              
       en_secuencial_fin                  smallint           NULL,                                                                                                                                                                                              
       en_tipo_enlace                     char(1)            NULL,                                                                                                                                                                                              
       en_puntos                          varchar(50)        NULL,                                                                                                                                                                                              
       en_corrida                         int                NOT NULL)                                                                                                                                                                                          
go 
  
print 'ba_fecha_cierre'                
Create table ba_fecha_cierre(                 
       fc_producto                        tinyint            NOT NULL,                                                                                                                                                                                          
       fc_fecha_cierre                    datetime           NOT NULL,                                                                                                                                                                                          
       fc_fecha_propuesta                 datetime           NULL)                                                                                                                                                                                              
go 
  
print 'ba_fecha_proceso'               
Create table ba_fecha_proceso(                
       fp_fecha                           datetime           NOT NULL)                                                                                                                                                                                          
go
  
print 'ba_impresora'                   
Create table ba_impresora(                    
       im_secuencial                      int                NOT NULL,                                                                                                                                                                                          
       im_ubicacion                       descripcion        NOT NULL,                                                                                                                                                                                          
       im_comando                         descripcion        NULL,                                                                                                                                                                                              
       im_nombre                          descripcion        NOT NULL)                                                                                                                                                                                          
go 
  
print 'ba_lec_off'                     
Create table ba_lec_off(                      
       le_batch                           int                NOT NULL,                                                                                                                                                                                          
       le_tipo                            char(1)            NOT NULL,                                                                                                                                                                                          
       le_rol                             smallint           NULL,                                                                                                                                                                                              
       le_login                           varchar(30)        NULL,                                                                                                                                                                                              
       le_oficina                         smallint           NOT NULL)                                                                                                                                                                                          
go 
  
print 'ba_lectura'                     
Create table ba_lectura(                      
       le_batch                           int                NOT NULL,                                                                                                                                                                                          
       le_tipo                            char(1)            NOT NULL,                                                                                                                                                                                          
       le_rol                             smallint           NULL,                                                                                                                                                                                              
       le_login                           varchar(10)        NULL,                                                                                                                                                                                              
       le_acceso                          char(1)            NOT NULL,                                                                                                                                                                                          
       le_opcion_off                      tinyint            NULL)                                                                                                                                                                                              
go 
  
print 'ba_log'                         
Create table ba_log(                          
       lo_sarta                           int                NOT NULL,                                                                                                                                                                                          
       lo_batch                           int                NOT NULL,                                                                                                                                                                                          
       lo_secuencial                      smallint           NOT NULL,                                                                                                                                                                                          
       lo_corrida                         smallint           NOT NULL,                                                                                                                                                                                          
       lo_operador                        char(64)           NULL,                                                                                                                                                                                              
       lo_fecha_inicio                    datetime           NOT NULL,                                                                                                                                                                                          
       lo_fecha_terminacion               datetime           NULL,                                                                                                                                                                                              
       lo_num_reg_proc                    int                NULL,                                                                                                                                                                                              
       lo_estatus                         char(1)            NULL,                                                                                                                                                                                              
       lo_razon                           varchar(255)       NULL,                                                                                                                                                                                              
       lo_fecha_proceso                   datetime           NOT NULL,                                                                                                                                                                                          
       lo_proceso                         int                NULL,                                                                                                                                                                                              
       lo_parametro                       varchar(255)       NULL,                                                                                                                                                                                              
       lo_intento                         smallint           NOT NULL)                                                                                                                                                                                          
go 
  
print 'ba_parametro'                   
Create table ba_parametro(                    
       pa_sarta                           int                NOT NULL,                                                                                                                                                                                          
       pa_batch                           int                NOT NULL,                                                                                                                                                                                          
       pa_ejecucion                       smallint           NOT NULL,                                                                                                                                                                                          
       pa_parametro                       smallint           NOT NULL,                                                                                                                                                                                          
       pa_nombre                          descripcion        NULL,                                                                                                                                                                                              
       pa_tipo                            char(1)            NOT NULL,                                                                                                                                                                                          
       pa_valor                           varchar(255)       NULL)                                                                                                                                                                                              
go 
  
print 'ba_path_pro'                    
Create table ba_path_pro(                     
       pp_producto                        tinyint            NOT NULL,                                                                                                                                                                                          
       pp_path_fuente                     varchar(255)       NULL,                                                                                                                                                                                              
       pp_path_destino                    varchar(255)       NULL)                                                                                                                                                                                              
go 
  
print 'ba_login_batch'                    
Create table ba_login_batch(                     
       lb_login                           login              NOT NULL,   
       lb_sarta                           int                NOT NULL,
       lb_batch                           int                NOT NULL,    
       lb_fecha_aut                       datetime           NOT NULL,
       lb_estado                          char(1)            NOT NULL,
       lb_usuario                         login              NOT NULL,
       lb_fecha_ult_mod                   datetime           NOT NULL)                                                                
go 
  
print 'ba_sarta'                       
Create table ba_sarta(                        
       sa_sarta                           int                NOT NULL,                                                                                                                                                                                          
       sa_nombre                          descripcion        NOT NULL,                                                                                                                                                                                          
       sa_descripcion                     varchar(255)       NOT NULL,                                                                                                                                                                                          
       sa_fecha_creacion                  datetime           NOT NULL,                                                                                                                                                                                          
       sa_creador                         descripcion        NOT NULL,                                                                                                                                                                                          
       sa_producto                        tinyint            NULL,                                                                                                                                                                                              
       sa_dependencia                     smallint           NULL,                                                                                                                                                                                              
       sa_autorizacion                    char(1)            NULL)                                                                                                                                                                                              
go 
  
print 'ba_sarta_batch'                 
Create table ba_sarta_batch(                  
       sb_sarta                           int                NOT NULL,                                                                                                                                                                                          
       sb_batch                           int                NOT NULL,                                                                                                                                                                                          
       sb_secuencial                      smallint           NOT NULL,                                                                                                                                                                                          
       sb_dependencia                     smallint           NULL,                                                                                                                                                                                              
       sb_repeticion                      char(1)            NULL,                                                                                                                                                                                              
       sb_critico                         char(1)            NULL,                                                                                                                                                                                              
       sb_left                            int                NULL,                                                                                                                                                                                              
       sb_top                             int                NULL,                                                                                                                                                                                              
       sb_lote_inicio                     int                NULL,                                                                                                                                                                                              
       sb_habilitado                      char(1)            NOT NULL)                                                                                                                                                                                          
go 
  
print 'ba_sarta_batch_exec'            
Create table ba_sarta_batch_exec(             
       sb_sarta                           int                NOT NULL,                                                                                                                                                                                          
       sb_batch                           int                NOT NULL,                                                                                                                                                                                          
       sb_secuencial                      smallint           NOT NULL,                                                                                                                                                                                          
       sb_dependencia                     smallint           NULL,                                                                                                                                                                                              
       sb_repeticion                      char(1)            NULL,                                                                                                                                                                                              
       sb_critico                         char(1)            NULL,                                                                                                                                                                                              
       sb_left                            int                NULL,                                                                                                                                                                                              
       sb_top                             int                NULL,                                                                                                                                                                                              
       sb_lote_inicio                     int                NULL,                                                                                                                                                                                              
       sb_habilitado                      char(1)            NULL,                                                                                                                                                                                              
       sb_adicionado                      char(1)            NULL,                                                                                                                                                                                              
       sb_id_proceso                      int                NULL,                                                                                                                                                                                              
       sb_imprimir                        tinyint            NULL)                                                                                                                                                                                              
go 
  
print 'ba_sarta_batch_log'             
Create table ba_sarta_batch_log(              
       sb_sarta                           int                NOT NULL,                                                                                                                                                                                          
       sb_batch                           int                NOT NULL,                                                                                                                                                                                          
       sb_secuencial                      smallint           NOT NULL,                                                                                                                                                                                          
       sb_dependencia                     smallint           NULL,                                                                                                                                                                                              
       sb_repeticion                      char(1)            NULL,                                                                                                                                                                                              
       sb_critico                         char(1)            NULL,                                                                                                                                                                                              
       sb_left                            int                NULL,                                                                                                                                                                                              
       sb_top                             int                NULL,                                                                                                                                                                                              
       sb_lote_inicio                     int                NULL,                                                                                                                                                                                              
       sb_habilitado                      char(1)            NULL,                                                                                                                                                                                              
       sb_adicionado                      char(1)            NULL,                                                                                                                                                                                              
       sb_id_proceso                      int                NULL,                                                                                                                                                                                              
       sb_imprimir                        tinyint            NULL,                                                                                                                                                                                              
       sb_corrida                         int                NOT NULL)                                                                                                                                                                                          
go 
  
print 'ba_secuencial'                  
Create table ba_secuencial(                   
       se_numero                          int                NOT NULL)                                                                                                                                                                                          
go 
  
print 'ba_tenlace'                     
Create table ba_tenlace(                      
       en_tsarta                          int                NOT NULL,                                                                                                                                                                                          
       en_tbatch_inicio                   int                NOT NULL,                                                                                                                                                                                          
       en_tsecuencial_inicio              smallint           NOT NULL,                                                                                                                                                                                          
       en_tbatch_fin                      int                NULL,                                                                                                                                                                                              
       en_tsecuencial_fin                 smallint           NULL,                                                                                                                                                                                              
       en_ttipo_enlace                    char(1)            NULL,                                                                                                                                                                                              
       en_tpuntos                         varchar(50)        NULL,                                                                                                                                                                                              
       en_tentre_lotes                    char(1)            NOT NULL)                                                                                                                                                                                          
go 
  
print 'ba_tparametro'                  
Create table ba_tparametro(                   
       pa_tsarta                          int                NOT NULL,                                                                                                                                                                                          
       pa_tbatch                          int                NOT NULL,                                                                                                                                                                                          
       pa_tejecucion                      smallint           NOT NULL,                                                                                                                                                                                          
       pa_tparametro                      smallint           NOT NULL,                                                                                                                                                                                          
       pa_tnombre                         varchar(64)        NULL,                                                                                                                                                                                              
       pa_ttipo                           char(1)            NOT NULL,                                                                                                                                                                                          
       pa_tvalor                          varchar(255)       NULL)                                                                                                                                                                                              
go 
  
print 'ba_tsarta'                      
Create table ba_tsarta(                       
       sa_tsarta                          int                NOT NULL,                                                                                                                                                                                          
       sa_tnombre                         descripcion        NOT NULL,                                                                                                                                                                                          
       sa_tdescripcion                    varchar(255)       NOT NULL,                                                                                                                                                                                          
       sa_tfecha_creacion                 datetime           NOT NULL,                                                                                                                                                                                          
       sa_tcreador                        descripcion        NOT NULL,                                                                                                                                                                                          
       sa_tproducto                       tinyint            NULL,                                                                                                                                                                                              
       sa_tdependencia                    smallint           NULL,                                                                                                                                                                                              
       sa_tautorizacion                   char(1)            NULL)                                                                                                                                                                                              
go 
  
print 'ba_tsarta_batch'                
Create table ba_tsarta_batch(                 
       sb_tsarta                          int                NOT NULL,                                                                                                                                                                                          
       sb_tbatch                          int                NOT NULL,                                                                                                                                                                                          
       sb_tsecuencial                     smallint           NOT NULL,                                                                                                                                                                                          
       sb_tdependencia                    smallint           NULL,                                                                                                                                                                                              
       sb_trepeticion                     char(1)            NULL,                                                                                                                                                                                              
       sb_tcritico                        char(1)            NULL,                                                                                                                                                                                              
       sb_tleft                           int                NULL,                                                                                                                                                                                              
       sb_ttop                            int                NULL,                                                                                                                                                                                              
       sb_tlote_inicio                    int                NULL,                                                                                                                                                                                              
       sb_thabilitado                     char(1)            NOT NULL)                                                                                                                                                                                          
go 
  
print 'ba_vlpid'                       
Create table ba_vlpid(                        
       vl_corrida                         smallint           NOT NULL,                                                                                                                                                                                          
       vl_sarta                           int                NOT NULL,                                                                                                                                                                                          
       vl_pid                             int                NOT NULL,                                                                                                                                                                                          
       vl_fecha_proceso                   datetime           NOT NULL,                                                                                                                                                                                          
       vl_archivo_fuente                  varchar(255)       NULL,                                                                                                                                                                                              
       vl_estado                          char(1)            NOT NULL)                                                                                                                                                                                          
go 
  
/*    Tablas nuevas usadas por modulo seguridad   */
print 'ba_operador' 
if exists ( select 1 from sysobjects where name = 'ba_operador' )
    drop TABLE ba_operador
go

go

create table ba_operador (
       op_login           varchar(30)     not null,
       op_rol           tinyint         not null,
       op_osuser        varchar(16)     not null,
       op_estado        char(1)         not null,
       op_dblogin       varchar(240)    not null
)
go

create unique clustered index ba_operador_KEY on ba_operador (op_login, op_rol, op_osuser)
go

print 'ba_log_operador' 
if exists ( select 1 from sysobjects where name = 'ba_log_operador' )
    drop table ba_log_operador 
go

create table ba_log_operador (
       lo_sec           int             not null,
       lo_login         varchar(30)     not null,
       lo_rol           tinyint         not null,
       lo_osuser        varchar(16)     not null,
       lo_fecha         datetime        not null,
       lo_cmd           varchar(255)    not null,
       lo_archivo       varchar(50)     null
)
go

create unique clustered index ba_log_operador_KEY on ba_log_operador (lo_sec)
go

create index ba_log_operador_KEYA on ba_log_operador (lo_login,lo_rol,lo_osuser,lo_fecha)
go

/*TABLA ba_ftp*/
print 'ba_ftp' 
if exists ( select 1 from sysobjects where name = 'ba_ftp' )
    drop table ba_ftp 
go

create table ba_ftp
(
ftp_login	varchar(255)		not null,
ftp_passwd	varchar(255)		not null,
ftp_ip		varchar(255)		not null,
ftp_protocolo varchar(10)		null
)
go

/* Relacionamiento base de datos - programa batch*/
print 'ba_batch_db'
go
if exists (select 1 from sysobjects where name = 'ba_batch_db')
	drop table ba_batch_db
go

create table ba_batch_db(bd_batch int not null, 
			 bd_database varchar(30) not null)

go

print 'creando index ba_batch_db_Key...'
go
if exists (select name from sysindexes where name='ba_batch_db_Key')
drop index ba_batch_db.ba_batch_db_Key
go

create unique index ba_batch_db_Key ON ba_batch_db(bd_batch, bd_database)
go

print 'creando tabla ba_ctrl_ciclico...'
go
if exists (select 1 from sysobjects where name = 'ba_ctrl_ciclico')
   drop table ba_ctrl_ciclico
go
create table ba_ctrl_ciclico (
    ctc_sarta       int,
    ctc_batch       int,   
    ctc_secuencial  int,
    ctc_procesar    char(1),
    ctc_estado      char(1) 
)
go

print 'creando index ba_ctrl_ciclico_KInd ...'
go
if exists (select name from sysindexes where name='ba_ctrl_ciclico_KInd ')
   drop index ba_ctrl_ciclico.ba_ctrl_ciclico_KInd 
go

create unique index ba_ctrl_ciclico_KInd on ba_ctrl_ciclico (ctc_sarta,ctc_batch,ctc_secuencial)
go


/* TABLA ba_lectura_reporte*/

print 'Creando tabla ba_lectura_reporte...'
go
if exists (select 1 from sysobjects where name = 'ba_lectura_reporte')
   drop table ba_lectura_reporte
go

create table ba_lectura_reporte
(
 lr_rol     int not null,
 lr_login   login null,
 lr_sarta   int not null, 
 lr_batch   int not null
)
go


if exists (select name from sysindexes where name='ba_lectura_reporte_IDX')
   drop index ba_lectura_reporte.ba_lectura_reporte_IDX
go

create index ba_lectura_reporte_IDX on ba_lectura_reporte (lr_rol, lr_login)
go


/* TABLA ba_lectura_oficina*/

print 'Creando tabla ba_lectura_oficina...'
go
if exists (select 1 from sysobjects where name = 'ba_lectura_oficina')
   drop table ba_lectura_oficina
go

create table ba_lectura_oficina (
  lo_rol       int null,
  lo_login     login null,
  lo_oficina   int null

)
go

if exists (select name from sysindexes where name='ba_lectura_oficina_IDX')
   drop index ba_lectura_oficina.ba_lectura_oficina_IDX
go

create index ba_lectura_oficina_IDX on ba_lectura_oficina (lo_rol, lo_login)
go

--------------------------------------------------------------------------------------
-- PJA: 12 MAYO 2011
-- Estructura Diaria para esquema de almacenamiento para el registro de errores que se 
-- presenten durante la ejecución de los procesos batch. 
--------------------------------------------------------------------------------------

print 'Creando tabla ba_error_batch...'
go
if exists (select 1 from sysobjects where name = 'ba_error_batch')
   drop table ba_error_batch
go

create table ba_error_batch 
(

er_secuencial_error     int          not null,
er_fecha_proceso	datetime     not null,
er_sarta	        int          null,
er_batch	        int          null,
er_secuencial	        int          null,
er_corrida	        int          null,
er_intento	        int          null,
er_fecha_error	        datetime     not null,
er_error	        int          not null,
er_tran	                int          null,
er_operacion            varchar(25)  null,
er_detalle              varchar(255) null

)
go


--------------------------------------------------------------------------------------
-- PJA: 12 MAYO 2011
-- Estructura Histórica para esquema de almacenamiento para el registro de errores que 
-- se presenten durante la ejecución de los procesos batch. 
--------------------------------------------------------------------------------------

print 'Creando tabla ba_error_batch_his...'
go
if exists (select 1 from sysobjects where name = 'ba_error_batch_his')
   drop table ba_error_batch_his
go

create table ba_error_batch_his 
(

er_secuencial_error     int          not null,
er_fecha_proceso	datetime     not null,
er_sarta	        int          null,
er_batch	        int          null,
er_secuencial	        int          null,
er_corrida	        int          null,
er_intento	        int          null,
er_fecha_error	        datetime     not null,
er_error	        int          not null,
er_tran	                int          null,
er_operacion            varchar(25)  null,
er_detalle              varchar(255) null,
er_fecha_depura	        datetime     not null,
er_usuario_depura       varchar(14)  not null


)
go

/*TABLA BA_habilita*/
print 'ba_habilita'
if exists (select 1 from sysobjects where name = 'ba_habilita')
  drop table ba_habilita
go

create table ba_habilita (
	ha_producto	int	not null,
	ha_descripcion	varchar(30)	not null
)
go


/*TABLA BA_habilita*/
print 'ad_respaldo'
if exists (select 1 from sysobjects where name = 'ad_respaldo')
   drop table ad_respaldo
go

create table ad_respaldo (
re_codigo	int,
re_path		varchar(255)
)
go


