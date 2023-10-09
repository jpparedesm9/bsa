/************************************************************************/
/*     Archivo:             mig_rol_definition.sp                       */
/*     Stored procedure:    sp_mig_rol_definition                       */
/*     Base de datos:       cobis                                       */
/*     Producto:            Clientes                                    */
/*     Disenado por:        Martín Borbor                               */
/*     Fecha de escritura:  04-Oct-2012                                 */
/************************************************************************/
/*                    IMPORTANTE                                        */
/*     Este programa es parte de los paquetes bancarios propiedad de    */
/*     "MACOSA", representantes exclusivos para el Ecuador de la        */
/*     "NCR CORPORATION".                                               */
/*     Su uso no autorizado queda expresamente prohibido asi como       */
/*     cualquier alteracion o agregado hecho por alguno de sus          */
/*     usuarios sin el debido consentimiento por escrito de la          */
/*     Presidencia Ejecutiva de MACOSA o su representante.              */
/*                    PROPOSITO                                         */
/*     Finalidad realizar procesos dependiendo de 2 operacione:         */
/*     Operacion G = Genera archivo script con los respectivos insert   */ 
/*                   para las tablas roles-componentes entre otros,     */
/*                   y respectivas transacciones de acuerdo al rol.     */
/*     Operacion P = Realiza el respectivo insert masivo a las tablas   */ 
/*                   correspondinetes de roles - componetes.            */
/*                    MODIFICACIONES                                    */
/*     FECHA          AUTOR          RAZON                              */
/*     04-Oct-2012    M Borbor    Emision inicial                       */
/*     08-Feb-2013    F. Lopez    Asociacion automatic roles a productos*/
/*     28-Ago-2013    J.Tagle     Migración Servicios Autorizados       */
/*     11-04-2016     BBO         Migracion Sybase-Sqlserver FAL        */
/*     22-04-2016     ELO         Migracion Sybase-Sqlserver FAL        */
/************************************************************************/
	
use cobis
go

SET ANSI_NULLS OFF
go

if exists (select * from sysobjects where name = 'sp_mig_rol_definition')
   drop proc sp_mig_rol_definition
go
create proc sp_mig_rol_definition (
   @i_rol            int,
   @i_operation      char(1),
   @t_debug          char(1)     = 'N',
   @t_file           varchar(10) = null,
   @t_show_version   bit         = 0
)
as
declare @w_sp_name varchar(32),
   @w_module       varchar(64),
   @w_agent        varchar(50),
   @w_component    varchar(255),
   @w_type_rec     varchar(20),
   @w_records      varchar(255),
   @w_records_null varchar(255),
   @w_page         varchar(40),
   @w_navigation   varchar(40),
   @w_rol          int,
   @w_order        int,
   @w_role         int,
   @w_codigo       int,
   @w_producto     tinyint,
   @w_moneda       tinyint,
   @w_transaccion  int,
   @w_servicio	   varchar(500),
   @w_fecha        varchar(10),
   @w_autoriza     smallint,
   @w_estado       char(1),
   @w_descripcion  varchar(64),
   @w_ad_rol       varchar(20),
   @w_print        varchar(64),
   @w_error1       varchar(64),
   @w_error2       varchar(64),
   @w_ok           varchar(30),
   @w_sigt         smallint,
   @w_conreg       tinyint,
   @w_conts        int,
   @w_ro_time_out  smallint, 
   @w_ro_admin_seg varchar(1), 
   @w_ro_departamento smallint, 
   @w_ro_oficina   smallint 

select @w_sp_name = 'sp_mig_rol_definition'
select @w_conts   = 100
select @w_fecha   = 'getdate()'
select @w_ad_rol  = 'ad_rol'
select @w_ok      = '----->  ya existe la trn ok'
select @w_error1  = 'Error en eliminar registros'
select @w_error2  = 'Proceso exitoso en eliminacion'

-----------------------------------------
----  VERSIONAMIENTO DEL PROGRAMA   -----
-----------------------------------------
if @t_show_version = 1
begin
   print 'Stored procedure sp_mig_rol_definition, Version 4.0.0.10'
   return 0
end

if @i_operation not in('G','P') 
begin
   print 'No corresponde codigo de operacion' 
   return 1
end

/* Verificar que exista el rol */
select @w_rol = null
from ad_rol
where ro_rol = @i_rol

if @@rowcount = 0
begin
   print 'No existe rol ingresado'
   return 1
end

/** Generar registros **/
If @i_operation = 'G'
begin
   print 'use cobis'
   print 'go'
   print ''
   ---------------------------------
   set @w_print = '----  GENERA ROLES MODULE   -----'
   print 'print '+ @w_print + ''
   print ''
   print 'delete from an_mig_role_module where mr_role = ' + convert(varchar, @i_rol)
   print ''
   print 'if @@error != 0'
   print '   print '' + @w_error1 + '''
   print 'else'
   print '   print '' + @w_error2 + '''
   print ''
   print 'go'
   print ''

   set @w_conreg = 0
   select @w_module = ''
   select @w_codigo = 0
  
   select mo_name as name, @i_rol as rol     
   into #module
   from an_role_module, an_module 
   where mo_id = rm_mo_id
   and rm_rol  = @i_rol

   while 1=1
   begin
      set rowcount 1
      select  @w_module = name
      from #module
      where name > @w_module 
      order by name

      /* si no existe, error */
      if @@rowcount = 0 break
                set rowcount 0
      /* Print Inserccion en la tabla  */
      print '   insert into an_mig_role_module values(''+ @w_module + '',' + convert(varchar, @i_rol) + ')'

      if @@error != 0
      begin
         print 'Error en generar insert an_mig_role_module'
         return 1
      end
      
      /* Guardar datos cada 100: segun valor constante */
      if @w_conreg = @w_conts
      begin
         set @w_conreg = 0
         print 'go'
      end
      else
      begin
         set @w_conreg = @w_conreg + 1
      end 

   end /* Fin While */   
   if @w_conreg != 0
   begin
      print 'go'
      print ''
   end
   set rowcount 0
   ---------------------------------
   set @w_print = '----  GENERA ROLES COMPONENT   -----'
   print 'print '' + @w_print + '''
   print ''
   print 'delete from an_mig_role_component where mr_role = ' + convert(varchar, @i_rol)
   print ''
   print 'if @@error != 0'
   print '   print '' + @w_error1 + '''
   print 'else'
   print '   print '' + @w_error2 + '''
   print ''
   print 'go'
   print ''

   set @w_conreg = 0
   select @w_component = ''
   select @w_codigo = 0

   select co_name as name, @i_rol as rol    
   into #component
   from an_role_component, an_component 
   where co_id = rc_co_id
   and rc_rol  = @i_rol

   while 1=1
   begin
      set rowcount 1
      select @w_component = name
      from #component
      where name > @w_component 
      order by name

      /* si no existe, error */
      if @@rowcount = 0 break
          set rowcount 0

      /* Print Inserccion en la tabla  */
      print '   insert into an_mig_role_component values('' + @w_component + '',' + convert(varchar, @i_rol) + ')'

      if @@error != 0
      begin
         print 'Error en generar insert an_mig_role_module'
         return 1
      end
      
      /* Guardar datos cada 100: segun valor constante */
      if @w_conreg = @w_conts
      begin
         set @w_conreg = 0
         print 'go'
      end
      else
      begin
         set @w_conreg = @w_conreg + 1
      end

   end /* Fin While */
   if @w_conreg != 0
   begin
      print 'go'
      print ''
   end
   set rowcount 0
   ---------------------------------
   set @w_print = '----  GENERA ROLES PAGE   -----'
   print 'print '' + @w_print + '''
   print ''
   print 'delete from  an_mig_role_page where mr_role = ' + convert(varchar, @i_rol)
   print ''
   print 'if @@error != 0'
   print '   print '' + @w_error1 + '''
   print 'else'
   print '   print '' + @w_error2 + '''
   print ''
   print 'go'
   print ''

   set @w_conreg = 0
   select @w_page = ''
   select @w_codigo = 0
  
   select pa_name as name, @i_rol as rol   
   into #page
   from an_role_page, an_page 
   where pa_id = rp_pa_id
   and rp_rol  = @i_rol

   while 1=1
   begin
      set rowcount 1
      select @w_page = name
      from #page
      where name > @w_page 
      order by name

      /* si no existe, error */
      if @@rowcount = 0 break
          set rowcount 0

      /* Print Inserccion en la tabla  */
      print '   insert into an_mig_role_page values('' + @w_page + '',' + convert(varchar, @i_rol) + ')'

      if @@error != 0
      begin
         print 'Error en generar insert an_mig_role_page'
         return 1
      end
      
      /* Guardar datos cada 100: segun valor constante */
      if @w_conreg = @w_conts
      begin
         set @w_conreg = 0
      print 'go'
      end
      else
      begin
         set @w_conreg = @w_conreg + 1
      end

   end /* Fin While */
   if @w_conreg != 0
   begin
      print 'go'
      print ''
   end
   set rowcount 0
---------------------------------
set @w_print = '----  GENERA ROLES AGENT   -----'
   print 'print '' + @w_print + '''
   print ''
   print 'delete from an_mig_role_agent where mr_role = ' + convert(varchar, @i_rol)
   print ''
   print 'if @@error != 0'
   print '   print '' + @w_error1 + '''
   print 'else'
   print '   print '' + @w_error2 + '''
   print ''
   print 'go'
   print ''

   set @w_conreg = 0
   select @w_agent = ''
   select @w_codigo = 0
   select @w_order = 0
  
   select ag_name as name, @i_rol as rol, ra_order as secuencia     
   into #agent
   from an_role_agent, an_agent 
   where ag_id = ra_ag_id
   and ra_rol  = @i_rol

   while 1=1
   begin
      set rowcount 1
      select  @w_agent = name, @w_order = secuencia
      from #agent
      where name > @w_agent 
      order by name

      /* si no existe, error */
      if @@rowcount = 0 break
                set rowcount 0
      /* Print Inserccion en la tabla  */
      print '   insert into an_mig_role_agent values('' + @w_agent + '',' + convert(varchar, @i_rol) + ',' + convert(varchar, @w_order) + ' '

      if @@error != 0
      begin
         print 'Error en generar insert an_mig_role_agent'
         return 1
      end
      
      /* Guardar datos cada 100: segun valor constante */
      if @w_conreg = @w_conts
      begin
         set @w_conreg = 0
         print 'go'
      end
      else
      begin
         set @w_conreg = @w_conreg + 1
      end 

   end /* Fin While */   
   if @w_conreg != 0
   begin
      print 'go'
      print ''
   end
   set rowcount 0
---------------------------------
   set @w_print = '----  GENERA ROLES NAVIGATION ZONE   -----'
   print 'print '' + @w_print + '''
   print ''
   print 'delete from  an_mig_role_navigation_zone where mr_role = ' + convert(varchar, @i_rol)
   print ''
   print 'if @@error != 0'
   print '   print '' + @w_error1 + ''' 
   print 'else'
   print '   print '' + @w_error2 + '''
   print ''
   print 'go'
   print ''

   set @w_conreg = 0
   select @w_navigation = ''
   select @w_codigo = 0
  
   select nz_name as name, @i_rol as rol  
   into #navigation
   from an_role_navigation_zone, an_navigation_zone 
   where nz_id = rn_nz_id
   and rn_rol  = @i_rol

   while 1=1
   begin
      set rowcount 1
      select @w_navigation = name
      from #navigation
      where name > @w_navigation 
      order by name

      /* si no existe, error */
      if @@rowcount = 0 break
          set rowcount 0

      /* Print Inserccion en la tabla  */      
      print '   insert into an_mig_role_navigation_zone values('' + @w_navigation + '',' + convert(varchar, @i_rol) + ')' 

      if @@error != 0
      begin
         print 'Error en generar insert an_mig_role_navigation_zone'
         return 1
      end
      
      /* Guardar datos cada 100: segun valor constante */
      if @w_conreg = @w_conts
      begin
         set @w_conreg = 0
         print 'go'
      end
      else
      begin
         set @w_conreg = @w_conreg + 1
      end

   end /* Fin While */
   if @w_conreg != 0
   begin
      print 'go'
      print ''
   end
   set rowcount 0
   ---------------------------------
   set @w_print = '----  GENERA INSERT AD_ROL   -----'
   print 'print '' + @w_print + '''
   ---------------------------------
   print ''
   set @w_conreg = 0
   select @w_descripcion = ''
   select @w_codigo = 0
   select @w_estado = 'V'
   select @w_ro_time_out  = 0
   select @w_ro_admin_seg = '' 
   select @w_ro_departamento = 0
   select @w_ro_oficina   = 0 
  
   select @w_descripcion = ro_descripcion, @w_ro_time_out = ro_time_out, @w_ro_admin_seg = ro_admin_seg, 
          @w_ro_departamento = ro_departamento, @w_ro_oficina = ro_oficina
   from ad_rol 
   where ro_rol  = @i_rol

   select @w_sigt = siguiente
   from cl_seqnos 
   where tabla  = @w_ad_rol

   if @w_sigt < @i_rol
   begin
      update cl_seqnos 
      set siguiente = @i_rol 
      where tabla   = @w_ad_rol

      if @@error != 0
      begin
          print 'Error en actualizar seqnos ad_rol'
          return 1
      end
   end

   /* Print Inserccion en la tabla  */    
   print 'if not exists ( select * from ad_rol where ro_descripcion = '' + @w_descripcion + '')'
   print 'begin'
   print '   insert into ad_rol values(' + convert(varchar, @i_rol) + ',1,'' + @w_descripcion + '',' + @w_fecha + ',1,'' + @w_estado + '',' + @w_fecha + ',null,'' + @w_ro_admin_seg + '',null,null)'
   print 'end'
   print ''
   --print 'go'
   print ''

   set @w_print = '----  ACTUALIZA CAMPOS AD_ROL   -----'
   print 'print '' + @w_print + '''
   print ''

   if @w_ro_time_out is not null
   begin
      print '   update cobis..ad_rol'
      print '    set ro_time_out = ' + convert(varchar, @w_ro_time_out)
      print '   where ro_rol  = ' + convert(varchar,@i_rol)
      --print 'go'
      print ''
   end

   if @w_ro_departamento is not null
   begin
      print '   update cobis..ad_rol'
      print '    set ro_departamento = ' + convert(varchar, @w_ro_departamento)
      print '   where ro_rol  = ' + convert(varchar,@i_rol)
      --print 'go'
      print ''
   end

   if @w_ro_oficina is not null
   begin
      print '   update cobis..ad_rol'
      print '    set ro_oficina = ' + convert(varchar, @w_ro_oficina)
      print '   where ro_rol  = ' + convert(varchar, @i_rol)
      --print 'go'
      print ''
   end
   print 'go'
   print ''

   ---------------------------------
   set @w_print = '----  GENERA INSERT TRANSACCION   -----'
   print 'print '' + @w_print + ''' 
   print ''

   set @w_conreg = 0
   select @w_transaccion = 0
   select @w_codigo = 0

   select ta_producto as producto, ta_moneda as moneda, ta_transaccion as transaccion
   into #transaction
   from ad_tr_autorizada 
   where ta_rol  = @i_rol
   and ta_estado = 'V'

   while 1=1
   begin
      set rowcount 1
      select @w_producto = producto, @w_moneda = moneda, @w_transaccion = transaccion 
      from #transaction
      where transaccion > @w_transaccion 
      order by transaccion

      /* si no existe, error */
      if @@rowcount = 0 break
          set rowcount 0

      /* Print Inserccion en la tabla  */
      print 'if exists(select 1 from ad_tr_autorizada'
      print '         where ta_transaccion = ' + convert(varchar,@w_transaccion)
      print '         and ta_moneda        = ' + convert(varchar,@w_moneda)
      print '         and ta_rol           = ' + convert(varchar, @i_rol) +')' 
      print 'begin'
      print '      print '' + @w_ok + '''
      print 'end'
      print 'else'
      print 'begin'
      print '      insert into ad_tr_autorizada values(' + @w_producto + ',''R'',' + @w_moneda + ',' + @w_transaccion + ',' + convert(varchar, @i_rol) + ',' + @w_fecha + ',1,''V'',' + @w_fecha + ')'
      print 'end'
      print ''
      if @@error != 0
      begin
          print 'Error en generar insert ad_tr_autorizada'
          return 1
      end
      
      /* Guardar datos cada 100: segun valor constante */
      if @w_conreg = @w_conts
      begin
         set @w_conreg = 0
         print 'go'
      end
      else
      begin
         set @w_conreg = @w_conreg + 1
      end
   end /* Fin While */
   if @w_conreg != 0
   begin
      print 'go'
      print ''
   end
   
   ---------------------------------
   set @w_print = '----  GENERA INSERT SERVICIOS   -----'
   print 'print '' + @w_print + '''
   print ''

   set rowcount 0   
   set @w_conreg = 0
   select @w_servicio = ''
   select @w_codigo = 0
   select @w_ok      = '----->  ya existe la servicio ok'

   select ts_producto as producto, ts_moneda as moneda, ts_servicio as servicio
   into #servicios
   from ad_servicio_autorizado
   where ts_rol  = @i_rol
   and ts_estado = 'V'
   order by ts_servicio

   while 1=1
   begin
      set rowcount 1
      select @w_producto = producto, @w_moneda = moneda, @w_servicio = servicio 
      from #servicios
      where servicio > @w_servicio 
      order by servicio

      /* si no existe, error */
      if @@rowcount = 0 break
          set rowcount 0

	  /* Print Inserccion en la tabla  */
      print 'if exists(select 1 from ad_servicio_autorizado'
      print '         where ts_servicio = "' + @w_servicio + '"' 
      print '         and ts_moneda        = ' + convert(varchar, @w_moneda) 
      print '         and ts_rol           = ' + convert(varchar, @i_rol) + ')' 
      print 'begin'
      print '      print '' + @w_ok + ''' 
      print 'end'
      print 'else'
      print 'begin'
      print '      insert into ad_servicio_autorizado values("' + @w_servicio + '",' + convert(varchar, @i_rol) + ',' + @w_producto + ',''R'', ' + convert(varchar, @w_moneda) + ',' + @w_fecha + ',''V'',' + @w_fecha + ')'      
	  print 'end'
      print ''
      if @@error != 0
      begin
          print 'Error en generar insert ad_servicio_autorizado'
          return 1
      end
      
      /* Guardar datos cada 100: segun valor constante */
      if @w_conreg = @w_conts
      begin
         set @w_conreg = 0
         print 'go'
      end
      else
      begin
         set @w_conreg = @w_conreg + 1
      end
   end /* Fin While */
   if @w_conreg != 0
   begin
      print 'go'
      print ''
   end   
 ---------------------------------
   set @w_print   = '----  GENERA INSERT ROL PROD   -----'
   set @w_records = ''
       
   print 'print '+ @w_print + '' 
   print ''
   print 'delete cobis..ad_pro_rol where pr_rol = ' + convert(varchar, @i_rol)
   print 'go'
   print ''

   while 1=1
   begin
      set rowcount 1
      select @w_producto = pr_producto, @w_moneda = pr_moneda, @w_type_rec = pr_tipo, @w_records = convert(varchar,pr_producto) + '-' + convert(varchar,pr_moneda) + '-' + pr_tipo
      from cobis..ad_pro_rol
      where pr_rol = @i_rol
        and pr_estado = 'V'
        and convert(varchar,pr_producto) + '-' + convert(varchar,pr_moneda) + '-' + pr_tipo > @w_records
      order by pr_producto, pr_moneda, pr_tipo

      /* si no existe, error */
      if @@rowcount = 0 
      begin
         break
         set rowcount 0
      end

      /* Print Inserccion en la tabla  */
      print 'insert into ad_pro_rol values(' + convert(varchar, @i_rol) + ',' + @w_producto + ','' + @w_type_rec + '',' + convert(varchar, @w_moneda) + ',getdate(),1,''V'',getdate(),null)'
      print ''
      if @@error != 0
      begin
          print 'Error en generar insert ad_tr_autorizada'
          return 1
      end
      
      /* Guardar datos cada 100: segun valor constante */
      if @w_conreg = @w_conts
      begin
         set @w_conreg = 0
         print 'go'
      end
      else
      begin
         set @w_conreg = @w_conreg + 1
      end
   end /* Fin While */
   if @w_conreg != 0
   begin
      print 'go'
      print ''
   end
   
   set rowcount 0
end /*  Finaliza operacion G  */

/** Proceso Inverso **/
If @i_operation = 'P'
begin
begin tran
   ----  PROCESA ROLES MODULE  -----
   delete from an_role_module  where rm_rol = @i_rol

   insert into an_role_module 
   select mo_id as codigo, mr_role as rol       
   from an_mig_role_module, an_module 
   where mr_mo_name = mo_name
   and mr_role  = @i_rol

   if @@error != 0
   begin
      /* Error en insercion de registro */
      print 'Error al insertar migración roles módulo'
      rollback
      return 1
   end

----  PROCESA ROLES COMPONET  -----
   delete from an_role_component where rc_rol = @i_rol

   insert into an_role_component
   select co_id as codigo, mr_role as rol      
   from an_mig_role_component, an_component 
   where mr_co_name = co_name
   and mr_role  = @i_rol

   if @@error != 0
   begin
      /* Error en insercion de registro */
      print 'Error al insertar migración roles component'
      rollback
      return 1
   end

----  PROCESA ROLES PAGE  -----
   delete from an_role_page where rp_rol = @i_rol

   insert into an_role_page
   select pa_id as codigo, mr_role as rol      
   from an_mig_role_page, an_page 
   where mr_pa_name = pa_name
   and mr_role  = @i_rol

   if @@error != 0
   begin
      /* Error en insercion de registro */
      print 'Error al insertar migración roles page'
      rollback
      return 1
   end

----  PROCESA ROLES AGENT  -----
   delete from an_role_agent  where ra_rol = @i_rol

   insert into an_role_agent 
   select ag_id as codigo, mr_role as rol , mr_order as secuencial      
   from an_mig_role_agent, an_agent 
   where mr_ag_name = ag_name
   and mr_role  = @i_rol

   if @@error != 0
   begin
      /* Error en insercion de registro */
      print 'Error al insertar migración roles agent'
      rollback
      return 1
   end

----  PROCESA ROLES NAVIGATION ZONE  -----
   delete from an_role_navigation_zone  where rn_rol = @i_rol

   insert into an_role_navigation_zone
   select mr_role as rol, nz_id as codigo      
   from an_mig_role_navigation_zone, an_navigation_zone 
   where mr_nz_name = nz_name
   and mr_role  = @i_rol

   if @@error != 0
   begin
      /* Error en insercion de registro */
      print 'Error al insertar migración roles navigation'
      rollback
      return 1
   end

commit tran  

------   BUSQUEDA REGISTROS NO EXISTENCIA AN_MODULE, AN_COMPONENT, AN_PAGE, AN_NAVIGATION  -----
   select @w_records = ''
   select @w_records_null = ''
   select @w_type_rec = ''

   print ''
   print '--Listado de registros no insertados por inconsistencia de parametrizacion:'
   print ''

   select co_name as name, mr_co_name as valor, 'COMPONENTCEN' as type--, 0 as secuencial
   into #records_null
   --inicio mig syb-sql 18042016
   from an_mig_role_component
        left outer join an_component on mr_co_name = co_name
   where mr_role  = @i_rol
   --fin mig syb-sql 18042016   
   /****** MIGRACION SYB-SQL
   from an_mig_role_component, an_component
   where mr_co_name *= co_name
   and mr_role  = @i_rol
   ******/
   
   insert into #records_null
   select mo_name as name, mr_mo_name as valor, 'MODULE' as type--, 0 as secuencial  
   --inicio mig syb-sql 18042016
   from an_mig_role_module
        left outer join an_module on mr_mo_name = mo_name
   where mr_role  = @i_rol
   --fin mig syb-sql 18042016
   /**** MIGRACION SYB-SQL
   from an_mig_role_module, an_module
   where mr_mo_name *= mo_name
   and mr_role  = @i_rol
   *****/

   insert into #records_null
   select pa_name as name, mr_pa_name as valor, 'PAGE' as type--, 0 as secuencial
   --inicio mig syb-sql 18042016
   from an_mig_role_page
        left outer join an_page on mr_pa_name = pa_name
   where mr_role  = @i_rol
   --fin mig syb-sql 18042016
   /**** MIGRACION SYB-SQL
   from an_mig_role_page, an_page
   where mr_pa_name *= pa_name
   and mr_role  = @i_rol
   *****/

   insert into #records_null
   select ag_name as name, mr_ag_name as valor, 'AGENT' as type--, mr_order as secuencial
   --inicio mig syb-sql 18042016
   from an_mig_role_agent
        left outer join an_agent on mr_ag_name = ag_name
   where mr_role  = @i_rol
   --fin mig syb-sql 18042016
   /**** MIGRACION SYB-SQL
   from an_mig_role_agent, an_agent
   where mr_ag_name *= ag_name
   and mr_role  = @i_rol
    ****/
    
   insert into #records_null
   select nz_name as name, mr_nz_name as valor, 'NAVIGATION' as type--, 0 as secuencial
   --inicio mig syb-sql 18042016
   from an_mig_role_navigation_zone
        left outer join an_navigation_zone on mr_nz_name = nz_name
   where mr_role  = @i_rol
   --fin mig syb-sql 18042016
   /**** MIGRACION SYB-SQL
   from an_mig_role_navigation_zone, an_navigation_zone
   where mr_nz_name *= nz_name
   and mr_role  = @i_rol
    *****/
    
   while 1=1
   begin
      set rowcount 1
      select @w_records_null = name, @w_records = valor, @w_type_rec = type
      from #records_null
      where valor > @w_records 
      and name is null
      order by valor 

      /* si no existe, error */
      if @@rowcount = 0 break
          set rowcount 0

         /* Print busqueda en la tabla  */
         if @w_type_rec = 'MODULE'
         begin
            print '   select * from cobis..an_mig_role_module where mr_mo_name = '' + @w_records + '' and mr_role  = ' + convert(varchar, @i_rol)
	    --print '   select * from cobis..an_mig_role_module where mr_mo_name = '' + @w_records + ''' 
            print ''
         end
         if @w_type_rec = 'COMPONENTCEN'
         begin
            print '   select * from cobis..an_mig_role_component where mr_co_name = '' + @w_records + '' and mr_role  = ' + convert(varchar, @i_rol)
	    --print '   select * from cobis..an_mig_role_component where mr_co_name = '' + @w_records + '''
            print ''
         end
         if @w_type_rec = 'PAGE'
         begin
            print '   select * from cobis..an_mig_role_page where mr_pa_name = '' + @w_records + '' and mr_role  = ' + convert(varchar, @i_rol)
	    --print '   select * from cobis..an_mig_role_page where mr_pa_name = '' + @w_records + '''
            print ''
         end
         if @w_type_rec = 'AGENT'
         begin
            print '   select * from cobis..an_mig_role_agent where mr_ag_name = '' + @w_records + '' and mr_role  = ' + convert(varchar, @i_rol)
	    --print '   select * from cobis..an_mig_role_agent where mr_ag_name = '' + @w_records + '''
            print ''
         end
         if @w_type_rec = 'NAVIGATION'
         begin
            print '   select * from cobis..an_mig_role_navigation_zone where mr_nz_name = '' + @w_records + '' and mr_role  = ' +  convert(varchar, @i_rol)
	    --print '   select * from cobis..an_mig_role_navigation_zone where mr_nz_name = ''+ @w_records + '''
            print ''
         end

      if @@error != 0
      begin
         print 'Error en busqueda registros null en tablas.'
         return 1
      end

   end   /* Fin while busqueda faltantes  */
end /*  Finaliza operacion P  */
set rowcount 0
go
