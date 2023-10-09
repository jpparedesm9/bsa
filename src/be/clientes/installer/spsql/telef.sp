use cobis
go
if not object_id('sp_telefono') is null
   drop proc sp_telefono
go
create procedure sp_telefono (
/************************************************************************/
/*   Archivo:                   telef.sp                                */
/*   Stored procedure:          sp_telefono                             */
/*   Base de datos:             cobis                                   */
/*   Producto:                  Clientes                                */
/*   Disenado por:              Mauricio Bayas/Sandra Ortiz             */
/*   Fecha de escritura:        12-Nov-1992                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   "MACOSA", representantes exclusivos para el Ecuador de la          */
/*   "NCR CORPORATION".                                                 */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/*                           PROPOSITO                                  */
/*   Este programa procesa las transacciones del stored procedure       */
/*   Busqueda de telefono                                               */
/*                              MODIFICACIONES                          */
/*   FECHA           AUTOR               RAZON                          */
/*   12/Nov/92       M. Davila           Emision Inicial                */
/*   13/Ene/93       L. Carvajal         Tabla de errores, variables    */
/*                                      de debug                        */
/*   07/Ago/00       J. Anaguano         Validaciones por Integridad de */ 
/*                                      Datos                           */ 
/*   15/07/2008  Ing. J. Luis Alprado F. Adicion del campo ac_hora como */
/*                                      criterio de ordenamiento        */
/*   06/Mayo/2009    Manuel Morales      La modificacion a la condicion */
/*                                      de el telefono ya esta asociado */
/*                                      a esta direccion.               */
/*   10/Abr/12      Daniel Vera         Adicion de campo te_telf_cobro  */
/*                                      para identificar telefonos      */
/*                                      utilizados para gestion de      */
/*                                      cobros.                         */
/*   29/Ene/14      Miguel Moya         REQ-27122                       */
/*   01/Abr/2020    ACH                 CASO:137576, se añade parametro */
/*   01/Dic/2020    SRO                 CASO 149335                     */
/*   13/09/2021     KVI                 Req. 123670 reporte mod. datos  */
/*   15/07/2022     KVI                 Error.188413                    */
/*   19/01/2023     KVI                 R.193221 Verificar.TelCel B2B.Gr*/
/************************************************************************/
   @s_ssn              int         = null,
   @s_user             login       = null,
   @s_term             varchar(32) = null,
   @s_sesn             int         = null,
   @s_culture          varchar(10) = null,
   @s_date             datetime    = null,
   @s_srv              varchar(30) = null,
   @s_lsrv             varchar(30) = null,
   @s_ofi              smallint    = null,
   @s_rol              smallint    = null,
   @s_org_err          char(1)     = null,
   @s_error            int         = null,
   @s_sev              tinyint     = null,
   @s_msg              descripcion = null,
   @s_org              char(1)     = null,
   @p_alterno          tinyint     = null,
   @t_debug            char(1)     = 'N',
   @t_file             varchar(10) = null,
   @t_from             varchar(32) = null,
   @t_trn              smallint    = null,
   @i_operacion        char(1),
   @i_ente             int         = null,  -- Codigo del ente al cual se le asocia un telefono
   @i_direccion        tinyint     = null,  -- Codigo de la direccion a la cual se asocia un telefono
   @i_secuencial       tinyint     = null,  -- Numero que indica la cantidad de telefonos que tiene el cliente
   @i_valor            varchar(16) = null,  -- Numero de telefono
   @i_tipo_telefono    char(2)     = null,  -- Tipo de telefono
   @i_te_telf_cobro    char(1)     = 'N',   -- Especifica si es telefono para gestion de cobro //DVE
   @i_tborrado         char(1)     = 'D',   -- 'D' - Unicamente se va a eliminar el telefono seleccionado
   @i_ejecutar         char(1)     = 'N',    --MALDAZ 06/25/2012 HSBC CLI-0565  
   @t_show_version     bit  = 0,      -- Mostrar la versión del programa   
   @i_verificado       char(1)     = null,
   @i_formato_fecha    int         = null,
   @i_cod_area         varchar(10) = null,  -- req27122 -- 'T' - Se van a eliminar TODAS los telefonos asociados a la dir.
   @i_canal            varchar(30) = null,
   @i_verificacion     char(1)     = null   -- R.193221
)
as
declare
   @w_transaccion      int,
   @w_sp_name          varchar(32),
   @w_aux              int,
   @w_valor            varchar(16),
   @w_tipo_telefono    char(2),
   @w_secuencial       varchar(3),
   @w_di_telefono      tinyint,
   @v_valor            varchar(16),
   @v_tipo_telefono    char(2),
   @o_siguiente        int,
   @w_te_telf_cobro    varchar(1), --DVE
   @v_te_telf_cobro    varchar(1) ,--DVE
   @w_doble_aut        char(1),    --Miguel Aldaz  06/22/2012 Doble autorización CLI-0565 HSBC
   @w_autorizacion     int,        --Miguel Aldaz  06/22/2012 Doble autorización CLI-0565 HSBC
   @w_estado_campo     char(1),    --Miguel Aldaz  06/26/2012 Doble autorización CLI-0565 HSBC
   @w_return           int,
   @w_verificado       char(1),
   @w_cod_area         varchar(10), -- req-27122
   @v_cod_area         char(10),    -- req-27122
   @v_verificado       char(1),
   @w_act_duplicado_tel char(1) = 'N',
   @w_error             int, -- Error.188413 
   @w_canal             int, -- R.193221
   @w_pcanal            int, -- R.193221,
   @w_id_celular_1      int  -- R.193221
   
   
  if @t_show_version = 1
  begin
    print 'Stored Procedure=sp_telefono Version=4.0.6172.5341 TFS-ChangeSet=C147439 TFS-GetDate=2016-54-24'
    return 0
  end

select @w_sp_name = 'sp_telefono'
select @w_act_duplicado_tel = pa_char from cobis..cl_parametro where pa_producto = 'CLI' and pa_nemonico in ('ACCEDU')

/** Insert **/
if @i_operacion = 'I'
begin
   if @t_trn = 111
   begin
      -- Verificacion de claves foraneas 
      if not exists (
                     select di_ente
                     from   cl_direccion
                     where  di_ente      = @i_ente
                     and    di_direccion = @i_direccion )
      begin
         exec sp_cerror
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 101001
            -- 'No existe direccion'
         return 101001
      end
      
      if not exists ( select codigo
                      from   cl_catalogo
                      where  codigo = @i_tipo_telefono
                      and    tabla  = ( select codigo
                                        from   cl_tabla
                                        where  tabla = 'cl_ttelefono'))
      begin
         exec sp_cerror
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 101025
            /* 'No existe tipo de telefono'*/
         return 101025
      end

      begin tran
         update cl_direccion
         set    di_telefono  = isnull(di_telefono,0) + 1
         where  di_ente      = @i_ente
         and    di_direccion = @i_direccion
         
         if @@error != 0
         begin
            exec sp_cerror
                 @t_debug        = @t_debug,
                 @t_file         = @t_file,
                 @t_from         = @w_sp_name,
                 @i_num          = 105035
                 --   'Error en incremento de telefono'
            return 105035
         end
         
         select @o_siguiente = di_telefono
         from   cl_direccion
         where  di_ente      = @i_ente
         and    di_direccion = @i_direccion

         /* Se valida el numero de telefono para no insertar numeros
            repetidos.  M. Silva .  01/21/98.  Bco. Estado */
  
         -- XOL: Estamos dentro de la @i_operacion = 'I', no es necesario esto 
         --if @i_operacion <>'U'   -- valida que este proceso no ocurra cuando exista una actualizaci¢n de los telefonos.
         --begin   
         
         if(@i_tipo_telefono = 'C')
         begin
		     if(@w_act_duplicado_tel = 'N')
			 begin
	             if exists ( select te_valor
	                             from   cl_telefono
	                             where  te_valor         = @i_valor
	                             --and    te_ente          = @i_ente
	                             --and    te_tipo_telefono = @i_tipo_telefono 
	                             --and    te_direccion     = @i_direccion
	                             /*and    te_telf_cobro    = @i_te_telf_cobro*/)
	             begin
	                  exec sp_cerror
	                      @t_debug        = @t_debug,
	                      @t_file         = @t_file,
	                      @t_from         = @w_sp_name,
	                      @i_num          = 107109
	                  --'El teléfono ya esta asociado a una dirección.'
	                  return  107082      
	             end
			 end
		 end
            
		 insert into cl_telefono 
		 (
		         te_ente,        te_direccion,     te_secuencial,
		         te_valor,       te_tipo_telefono, te_telf_cobro,--DVE
		         te_funcionario, te_verificado,    te_fecha_registro, te_area
		 )  --req-27122
		 values 
		 (       @i_ente,        @i_direccion,     @o_siguiente,
		         @i_valor,       @i_tipo_telefono, @i_te_telf_cobro,--DVE
		         @s_user,        'N',              @s_date,           @i_cod_area
		 )
		 
		 if @@error <> 0
		 begin
		    --print 'en %1! dir %2! sig %3! val %4! tt %5! tc %6!',@i_ente,@i_direccion,@o_siguiente,@i_valor,@i_tipo_telefono , @i_te_telf_cobro -- JLi 22-07-2003
		    exec sp_cerror
		         @t_debug        = @t_debug,
		         @t_file         = @t_file,
		         @t_from         = @w_sp_name,
		         @i_num          = 103038
		          /* 'Error en creacion de telefono'*/
		    return 103038
		 end
		 
		 -- Transaccion servicios - cl_telefono 
		 insert into ts_telefono 
		 (
		        secuencial,       tipo_transaccion, clase,        fecha,
		        usuario,          terminal,         srv,          lsrv,
		        ente,             direccion,        telefono,     valor,
		        tipo,             cobro,            codarea,	  oficina,	
				hora,             canal
		 ) --DVE -- req 27122
		 values
		 (
		        @s_ssn,           @t_trn,           'N',          @s_date/*getdate()*/,
		        @s_user,          @s_term,          @s_srv,       @s_lsrv, 
		        @i_ente,          @i_direccion,     @o_siguiente, @i_valor,
		        @i_tipo_telefono, @i_te_telf_cobro, @i_cod_area,	 @s_ofi,	
				getdate(),        @i_canal
		 ) --DVE
		 
		 if @@error <> 0
		 begin
		    exec sp_cerror
		         @t_debug        = @t_debug,
		         @t_file         = @t_file,
		         @t_from         = @w_sp_name,
		         @i_num          = 103005
		         --'Error en creacion de transaccion de servicio'
		     return  103005
		 end

      commit tran
      select @o_siguiente
	  
	  --Inicio R.193221
	  select @w_pcanal = ca_canal from cobis..cl_canal where ca_nombre = 'b2b' and ca_estado = 'V'
	  select @w_canal = ca_canal from cobis..cl_canal where ca_nombre = lower(@i_canal) and ca_estado = 'V' 
	  print 'sp_telefono -->> operacion: I -->> pcanal: ' + convert(varchar,@w_pcanal)
	  print 'sp_telefono -->> operacion: I -->> canal: ' + convert(varchar,@w_canal)
	  --Fin R.193221
			
	  if @i_tipo_telefono = 'C' -- Error.188413
	  and @w_canal != @w_pcanal -- R.193221
	  begin
	    --EJECUCION DE CAMBIO DE ESTADO bv_login 
        exec @w_error = cob_bvirtual..sp_b2c_mantenimiento_login 
        @s_ssn        = @s_ssn,
        @s_ofi        = @s_ofi,
        @s_user       = @s_user,
        @s_date       = @s_date,
        @s_srv        = @s_srv,
        @s_term       = @s_term,
        @s_rol        = @s_rol,
        @s_lsrv       = @s_lsrv,
        @s_sesn       =  @s_ssn,
        @i_operacion  = 'E',
        @i_ente_mis   = @i_ente,    
        @i_celular    = @i_valor,
        @i_canal      = @i_canal   
        
        if @w_error <> 0
        begin
           exec sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 105035
                /* 'Error en actualizacion de telefono'*/
           return 105035
        end
	  end
	  
      return 0
   end
   else
   begin
      exec sp_cerror
         @t_debug      = @t_debug,
         @t_file       = @t_file,
         @t_from       = @w_sp_name,
         @i_num        = 151051
         /*  'No corresponde codigo de transaccion' */
      return 151051
   end
end

/** Update **/
if @i_operacion = 'U'
begin
   if @t_trn = 112
   begin
   
      if @i_valor is null or ltrim(rtrim(@i_valor)) = '' begin	  --SRO. Para borrar en móvil
	     select @i_operacion = 'D',
		        @t_trn = 148
	  end
	  else begin
         if @i_ejecutar = 'N'
         begin
            /* Verificacion de claves foraneas */
            if not exists (
            select di_ente
                            from cl_direccion
                            where di_ente    = @i_ente
                            and di_direccion = @i_direccion )
            begin
               exec sp_cerror
                  @t_debug        = @t_debug,
                  @t_file         = @t_file,
                  @t_from         = @w_sp_name,
                  @i_num          = 101001
                   /* 'No existe direccion'*/
               return 101001
            end
            if not exists (
                            select codigo
                            from   cl_catalogo
                            where  codigo = @i_tipo_telefono
                            and    tabla  = (select codigo
                                             from   cl_tabla
                                             where  tabla = 'cl_ttelefono')
            )
            begin
               exec sp_cerror
                  @t_debug        = @t_debug,
                  @t_file         = @t_file,
                  @t_from         = @w_sp_name,
                  @i_num          = 101025
                  /*'No existe tipo de telefono'*/
               return 101025
            end
         end --if @i_ejecutar = 'N'
         
         /* Verificacion de cambio: @w_aux = 0 -> cambio  @w_aux = -1 -> no cambio */
         select  @w_valor         = te_valor,
                 @w_tipo_telefono = te_tipo_telefono,
                 @w_te_telf_cobro = te_telf_cobro,
                 @w_verificado    = te_verificado,--DVE
                 @w_cod_area      = te_area -- req 27122
         from    cl_telefono
         where   te_ente          = @i_ente
         and     te_direccion     = @i_direccion
         and     te_secuencial    = @i_secuencial
         
         if @@rowcount != 1
         begin
            exec sp_cerror
               @t_debug      = @t_debug,
               @t_file       = @t_file,
               @t_from       = @w_sp_name,
               @i_num        = 105035
               /* 'No existe telefono'*/
            return 105035
         end
         
         select @v_valor = @w_valor,
                @v_tipo_telefono = @w_tipo_telefono,
                @v_te_telf_cobro = @w_te_telf_cobro --DVE 
         
         select @w_aux = -1
         if @w_valor = @i_valor
            select @w_valor = null, @v_valor = null
         else
         begin
            select @w_valor = @i_valor, @w_aux = 0
            /*
            insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                                      ac_campo, ac_valor_ant, ac_valor_nue,
                                      ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
            values
                                      (@i_ente, @s_date,'cl_telefono',
                                      'te_valor', @v_valor, @w_valor,
                                      'U', @i_direccion, @i_secuencial, getdate())
            if @@error != 0
            begin
                   exec sp_cerror
                         @t_debug    = @t_debug,
                         @t_file     = @t_file,
                         @t_from     = @w_sp_name,
                         @i_num      = 103001
                   return 1 
            end*/
         end
         
         if @w_tipo_telefono = @i_tipo_telefono
            select @w_tipo_telefono = null, @v_tipo_telefono = null
         else
            select @w_tipo_telefono = @i_tipo_telefono, @w_aux = 0
         
         --DVE    
         if @w_te_telf_cobro = @i_te_telf_cobro
            select @w_te_telf_cobro = null, @v_te_telf_cobro = null
         else
            select @w_te_telf_cobro = @i_te_telf_cobro, @w_aux = 0
            
         if @w_verificado = @i_verificado
            select @w_verificado = null, @v_verificado = null
         else
            select @w_verificado = @i_verificado, @w_aux = 0
         
         /*req 27122  validación si el valor ingresado es diferente al valor actual*/  
         if @w_cod_area = @i_cod_area
            select @w_cod_area = null, @v_cod_area = null
         else
            select @w_cod_area = @i_cod_area, @w_aux = 0
         
         if @w_aux = 0
         begin
            if(@i_tipo_telefono = 'C')
            begin
		        if(@w_act_duplicado_tel = 'N')
			    begin
	               if exists (select te_valor
	                               from   cl_telefono
	                               where  te_valor = @i_valor
	                               and    te_ente <> @i_ente)
	               begin
	                    exec sp_cerror
	                        @t_debug        = @t_debug,
	                        @t_file         = @t_file,
	                        @t_from         = @w_sp_name,
	                        @i_num          = 107109
	                    --'El teléfono ya esta asociado a una dirección.'
	                    return  107082      
	               end
				end
		    end
            begin tran
               update cl_telefono
               set    te_valor              = @i_valor,
                      te_tipo_telefono      = isnull(@i_tipo_telefono,te_tipo_telefono),
                      te_telf_cobro         = isnull(@i_te_telf_cobro,te_telf_cobro), --DVE
                      te_funcionario        = @s_user,
                      te_verificado         = isnull(@i_verificado, 'N'),
                      te_fecha_ver          = case @i_verificado when 'S' then @s_date else null end,
                      te_fecha_modificacion = @s_date,
                      te_area               = isnull(@i_cod_area,te_area) 
               where  te_ente               = @i_ente
               and    te_direccion          = @i_direccion
               and    te_secuencial         = @i_secuencial
         
               if @@error <> 0
               begin
                  exec sp_cerror
                       @t_debug        = @t_debug,
                       @t_file         = @t_file,
                       @t_from         = @w_sp_name,
                       @i_num          = 105035
                       /* 'Error en actualizacion de telefono'*/
                  return 105035
               end
               
               /* Transaccion servicios - cl_telefono */
               insert into ts_telefono 
               (secuencial,       tipo_transaccion, clase,    fecha,
                usuario,          terminal,         srv,      lsrv,
                ente,             direccion,        telefono, valor,
                tipo,             cobro,			codarea,  oficina,  hora,
			    canal,            rol) --DVE
               values
			   (@s_ssn,           @t_trn,           'P',           @s_date/*getdate()*/,
                @s_user,          @s_term,          @s_srv,        @s_lsrv, 
                @i_ente,          @i_direccion,     @i_secuencial, @v_valor,
                @v_tipo_telefono, @v_te_telf_cobro,	@v_cod_area,   @s_ofi,  getdate(),
				@i_canal,         @s_rol)
               
               if @@error <> 0
               begin
                  exec sp_cerror
                       @t_debug        = @t_debug,
                       @t_file         = @t_file,
                       @t_from         = @w_sp_name,
                       @i_num          = 103005
                       /* 'Error en creacion de transaccion de servicio'*/
                  return  103005
               end
            
               insert into ts_telefono 
               (secuencial,       tipo_transaccion, clase,    fecha,
                usuario,          terminal,         srv,      lsrv,
                ente,             direccion,        telefono, valor,
                tipo,             cobro,			codarea,  oficina,	hora,
				canal,            rol) --DVE
               values
			   ( @s_ssn,           @t_trn,       'A',           @s_date/*getdate()*/,
                 @s_user,          @s_term,      @s_srv,        @s_lsrv, 
                 @i_ente,          @i_direccion, @i_secuencial, @w_valor,
                 @w_tipo_telefono, @w_te_telf_cobro,	@w_cod_area,  @s_ofi,	getdate(),
				 @i_canal,         @s_rol)
                 
               if @@error <> 0
               begin
                  exec sp_cerror
                       @t_debug        = @t_debug,
                       @t_file         = @t_file,
                       @t_from         = @w_sp_name,
                       @i_num          = 103005
                       /* 'Error en creacion de transaccion de servicio'*/
                  return  103005
               end
         
               if @v_valor <> @w_valor
               begin
                  insert into cl_actualiza 
                  (       ac_ente, ac_fecha, ac_tabla,
                          ac_campo, ac_valor_ant, ac_valor_nue,
                          ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
                  values
                  (       @i_ente, @s_date,'cl_telefono',
                          'te_valor', @v_valor, @w_valor,
                          'U', @i_direccion, @i_secuencial, getdate())
                   
                  if @@error <> 0
                  begin
                     exec sp_cerror
                          @t_debug    = @t_debug,
                          @t_file     = @t_file,
                          @t_from     = @w_sp_name,
                          @i_num      = 103001
                          return 103001 /*'Error en creacion de cliente'*/
                  end
               end
            commit tran
			
			if @i_tipo_telefono = 'C' -- Error.188413
	        begin
			  --EJECUCION DE CAMBIO DE ESTADO bv_login 
              exec @w_error = cob_bvirtual..sp_b2c_mantenimiento_login 
              @s_ssn        = @s_ssn,
              @s_ofi        = @s_ofi,
              @s_user       = @s_user,
              @s_date       = @s_date,
              @s_srv        = @s_srv,
              @s_term       = @s_term,
              @s_rol        = @s_rol,
              @s_lsrv       = @s_lsrv,
              @s_sesn       =  @s_ssn,
              @i_operacion  = 'E',
              @i_ente_mis   = @i_ente,    
              @i_celular    = @i_valor,
              @i_canal      = @i_canal   
              
              if @w_error <> 0
              begin
                 exec sp_cerror
                      @t_debug        = @t_debug,
                      @t_file         = @t_file,
                      @t_from         = @w_sp_name,
                      @i_num          = 105035
                      /* 'Error en actualizacion de telefono'*/
                 return 105035
              end
			end
			
			--Inicio R.193221
		    select @w_pcanal = ca_canal from cobis..cl_canal where ca_nombre = 'b2b' and ca_estado = 'V'
		    select @w_canal = ca_canal from cobis..cl_canal where ca_nombre = lower(@i_canal) and ca_estado = 'V' 
		    print 'sp_telefono -->> pcanal: ' + convert(varchar,@w_pcanal)
		    print 'sp_telefono -->> canal: ' + convert(varchar,@w_canal)
		
		    --REGISTRO VERIFICACION TELEFONO CELULAR B2B 
		    if @i_tipo_telefono = 'C' and @w_canal = @w_pcanal 
		    begin
		        if @i_verificacion = 'N' 
		        begin
			        print 'sp_telefono -->> Ingresa Verificacion N'
		            if not exists (select 1 from cobis..cl_verif_co_tel 
                                   where ct_valor = ltrim(rtrim(@i_valor)) 
                                   and   ct_tipo  = 'C' 
                                   and   ct_ente  = @i_ente
				    			   and   ct_verificacion = 'N') 
		            begin
		                insert into cobis..cl_verif_co_tel
		                       (ct_ente, ct_direccion, ct_valor, ct_tipo,          ct_verificacion, ct_canal, ct_fecha_proc, ct_fecha)
                        values (@i_ente, @i_direccion, @i_valor, @i_tipo_telefono, @i_verificacion, @w_canal, @s_date,       getdate()) 
		            end
				    else
				    begin
				        update cobis..cl_verif_co_tel
				    	set ct_fecha_proc = @s_date,
				    	    ct_fecha = getdate()
				        where ct_valor = ltrim(rtrim(@i_valor)) 
                        and   ct_tipo  = 'C' 
                        and   ct_ente  = @i_ente
						and   ct_verificacion = 'N'
				    end
		        
				    exec cobis..sp_cerror  
		              @t_debug  = @t_debug,
			          @t_file   = @t_file,
			          @t_from   = @w_sp_name,
			          @i_num    = 103204
			          --'NECESITA VERIFICAR SU TELEFONO CELULAR'		   
			          return 103204
		        end
			    else if @i_verificacion = 'S' and not exists (select 1 from cobis..cl_verif_co_tel 
                                                              where ct_valor = ltrim(rtrim(@i_valor)) 
                                                              and   ct_tipo  = 'C' 
                                                              and   ct_ente  = @i_ente
			    											  and   ct_verificacion = 'S') 
		        begin
			        print 'sp_telefono -->> Ingresa Verificacion S'
		            insert into cobis..cl_verif_co_tel
		                   (ct_ente, ct_direccion, ct_valor, ct_tipo,          ct_verificacion, ct_canal, ct_fecha_proc, ct_fecha)
                    values (@i_ente, @i_direccion, @i_valor, @i_tipo_telefono, @i_verificacion, @w_canal, @s_date,       getdate()) 
		        end
		    end		
		    --Fin R.193221
	  
            return 0
         end --aux
      end	  
   end
   else
   begin
      exec sp_cerror
         @t_debug      = @t_debug,
         @t_file       = @t_file,
         @t_from       = @w_sp_name,
         @i_num        = 151051
         /*  'No corresponde codigo de transaccion' */
         return 151051
    end
end -- 'U'

/** Search **/
If @i_operacion = 'S'
begin
   if @t_trn = 147
   begin   
      select 'C¢digo'      = te_secuencial,
             'Telefono'    = te_valor,
             'Tipo'        = te_tipo_telefono,
             'Descripcion' = substring(a.valor, 1, 10), 
             'Telf. Cobro' = isnull(te_telf_cobro, 'N'), --DVE
             'Funcionario' = te_funcionario, --PRA
             'Verificado'  = te_verificado, --PRA
             'Fec. Ver.'   = convert(varchar(10),te_fecha_ver,@i_formato_fecha), --PRA
             'Fec. Reg.'   = convert(varchar(10),te_fecha_registro,@i_formato_fecha), --PRA
             'Fec. Mod.'   = convert(varchar(10),te_fecha_modificacion,@i_formato_fecha), --PRA
             'Cod. Area'   = te_area,
			 'Verificacion'= (select top 1 ct_verificacion from cobis..cl_verif_co_tel 
				              where ct_ente = te_ente 
							  and ct_direccion = te_direccion
							  and ct_tipo = te_tipo_telefono
							  and ct_valor = te_valor
							  order by ct_fecha desc) -- R.193221
      from   cl_telefono, cl_catalogo a, cl_tabla m
      where  te_ente = @i_ente
      and    te_direccion = @i_direccion
      and    a.codigo = te_tipo_telefono
      and    a.tabla  = m.codigo
      and    m.tabla = 'cl_ttelefono'
      
      if @@error <> 0
      begin
         exec sp_cerror
              @t_debug        = @t_debug,
              @t_file         = @t_file,
              @t_from         = @w_sp_name,
              @i_num          = 101001
              /* 'No existe dato solicitado'*/
         return 101001
      end
      
      return 0
   end
   else
   begin
      exec sp_cerror
           @t_debug      = @t_debug,
           @t_file       = @t_file,
           @t_from       = @w_sp_name,
           @i_num        = 151051
           /*  'No corresponde codigo de transaccion' */
      return 151051
   end
end -- 'S'

/** Delete **/
if @i_operacion = 'D'
begin
   if @t_trn = 148
   begin
      /* Verificacion de claves foraneas */
      if not exists (
                select di_ente
                from  cl_direccion
                where di_ente = @i_ente
                and  di_direccion = @i_direccion )
      begin
         exec sp_cerror
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 101001
            /* 'No existe direccion'*/
         return 101001
      end
   
      /* Valores para transaccion de  servicios */
      select @w_valor = te_valor,
             @w_tipo_telefono = te_tipo_telefono
      from   cl_telefono
      where  te_ente       = @i_ente
      and    te_direccion  = @i_direccion
      and    te_secuencial = @i_secuencial
      
      /* OHF: Control eliminacion de telefonos:
         - Si se trata de la eliminacion de un solo telefono, se controla que minimo quede un telefono asociado a la dir.
         - Si se trata de la eliminacion de una direccion se deben eliminar todos los telefonos asociados.
      */
      if @i_tborrado <> 'T'
      begin
         select @w_di_telefono = count(*) 
         from   cl_telefono
         where  te_ente = @i_ente
         and    te_direccion = @i_direccion
      
         if @w_di_telefono = 1
         begin
            exec sp_cerror
                 @t_debug        = @t_debug,
                 @t_file         = @t_file,
                 @t_from         = @w_sp_name,
                 @i_num          = 107126
                 /* 'No se pueden eliminar todos los numeros telefonicos'*/
            return 107126
         end
      end
   
      begin tran
         update cl_direccion
         set    di_telefono = di_telefono - 1
         --     set di_telefono = di_telefono 
         where  di_ente      = @i_ente
         and    di_direccion = @i_direccion
         
         if @@error <> 0
         begin
         exec sp_cerror
              @t_debug        = @t_debug,
              @t_file         = @t_file,
              @t_from         = @w_sp_name,
              @i_num          = 107038
              /* 'Error en disminucion de telefono'*/
              return 107038
         end
            
         delete from cl_telefono
         where  te_ente = @i_ente
         and    te_direccion = @i_direccion
         and    te_secuencial = @i_secuencial
         
         if @@error <> 0
         begin
         exec sp_cerror
              @t_debug        = @t_debug,
              @t_file         = @t_file,
              @t_from         = @w_sp_name,
              @i_num          = 107038
              /* 'Error en eliminacion de telefono'*/
              return 107038
         end
         
         select @w_secuencial = convert(varchar(3),@i_secuencial)
         
         insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                                  ac_campo, ac_valor_ant, ac_valor_nue,
                                  ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
         values
                                 (@i_ente, @s_date,'cl_telefono',
                                  'te_secuencial', @w_secuencial, null,
                                  'D',@i_direccion, @i_secuencial, getdate())
         if @@error <> 0
         begin
            exec sp_cerror
                 @t_debug    = @t_debug,
                 @t_file     = @t_file,
                 @t_from     = @w_sp_name,
                 @i_num      = 103001
                 return 103001 /*'Error en creacion de cliente'*/
         end                                                                    
   
         update cl_telefono
         set   te_secuencial = te_secuencial - 1
         where te_ente = @i_ente
         and   te_direccion = @i_direccion
         and   te_secuencial > @i_secuencial
         
         if @@error <> 0
         begin
         exec sp_cerror
              @t_debug        = @t_debug,
              @t_file         = @t_file,
              @t_from         = @w_sp_name,
              @i_num          = 107038
              /* 'Error en eliminacion de telefono'*/
              return 107038
         end
         
        insert into ts_telefono 
        (secuencial, alterno,   tipo_transaccion, clase, fecha,
         usuario,    terminal,  srv,              lsrv,
         ente,       direccion, telefono,         valor,
         tipo,	     oficina,	hora,             canal)
        values
		(@s_ssn,            @p_alterno,      @t_trn,        'B', @s_date/*getdate()*/,
         @s_user,           @s_term,         @s_srv,        @s_lsrv, 
         @i_ente,           @i_direccion,    @i_secuencial, @w_valor,
         @w_tipo_telefono,	@s_ofi,	         getdate(),     @i_canal)
      
        if @@error <> 0
        begin
           exec sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 103005
                /* 'Error en creacion de transaccion de servicio'*/
           return  103005
        end
     
        /* **************** SE COMENTA PARA FIE - JBA - MAY 28 2015 ****************   
               -- INI ELIMINACION DE DATOS - AUTORIZACIONES
              exec @w_return = sp_autorizaciones
                    @i_operacion    = 'D',
                    @t_trn          = 1024,
                    @i_cliente      = @i_ente,
                    @i_tabla        = 'cl_telefono',
                    @i_secuencial   = @i_direccion,
                    @i_sec_dir      = @i_secuencial
               if @w_return <> 0
               begin
                 exec sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = @w_return
                 -- 'Error en actualizacion de compania'--
                return @w_return
              end
            -- FIN ELIMINACION DE DATOS - AUTORIZACIONES
        * ***************** SE COMENTA PARA FIE - JBA - MAY 28 2015 ***************/
      
      commit tran
	  
	  if @w_tipo_telefono = 'C' -- Error.188413
	  begin
	    --EJECUCION DE CAMBIO DE ESTADO bv_login 
        exec @w_error = cob_bvirtual..sp_b2c_mantenimiento_login 
        @s_ssn        = @s_ssn,
        @s_ofi        = @s_ofi,
        @s_user       = @s_user,
        @s_date       = @s_date,
        @s_srv        = @s_srv,
        @s_term       = @s_term,
        @s_rol        = @s_rol,
        @s_lsrv       = @s_lsrv,
        @s_sesn       =  @s_ssn,
        @i_operacion  = 'E',
        @i_ente_mis   = @i_ente,    
        @i_celular    = @w_valor,
        @i_canal      = @i_canal  		
        
        if @w_error <> 0
        begin
           exec sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 105035
                /* 'Error en actualizacion de telefono'*/
           return 105035
        end
	  end
			
      return 0
   end
   else
   begin
      exec sp_cerror
           @t_debug      = @t_debug,
           @t_file       = @t_file,
           @t_from       = @w_sp_name,
           @i_num        = 151051
           /*  'No corresponde codigo de transaccion' */
      return 151051
   end
end

go
--sp_procxmode 'dbo.sp_telefono', 'Unchained'
go

