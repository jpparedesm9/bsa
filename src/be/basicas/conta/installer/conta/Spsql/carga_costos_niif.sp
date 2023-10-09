/************************************************************************/
/*   Archivo:            carga_costos_niif.sp                           */
/*   Stored procedure:   sp_carga_costos_niif                           */
/*   Base de datos:      cob_conta                                      */
/*   Producto:                                                          */
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
/* costos informacion Niif                                              */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA              AUTOR           RAZON                            */
/*  Abril-22-2015      Elcira PElaez   Emision Inicial BAncamia         */
/************************************************************************/

use cob_conta
go

SET ANSI_NULLS OFF
GO

set nocount on

if exists (select 1 from sysobjects where name = 'sp_carga_costos_niif')
   drop proc sp_carga_costos_niif
go

create proc sp_carga_costos_niif
@i_param1  datetime      = null,    -- Fecha de Corte
@i_param2   varchar(100) = null     -- Nombre del Archivo a Cargar

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
   @w_encabezado         varchar(2),
   @w_rowcount           int,
   @w_cabecera		       varchar(200),
   @w_nombre_plano       varchar(250),
   @w_col_id             int,
   @w_columna            varchar(100),
   @w_nom_tabla          varchar(100),
   @w_nombre             varchar(30),
   @w_comando1           varchar(1000),
   @w_fecha_plano        varchar(12),
   @w_campo_err          varchar(100),
   @w_dato               varchar(100)


if exists (select 1 from sysobjects where name = 'cargue_costos_errores_tmp')
begin
   drop table cargue_costos_errores_tmp 
end   


---INICIALIZA VARIABLES 
select @w_sp_name     = 'sp_carga_costos_niif',       
       @w_fecha_corte = @i_param1,
       @w_archivo     = @i_param2,
       @w_fecha_plano = convert(varchar(12),@w_fecha_corte,112)


select @w_dato      = @i_param1
select @w_campo_err = ''
      
---VALIDA QUE EL PARAMETRO Fecha de Corte HAYA SIDO ENVIADO 
if @i_param1 is null
begin
  select @w_msg = 'Error, Fecha de Corte no enviada',
         @w_error = 801085   
 
  goto ERRORFIN
end

---VALIDA QUE EL PARAMETRO Nombre del Archivo HAYA SIDO ENVIADO 
if @i_param2 is null
begin
  select @w_msg = 'Error, Nombre de Archivo no enviado',
         @w_error = 808007    
                    
  goto ERRORFIN  
end


---USO DE PARAMETROS  
select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

If @w_s_app is null
begin
   select 
   @w_msg     = 'ERROR CARGANDO PARAMETRO BCP',
   @w_error   = 4000001      
   
   goto ERRORFIN
end

---PATH ORIGEN  
select @w_path = pp_path_destino 
from cobis..ba_path_pro
where pp_producto = 6

If @w_path is null
begin
   select 
   @w_msg     = 'ERROR CARGANDO LA RUTA BATCH DE DESTINO, REVISAR PARAMETRIZACION',
   @w_error   = 4000002           
   
   goto ERRORFIN
end 

---CARGAR TEMPORAL PARA VALIDACION ERRORES DE ENTREGA
if exists (select 1 from sysobjects where name = 'ex_cargue_costos_niif_tmp')
begin
   drop table ex_cargue_costos_niif_tmp
end
 
create table ex_cargue_costos_niif_tmp(
cnt_fecha_corte      varchar(30) null,   -- FECHA DE CORTE
cnt_numero_op        varchar(14) null,   -- NUMERO DE CUENTA CONTABLE
cnt_codigo_if       varchar(5) null,   -- Naturaleza
cnt_costo_atribuible varchar(30) null,   -- COSTO ATRIBUIBLE
cnt_costo_amor_cau   varchar(30) null,   -- COSTO AMORTIZADO
cnt_costo_amor_pend  varchar(30) null    -- COST PNDIENTE AMORTIZAR
)

--- CARGAS EN VARIABLE @W_COMANDO - CARGA PRIMERO EN TEMPORALES PARA UBICAR POSIBLES REGISTROS CON ERRORES LUEGO DEL CARGUE A LA TABLA DEFINITIVA
select @w_comando = @w_s_app + 's_app'+ ' bcp -auto -login cob_conta..ex_cargue_costos_niif_tmp in ' +
                    @w_path + @w_archivo + 
                    ' -c -e' + @w_archivo +'_'+convert(varchar(10),@i_param1,112)+ '.err' + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'
exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0
begin
   select 
   @w_msg     = 'ERROR CARGANDO ARCHIVO POR BCP EN TMP',
   @w_error   = 4000003       
   goto ERRORFIN
end 
ELSE
begin
  print 'cargado en la tabla temporal ex_cargue_costos_niif_tmp'
end
                                                                                                                                                                                                                                                          
truncate table cob_externos..ex_cargue_costos_amort_niif

if @@ERROR <> 0
begin
   print 'Error al Eliminar Datos de cob_externos..ex_cargue_costos_amort_niif'
   goto  ERRORFIN
end

---CARGAS EN VARIABLE @W_COMANDO 
select @w_comando = @w_s_app + 's_app'+ ' bcp -auto -login cob_externos..ex_cargue_costos_amort_niif in ' +
                    @w_path + @w_archivo + 
                    ' -c -e'  + @w_archivo + '_' + convert(varchar(10),@i_param1,112)+ '.err' + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'

---EJECUTAR CON CMDSHELL  
exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0
begin
   select 
   @w_msg     = 'ERROR CARGANDO ARCHIVO POR BCP',
   @w_error   = 4000003       
   
   goto ERRORFIN
end 
else
begin
   print 'ARCHIVO DE COSTOS NIIF CARGADO...'
end


delete cob_externos..ex_cargue_niif_errores
where er_archivo_cargado = @w_archivo
and   er_fecha_corte = convert(varchar,@w_fecha_corte,101)

if @@ERROR <> 0
begin
   print 'Error al Eliminar Datos de cob_externos..ex_cargue_param_niif'
   goto  ERRORFIN
end
                                                                                                                                                                                                                                                             
--- INSERTA EN LA TABLA DE ERRORES DE CARGUE AQUELLOS REGISTROS QUE NO FUERON CARGADOS EN LA TABLA DEFINITIVA*/
insert into cob_externos..ex_cargue_niif_errores
select distinct
       @w_archivo,      
       convert(varchar,@w_fecha_corte,101),    
       cnt_numero_op,
       null,      
       null,              
       null,
       null,
       null,
       null,
       cnt_codigo_if,
       cnt_costo_atribuible, 
       cnt_costo_amor_cau,   
       cnt_costo_amor_pend,
       'ERROR EN CARGA DE VALORES '
from cob_conta..ex_cargue_costos_niif_tmp
where cnt_numero_op  not in (select cc_numero_op from cob_externos..ex_cargue_costos_amort_niif)


---GENERANDO CABECERA
----------------------------------------
--Generar Archivo de Cabeceras solo si se creo la tabla con errres
----------------------------------------


select 
'ARCHIVO'=substring(er_archivo_cargado,1,30),
'FECHACORTE'=er_fecha_corte,
'NRo_OP'=er_cuenta,
'CODIGO_IF'=er_codigo_if,
'COSTO ATRIBUIBLE'=er_costo_atribuible,
'COSTO AMORTIZADO'=er_costo_amort_cau,
'COSTO PENDIENTE'=er_costo_amort_pen,
'DESCRIPCION ERROR'=substring(er_descripcion,1,100)
into cargue_costos_errores_tmp
 from  cob_externos..ex_cargue_niif_errores
where ltrim(rtrim(er_archivo_cargado)) = ltrim(rtrim(@w_archivo))
and   er_fecha_corte = @w_fecha_corte

if exists (select 1 from sysobjects where name = 'cargue_costos_errores_tmp')
begin
      PRINT ''
      PRINT 'Entro a genrar plano de Errores'
      PRINT ''
      select @w_nombre      = 'CABECERA_CERRORES.TXT'
      select @w_nombre_plano = @w_path + @w_nombre ,
             @w_nom_tabla    = 'cargue_costos_errores_tmp',
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
         select @w_msg = 'ERROR GENERANDO CABECERA'
         goto ERRORFIN
      end
      
      
      ---GENERANDO PLANO DE ERRORES DATOS
      
      select @w_comando = @w_s_app + 's_app'+ ' bcp -auto -login cob_conta..cargue_costos_errores_tmp out ' +
                          @w_path + 'carga_Cniff_errores_' + @w_fecha_plano  +'.txt' + 
                          ' -c -e'+' Costos_niif_'+ @w_fecha_plano + '.err' + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'
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
      
      select @w_comando = 'TYPE ' + @w_path + 'carga_Cniff_errores_' + @w_fecha_plano  + '.txt >> ' +  @w_path + 'CABECERA_CERRORES.TXT'
      exec @w_error = xp_cmdshell @w_comando
      if @w_error <> 0 begin
         select @w_msg = 'ERROR UNIENDO ARCHIVOS'
         goto ERRORFIN
      end
      
      select @w_comando = 'copy ' + @w_path + 'CABECERA_CERRORES.TXT'  + ' ' + @w_path + 'carga_Cniff_errores_' + @w_fecha_plano  + '.txt'
      exec @w_error = xp_cmdshell @w_comando
      if @w_error <> 0 begin
         select @w_msg = 'ERROR RENOMBRANZO ARCHIVO FINAL'
         goto ERRORFIN
      end
      ELSE
      begin
         ---BORRAR LA BASURA
         select @w_comando  = 'ERASE ' + @w_path + 'CABECERA_CERRORES.TXT'
         exec @w_error = xp_cmdshell @w_comando
         if @w_error <> 0 begin
             print 'Error borrando Archivo:CABECERA_CERRORES.TXT'
             select @w_error = 2101084
             goto ERRORFIN    
         end
      end
end --- Generar Errores
ELSE
begin
      PRINT ''
      PRINT 'NO SE GENERARON ERRORES EN LA CARGA DE COSTOS NIFF'
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