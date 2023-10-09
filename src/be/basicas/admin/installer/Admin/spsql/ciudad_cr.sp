/************************************************************************/
/*	Archivo:		ciudad.sp				*/
/*	Stored procedure:	sp_ciudad				*/
/*	Base de datos:		cobis					*/
/*	Producto: Administracion					*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 						*/
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
/*	Insercion de ciudades						*/
/*	Actualizacion de ciudades					*/
/*	Busqueda de ciudades						*/
/*	Query de ciudades						*/
/*	Ayuda de ciudades						*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*					Emision inicial			*/
/*	20/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/*	02/May/95	S. Vinces 	Cambiso de Admin Distribuido    */
/*	16/May/01       C. Vargas       Agregar en operacion H el tipo  */
/*					"S" y "E" para consultar la     */
/*					ciudad asociada a una provincia */
/*	20/Abr/94	F.Iza     	Modificaci¢n Busca ciudad	*/
/*  21/Abr/16   BBO         Migracion SYB-SQL FAL                       */
/************************************************************************/

use cobis
go

SET ANSI_NULLS OFF
go

if exists (select * from sysobjects where name = 'sp_ciudad_cr')
   drop proc sp_ciudad_cr
go

create proc sp_ciudad_cr (
	@s_ssn			    int         = NULL,
	@s_user			    login       = NULL,
	@s_sesn			    int         = NULL,
	@s_term			    varchar(32) = NULL,
	@s_date			    datetime    = NULL,
	@s_srv			    varchar(30) = NULL,
	@s_lsrv			    varchar(30) = NULL, 
	@s_rol			    smallint    = NULL,
	@s_ofi			    smallint    = NULL,
	@s_org_err		    char(1)     = NULL,
	@s_error		    int         = NULL,
	@s_sev			    tinyint     = NULL,
	@s_msg			    descripcion = NULL,
	@s_org			    char(1)     = NULL,
	@t_debug		    char(1)     = 'N',
	@t_file			    varchar(14) = null,
	@t_from			    varchar(32) = null,
	@t_trn			    smallint    = NULL,
    @i_operacion		varchar(2)  = null,
    @i_tipo			    varchar(1)  = null,
    @i_modo			    tinyint     = null,
    @i_ciudad		    int         = null, 
    @i_valorcat         catalogo    = null,
    @i_descripcion 		descripcion = null,
    @i_provincia     	int         = null, --Cambio de smallint a int
    @i_pais		     	smallint    = null, 
    @i_estado		    estado      = null,
	@i_cod_bce		    smallint    = null,
	@i_central_transmit varchar(1)  = null,
    @i_valor		    descripcion = null,   
    @i_ciudad_alf       varchar(64) = null,
	@i_canton_alf       varchar(64) = null,
	@i_canton		    int         = null
)
as
declare @w_today		datetime,
	@w_sp_name			varchar(32),
	@w_cambio			int,
	@w_parroq			int,
	@w_codigo			int,
	@w_descripcion		descripcion,
	@w_provincia		int, --Cambio de smallint a int
	@w_pais				smallint,
	@w_estado			estado,
	@v_descripcion		descripcion,
	@v_provincia		int, --Cambio de smallint a int
	@v_pais				smallint,
	@v_estado			estado,
	@v_cod_bce			smallint,
    @o_canton       	int, /* PES Version Colombia */
    @w_cmdtransrv   	varchar(64),
    @w_nt_nombre    	varchar(32),
	@w_server_logico    varchar(10),
	@w_num_nodos        smallint,    
	@w_contador         smallint,
	@w_clave  	    	int,
	@w_cod_bce	    	smallint,
	@w_return     	    int,
	@w_codigo_c	    	varchar(10), 
	@w_cod_pais			smallint,
	@w_canton     	    int,
	@w_longitud    	    int,
	@w_caracter    	    char(1),
	@w_pos				smallint,
	@w_valida    	    tinyint

select @w_today=@s_date
select @w_sp_name = 'sp_ciudad'
select @w_longitud = datalength(@i_valorcat),
       @w_pos = 1

if @i_valorcat is not null
begin
   while @w_longitud > @w_pos
   begin
      select @w_caracter = substring(@i_valorcat,@w_pos,1)
      if @w_caracter in ('0','1','2','3','4','5','6','7','8','9')
         select @w_valida = 1
      else
      begin
         select @w_valida = 0
         break
      end
      select @w_pos = @w_pos + 1
   end
   if @w_valida = 1
      select @w_canton = convert(int, @i_valorcat)
   else
   begin
      exec sp_cerror
           @t_debug	= @t_debug,
           @t_file	= @t_file,
           @t_from	= @w_sp_name,
           @i_num	= 107130
           /*'La busqueda debe realizarse por el codigo del destino geografico'*/
      return 1
   end
end
   


/* Search */
if @i_operacion = 'S'
begin
if @t_trn = 1561
begin
     set rowcount 20
     if @i_modo = 0
        select 'CODIGO'         = ci_ciudad,
               'CIUDAD'         = substring(ci_descripcion,1, 40),
               'COD. PROVINCIA' = ci_provincia,
               'PROVINCIA'      = substring(pv_descripcion,1, 20),
               'COD. PAIS'      = pv_pais,
               'PAIS'           = substring(pa_descripcion,1, 20),
        	      'COD. CANTON'    = ci_canton,
               'CANTON'         = substring(ca_descripcion,1, 20),
               'COD.REMESAS'    = ci_cod_remesas,
               'ESTADO'         = ci_estado
        from   cl_ciudad, cl_provincia, cl_pais,cl_canton,cl_municipio
        where  pv_provincia = ci_provincia
          and  pa_pais = pv_pais
          and  ca_municipio = mu_municipio
          and  mu_cod_prov = pv_provincia
          and  ci_canton  = ca_canton
        order  by ci_ciudad
     else
     if @i_modo = 1
        select 'CODIGO'         = ci_ciudad,
               'CANTON'         = substring(ci_descripcion,1, 40),
               'COD. PROVINCIA' = ci_provincia,
               'PROVINCIA'      = substring(pv_descripcion,1, 20),
               'COD. PAIS'      = pv_pais,
               'PAIS'           = substring(pa_descripcion,1, 20),
        	      'COD. CANTÓN'    = ci_canton,
               'CANTÓN'         = substring(ca_descripcion,1, 20),
               'COD.REMESAS'    = ci_cod_remesas,
               'ESTADO'         = ci_estado
        from   cl_ciudad, cl_provincia, cl_pais,cl_canton,cl_municipio
        where  pv_provincia = ci_provincia
          and  pa_pais = pv_pais
          and  ca_municipio = mu_municipio
          and  mu_cod_prov  = pv_provincia
          and  ci_canton  = ca_canton
          and  ci_ciudad > @i_canton
        order  by ci_ciudad
        
        if @@rowcount = 0
            exec sp_cerror
                 @t_debug        = @t_debug,
                 @t_file         = @t_file,
                 @t_from         = @w_sp_name,
                 @i_num          = 101000
              /*    'No existe dato en catalogo'*/
set rowcount 0
return 0
end
else
   begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151051
	   /*  'No corresponde codigo de transaccion' */
	return 1
    end
end

/* Query */
if @i_operacion = 'Q'
begin
if @t_trn = 1560
begin
     set rowcount 20
     if @i_modo = 0
	select 'Codigo'         = ci_ciudad,
	       'Canton'         = substring(ci_descripcion,1, 40),
	       'Cod. Provincia' = ci_provincia,
	       'Provincia'      = substring(pv_descripcion,1, 20),	       
	       'Cod.Remesas'    = ci_cod_remesas	       
	from   cl_ciudad, cl_provincia
	where  pv_provincia = ci_provincia
          and  ci_estado = 'V'
	order  by ci_ciudad
     else
	if @i_modo = 1
	select 'Codigo'         = ci_ciudad,
	       'Canton'         = substring(ci_descripcion,1, 40),
	       'Cod. Provincia' = ci_provincia,
	       'Provincia'      = substring(pv_descripcion,1, 20),	       
	       'Cod.Remesas'    = ci_cod_remesas
	from   cl_ciudad, cl_provincia
	where  pv_provincia = ci_provincia
	  and  ci_ciudad > @i_canton
          and  ci_estado = 'V'
	order  by ci_ciudad
     set rowcount 0
     return 0
end
else
begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151051
	   /*  'No corresponde codigo de transaccion' */
	return 1
end
end
/* ** Help ** */
if @i_operacion = "H"
begin
   if @t_trn = 1562
   begin
	if @i_tipo = "A"
	begin


		set rowcount 20
		if @i_modo = 0
			select 'Cod.'  = ci_ciudad,
			       'Nombre'= ci_descripcion,
			       'Pais'  = pa_descripcion
			  from cl_ciudad, cl_provincia, cl_pais
			 where ci_provincia = pv_provincia
 			   and pv_pais = pa_pais
			   and ci_estado = 'V'
		else 
		if @i_modo = 1
			select 'Cod.'  = ci_ciudad,
			       'Nombre'= ci_descripcion,
			       'Pais'  = pa_descripcion
			  from cl_ciudad, cl_provincia, cl_pais
			 where ci_provincia = pv_provincia
 			   and pv_pais = pa_pais
			   and ci_estado = 'V'
			   and (ci_ciudad > @i_canton or @i_canton is null)
               and (ci_ciudad = @w_canton or @w_canton is null)
     		set rowcount 0
	end
	else
	begin
	if @i_tipo = "V"
           begin
		select ci_descripcion
		  from cl_ciudad
		 where ci_ciudad = @i_canton
		   and ci_estado = 'V'
     		if @@rowcount = 0
			exec sp_cerror
				@t_debug	= @t_debug,
				@t_file		= @t_file,
				@t_from		= @w_sp_name,
				@i_num		= 101024
	       	/*' No existe dato en catalogo'*/
		return 0
	   end
           else
           begin
             if @i_tipo = "B"                                            
             begin      
        	set rowcount 20                                     
        	if @i_modo = 0       
                   select 'Cod.'  = ci_ciudad,                    
                          'Nombre'= ci_descripcion,             
                          'Pais'  = pa_descripcion                
                   from cl_ciudad, cl_provincia, cl_pais     
                   where ci_provincia = pv_provincia          
                   and pv_pais = pa_pais                    
		   and (ci_provincia = @i_provincia or @i_provincia is null)
                   and ci_estado = 'V'                      
                   and ci_descripcion like @i_valor
                   order by ci_descripcion /*--REC*/
                else                                                
                if @i_modo = 1       
                   select 'Cod.'  = ci_ciudad,                    
                          'Nombre'= ci_descripcion,             
                          'Pais'  = pa_descripcion                 
                  from cl_ciudad, cl_provincia, cl_pais     
                 where ci_provincia = pv_provincia          
                   and pv_pais = pa_pais                    
		   and (ci_provincia = @i_provincia or @i_provincia is null)
                   and ci_estado = 'V'                 
                   and ci_descripcion like @i_valor
                   and ci_descripcion > @i_canton_alf                /*REC*/
                   order by ci_descripcion  --REC
                   set rowcount 0  
             end                                    
             else
	       if @i_tipo = "S" 
	       begin
		set rowcount 20
		if @i_modo = 0
			select 'Cod.'  = ci_ciudad,                    
                   'Nombre'= ci_descripcion,             
                   'Pais'  = pa_descripcion 
			  from cl_ciudad, cl_provincia, cl_pais
			 where ci_provincia = pv_provincia
 			   and pv_pais      = pa_pais
			   and pv_provincia = @i_provincia
			   and ci_estado    = 'V'
		else 
		if @i_modo = 1
			select 'Cod.'  = ci_ciudad,                    
                   'Nombre'= ci_descripcion,             
                   'Pais'  = pa_descripcion 
			  from cl_ciudad, cl_provincia, cl_pais
			 where ci_provincia = pv_provincia
 			   and pv_pais      = pa_pais
			   and pv_provincia = @i_provincia
			   and ci_estado    = 'V'
			   and ci_ciudad    > @i_canton			   
     		set rowcount 0		
	       end
	       else
		  if @i_tipo = "E"
		  begin
			select ci_descripcion
			  from cl_ciudad
			 where ci_ciudad    = @i_canton
			   and ci_provincia = @i_provincia
			   and ci_estado    = 'V'
     			if @@rowcount = 0
			   exec sp_cerror
				@t_debug	= @t_debug,
				@t_file		= @t_file,
				@t_from		= @w_sp_name,
				@i_num		= 101024,
				@i_msg          = "canton no pertenece a provincia o no existe"
		       	/*' No existe dato en catalogo'*/
			return 0
		  end
		  else
			if @i_tipo = "N"
			begin
			
				/* validacion de parametro general del pais */
				/* ADU: 20051214 */
			
			    select @w_cod_pais = pa_smallint
			    from cobis..cl_parametro
			    where pa_nemonico='CP' and pa_producto='ADM'
			    
			    if (@w_cod_pais is null)
			    begin
			  
			  	exec sp_cerror
			  	     @t_debug     = @t_debug,
			  	     @i_msg       = 'NO EXISTE PARAMETRO DE CODIGO DE PAIS (CP)',
			  	     @t_file      = @t_file,
			  	     @t_from      = @w_sp_name,
			  	     @i_num       = 101077
			  	return 1
			    end

				set rowcount 20
				if @i_modo = 0
					select 'Cod.'  = ci_ciudad,                    
                           'Nombre'= ci_descripcion,             
                           'Pais'  = pa_descripcion 
					  from cl_ciudad, cl_provincia, cl_pais
					 where ci_provincia = pv_provincia
		 			   and pv_pais = pa_pais
					   and ci_estado = 'V'
					   and pa_pais = @w_cod_pais
				else 
				if @i_modo = 1
					select 'Cod.'  = ci_ciudad,                    
                           'Nombre'= ci_descripcion,             
                           'Pais'  = pa_descripcion
					  from cl_ciudad, cl_provincia, cl_pais
					 where ci_provincia = pv_provincia
		 			   and pv_pais = pa_pais
					   and ci_estado = 'V'
					   and ci_ciudad > @i_canton
					   and pa_pais = @w_cod_pais
		     		set rowcount 0
			end
			else
				if @i_tipo = "W"
			    	begin
						/* validacion de parametro general del pais */
						/* ADU: 20051214 */
					
					    select @w_cod_pais = pa_smallint
					    from cobis..cl_parametro
					    where pa_nemonico='CP' and pa_producto='ADM'
					    
					    if (@w_cod_pais is null)
					    begin
					  
					  	exec sp_cerror
					  	     @t_debug     = @t_debug,
					  	     @i_msg       = 'NO EXISTE PARAMETRO DE CODIGO DE PAIS (CP)',
					  	     @t_file      = @t_file,
					  	     @t_from      = @w_sp_name,
					  	     @i_num       = 101077
					  	return 1
					    end

						select ci_descripcion
						from cl_ciudad
						where ci_ciudad = @i_canton
							and ci_estado = 'V'
							and ci_pais = @w_cod_pais
				     	
				     	if @@rowcount = 0
							exec sp_cerror
								@t_debug	= @t_debug,
								@t_file		= @t_file,
								@t_from		= @w_sp_name,
								@i_num		= 101024
						/*' No existe dato en catalogo'*/
						return 0
				 	end
				 else
               	     begin
	                 exec sp_cerror
		             @t_debug	 = @t_debug,
	  	             @t_file	 = @t_file,
	        	     @t_from	 = @w_sp_name,
		             @i_num	 = 151051
		           /*  'No corresponde codigo de transaccion' */
	        	     return 1
                      end
           end
       end
   end
end
go
