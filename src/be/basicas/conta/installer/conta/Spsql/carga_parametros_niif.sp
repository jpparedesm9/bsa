/************************************************************************/
/*   Archivo:            carga_parametros_niif.sp                       */
/*   Stored procedure:   sp_carga_parametros_niif                       */
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
/*  Abril-21-2015      Elcira Pelaez   Emision Inicial Bancamia         */
/*  Agosto-11-2015     Andres Muñoz    CCA 515 Ajustes For281           */
/************************************************************************/
use cob_conta
go

SET ANSI_NULLS OFF
GO

if exists (select 1 from sysobjects where name = 'sp_carga_parametros_niif')
   drop proc sp_carga_parametros_niif
go

create proc sp_carga_parametros_niif
@i_param1   datetime     = null,    -- Fecha de Corte
@i_param2   varchar(100) = null     -- Nombre del Archivo a Cargar

as
declare
@w_sp_name            varchar(32),
@w_fecha_proceso      varchar(15),
@w_archivo            varchar(30),
@w_msg                descripcion,
@w_error              int,      
@w_s_app              varchar(50),
@w_path               varchar(50),
@w_comando            varchar(1000),
@w_comando1           varchar(1000),
@w_encabezado         varchar(2),
@w_rowcount           int,
@w_cabecera		       varchar(100),
@w_nombre_plano       varchar(250),
@w_col_id             int,
@w_columna            varchar(100),
@w_nom_tabla          varchar(100),
@w_nombre             varchar(30),
@w_campo_err          varchar(100),
@w_dato               varchar(100),
@w_errores_carga      int

set nocount on

if exists (select 1 from sysobjects where name = 'cargue_niif_errores_tmp')
begin
   drop table cargue_niif_errores_tmp 
end

---INICIALIZA VARIABLES
select
@w_sp_name       = 'sp_carga_parametros_niif',       
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
   @w_error     = 4000001      
   goto ERRORFIN
end

--- PATH ORIGEN 
select @w_path     = pp_path_destino 
from   cobis..ba_path_pro
where  pp_producto = 6

If @w_path is null
begin
   select 
   @w_msg       = 'ERROR CARGANDO LA RUTA BATCH DE DESTINO, REVISAR PARAMETRIZACION',
   @w_campo_err = 'PATH',
   @w_dato      = @w_s_app,
   @w_error     = 4000002           
   goto ERRORFIN
end 

truncate table cob_externos..ex_cargue_param_niif

delete cob_externos..ex_cargue_niif_errores
where  er_archivo_cargado = @w_archivo
and    er_fecha_corte     = @w_fecha_proceso

if @@ERROR <> 0
begin
   select
   @w_msg        = 'ERROR AL ELIMINAR DATOS DE COB_EXTERNOS..EX_CARGUE_NIIF_ERRORES',
   @w_campo_err  = 'ELIMINACION DATOS TABLA EX_CARGUE_NIIF_ERRORES',
   @w_dato       = 'DELETE',
   @w_error      = 1
   goto  ERRORFIN
end

--ELIMINAR DATOS DE LAS CUENTAS
delete from cb_cuenta_niif
where cu_fecha_ing = @i_param1

if @@ERROR <> 0
begin
   select
   @w_msg        = 'ERROR AL ELIMINAR DATOS DE COB_CONTA..CB_CUENTA_NIIF',
   @w_campo_err  = 'ELIMINACION DATOS TABLA COB_CONTA..CB_CUENTA_NIIF',
   @w_dato       = 'DELETE',
   @w_error      = 2
   goto  ERRORFIN
end


--- CARGAS EN VARIABLE @W_COMANDO
select @w_comando = @w_s_app + 's_app'+ ' bcp -auto -login cob_externos..ex_cargue_param_niif in ' +
                    @w_path + @w_archivo + 
                    ' -c -e'+' Pniif_'+convert(varchar(10),@i_param1,112)+ '.err' + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'
                    
--- EJECUTAR CON CMDSHELL 
exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0
begin
   select 
   @w_msg        = 'ERROR CARGANDO ARCHIVO POR BCP, FAVOR VALIDAR ESTRUCTURA Y DATOS OBLIGATORIOS (CUENTA, NATURALEZA)',
   @w_campo_err  = 'CARGA DE DATOS COB_EXTERNOS..EX_CARGUE_PARAM_NIIF',
   @w_dato       = 'CARGA PLANO',
   @w_error      = 4000003
   goto ERRORFIN
end 
else
begin
   print 'ARCHIVO DE PARAMETROS NIIF CARGADO...'
end

---VALIDACION COLUMNAS QUE CONOCEMOS
----------------------------------------
---1. NATUTALEZA SOLO PUEDE SER D/C
insert into cob_externos..ex_cargue_niif_errores(
er_archivo_cargado,     er_fecha_corte,      er_cuenta,
er_naturaleza,          er_moneda,           er_indicador,
er_descripcion)
select
@w_archivo,             @w_fecha_proceso,    cp_cuenta,
cp_naturaleza,          cp_moneda,           cp_indicador,
'LA COLUMNA 2 NATRURALEZA  TRAE DATOS INCONSISTENTES'
from  cob_externos..ex_cargue_param_niif
where cp_naturaleza not in ('D','C')

if @@ERROR <> 0
begin
   select
   @w_msg        = 'ERROR EN NATURALEZA DE CUENTA',
   @w_campo_err  = 'cp_naturaleza',
   @w_dato       = 'NATURALEZA DE CUENTA',
   @w_error      = 4000003
   goto  ERRORFIN
end

---2. CUENTA MAYOR DE 10 DIGITOS
insert into cob_externos..ex_cargue_niif_errores(
er_archivo_cargado,     er_fecha_corte,      er_cuenta,
er_naturaleza,          er_moneda,           er_indicador,
er_descripcion)
select
@w_archivo,             @w_fecha_proceso,    cp_cuenta,
cp_naturaleza,          cp_moneda,           cp_indicador,
'CUENTA MAYOR A DIEZ DIGITOS'
from  cob_externos..ex_cargue_param_niif
where len(cp_cuenta) > 10

if @@ERROR <> 0
begin
   select 
   @w_msg        = 'ERROR CUENTA MAYOR A DIEZ DIGITOS',
   @w_campo_err  = 'cp_cuenta',
   @w_dato       = 'CUENTA',
   @w_error      = 4000003
   goto  ERRORFIN
end

---3. MONEDA 1 o 2
insert into cob_externos..ex_cargue_niif_errores(
er_archivo_cargado,     er_fecha_corte,      er_cuenta,
er_naturaleza,          er_moneda,           er_indicador,
er_descripcion)
select
@w_archivo,             @w_fecha_proceso,    cp_cuenta,
cp_naturaleza,          cp_moneda,           cp_indicador,
'LA COLUMNA 3 MONEDA TRAE DATOS INCONSISTENTES'
from  cob_externos..ex_cargue_param_niif
where len(cp_cuenta) > 6
and   (cp_moneda not in ('1','2')
or    substring(cp_cuenta, 7, 1) <> cp_moneda)

if @@ERROR <> 0
begin
   select
   @w_msg        = 'ERROR EN MONEDA DE CUENTA',
   @w_campo_err  = 'cp_moneda',
   @w_dato       = 'MONEDA',
   @w_error      = 4000003
   goto  ERRORFIN
end

--ACTUALIZACION INDICADOR NO ENVIADO POR INDICADOR DEFAULT
update cob_externos..ex_cargue_param_niif set
cp_indicador = 'N'
where cp_indicador is null
or    ltrim(rtrim(cp_indicador)) = ''
or    len(cp_cuenta) <> 6

if @@ERROR <> 0
begin
   select
   @w_msg        = 'ERROR ACTUALIZANDO INDICADOR',
   @w_campo_err  = 'cp_indicador',
   @w_dato       = 'INDICADOR',
   @w_error      = 4000003
   goto  ERRORFIN
end

---4. INDICADOR S o N OBLIGATORIO CUENTAS A 6 DIGITOS
insert into cob_externos..ex_cargue_niif_errores(
er_archivo_cargado,     er_fecha_corte,      er_cuenta,
er_naturaleza,          er_moneda,           er_indicador,
er_descripcion)
select
@w_archivo,             @w_fecha_proceso,    cp_cuenta,
cp_naturaleza,          cp_moneda,           cp_indicador,
'LA COLUMNA 4 INDICADOR TRAE DATOS INCONSISTENTES'
from  cob_externos..ex_cargue_param_niif
where len(cp_cuenta) = 6
and   cp_indicador not in ('S','N')

if @@ERROR <> 0
begin
   select
   @w_msg        = 'ERROR EN INDICADOR OBLIGATORIO DE LA CUENTA',
   @w_campo_err  = 'cp_indicador',
   @w_dato       = 'INDICADOR OBLIGATORIO',
   @w_error      = 4000003
   goto  ERRORFIN
end

select @w_errores_carga = count(1) 
from   cob_externos..ex_cargue_niif_errores
where  ltrim(rtrim(er_archivo_cargado)) = ltrim(rtrim(@w_archivo))
and    er_fecha_corte = @w_fecha_proceso

if @w_errores_carga = 0
begin
   --INGRESANDO INFORMACIÓN DE LAS CUENTAS NIIF
   insert into cb_cuenta_niif
   select
   @i_param1,
   cp_cuenta,
   null,
   len(cp_cuenta),
   cp_naturaleza,
   cp_moneda
   from  cob_externos..ex_cargue_param_niif
   
   --ACTUALIZANDO CUENTAS PADRE NIVEL 10 DIGITOS
   update cb_cuenta_niif set
   cu_cuenta_padre = substring(cu_cuenta, 1, 6)
   where cu_nivel_cuenta = 10
   and   cu_fecha_ing    = @i_param1
   
   if @@ERROR <> 0
   begin
      select
      @w_msg        = 'ERROR ACTUALIZANDO CUENTA PADRE NIIF NIVEL 10',
      @w_campo_err  = 'cu_cuenta_padre',
      @w_dato       = 'CUENTA PADRE', 
      @w_error      = 605019
      goto  ERRORFIN
   end
   
   --ACTUALIZANDO CUENTAS PADRE NIVEL 6 DIGITOS
   update cb_cuenta_niif set
   cu_cuenta_padre = substring(cu_cuenta, 1, 4)
   where cu_nivel_cuenta = 6
   and   cu_fecha_ing    = @i_param1
   
   if @@ERROR <> 0
   begin
      select
      @w_msg        = 'ERROR ACTUALIZANDO CUENTA PADRE NIIF NIVEL 6',
      @w_campo_err  = 'cu_cuenta_padre',
      @w_dato       = 'CUENTA PADRE',
      @w_error      = 605019
      goto  ERRORFIN
   end
   
   --ACTUALIZANDO CUENTAS PADRE NIVEL 4 DIGITOS
   update cb_cuenta_niif set
   cu_cuenta_padre = substring(cu_cuenta, 1, 2)
   where cu_nivel_cuenta = 4
   and   cu_fecha_ing    = @i_param1
   
   if @@ERROR <> 0
   begin
      select
      @w_msg        = 'ERROR ACTUALIZANDO CUENTA PADRE NIIF NIVEL 4',
      @w_campo_err  = 'cu_cuenta_padre',
      @w_dato       = 'CUENTA PADRE', 
      @w_error      = 605019
      goto  ERRORFIN
   end
   
   --ACTUALIZANDO CUENTAS PADRE NIVEL 2 DIGITOS
   update cb_cuenta_niif set
   cu_cuenta_padre = substring(cu_cuenta, 1, 1)
   where cu_nivel_cuenta = 2
   and   cu_fecha_ing    = @i_param1
   
   if @@ERROR <> 0
   begin
      select
      @w_msg        = 'ERROR ACTUALIZANDO CUENTA PADRE NIIF NIVEL 2',
      @w_campo_err  = 'cu_cuenta_padre',
      @w_dato       = 'CUENTA PADRE',
      @w_error      = 605019
      goto  ERRORFIN
   end
   
   select distinct 'cuenta' = cu_cuenta_padre 
   into   #no_param 
   from   cb_cuenta_niif
   where  cu_cuenta_padre not in (select cp_cuenta from cob_externos..ex_cargue_param_niif)
   and    cu_fecha_ing    = @i_param1
   and    cu_cuenta_padre <> NULL
   
   if @@ROWCOUNT > 0
   begin
      
      select @w_errores_carga = 1
      
      insert into cob_externos..ex_cargue_niif_errores(
      er_archivo_cargado,     er_fecha_corte,      er_cuenta,
      er_descripcion)
      select
      @w_archivo,             @w_fecha_proceso,    cuenta,
      'CUENTA MAYOR NO PARAMETRIZADA'
      from  #no_param
      
      if @@ERROR <> 0
      begin
         select
         @w_msg        = 'ERROR EN CUENTA PADRE',
         @w_campo_err  = 'cp_cuenta',
         @w_dato       = 'CUENTA',
         @w_error      = 4000003
         goto  ERRORFIN
      end
   end
   else
   begin
      PRINT ''
      PRINT 'NO SE GENERARON ERRORES EN LA CARGA DE PARAMETROS NIFF'
      PRINT ''
   end
end

select 
'ARCHIVO'     = substring(er_archivo_cargado,1,30),
'FECHACARGA'  = er_fecha_corte,
'CUENTA'      = er_cuenta,
'NATURALEZA'  = er_naturaleza,
'MONEDA'      = er_moneda,
'INDICADOR'   = er_indicador,
'DESCRIPCION' = substring(er_descripcion,1,100)
into  cargue_niif_errores_tmp
from  cob_externos..ex_cargue_niif_errores
where ltrim(rtrim(er_archivo_cargado)) = ltrim(rtrim(@w_archivo))
and   er_fecha_corte = @w_fecha_proceso

---GENERANDO CABECERA
----------------------------------------
--Generar Archivo de Cabeceras solo si se creo la tabla con errres
----------------------------------------

if @w_errores_carga > 0
begin
   PRINT ''
   PRINT 'ENTRO A GENERAR PLANO DE ERRORES'
   PRINT ''
   select
   @w_nombre       = 'CABECERA_PERRORES.TXT',
   @w_nombre_plano = @w_path + @w_nombre ,
   @w_nom_tabla    = 'cargue_niif_errores_tmp',
   @w_col_id       = 0,
   @w_columna      = '',
   @w_cabecera     = convert(varchar(2000), '')
   
   while 1 = 1 
   begin
      set rowcount 1
      select 
      @w_columna = c.name,
      @w_col_id  = c.colid
      from cob_conta..sysobjects o, cob_conta..syscolumns c
      where o.id    = c.id
      and   o.name  = @w_nom_tabla
      and   c.colid > @w_col_id
      order by c.colid
   
      if @@rowcount = 0 begin
         set rowcount 0
         break
      end
   
      select @w_cabecera = @w_cabecera + @w_columna + '^|'
   end
   
   select @w_cabecera = left(@w_cabecera, datalength(@w_cabecera) - 2)
   
   --Escribir Cabecera
   select @w_comando1 = 'echo ' + @w_cabecera + ' > ' + @w_nombre_plano
   
   exec @w_error = xp_cmdshell @w_comando1
   
   if @w_error <> 0 
   begin
      select
      @w_msg        = 'ERROR GENERANDO CABECERA',
      @w_campo_err  = 'CABECERA BCP',
      @w_dato       = 'BCP',
      @w_error      = 4000002
      goto ERRORFIN
   end
   
   ---GENERANDO PLANO DE ERRORES DATOS
   
   select @w_comando = @w_s_app + 's_app'+ ' bcp -auto -login cob_conta..cargue_niif_errores_tmp out ' +
                       @w_path + 'carga_Pniff_errores_' + @w_fecha_proceso  +'.txt' + 
                       ' -c -e'+' Pniif_'+ @w_fecha_proceso + '.err' + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'
   
   exec @w_error = xp_cmdshell @w_comando
   
   if @w_error <> 0
   begin
      select 
      @w_msg        = 'ERROR GENERANDO ARCHIVO DE ERRORES',
      @w_campo_err  = 'ARCHIVO BCP',
      @w_dato       = 'BCP',
      @w_error      = 4000003
      goto ERRORFIN
   end 
   else
   begin
      print 'ARCHIVO DE ERRORES GENERADO...'
   end
   
   ----UNION CABECERA Y DATOS
   select @w_comando = 'TYPE ' + @w_path + 'carga_Pniff_errores_' + @w_fecha_proceso  + '.txt >> ' +  @w_path + 'CABECERA_PERRORES.TXT'
   
   exec @w_error = xp_cmdshell @w_comando
   
   if @w_error <> 0 begin
      select
      @w_msg        = 'ERROR UNIENDO ARCHIVOS',
      @w_campo_err  = 'UNION BCP',
      @w_dato       = 'BCP',
      @w_error = 4000004
      goto ERRORFIN
   end
   
   select @w_comando = 'copy ' + @w_path + 'CABECERA_PERRORES.TXT'  + ' ' + @w_path + 'carga_Pniff_errores_' + @w_fecha_proceso  + '.txt'
   
   exec @w_error = xp_cmdshell @w_comando
   
   if @w_error <> 0 begin
      select
      @w_msg        = 'ERROR RENOMBRANDO ARCHIVO FINAL',
      @w_campo_err  = 'RENOMBRE BCP',
      @w_dato       = 'BCP',
      @w_error      = 4000005
      goto ERRORFIN
   end
   ELSE
   begin
      ---SI HAY ERRORES BORRA TABLA CARGUE
      delete from cob_externos..ex_cargue_param_niif
      
      ---BORRAR LA BASURA
      select @w_comando  = 'ERASE ' + @w_path + 'CABECERA_PERRORES.TXT'
      
      exec @w_error = xp_cmdshell @w_comando
      
      if @w_error <> 0 begin
          select
          @w_msg        = 'ERROR BORRANDO ARCHIVO:CABECERA_PERRORES.TXT',
          @w_campo_err  = 'BORRADO BCP',
          @w_dato       = 'BCP', 
          @w_error      = 2101084
          goto ERRORFIN    
      end
   end
   
   --INGRESA REGISTRO DE ERRORES DEL PROCESO DE VALIDACION       
   insert into cb_errores(
   cbe_procedimiento,      cbe_detalle_err,        cbe_campo_err,
   cbe_campo_dato,         cbe_fecha_err)
   select
   @w_sp_name,             er_descripcion,         'PARAMETRIZACION NIIF',
   er_cuenta,              getdate()
   from cob_externos..ex_cargue_niif_errores
   where ltrim(rtrim(er_archivo_cargado)) = ltrim(rtrim(@w_archivo))
   and   er_fecha_corte = @w_fecha_proceso

   return 1
end --- Generar Errores

set nocount off

return 0

ERRORFIN:
   insert into cb_errores(
   cbe_procedimiento,      cbe_detalle_err,        cbe_campo_err,
   cbe_campo_dato,         cbe_fecha_err)
   values(
   @w_sp_name,             @w_msg,                 @w_campo_err,
   @w_dato,                getdate())

   print @w_msg

return @w_error

go
