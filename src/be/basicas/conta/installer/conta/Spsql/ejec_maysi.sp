/************************************************************************/
/*	Archivo: 		    ejec_maysi.sp                                   */
/*	Stored procedure: 	sp_ejec_maysi  	                                */
/*	Base de datos:  	cob_conta  				                        */
/*	Producto:           Contabilidad               	                    */
/*	Disenado por:       Andres Muñoz                                    */
/*	Fecha de escritura: Abril de 2012				                    */
/************************************************************************/
/*                          IMPORTANTE 	                                */
/*	Este programa es parte de los paquetes bancarios propiedad de	    */
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	        */
/*	"NCR CORPORATION".						                            */
/*	Su uso no autorizado queda expresamente prohibido asi como	        */
/*	cualquier alteracion o agregado hecho por alguno de sus		        */
/*	usuarios sin el debido consentimiento por escrito de la 	        */
/*	Presidencia Ejecutiva de MACOSA o su representante.		            */
/*                           PROPOSITO                                  */
/*                                                                      */
/*                         MODIFICACIONES                               */
/*	FECHA		AUTOR		  RAZON				                        */
/************************************************************************/

use cob_conta
go

if exists(select 1 from cob_conta..sysobjects where name = 'sp_ejec_maysi' and xtype = 'P')
   drop proc sp_ejec_maysi
go

create proc sp_ejec_maysi
(
@i_param1    tinyint,  --EMPRESA
@i_param2    datetime  --FECHA
)
as
declare 
@i_empresa    tinyint,
@i_fecha      datetime,
@w_sp_name    varchar(64),
@w_particion  tinyint,
@w_return     int,
@w_fecha      datetime,
@w_error      int,
@w_msg        varchar(256)

/* CARGA INICIAL DE VARIABLES DE TRABAJO */
select 
@w_sp_name   = 'sp_ejec_maysi',
@w_particion = 1,
@i_empresa   = convert(tinyint, @i_param1),
@i_fecha     = convert(datetime, @i_param2)

/* CARGA DE PARAMETRO FECHA PROCESO*/
select @w_fecha = fp_fecha
from cobis..ba_fecha_proceso

/***  VALIDACION PASO A DEFINITIVOS ***/
select 1 
from cobis..ba_log
where lo_batch in (select ba_batch
                   from cobis..ba_batch 
                   where ba_arch_fuente = 'cb_consu.sqr')
and   lo_estatus = 'E'
and   lo_fecha_inicio >= convert(varchar(10), @w_fecha, 101)

if @@rowcount > 0
begin
   select 
   @w_error = 601602,
   @w_msg   = 'NO SE PERMITE MAYORIZACIÓN MIENTRAS SE EJECUTA PASO A DEFINITIVOS'
   goto ERROR 
end

/***  VALIDACION PRODUCTO HABILITADO  ***/
select 1
from cobis..cl_pro_moneda
where pm_producto = 6
and   pm_estado = 'V'

if @@rowcount > 0
begin
   select 
   @w_error = 601603,
   @w_msg   = 'ERROR PRODUCTO CONTABILIDAD HABILITADO'
   goto ERROR 
end

/*** VALIDACION EXISTENCIA DE LA TABLA DE TRABAJO ***/
if exists(select 1 from sysobjects where name = 'cb_tmp_may' and xtype = 'U')
   drop table cb_tmp_may

create table cb_tmp_may(
secuencial 	     numeric(10,0) identity not null,
co_empresa 	     tinyint         not null,
co_cuenta	     cuenta_contable not null,
co_fecha_tran    datetime        not null, 
co_oficina_dest	 smallint        not null, 
co_area_dest     smallint        not null,
co_debito        money           not null,
co_credito       money           not null,
co_debito_me     money           not null,
co_credito_me    money           not null,
co_estado        char(1)         not null
)

create clustered index cb_tmp_may_Key on cb_tmp_may(secuencial)

if @@trancount = 0
   begin tran

execute cob_conta..sp_maysi
@i_empresa      = @i_empresa,
@i_fecha_tran   = @i_fecha,
@i_nro_procesos = @w_particion,
@i_opcion       = 0

if @@error <> 0
begin
   select 
   @w_error = '601604',
   @w_msg = 'Error opcion 0 sp_maysi'
   goto ERROR
end


execute cob_conta..sp_maysi
@i_empresa    =  @i_empresa,
@i_fecha_tran =  @i_fecha,
@i_opcion     =  1,
@i_proceso    =  1

if @@error <> 0
begin
   select
   @w_error = '601604',
   @w_msg    = 'Error opcion 1 sp_maysi'
   goto ERROR
end

execute cob_conta..sp_maysi
@i_empresa      = 1,
@i_fecha_tran   = @i_fecha,
@i_opcion       = 2

if @@error <> 0
begin
   select
   @w_error = '601604',
   @w_msg    = 'Error opcion 2 sp_maysi'
   goto ERROR
end

while @@trancount > 0
begin
   commit tran
end
   
return 0

/* ETIQUETA DE ERRORES Y ROLLBACK */
ERROR:

exec cobis..sp_cerror     
@t_from  = @w_sp_name,    
@i_num   = @w_error,      
@i_msg   = @w_msg         

while @@trancount > 0 begin
   rollback tran
end
                            
return @w_error 
   
go