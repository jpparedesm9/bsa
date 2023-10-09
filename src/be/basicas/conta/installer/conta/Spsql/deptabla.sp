/************************************************************************/
/*      Archivo:                deptabla.sp                             */
/*      Stored procedure:       sp_depura_tablas                        */
/*      Base de datos:          cob_conta                               */
/*      Producto:               Contabilidad                            */
/*      Disenado por:           Contabilidad                            */
/*      Fecha de escritura:     Octubre 2009                            */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Depuración de tablas y cargar en servidor de historicos         */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA            AUTOR                  RAZON                   */
/************************************************************************/

use cob_conta
go

if exists(select 1 from sysobjects where name = 'sp_depura_tablas')
   drop proc sp_depura_tablas
go

create proc sp_depura_tablas
@i_param1    varchar(255) = 'N',       -- DEBUG
@i_param2    varchar(255) = NULL,      -- OPERACION
@i_param3    varchar(255) = NULL,      -- BASE DE DATOS
@i_param4    varchar(255) = NULL,      -- FECHA EJECUCIÓN
@i_param5    varchar(10)  = '&|',      -- SEPARADOR DE LOS BCPS
@i_param6    varchar(50)  = NULL,      -- TABLA (DEBE QUEDAR IGUAL QUE EN LA PARAMETRIZACIÓN)
@i_param7    varchar(1)   = NULL       -- OPCION TIPO DEPURACIÓN N PARA PASO DE HISTORICOS A PRODUCCIÓN
as

declare 
@w_s_app             varchar(255),
@w_path              varchar(255),
@w_destino           varchar(255),
@w_errores           varchar(255),
@w_cmd               nvarchar(500),
@w_error             int,
@w_comando           varchar(5000),
@w_fecha             datetime,
@w_batch             int,
@w_columna           varchar(50),
@w_col_id            int,
@w_cabecera          varchar(5000),
@w_sentencia         varchar(1000),
@w_empresa           tinyint,
@w_tabla             varchar(255),
@w_campo             varchar(50),
@w_basedatos         varchar(50),
@w_conexion          varchar(255),
@w_ruta              varchar(255),
@w_usuario           varchar(255),
@w_password          varchar(255),
@w_unidad            varchar(255),
@w_path_fuente       varchar(255),
@w_archivo           varchar(255),
@w_fecha_crea        datetime,
@w_fecha_min         datetime,
@w_tipo              char(1),
@w_campo1            varchar(50),
@w_valor1            varchar(50),
@w_valor2            varchar(50),
@i_debug             char(1),
@i_operacion         char(1),
@w_carpeta           varchar(10),
@w_tipodep           char(1),
@w_desc_error        varchar(100),
@w_fecha_dep         datetime,
@w_corte             smallint,
@w_periodo           smallint,
@w_rowcount          int,
@w_inicio            datetime,
@w_sarta             int,
@w_servidor          varchar(50),
@w_sp_name           varchar(30),
@w_registros         int,
@w_server            varchar(30),
@w_parametro         varchar(1),
@i_tipo              char(1),
@i_tabla             varchar(50),
@w_separador         varchar(10)

select @i_debug      = convert(char(1), @i_param1)
select @i_operacion  = convert(char(1), @i_param2)
select @w_basedatos  = convert(varchar(50), @i_param3)
select @w_fecha_crea = convert(datetime, @i_param4)
select @w_separador  = @i_param5
select @i_tabla      = convert(varchar(50), @i_param6)
select @w_sp_name    = 'sp_depura_tablas'
select @i_tipo       = convert(char(1), nullif(rtrim(ltrim(@i_param7)), ''))


select @w_tipodep = 'N'
select @w_rowcount = 0
select @w_error = 0

select @w_servidor = @@servername

select @w_server = pa_char
from cobis..cl_parametro
where pa_nemonico = 'NSCP'
and   pa_producto = 'ADM'

select @w_inicio = dateadd(mi, -1, getdate())

if @i_tabla is null begin
   select 
   @w_sarta = lo_sarta, 
   @w_parametro = substring(lo_parametro, charindex(';', lo_parametro)+1, 1)
   from cobis..ba_log
   where lo_estatus = 'E'
   and   lo_sarta in (6005, 6008)
   and   lo_fecha_inicio >= @w_inicio
   
   if @w_servidor = @w_server begin
      if @w_parametro = 'C' begin
         print 'PROCESO CON PARAMETRO: (' + @w_parametro + ') ES DEL SERVIDOR DE HISTORICOS...'
         return 1
      end
   end
   else begin
      if @w_parametro = 'E' begin
         print 'PROCESO CON PARAMETRO: (' + @w_parametro + ') ES DEL SERVIDOR CENTRAL...'
         return 1
      end   
   end
end

delete from cob_conta_super..sb_errorlog
where er_fuente = @w_sp_name

set rowcount 0

select @w_path = pp_path_destino
from cobis..ba_path_pro  
where pp_producto = 6

select @w_path_fuente = pp_path_fuente
from cobis..ba_path_pro  
where pp_producto = 6

select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

if @i_debug = 'S' begin
   print @w_s_app
   print @w_path
   print @i_operacion + '*'
   print @w_basedatos
end 

select
distinct pd_tipo_dep
into #tipos
from cob_conta..cb_paramdep
where (pd_tipo_dep = @i_tipo or (@i_tipo is null and pd_tipo_dep <> 'N'))
and   pd_basedatos = @w_basedatos

select 
pd_tabla,
pd_campo,
pd_campo1,
pd_basedatos,
pd_tipo,
pd_tipo_dep
into #paramdep
from cob_conta..cb_paramdep
where pd_basedatos = @w_basedatos
and   pd_estado    = 'V'
and   (pd_tabla = @i_tabla or @i_tabla is null)   
and   pd_tipo_dep in (select pd_tipo_dep from #tipos)

if @i_operacion = 'E' begin   -- EXTRACCION

   if @i_debug = 'S' begin
      print @i_operacion + '*'
   end 

   while 1 = 1 begin
   
      set rowcount 1
      
      print 'Entra a tablas'

      select 
      @w_tabla     = pd_tabla,
      @w_tipo      = pd_tipo,
      @w_campo     = pd_campo,
      @w_campo1    = pd_campo1,
      @w_basedatos = pd_basedatos,
      @w_tipodep   = pd_tipo_dep
      from #paramdep
      
      if @@rowcount = 0 break

      if @i_debug = 'S' begin
         print 'Tabla'
         print @w_tabla
         print @w_campo 
         print @w_campo1
         print @w_basedatos
         print @w_tipo
         print @w_tipodep
      end 
      
      delete #paramdep
      where pd_tabla     = @w_tabla
      and   pd_campo     = @w_campo     
      and   pd_basedatos = @w_basedatos
      
      set rowcount 0
   
      select @w_sentencia = 'if exists(select 1 from sysobjects where name = ' + '''' + 'vw_cabecera' + '''' + ')   drop view vw_cabecera'
      
      select @w_error = 0
   
      exec (@w_sentencia)
      if @@error <> 0 begin
         select @w_desc_error =  'Error en borrado de vista' + ' ' + cast(@w_error as varchar) + ' tabla: ' + @w_tabla
         print @w_desc_error
         
         exec cob_conta_super..sp_errorlog
         @i_operacion     = 'I',
         @i_fecha_fin     = @w_fecha_crea,
         @i_fuente        = @w_sp_name,
         @i_origen_error  = '28001',
         @i_descrp_error  = @w_desc_error
                  
         GOTO SIGUIENTE
      end
      
      if @w_tipodep not in ('H', 'P', 'S') begin

         /*** CREACION TABLA TEMPORAL ***/
         
         select @w_sentencia = 'if exists(select 1 from cob_conta..sysobjects where name = ' + '''' + 'fecha_dep' + '''' + ') drop table fecha_dep'
         
         exec (@w_sentencia)
         if @@error <> 0 begin
            select @w_desc_error = 'Error en borrado de tabla temporal de tabla: ' + @w_tabla
            print @w_desc_error
            
            exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @w_fecha_crea,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = '28001',
            @i_descrp_error  = @w_desc_error            
            GOTO SIGUIENTE
         end      
         
         if @w_tipo = 'D' begin    -- TIPO FECHA DATETIME
            print 'tipo D'
            select @w_sentencia = 'create table cob_conta..fecha_dep (valor1  datetime, valor2  datetime NULL)'
         end
         else begin
            if @w_tipo = 'C' begin    -- TIPO CARACTER CHAR
               select @w_sentencia = 'create table cob_conta..fecha_dep (valor1  varchar(50), valor2  varchar(50) NULL)'
            end
            else begin      -- TIPO NUMERICO  INT
               select @w_sentencia = 'create table cob_conta..fecha_dep (valor1  int, valor2  int NULL)'
            end        
         end
         
         exec (@w_sentencia)
         if @@error <> 0 begin
            select @w_desc_error =  'Error en creación de tabla temporal de tabla: ' + @w_tabla
            print @w_desc_error
            
            exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @w_fecha_crea,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = '28001',
            @i_descrp_error  = @w_desc_error 
                        
            GOTO SIGUIENTE
         end      
         
         /*** INSERCION EN TABLA TEMPORAL ***/

         select @w_sentencia = 'insert into cob_conta..fecha_dep (valor1) values (' + '''' + convert(varchar(10), @w_fecha_crea, 101)+ '''' +  ')'
--         select @w_sentencia = 'insert into cob_conta..fecha_dep (valor1) select  max(' + @w_campo + ') ' + 'from ' + @w_tabla 
         
         if @i_debug = 'S' begin
            print @w_sentencia 
         end
         
         exec (@w_sentencia)
         if @@error <> 0 begin
            select @w_desc_error = 'Error en extracción de dato del campo1 de trabajo de tabla: ' + @w_tabla
            print @w_desc_error
            
            exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @w_fecha_crea,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = '28001',
            @i_descrp_error  = @w_desc_error 
                        
            GOTO SIGUIENTE
         end
         
         select @w_valor1 = cast(valor1 as varchar)
         from cob_conta..fecha_dep      
         
         if @w_campo1 is not null begin
            select @w_sentencia = 'update cob_conta..fecha_dep set valor2 = (select max(' + @w_campo1 + ') ' + 'from ' + @w_tabla + ' where ' + @w_campo + ' = ' + @w_valor1 +')'
         
         
            if @i_debug = 'S' begin
               print @w_sentencia 
            end
         
            exec (@w_sentencia)
            if @@error <> 0 begin
               select @w_desc_error = 'Error en extracción de dato del campo 2 de trabajo de tabla: '+ @w_tabla
               print @w_desc_error
               
               exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @w_fecha_crea,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28001',
               @i_descrp_error  = @w_desc_error 
                           
               GOTO SIGUIENTE
            end
         end
               
         select @w_valor2 = cast(valor2 as varchar)
         from cob_conta..fecha_dep
               
         if @i_debug = 'S' begin
            print @w_valor1
            print @w_valor2
         end
         
         if @w_tipo = 'D' begin
            select @w_valor1 = '''' + convert(varchar, @w_valor1) + ''''
            select @w_valor2 = '''' + convert(varchar, @w_valor2) + ''''
         end
         
         if @w_tipo = 'C' begin
            select @w_valor1 = '''' + convert(varchar, @w_valor1) + ''''
            select @w_valor2 = '''' + convert(varchar, @w_valor2) + ''''
         end
         
         if @w_tipo = 'I' begin
            select @w_valor1 = convert(varchar, @w_valor1)
            select @w_valor2 = convert(varchar, @w_valor2)
         end      
         
         if @w_campo1 is not null begin
            print 'campo1 not null'
            select @w_sentencia = 'create view vw_cabelcera as ' + 'select * ' + 'from ' + @w_tabla + ' where ' + @w_campo + ' = ' + @w_valor1 + ' and ' + @w_campo1 + ' = ' + @w_valor2
         end
         else begin
            print 'campo1 null'
            select @w_sentencia = 'create view vw_cabecera as ' + 'select * ' + 'from ' + @w_tabla + ' where ' + @w_campo + ' = ' + @w_valor1
         end
         
         if @i_debug = 'S' begin
            print @w_tabla
            print @w_campo
            print @w_valor1
            print @w_sentencia
            print @w_tipo
            print @w_cmd          
         end
         
         exec (@w_sentencia)
         if @@error <> 0 begin
            print 'Error en creacion de vista de tabla: ' + @w_tabla
            print @w_desc_error
            
            exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @w_fecha_crea,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = '28001',
            @i_descrp_error  = @w_desc_error 
                        
            GOTO SIGUIENTE
         end
      end
      
      if  @w_tipodep in ('H', 'P') begin  -- @w_tipodep in ('H', 'P')
         select @w_sentencia = 'create view vw_cabecera as ' + 'select * ' + 'from ' + @w_tabla
         
         if @i_debug = 'S' begin
            print '@w_tipodep H y P'
            print @w_sentencia
            print @w_tipo
            print @w_cmd          
         end
         
         exec (@w_sentencia)
         if @@error <> 0 begin
            select @w_desc_error = 'Error en creacion de vista de tabla: ' + @w_tabla
            print @w_desc_error
           
            exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @w_fecha_crea,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = '28001',
            @i_descrp_error  = @w_desc_error             
            GOTO SIGUIENTE
         end
         
        
      end
      
      if @w_tipodep = 'S' begin
         select @w_fecha_dep = '01/01/1900'
         
         select @w_fecha_dep = isnull (min (fecha_ini), '01/01/1900')
         from ts_corte
         where fecha = @w_fecha_crea
         and   tipo  = 'V'
         and   clase = 'A'
         
         if datepart(mm, @w_fecha_dep) < datepart(mm, @w_fecha_crea) begin
                  
            select @w_fecha_dep = dateadd (mm, 1, dateadd(dd, datepart(dd, @w_fecha_crea)*-1, @w_fecha_crea))

            select 
            @w_corte = co_corte,
            @w_periodo = co_periodo
            from cob_conta..cb_corte
            where co_fecha_ini = @w_fecha_dep         
                     
            select @w_sentencia = 'create view vw_cabecera as ' + 'select * ' + 'from ' + @w_tabla + ' where st_periodo = ' + convert(char(4), @w_periodo) + ' and st_corte >= ' + convert(char(3), @w_corte)
            
            if @i_debug = 'S' begin
               print @w_tabla
               print @w_campo
               print @w_valor1
               print @w_sentencia
               print @w_tipo
               print @w_cmd          
            end
            
            exec (@w_sentencia)
            if @@error <> 0 begin
               print 'Error en creacion de vista de tabla: ' + @w_tabla
               print @w_desc_error
               
               exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @w_fecha_crea,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28001',
               @i_descrp_error  = @w_desc_error 
                           
               GOTO SIGUIENTE
            end
         end
            
         else begin
            select @w_fecha_dep = dateadd (mm, 1, dateadd(dd, datepart(dd, @w_fecha_crea)*-1, @w_fecha_crea))

            select 
            @w_corte = co_corte,
            @w_periodo = co_periodo
            from cob_conta..cb_corte
            where co_fecha_ini = @w_fecha_dep         
                     
            select @w_sentencia = 'create view vw_cabecera as ' + 'select * ' + 'from ' + @w_tabla + ' where st_periodo = ' + convert(char(4), @w_periodo) + ' and st_corte = ' + convert(char(3), @w_corte)         
            
            if @i_debug = 'S' begin
               print @w_tabla
               print @w_campo
               print @w_valor1
               print @w_sentencia
               print @w_tipo
               print @w_cmd          
            end
            
            exec (@w_sentencia)
            if @@error <> 0 begin
               print 'Error en creacion de vista de tabla: ' + @w_tabla
               print @w_desc_error
               
               exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @w_fecha_crea,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28001',
               @i_descrp_error  = @w_desc_error                
               GOTO SIGUIENTE
            end
         end
        
      end
         
      
      if @w_tipodep = 'C' begin
         select @w_fecha = '01/01/1900'
         
         select @w_fecha = convert(varchar(10), max(sc_fecha_gra), 101)
         from cob_conta_tercero..ct_scomprobante 
                     
         if @w_tabla = 'cob_conta_tercero..ct_scomprobante' begin
         
            if exists (select 1 from sysobjects where name = 'vw_cabecera')
               drop view vw_cabecera
         
            select @w_sentencia = 'create view vw_cabecera as ' + 'select * from cob_conta_tercero..ct_scomprobante where convert(varchar(10),sc_fecha_gra, 101) = ' + '''' + cast(@w_fecha_crea as  varchar) + ''''
            
            exec (@w_sentencia)
            if @@error <> 0 begin
               select @w_desc_error = 'Error en creacion de vista de tabla: ' + @w_tabla
               print @w_desc_error
               
               exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @w_fecha_crea,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28001',
               @i_descrp_error  = @w_desc_error                
               GOTO SIGUIENTE
            end
         end
         
         if @w_tabla = 'cob_conta_tercero..ct_sasiento' begin
         
            if exists (select 1 from sysobjects where name = 'comprobantes_work')
               drop table comprobantes_work
               
            if exists (select 1 from sysobjects where name = 'vw_cabecera')
               drop view vw_cabecera               
         
            select sc_fecha_tran, sc_producto, sc_comprobante
            into comprobantes_work
            from cob_conta_tercero..ct_scomprobante
            where convert(varchar(10), sc_fecha_gra, 101) = @w_fecha_crea
            
            select @w_sentencia = 'create view vw_cabecera as ' + 'select cob_conta_tercero..ct_sasiento.* from cob_conta_tercero..ct_sasiento, comprobantes_work where sa_comprobante = sc_comprobante and   sa_fecha_tran = sc_fecha_tran and   sa_producto = sc_producto'

            exec (@w_sentencia)
            if @@error <> 0 begin
               select @w_desc_error = 'Error en creacion de vista de tabla: ' + @w_tabla
               print @w_desc_error
               
               exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @w_fecha_crea,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28001',
               @i_descrp_error  = @w_desc_error 
                           
               GOTO SIGUIENTE
            end
         end
         
         select @w_fecha = convert(varchar(10), max(co_fecha_mod), 101)
         from cob_conta..cb_comprobante         
         
         if @w_tabla = 'cob_conta..cb_comprobante' begin
         
            print @w_fecha_crea
            print @w_tabla
            
            if exists (select 1 from sysobjects where name = 'vw_cabecera')
               drop view vw_cabecera            
         
            select @w_sentencia = 'create view vw_cabecera as ' + 'select * from cob_conta..cb_comprobante where convert(varchar(10),co_fecha_mod, 101) = ' + '''' + cast(@w_fecha_crea as  varchar) + ''''
            
            exec (@w_sentencia)
            if @@error <> 0 begin
               select @w_desc_error = 'Error en creacion de vista de tabla: ' + @w_tabla
               print @w_desc_error
               
               exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @w_fecha_crea,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28001',
               @i_descrp_error  = @w_desc_error 
                           
               GOTO SIGUIENTE
            end
         end
         
         if @w_tabla = 'cob_conta..cb_asiento' begin
         
            if exists (select 1 from sysobjects where name = 'comprobantes_work')
               drop table comprobantes_work         
               
            if exists (select 1 from sysobjects where name = 'vw_cabecera')
               drop view vw_cabecera            
               
            select co_fecha_tran, co_oficina_orig, co_comprobante
            into comprobantes_work
            from cob_conta..cb_comprobante
            where convert(varchar(10),co_fecha_mod,101) = @w_fecha_crea
            
            select @w_sentencia = 'create view vw_cabecera as ' + 'select cob_conta..cb_asiento.* from cob_conta..cb_asiento, comprobantes_work where as_comprobante = co_comprobante and   as_fecha_tran  = co_fecha_tran and   as_oficina_orig = co_oficina_orig'

            exec (@w_sentencia)
            if @@error <> 0 begin
               select @w_desc_error = 'Error en creacion de vista de tabla: ' + @w_tabla
               print @w_desc_error
               
               exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @w_fecha_crea,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28001',
               @i_descrp_error  = @w_desc_error                
               GOTO SIGUIENTE
            end
         end         
      end
      
      select @w_carpeta = replace(convert(varchar, @w_fecha_crea, 102), '.', '')      
      
--      select @w_fecha_crea = getdate()

      select @w_conexion = pa_char
      from cobis..cl_parametro
      where pa_nemonico = 'DISH'
      and   pa_producto = 'CON'
      
      select @w_ruta = pa_char
      from cobis..cl_parametro
      where pa_nemonico = 'RCXR'
      and   pa_producto = 'CON'
         
      select @w_usuario = pa_char
      from cobis..cl_parametro
      where pa_nemonico = 'UCXR'
      and   pa_producto = 'CON'
   
      select @w_password = pa_char
      from cobis..cl_parametro
      where pa_nemonico = 'PCXR'
      and   pa_producto = 'CON'
   
      select @w_archivo = replace(convert(varchar(80), @w_tabla, 102), '.', '') + '_' + replace(convert(varchar, @w_fecha_crea, 102), '.', '') + '.bcp'
   
      print 'ARCHIVO'
   
      print @w_archivo 
      
      select @w_unidad = substring (@w_path, 1, 2)
      
      select @w_destino  = @w_path + replace(convert(varchar(80), @w_tabla, 102), '.', '') + '_' + replace(convert(varchar, @w_fecha_crea, 102), '.', '') + '.bcp',
             @w_errores  = @w_path + replace(convert(varchar(80), @w_tabla, 102), '.', '') + '_' + replace(convert(varchar, @w_fecha_crea, 102), '.', '') + '.err'

      select @w_cmd = @w_path_fuente + 's_app.cmd cob_conta..vw_cabecera out ' 
                         
      select @w_comando = @w_cmd + @w_destino + ' -b5000 -c -e' + @w_errores + ' -t"' + @w_separador + '" ' + '-config s_app.ini ' + @w_carpeta + ' ' + @w_unidad
      
      if @i_debug = 'S' begin
         print 'path salida'
         print @w_path
         print @w_comando 
         print @w_destino
         print @w_errores
      end 
      
      exec @w_error = xp_cmdshell @w_comando
      if @w_error <> 0 begin
         select @w_desc_error =  'Error generando Archivo BCP de tabla: ' + @w_tabla
         print @w_comando
         print @w_desc_error
         
         exec cob_conta_super..sp_errorlog
         @i_operacion     = 'I',
         @i_fecha_fin     = @w_fecha_crea,
         @i_fuente        = @w_sp_name,
         @i_origen_error  = '28001',
         @i_descrp_error  = @w_desc_error          
         GOTO SIGUIENTE
      end
      

      
      select @w_comando = @w_path_fuente + 'ured.cmd \\'+ @w_conexion + '\' + @w_ruta + ' ' + @w_password + ' ' + @w_conexion + '\' + @w_usuario + ' ' + @w_unidad + ' ' + @w_path + ' ' + @w_archivo + ' ' + @w_carpeta
   
      if @i_debug = 'S' begin
         print 'Comando'
         print @w_conexion
         print @w_ruta 
         print @w_usuario
         print @w_password
         print @w_path
         print @w_unidad
      end 
   
      exec @w_error = xp_cmdshell @w_comando
      if @w_error <> 0 begin
         select @w_desc_error =  'Error trasmitiendo Archivo BCP de tabla: ' + @w_tabla
         print @w_comando
         print @w_desc_error
         
         exec cob_conta_super..sp_errorlog
         @i_operacion     = 'I',
         @i_fecha_fin     = @w_fecha_crea,
         @i_fuente        = @w_sp_name,
         @i_origen_error  = '28001',
         @i_descrp_error  = @w_desc_error 
                     
         GOTO SIGUIENTE
      end      
      
      if @w_tipodep = 'H' begin
         select @w_cmd = 'truncate table ' + @w_tabla
         
         exec (@w_cmd)
         if @@error <> 0 begin
            select @w_desc_error = 'Error ejecutando borrado de tabla ' + @w_tabla
            print @w_cmd
            print @w_desc_error
            
            exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @w_fecha_crea,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = '28001',
            @i_descrp_error  = @w_desc_error             
            GOTO SIGUIENTE
         end
      end      
      SIGUIENTE:
   end
end   

if @i_operacion = 'D' begin   -- BORRADO

   while 1 = 1 begin   
   
      select 
      @w_tabla     = pd_tabla,
      @w_tipo      = pd_tipo,
      @w_campo     = pd_campo,
      @w_campo1    = pd_campo1,
      @w_basedatos = pd_basedatos
      from #paramdep
      where pd_tipo_dep not in ('H', 'P')
      
      if @@rowcount = 0 break

      if @i_debug = 'S' begin
         print 'Tabla'
         print @w_tabla
         print @w_campo 
         print @w_campo1
         print @w_basedatos
         print @w_tipo
      end 
      
      delete #paramdep
      where pd_tabla     = @w_tabla
      and   pd_campo     = @w_campo     
      and   pd_basedatos = @w_basedatos   
      
      select @w_sentencia = 'if exists(select 1 from cob_conta..sysobjects where name = ' + '''' + 'fecha_dep' + '''' + ') drop table fecha_dep'

      exec (@w_sentencia)
      if @@error <> 0 begin
         select @w_desc_error = 'Error en borrado de tabla temporal de tabla: '+@w_tabla
         print @w_desc_error
         
         exec cob_conta_super..sp_errorlog
         @i_operacion     = 'I',
         @i_fecha_fin     = @w_fecha_crea,
         @i_fuente        = @w_sp_name,
         @i_origen_error  = '28001',
         @i_descrp_error  = @w_desc_error          
      end      

      if @w_tipo = 'D' begin
         print 'tipo D'
         select @w_sentencia = 'create table cob_conta..fecha_dep (valor1  datetime, valor2  datetime NULL)'
      end
      else begin
         if @w_tipo = 'C' begin
            select @w_sentencia = 'create table cob_conta..fecha_dep (valor1  varchar(50), valor2  varchar(50) NULL)'
         end
         else begin
            select @w_sentencia = 'create table cob_conta..fecha_dep (valor1  int, valor2  int NULL)'
         end        
      end
      
      exec (@w_sentencia)
      if @@error <> 0 begin
         select @w_desc_error = 'Error en creación de tabla temporal de tabla: ' + @w_tabla
         print @w_desc_error
         
         exec cob_conta_super..sp_errorlog
         @i_operacion     = 'I',
         @i_fecha_fin     = @w_fecha_crea,
         @i_fuente        = @w_sp_name,
         @i_origen_error  = '28001',
         @i_descrp_error  = @w_desc_error          
      end      
     
      /*** INSERCION EN TABLA TEMPORAL ***/
                  
      select @w_sentencia = 'insert into cob_conta..fecha_dep (valor1) select  min(' + @w_campo + ') ' + 'from ' + @w_tabla 
      
      if @i_debug = 'S' begin
         print @w_sentencia 
      end
      
      exec (@w_sentencia)
      if @@error <> 0 begin
         select @w_desc_error =  'Error en extracción de dato del campo de trabajo de tabla: ' + @w_tabla
         print @w_desc_error
         
         exec cob_conta_super..sp_errorlog
         @i_operacion     = 'I',
         @i_fecha_fin     = @w_fecha_crea,
         @i_fuente        = @w_sp_name,
         @i_origen_error  = '28001',
         @i_descrp_error  = @w_desc_error 
            
      end
      
      select @w_valor1 = cast(valor1 as varchar)
      from cob_conta..fecha_dep      

      if @w_campo1 is not null begin
         select @w_sentencia = 'update cob_conta..fecha_dep set valor2 = (select min(' + @w_campo1 + ') ' + 'from ' + @w_tabla + ' where ' + @w_campo + ' = ' + @w_valor1 +')'
      

         if @i_debug = 'S' begin
            print @w_sentencia 
         end
      
         exec (@w_sentencia)
         if @@error <> 0 begin
            select @w_desc_error = 'Error en extracción de dato del campo2 de trabajo de tabla: '+ @w_tabla
            print @w_desc_error
            
            exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @w_fecha_crea,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = '28001',
            @i_descrp_error  = @w_desc_error 
                        
         end
      end
            
      select @w_valor2 = cast(valor2 as varchar)
      from cob_conta..fecha_dep
            
      if @i_debug = 'S' begin
         print @w_valor1
         print @w_valor2
      end
      
      if @w_tipo = 'D' begin
         select @w_valor1 = '''' + convert(varchar, @w_valor1) + ''''
         select @w_valor2 = '''' + convert(varchar, @w_valor2) + ''''
      end
      
      if @w_tipo = 'C' begin
         select @w_valor1 = '''' + convert(varchar, @w_valor1) + ''''
         select @w_valor2 = '''' + convert(varchar, @w_valor2) + ''''
      end
      
      if @w_tipo = 'I' begin
         select @w_valor1 = convert(varchar, @w_valor1)
         select @w_valor2 = convert(varchar, @w_valor2)
      end            

      set rowcount 10000
      
------------------------

      if @w_tipodep = 'C' begin
         select @w_fecha = '01/01/1900'
         
         select @w_fecha = convert(varchar(10), min(sc_fecha_gra), 101)
         from cob_conta_tercero..ct_scomprobante 
                     
         if @w_tabla = 'cob_conta_tercero..ct_scomprobante' begin
         
            if exists (select 1 from sysobjects where name = 'vw_cabecera')
               drop view vw_cabecera
               
            select @w_sentencia = 'while 1=1 begin '
            select @w_sentencia = @w_sentencia  + 'delete cob_conta_tercero..ct_scomprobante where convert(varchar(10),sc_fecha_gra, 101) = ' + '''' + cast(@w_fecha as  varchar) + ''''
            select @w_sentencia = @w_sentencia + ' if @@rowcount = 0 break end'      
            
            exec (@w_sentencia)
            if @@error <> 0 begin
               select @w_desc_error = 'Error en creacion de vista de tabla: ' + @w_tabla
               print @w_desc_error
               
               exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @w_fecha_crea,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28001',
               @i_descrp_error  = @w_desc_error 
               
               GOTO SIGUIENTE
            end
         end
         
         if @w_tabla = 'cob_conta_tercero..ct_sasiento' begin
         
            if exists (select 1 from sysobjects where name = 'comprobantes_work')
               drop table comprobantes_work
               
            select sc_fecha_tran, sc_producto, sc_comprobante
            into comprobantes_work
            from cob_conta_tercero..ct_scomprobante
            where convert(varchar(10),sc_fecha_gra, 101) = @w_fecha
            
            select @w_sentencia = 'while 1=1 begin'
            select @w_sentencia = @w_sentencia + ' delete cob_conta_tercero..ct_sasiento from comprobantes_work where sa_comprobante = sc_comprobante and   sa_fecha_tran = sc_fecha_tran and   sa_producto = sc_producto'
            select @w_sentencia = @w_sentencia + ' if @@rowcount = 0 break end'      
            
            exec (@w_sentencia)
            if @@error <> 0 begin
               select @w_desc_error = 'Error en creacion de vista de tabla: ' + @w_tabla
               print @w_desc_error
               
               exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @w_fecha_crea,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28001',
               @i_descrp_error  = @w_desc_error 
               
               GOTO SIGUIENTE
            end
         end
         
         select @w_fecha = convert(varchar(10), min(co_fecha_mod), 101)
         from cob_conta..cb_comprobante         
         
         if @w_tabla = 'cob_conta..cb_comprobante' begin
         
            print @w_fecha
            print @w_tabla
            
            if exists (select 1 from sysobjects where name = 'vw_cabecera')
               drop view vw_cabecera            
         
            select @w_sentencia = 'while 1=1 begin '
            select @w_sentencia = @w_sentencia + 'delete from cob_conta..cb_comprobante where convert(varchar(10),co_fecha_mod, 101) = ' + '''' + cast(@w_fecha as  varchar) + ''''
            select @w_sentencia = @w_sentencia + ' if @@rowcount = 0 break end'
            
            exec (@w_sentencia)
            if @@error <> 0 begin
               select @w_desc_error = 'Error en creacion de vista de tabla: ' + @w_tabla
               print @w_desc_error
               
               exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @w_fecha_crea,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28001',
               @i_descrp_error  = @w_desc_error                
               
               GOTO SIGUIENTE
            end
         end
         
         if @w_tabla = 'cob_conta..cb_asiento' begin
         
            if exists (select 1 from sysobjects where name = 'comprobantes_work')
               drop table comprobantes_work         
               
            if exists (select 1 from sysobjects where name = 'vw_cabecera')
               drop view vw_cabecera            
               
            select co_fecha_tran, co_oficina_orig, co_comprobante
            into comprobantes_work
            from cob_conta..cb_comprobante
            where convert(varchar(10),co_fecha_mod, 101) = @w_fecha
            
            select @w_sentencia = 'while 1=1 begin '
            select @w_sentencia = @w_sentencia + 'delete cob_conta..cb_asiento from cob_conta..cb_asiento, comprobantes_work where as_comprobante = co_comprobante and   as_fecha_tran  = co_fecha_tran and   as_oficina_orig = co_oficina_orig'
            select @w_sentencia = @w_sentencia + ' if @@rowcount = 0 break end'

            exec (@w_sentencia)
            if @@error <> 0 begin
               select @w_desc_error = 'Error en creacion de vista de tabla: ' + @w_tabla
               print @w_desc_error
               
               exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @w_fecha_crea,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28001',
               @i_descrp_error  = @w_desc_error 
                              
               GOTO SIGUIENTE
            end
         end         
      end

-----------------------
      else begin
      
         if @w_campo1 is not null begin
            select @w_sentencia = 'while 1=1 begin'
            select @w_sentencia = @w_sentencia +  ' delete ' +  @w_tabla + ' where ' + @w_campo + ' = ' + @w_valor1 + ' and ' + @w_campo1 + ' = ' + @w_valor2
            select @w_sentencia = @w_sentencia + ' if @@rowcount = 0 break end'      
         end
         else begin
            if @w_tipo = 'D' begin
               select @w_sentencia = 'while 1=1 begin'
               select @w_sentencia = @w_sentencia +  ' delete ' +  @w_tabla + ' where ' + @w_campo + ' = ' + '''' + cast(@w_fecha_crea as varchar) + ''''
               select @w_sentencia = @w_sentencia + ' if @@rowcount = 0 break end'
            end
         end     
         
         if @i_debug = 'S' begin
            print @w_sentencia
         end
         
         exec (@w_sentencia)
         if @@error <> 0 begin
            select @w_desc_error = 'Error en creacion de vista de tabla: ' +  @w_tabla
            set rowcount 0
            print @w_desc_error
            
            exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @w_fecha_crea,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = '28001',
            @i_descrp_error  = @w_desc_error             
         end
      end
   end   
end   

if @i_operacion = 'C' begin     -- CARGA

   set rowcount 0
   
   while 1 = 1 begin   
      select 
      @w_tabla     = pd_tabla,
      @w_tipo      = pd_tipo,
      @w_campo     = pd_campo,
      @w_campo1    = pd_campo1,
      @w_basedatos = pd_basedatos,
      @w_tipodep   = pd_tipo_dep
      from #paramdep
      order by pd_tabla
      
      if @@rowcount = 0 break

      if @i_debug = 'S' begin
         print 'Tabla'
         print @w_tabla
         print @w_campo 
         print @w_campo1
         print @w_basedatos
         print @w_tipo
      end 
      
      delete #paramdep
      where pd_tabla     = @w_tabla
      and   pd_campo     = @w_campo     
      and   pd_basedatos = @w_basedatos

      if @w_tipodep = 'P' begin
         select @w_cmd = 'truncate table ' + @w_tabla
         
         exec (@w_cmd)
         if @@error <> 0 begin
            select @w_desc_error = 'Error ejecutando borrado de tabla ' + @w_tabla
            print @w_cmd
            print @w_desc_error
            
            exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @w_fecha_crea,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = '28001',
            @i_descrp_error  = @w_desc_error             
         end
      end

      if @w_tipodep = 'S' begin
         select @w_fecha_dep = dateadd (mm, 1, dateadd(dd, datepart(dd, @w_fecha_crea)*-1, @w_fecha_crea))
         
         select
         @w_corte = co_corte,
         @w_periodo = co_periodo
         from cob_conta..cb_corte
         where co_fecha_ini = @w_fecha_dep

         while 1 = 1 begin
            set rowcount 50000
         
            delete cob_conta_tercero..ct_saldo_tercero
            where st_corte   = @w_corte
            and   st_periodo = @w_periodo
            
            select @w_error = @@error, @w_rowcount = @@rowcount 
            
            if @w_error <> 0 begin
               set rowcount 0
               select @w_desc_error = 'Error ejecutando borrado de tabla ' + @w_tabla
               print @w_comando
               print @w_desc_error
               
               exec cob_conta_super..sp_errorlog
               @i_operacion     = 'I',
               @i_fecha_fin     = @w_fecha_crea,
               @i_fuente        = @w_sp_name,
               @i_origen_error  = '28001',
               @i_descrp_error  = @w_desc_error                
            end         
            
            if @w_rowcount = 0 begin
               set rowcount 0
               break
            end
         end
      end

      set rowcount 0
      
      if exists (select 1 from cob_conta_super..sysobjects where name = 'sb_regtabla')
         drop table cob_conta_super..sb_regtabla
         
      create table cob_conta_super..sb_regtabla
      ( registros   int  )      

      if @w_tipo = 'D' and @w_tipodep = 'T' begin
         select @w_cmd = 'insert into cob_conta_super..sb_regtabla select count(1) from ' + @w_tabla + ' where ' + @w_campo + ' = ' + '''' + convert(varchar,@w_fecha_crea) + ''''

         exec sp_executesql @w_cmd
         if @@error <> 0 begin
            select @w_desc_error =  'Error cargando registros de tabla: ' + @w_tabla
            print @w_cmd
            print @w_desc_error
            
            exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @w_fecha_crea,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = '28001',
            @i_descrp_error  = @w_desc_error

         end         

         select @w_registros = registros from cob_conta_super..sb_regtabla
         
         if @w_registros > 0 begin
         
            select @w_desc_error =  'Ya existe informacion en la tabla: ' + @w_tabla + ' a: ' + convert(varchar,@w_fecha_crea)
         
            exec cob_conta_super..sp_errorlog
            @i_operacion     = 'I',
            @i_fecha_fin     = @w_fecha_crea,
            @i_fuente        = @w_sp_name,
            @i_origen_error  = '28001',
            @i_descrp_error  = @w_desc_error
            
            GOTO SIGUIENTE1
         end
      end

      select @w_carpeta = replace(convert(varchar, @w_fecha_crea, 102), '.', '')
   
      select @w_destino  = @w_path + replace(convert(varchar(80), @w_tabla, 102), '.', '') + '_' + replace(convert(varchar, @w_fecha_crea, 102), '.', '') + '.bcp',
             @w_errores  = @w_path + replace(convert(varchar(80), @w_tabla, 102), '.', '') + '_' + replace(convert(varchar, @w_fecha_crea, 102), '.', '') + '.err'
      
      select @w_cmd = @w_path_fuente + 's_app.cmd ' +  @w_tabla + ' in '              
      
      select @w_comando = @w_cmd + @w_destino + ' -b5000 -c -e' + @w_errores + ' -t"' + @w_separador + '" ' + '-config s_app.ini'
      
      if @i_debug = 'S' begin
         print 'path salida'
         print @w_tabla
         print @w_path
         print '@w_comando: ' + @w_comando
         print @w_basedatos
         print @w_campo
      end 
      
      exec @w_error = xp_cmdshell @w_comando
      if @w_error <> 0 begin
         select @w_desc_error =  'Error cargando Archivo BCP ' + @w_tabla
         print @w_comando
         print @w_desc_error
         
         exec cob_conta_super..sp_errorlog
         @i_operacion     = 'I',
         @i_fecha_fin     = @w_fecha_crea,
         @i_fuente        = @w_sp_name,
         @i_origen_error  = '28001',
         @i_descrp_error  = @w_desc_error
         
      end
      SIGUIENTE1:
   end
   
end

if exists (select 1 from cob_conta_super..sb_errorlog
           where er_fuente = @w_sp_name) begin
   exec cob_conta_super..sp_errorlog
   @i_fuente         =   @w_sp_name
   
   print 'EXISTEN ERRORES POR FAVOR VALIDAR EL REPORTE errorlog_sp_depura_tablas en REC/LISTADOS'
     
   return 1
end

return 0

go