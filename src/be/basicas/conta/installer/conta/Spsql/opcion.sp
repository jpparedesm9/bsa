/************************************************************************/
/*	Archivo: 		opcion.sp				*/
/*	Stored procedure: 	sp_opcion				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     26-enero-1995 				*/
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
/*	   Mantenimiento al catalogo de Opciones                        */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	26/Ene/1995	G Jaramillo     Emision Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_opcion')
    drop proc sp_opcion
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_opcion (
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
   @i_modo               smallint = null,
   @i_empresa            tinyint  = null,
   @i_opcion             tinyint  = null,
   @i_debcred            char(  1)  = '%',
   @i_nombre             descripcion  = null,
   @i_opcion1		 tinyint = null,
   @i_debcred1		 char(1) = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_empresa            tinyint,
   @w_opcion             tinyint,
   @w_debcred            char(  1),
   @w_nombre             descripcion

select @w_today = getdate()
select @w_sp_name = 'sp_opcion'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 6781 and @i_operacion = 'I') or
   (@t_trn <> 6782 and @i_operacion = 'U') or
   (@t_trn <> 6783 and @i_operacion = 'D') or
   (@t_trn <> 6784 and @i_operacion = 'V') or
   (@t_trn <> 6785 and @i_operacion = 'S') or
   (@t_trn <> 6786 and @i_operacion = 'Q') or
   (@t_trn <> 6787 and @i_operacion = 'A')
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
if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
    select 
         @w_empresa = op_empresa,
         @w_opcion = op_opcion,
         @w_debcred = op_debcred,
         @w_nombre = op_nombre
    from cob_conta..cb_opcion
    where 
         op_empresa = @i_empresa and
         op_opcion = @i_opcion and
         op_debcred = @i_debcred

    if @@rowcount > 0
            select @w_existe = 1
    else
            select @w_existe = 0
end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U'
begin
    if 
         @i_empresa is NULL or 
         @i_opcion  is NULL or 
         @i_debcred is NULL or 
         @i_nombre  is NULL 
    begin
    /* Campos NOT NULL con valores nulos */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 601078
        return 1 
    end
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
         insert into cb_opcion(
              op_empresa,
              op_opcion,
              op_debcred,
              op_nombre)
         values (
              @i_empresa,
              @i_opcion,
              @i_debcred,
              @i_nombre)

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

         /* Transaccion de Servicio */
         /***************************/

         insert into ts_opcion
         values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
         @i_empresa,
         @i_opcion,
         @i_debcred,
         @i_nombre)

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 603032
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
        @i_num   = 607021
        return 1 
    end

/***** Integridad Referencial *****/
/*****                        *****/
    if exists (select * from cb_opc_item
		 where oi_empresa = @i_empresa and
			oi_opcion = @i_opcion and
			oi_debcred = @i_debcred)
    begin
    /* Registro a eliminar relacionado con otra tabla*/
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 607125
        return 1 
    end


    begin tran
         delete cob_conta..cb_opcion
    where 
         op_empresa = @i_empresa and
         op_opcion = @i_opcion and
         op_debcred = @i_debcred

                                
         if @@error <> 0
         begin
         /*Error en eliminacion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 607022
             return 1 
         end

            

         /* Transaccion de Servicio */
         /***************************/

         insert into ts_opcion
         values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
         @w_empresa,
         @w_opcion,
         @w_debcred,
         @w_nombre)

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 603032
             return 1 
         end
    commit tran
    return 0
end

/* Consulta opcion QUERY */
/*************************/

if @i_operacion = 'Q'
begin

    if @w_existe = 1
         select 
              @w_empresa,
              @w_opcion,
              @w_debcred,
              @w_nombre
    else
    begin
    /*Registro no existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 601159
        return 1 
    end
    return 0
end


/* Consulta opcion Value */
/*************************/

if @i_operacion = 'V'
begin
	if @w_existe = 1
		select @w_nombre
       	else
    	begin
    		/*Registro no existe */
       	 	exec cobis..sp_cerror
       	 	@t_debug = @t_debug,
       	 	@t_file  = @t_file, 
       	 	@t_from  = @w_sp_name,
       	 	@i_num   = 601159
       	 	return 1 
   	end
	return 0
end

/* Consulta opcion All   */
/*************************/

if @i_operacion = 'A'
begin
	set rowcount 20

	if @i_modo = 0
	begin
		select 	'Opcion' = op_opcion,
			'Nombre' = substring(op_nombre,1,25)
		from cob_conta..cb_opcion
		where op_empresa = @i_empresa and
		      op_debcred like @i_debcred

		if @@rowcount = 0
    		begin
    			/*No existen registros */
       	 		exec cobis..sp_cerror
       	 		@t_debug = @t_debug,
       	 		@t_file  = @t_file, 
       	 		@t_from  = @w_sp_name,
       	 		@i_num   = 601153
       	 		return 1 
   		end
	end
	else
	begin
		select 	'Opcion' = op_opcion,
			'Nombre' = substring(op_nombre,1,25)
		from cob_conta..cb_opcion
		where op_empresa = @i_empresa and
		      op_debcred = @i_debcred and
		      op_opcion > @i_opcion

		if @@rowcount = 0
    		begin
    			/*No existen mas registros */
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

/* Consulta opcion SEARCH  */
/*************************/

if @i_operacion = 'S'
begin
	set rowcount 20

	if @i_modo = 0
	begin
		select 	'Opcion' = op_opcion,
			'Nombre' = substring(op_nombre,1,25),
			'Deb/Cred' = op_debcred
		from cob_conta..cb_opcion
		where op_empresa = @i_empresa and
		      op_nombre like @i_nombre and
		      op_debcred like @i_debcred

		order by op_opcion,op_debcred

		if @@rowcount = 0
    		begin
    			/*No existen registros */
       	 		exec cobis..sp_cerror
       	 		@t_debug = @t_debug,
       	 		@t_file  = @t_file, 
       	 		@t_from  = @w_sp_name,
       	 		@i_num   = 601153
       	 		return 1 
   		end
	end
	else
	begin
		select 	'Opcion' = op_opcion,
			'Nombre' = substring(op_nombre,1,25),
			'Deb/Cred'= op_debcred
		from cob_conta..cb_opcion
		where op_empresa = @i_empresa and
		      op_nombre like @i_nombre and
		      op_debcred like @i_debcred and
		    ((op_opcion = @i_opcion1 and 
		      op_debcred > @i_debcred1) or
		     (op_opcion > @i_opcion1))

		if @@rowcount = 0
    		begin
    			/*No existen mas registros */
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
         update cob_conta..cb_opcion
         set 
              op_nombre = @i_nombre
    where 
         op_empresa = @i_empresa and
         op_opcion = @i_opcion and
         op_debcred = @i_debcred

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

         /* Transaccion de Servicio */
         /***************************/

         insert into ts_opcion
         values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
         @w_empresa,
         @w_opcion,
         @w_debcred,
         @w_nombre)

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 603032
             return 1 
         end

            

         /* Transaccion de Servicio */
         /***************************/

         insert into ts_opcion
         values (@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,
         @i_empresa,
         @i_opcion,
         @i_debcred,
         @i_nombre)

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 603032
             return 1 
         end
    commit tran
    return 0
end

go

