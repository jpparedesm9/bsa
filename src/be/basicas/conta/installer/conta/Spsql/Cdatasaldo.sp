/************************************************************************/
/*  Archivo:             csaldos.sp                                     */
/*  Stored procedure:   sp_con_saldos                                   */
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
/*  de los saldos                                                       */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_con_saldos')
    drop proc sp_con_saldos
go

create proc sp_con_saldos(
    @s_ssn          int         = null,
    @s_date         datetime    = null,
    @s_user         login       = null,
    @s_term         descripcion = null,
    @s_corr         char(1)     = null,
    @s_ssn_corr     int         = null,
    @s_ofi          smallint    = null,
    @t_rty          char(1)     = null,
    @t_trn          int         = null,
    @t_debug        char(1)     = 'N',
    @t_file         varchar(14) = null,
    @t_from         varchar(30) = null,
    @i_operacion    char(1)     = null,
    @i_empresa      tinyint     = null,
    @i_fecha_ini    datetime    = null,
    @i_fecha_fin    datetime    = null,
    @i_oficina_orig smallint    = null,
    @i_orden        int         = null,
    @i_area         smallint    = null,
    @i_cuenta       cuenta      = null,
    @i_modo         tinyint     = null,
    @i_ente         int         = null,
    @o_orden        int         = null out,
    @o_respuesta    char(1)     = null out

)
as
declare
    @w_today             datetime,    
    @w_return            int,         
    @w_sp_name           varchar(32),  
    @w_caracter          char(1),
    @w_path              varchar(255),
    @w_destino           varchar(255),
    @w_errores           varchar(255),
    @w_cmd               varchar(500),
    @w_error             int,
    @w_comando           varchar(5000),
    @w_fecha             datetime,
    @w_batch             int,
    @w_sentencia         varchar(5000),
    @w_empresa           tinyint,
    @w_producto          int,
    @w_tabla             varchar(255),
    @w_fecha_hora_real   datetime,
    @w_secuencial        int,
    @w_fin               int,
    @w_cuenta            varchar(25),
    @w_campo             varchar(50),
    @w_basedatos         varchar(50),
    @w_conexion          varchar(255),
    @w_ruta              varchar(255),
    @w_usuario           varchar(255),
    @w_password          varchar(255),
    @w_unidad            varchar(255),
    @w_path_fuente       varchar(255),
    @w_path_dest         varchar(255),
    @w_archivo           varchar(255),
    @w_archtit           varchar(255),
    @w_archivo_err       varchar(255),
    @w_ident_ctrl        int,
    @w_fecha_crea        varchar(12),
    @w_fecha_min         datetime,
    @w_tipo              char(1),
    @w_campo1            varchar(50),
    @w_valor1            varchar(50),
    @w_valor2            varchar(50),
    @i_debug             char(1),
    @w_carpeta           varchar(10),
    @w_tipodep           char(1),
    @w_desc_error        varchar(100),
    @w_fecha_dep         datetime,
    @w_rowcount          int,
    @w_genera            char(1),
    @w_vista             char(50),
    @w_vista_del         char(50),
    @w_terminal          descripcion,
    @w_estado            char(1),
    @w_archivo_sal       varchar(255),
    @w_arch_bcp          varchar(255),
    @w_corte             int,
    @w_corte_fin         int,
    @w_estado_corte      char(1),
    @w_periodo           int,
    @w_saldo             money,
    @w_saldo1            money,
    @w_estado_pro        char(1),
    @w_orig              varchar(5),
    @w_path_zip          varchar(255),
    @w_server            varchar(50)

select @w_today = convert(char(10),getdate(),101)
select @w_sp_name = 'sp_con_saldos'  ,@w_producto = 6 ,  @w_fecha_hora_real = getdate()
select @w_path_zip = 'C:\WINDOWS\system32\'
select @w_server   = @@servername

if (@t_trn <> 6272  and @i_operacion = 'Q') and 
   (@t_trn = 6272 and @i_operacion <> 'I')  and
   (@t_trn = 6272 and @i_operacion <> 'C') 
begin   /* 'Tipo de transaccion no corresponde' */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = 6000009
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
        i_fecha_ini         = @i_fecha_ini
    exec cobis..sp_end_debug
end

select @w_path = pp_path_destino
from cobis..ba_path_pro  
where pp_producto = 6

select @w_path_zip = pa_char
from cobis..cl_parametro
where pa_nemonico = 'ZIP'
and   pa_producto = 'CON'

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
                if @w_estado_pro = 'F' 
                begin
                   select 
                   @o_orden     =  @i_orden,
                   @o_respuesta = 'S' 
                end
                else
                begin
                   select 
                   @o_orden     =  @i_orden,
                   @o_respuesta = 'X' 
                end
            end
     end
    end
  return 0    
end

if @i_operacion = 'I'
begin

   begin tran
   save tran reg_solicitud
      
   insert into cb_datos_ctlr(
   term,          sec_proc,          fecha_inicio,
   fecha_fin,     oficina ,          cuenta,      
   estado,        empresa,           modo,
   ente)
   values(
   @s_term+@s_user, null,               @i_fecha_ini,
   @i_fecha_fin,    @i_oficina_orig ,   @i_cuenta,
   'I' ,            @i_empresa,         @i_modo,
   @i_ente )
      
   select @w_ident_ctrl = @@identity
   if @@error <> 0
   begin
      rollback tran reg_solicitud
      select @w_error = 107201
   end
   
   select @w_comando = 'SP:cob_conta..sp_con_saldos  @i_operacion = ''Q'', @i_orden = ' + cast(  @w_ident_ctrl as varchar)
   
   insert into cobis..ad_proceso_system_op(
   ps_sec_sinc,       ps_cmd,              ps_producto,
   ps_estado,         ps_hora_inicio)
   values(
   @w_ident_ctrl,     @w_comando,          @w_producto,
   'I',               @w_fecha_hora_real     )
   
   if @@error <> 0   
   begin
      rollback tran reg_solicitud
      select @w_error = 107202
   end

   select @w_secuencial     = @@identity
   
   update cb_datos_ctlr with (rowlock)
   set sec_proc = @w_secuencial
   from  cb_datos_ctlr 
   where  sec_cons = @w_ident_ctrl
   
   if @@error <> 0
   begin
      rollback tran reg_solicitud
      select @w_error = 107207
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
   @w_terminal     = term,
   @i_modo         = modo,
   @i_ente         = ente
   from    cb_datos_ctlr 
   where   sec_cons = @i_orden

   select @w_basedatos = 'cob_conta..'
   if @i_cuenta is not null
      select @w_vista =   'dsal' + rtrim(ltrim(@i_cuenta))
   else
      select @w_vista =   'dsal' + rtrim(ltrim(@i_ente))
   
   select @w_cuenta = ltrim(rtrim( @i_cuenta)) +  '%'
   
   select @w_sentencia = 'if exists(select 1 from sysobjects where name = ' 
                          + '''' + @w_vista + '''' 
                          + ')  '  +   'drop view   ' +  @w_vista

   select @w_error = 0
   
   exec (@w_sentencia)
   if @@error <> 0
   begin
      return 1
   end
   
   select @w_error = 0

   exec (@w_sentencia)
   if @@error <> 0
   begin
      select  @o_orden     =  @i_orden ,@o_respuesta = 'X' 
      return 1
   end
   
   select  
   @w_corte        = co_corte,
   @w_periodo      = co_periodo,
   @w_estado_corte = co_estado
   from  cob_conta..cb_corte
   where co_empresa      = @i_empresa 
   and   co_fecha_ini   <= @i_fecha_ini 
   and   co_fecha_fin   >= @i_fecha_ini
   
   select  
   @w_corte_fin    = co_corte
   from  cob_conta..cb_corte
   where co_empresa      = @i_empresa 
   and   co_fecha_ini   <= @i_fecha_fin
   and   co_fecha_fin   >= @i_fecha_fin
   
   if @i_modo = 1
   begin --2
      select @w_orig = 'MOV'
      
      if @w_estado_corte = 'A'
      begin
         select @w_sentencia = 'create view ' + @w_vista  + ' as ' +
         'select    sa_oficina, 
                    sa_cuenta,
                    sa_nombre = (select cu_nombre from cob_conta..cb_cuenta where cu_cuenta = sa_cuenta),
                    sa_fecha = (select co_fecha_ini from cob_conta..cb_corte where co_corte = sa_corte and co_periodo = sa_periodo),
                    sum(isnull(sa_saldo,0)) sa_saldo,
                    sum(isnull(sa_saldo_me,0)) sa_saldo_me'
                  + '   from cob_conta..cb_saldo' 
                  + '   where  sa_empresa  = ' + convert(varchar(20), @i_empresa)
                  + '   and    sa_periodo  = ' + convert(varchar(10), @w_periodo) 
                  + '   and    sa_corte    >= ' + convert(varchar(10), @w_corte) 
                  + '   and    sa_corte    <= ' + convert(varchar(10), @w_corte_fin)
                  + '   and    sa_cuenta  like ' + '''' + @w_cuenta + ''''
                  if @i_oficina_orig is not null begin
                     select @w_sentencia = @w_sentencia + '   and    sa_oficina  in (    select je_oficina from cob_conta..cb_jerarquia  where je_empresa =  ' 
                                                     +     convert(varchar(20), @i_empresa)
                                                     + '  and   (je_oficina =   ' + convert(varchar(5),@i_oficina_orig) 
                                                     + '  or je_oficina_padre =  ' + convert(varchar(5),@i_oficina_orig)  + ' ))'
                  end
                  select @w_sentencia = @w_sentencia + 'group by sa_oficina,sa_cuenta,sa_corte, sa_periodo'
   
      end
      else begin
         select @w_sentencia = 'create view ' + @w_vista  + ' as ' +
         'select hi_oficina,
                 hi_cuenta,
                 sa_nombre = (select cu_nombre from cob_conta..cb_cuenta where cu_cuenta = hi_cuenta),
                 hi_fecha = (select co_fecha_ini from cob_conta..cb_corte where co_corte = hi_corte and co_periodo = hi_periodo),
                 sum(isnull(hi_saldo,0)) hi_saldo,
                 sum(isnull(hi_saldo_me,0)) hi_saldo_me'
                  + '   from cob_conta_his..cb_hist_saldo' 
                  + '   where  hi_empresa  = ' + convert(varchar(20), @i_empresa)
                  + '   and    hi_periodo  = ' + convert(varchar(10), @w_periodo) 
                  + '   and    hi_corte    >= ' + convert(varchar(10), @w_corte)
                  + '   and    hi_corte    <= ' + convert(varchar(10), @w_corte_fin) 
                  + '   and    hi_cuenta  like ' + '''' + @w_cuenta + ''''
                  if @i_oficina_orig is not null begin
                  select @w_sentencia = @w_sentencia + '   and    hi_oficina  in (    select je_oficina from cob_conta..cb_jerarquia  where je_empresa =  ' 
                                                     +     convert(varchar(20), @i_empresa)
                                                     + '  and   (je_oficina =   ' + convert(varchar(5),@i_oficina_orig) 
                                                     + '  or je_oficina_padre =  ' + convert(varchar(5),@i_oficina_orig)  + ' ))'
                  end
                  select @w_sentencia = @w_sentencia + 'group by hi_oficina,hi_cuenta,hi_corte, hi_periodo'
                  
      end
   end  -- 2
   if @i_modo = 2
   begin -- 3
      select @w_orig = 'CONS'
      
      if @w_estado_corte = 'A'
      begin
          select @w_sentencia = 'create view ' + @w_vista  + ' as ' +
          'select    of_oficina, sa_cuenta,
                     sa_nombre = (select cu_nombre from cob_conta..cb_cuenta where cu_cuenta = sa_cuenta),
                     sa_fecha = (select co_fecha_ini from cob_conta..cb_corte where co_corte = sa_corte and co_periodo = sa_periodo),                
                     sum(isnull(sa_saldo,0)) sa_saldo,
                     sum(isnull(sa_saldo_me,0)) sa_saldo_me'
                   + '   from cob_conta..cb_saldo,cob_conta..cb_oficina,cob_conta..cb_jerarquia' 
                   + '   where  sa_empresa  = ' + convert(varchar(20), @i_empresa)
                   + '   and    sa_periodo  = ' + convert(varchar(10), @w_periodo) 
                   + '   and    sa_corte    >= ' + convert(varchar(10), @w_corte) 
                   + '   and    sa_corte    <= ' + convert(varchar(10), @w_corte_fin)
                   + '   and    sa_cuenta  like ' + '''' + @w_cuenta + ''''
                   + '   and    of_empresa  = ' + convert(varchar(20), @i_empresa)
                   + '   and    of_oficina = je_oficina_padre'
                   + '   and    je_empresa  = ' + convert(varchar(20), @i_empresa)
                   if @i_oficina_orig is not null
                      select @w_sentencia = @w_sentencia + '   and    of_oficina  = ' + convert(varchar(5),@i_oficina_orig) 
                   select @w_sentencia = @w_sentencia + '   and    sa_oficina = je_oficina
                         group by of_oficina,sa_cuenta,sa_corte, sa_periodo'
      end
      else
      begin
           select @w_sentencia = 'create view ' + @w_vista  + ' as ' +
          'select    of_oficina, hi_cuenta,
                     hi_nombre = (select cu_nombre from cob_conta..cb_cuenta where cu_cuenta = hi_cuenta),
                     hi_fecha = (select co_fecha_ini from cob_conta..cb_corte where co_corte = hi_corte and co_periodo = hi_periodo),                
                     sum(isnull(hi_saldo,0)) hi_saldo,
                     sum(isnull(hi_saldo_me,0)) hi_saldo_me'
                   + '   from cob_conta_his..cb_hist_saldo,cob_conta..cb_oficina,cob_conta..cb_jerarquia' 
                   + '   where  hi_empresa  = ' + convert(varchar(20), @i_empresa)
                   + '   and    hi_periodo  = ' + convert(varchar(10), @w_periodo) 
                   + '   and    hi_corte    >= ' + convert(varchar(10), @w_corte) 
                   + '   and    hi_corte    <= ' + convert(varchar(10), @w_corte_fin)
                   + '   and    hi_cuenta  like ' + '''' + @w_cuenta + ''''
                   + '   and    of_empresa  = ' + convert(varchar(20), @i_empresa)
                   + '   and    of_oficina = je_oficina_padre'
                   + '   and    je_empresa  = ' + convert(varchar(20), @i_empresa)
                   if @i_oficina_orig is not null
                      select @w_sentencia = @w_sentencia + '   and    of_oficina  = ' + convert(varchar(5),@i_oficina_orig) 
                   select @w_sentencia = @w_sentencia + '   and    hi_oficina = je_oficina
                         group by of_oficina,hi_cuenta, hi_corte, hi_periodo'
      end
   end  --3  
   if @i_modo = 3 begin
      select @w_orig = 'TERC'
      select @w_sentencia = 'create view ' + @w_vista  + ' as '
      select @w_sentencia = @w_sentencia  + 'select st_periodo, st_fecha = ' + '''' + cast(@i_fecha_ini as varchar) + '''' + ', st_cuenta, st_oficina, st_area, st_ente, st_saldo, st_saldo_me, '
      select @w_sentencia = @w_sentencia + 'st_tipo_doc = (select en_tipo_ced from cobis..cl_ente where en_ente = st_ente), '
      select @w_sentencia = @w_sentencia + 'st_documento = (select en_ced_ruc from cobis..cl_ente where en_ente = st_ente), '
      select @w_sentencia = @w_sentencia + 'st_nombre = (select en_nomlar from cobis..cl_ente where en_ente = st_ente) '
      select @w_sentencia = @w_sentencia  + 'from cob_conta_tercero..ct_saldo_tercero where st_corte = ' + cast(@w_corte as varchar) 
      select @w_sentencia = @w_sentencia  + ' and st_periodo = ' + cast(@w_periodo as varchar) 
      if @i_cuenta is not null
         select @w_sentencia = @w_sentencia + ' and st_cuenta = ' + '''' + @i_cuenta + ''''
      if @i_oficina_orig is not null
         select @w_sentencia = @w_sentencia  + ' and st_oficina = ' + cast(@i_oficina_orig as varchar) 
      select @w_sentencia = @w_sentencia  + ' and st_empresa = ' + cast(@i_empresa as varchar)
      
      if @i_ente is not null
         select @w_sentencia = @w_sentencia  + ' and st_ente = ' + convert(varchar(20),@i_ente)
         
   end
   print @w_sentencia
   exec (@w_sentencia)

   if @@error <> 0 
   begin
      select  @o_orden     =  @i_orden ,@o_respuesta = 'X' 
      return 1
   end
   else
   begin

      if not exists(select 1 from cob_conta..sysobjects where name = @w_vista) begin
         print 'Vista no creada'
         select  @o_orden     =  @i_orden ,@o_respuesta = 'X' 
         insert into cob_conta..cb_errores values ('sp_con_saldos', 'Error en creacion de vista', @w_terminal, @i_cuenta, @w_today)
         return 1
      end

      select @w_archtit = 'titulo'+@w_vista
      
      print @w_orig
      
      select @w_terminal = convert(varchar(10), @w_terminal) + @w_orig
      select @w_tabla   = ltrim(rtrim(@w_vista))
      select @w_fecha_crea = replace(convert(varchar(12), getdate(), 102), '.', '')
      select @w_arch_bcp  = replace(convert(varchar(80), @w_tabla, 102), '.', '')  + '-' + @w_fecha_crea
      select @w_archivo = @w_path + @w_arch_bcp + @w_terminal + '.csv'
      select @w_archivo_err = @w_path + @w_arch_bcp + @w_terminal + '.err'
      select @w_archivo_sal = @w_path + @w_arch_bcp + @w_terminal + '.out'
       
      select @w_comando = 'echo ' --+ '"'
      if @i_modo = 3
         select @w_comando = @w_comando + 'PERIODO;FECHA;CUENTA;OFICINA;AREA;ENTE;SALDO;SALDO_ME;TIPO_DOC;DOCUMENTO;NOMBRE'
      else 
         select @w_comando = @w_comando + 'OFICINA;CUENTA;DESCRIPCION;FECHA;SALDO;SALDO_ME'
      
      select @w_comando = @w_comando /*+'"' */+ '> ' + @w_archivo
      
      exec @w_error = xp_cmdshell @w_comando
      if @w_error <> 0 begin
         print 'Error generando Archivo: ' + @w_archivo
         insert into cob_conta..cb_errores values ('sp_con_saldos', 'Error en archivo titulos', @w_terminal, @i_cuenta, @w_today)
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
      
      select @w_comando = 'select * from ' + @w_tabla
      
      select @w_comando = 'bcp ' + @w_tabla + '  out  ' + @w_path + rtrim(ltrim(@w_archtit)) + ' -b5000 -c -e' + @w_archivo_err + ' -t";"  -T ' + '-S' + @w_server
      
      exec @w_error = xp_cmdshell @w_comando
      if @w_error <> 0 begin
         print 'Error generando bcp: ' + @w_archivo
         insert into cob_conta..cb_errores values ('sp_con_saldos', 'Error en creacion de bcp', @w_terminal, @i_cuenta, @w_today)
         print @w_comando
         PRINT @w_error
      end

      select @w_comando = 'type ' + @w_path + rtrim(ltrim(@w_archtit)) + ' >> ' + @w_archivo
      
      select @w_comando
      print @w_comando
      print @w_archivo
      
      exec @w_error = xp_cmdshell @w_comando
      if @w_error <> 0 begin
         print 'Error generando Archivo: ' + @w_archivo
         print @w_comando
         PRINT @w_error
      end
      
      select @w_comando = ''
      select @w_comando = 'del ' + @w_path + @w_archtit
      
      select @w_comando
      
      exec @w_error = xp_cmdshell @w_comando
      if @w_error <> 0 begin
         print 'Error generando Archivo: ' + @w_archivo
         insert into cob_conta..cb_errores values ('sp_con_saldos', 'Error en borrado de temporal', @w_terminal, @i_cuenta, @w_today)
         print @w_comando
         PRINT @w_error
      end
      
      select @w_comando = ''
      select @w_comando = @w_path_zip + 'pkzip25 -add -fast -max ' + @w_archivo + '.zip '+  @w_archivo
      
      exec @w_error = xp_cmdshell @w_comando
      if @w_error <> 0 begin
         print 'Error generando comprimiendo archivo: ' + @w_archivo
         insert into cob_conta..cb_errores values ('sp_con_saldos', 'Error comprimiendo archivo', @w_terminal, @i_cuenta, @w_today)
         print @w_comando
         PRINT @w_error
         return 1
      end
      
      waitfor delay '00:00:30'
      
      select @w_path_dest = pa_char + '\'
      from cobis..cl_parametro
      where pa_nemonico = 'PPL'
      and   pa_producto = 'CON'
      
      if @@rowcount = 0
      begin
        select 
        @w_desc_error =  'NO EXISTE PARAMETRO DE RUTA DE SERVIDOR DESTINO ',
        @w_error = 70002
        insert into cob_conta..cb_errores values ('sp_con_saldos', 'No existe ruta de archivo', @w_terminal, @i_cuenta, @w_today)
      end
      select @w_comando = ''
      select @w_comando = 'xcopy ' + @w_archivo + '.zip '+  @w_path_dest + ' /y'
      
      exec @w_error = xp_cmdshell @w_comando
      if @w_error <> 0 begin
         print 'Error trasmitiendo archivo: ' + @w_archivo
         insert into cob_conta..cb_errores values ('sp_con_saldos', 'Error copiando archivo en ruta', @w_terminal, @w_path_dest, @w_today)
         print @w_comando
         PRINT @w_error
         return 1
      end

      select @w_sentencia = 'if exists(select 1 from sysobjects where name = ' 
                             + '''' + @w_vista + '''' 
                             + ')  '  +   'drop view   ' +  @w_vista
       
      select @w_error = 0
       
      exec (@w_sentencia)
      if @@error <> 0
      begin
         select  @o_orden     =  @i_orden ,@o_respuesta = 'X' 
         return 1
      end
      
   end -- else
end

return 0
go
