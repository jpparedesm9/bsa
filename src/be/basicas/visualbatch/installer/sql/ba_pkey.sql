
/* SQL Environment is SYBASE                 */
/* Environment - Retain case                 */
/* Environment - Do not prefix names         */
/* Environment - CLUSTERED unique indexes    */
/* Environment - LoadUserDefs                */


use cobis
go

/* ba_batch */
print 'ba_batch_Key'
go

CREATE UNIQUE CLUSTERED INDEX ba_batch_Key ON ba_batch (
       ba_batch)
go

/* ba_log */
print 'ba_log_Key'
go

CREATE UNIQUE CLUSTERED INDEX ba_log_Key ON ba_log (
       lo_sarta,
       lo_batch,
       lo_secuencial,
       lo_corrida,
       lo_intento)
go

/* ba_parametro */
print 'ba_parametro_Key'
go

CREATE UNIQUE CLUSTERED INDEX ba_parametro_Key ON ba_parametro (
       pa_sarta,
       pa_ejecucion,
       pa_batch,
       pa_parametro)
go

/* ba_login_batch_key */
print 'ba_login_batch_Key'
go

CREATE UNIQUE CLUSTERED INDEX ba_login_batch_Key ON ba_login_batch (
       lb_login,
       lb_sarta,
       lb_batch)
go

/* ba_sarta */
print 'ba_sarta_Key'
go

CREATE UNIQUE CLUSTERED INDEX ba_sarta_Key ON ba_sarta (
       sa_sarta)
go

/* ba_sarta_batch */
print 'ba_sarta_batch_Key'
go

CREATE UNIQUE CLUSTERED INDEX ba_sarta_batch_Key ON ba_sarta_batch (
       sb_sarta,
       sb_secuencial)
go

/* ba_lectura */
print 'ba_lectura_Key'
go

CREATE UNIQUE CLUSTERED INDEX ba_lectura_key ON ba_lectura (
       le_batch,
       le_tipo,
       le_login,
       le_rol)
go


/* ba_fecha_cierre */
print 'ba_fecha_cierre'
go

CREATE UNIQUE CLUSTERED INDEX ba_fecha_cierre_key ON ba_fecha_cierre (
       fc_producto)
go              

/*ba_enlace*/
print 'ba_enlace_Key'
go

CREATE UNIQUE CLUSTERED INDEX ba_enlace_Key ON ba_enlace (
       en_sarta,
       en_secuencial_inicio,
       en_batch_inicio,
       en_secuencial_fin,
       en_batch_fin)
go

/*ba_tsarta*/
print 'ba_tsarta_Key'
go

CREATE UNIQUE CLUSTERED INDEX ba_tsarta_Key ON ba_tsarta (
       sa_tsarta)
go

/*ba_tsarta_batch*/
print 'ba_tsarta_batch_Key'
go

CREATE UNIQUE CLUSTERED INDEX ba_tsarta_batch_Key ON ba_tsarta_batch (
       sb_tsarta,
       sb_tsecuencial)
go

/*ba_tenlace*/
print 'ba_tenlace_Key'
go

CREATE UNIQUE CLUSTERED INDEX ba_tenlace_Key ON ba_tenlace (
       en_tsarta,
       en_tsecuencial_inicio,
       en_tbatch_inicio,
       en_tsecuencial_fin,
       en_tbatch_fin)
go

/*ba_tparametro*/
print 'ba_tparametro.ba_tparametro_Key'
go

create unique clustered index ba_tparametro_Key on ba_tparametro (
       pa_tsarta,
       pa_tejecucion,
       pa_tbatch,
       pa_tparametro)
go

/*ba_sarta_batch_exec*/
print 'ba_sarta_batch_exec_Key'
go

CREATE UNIQUE CLUSTERED INDEX ba_sarta_batch_exec_Key ON ba_sarta_batch_exec (
       sb_sarta,
       sb_secuencial)
go

/*ba_enlace_exec*/
print 'ba_enlace_exec_Key'
go

CREATE UNIQUE CLUSTERED INDEX ba_enlace_exec_Key ON ba_enlace_exec (
       en_sarta,
       en_secuencial_inicio,
       en_batch_inicio, 
       en_secuencial_fin,
       en_batch_fin)
go

/*ba_sarta_batch_log*/
print 'ba_sarta_batch_log_Key'
go

CREATE UNIQUE CLUSTERED INDEX ba_sarta_batch_log_Key ON ba_sarta_batch_log (
       sb_sarta,
       sb_batch,
       sb_secuencial, 
       sb_corrida)
go

/*ba_enlace_log*/
print 'ba_enlace_log_Key'
go

CREATE UNIQUE CLUSTERED INDEX ba_enlace_log_Key ON ba_enlace_log (
       en_sarta,
       en_secuencial_inicio,
       en_batch_inicio, 
       en_batch_fin,
       en_secuencial_fin,
       en_corrida)
go


/*ba_lec_off*/
print 'ba_lec_off_Key'
go

create unique clustered index ba_lec_off_Key on ba_lec_off (
       le_batch,
       le_tipo,
       le_rol,
       le_login,
       le_oficina)
go

/*ba_aprobacion*/
print 'ba_aprobacion_Key'
go

create unique clustered index ba_aprobacion_Key on ba_aprobacion (
       ap_sarta,
       ap_fecha)
go

/*ba_path_pro*/
print 'ba_path_pro_Key'
go

create unique clustered index ba_path_pro_Key on ba_path_pro (
       pp_producto)
go  

print 'ba_corrida_Key'
go

create unique clustered index ba_corrida_Key on ba_corrida (
       co_corrida_id,
       co_sarta,
       co_estado)
go

print 'ba_vlpid_Key'
go

create unique clustered index ba_vlpid_Key on ba_vlpid (
       vl_corrida,
       vl_sarta,
       vl_pid)
go

-------------------------------------------------------------------------------------
-- PJA: 12 MAYO 2011
-- Estructura Diaria para esquema de almacenamiento para el registro de errores que se 
-- presenten durante la ejecución de los procesos batch. 
--------------------------------------------------------------------------------------


print 'ba_error_batch_key ...'
go

if exists (select name from sysindexes where name='ba_error_batch_key')
   drop index ba_error_batch.ba_error_batch_key
go


CREATE NONCLUSTERED INDEX ba_error_batch_key on cobis..ba_error_batch 
(
     er_secuencial_error, 
     er_fecha_proceso
)
go


print 'ba_error_batch_idx  ...'
go

if exists (select name from sysindexes where name='ba_error_batch_idx')
   drop index ba_error_batch.ba_error_batch_idx
go


CREATE INDEX ba_error_batch_idx on cobis..ba_error_batch 
(
     er_fecha_proceso, 
     er_sarta, 
     er_batch
)
go


--------------------------------------------------------------------------------------
-- PJA: 12 MAYO 2011
-- Estructura Histórica para esquema de almacenamiento para el registro de errores que 
-- se presenten durante la ejecución de los procesos batch. 
--------------------------------------------------------------------------------------

print 'ba_error_batch_his_key ...'
go

if exists (select name from sysindexes where name='ba_error_batch_his_key')
   drop index ba_error_batch_his.ba_error_batch_his_key
go

CREATE NONCLUSTERED INDEX ba_error_batch_his_key on cobis..ba_error_batch_his 
(
     er_secuencial_error, 
     er_fecha_proceso
)
go


print 'ba_error_batch_his_idx ...'
go

if exists (select name from sysindexes where name='ba_error_batch_his_idx')
   drop index ba_error_batch_his.ba_error_batch_his_idx
go


CREATE INDEX ba_error_batch_his_idx on cobis..ba_error_batch_his 
(
     er_fecha_proceso, 
     er_sarta, 
     er_batch
)
go


print 'ad_respaldo_Key ...'
go

CREATE UNIQUE INDEX ad_respaldo_Key ON ad_respaldo (
	re_codigo)
go
