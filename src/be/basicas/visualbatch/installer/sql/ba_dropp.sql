/*	Script para la eliminacion de indices por  */
/*	clave primaria de Visual Batch */



use cobis
go

/* ba_batch.ba_batch_Key */
print '=====> ba_batch.ba_batch_Key'
go
if exists (select name from sysindexes where name='ba_batch_Key')
	DROP INDEX ba_batch.ba_batch_Key
go

/* ba_log.ba_log_Key */
print '=====> ba_log.ba_log_Key'
go

if exists (select name from sysindexes where name='ba_log_Key')
	DROP INDEX ba_log.ba_log_Key
go

/* ba_parametro.ba_parametro_Key */
print '=====> ba_parametro.ba_parametro_Key'
go

if exists (select name from sysindexes where name='ba_parametro_Key')
	DROP INDEX ba_parametro.ba_parametro_Key
go


/* ba_login_batch.ba_login_batch_Key */
print '=====> ba_login_batch.ba_login_batch_Key'
go

if exists (select name from sysindexes where name='ba_login_batch_Key')
	DROP INDEX ba_login_batch.ba_login_batch_Key
go


/* ba_sarta.ba_sarta_Key */
print '=====> ba_sarta.ba_sarta_Key'
go

if exists (select name from sysindexes where name='ba_sarta_Key')
	DROP INDEX ba_sarta.ba_sarta_Key
go

/* ba_sarta_batch.ba_sarta_batch_Key */
print '=====> ba_sarta_batch.ba_sarta_batch_Key'
go

if exists (select name from sysindexes where name='ba_sarta_batch_Key')
	DROP INDEX ba_sarta_batch.ba_sarta_batch_Key
go

/* ba_lectura.ba_lectura_Key */
print '=====> ba_lectura.ba_lectura_Key'
go

if exists (select name from sysindexes where name='ba_lectura_Key')
	DROP INDEX ba_lectura.ba_lectura_Key
go

/* ba_fecha_cierre.ba_fecha_cierre_key  */
print '=====> ba_fecha_cierre.ba_fecha_cierre_key'
go

if exists (select name from sysindexes where name='ba_fecha_cierre_key')
	DROP INDEX ba_fecha_cierre.ba_fecha_cierre_key
go

/*ba_enlace.ba_enlace_Key*/
print '=====> ba_enlace.ba_enlace_Key'
go

if exists (select name from sysindexes where name='ba_enlace_Key')
	DROP INDEX ba_enlace.ba_enlace_Key
go

/*ba_tsarta.ba_tsarta_Key*/
print '=====> ba_tsarta.ba_tsarta_Key'
go

if exists (select name from sysindexes where name='ba_tsarta_Key')
	DROP INDEX ba_tsarta.ba_tsarta_Key
go

/*ba_tsarta_batch.ba_tsarta_batch_Key*/
print '=====> ba_tsarta_batch.ba_tsarta_batch_Key'
go

if exists (select name from sysindexes where name='ba_tsarta_batch_Key')
	DROP INDEX ba_tsarta_batch.ba_tsarta_batch_Key
go

/*ba_tenlace.ba_tenlace_Key*/
print '=====> ba_tenlace.ba_tenlace_Key'
go

if exists (select name from sysindexes where name='ba_tenlace_Key')
	DROP INDEX ba_tenlace.ba_tenlace_Key
go


/*ba_tparametro.ba_tparametro_Key*/
print '=====> ba_tparametro.ba_tparametro_Key'
go

if exists (select name from sysindexes where name='ba_tparametro_Key')
	DROP INDEX ba_tparametro.ba_tparametro_Key
go


/*ba_sarta_batch_exec.ba_sarta_batch_exec_Key*/
print '=====> ba_sarta_batch_exec.ba_sarta_batch_exec_Key'
go

if exists (select name from sysindexes where name='ba_sarta_batch_exec_Key')
	DROP INDEX ba_sarta_batch_exec.ba_sarta_batch_exec_Key
go


/*ba_enlace_exec.ba_enlace_exec_Key*/
print '=====> ba_enlace_exec.ba_enlace_exec_Key'
go

if exists (select name from sysindexes where name='ba_enlace_exec_Key')
	DROP INDEX ba_enlace_exec.ba_enlace_exec_Key
go


/*ba_sarta_batch_log.ba_sarta_batch_log_Key*/
print '=====> ba_sarta_batch_log.ba_sarta_batch_log_Key'
go

if exists (select name from sysindexes where name='ba_sarta_batch_log_Key')
	DROP INDEX ba_sarta_batch_log.ba_sarta_batch_log_Key
go

/*ba_enlace_log_Key.ba_enlace_log_Key*/
print '=====> ba_enlace_log_Key.ba_enlace_log_Key'
go

if exists (select name from sysindexes where name='ba_enlace_log_Key')
	DROP INDEX ba_enlace_log_Key.ba_enlace_log_Key
go

/*ba_lec_off.ba_lec_off_Key*/
print '=====> ba_lec_off.ba_lec_off_Key'
go

if exists (select name from sysindexes where name='ba_lec_off_Key')
	DROP INDEX ba_lec_off.ba_lec_off_Key
go

/*ba_aprobacion.ba_aprobacion_Key*/
print '=====> ba_aprobacion.ba_aprobacion_Key'
go

if exists (select name from sysindexes where name='ba_aprobacion_Key')
	DROP INDEX ba_aprobacion.ba_aprobacion_Key
go

/*ba_path_pro.ba_path_pro_Key*/
print '=====> ba_path_pro.ba_path_pro_Key'
go

if exists (select name from sysindexes where name='ba_path_pro_Key')
	DROP INDEX ba_path_pro.ba_path_pro_Key
go


/*ba_corrida.ba_corrida_Key*/
print '=====> ba_corrida.ba_corrida_Key'
go

if exists (select name from sysindexes where name='ba_corrida_Key')
	DROP INDEX ba_corrida.ba_corrida_Key
go

/*ba_vlpid.ba_vlpid_Key*/
print '=====> ba_vlpid.ba_vlpid_Key'
go

if exists (select name from sysindexes where name='ba_vlpid_Key')
	DROP INDEX ba_vlpid.ba_vlpid_Key
go


--------------------------------------------------------------------------------------
-- PJA: 12 MAYO 2011
-- Estructura Diaria para esquema de almacenamiento para el registro de errores que se 
-- presenten durante la ejecución de los procesos batch. 
--------------------------------------------------------------------------------------


print '=====> ba_error_batch.ba_error_batch_key'
go

if exists (select name from sysindexes where name='ba_error_batch_key')
   drop index ba_error_batch.ba_error_batch_key
go



print '=====> ba_error_batch.ba_error_batch_idx'
go

if exists (select name from sysindexes where name='ba_error_batch_idx')
   drop index ba_error_batch.ba_error_batch_idx
go



--------------------------------------------------------------------------------------
-- PJA: 12 MAYO 2011
-- Estructura Histórica para esquema de almacenamiento para el registro de errores que 
-- se presenten durante la ejecución de los procesos batch. 
--------------------------------------------------------------------------------------

print '=====> ba_error_batch_his.ba_error_batch_his_key'
go

if exists (select name from sysindexes where name='ba_error_batch_his_key')
   drop index ba_error_batch_his.ba_error_batch_his_key
go


print '=====> ba_error_batch_his.ba_error_batch_his_idx'
go

if exists (select name from sysindexes where name='ba_error_batch_his_idx')
   drop index ba_error_batch_his.ba_error_batch_his_idx
go


