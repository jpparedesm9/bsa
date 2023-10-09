/************************************************************************/
/*   Archivo:            cb_carga322n.sp                                */
/*   Stored procedure:   sp_cargaof_niif                                */
/*   Base de datos:      cob_conta                                      */
/*   Producto:           contabilidad                                   */
/*   Fecha de escritura: Abr. 2015                                      */
/************************************************************************/
/*                               IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                          PROPOSITO                                   */
/*                                                                      */
/* Proceso que permite cargar a traves de archivos planos un aparametri-*/
/* zacion Niif que el banco entrega                                     */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA              AUTOR           RAZON                            */
/*  Octubre 10 2015    Luisa Bernal    Emision Inicial Bancamia         */
/************************************************************************/
use cob_conta
go

SET ANSI_NULLS OFF
GO

if exists (select 1 from sysobjects where name = 'sp_cargaof_niif')
   drop proc sp_cargaof_niif
go

create proc sp_cargaof_niif
@i_param1   datetime     = null,
@i_param2   varchar(100) = null     -- Nombre del Archivo a Cargar

as
declare
@w_sp_name            varchar(32),
@w_fecha_proceso      varchar(15),
@w_archivo            varchar(30),
@w_msg                descripcion,
@w_mensaje            descripcion,
@w_error              int,      
@w_s_app              varchar(50),
@w_path               varchar(50),
@w_comando            varchar(5000),
@w_campo_err          varchar(100),
@w_dato               varchar(100),
@w_errores_carga      int,
@w_anio               int,
@w_cmd                varchar(500),
@w_destino            varchar(500),
@w_errores            varchar(5000),
@w_error_tmp          int         ,
@w_error_bcp          int


set nocount on

---INICIALIZA VARIABLES
select
@w_sp_name       = 'sp_cargaof_niif',       
@w_fecha_proceso = convert(varchar(10), @i_param1, 112),
@w_archivo       = @i_param2,
@w_errores_carga = 0

---VALIDA QUE EL PARAMETRO Fecha de Corte HAYA SIDO ENVIADO
if @i_param1 is null
begin
   select
   @w_msg       = 'ERROR, FECHA NO VALIDA EN PARAMETRO 1',
   @w_campo_err = 'PARAMETRO 1',
   @w_dato      = @i_param1,
   @w_error     = 801085
   goto ERRORFIN
end

---VALIDA QUE EL PARAMETRO Nombre del Archivo HAYA SIDO ENVIADO
if @i_param2 is null
begin
   select
   @w_msg       = 'ERROR, NOMBRE DE ARCHIVO NO ENVIADO EN PARAMETRO 2',
   @w_campo_err = 'PARAMETRO 2',
   @w_dato      = @i_param2,
   @w_error     = 808007    
   goto ERRORFIN  
end

--- USO DE PARAMETROS 
select @w_s_app    = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

if @w_s_app is null
begin
   select 
   @w_msg       = 'ERROR CARGANDO PARAMETRO BCP',
   @w_campo_err = 'S_APP',
   @w_dato      = @w_s_app,
   @w_error     = 251142      
   goto ERRORFIN
end

--- PATH ORIGEN 
select @w_path     = pp_path_destino 
from   cobis..ba_path_pro
where  pp_producto = 6

If @w_path is null
begin
   select 
   @w_msg       = 'ERROR EN RUTA BATCH DE DESTINO, REVISAR PARAMETRIZACION',
   @w_campo_err = 'PATH',
   @w_dato      = @w_s_app,
   @w_error     = 251143           
   goto ERRORFIN
end 

select @w_anio = DATEPART(YYYY, @i_param1)

truncate table cob_externos..ex_cargue_balance_oficinas_niif

select 
@w_destino  = @w_path + @w_archivo,
@w_errores  = @w_path + 'balance_oficinas.err' 

--- CARGAS EN VARIABLE @W_COMANDO
select @w_comando = @w_s_app + 's_app bcp -auto -login cob_externos..ex_cargue_balance_oficinas_niif in ' +
                    @w_destino + ' -b5000 -c -e '+ @w_errores + ' -m 1 -t"|" ' + '-config '+ @w_s_app + 's_app.ini'
                    
--- EJECUTAR CON CMDSHELL 
exec @w_error = xp_cmdshell @w_comando
   
if @w_error = 0
begin
   print 'ARCHIVO CARGADO EXITOSAMENTE'
   if (select count(1) FROM cob_externos..ex_cargue_balance_oficinas_niif) = 0
   begin
      print 'NO SE CARGO NINGUN REGISTRO'
      select @w_mensaje = 'ERROR EN CARGUE, ARCHIVO TIENE CERO REGISTROS',
	         @w_error   = 208158
      goto ERRORFIN
   end
end
else
begin
   print 'ERROR - ' + cast(@w_error as varchar)
   select @w_mensaje = 'ERROR EN CARGUE, VALIDAR ESTRUCTURA DEL ARCHIVO'
   goto ERRORFIN
end

--VALIDACIONES DE NULIDAD
if ((select count(1) from cob_externos..ex_cargue_balance_oficinas_niif where co_fecha_corte is null) > 0)
begin
   print 'CAMPO FECHA NO PUEDE SER UN VALOR NULO'
   select @w_mensaje = 'ERROR DE ARCHIVO DE CARGA, REGISTROS CON FECHA VACIA',
      @w_error   = 601001
   goto ERRORFIN   
end

if ((select count(1) from cob_externos..ex_cargue_balance_oficinas_niif where co_cuenta is null) > 0)
begin
   print 'CAMPO CUENTA NO PUEDE SER UN VALOR NULO'
   select @w_mensaje = 'ERROR DE ARCHIVO DE CARGA, REGISTROS CON CUENTA VACIA',
       @w_error   = 601001
   goto ERRORFIN
end

if  ((select count(1) from cob_externos..ex_cargue_balance_oficinas_niif where co_oficina is null) > 0)
begin
   print 'CAMPO OFICINA NO PUEDE SER UN VALOR NULO'
   select @w_mensaje = 'ERROR DE ARCHIVO DE CARGA, REGISTROS CON OFICINA VACIA',
       @w_error   = 601001
   goto ERRORFIN
end
if ((select count(1) from cob_externos..ex_cargue_balance_oficinas_niif where co_saldo_cuenta is null) > 0)
begin
   print 'CAMPO SALDO CUENTA NO PUEDE SER UN VALOR NULO'
   select @w_mensaje = 'ERROR DE ARCHIVO DE CARGA, REGISTROS CON SALDO CUENTA VACIO',
       @w_error   = 601001
   goto ERRORFIN
end
if ((select count(1) from cob_externos..ex_cargue_balance_oficinas_niif where co_saldo_debito is null) > 0)
begin
   print 'CAMPO SALDO DEBITO NO PUEDE SER UN VALOR NULO'
   select @w_mensaje = 'ERROR DE ARCHIVO DE CARGA, REGISTROS CON SALDO DEBITO VACIO',
       @w_error   = 601001
   goto ERRORFIN
end
if ((select count(1) from cob_externos..ex_cargue_balance_oficinas_niif where co_saldo_credito is null) > 0)
begin
   print 'CAMPO SALDO CREDITO NO PUEDE SER UN VALOR NULO'
   select @w_mensaje = 'ERROR DE ARCHIVO DE CARGA, REGISTROS CON SALDO CREDITO VACIO',
       @w_error   = 601001
   goto ERRORFIN
end

if exists (select 1 from sysobjects where name = 'cb_tempo')
   drop table cb_tempo

create table cb_tempo (	
   valor         varchar(14) null,
   descripcion   varchar (100) null)

insert into cb_tempo values('VALOR', 'ERROR')

--VALIDACIONES DE ERROR 
insert into cb_tempo 
select 
co_fecha_corte, 'FECHA DE CORTE NO ES CORRECTA'
from  cob_externos..ex_cargue_balance_oficinas_niif
where co_fecha_corte in (select co_fecha_ini from cob_conta..cb_corte 
                         where co_estado     = 'N')
                         
if @@ERROR <> 0
begin
   select 
   @w_msg        = 'ERROR CARGANDO ERRORES DE CORTE',
   @w_campo_err  = 'CARGA DE DATOS cob_externos..carga_ofi_errores',
   @w_dato       = 'carga_ofi_errores',
   @w_error      = 4000051
   goto ERRORFIN
end 

insert into cb_tempo 
select 
co_cuenta, 'CUENTA NO SE ENCUENTRA PARAMETRIZADA'
from  cob_externos..ex_cargue_balance_oficinas_niif
where co_cuenta not in (select cu_cuenta from cob_conta..cb_cuenta_niif)

if @@ERROR <> 0
begin
   select 
   @w_msg        = 'ERROR CARGANDO ERRORES DE CUENTA NIIF',
   @w_campo_err  = 'CARGA DE DATOS cob_externos..carga_ofi_errores',
   @w_dato       = 'carga_ofi_errores',
   @w_error      = 4000051
   goto ERRORFIN
end 

insert into cb_tempo 
select 
co_oficina, 'OFICINA NO SE ENCUENTRA CREADA'
from  cob_externos..ex_cargue_balance_oficinas_niif
where co_oficina not in (select of_oficina from cob_conta..cb_oficina)

if @@ERROR <> 0
begin
   select 
   @w_msg        = 'ERROR CARGANDO ERRORES DE OFICINAS',
   @w_campo_err  = 'CARGA DE DATOS cob_externos..carga_ofi_errores',
   @w_dato       = 'carga_ofi_errores',
   @w_error      = 4000051
   goto ERRORFIN
end 

if (select count(1) from cb_tempo) > 1
begin
   delete from cob_externos..ex_cargue_balance_oficinas_niif
   select * from cb_tempo
   
   select @w_error = 2903058
   select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_conta..cb_tempo out '
   select 
   @w_destino  = @w_path + 'ERRORES_' + @w_archivo

   select @w_comando = @w_cmd + @w_destino + ' -b5000  -c -e' + @w_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'

   exec @w_error_tmp = xp_cmdshell @w_comando

   if @w_error_tmp <> 0
      print 'OCURRIO UN FALLO AL GENERAR EL BCP - FAVOR VALIDAR'
      
   goto FIN
end

return 0

ERRORFIN:

print 'ERROR - ' + cast(@w_error as varchar)

select @w_msg = mensaje from cobis..cl_errores where numero = @w_error

select @w_comando ='echo ' + @w_mensaje + ' >> '+ @w_errores

exec  @w_error_bcp = xp_cmdshell @w_comando

if @w_error_bcp <> 0
begin
   select 
   @w_msg        = 'ERROR AL GRABAR REGISTRO DE ERROR',
   @w_campo_err  = 'EL ARCHIVO CARGADO TIENE 0 REGISTROS',
   @w_dato       = 'CARGA PLANO',
   @w_error      = 208160
end

insert into cb_errores(
   cbe_procedimiento,      cbe_detalle_err,        cbe_campo_err,
   cbe_campo_dato,         cbe_fecha_err)
   values(
   @w_sp_name,             @w_msg,                 @w_campo_err, 
   @w_dato,                getdate())

FIN:
   delete from cob_externos..ex_cargue_balance_oficinas_niif
   print 'ERROR - ' + cast(@w_error as varchar)
return @w_error

go
