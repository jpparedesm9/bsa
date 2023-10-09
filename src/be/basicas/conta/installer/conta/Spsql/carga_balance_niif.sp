/************************************************************************/
/*   Archivo:            carga_balance_niif.sp                          */
/*   Stored procedure:   sp_carga_balance_niif                          */
/*   Base de datos:      cob_conta                                      */
/*   Producto:           CONTA                                          */
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
/* Proceso que permite cargar a traves de archivos planos los           */
/* informacion Niif                                                     */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA              AUTOR         RAZON                              */
/*  Abril-21-2015      Luis Guzman   Emision Inicial                    */
/************************************************************************/

use cob_conta
go

SET ANSI_NULLS OFF
GO

set nocount on

if exists (select 1 from sysobjects where name = 'sp_carga_balance_niif')
   drop proc sp_carga_balance_niif
go

create proc sp_carga_balance_niif
@i_param1  datetime     = null,   -- Fecha de Corte
@i_param2  varchar(100) = null    -- Nombre del Archivo a Cargar

as
declare
   @w_sp_name            varchar(32),
   @w_fecha_corte        datetime,
   @w_archivo            varchar(30),
   @w_msg                descripcion,
   @w_error              int,      
   @w_s_app              varchar(50),
   @w_path               varchar(50),
   @w_comando            varchar(1000),
   @w_rowcount           int,
   @w_cabecera		       varchar(200),
   @w_nombre_plano      varchar(250),
   @w_col_id            int,
   @w_columna           varchar(100),
   @w_nom_tabla         varchar(100),
   @w_nombre            varchar(30),
   @w_comando1          varchar(1000),
   @w_fecha_plano       varchar(12),
   @w_campo_err         varchar(100),
   @w_dato              varchar(100)

/*INICIALIZA VARIABLES*/
select @w_sp_name     = 'sp_carga_balance_niif',       
       @w_fecha_corte = @i_param1,
       @w_archivo     = @i_param2,
       @w_fecha_plano = convert(varchar(12),@w_fecha_corte,112)
          

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

delete from cob_externos..ex_cargue_balance_niif

if @@ERROR <> 0
begin
   print 'Error al Eliminar Datos de cob_externos..ex_cargue_balance_niif'
   goto  ERRORFIN
end


/* CARGAS EN VARIABLE @W_COMANDO*/
select @w_comando = @w_s_app + 's_app'+ ' bcp -auto -login cob_externos..ex_cargue_balance_niif in ' +
                    @w_path + @w_archivo + 
                    ' -c -e'+' niif_'+convert(varchar(10),@i_param1,112)+ '.err' + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'

/* EJECUTAR CON CMDSHELL */
exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0
begin
   select 
   @w_msg        = 'ERROR CARGANDO ARCHIVO POR BCP, FAVOR VALIDAR ESTRUCTURA Y DATOS',
   @w_campo_err  = 'CARGA DE DATOS COB_EXTERNOS..EX_CARGUE_BALANCE_NIIF',
   @w_dato       = 'CARGA PLANO',
   @w_error      = 4000003
   goto ERRORFIN
end 
else
begin
   print 'ARCHIVO DE BALANCE NIIF CARGADO...'
end

delete from cob_externos..ex_cargue_niif_errores
where er_archivo_cargado = @w_archivo


/*VALIDACION FECHA*/
insert into cob_externos..ex_cargue_niif_errores 
select distinct
       @w_archivo,      cb_fecha_corte,    cb_cuenta,
       null,            null,              null,
       cb_saldo_cuenta, cb_saldo_debito,   cb_saldo_credito,
       null,            null,              null,
       null,            'FECHA NO PUEDE SER NULA'
from cob_externos..ex_cargue_balance_niif
where cb_fecha_corte is null

if @@ERROR <> 0
begin
   select
   @w_msg        = 'ERROR EN FECHA',
   @w_campo_err  = 'cb_fecha_corte',
   @w_dato       = 'FECHA',
   @w_error      = 4000003
   goto  ERRORFIN
end

/*VALIDACION CUENTA*/
insert into cob_externos..ex_cargue_niif_errores
select distinct
       @w_archivo,      cb_fecha_corte,    cb_cuenta,
       null,            null,              null,
       cb_saldo_cuenta, cb_saldo_debito,   cb_saldo_credito,
       null,            null,              null,
       null,            'CUENTA NO PUEDE SER NULA'
from cob_externos..ex_cargue_balance_niif
where cb_cuenta is null

if @@ERROR <> 0
begin
   select
   @w_msg        = 'ERROR EN CUENTA',
   @w_campo_err  = 'cb_cuenta',
   @w_dato       = 'CUENTA',
   @w_error      = 4000003
   goto  ERRORFIN
end

/*VALIDACION CANTIDAD DE DIGITOS DE CUENTA*/
insert into cob_externos..ex_cargue_niif_errores
select distinct
       @w_archivo,      cb_fecha_corte,    cb_cuenta,
       null,            null,              null,
       cb_saldo_cuenta, cb_saldo_debito,   cb_saldo_credito,
       null,            null,              null,
       null,            'CUENTA SUPERA LOS 10 DIGITOS'
from cob_externos..ex_cargue_balance_niif
where len(cb_cuenta) > 10

if @@ERROR <> 0
begin
   select
   @w_msg        = 'ERROR EN CUENTA MAYOR A 10 DIGITOS',
   @w_campo_err  = 'cb_cuenta',
   @w_dato       = 'CUENTA',
   @w_error      = 4000003
   goto  ERRORFIN
end

/*VALIDACION CANTIDAD DE DIGITOS DE CUENTA*/
insert into cob_externos..ex_cargue_niif_errores
select distinct
       @w_archivo,      cb_fecha_corte,    cb_cuenta,
       null,            null,              null,
       cb_saldo_cuenta, cb_saldo_debito,   cb_saldo_credito,
       null,            null,              null,
       null,            'CUENTA NO SE ENCUENTRA PARAMETRIZADA'
from cob_externos..ex_cargue_balance_niif
where cb_cuenta not in (select cp_cuenta from cob_externos..ex_cargue_param_niif)

if @@ERROR <> 0
begin
   select
   @w_msg        = 'ERROR EN CUENTA PARAMETRIZADA',
   @w_campo_err  = 'cb_cuenta',
   @w_dato       = 'CUENTA',
   @w_error      = 4000003
   goto  ERRORFIN
end

---GENERA ARCHIVO DE ERRORES
---GENERANDO CABECERA
----------------------------------------
--Generar Archivo de Cabeceras solo si se creo la tabla con errres
----------------------------------------

if exists(select 1 from sysobjects where name = 'cargue_niif_berrores_tmp')
   drop table cargue_niif_berrores_tmp

select 
'ARCHIVO'            = substring(er_archivo_cargado,1,30),
'FECHA_CORTE'        = er_fecha_corte,
'CUENTA'             = er_cuenta,
'SALDO DE LA CUENTA' = er_saldo_cuenta,
'SALDO DE DEBITO'    = er_saldo_debito,
'SALDO DE CREDITO'   = er_saldo_credito,
'DESCRIPCION'        = substring(er_descripcion,1,100)
into cargue_niif_berrores_tmp
from  cob_externos..ex_cargue_niif_errores
where ltrim(rtrim(er_archivo_cargado)) = ltrim(rtrim(@w_archivo))

if exists(select 1 from cargue_niif_berrores_tmp)
begin
   PRINT ''
   PRINT 'Entro a generar plano de Errores'
   PRINT ''
   select @w_nombre      = 'CABECERA_BERRORES.TXT'
   select @w_nombre_plano = @w_path + @w_nombre ,
          @w_nom_tabla    = 'cargue_niif_berrores_tmp',
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
   select @w_cabecera
   --Escribir Cabecera
   select @w_comando1 = 'echo ' + @w_cabecera + ' > ' + @w_nombre_plano
   select @w_comando1
   
   exec @w_error = xp_cmdshell @w_comando1
   if @w_error <> 0 
   begin
      select @w_msg = 'ERROR GENERANDO CABECERA'
      goto ERRORFIN
   end
      
   ---GENERANDO PLANO DE ERRORES DATOS
   print ' va1'
   select @w_comando = @w_s_app + 's_app'+ ' bcp -auto -login cob_conta..cargue_niif_berrores_tmp out ' +
                       @w_path + 'carga_niff_Berrores_' + @w_fecha_plano  +'.txt' + 
                       ' -c -e'+' Bniif_'+ @w_fecha_plano + '.err' + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'

   exec @w_error = xp_cmdshell @w_comando
   if @w_error <> 0
   begin
      select 
      @w_msg     = 'ERROR GENERANDO ARCHIVO DE ERRORES',
      @w_error   = 4000003       
      goto ERRORFIN
   end 
   else
   begin
      print 'ARCHIVO DE Errores GENERADO...'
   end
      
   ----UNION CABECERA Y DATOS
      
   select @w_comando = 'TYPE ' + @w_path + 'carga_niff_Berrores_' + @w_fecha_plano  + '.txt >> ' +  @w_path + 'CABECERA_BERRORES.TXT'
   exec @w_error = xp_cmdshell @w_comando
   if @w_error <> 0 begin
      select @w_msg = 'ERROR UNIENDO ARCHIVOS'
      goto ERRORFIN
   end
      
   select @w_comando = 'copy ' + @w_path + 'CABECERA_BERRORES.TXT'  + ' ' + @w_path + 'carga_niff_Berrores_' + @w_fecha_plano  + '.txt'
   exec @w_error = xp_cmdshell @w_comando
   if @w_error <> 0 begin
      select @w_msg = 'ERROR RENOMBRANZO ARCHIVO FINAL'
      goto ERRORFIN
   end
   ELSE
   begin
      
      ---SI HAY ERRORES BORRA TABLA CARGUE
      delete from cob_externos..ex_cargue_balance_niif
   
      ---BORRAR LA BASURA
      select @w_comando  = 'ERASE ' + @w_path + 'CABECERA_BERRORES.TXT'
      exec @w_error = xp_cmdshell @w_comando
      if @w_error <> 0 begin
          print 'Error borrando Archivo:CABECERA_BERRORES.TXT'
          select @w_error = 2101084
          goto ERRORFIN    
      end
   end
   
   return 1
      
end   -- CASO QUE NO EXISTAN ERRORES...
ELSE
begin
      PRINT ''
      PRINT ' =====> NO SE GENERARON ERRORES EN LA CARGA DE BALANCE NIFF'
      PRINT ''
end

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

