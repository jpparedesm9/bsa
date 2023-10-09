/************************************************************************/
/*	Archivo: 		concconci.sp  				*/
/*	Stored procedure: 	sp_conceptos_conciliacion	*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Marta Elena Segura P.          	*/
/*	Fecha de escritura:     1-Julio-2000 				*/
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
/*	   Mantenimiento de la tabla 						*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_conceptos_conciliacion')
    drop proc sp_conceptos_conciliacion

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_conceptos_conciliacion (
   @s_ssn                int      = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_corr               char(1)  = null,
   @s_ssn_corr           int      = null,
   @s_ofi                smallint  = null,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_modo		 tinyint = 0,
   @i_codigo		 catalogo = null,
   @i_empresa	  	 tinyint = null,
   @i_descripcion        varchar(150) = null,
   @i_tipopera	 	 char(1) = null,
   @i_tipbanco		 char(1) = null,
   @i_cod_opera		 catalogo = null
)
as

declare
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,        /* existe el registro*/
   @w_empresa            tinyint,     /* JCG10 */
   @w_codigo		 catalogo,
   @w_descripcion        varchar(150),
   @w_tipopera	 	 char(1),
   @w_tipbanco		 char(1),
   @w_cod_opera		 catalogo
   
select @w_sp_name = 'sp_conceptos_conciliacion'

/*  Modo de debug  */
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
		i_operacion			= @i_operacion,
		i_codigo			= @i_codigo,
   		i_empresa			= @i_empresa,
   		i_descripcion 		= @i_descripcion,
		i_tipopera			= @i_tipopera,
   		i_tipbanco 			= @i_tipbanco,
		i_cod_opera			= @i_cod_opera
	exec cobis..sp_end_debug
end

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 6829 and @i_operacion = 'I') or /* Insercion */
   (@t_trn <> 6830 and @i_operacion = 'U') or /* Update de nombre */
   (@t_trn <> 6831 and @i_operacion = 'D') or /* Eliminacion */
   (@t_trn <> 6834 and @i_operacion = 'Q') or /* Query de uno */
   (@t_trn <> 6834 and @i_operacion = 'V') or /* Query de uno */
   (@t_trn <> 6836 and @i_operacion = 'A') or /* Anadir operacion */
   (@t_trn <> 6837 and @i_operacion = 'E')    /* Eliminar operacion */
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 601077
    return 1 
end

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'Q'
begin
    select @w_codigo = cc_concepto,
		   @w_descripcion = cc_descripcion,
		   @w_tipopera = cc_operacion,
		   @w_tipbanco = cc_banco
    from cb_conceptos_conciliacion
    where cc_concepto  = @i_codigo

    if @@rowcount != 1
            select @w_existe = 0
    else
            select @w_existe = 1
end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U'
begin
    if   @i_empresa is NULL or /* JCG10 */
         @i_codigo  is NULL or 
         @i_descripcion is NULL or 
         @i_tipopera is NULL or 
         @i_tipbanco is NULL 
    begin
    /* Campos NOT NULL con valores nulos */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 601001
        return 1 
    end
end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'A' or @i_operacion = 'E'
begin
    if   @i_codigo is NULL or 
         @i_cod_opera is NULL 
    begin
    /* Campos NOT NULL con valores nulos */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 601001
        return 1 
    end
    select @w_codigo = cm_concepto,
		   @w_cod_opera = cm_operacion
    from cb_conceptos_movimientos
    where cm_concepto = @i_codigo
      and cm_operacion = @i_cod_opera

    if @@rowcount != 1
            select @w_existe = 0
    else
            select @w_existe = 1    
end

/* Insercion del registro */
/**************************/
if @i_operacion = 'I'
begin
    if @w_existe = 1
    begin
    /* Registro ya existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 601160
        return 1 
    end
    begin tran
         insert into cb_conceptos_conciliacion(
              cc_concepto,
              cc_descripcion,
              cc_operacion,
		      cc_banco)
         values (
              @i_codigo,
              @i_descripcion,
              @i_tipopera,
		      @i_tipbanco)
         if @@error <> 0 
         begin
         /* Error en insercion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 601161
             return 1 
         end
    commit tran 
    return 0
end

/* Actualizacion del registro */
/******************************/

if @i_operacion = 'U'
begin
    if @w_existe = 0
    begin
    /* Registro a actualizar no existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 605082

        return 1 
    end

    begin tran
         update cob_conta..cb_conceptos_conciliacion
            set cc_concepto = @i_codigo,
				cc_descripcion = @i_descripcion,
                cc_operacion = @i_tipopera,
				cc_banco = @i_tipbanco
         where  cc_concepto = @i_codigo
         
         if @@error <> 0 
         begin
         /* Error en actualizacion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 605081
             return 1 
         end
    commit tran
    return 0

end

/* Eliminacion de registros */
/****************************/

if @i_operacion = 'D'
begin
    if @w_existe = 0
    begin
    /* Registro a eliminar no existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 605082
        return 1 
    end

    begin tran
         delete cob_conta..cb_conceptos_conciliacion
	     where cc_concepto = @i_codigo    commit tran
    return 0
end

/* Consulta opcion QUERY */
/*************************/
if @i_operacion = 'V'
begin
    if @w_existe = 1
    begin
    	if @i_modo = 0
    	begin
			select
			@w_empresa,
			@w_codigo,
			@w_descripcion,
			@w_tipopera,
			@w_tipbanco
			
			set rowcount 20
	    	select 'CODIGO' = cm_operacion,
       		       'DESCRIPCION' = b.valor
		    from cb_conceptos_movimientos, cobis..cl_tabla a, cobis..cl_catalogo b
		    where a.tabla = 'cb_operacion_entidad'
		      and a.codigo = b.tabla
		      and b.codigo = cm_operacion
		      and cm_concepto = @i_codigo
		    order by cm_operacion
		
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
	 		select 'CONCEPTO' = cm_operacion,
			       'DESCRIPCION' = b.valor
		    from cb_conceptos_movimientos, cobis..cl_tabla a, cobis..cl_catalogo b
		    where a.tabla = 'cb_operacion_entidad'
		      and a.codigo = b.tabla
		      and b.codigo = cm_operacion
		      and cm_concepto = @i_codigo
	    	  and cm_operacion > @i_cod_opera
			order by cm_operacion
		
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
    else begin
    /*Registro no existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 601159
        return 1 
    end
end

if @i_operacion = 'Q'
begin
	set rowcount 20
	if @i_modo = 0
	begin
	    select 'CONCEPTO' = cc_concepto,
			   'DESCRIPCION' = cc_descripcion
	    from cb_conceptos_conciliacion
		order by cc_concepto
		
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
	    select 'CONCEPTO' = cc_concepto,
			   'DESCRIPCION' = cc_descripcion
	    from cb_conceptos_conciliacion
	    where cc_concepto > @i_codigo
		order by cc_concepto
		
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

/* Anadir operacion al concepto */
/***********************/
if @i_operacion = 'A'
begin
    if @w_existe = 1
    begin
    /* Registro ya existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 601160
        return 1 
    end
    begin tran
         insert into cb_conceptos_movimientos(
              cm_concepto,
              cm_operacion)
         values (@i_codigo,
              @i_cod_opera)
         if @@error <> 0 
         begin
         /* Error en insercion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 601161
             return 1 
         end
    commit tran 
    return 0
end   

/* Eliminar operacion a concepto */
if @i_operacion = 'E'
begin
    if @w_existe = 0
    begin
    /* Registro ya existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 605082
        return 1 
    end
    begin tran
         delete cb_conceptos_movimientos
         where cm_concepto = @i_codigo
           and cm_operacion = @i_cod_opera
         if @@error <> 0 
         begin
         /* Error en insercion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 601161
             return 1 
         end
    commit tran 
    return 0
end
go
