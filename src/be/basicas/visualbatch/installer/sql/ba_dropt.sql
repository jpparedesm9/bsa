/********************************************************************************************/ 
/*   Script para eliminacion de tablas                                                      */ 
/*   de la base de datos de : cobis - Modulo visual batch                                   */                                                                                                                                                                  
/********************************************************************************************/ 
  
use cobis                
go 
  
print 'ba_aprobacion'                  
if exists (select 1 from sysobjects where name = 'ba_aprobacion')                  
    drop table ba_aprobacion                  
go 
print 'ba_batch'                       
if exists (select 1 from sysobjects where name = 'ba_batch')                       
    drop table ba_batch                       
go 
print 'ba_corrida'                     
if exists (select 1 from sysobjects where name = 'ba_corrida')                     
    drop table ba_corrida                     
go 
print 'ba_enlace'                      
if exists (select 1 from sysobjects where name = 'ba_enlace')                      
    drop table ba_enlace                      
go 
print 'ba_enlace_exec'                 
if exists (select 1 from sysobjects where name = 'ba_enlace_exec')                 
    drop table ba_enlace_exec                 
go 
print 'ba_enlace_log'                  
if exists (select 1 from sysobjects where name = 'ba_enlace_log')                  
    drop table ba_enlace_log                  
go 
print 'ba_fecha_cierre'                
if exists (select 1 from sysobjects where name = 'ba_fecha_cierre')                
    drop table ba_fecha_cierre                
go 
print 'ba_fecha_proceso'               
if exists (select 1 from sysobjects where name = 'ba_fecha_proceso')               
    drop table ba_fecha_proceso               
go 
print 'ba_impresora'                   
if exists (select 1 from sysobjects where name = 'ba_impresora')                   
    drop table ba_impresora                   
go 
print 'ba_lec_off'                     
if exists (select 1 from sysobjects where name = 'ba_lec_off')                     
    drop table ba_lec_off                     
go 
print 'ba_lectura'                     
if exists (select 1 from sysobjects where name = 'ba_lectura')                     
    drop table ba_lectura                     
go 
print 'ba_log'                         
if exists (select 1 from sysobjects where name = 'ba_log')                         
    drop table ba_log                         
go 
print 'ba_log_mgv'                     
if exists (select 1 from sysobjects where name = 'ba_log_mgv')                     
    drop table ba_log_mgv                     
go 
print 'ba_parametro'                   
if exists (select 1 from sysobjects where name = 'ba_parametro')                   
    drop table ba_parametro                   
go 
print 'ba_path_pro'                    
if exists (select 1 from sysobjects where name = 'ba_path_pro')                    
    drop table ba_path_pro                    
go 
print 'ba_login_batch'                       
if exists (select 1 from sysobjects where name = 'ba_login_batch')                       
    drop table ba_login_batch                       
go 
print 'ba_sarta'                       
if exists (select 1 from sysobjects where name = 'ba_sarta')                       
    drop table ba_sarta                       
go 
print 'ba_sarta_batch'                 
if exists (select 1 from sysobjects where name = 'ba_sarta_batch')                 
    drop table ba_sarta_batch                 
go 
print 'ba_sarta_batch_exec'            
if exists (select 1 from sysobjects where name = 'ba_sarta_batch_exec')            
    drop table ba_sarta_batch_exec            
go 
print 'ba_sarta_batch_log'             
if exists (select 1 from sysobjects where name = 'ba_sarta_batch_log')             
    drop table ba_sarta_batch_log             
go 
print 'ba_secuencial'                  
if exists (select 1 from sysobjects where name = 'ba_secuencial')                  
    drop table ba_secuencial                  
go 
print 'ba_tenlace'                     
if exists (select 1 from sysobjects where name = 'ba_tenlace')                     
    drop table ba_tenlace                     
go 
print 'ba_tparametro'                  
if exists (select 1 from sysobjects where name = 'ba_tparametro')                  
    drop table ba_tparametro                  
go 
print 'ba_tran_servicio'               
if exists (select 1 from sysobjects where name = 'ba_tran_servicio')               
    drop table ba_tran_servicio               
go 
print 'ba_tsarta'                      
if exists (select 1 from sysobjects where name = 'ba_tsarta')                      
    drop table ba_tsarta                      
go 
print 'ba_tsarta_batch'                
if exists (select 1 from sysobjects where name = 'ba_tsarta_batch')                
    drop table ba_tsarta_batch                
go 
print 'ba_vlpid'                       
if exists (select 1 from sysobjects where name = 'ba_vlpid')                       
    drop table ba_vlpid                       
go 

--------------------------------------------------------------------------------------
-- PJA: 12 MAYO 2011
-- Estructura Diaria para esquema de almacenamiento para el registro de errores que se 
-- presenten durante la ejecución de los procesos batch. 
--------------------------------------------------------------------------------------

print 'ba_error_batch'                       
if exists (select 1 from sysobjects where name = 'ba_error_batch')                       
   drop table ba_error_batch
go 

--------------------------------------------------------------------------------------
-- PJA: 12 MAYO 2011
-- Estructura Histórica para esquema de almacenamiento para el registro de errores que 
-- se presenten durante la ejecución de los procesos batch. 
--------------------------------------------------------------------------------------

print 'ba_error_batch_his'                       
if exists (select 1 from sysobjects where name = 'ba_error_batch_his')                       
   drop table ba_error_batch_his
go 

--------------------------------------------------------------------------------------
-- ARO: 09 Julio 2012
-- Correccion para eliminar el script ba_ftp.sql que no debia existir
-- Correccion para eliminar el script ba_habilita.sql que no debia existir
--------------------------------------------------------------------------------------

print 'ba_ftp'
if exists (select 1 from sysobjects where name = 'ba_ftp')                       
   drop table ba_ftp
go

print 'ba_habilita'
if exists (select 1 from sysobjects where name = 'ba_habilita')                       
   drop table ba_habilita
go
---------------------------------------------------------------------------------------


print 'ad_respaldo'
if exists (select 1 from sysobjects where name = 'ad_respaldo')                       
   drop table ad_respaldo
go



