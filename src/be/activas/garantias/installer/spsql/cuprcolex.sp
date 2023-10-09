/******************************************************************/
/*  Archivo:            cuprcolex.sp                             */
/*  Stored procedure:   sp_prcolate_ex                            */
/*  Base de datos:      cob_custodia                              */
/*  Producto:           Custodia                                  */
/*  Disenado por:       Gabriel Alvis                             */
/*  Fecha de escritura: 22/Abr/2009                               */
/******************************************************************/
/*                          IMPORTANTE                            */
/*  Este programa es parte de los paquetes bancarios propiedad de */
/*  'MACOSA'                                                      */
/*  Su uso no autorizado queda expresamente prohibido asi como    */
/*  cualquier alteracion o agregado hecho por alguno de sus       */
/*  usuarios sin el debido consentimiento por escrito de la       */
/*  Presidencia Ejecutiva de MACOSA o su representante.           */
/******************************************************************/
/*                          PROPOSITO                             */
/*  Reemplazar al prcolate.sqr en funciones sirviendo de          */
/*  procedimiento cáscara en invocacion del SP                    */
/*  cob_custodia..sp_procesa_colateral                            */
/******************************************************************/
/*                          MODIFICACIONES                        */
/*  FECHA       AUTOR       RAZON                                 */
/*  22/Abr/09   G. Alvis    Emision Inicial                       */
/******************************************************************/

use cob_custodia
go

if object_id('sp_prcolate_ex') is not null
   drop proc sp_prcolate_ex
go

create proc sp_prcolate_ex
   @i_param1   varchar(255) = null,
   @i_param2   varchar(255) = null,
   @i_param3   varchar(255) = null,
   @i_param4   varchar(255) = null,
   @i_param5   varchar(255) = null,
   @i_param6   varchar(255) = null,
   @i_param7   varchar(255) = null
as

declare 
   @w_return      int,
   @i_fecha       datetime,
   @i_archivo     varchar(64),
   @i_simulacion  char(1)
   
select 
   @i_fecha      = convert(datetime,    @i_param1),  
   @i_archivo    = convert(varchar(64), @i_param2),
   @i_simulacion = convert(char(1),     @i_param3)     
   
select @i_simulacion = upper(@i_simulacion)

if @i_simulacion not in ('S', 'N')
begin
   print 'DEBE INGRESAR S/N PARA INDICAR SI SE TRATA DE UNA SIMULACION O NO'
   return 1
end

truncate table cu_colateral_det_tmp

exec @w_return = sp_carga_saldo_ext
@i_fecha      = @i_fecha,     
@i_archivo    = @i_archivo,   
@i_simulacion = @i_simulacion

if @w_return <> 0 goto ERROR

exec @w_return = sp_procesa_colateral
@i_fecha_proc   = @i_fecha,  
@i_simulacion   = @i_simulacion

if @w_return <> 0 goto ERROR

exec @w_return = sp_colateral_disp
@i_fecha_proc  = @i_fecha,
@i_simulacion  = @i_simulacion

if @w_return <> 0 goto ERROR

truncate table cu_universo_pagares_col
  
return 0
ERROR:   
return @w_return
   
go
