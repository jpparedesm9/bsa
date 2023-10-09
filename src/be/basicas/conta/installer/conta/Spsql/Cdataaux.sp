/************************************************************************/
/*  Archivo:             cdataux.sp                                     */
/*  Stored procedure:   sp_con_dat_aux                                  */
/*  Base de datos:      cob_conta                                       */
/*  Producto:           contabilidad                                    */
/*  Disenado por:                                                       */
/*  Fecha de escritura:                                                 */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de la           */
/*  "NCR CORPORATION".                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Este programa genera el archivo plano para los criterios de consulta*/
/*  de las tablas auxiliares                                            */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_con_dat_aux')
    drop proc sp_con_dat_aux  
go

create proc sp_con_dat_aux(
@t_rty              char(1)         = null,
@t_trn              smallint        = null,
@t_debug            char(1)         = 'N',
@t_file             varchar(14)     = null,
@t_from             varchar(30)     = null,
@s_ssn              int             = null,
@s_date             datetime        = null,
@s_user             login           = null,
@s_term             descripcion     = null,
@s_corr             char(1)         = null,
@s_ssn_corr         int             = null,
@s_ofi              smallint        = null,
@i_operacion        char(1)         = null,
@i_modo             smallint        = 0,
@i_empresa          tinyint         = null,
@i_fecha_ini        datetime        = '01/01/1980',
@i_fecha_fin        datetime        = '12/31/2099',
@i_orden            int             = null,
@i_oficina_orig     smallint        = null,
@i_area_orig        smallint        = null,
@i_formato_fecha    tinyint         = 101,
@i_cuenta           cuenta_contable = null,
@i_frontend         char(1)         = 'N',
@i_ente             int             = null,
@o_orden            int             = null out,
@o_respuesta        char(1)         = null out
    
)
as
declare
@w_today             datetime,    
@w_return            int, 
@w_fin               int,     
@w_sp_name           varchar(32),  
@w_caracter          char(1),
@w_path              varchar(255),
@w_destino           varchar(255),
@w_errores           varchar(255),
@w_cmd               varchar(5000),
@w_error             int,
@w_secuencial        int,
@w_producto          int,
@w_comando           varchar(5000),
@w_fecha             datetime,
@w_fecha_real_resp   datetime,
@w_batch             int,
@w_ident_ctrl        int,
@w_sentencia         varchar(5000),
@w_empresa           tinyint,
@w_tabla             varchar(255),
@w_cuenta            varchar(25),
@w_campo             varchar(50),
@w_basedatos         varchar(50),
@w_conexion          varchar(255),
@w_ruta              varchar(255),
@w_usuario           varchar(255),
@w_password          varchar(255),
@w_unidad            varchar(255),
@w_path_fuente       varchar(255),
@w_archivo           varchar(255),
@w_archtit           varchar(255),
@w_archivo_err       varchar(255),
@w_path_dest         varchar(255),
@w_arch_bcp          varchar(255),
@w_fecha_crea        varchar(12),
@w_fecha_min         datetime,  
@w_fecha_hora_real   datetime,
@w_tipo              char(1),
@w_campo1            varchar(50),
@w_valor1            varchar(50),
@w_valor2            varchar(50),
@i_debug             char(1),
@w_carpeta           varchar(10),
@w_tipodep           char(1),
@w_desc_error        varchar(100),
@w_fecha_dep         datetime,
@w_terminal          descripcion,
@w_rowcount          int,
@w_genera            char(1),
@w_vista             char(50),
@w_vista_del         char(50),
@w_estado            char(1),
@w_estado_pro        char(1),
@w_archivo_sal       varchar(255),
@w_meses             smallint,
@w_contador          int,
@w_path_zip          varchar(255),
@w_server            varchar(50)

select @w_today    = convert(char(10),getdate(),101)
select @w_sp_name  = 'sp_con_dat_aux' 
select @w_path_zip = 'C:\WINDOWS\system32\'
select @w_server   = @@servername

if (@t_trn = 6978 and @i_operacion <> 'Q') and 
   (@t_trn = 6978 and @i_operacion <> 'I') and
   (@t_trn = 6978 and @i_operacion <> 'C') and
   (@t_trn = 6978 and @i_operacion <> 'R') and
   (@t_trn = 6978 and @i_operacion <> 'V')
   
begin   
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = 601077
    return 1
end


if @t_debug = 'S'
begin
   exec cobis..sp_begin_debug @t_file = @t_file
   select '/** Store Procedure **/ ' = @w_sp_name,
   t_file              = @t_file,
   t_from              = @t_from,
   i_operacion         = @i_operacion,
   i_modo              = @i_modo,
   i_empresa           = @i_empresa,
   i_oficina_orig      = @i_oficina_orig,
   i_area_orig         = @i_area_orig,
   i_fecha_ini         = @i_fecha_ini,
   i_fecha_fin         = @i_fecha_fin
   exec cobis..sp_end_debug
end

select @w_path = pp_path_destino
from cobis..ba_path_pro  
where pp_producto = 6

select @w_path_zip = pa_char
from cobis..cl_parametro
where pa_nemonico = 'ZIP'
and   pa_producto = 'CON'

select @w_estado = 'P'     ,    @w_fecha_hora_real = getdate()    ,  @w_producto = 6

if @i_operacion = 'V' begin
   select @w_contador = count(1)
   from cob_conta..cb_cuenta
   where cu_cuenta = @i_cuenta
   and   cu_acceso = 'A'
   
   if @w_contador > 0 begin
      select 'A'
      return 0
   end
   else 
      select 'M'
end

if @i_operacion = 'C'
begin
   if   @i_orden is not null 
   begin
      select   @w_estado_pro =  ps_estado
      from cobis..ad_proceso_system_op        
      where  ps_id   = @i_orden
      
      select @w_rowcount = @@rowcount

      if @w_rowcount <> 0
      begin
         if @w_estado_pro in ('I', 'P')
         begin
                select 
                  @o_orden     =  @i_orden,
                  @o_respuesta = 'N'                   
         end
         else
         begin
            if @w_estado_pro = 'E'
             select @o_orden     =  @i_orden,
                    @o_respuesta = 'X' 
             else
                  select @o_orden     =  @i_orden,
                    @o_respuesta = 'S' 
         end
      end
   end
   return 0    
end
   
if @i_operacion = 'I' begin
   begin tran
   save tran reg_solicitud
      
   insert into cb_datos_ctlr( 
   term,            sec_proc,         fecha_inicio,
   fecha_fin,       oficina ,         cuenta,      
   estado,          empresa,          ente )
   values(
   @s_term+@s_user, null,             @i_fecha_ini,
   @i_fecha_fin,    @i_oficina_orig , @i_cuenta,
   'I' ,            @i_empresa,       @i_ente )
      
   select @w_ident_ctrl = @@identity
   if @@error <> 0
   begin
      rollback tran reg_solicitud
    end
   
   select @w_comando = 'SP:cob_conta..sp_con_dat_aux  @i_operacion = ''Q'', @i_orden = ' + cast(  @w_ident_ctrl as varchar)
   
   insert into cobis..ad_proceso_system_op(
   ps_sec_sinc,       ps_cmd,              ps_producto,
   ps_estado,         ps_hora_inicio)
   values(
   @w_ident_ctrl,     @w_comando,          @w_producto,
   'I',               @w_fecha_hora_real     )
      
   select @w_error  = @@error ,  @w_secuencial     = @@identity
   
   if  @w_error <> 0   
   begin
      rollback tran reg_solicitud
      select @o_orden     =  @w_secuencial,
             @o_respuesta = 'X'
      return 0
   end

   select @w_secuencial     = @@identity
   
   update cb_datos_ctlr with (rowlock)
   set sec_proc = @w_secuencial
   from  cb_datos_ctlr 
   where  sec_cons = @w_ident_ctrl
   
   if @@error <> 0
   begin
      select @o_orden     =  @w_secuencial,
             @o_respuesta = 'X' 
      return 0
   end
    
   select 
   @o_orden     =  @w_secuencial,
   @o_respuesta = 'N'
                   
   commit tran
end    --modo 


if @i_operacion = 'Q'
begin
   select                 
   @i_fecha_ini    = fecha_inicio,   
   @i_fecha_fin    = fecha_fin,
   @i_oficina_orig = oficina ,
   @i_cuenta       = cuenta,
   @i_empresa      = empresa,
   @i_ente         = ente,
   @w_terminal     = term
   from    cb_datos_ctlr 
   where   sec_cons = @i_orden
    
   if @@rowcount <> 0
   begin

      select @w_meses = datediff (mm, @i_fecha_ini, @i_fecha_fin)

      if @w_meses > 1 begin
         print 'Rango maximo permitido de 1 mes'
         return 0
      end

      select @w_cuenta = ltrim(rtrim( @i_cuenta)) +  '%'
      
      select @w_basedatos = 'cob_conta..'
      if @i_cuenta is not null
         select @w_vista =   'dsaux' + rtrim(ltrim(@i_cuenta))
      else
         select @w_vista =   'dsaux' + rtrim(ltrim(convert(varchar,@i_ente)))

      select @w_sentencia = 'create view ' + @w_vista + ' as ' 
      select @w_sentencia = @w_sentencia + 'select  sc_producto, sc_comprobante, sc_fecha_tran, sc_oficina_orig, sc_area_orig, '
      select @w_sentencia = @w_sentencia + 'sc_descripcion, sc_tot_debito, sc_tot_credito, sc_mayorizado, sc_comp_definit, '
      select @w_sentencia = @w_sentencia + 'sc_tran_modulo, sa_asiento, sa_cuenta, sa_oficina_dest, sa_area_dest, sa_credito, '
      select @w_sentencia = @w_sentencia + 'sa_debito, sa_credito_me, sa_debito_me, sa_moneda, sa_ente, '
      select @w_sentencia = @w_sentencia + 'sa_tipo_doc = (select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente), '
      select @w_sentencia = @w_sentencia + 'sa_ced_ruc = (select en_ced_ruc from cobis..cl_ente where en_ente = sa_ente), '
      select @w_sentencia = @w_sentencia + 'sa_nombre = (select en_nomlar from cobis..cl_ente where en_ente = sa_ente), '
      select @w_sentencia = @w_sentencia + 'sa_con_rete, sa_base, sa_valret, sa_mayorizado,  sa_debcred,  sa_documento, sa_cheque, sa_doc_banco'
      select @w_sentencia = @w_sentencia + '   from  cob_conta_tercero..ct_scomprobante , cob_conta_tercero..ct_sasiento' 
      select @w_sentencia = @w_sentencia + '   where  sc_empresa = sa_empresa  and  sc_producto = sa_producto   and sc_comprobante = sa_comprobante  and sc_fecha_tran = sa_fecha_tran and sc_estado =   ' 
      select @w_sentencia = @w_sentencia + '''' + @w_estado + ''''
      
      if @i_oficina_orig is not null
         select @w_sentencia = @w_sentencia + '   and sa_oficina_dest = ' + convert(varchar(5),@i_oficina_orig) 
         
      select @w_sentencia = @w_sentencia + '   and sc_fecha_tran >=  ' +  '''' + convert (varchar(12), @i_fecha_ini , 101)  + ''''
      select @w_sentencia = @w_sentencia + '   and sc_fecha_tran <=  '  +  ''''+  convert (varchar(12), @i_fecha_fin , 101)  + ''''
      select @w_sentencia = @w_sentencia + '   and sc_empresa =   ' + convert(varchar(20), @i_empresa)
      if @w_cuenta is not null
         select @w_sentencia = @w_sentencia + '   and sa_cuenta  like ' + '''' + @w_cuenta + ''''
      
      if @i_ente is not null
         select @w_sentencia = @w_sentencia + '   and sa_ente = ' + convert(varchar(20),@i_ente)

      print @w_sentencia

      exec (@w_sentencia)
      if @@error <> 0 begin
          print 'Error en creacion de vista ' 
      end
      else
      begin

         select @w_archtit = 'titulo'+@w_vista

         select @w_tabla   = ltrim(rtrim(@w_vista))
         select @w_fecha_crea = replace(convert(varchar(12), getdate(), 102), '.', '')
         select @w_arch_bcp  = replace(convert(varchar(80), @w_tabla, 102), '.', '')  + '-' + @w_fecha_crea
         select @w_archivo = @w_path + @w_arch_bcp + @w_terminal + '.csv'
         select @w_archivo_err = @w_path + @w_arch_bcp + '.err'
         select @w_archivo_sal = @w_path + @w_arch_bcp + '.out'
         
         select @w_comando = 'echo ' --+ '"'
         select @w_comando = @w_comando + 'producto;comprobante;fecha_tran;oficina_orig;area_orig;descripcion;'
         select @w_comando = @w_comando + 'tot_debito;tot_credito;mayorizado;comp_definit;tran_modulo;asiento;'
         select @w_comando = @w_comando + 'cuenta;oficina_dest;area_dest;credito;debito;credito_me;debito_me;'
         select @w_comando = @w_comando + 'moneda;ente;tipo_doc;documento;nombre;con_rete;base;valret;mayorizado;debcred;'
         select @w_comando = @w_comando + 'oper_banco;cheque;doc_banco ' /*+'"'*/ + '> ' + @w_archivo
         PRINT @w_comando

         exec @w_error = xp_cmdshell @w_comando
         if @w_error <> 0 begin
            print 'Error generando Archivo: ' + @w_archivo
            print @w_comando
            PRINT @w_error
         end

         
         select @w_conexion = pa_char
         from cobis..cl_parametro
         where pa_nemonico = 'PLANO'
         and   pa_producto = 'CON'
              
         select @w_destino  = @w_archivo,
                @w_errores  = @w_archivo_err
         
         select @w_tabla  = @w_basedatos + @w_vista 
         
         select @w_comando = 'bcp ' + convert(varchar(40),rtrim(ltrim(@w_tabla))) + '  out  ' + @w_path + rtrim(ltrim(@w_archtit)) + ' -b5000 -c -e' + @w_archivo_err + ' -S' + @w_server +  ' -t";"  -T -o' + @w_archivo_sal
         

         exec @w_error = xp_cmdshell @w_comando
         if @w_error <> 0 begin
            print 'error en bcp titulo'
            insert into cob_conta..cb_errores values ('sp_con_dat_aux', 'Error en bcp de datos', @w_terminal, @w_vista, @w_today)
         end

         waitfor delay '00:00:05'
         
         select @w_comando = 'type ' + @w_path + rtrim(ltrim(@w_archtit)) + ' >> ' + @w_archivo
         
         select @w_comando
         
         exec @w_error = xp_cmdshell @w_comando
         if @w_error <> 0 begin
            print 'Error generando Archivo: ' + @w_archivo
            insert into cob_conta..cb_errores values ('sp_con_dat_aux', 'Error en archivo de titulos', @w_terminal, @w_vista, @w_today)
            print @w_comando
            PRINT @w_error
         end
         
         select @w_comando = 'del ' + @w_path + @w_archtit
         
         select @w_comando
         
         exec @w_error = xp_cmdshell @w_comando
         if @w_error <> 0 begin
            print 'Error generando Archivo: ' + @w_archivo
            insert into cob_conta..cb_errores values ('sp_con_dat_aux', 'Error en borrado de archivos temporales', @w_terminal, @w_vista, @w_today)
            print @w_comando
            PRINT @w_error
         end
         
         select @w_comando = @w_path_zip + 'pkzip25 -add -fast -max ' + @w_archivo + '.zip '+  @w_archivo
         
         exec @w_error = xp_cmdshell @w_comando
         if @w_error <> 0 begin
            print 'Error generando Archivo: ' + @w_archivo
            insert into cob_conta..cb_errores values ('sp_con_dat_aux', 'Error comprimiendo archivo', @w_terminal, @w_vista, @w_today)
            print @w_comando
            PRINT @w_error
         end

         waitfor delay '00:00:30'
         
         select @w_path_dest = pa_char + '\'
         from cobis..cl_parametro
         where pa_nemonico = 'PPL'
         and   pa_producto = 'CON'
         
         if @@rowcount = 0
         begin
           select @w_desc_error =  'NO EXISTE PARAMETRO DE RUTA DE SERVIDOR DESTINO ',
                  @w_error = 70002
         end
         
         select @w_comando = 'xcopy ' + @w_archivo + '.zip '+  @w_path_dest + ' /y'
         
         exec @w_error = xp_cmdshell @w_comando
         if @w_error <> 0 begin
            print 'Error generando Archivo: ' + @w_archivo
            insert into cob_conta..cb_errores values ('sp_con_dat_aux', 'Error compiando archivoen la ruta', @w_terminal, @w_path_dest, @w_today)
            print @w_comando
            PRINT @w_error
         end
         
         select @w_vista_del = ltrim(rtrim(@w_vista))
          
         select @w_sentencia = 'if exists(select 1 from sysobjects where name = ' 
                                + '''' + @w_vista_del + '''' 
                                + ')  '  +   'drop view   ' +  @w_vista_del

         select @w_error = 0
            
         exec (@w_sentencia)
         if @@error <> 0
         begin
            select 
            @o_orden     =  @w_secuencial,
            @o_respuesta = 'X'
            return 1
         end
      end
   end  
end

if @i_operacion = 'R' begin
   select @w_path_dest = pa_char
   from cobis..cl_parametro
   where pa_nemonico = 'PPL'
   and   pa_producto = 'CON'

   select @w_path_dest
end

return 0
go
