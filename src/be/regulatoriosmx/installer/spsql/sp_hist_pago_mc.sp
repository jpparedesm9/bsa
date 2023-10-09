/************************************************************************/
/*  Archivo:                sp_hist_pago_mc.sp                          */
/*  Stored procedure:       sp_hist_pago_mc                             */
/*  Base de Datos:          cob_conta_super                             */
/*  Producto:               cob_conta_super                             */
/*  Disenado por:           PXSG                                        */
/*  Fecha de Documentacion: 02/12/2019                                  */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/* Devuelve la fecha para Eliminar las carpetas del FTP de Interfactura */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR                   RAZON                           */
/* 02/12/2019    PXSG                  Emision Inicial                  */
/* **********************************************************************/

use cob_conta_super
go

if exists(select 1 from sysobjects where name ='sp_hist_pago_mc')
	drop proc sp_hist_pago_mc
go

create proc sp_hist_pago_mc (
	@i_num_prestamo	varchar(24),
	@i_operacion   	varchar(10),
	@t_show_version	bit             = 0,
	@t_debug          char(1)         = 'N',
	@t_file           varchar(10)     = null
	
)

AS

Declare
	@w_sp_name          varchar(32),
	@w_op_toperacion    varchar(20),
	@w_ciclo_vig_grupal int ,
	@w_ciclo_max_grupal int ,
	@w_num_grp          int,
	@w_fecha_proceso    datetime,
	@w_error            int

if @t_show_version = 1
begin
    print 'Stored procedure sp_hist_pago_mc, Version 1.0.0'
    return 0
end
--------------------------------------------------------------------------------------

/*  Inicializacion de Variables  */
select  @w_sp_name = 'sp_hist_pago_mc'

select @w_fecha_proceso=fp_fecha 
from   cobis..ba_fecha_proceso
     
--Consulta de servicio 
if @i_operacion = 'Q'
begin 
select 
@w_fecha_proceso=fp_fecha 
from cobis..ba_fecha_proceso

select 
@w_op_toperacion=op_toperacion 
from   cob_cartera..ca_operacion
where  op_banco=@i_num_prestamo

--Validaciones para Operacion Grupal
if(@w_op_toperacion='GRUPAL')
begin

select 
top 1  @w_num_grp=tg_grupo 
from   cob_credito..cr_tramite_grupal
where  tg_referencia_grupal=@i_num_prestamo

select 
@w_ciclo_max_grupal=max(dc_ciclo_grupo) 
from   cob_cartera..ca_det_ciclo, cob_cartera..ca_ciclo,
       cob_cartera..ca_operacion
where  dc_referencia_grupal = ci_prestamo
and    op_operacion         = dc_operacion
and    ci_grupo             = @w_num_grp

select 
@w_ciclo_vig_grupal=max(dc_ciclo_grupo) 
from  cob_cartera..ca_det_ciclo, cob_cartera..ca_ciclo, 
      cob_cartera..ca_operacion
where dc_referencia_grupal   = ci_prestamo
and   op_operacion           = dc_operacion
and   dc_referencia_grupal   = @i_num_prestamo

                 
if(@w_ciclo_max_grupal<>@w_ciclo_vig_grupal)   
 begin
     select @w_error = 3600002 -- 'EL PRESTAMO NO TIENE UN CICLO VIGENTE'
	  goto ERROR
 end  
 
select 
co_secuencial,
convert(varchar(10),co_fecha_valor,103),
co_monto
from   cob_cartera..ca_operacion,cob_cartera..ca_corresponsal_trn
where op_operacion= co_codigo_interno
and   op_banco    = @i_num_prestamo
and   co_estado   = 'P'
and   co_accion   = 'I'
order by co_secuencial 

return 0
          
end

--Validaciones para Operacion Individual
if(@w_op_toperacion='INDIVIDUAL') begin

	if not exists(select 1 from ca_operacion,ca_estado
					  where op_toperacion='INDIVIDUAL'
					  and   op_banco=@i_num_prestamo
					  and  op_estado=es_codigo
					  and  es_procesa='S')
   begin
	  	select @w_error = 3600003 -- 'EL PRESTAMO NO SE ENCUENTRA VIGENTE'
	   goto ERROR
   end

end 

--Validaciones para Revolvente
if(@w_op_toperacion='REVOLVENTE')

begin

	if not exists(select 1 from cob_cartera..ca_operacion
	              where  op_toperacion     = 'REVOLVENTE'
  				     and    op_banco          = @i_num_prestamo
	              and    @w_fecha_proceso  between op_fecha_ini and op_fecha_fin)
	begin
	
	   select @w_error = 3600003 -- 'EL PRESTAMO NO SE ENCUENTRA VIGENTE'
	   goto ERROR
	
	end

end

select 
cd_sec_ing,
convert(varchar(10),co_fecha_valor,103),
co_monto
from   cob_cartera..ca_operacion,cob_cartera..ca_corresponsal_trn,
       cob_cartera..ca_corresponsal_det
where  op_operacion  = co_codigo_interno
and    cd_operacion  = op_operacion
and    cd_secuencial = co_secuencial
and    op_banco      = @i_num_prestamo
and    co_estado     = 'P'
and    co_accion     = 'I'
order by cd_sec_ing 

end--Fin Operacion Q

return 0 

ERROR:
    begin --Devolver mensaje de Error
        --select @w_error
        exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = @w_error

        return @w_error
    end

go
