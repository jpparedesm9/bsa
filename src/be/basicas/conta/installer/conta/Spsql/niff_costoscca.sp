/************************************************************************/
/*  Archivo:            niff_costoscca.sp                               */
/*  Stored procedure:   sp_niif_costoscca                               */
/*  Base de datos:      cob_conta                                       */
/*  Producto:           contabilidad                                    */
/*  Disenado por:       Alejandra Celis                                 */
/*  Fecha de escritura: 09-Mayo-2014                                    */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/* Realizar el Cargue de Costos Adicionales para la Interface CORVUS    */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA         AUTOR                      RAZON                      */
/*  09/May/2014   Alejandra Celis         429 Emision Inicial           */
/************************************************************************/
use cob_conta
go

if exists (select 1 from sysobjects where name = 'sp_niif_costoscca')
   drop proc sp_niif_costoscca
go

SET ANSI_NULLS OFF
GO

create proc sp_niif_costoscca (
@i_param1            varchar(50)  =null
)
as
declare
@w_int                      int            ,
@w_total                    int            ,
@w_error                    int            ,
@w_app                      varchar(50)    ,
@w_s_app                    varchar(30)    ,
@w_path                     varchar(255)   ,
@w_archivo                  varchar(64)    ,   
@w_comando                  varchar(1000)  ,
@w_destino                  varchar(2500)  ,
@w_fecha_crea               datetime       ,
@w_errores                  varchar(1500)  ,
@w_arch                     varchar(255)   ,
@w_reg_arch                 int            ,
@w_reg                      int            ,
@w_mensaje                  varchar(200)

print 'INICIA PROCESO con archivo ..' + @i_param1

/*********SE CARGA LA INFORMACION DESDE EL ARCHIVO PLANO***********/

/*******OBTIENE LA RUTA DEL S_APP*************/
select @w_s_app    = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'S_APP'     

if @@rowcount = 0
begin
   select @w_error = 103115,
   @w_mensaje = 'NO SE ENCONTRO EL PARAMETRO S_APP. '
   goto ERRORFIN
end


/*********OBTIENE LA RUTA DONDE SE CARGA EL ARCHIVO PLANO********/
select @w_path =pp_path_destino
from   cobis..ba_path_pro
where  pp_producto = 6

if @@rowcount = 0
begin
   select @w_error = 103115,
   @w_mensaje = 'NO SE ENCONTRO LA RUTA DONDE SE CARGA EL ARCHIVO PLANO. '
   goto ERRORFIN
end

truncate table cob_conta_super..cb_costos_adic

/*******CARGA EN VARIABLE @W_COMANDO********/
select @w_comando = 'wc -l ' + @w_path  + @i_param1 + ' > ' + @w_path + 'salida.out'
exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 
begin
   print 'Error validando cantidad de registros'
   print @w_comando
   return 1
end   
delete cobis..cl_val_arch
select @w_app =  's_app bcp -auto -login cobis..cl_val_arch in '
select @w_destino  = @w_path + @i_param1,
       @w_errores  = @w_path + @i_param1 + '.err'
select @w_comando =  @w_s_app + @w_app + @w_path  + 'salida.out' + ' -b5000 -c -e' + @w_errores + ' -t"|" ' + '-config '+  + @w_s_app + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
    print 'Error Cargando numero de registros del archivo'
    print @w_comando
    return 1
end
   
select @w_arch = registros
from cobis..cl_val_arch

select @w_arch
select @w_reg_arch = convert(int, rtrim(ltrim(substring (ltrim(@w_arch), 1, charindex(' ', ltrim(@w_arch))))))
select @w_reg_arch = isnull(@w_reg_arch, 0)

select @w_comando = @w_s_app +'s_app'+ ' bcp -auto -login cob_conta_super..cb_costos_adic  in '  +
       @w_path + @i_param1  + ' -b100 -t"|" -c -e'+ @w_path + @i_param1  + '.err'  + 
       ' -config '+ @w_s_app + 's_app.ini'
                    
                   
/*********SE EJECUTA CON CMDSHELL*******/
exec @w_error = xp_cmdshell @w_comando 
   
if @w_error <> 0 
begin
   select @w_mensaje = 'ERROR AL CARGAR ARCHIVO. '+@i_param1 + ' '+ convert(varchar, @w_error)
   goto ERRORFIN
end
else
begin
   /* Solamente deja el archivo definitivo, se eliminan los archivos temporales */
   select @w_comando = 'del ' + @w_path + @i_param1 + '.err'
   exec @w_error = xp_cmdshell @w_comando
   if @w_error <> 0 begin
      select @w_error = 808022, @w_mensaje = 'ERROR AL ELIMINAR ARCHIVOS TEMPORALES DE TRABAJO.'
      print @w_comando
      goto ERRORFIN
   end
end

select  @w_reg = count(1) from cob_conta_super..cb_costos_adic

if (@w_reg <> @w_reg_arch ) or  @w_reg_arch  = 0
begin
   delete cob_conta_super..cb_costos_adic
   select @w_mensaje = 'Error Cargando Archivo Costos Adicionales.  El numero de Regs no coincide --> ' + @w_destino
   goto ERRORFIN
end
   
return 0
ERRORFIN: 
   select @w_mensaje = 'ERROR: ' + 'sp_niif_costoscca' + ' --> ' + @w_mensaje
   print @w_mensaje
   return 1
go

/*
delete     cobis..cl_val_arch
delete cob_conta_super..cb_costos_adic
exec sp_niif_costoscca 
@i_param1        = 'costos_adic.txt'
select * from cobis..cl_val_arch
select * from cob_conta_super..cb_costos_adic
delete  cob_conta..cb_costos_adic
)
*/