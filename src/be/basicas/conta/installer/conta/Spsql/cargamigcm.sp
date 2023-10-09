/************************************************************************/
/*      Archivo           :  cargamigc.sp                                */
/*      Base de datos     :  cob_conta                                  */
/*      Producto          :  Contabilidad                               */
/*      Disenado por      :  Jose Rafael Molano Z.                      */
/*      Fecha de escritura:  Abril 24 de 2008                           */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*     Consolidar todos los procesos que se realizan en la migracion    */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR           RAZON                           */
/************************************************************************/
use cob_conta
go

set ansi_nulls off
go

if exists (select 1 from sysobjects where name = 'sp_carmigcm')
   drop proc sp_carmigcm
go

create proc sp_carmigcm (
@i_param1   varchar(255),               --EMPRESA
@i_param2   varchar(255),               --ARCHIVO
@i_param3   varchar(255) = 'N'          --DEBUG
)
as
declare
@w_nombre_programa    varchar(100),
@w_path_listados      varchar(300),
@w_longitud           int,
@w_plano              varchar(255),
@w_s_app              varchar(300),
@w_cmd                varchar(350),
@w_errores            varchar(350),
@w_comando            varchar(350),
@w_error              int,
@i_empresa            tinyint,
@i_archivo            varchar(100),
@i_debug              char(1),
@w_reg                int,
@w_reg_arch           int,
@w_ruta               varchar(300),
@w_arch               varchar(300)

select @w_ruta = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

select @i_empresa = convert(tinyint, @i_param1)
select @i_archivo = convert(varchar(100), @i_param2)
select @i_debug   = convert(char(1), @i_param3)

select @w_nombre_programa = 'cargamigc.sp'

truncate table cob_conta..cb_estado_mig
truncate table cob_conta..cb_convivencia_tmp
truncate table cob_conta..cb_log_errores_mig
truncate table cob_conta..cb_scomprobante_mig
truncate table cob_conta..cb_sasiento_mig
delete from cob_conta..cb_registro

if exists(select 1 from sysobjects where name = 'cb_val_arch' and type = 'U') begin
   drop table cb_val_arch
end

create table cb_val_arch (
   registros varchar(255)
)

select @w_longitud = len(@i_archivo)

print @w_longitud

if @w_longitud > 50 begin
   print 'Longitud del nombre del archivo superior al permitido (50)'
   return 1
end

select @w_path_listados = pp_path_destino
from cobis..ba_path_pro  
where pp_producto = 6

select @w_plano = substring (pp_path_destino, 1, charindex('Conta', pp_path_destino)+5) + 'convivencia\datosentrada\'
from cobis..ba_path_pro  
where pp_producto = 6

select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

select @w_errores  = @w_path_listados + @i_archivo + '.err'
select @w_cmd      = @w_s_app + 's_app bcp cob_conta..cb_convivencia_tmp in '
select @w_comando  = @w_cmd + @w_plano + @i_archivo + ' -b5000 -c -e' + @w_errores + ' -t' + '"' +'&&'+ '"' + ' -auto -login ' + '-config ' + @w_s_app + 's_app.ini'

if @i_debug = 'S' begin
   print 'path salida'
   print @w_cmd
   print @w_path_listados
   print @w_comando 
   print @w_errores
end 

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
    print 'Error cargando Archivo: ' + @i_archivo
    print @w_comando
end

select @w_comando = ''
select @w_comando = 'wc -l ' + @w_plano + '\' + @i_archivo + ' > ' + @w_path_listados + '\salida.out'

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   print 'Error validando cantidad de registros'
   print @w_comando
   return 1
end   

select @w_cmd =  @w_s_app + 's_app bcp -auto -login cob_conta..cb_val_arch in ',
       @w_errores  = @w_path_listados + @i_archivo + '.err'
select @w_comando = @w_cmd + @w_path_listados + '\' + 'salida.out' + ' -b5000 -c -e' + @w_errores + ' -t"|" ' + '-config '+  + @w_ruta + 's_app.ini'
exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   print 'Error Cargando numero de registros del archivo'
   print @w_comando
   return 1
end

select @w_arch = registros
from cob_conta..cb_val_arch

select @w_arch
select @w_reg_arch = convert(int, rtrim(ltrim(substring (ltrim(@w_arch), 1, charindex(' ', ltrim(@w_arch))))))
select @w_reg_arch = isnull(@w_reg_arch, 0)

select @w_reg = count(1) from cob_conta..cb_convivencia_tmp

if @w_reg <> @w_reg_arch begin
   print 'NO SE CARGO EL ARCHIVO CORRECTAMENTE, POR FAVOR VALIDAR'
   print 'registros tabla: ' + cast(@w_reg as varchar)
   print 'registros archivo: ' + cast(@w_reg_arch as varchar)
   return 1
end

if @w_reg = 0 begin
   print 'NO SE CARGO EL ARCHIVO CORRECTAMENTE, POR FAVOR VALIDAR'
   return 1
end

return 0

go
   
