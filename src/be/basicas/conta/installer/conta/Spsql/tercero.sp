/************************************************************************/
/*	Archivo: 		terceros.sp  				*/
/*	Stored procedure: 	sp_terceros				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Mauricio F. Morales R.              	*/
/*	Fecha de escritura:     22-Enero-1996 				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	   Mantenimiento de la tabla cb_terceros                        */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		             RAZON		*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_terceros')
    drop proc sp_terceros

go
create proc sp_terceros (
   @s_ssn                  int              	= null,
   @s_date                 datetime         	= null,
   @s_user                 login            	= null,
   @s_term                 descripcion      	= null,
   @s_corr                 char(1)          	= null,
   @s_ssn_corr             int              	= null,
   @s_ofi                  smallint          	= null,
   @t_rty                  char(1)          	= null,
   @t_trn                  smallint         	= null,
   @t_debug                char(1)          	= 'N',
   @t_file                 varchar(14)      	= null,
   @t_from                 varchar(30)      	= null,
   @i_operacion            char(1)          	= null,
   @i_empresa		   tinyint          	= null,
   @i_cons		   tinyint          	= null,
   @i_nombre               descripcion      	= null,
   @i_ced_ruc              varchar(30)      	= null,
   @i_tipoid_new	   char(1)          	= null,
   @i_identif_new	   char(13)         	= null, 
   @i_tipo		   tinyint          	= 0,
   @i_modo		   tinyint          	= 0,
   @i_subtipo		   tinyint          	= 0,
   @i_tipoid		   char(4)          	= null,  
   @i_identif		   char(13)         	= null,
   @i_ente		   int              	= null,
   @i_ente1		   int              	= null,
   @i_apellidos		   descripcion      	= null,
   @i_nombres		   descripcion      	= null,
   @i_reg_fiscal           varchar(10)      	= null,
   @i_direccion		   descripcion      	= null,
   @i_telefono		   char(15)         	= null,
   @i_ciudad		   char(25)         	= null,
   @i_fecha_i		   datetime         	= null,
   @i_fecha_f		   datetime         	= null,
   @i_cuenta_i		   cuenta      		= null,
   @i_cuenta_f		   cuenta      		= null,
   @i_cuenta		   cuenta      		= null,
   @i_valor		   varchar(32)      	= '%',
   @i_actividad		   varchar(20)      	= null,
   @i_tipo_ced		   char(2)          	= null,
   @i_subtipo_ente         char(1)          	= null,
   @i_apellido1            varchar(16)      	= null,
   @i_apellido2            varchar(16)      	= null,
   @i_nombres_ente         varchar(32)      	= null,
   @i_oficina              smallint         	= null,
   @i_area		   smallint         	= null,
   @i_oficina_dest         smallint         	= null,
   @i_area_dest		   smallint         	= null,
   @i_retencion            char(1)          	= null,
   @i_gran_contribuyente   char(1)          	= null,
   @i_cedula               varchar(13)      	= null,
   @i_sector               catalogo         	= null,
   @i_categoria            catalogo         	= null,   
   @i_actividad_ente       catalogo         	= null,
   @i_tipo_cia             catalogo         	= null,
   @i_tipo_dir             catalogo         	= null,
   @i_direccion_ente       varchar(254)     	= null,
   @i_tipo_tel             char(1)          	= null,
   @i_telefono_ente        varchar(16)      	= null,
   @i_documento            varchar(24)      	= '%',
   @i_documento1           varchar(24)      	= '%',
   @i_ciudad_ente          int              	= null,
   @o_ente	           int                  = null out,
   @o_nom_ente	           varchar(50)          = null out
   
   
)
as

declare
   @w_return             int,          
   @w_sp_name            varchar(32),  
   @w_existe             tinyint,      
   @w_nombre             descripcion,
   @w_identif		 char(13), 
   @w_tipoid		 char(1),
   @w_siguiente		 tinyint, 
   @w_sgte_ente          int,     
   @w_comprobante	 int,        
   @w_reg_fiscal	 varchar(10),
   @w_descripcion	 descripcion,
   @w_actividad		 varchar(64),
   @w_cod_actividad      varchar(10),
   @w_ente 	   	 int,
   @w_p_apellido 	 varchar(16),
   @w_s_apellido 	 varchar(16),
   @w_num_dir            tinyint,
   @w_fecha_nac          datetime,
   @w_fecha_emision      datetime,
   @w_fecha_ven          datetime,
   @w_lugar_nac          int,
   @w_tipo_vivienda      catalogo,
   @w_rep_superban       char(1),
   @w_fecha_expira       datetime,
   @w_sexo               char(1),
   @w_profesion          catalogo,
   @w_estado_civil       char(2),
   @w_nivel_estudio      catalogo,
   @w_lugar_doc          int,
   @w_notaria            tinyint,
   @w_escritura          int,
   @w_filial             tinyint,
   @w_ciudad_notaria     int,
   @w_pais               smallint,
   @w_referido           smallint,
   @w_today              datetime,
   @w_nombres_ente       varchar(32) ,
   @w_subtipo            char(1),
   @w_tipo_ced           char(4),
   @w_ced_ruc            varchar(30)

select @w_today = getdate()
select @w_sp_name = 'sp_terceros'

if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select  '/**  Stored Procedure  **/ ' = @w_sp_name,
		s_ssn                      = @s_ssn,
		s_user                     = @s_user,
		s_term                     = @s_term,   
		s_date                     = @s_date,   
		t_debug                    = @t_debug,  
		t_file                     = @t_file,
		t_from                     = @t_from,
		t_trn                      = @t_trn,
		i_modo                     = @i_modo,
		i_operacion		   = @i_operacion,
   		i_empresa		   = @i_empresa,
   		i_nombre		   = @i_nombre,
   		i_tipoid_new		   = @i_tipoid_new,
   		i_identif_new		   = @i_identif_new,
   		i_identif		   = @i_identif,      
		i_ente			   = @i_ente,         
   		i_fecha_i		   = @i_fecha_i,
   		i_fecha_f		   = @i_fecha_f,
   		i_cuenta_i		   = @i_cuenta_i,
   		i_cuenta_f		   = @i_cuenta_f,
		i_apellidos		   = @i_apellidos,
		i_nombres		   = @i_nombres,
		i_reg_fiscal		   = @i_reg_fiscal,
		i_direccion		   = @i_direccion,
		i_telefono		   = @i_telefono,
		i_ciudad		   = @i_ciudad,
		i_tipo			   = @i_tipo,
		i_subtipo		   = @i_subtipo,
		i_cons			   = @i_cons

	exec cobis..sp_end_debug
end


if (@t_trn <> 6989 and @i_operacion = 'I') or 
   (@t_trn <> 6989 and @i_operacion = 'M') or 
   (@t_trn <> 6989 and @i_operacion = 'B') or 
   (@t_trn <> 6990 and @i_operacion = 'E') or 
   (@t_trn <> 6990 and (@i_operacion = 'X' or @i_operacion = 'V' or @i_operacion = 'W')) or 
   (@t_trn <> 6991 and @i_operacion = 'Q') or 
   (@t_trn <> 6994 and @i_operacion = 'U') or 
   (@t_trn <> 6992 and @i_operacion = 'A') or 
   (@t_trn <> 6993 and @i_operacion = 'D') or 
   (@t_trn <> 6996 and @i_operacion = 'S')   

begin
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 601077
    return 1 
end

if @i_operacion <> 'A' or @i_operacion <> 'S' or @i_operacion <> 'M' or @i_operacion <> 'V'
begin
    select 
         @w_ente 	   = en_ente,
         @w_nombre 	   = en_nombre,
         @w_p_apellido 	   = p_p_apellido,
         @w_s_apellido 	   = p_s_apellido,
         @w_tipo_ced	   = en_tipo_ced,
         @w_subtipo	   = en_subtipo,
         @w_ced_ruc	   = en_ced_ruc
    from cobis..cl_ente
    where 
	(en_ente  = @i_ente or @i_ente is null) and 
	(en_ced_ruc  = ltrim(rtrim(@i_ced_ruc)) or @i_ced_ruc is null) and
	(en_tipo_ced = ltrim(rtrim(@i_tipoid)) or @i_tipoid is null)

    if @@rowcount != 1
            select @w_existe = 0
    else
            select @w_existe = 1
	
end


if @i_operacion = 'I' or @i_operacion = 'U'
begin
    if @i_ente is NULL 
    begin
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 601001
        return 1 
    end
end

if @i_operacion = 'Q'
begin
	if @w_existe = 1
	begin
       if @i_modo = 0
            begin
              select @w_ente,           @w_nombre,      @w_p_apellido,
                     @w_s_apellido,     @w_tipo_ced,    @w_subtipo,     @w_ced_ruc
             end 
		else
		    begin
                 select @o_ente	= @w_ente
   			     select @o_nom_ente = 	rtrim(@w_p_apellido) + ' ' + rtrim(@w_s_apellido) + ' ' + rtrim(@w_nombre)
		 		 select	@w_ente, rtrim(@w_p_apellido) + ' ' + rtrim(@w_s_apellido) + ' ' + rtrim(@w_nombre)
			     
		    end 
	end
	else
	begin
   		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601159
		return 1
	end
end

if @i_operacion = 'S'
begin
	set rowcount 20
	if @i_tipo = 1 
	begin
		if @i_subtipo = 1 
		begin
		    if @i_modo = 0
		    begin
	            	select 
		    	         'TIPO ID'  		 = en_tipo_ced,
		    	         'IDENTIFICACION'	 = en_ced_ruc,
		    	         'NOMBRE' 		     = en_nombre,
		    	         'APELLIDOS'		 = p_p_apellido
	            	from cobis..cl_ente, 
                         cobis..cl_ciudad
			        where en_ente     = @i_ente
			        and   en_tipo_ced <> 'D' 
                    and   en_tipo_ced <> 'S' 
	            	order by en_ced_ruc

	            	if @@rowcount = 0
    	            	begin
                      		exec cobis..sp_cerror
                      		@t_debug = @t_debug,
                      		@t_file  = @t_file, 
                      		@t_from  = @w_sp_name,
                      		@i_num   = 601159
                      		return 1 
                    	end
		    end
		    else 
			begin
	            	select 
		    	         'TIPO ID'  		= en_tipo_ced,
		    	         'IDENTIFICACION'	= en_ced_ruc,
		    	         'NOMBRE' 		    = en_nombre,
		    	         'APELLIDOS'		= p_p_apellido
	            	from cobis..cl_ente, 
                         cobis..cl_ciudad
			        where en_ente = @i_ente
			        and   en_ced_ruc > @i_identif
			        and   en_tipo_ced <> 'D' 
                    and   en_tipo_ced <> 'S' 
	            	order by en_ced_ruc

	            	if @@rowcount = 0
    	            	begin
                      		exec cobis..sp_cerror
                      		@t_debug = @t_debug,
                      		@t_file  = @t_file, 
                      		@t_from  = @w_sp_name,
                      		@i_num   = 601159
                      		return 1 
                    	end
		    end
		end
		if @i_subtipo = 2 
		begin
		    if @i_modo = 0
		    begin
	            	select 
		    	'TIPO ID'  		= en_tipo_ced,
		    	'IDENTIFICACION'	= en_ced_ruc,
		    	'NOMBRE' 		= en_nombre,
		    	'APELLIDOS'		= p_p_apellido
	            	from cobis..cl_ente, cobis..cl_ciudad
			where en_ente = @i_ente
			  and en_tipo_ced = 'D' 
                          and en_tipo_ced = 'S' 
	            	order by en_ced_ruc


	            	if @@rowcount = 0
    	            	begin
                      		exec cobis..sp_cerror
                      		@t_debug = @t_debug,
                      		@t_file  = @t_file, 
                      		@t_from  = @w_sp_name,
                      		@i_num   = 601159
                      		return 1 
                    	end
		    end
		    else 
		    begin
	            	select 
		    	'TIPO ID'  		= en_tipo_ced,
		    	'IDENTIFICACION'	= en_ced_ruc,
		    	'NOMBRE' 		= en_nombre,
		    	'APELLIDOS'		= p_p_apellido
	            	from cobis..cl_ente, cobis..cl_ciudad
			where en_ente = @i_ente
			  and en_ced_ruc > @i_identif
			  and en_tipo_ced = 'D' 
                          and en_tipo_ced = 'S' 
	            	order by en_ced_ruc

	            	if @@rowcount = 0
    	            	begin
                      		exec cobis..sp_cerror
                      		@t_debug = @t_debug,
                      		@t_file  = @t_file, 
                      		@t_from  = @w_sp_name,
                      		@i_num   = 601159
                      		return 1 
                    	end
		    end
		end
	end
	if @i_tipo = 2 
	begin
		if @i_subtipo = 1 
		begin
		    if @i_modo = 0
		    begin
	            	select 
		    	'TIPO ID'  		= en_tipo_ced,
		    	'IDENTIFICACION'	= en_ced_ruc,
		    	'NOMBRE' 		= en_nombre,
		    	'APELLIDOS'		= p_p_apellido
	            	from cobis..cl_ente, cobis..cl_ciudad
			where en_ente = @i_ente
			  and en_tipo_ced <> 'D' 
                          and en_tipo_ced <> 'S' 
	            	order by en_nombre

	            	if @@rowcount = 0
    	            	begin
                      		exec cobis..sp_cerror
                     		@t_debug = @t_debug,
                      		@t_file  = @t_file, 
                      		@t_from  = @w_sp_name,
                      		@i_num   = 601159
                      		return 1 
                    	end
		    end
		    else  
		    begin
	            	select 
		    	'TIPO ID'  		= en_tipo_ced,
		    	'IDENTIFICACION'	= en_ced_ruc,
		    	'NOMBRE' 		= en_nombre,
		    	'APELLIDOS'		= p_p_apellido
	            	from cobis..cl_ente, cobis..cl_ciudad
			where en_ente = @i_ente
			  and en_ced_ruc > @i_nombre
			  and en_tipo_ced <> 'N' 
			  and en_tipo_ced <> 'D' 
                          and en_tipo_ced <> 'S' 
	            	order by en_nombre

	            	if @@rowcount = 0
    	            	begin
                      		exec cobis..sp_cerror
                     		@t_debug = @t_debug,
                      		@t_file  = @t_file, 
                      		@t_from  = @w_sp_name,
                      		@i_num   = 601159
                      		return 1 
                    	end
		    end
		end 
		if @i_subtipo = 2 
		begin
		    if @i_modo = 0
		    begin
	            	select 
		    	'TIPO ID'  		= en_tipo_ced,
		    	'IDENTIFICACION'	= en_ced_ruc,
		    	'NOMBRE' 		= en_nombre,
		    	'APELLIDOS'		= p_p_apellido
	            	from cobis..cl_ente, cobis..cl_ciudad
			where en_ente = @i_ente
			  and en_tipo_ced = 'N' 
			  and en_tipo_ced = 'D' 
                          and en_tipo_ced = 'S' 
	            	order by en_nombre


	            	if @@rowcount = 0
    	            	begin
                      		exec cobis..sp_cerror
                      		@t_debug = @t_debug,
                      		@t_file  = @t_file, 
                      		@t_from  = @w_sp_name,
                      		@i_num   = 601159
                      		return 1 
                    	end
		    end
		    else 
		    begin
	            	select 
		    	'TIPO ID'  		= en_tipo_ced,
		    	'IDENTIFICACION'	= en_ced_ruc,
		    	'NOMBRE' 		= en_nombre,
		    	'APELLIDOS'		= p_p_apellido
	            	from cobis..cl_ente, cobis..cl_ciudad
			where en_ente = @i_ente
			  and en_ced_ruc > @i_nombre
			  and en_tipo_ced = 'N' 
			  and en_tipo_ced = 'D' 
                          and en_tipo_ced = 'S' 
	            	order by en_nombre
	            	if @@rowcount = 0
    	            	begin
                      		exec cobis..sp_cerror
                      		@t_debug = @t_debug,
                      		@t_file  = @t_file, 
                      		@t_from  = @w_sp_name,
                      		@i_num   = 601159
                      		return 1 
                    	end
		   end
		end
	end
end   



if @i_operacion = 'A'
begin
        if @i_modo = 0
        begin
 	     select 'TIPO ID'           = en_tipo_ced,
                    'IDENTIFICACION'    = en_ced_ruc,
                    'NOMBRE'            = en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido
             from cobis..cl_ente
             order by en_ced_ruc

             if @@rowcount = 0
             begin
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 601159
              return 1 
   	     end
        end

        if @i_modo = 1
        begin
 	     select 'TIPO ID'           = en_tipo_ced,
                    'IDENTIFICACION'    = en_ced_ruc,
                    'NOMBRE'            = en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido
             from cobis..cl_ente
             where en_ente = @i_ente 
               and en_ced_ruc > @i_identif
             order by en_ced_ruc

             if @@rowcount = 0
             begin
        	      exec cobis..sp_cerror
	              @t_debug = @t_debug,
        	      @t_file  = @t_file,
	              @t_from  = @w_sp_name,
        	      @i_num   = 601159
	              return 1
	    end
        end


        if @i_modo = 3
        begin

	     set rowcount 20
	     select distinct
		    'CODIGO'   	        = en_ente,
            'TIPO ID'           = en_tipo_ced,
            'IDENTIFICACION'    = en_ced_ruc,
            'NOMBRE'            = en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido,
            'DOCUMENTO'         = sa_documento,
		    'CUENTA'            = sa_cuenta,
		    'OFICINA'	        = sa_oficina_dest,
		    'AREA'	        = sa_area_dest,
		    'MOV. DEBITO'       = sum(sa_debito),
		    'MOV. CREDITO MN'   = sum(sa_credito),
		    'MOV. DEBITO ME'    = sum(sa_debito_me),
		    'MOV. CREDITO ME'   = sum(sa_credito_me)
             from cobis..cl_ente, cob_conta_tercero..ct_sasiento, cob_conta_tercero..ct_scomprobante
             where sa_empresa = @i_empresa
             and sa_producto > 0
             and sa_fecha_tran >= @i_fecha_i
             and sa_fecha_tran <= @i_fecha_f
             and sa_comprobante > 0
             and sa_asiento > 0
             and sa_cuenta = @i_cuenta_i
	         and sa_oficina_dest = @i_oficina
	         and sa_area_dest = @i_area
             and isnull(sa_documento,'') like @i_documento
             and sa_mayorizado = 'S'
             and sa_ente = en_ente
--           and ((sa_cuenta >= @i_cuenta_i and sa_cuenta <= @i_cuenta_f)
--                 or (sa_cuenta like (@i_cuenta_i + '%') 
--                 or sa_cuenta like (@i_cuenta_f + '%')))
             and en_ente = @i_ente 
             and sc_comprobante = sa_comprobante
             and sc_fecha_tran = sa_fecha_tran
             and sc_empresa = @i_empresa
             group by en_ente, en_tipo_ced, en_ced_ruc, en_nombre, p_p_apellido, p_s_apellido, sa_documento,sa_cuenta,sa_oficina_dest,sa_area_dest
               order by en_ente, sa_documento,sa_cuenta, sa_oficina_dest, sa_area_dest

	     if @@rowcount = 0
             begin
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 601159
              return 1
             end
        end

        if @i_modo = 4
        begin
	     set rowcount 20
	     select distinct
		    'CODIGO'   	        = en_ente,
            'TIPO ID'           = en_tipo_ced,
            'IDENTIFICACION'    = en_ced_ruc,
            'NOMBRE'            = en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido,
            'DOCUMENTO'         = sa_documento,
		    'CUENTA'            = sa_cuenta,
		    'OFICINA'	        = sa_oficina_dest,
		    'AREA'	        = sa_area_dest,
		    'MOV. DEBITO'       = sum(sa_debito),
		    'MOV. CREDITO MN'   = sum(sa_credito),
		    'MOV. DEBITO ME'    = sum(sa_debito_me),
		    'MOV. CREDITO ME'   = sum(sa_credito_me)
             from cobis..cl_ente, cob_conta_tercero..ct_sasiento, cob_conta_tercero..ct_scomprobante
             where sa_empresa = @i_empresa
               and sa_fecha_tran >= @i_fecha_i
               and sa_fecha_tran <= @i_fecha_f
               and sa_comprobante > 0
               and sa_cuenta >= @i_cuenta_i 
--               and   sa_oficina_dest  in (select je_oficina from cob_conta..cb_jerarquia
--                                           where  je_empresa = @i_empresa
--                                   	   and (je_oficina = @i_oficina or
--                                           je_oficina_padre = @i_oficina))
--               and   sa_area_dest in (select ja_area from cob_conta..cb_jerararea
--                              		where ja_empresa = @i_empresa and
--                                   	(ja_area_padre = @i_area or  
--                                    	ja_area = @i_area))
	       and sa_oficina_dest = @i_oficina
	       and sa_area_dest = @i_area
               and (en_ente = @i_ente or isnull(@i_ente,0)=0)  
               and sa_ente = en_ente
               and sc_comprobante = sa_comprobante
               and sc_fecha_tran = sa_fecha_tran
               and sc_empresa = @i_empresa
               and sa_documento like @i_documento
               and sa_mayorizado = 'S'
               and ((sa_ente > @i_ente1) or
                    (sa_ente = @i_ente1 and sa_documento > @i_documento1) or
                    (sa_ente = @i_ente1 and sa_documento = @i_documento1 and sa_cuenta > @i_cuenta) or
                    (sa_ente = @i_ente1 and sa_documento = @i_documento1 and sa_cuenta = @i_cuenta and sa_oficina_dest > @i_oficina_dest) or
                    (sa_ente = @i_ente1 and sa_documento = @i_documento1 and sa_cuenta = @i_cuenta and sa_oficina_dest = @i_oficina_dest and sa_area_dest > @i_area_dest)
                    )
	       group by en_ente, en_tipo_ced, en_ced_ruc, en_nombre, p_p_apellido, p_s_apellido, sa_documento,sa_cuenta,sa_oficina_dest,sa_area_dest
               order by en_ente, sa_documento,sa_cuenta, sa_oficina_dest, sa_area_dest

             if @@rowcount = 0
             begin
               exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 601150
               return 1
             end
        end

       return 0
end

if @i_operacion = 'M'       
begin
    if NOT EXISTS(    
    select * 
    from cobis..cl_ente 
    where 
         en_subtipo = @i_subtipo_ente and 
	 en_tipo_ced = @i_tipo_ced and
	 en_ced_ruc  = @i_cedula 
    )

    begin


   if @i_tipo_dir is not null
      select @w_num_dir = 1
   else
      select @w_num_dir = 0

   if @i_subtipo_ente = 'P'
   begin
      select @w_fecha_nac     = '01/01/1910',
             @w_fecha_emision = '01/01/1930',
             @w_fecha_ven     = null,
             @w_lugar_nac     = 5001000,
             @w_tipo_vivienda = 'P',
             @w_rep_superban  = 'N',
             @w_fecha_emision = null,
             @w_fecha_expira  = null,
             @w_sexo          = 'M',
             @w_profesion     = '000000',
             @w_estado_civil  = null,
             @w_nivel_estudio = null

      if @i_tipo_ced = 'PA' or @i_tipo_ced = 'CE'
      begin
          select @w_lugar_doc = 249
      end
      else
      begin
          select @w_lugar_doc = 5001000
      end
   end  
   else
   begin
      select @w_fecha_nac     = null,
             @w_fecha_emision = null,
             @w_fecha_ven     = null,
             @w_notaria       = 1,
             @w_escritura     = 1,
             @w_ciudad_notaria = 5001000
   end

   select    @w_filial        = 1,
             @w_pais          = 169,
             @w_referido      = null,
             @w_rep_superban  = 'N'

   exec cobis..sp_cseqnos
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_tabla        = 'cl_ente',
                @o_siguiente    = @w_sgte_ente out

   select @w_nombres_ente = ltrim(rtrim(@i_nombres_ente))

   insert into cobis..cl_ente
   (
    en_ente,		en_nombre,		en_subtipo,		en_filial,
    en_oficina,		en_ced_ruc,             en_fecha_mod,           en_direccion,
    en_actividad,       en_retencion,           en_mala_referencia,     en_tipo_ced,            
    en_sector,          p_p_apellido,           p_s_apellido,           c_tipo_compania,        
    en_nomlar,          c_ciudad,               en_gran_contribuyente,
    en_fecha_crea,                              en_referencia,          en_casilla,
    en_casilla_def,     en_tipo_dp,             en_balance,             en_pais,
    en_oficial,         en_comentario,          en_referido,            en_doc_validado,
    en_rep_superban,    p_sexo,                 p_fecha_nac,            p_ciudad_nac,
    p_lugar_doc,        p_profesion,            p_estado_civil,         p_nivel_estudio,
    p_tipo_persona,     p_tipo_vivienda,        p_personal,             p_propiedad,
    p_trabajo,          p_fecha_emision,        p_fecha_expira,         c_cap_suscrito,
    en_asosciada,       c_posicion,             c_rep_legal,            c_activo,
    c_pasivo,           c_es_grupo,             c_capital_social,       c_reserva_legal,
    c_fecha_const,      c_plazo,                                        c_direccion_domicilio,
    c_fecha_inscrp,                             c_fecha_aum_capital,    c_cap_pagado,
    c_tipo_soc,         c_total_activos,        c_num_empleados,        c_sigla,
    c_escritura,        c_notaria,              c_fecha_exp,            c_fecha_vcto,
    c_camara,           c_registro,             c_grado_soc,            c_fecha_registro,
    c_fecha_modif,      c_fecha_verif,          c_vigencia,             c_verificado,
    c_funcionario,      en_situacion_cliente,   en_patrimonio_tec,      en_fecha_patri_bruto,
    en_vinculacion,     en_tipo_vinculacion,    en_preferen,		en_categoria  
   )
   values
   (
    @w_sgte_ente,       @i_nombre,              @i_subtipo_ente,        @i_empresa,
    @i_oficina,         @i_cedula,              @s_date,                @w_num_dir,
    @i_actividad_ente,  @i_retencion,           'N',                    @i_tipo_ced,            
    @i_sector,          @i_apellido1,           @i_apellido2,           @i_tipo_cia,            
    @w_nombres_ente,    @i_ciudad_ente,         @i_gran_contribuyente,
    @w_today,           	                0,                      0,
    null,               null,                   0,                      @w_pais,
    1,                  null,                   @w_referido,            'N',
    @w_rep_superban,    @w_sexo,                @w_fecha_nac,           @w_lugar_nac,
    @w_lugar_doc,       @w_profesion,           @w_estado_civil,        @w_nivel_estudio,
    null,               @w_tipo_vivienda,       0,                      0,
    0,                  @w_fecha_emision,       @w_fecha_expira,        null,
    null,               null,                   null,                   0,
    0,                  null,                   0,                      null,
    '01/01/1990',       null,                                           null,
    null,                                       null,                   null,
    'NDE',              0,                      0,                      @i_apellido1,
    @w_escritura,       @w_notaria,             null,                   null,
    null,               null,                   null,                   null,
    null,               null,                   'VIGENTE',              'N',
    null,               'NOR',                  0,                      null,
    'N',                null,                   'N',			@i_categoria

   )


   if @i_tipo_dir is not null
   begin
     insert into cobis..cl_direccion
     (
      di_ente,            di_direccion,           di_descripcion,         di_parroquia,
      di_ciudad,          di_tipo,                di_fecha_registro,      di_fecha_modificacion,
      di_vigencia,        di_verificado
     )
     values
     (
      @w_sgte_ente,       1,                      @i_direccion_ente,      1,
      @i_ciudad_ente,     @i_tipo_dir,            @s_date,                @s_date,
      'V',                'N'
     )

     if @i_tipo_tel is not null
     begin
       insert into cobis..cl_telefono
       (
        te_ente,             te_direccion,          te_secuencial,          te_valor,
        te_tipo_telefono
       )
       values
       (
        @w_sgte_ente,        1,                     1,                      @i_telefono_ente,
        @i_tipo_tel
       )
     end
   end
  end
  else
  begin
     print 'Ya existe el tercero %1! '+@i_cedula
  end
end

if @i_operacion = 'V'
begin
   select 
   en_ente,
   en_nombre,
   p_p_apellido,
   p_s_apellido
   from cobis..cl_ente
   where en_tipo_ced > ''
   and en_ced_ruc  = @i_ced_ruc
end

if @i_operacion = 'W'
begin
   select 
   @w_ente = en_ente,
   @w_nombre = en_nombre,
   @w_p_apellido = p_p_apellido,
   @w_s_apellido = p_s_apellido,
   --en_tipo_ced,
   --DATALENGTH(en_ced_ruc),
   @w_subtipo=en_subtipo
   from cobis..cl_ente
   where en_ced_ruc  = @i_ced_ruc
   and en_tipo_ced = upper(@i_tipo_ced)

   select
   @w_ente,	    @w_nombre,
   @w_p_apellido,	@w_s_apellido, @w_subtipo
end


if @i_operacion = 'B'
begin
    select 
    en_ente,
    en_nombre,
    p_p_apellido,
    p_s_apellido,
	en_sector,
	en_actividad,
	c_tipo_compania,
    di_tipo,
    di_descripcion,
    te_tipo_telefono,
    te_valor,
    c_ciudad,
    en_retencion,
	en_gran_contribuyente,
    en_ced_ruc,
    en_tipo_ced,
    en_categoria
    from cobis..cl_ente
    left outer join cobis..cl_telefono on
         te_ente  = en_ente and 
         te_direccion = en_direccion
         left outer join cobis..cl_direccion on
            di_direccion = en_direccion and
            di_ente = en_ente
    where  en_ente  = @i_ente
    and    te_secuencial = 1    
end
go
