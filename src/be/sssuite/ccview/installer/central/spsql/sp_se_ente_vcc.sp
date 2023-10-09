/************************************************************************/
/*  Archivo:        	sp_se_ente_vcc.sp      				            */
/*  Stored procedure:   sp_se_ente_vcc                  	            */
/*  Base de datos:      cobis                  				            */
/*  Producto:           Clientes                			            */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 08-Nov-1992                 			        */
/************************************************************************/
/*              IMPORTANTE              				                */
/*  Este programa es parte de los paquetes bancarios propiedad de   	*/
/*  'MACOSA', representantes exclusivos para el Ecuador de la   	    */
/*  'NCR CORPORATION'.                      				            */
/*  Su uso no autorizado queda expresamente prohibido asi como  	    */
/*  cualquier alteracion o agregado hecho por alguno de sus     	    */
/*  usuarios sin el debido consentimiento por escrito de la     	    */
/*  Presidencia Ejecutiva de MACOSA o su representante.     		    */
/*              PROPOSITO               				                */
/*  Este programa implementa la busqueda de clientes (personas  	    */
/*  y companias) segun distintos criterios de busqueda:     		    */
/*      codigo de cliente                   				            */
/*      apellido                        				                */
/*      cedula o pasaporte                  				            */
/*              MODIFICACIONES              				            */
/*  FECHA       AUTOR       	RAZON               			        */
/*  06/09/2012  IOR             Copia del sp_se_ente para VCC           */
/************************************************************************/

use cobis
go
if exists (select 1 from sysobjects where name = 'sp_se_ente_vcc')
   drop proc sp_se_ente_vcc
go

create proc sp_se_ente_vcc (
        @s_ssn		    int 		  = null,
        @s_user		    login 		  = null,
        @s_term		    varchar(30)   = null,
        @s_date		    datetime 	  = null,
        @s_srv		    varchar(30)   = null,
        @s_lsrv		    varchar(30)   = null,
        @s_rol		    smallint 	  = NULL,
        @s_ofi		    smallint 	  = NULL,
        @s_org_err	    char(1) 	  = NULL,
        @s_error	    int 		  = NULL,
        @s_sev		    tinyint 	  = NULL,
        @s_msg		    descripcion   = NULL,
        @s_org		    char(1) 	  = NULL,
	    @t_debug    	char(1) 	  = 'N',
	    @t_file     	varchar(10)   = null,
	    @t_from     	varchar(32)   = null,
	    @t_trn	    	int           = null,
	    @i_subtipo  	char(1) 	  = null, -- Subtipo de cliente: natural (P), juridica (C), cifrada (I)
	    @i_tipo     	tinyint 	  = null, -- Tipo de consulta
	    @i_modo     	tinyint 	  = null, -- Modo de busqueda
	    @i_valor    	varchar(64)   = '%',  -- Criterio de Busqueda
        @i_ente         int 		  = null, -- Codigo secuencial del cliente
        @i_nombre       descripcion   = '%',  -- Primer nombre del cliente
        @i_p_apellido   varchar(20)   = '%',  -- Primer apellido del cliente
        @i_s_apellido   varchar(20)   = null, -- Segundo apellido del cliente
	    @i_c_apellido   varchar(20)   = null, -- Apellido de casada del cliente, si fuera el caso
        @i_ced_ruc      numero 		  = null, -- Numero de identificacion del cliente
	    @i_oficina	    smallint 	  = null, -- Codigo de la oficina
        @i_nombre_completo varchar(64) 	= null, -- Nombre completo del cliente
        @i_pasaporte    numero 		  = null,  -- Numero de pasaporte
        @i_es_cliente      char = 'S' -- Filtro para clientes y prospectos --AAV

)
as
declare @w_sp_name  varchar(32),
	    @w_nombre   varchar(150),
		@w_tablas   varchar(250),
		@w_columnas varchar(5000),
		@w_criterio varchar(3000),
        @w_ordenamiento varchar(250),
		@w_cantidad_ced int,		
	    @w_cantidad_cap int,
	    @w_cantidad_sap int,
	    @w_cantidad_pap int,
	    @w_cantidad_nom int,
		@w_cantidad_val int,
        @w_concatenado varchar (3000),
        @w_concatenadojur varchar (3000),
        @w_valor  varchar (5000), 
        @w_ente  varchar (1000),
	@w_es_cliente char		

select @w_sp_name = 'sp_se_ente_vcc'

if @i_es_cliente = 'N'
    select @w_es_cliente = null
else
    select @w_es_cliente = 'S'

if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Stored Procedure **/ '  = @w_sp_name,
                s_ssn              = @s_ssn,
                s_user             = @s_user,
                s_term             = @s_term,
                s_date             = @s_date,
                s_srv              = @s_srv,
                s_lsrv             = @s_lsrv,
                s_ofi              = @s_ofi,
		        s_rol		       = @s_rol,
		        s_org_err	       = @s_org_err,
		        s_error		       = @s_error,
		        s_sev		       = @s_sev,
		        s_msg		       = @s_msg,
		        s_org		       = @s_org,
	 	        t_trn		       = @t_trn,
		        t_file             = @t_file,
		        t_from             = @t_from,
		        i_subtipo          = @i_subtipo,
	        	i_tipo             = @i_tipo,
		        i_modo             = @i_modo,
		        i_valor            = @i_valor,
                i_ente             = @i_ente,
                i_nombre           = @i_nombre,
                i_p_apellido       = @i_p_apellido,
                i_ced_ruc          = @i_ced_ruc,
                i_oficina          = @i_oficina,
                i_nombre_completo  = @i_nombre_completo,
                i_pasaporte        = @i_pasaporte
	exec cobis..sp_end_debug
end

if @t_trn = 73923
begin

     if @i_nombre is null 
	      select @i_nombre = ' '
	
	 if @i_p_apellido is null 
	      select @i_p_apellido = ' '
	
	 if @i_s_apellido is null
	      select @i_s_apellido = ' '
	
     if @i_c_apellido is null
	      select @i_c_apellido = ' '
		  
     select @w_cantidad_ced = DATALENGTH(@i_ced_ruc)
	 select @w_cantidad_cap = DATALENGTH(@i_c_apellido)
	 select @w_cantidad_sap = DATALENGTH(@i_s_apellido)
	 select @w_cantidad_pap = DATALENGTH(@i_p_apellido)
	 select @w_cantidad_nom = DATALENGTH(@i_nombre)
	 select @w_cantidad_val = DATALENGTH(@i_valor)
	 select @w_concatenado = LTRIM(RTRIM(@i_p_apellido)) + LTRIM(RTRIM(@i_nombre)) + LTRIM(RTRIM(convert(varchar(10), @i_ente)))
	 select @w_valor = LTRIM(RTRIM(@i_valor))
	 select @w_ente = LTRIM(RTRIM(convert(varchar(10), @i_ente)))
	 select @w_concatenadojur = @w_valor + @w_ente 
		 	
set rowcount 20 

if @i_subtipo = 'P' -- Datos de Persona Natural 
begin 

     if @i_s_apellido is null
	      select @w_nombre = @i_p_apellido + ' ' + @i_nombre
     else
	      select @w_nombre = @i_p_apellido + ' ' + @i_s_apellido + ' ' + @i_nombre
		 
     select @w_columnas = 'Select "No." = en_ente,
	                              "Primer Apellido"   = case p_estado_civil
						                                when "ME" then p_p_apellido + " " + "(MENOR)"
                                                        else p_p_apellido
                                                        end,
						          "Segundo Apellido"  = p_s_apellido,     
		   	                      "Apellido de Casada"= p_c_apellido, 
								  "Primer Nombre"     = case p_estado_civil
                                                        when "ME" then en_nombre + " " + "(MENOR)"
                                                        else en_nombre
                                                        end,  
								  "Segundo Nombre"    = p_s_nombre,          
		 	                      "I.D."              = en_ced_ruc,
		 	                      "Tipo I.D."         = en_tipo_ced,
								  "Oficial"           = en_oficial,
		                          "Nombre del Oficial" = (select fu_nombre from cl_funcionario, cc_oficial
                                                          where x.en_oficial = oc_oficial
                                                          and oc_funcionario =  fu_funcionario), 
			                      "Bloqueado"         = en_estado,
					      		"Es cliente" = en_cliente'
	
     if @i_tipo = 1 -- Datos por Ente
     begin 
	      select @w_tablas = ' from	cl_ente x '     
	      select @w_criterio = ' where  en_subtipo = "P"'
		  -- Para traer la información si es un cliente o prospecto
		  if @w_es_cliente = 'S'
		  	select @w_criterio = @w_criterio + '  and en_ente in (select cl_cliente from cl_cliente(index cl_cliente_Key))'
		  else
		  	select @w_criterio = @w_criterio + '  and en_ente not in (select cl_cliente from cl_cliente(index cl_cliente_Key))'

		  select @w_ordenamiento = ' order by en_ente '
	 
	      if @i_modo = 0 -- Normal
		  begin
		       select @w_criterio = @w_criterio + '  and en_ente >= ' + convert(varchar(10),@i_ente) + ''
			   goto BUSQUEDA
		  end
	      else if @i_modo = 1 -- Siguientes
		  begin
		       select @w_criterio = @w_criterio + '  and en_ente > ' + convert(varchar(10),@i_ente) + ''
			   goto BUSQUEDA
		  end
		  else
		  begin
		       select @w_criterio = @w_criterio + '  and en_ente = ' + convert(varchar(10),@i_ente) + ''
			   goto BUSQUEDA
		  end
     return 0
	 end	
				   
     if @i_tipo = 2 -- ID. de Identificacion 'CI' - CIFRADOS
     begin 
	      select @w_tablas = ' from	cl_ente x '     
	      select @w_criterio = ' where  en_subtipo = "P"'
		select @w_criterio = @w_criterio + '  and en_tipo_ced = "CI"'
		  -- Para traer la información si es un cliente o prospecto
		  if @w_es_cliente = 'S'
		  	select @w_criterio = @w_criterio + '  and en_ente in (select cl_cliente from cl_cliente(index cl_cliente_Key))'
		  else
		  	select @w_criterio = @w_criterio + '  and en_ente not in (select cl_cliente from cl_cliente(index cl_cliente_Key))'
		  
		  select @w_ordenamiento = ' order by en_ced_ruc '
	 
	      if @i_modo = 0 -- Normal
		  begin
		       select @w_criterio = @w_criterio + '  and en_ced_ruc >= "" + @i_ced_ruc + ""'
			   goto BUSQUEDA
		  end
	      else if @i_modo = 1 -- Siguientes
		  begin
		       select @w_criterio = @w_criterio + '  and en_ced_ruc > "" + @i_ced_ruc + ""'
			   goto BUSQUEDA
		  end
		  else
		  begin
		       select @w_criterio = @w_criterio + '  and en_ced_ruc = "" + @i_ced_ruc + ""'
			   goto BUSQUEDA
		  end
     return 0
	 end	  

     if @i_tipo = 3 -- ID. de Identificacion 'CR' - CEDULA DE RESIDENCIA
     begin 
	      select @w_tablas = ' from	cl_ente x '     
	      select @w_criterio = ' where  en_subtipo = "P"'
		  select @w_criterio = @w_criterio + '  and en_tipo_ced = "CR"'
	      -- Para traer la información si es un cliente o prospecto
	      if @w_es_cliente = 'S'
		  	select @w_criterio = @w_criterio + '  and en_ente in (select cl_cliente from cl_cliente(index cl_cliente_Key))'
		  else
		  	select @w_criterio = @w_criterio + '  and en_ente not in (select cl_cliente from cl_cliente(index cl_cliente_Key))'

		  select @w_ordenamiento = ' order by en_ced_ruc '
	 
	      if @i_modo = 0 -- Normal
		  begin
		       select @w_criterio = @w_criterio + '  and en_ced_ruc >= "" + @i_ced_ruc + ""'
			   goto BUSQUEDA
		  end
	      else if @i_modo = 1 -- Siguientes
		  begin
		       select @w_criterio = @w_criterio + '  and en_ced_ruc > "" + @i_ced_ruc + ""'
			   goto BUSQUEDA
		  end
		  else
		  begin
		       select @w_criterio = @w_criterio + '  and en_ced_ruc = "" + @i_ced_ruc + ""'
			   goto BUSQUEDA
		  end
     return 0
	 end		

     if @i_tipo = 4 -- Apellido de Casada
     begin
	      if @i_c_apellido = '' 
               select @i_c_apellido = '%' 
			   
	      select @w_tablas = ' from	cl_ente x (index ien_ap_casada) '     
	      select @w_criterio = ' where  en_subtipo = "P"'
		  -- Para traer la información si es un cliente o prospecto
		  if @w_es_cliente = 'S'
		  	select @w_criterio = @w_criterio + '  and en_ente in (select cl_cliente from cl_cliente(index cl_cliente_Key))'
		  else
		  	select @w_criterio = @w_criterio + '  and en_ente not in (select cl_cliente from cl_cliente(index cl_cliente_Key))'

		  select @w_ordenamiento = ' order by p_c_apellido, p_p_apellido, en_ente '
	 
	      if @i_modo = 0 -- Normal
		  begin
		       select @w_criterio = @w_criterio + '  and p_c_apellido >= "" + @i_c_apellido + ""'
			   goto BUSQUEDA
		  end
	      else if @i_modo = 1 -- Siguientes
		  begin
		       select @w_criterio = @w_criterio + '  and ((p_c_apellido > "" + @i_c_apellido + ""' + ') or (p_c_apellido = "" + @i_c_apellido + ""' + ' and p_p_apellido > "" + @i_p_apellido + ""' + '))'
			   goto BUSQUEDA
		  end
		  else
		  begin
		       select @w_criterio = @w_criterio + '  and substring(p_c_apellido,1, ' + convert(varchar(10),@w_cantidad_cap) + ') = "" + @i_c_apellido + ""'
			   goto BUSQUEDA
		  end
     return 0
	 end		 
     		   
      if @i_tipo = 5 -- Datos por Apellido y/o Nombre
     begin
          if @i_p_apellido = '' 
               select @i_p_apellido = '%'        

          if @i_nombre = ''
               select @i_nombre = '%' 
					
		  select @w_tablas = ' from	cl_ente x (index cl_ente_Key) '
          select @w_criterio = ' where  en_subtipo = "P"'
          --select @w_criterio = @w_criterio + '  and en_cliente = 'S''	
	  	  -- Para traer la información si es un cliente o prospecto
	  	  if @w_es_cliente = 'S'
		  	select @w_criterio = @w_criterio + '  and en_ente in (select cl_cliente from cl_cliente(index cl_cliente_Key))'
		  else
		  	select @w_criterio = @w_criterio + '  and en_ente not in (select cl_cliente from cl_cliente(index cl_cliente_Key))'

          select @w_ordenamiento = ' order by p_p_apellido + en_nombre + convert(varchar(10),en_ente)'		  
              
		  if ((@i_p_apellido <> '%' and @i_nombre <> '%') or (@i_p_apellido = '%' and @i_nombre = '%'))
		  begin
		       if @i_modo = 0 -- Normal
		       begin
			        select @w_criterio = @w_criterio + '  and p_p_apellido >= "" + @i_p_apellido + ""'
				    select @w_criterio = @w_criterio + '  and en_nombre >= "" + @i_nombre + ""'
				    goto BUSQUEDA
			   end
			   else if @i_modo = 1 -- Siguientes
		       begin
		            --select @w_criterio = @w_criterio + '  and (p_p_apellido = '' + @i_p_apellido + ''' + ' and en_nombre = '' + @i_nombre + ''' + ' and en_ente >' + convert(varchar(10),@i_ente) + ')' + ' or (p_p_apellido = '' + @i_p_apellido + ''' + ' and en_nombre > '' + @i_nombre + ''' + ')' + ' or (p_p_apellido > '' + @i_p_apellido + ''' + ')'
			        select @w_criterio = @w_criterio + ' and  p_p_apellido + en_nombre + convert(varchar(10),en_ente) > "" + @w_concatenado+ ""'
					goto BUSQUEDA
		       end
			   else
		       begin
		            select @w_criterio = @w_criterio + '  and p_p_apellido = "" + @i_p_apellido + ""'
				    select @w_criterio = @w_criterio + '  and en_nombre = "" + @i_nombre + ""'
			        goto BUSQUEDA
		       end	
          end
		  else if (@i_p_apellido = '%' and @i_nombre <> '%')
		  begin
               select @w_tablas = ' from	cl_ente x (index ien_nombre) '
               select @w_criterio = ' where  en_subtipo = "P"'		
               --select @w_criterio = @w_criterio + '  and en_cliente = 'S''
	       	   -- Para traer la información si es un cliente o prospecto
	       	   if @w_es_cliente = 'S'
		  			select @w_criterio = @w_criterio + '  and en_ente in (select cl_cliente from cl_cliente(index cl_cliente_Key))'
		  		else
		  			select @w_criterio = @w_criterio + '  and en_ente not in (select cl_cliente from cl_cliente(index cl_cliente_Key))'

               select @w_ordenamiento = ' order by en_nombre, p_p_apellido, en_ente'	
                  
		       if @i_modo = 0 -- Normal
               begin
			        select @w_criterio = @w_criterio + '  and en_nombre >= "" + @i_nombre + ""'
			        goto BUSQUEDA
			   end
               else if @i_modo = 1 -- Siguientes
               begin
			        select @w_criterio = @w_criterio + '  and ((en_nombre > "" + @i_nombre + ""' + ') or (en_nombre = "" + @i_nombre + ""' + ' and p_p_apellido > "" + @i_p_apellido + ""' + '))'
			        goto BUSQUEDA
               end
			   else
	           begin
		            select @w_criterio = @w_criterio + '  and substring(en_nombre,1, ' + convert(varchar(10),@w_cantidad_nom) + ') = "" + @i_nombre + ""'
			        goto BUSQUEDA
		       end	
			   
          end
          else
          begin
               if (@i_nombre = '%' and  @i_p_apellido <> '%')
			   begin
			        select @w_tablas = ' from	cl_ente x (index cl_ente_Key) '
                    select @w_criterio = ' where  en_subtipo = "P"'	
					--select @w_criterio = @w_criterio + '  and en_cliente = 'S''
					-- Para traer la información si es un cliente o prospecto
		    		if @w_es_cliente = 'S'
		  				select @w_criterio = @w_criterio + '  and en_ente in (select cl_cliente from cl_cliente(index cl_cliente_Key))'
		  			else
		  				select @w_criterio = @w_criterio + '  and en_ente not in (select cl_cliente from cl_cliente(index cl_cliente_Key))'

                    select @w_ordenamiento = ' order by p_p_apellido, en_nombre , en_ente'					
                   
                    if @i_modo = 0 -- Normal
                    begin
			             select @w_criterio = @w_criterio + '  and p_p_apellido >= "" + @i_p_apellido + ""'
			             goto BUSQUEDA
			        end
                    else if @i_modo = 1 -- Siguientes
                    begin
			             select @w_criterio = @w_criterio + '  and ((p_p_apellido > "" + @i_p_apellido + ""' + ') or (p_p_apellido = "" + @i_p_apellido + ""' + ' and en_nombre > "" + @i_nombre + ""' + '))'
			             goto BUSQUEDA
                    end
			        else
	                begin
		                 select @w_criterio = @w_criterio + '  and substring(p_p_apellido,1, ' + convert(varchar(10),@w_cantidad_pap) + ') = "" + @i_p_apellido + ""'
			             goto BUSQUEDA
		            end						
			   end
          end		  
     return 0
     end

     if @i_tipo = 6 -- Datos por pasaporte
     begin
	      select @w_tablas = ' from	cl_ente x '     
	      select @w_criterio = ' where  en_subtipo = "P"'
		  select @w_criterio = @w_criterio + '  and en_tipo_ced = "PA"'
		  -- Para traer la información si es un cliente o prospecto
		  if @w_es_cliente = 'S'
		  	select @w_criterio = @w_criterio + '  and en_ente in (select cl_cliente from cl_cliente(index cl_cliente_Key))'
		  else
		  	select @w_criterio = @w_criterio + '  and en_ente not in (select cl_cliente from cl_cliente(index cl_cliente_Key))'

		  select @w_ordenamiento = ' order by en_ced_ruc '
          
		  if @i_modo = 0 -- Normal
		  begin
		       select @w_criterio = @w_criterio + '  and en_ced_ruc >= "" + @i_ced_ruc + ""'
		       goto BUSQUEDA
		  end
		  else if @i_modo = 1 -- Siguientes
		  begin
		       select @w_criterio = @w_criterio + '  and en_ced_ruc > "" + @i_ced_ruc + ""'
			   goto BUSQUEDA
		  end
		  else
		  begin
		       select @w_criterio = @w_criterio + '  and en_ced_ruc = "" + @i_ced_ruc + ""'
			   goto BUSQUEDA
		  end
     end

     if @i_tipo = 7 -- ID. de Identificacion 'CA' 
     begin
	      select @w_tablas = ' from	cl_ente x '     
	      select @w_criterio = ' where  en_subtipo = "P"'
		  select @w_criterio = @w_criterio + '  and en_tipo_ced = "CA"'
		  -- Para traer la información si es un cliente o prospecto
		  if @w_es_cliente = 'S'
		  	select @w_criterio = @w_criterio + '  and en_ente in (select cl_cliente from cl_cliente(index cl_cliente_Key))'
		  else
		  	select @w_criterio = @w_criterio + '  and en_ente not in (select cl_cliente from cl_cliente(index cl_cliente_Key))'

		  select @w_ordenamiento = ' order by en_ced_ruc '
          
		  if @i_modo = 0 -- Normal
		  begin
		       select @w_criterio = @w_criterio + '  and en_ced_ruc >= "" + @i_ced_ruc + ""'
		       goto BUSQUEDA
		  end
		  else if @i_modo = 1 -- Siguientes
		  begin
		       select @w_criterio = @w_criterio + '  and en_ced_ruc > "" + @i_ced_ruc + ""'
			   goto BUSQUEDA
		  end
		  else
		  begin
		       select @w_criterio = @w_criterio + '  and en_ced_ruc = "" + @i_ced_ruc + ""'
			   goto BUSQUEDA
		  end
     end

     if @i_tipo = 8 -- Datos por Numero de Identificacion
     begin
	      select @w_tablas = ' from	cl_ente x '     
	      select @w_criterio = ' where  en_subtipo = "P"'
		  -- Para traer la información si es un cliente o prospecto
		  if @w_es_cliente = 'S'
		  	select @w_criterio = @w_criterio + '  and en_ente in (select cl_cliente from cl_cliente(index cl_cliente_Key))'
		  else
		  	select @w_criterio = @w_criterio + '  and en_ente not in (select cl_cliente from cl_cliente(index cl_cliente_Key))'

		  select @w_ordenamiento = ' order by en_ced_ruc '
          
		  if @i_modo = 0 -- Normal
		  begin
		       select @w_criterio = @w_criterio + '  and en_ced_ruc >= "" + @i_ced_ruc + ""'
		       goto BUSQUEDA
		  end
		  else if @i_modo = 1 -- Siguientes
		  begin
		       select @w_criterio = @w_criterio + '  and en_ced_ruc > "" + @i_ced_ruc + ""'
			   goto BUSQUEDA
		  end
		  else
		  begin
		       select @w_criterio = @w_criterio + '  and substring(en_ced_ruc,1, ' + convert(varchar(10),@w_cantidad_ced) + ') = "" + @i_ced_ruc + ""'
			   goto BUSQUEDA
		  end
     end   	 
end

if @i_subtipo = 'C' -- Datos de Persona Juridica
begin
      select @w_columnas = 	'Select "No."      = en_ente,
	                        "Raz¢n Social"     = c_razon_social,
			                "Nombre Comercial" = en_nombre,
							"No.I.D."          = en_ced_ruc,
		   	                "Tipo I.D."        = en_tipo_ced,
                            "Oficial"          = en_oficial,
		                    "Nombre del Oficial" = (select fu_nombre 
			                                        from cl_funcionario, cc_oficial
                                                    where x.en_oficial = oc_oficial
                                                    and oc_funcionario =  fu_funcionario),
			                "Bloqueado"        = en_estado'	
			
     if @i_tipo = 1 -- Datos por Ente
     begin
	 	  select @w_tablas = ' from	cl_ente x '     
	      select @w_criterio = ' where  en_subtipo = "C"'
		  select @w_criterio = @w_criterio + '  and en_cliente = "S"'
		  -- Para traer la información si es un cliente o prospecto
		  if @w_es_cliente = 'S'
		  	select @w_criterio = @w_criterio + '  and en_ente in (select cl_cliente from cl_cliente(index cl_cliente_Key))'
		  else
		  	select @w_criterio = @w_criterio + '  and en_ente not in (select cl_cliente from cl_cliente(index cl_cliente_Key))'

		  select @w_ordenamiento = ' order by en_ente '
		  
	      if @i_modo = 0 -- Normal
		  begin
		       select @w_criterio = @w_criterio + '  and en_ente >= ' + convert(varchar(10),@i_ente) + ''
			   goto BUSQUEDA
		  end
	      else if @i_modo = 1 -- Siguientes
		  begin
		       select @w_criterio = @w_criterio + '  and en_ente > ' + convert(varchar(10),@i_ente) + ''
			   goto BUSQUEDA
		  end
		  else
		  begin
		       select @w_criterio = @w_criterio + '  and en_ente = ' + convert(varchar(10),@i_ente) + ''
			   goto BUSQUEDA
		  end
	 end
	 
	 if @i_tipo = 2 -- Datos por RUC o Numero de Identificacion
     begin 
	      select @w_tablas = ' from	cl_ente x '     
	      select @w_criterio = ' where  en_subtipo = "C"'
		  -- Para traer la información si es un cliente o prospecto
		  if @w_es_cliente = 'S'
		  	select @w_criterio = @w_criterio + '  and en_ente in (select cl_cliente from cl_cliente(index cl_cliente_Key))'
		  else
		  	select @w_criterio = @w_criterio + '  and en_ente not in (select cl_cliente from cl_cliente(index cl_cliente_Key))'

		  select @w_ordenamiento = ' order by en_ced_ruc '
	 
	      if @i_modo = 0 -- Normal
		  begin
		       select @w_criterio = @w_criterio + '  and en_ced_ruc >= "" + @i_ced_ruc + ""'
			   goto BUSQUEDA
		  end
	      else if @i_modo = 1 -- Siguientes
		  begin
		       select @w_criterio = @w_criterio + '  and en_ced_ruc > "" + @i_ced_ruc + ""'
			   goto BUSQUEDA
		  end
		  else
		  begin
		       select @w_criterio = @w_criterio + '  and substring(en_ced_ruc,1, ' + convert(varchar(10),@w_cantidad_ced) + ') = "" + @i_ced_ruc + ""'
			   goto BUSQUEDA
		  end
     return 0
	 end
	 
	 if @i_tipo = 3 -- Datos por RUC o Numero de Identificacion
     begin 
	      select @w_tablas = ' from	cl_ente x '     
	      select @w_criterio = ' where  en_subtipo = "C"'
		  -- select @w_criterio = @w_criterio + '  and  en_cliente = 'S''
	  	  -- Para traer la información si es un cliente o prospecto
	  	  if @w_es_cliente = 'S'
		  	select @w_criterio = @w_criterio + '  and en_ente in (select cl_cliente from cl_cliente(index cl_cliente_Key))'
		  else
		  	select @w_criterio = @w_criterio + '  and en_ente not in (select cl_cliente from cl_cliente(index cl_cliente_Key))'

		  select @w_ordenamiento = ' order by en_ced_ruc '
	 
	      if @i_modo = 0 -- Normal
		  begin
		       select @w_criterio = @w_criterio + '  and en_ced_ruc >= '' + @i_ced_ruc + '''
			   goto BUSQUEDA
		  end
	      else if @i_modo = 1 -- Siguientes
		  begin
		       select @w_criterio = @w_criterio + '  and en_ced_ruc > '' + @i_ced_ruc + '''
			   goto BUSQUEDA
		  end
		  else
		  begin
		       select @w_criterio = @w_criterio + '  and en_ced_ruc = '' + @i_ced_ruc + '''
			   goto BUSQUEDA
		  end
     return 0
	 end
	 
	 if @i_tipo = 4 -- Datos por Razon Social
     begin 
	      select @w_criterio = ' where  en_subtipo = "C"'
		  select @w_criterio = @w_criterio + '  and  en_cliente = "S"'
		  -- Para traer la información si es un cliente o prospecto
		  if @w_es_cliente = 'S'
		  	select @w_criterio = @w_criterio + '  and en_ente in (select cl_cliente from cl_cliente(index cl_cliente_Key))'
		  else
		  	select @w_criterio = @w_criterio + '  and en_ente not in (select cl_cliente from cl_cliente(index cl_cliente_Key))'

		  select @w_ordenamiento = ' order by c_razon_social + convert(varchar(10), en_ente) '
	 
	      if @i_modo = 0 -- Normal
		  begin
		       select @w_tablas = ' from  cl_ente x  ' 
		       select @w_criterio = @w_criterio + '  and c_razon_social >= "" + @i_valor + ""'
			   goto BUSQUEDA
		  end
	      else if @i_modo = 1 -- Siguientes
		  begin
		       select @w_tablas = ' from  cl_ente x (index ien_razon_social)  ' 	
		       --select @w_criterio = @w_criterio + '  and c_razon_social > '' + @i_valor + '''
			   select @w_criterio = @w_criterio + '  and c_razon_social + convert(varchar(10),en_ente) > "" + @w_concatenadojur + ""'
			   goto BUSQUEDA
		  end
		  else
		  begin
		       select @w_tablas = ' from  cl_ente x (index ien_razon_social)  ' 
		       select @w_criterio = @w_criterio + '  and substring(c_razon_social,1, ' + convert(varchar(10),@w_cantidad_val) + ') = "" + @i_valor + ""'
			   goto BUSQUEDA
		  end
     return 0
	 end
	 
	 if @i_tipo = 5 -- Datos Nombre Comercial
     begin
	      select @w_columnas = 	'Select "No."      = en_ente,
			                "Nombre Comercial" = en_nombre,
							"Raz¢n Social"     = c_razon_social,
		   	                "No.I.D."          = en_ced_ruc,
		   	                "Tipo I.D."        = en_tipo_ced,
                            "Oficial"          = en_oficial,
		                    "Nombre del Oficial" = (select fu_nombre 
			                                        from cl_funcionario, cc_oficial
                                                    where x.en_oficial = oc_oficial
                                                    and oc_funcionario =  fu_funcionario),
			                "Bloqueado"        = en_estado'	
	      if @i_valor = ''
               select @i_valor = '%'
	  
	      select @w_tablas = ' from  cl_ente x  ' 
	      select @w_criterio = ' where  en_subtipo = "C"'
		  --select @w_criterio = @w_criterio + '  and  en_cliente = 'S''
		  -- Para traer la información si es un cliente o prospecto
		  if @w_es_cliente = 'S'
		  	select @w_criterio = @w_criterio + '  and en_ente in (select cl_cliente from cl_cliente(index cl_cliente_Key))'
		  else
		  	select @w_criterio = @w_criterio + '  and en_ente not in (select cl_cliente from cl_cliente(index cl_cliente_Key))'

		  select @w_ordenamiento = ' order by en_nombre + convert(varchar(10), en_ente) '
	 
	      if @i_modo = 0 -- Normal
		  begin
		       select @w_criterio = @w_criterio + '  and en_nombre >= "" + @i_valor + ""'
			   goto BUSQUEDA
		  end
	      else if @i_modo = 1 -- Siguientes
		  begin
               select @w_criterio = @w_criterio + '  and en_nombre + convert(varchar(10),en_ente) > "" + @w_concatenadojur + ""'
			   goto BUSQUEDA
		  end
		  else
		  begin
		       select @w_criterio = @w_criterio + '  and substring(en_nombre,1, ' + convert(varchar(10),@w_cantidad_val) + ') = "" + @i_valor + ""'
			   goto BUSQUEDA
		  end
     return 0
	 end
end

if @i_subtipo = 'I' -- Datos de Persona Cifrada
begin
     select @w_columnas = 'Select "No."              = en_ente,
		   	                     "Tipo I.D."         = en_tipo_ced,
		   	                     "Nombre"            = en_nombre,
		 		                 "Nombre del Oficial"	= (select fu_nombre from cl_funcionario, cc_oficial
                                                           where x.en_oficial = oc_oficial
                                                           and oc_funcionario =  fu_funcionario),
			                     "Bloqueado"         = en_estado'

     if @i_tipo = 1 -- Datos por Ente
     begin
	 	  select @w_tablas = ' from	cl_ente x (index ien_ente) '     
	      select @w_criterio = ' where  en_subtipo = "I" '
		  --select @w_criterio = @w_criterio + '  and en_cliente = 'S''
		  -- Para traer la información si es un cliente o prospecto
		  if @w_es_cliente = 'S'
		  	select @w_criterio = @w_criterio + '  and en_ente in (select cl_cliente from cl_cliente(index cl_cliente_Key))'
		  else
		  	select @w_criterio = @w_criterio + '  and en_ente not in (select cl_cliente from cl_cliente(index cl_cliente_Key))'

		  select @w_ordenamiento = ' order by en_ente '
		  
	      if @i_modo = 0 -- Normal
		  begin
		       select @w_criterio = @w_criterio + '  and en_ente >= ' + convert(varchar(10),@i_ente) + ''
			   goto BUSQUEDA
		  end
	      else if @i_modo = 1 -- Siguientes
		  begin
		       select @w_criterio = @w_criterio + '  and en_ente > ' + convert(varchar(10),@i_ente) + ''
			   goto BUSQUEDA
		  end
		  else
		  begin
		       select @w_criterio = @w_criterio + '  and en_ente = ' + convert(varchar(10),@i_ente) + ''
			   goto BUSQUEDA
		  end
	 end

	 if @i_tipo = 5 -- Datos por Nombre
     begin
          select @w_tablas = ' from  cl_ente x  '	 
	      select @w_criterio = ' where  en_subtipo = "I"'
		  -- select @w_criterio = @w_criterio + '  and  en_cliente = 'S''
		  -- Para traer la información si es un cliente o prospecto
		  if @w_es_cliente = 'S'
		  	select @w_criterio = @w_criterio + '  and en_ente in (select cl_cliente from cl_cliente(index cl_cliente_Key))'
		  else
		  	select @w_criterio = @w_criterio + '  and en_ente not in (select cl_cliente from cl_cliente(index cl_cliente_Key))'

		  select @w_ordenamiento = ' order by en_nombre, en_ente '
	 
	      if @i_modo = 0 -- Normal
		  begin
		       select @w_criterio = @w_criterio + '  and en_nombre >= "" + @i_valor + ""'
			   goto BUSQUEDA
		  end
	      else if @i_modo = 1 -- Siguientes
		  begin
		       select @w_criterio = @w_criterio + '  and en_nombre > "" + @i_valor + ""'
			   goto BUSQUEDA
		  end
		  else
		  begin
		       select @w_criterio = @w_criterio + '  and en_nombre = "" + @i_valor + ""'
			   goto BUSQUEDA
		  end
     return 0
	 end

end

BUSQUEDA:

     execute (@w_columnas+@w_tablas+@w_criterio+@w_ordenamiento)

     if @@rowcount = 0
     begin
	      exec sp_cerror
		       @t_debug    = @t_debug,
			   @t_file     = @t_file,
			   @t_from     = @w_sp_name,
			   @i_num      = 101001
			   /* 'No existe dato solicitado'*/
	   	  return 1
     end
end

go
