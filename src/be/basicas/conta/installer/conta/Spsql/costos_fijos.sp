/************************************************************************/
/*      Archivo:                costos_pfijo.sp                         */
/*      Base de datos:          cob_conta                               */
/*      Producto:               contabilidad                            */
/*      Disenado por:           jose Molano                             */
/*      Fecha de escritura:     05/21/2014                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA".                                                       */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*  carga los costos por CDTS, para balance de apertura para NIIF       */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA          AUTOR                    RAZON                       */
/*  Mayo/21/2014   Jose Molano           Creacion Inicial NR 429        */
/************************************************************************/

use cob_conta
go

if exists(select 1 from cob_conta..sysobjects where name = 'sp_costos_pfijo' and type = 'P') 
   drop proc sp_costos_pfijo 
go

create proc sp_costos_pfijo
@i_param1   varchar(50)
as
declare 
@i_archivo  varchar(50),
@w_path_lis varchar(50),
@w_comando  varchar(500),
@w_ruta     varchar(50),
@w_msg      varchar(100),
@w_s_app    varchar(100),
@w_error    varchar(100),
@w_destino  varchar(255),
@w_errores  varchar(255),
@w_arch     varchar(255),
@w_reg_arch         int,
@w_reg              int

select @i_archivo = @i_param1

select @w_path_lis = pp_path_destino
from cobis..ba_path_pro  
where pp_producto = 6

select @w_ruta = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

truncate table cob_externos..ex_costos_pfijo

select @w_comando = 'wc -l ' + @w_path_lis + @i_archivo + ' > ' + @w_path_lis + 'salida.out'

print @w_comando

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   select @w_msg = '[sp_costos_pfijo] Error validando cantidad de registros ' + @w_comando
   print  @w_msg
   return 1
end   

select @w_s_app =  's_app bcp -auto -login cob_externos..ex_val_arch in '
select @w_destino  = @w_path_lis + @i_archivo,
       @w_errores  = @w_path_lis + @i_archivo + '.err'
select @w_comando = @w_ruta + @w_s_app + @w_path_lis + 'salida.out' + ' -b5000 -c -e' + @w_errores + ' -t"|" ' + '-config '+  + @w_ruta + 's_app.ini'

print @w_comando

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   select @w_msg = '[sp_costos_pfijo] Error Cargando numero de registros del archivo ' + @w_comando
   return 1
end

select @w_arch = registros
from cob_externos..ex_val_arch

select @w_arch
select @w_reg_arch = convert(int, rtrim(ltrim(substring (ltrim(@w_arch), 1, charindex(' ', ltrim(@w_arch))))))
select @w_reg_arch = isnull(@w_reg_arch, 0)

select @w_s_app    = 's_app bcp -auto -login cob_externos..ex_costos_pfijo in '
select @w_destino  = @w_path_lis + @i_archivo,
       @w_errores  = @w_path_lis + @i_archivo + '.err'
select @w_comando  = @w_ruta + @w_s_app + @w_path_lis + '\' + @i_archivo + ' -b5000 -c -e' + @w_errores + ' -t"|" ' + '-config '+  + @w_ruta + 's_app.ini'

print @w_comando

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   select @w_msg = '[sp_costos_pfijo] Error Cargando archivo: ' + @i_archivo
insert into cl_error_log (er_fecha_proc, er_usuario, er_descripcion) values (getdate(), 'op_batch', @w_msg)
   print  @w_msg
   return 1
end

select @w_reg = count(1) from cob_externos..ex_costos_pfijo

if @w_reg <> @w_reg_arch begin
   select @w_msg = '[sp_costos_pfijo] NO SE CARGO EL ARCHIVO CORRECTAMENTE, POR FAVOR VALIDAR'
   print  @w_msg
   return 1
end

if @w_reg = 0 begin
   select @w_msg = '[sp_costos_pfijo] NO SE CARGO EL ARCHIVO CORRECTAMENTE, POR FAVOR VALIDAR'
   print  @w_msg
   return 1
end

return 0

go
