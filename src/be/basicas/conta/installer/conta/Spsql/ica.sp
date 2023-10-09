/************************************************************************/
/*	Archivo: 		ica.sp  				*/
/*	Stored procedure: 	sp_ica					*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Fernando Salgado 			*/
/*	Fecha de escritura:     02-Abril-1997 				*/
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
/*	   Mantenimiento de la tabla cb_ica				*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	02/Abr/1997	F.Salgado	Emision Inicial			*/
/*	21/Nov/1997	Juan Carlos Gomez Cambio de longitud de campo   */
/*					ic_codigo			*/
/*      20/nov/1997     Sandra Robayo   Insercion operacion B           */
/*	01/Dic/1997	Juan Carlos Gomez Modificacion en operacion 'A' */
/* 	12/Dic/1997	Juan Carlos Gomez Ingreso de nuevos parametros  */
/*    			JCG10 						*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_ica')
	drop proc sp_ica
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_ica (
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
   @i_empresa            tinyint = null,   /* JCG10 */
   @i_codigo             char(4) = null,
   @i_descripcion        varchar(255) = null,
   @i_codiciud           int = null,
   @i_ofic_destino       smallint = null,
   @i_base               money = 0,
   @i_porcentaje         float = 0,
   @i_cuenta		 cuenta = null,
   @i_ciudad		 int = null,
   @i_debcred            char(1) = null          /* JCG10 */
)
as

declare
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,        /* existe el registro*/
   @w_retencion  	 float,
   @w_empresa      	 tinyint,    /* JCG10 */
   @w_codigo             char(4),
   @w_codiciud           int,
   @w_descripcion        varchar(255),
   @w_base               money,
   @w_ciudad		 int,
   @w_ciudad_admin       int,
   @w_flag               char(2),    /* Indica que no hay mas registros */
   @w_oficina_admin      smallint,
   @w_debito             money,
   @w_credito            money,
   @w_debcred            char(1)     /* JCG10 */

select @w_sp_name = 'sp_ica'
select @w_flag = '00'

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
		i_operacion		   = @i_operacion,
                i_empresa  		   = @i_empresa,  /* JCG10 */
		i_codigo                   = @i_codigo,
                i_descripcion              = @i_descripcion,
                i_base                     = @i_base,
                i_porcentaje               = @i_porcentaje,
		i_ciudad		   = @i_ciudad,
         	i_debcred		   = @i_debcred   /* JCG10 */

	exec cobis..sp_end_debug
end

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 6968 and @i_operacion = 'I') or /* Insercion */
   (@t_trn <> 6969 and @i_operacion = 'U') or /* Update */
   (@t_trn <> 6970 and @i_operacion = 'D') or /* Eliminacion */
   (@t_trn <> 6971 and @i_operacion = 'A') or /* Search */
   (@t_trn <> 6971 and @i_operacion = 'F') or /* Find Conceptos */
   (@t_trn <> 6971 and @i_operacion = 'S') or /* Search */
   (@t_trn <> 6581 and @i_operacion = 'B') or /* Search 88 y 99 */
   (@t_trn <> 6585 and @i_operacion = 'Q') or /* busca uno */
   (@t_trn <> 6586 and @i_operacion = 'V')  /* trae la ciudad */
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
if @i_operacion <> 'A' and @i_operacion <> 'B' and @i_operacion <> 'V'
begin
    select @w_empresa = ic_empresa,   /* JCG10 */
	   @w_codigo = ic_codigo,
           @w_descripcion = ic_descripcion,
           @w_base = ic_base,
           @w_retencion = ic_porcentaje,
	   @w_ciudad = ic_ciudad,
	   @w_debcred = ic_debcred    /* JCG10 */
    from cob_conta..cb_ica
    where ic_empresa = @i_empresa and /* JCG10 */
          ic_codigo = @i_codigo and
          ic_ciudad = @i_ciudad and
          ic_debcred = @i_debcred

    if @@rowcount = 0
            select @w_existe = 0
    else
            select @w_existe = 1
end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U' or @i_operacion = 'D'
begin
    if   @i_empresa is NULL or    /* JCG10 */
         @i_codigo  is NULL or
         @i_descripcion is NULL or
         @i_porcentaje  is NULL or
         @i_base   is NULL or
         @i_ciudad is NULL or
	 @i_debcred is NULL       /* JCG10 */
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
         insert into cb_ica(
    	      ic_empresa,    /* JCG10 */
	      ic_codigo,
              ic_descripcion,
              ic_base,
              ic_porcentaje,
	      ic_ciudad,
	      ic_debcred)    /* JCG10 */
         values (
              @i_empresa,    /* JCG10 */
              @i_codigo,
              @i_descripcion,
              @i_base,
              @i_porcentaje,
	      @i_ciudad,
              @i_debcred)    /* JCG10 */

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

         insert into ts_concica
         values (@i_empresa,@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
	 @i_codigo,
         @i_descripcion,
         @i_base,
         @i_porcentaje,
	 @i_ciudad,
	 @i_debcred)		/* JCG10 */

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
         update cob_conta..cb_ica
	    set ic_empresa = @i_empresa,    /* JCG10 */
		ic_codigo = @i_codigo,
                ic_descripcion = @i_descripcion,
                ic_base = @i_base,
                ic_porcentaje = @i_porcentaje,
		ic_ciudad = @i_ciudad,
		ic_debcred = @i_debcred     /* JCG10 */
         where  ic_empresa = @i_empresa and /* JCG10 */
		ic_codigo = @i_codigo and
                ic_ciudad = @i_ciudad and
                ic_debcred = @i_debcred

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

         insert into ts_concica
         values (@i_empresa,@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
 	 @w_codigo,
         @w_descripcion,
         @w_base,
         @w_retencion,
	 @w_ciudad,
	 @w_debcred)		/* JCG10 */

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

         insert into ts_concica
         values (@i_empresa,@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,
 	 @i_codigo,
         @i_descripcion,
         @i_base,
         @i_porcentaje,
	 @i_ciudad,
	 @i_debcred)		/* JCG10 */

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
        @i_num   = 605082
        return 1
    end

    /* integridad referencial  */

    declare cursor_conceptos cursor for
    select as_debito, as_credito
    from cb_retencion a, cb_asiento, cb_relofi b , cobis..cl_oficina
    where
       a.re_con_ica = @i_codigo and
       as_comprobante = a.re_comprobante and
       as_empresa = a.re_empresa and
       a.re_asiento = as_asiento and
       a.re_empresa = @i_empresa and
       b.re_filial = @i_empresa and
       b.re_empresa = @i_empresa and
       re_ofconta = as_oficina_dest and
       of_filial = @i_empresa and
       of_oficina = b.re_ofadmin

    open cursor_conceptos

    fetch cursor_conceptos into @w_debito, @w_credito

    while @@fetch_status = 0
    begin
      /* integridad referencial  */

      if (@w_debito > 0 and @i_debcred = 'D') or
         (@w_credito > 0 and @i_debcred = 'C')
      begin

         /* registro a eliminar esta relacionado con tabla */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file = @t_file,
         @t_from = @w_sp_name,
         @i_num = 607127
         close cursor_conceptos
         deallocate cursor_conceptos
         return 1
      end

      fetch cursor_conceptos into @w_debito, @w_credito

    end


    close cursor_conceptos
    deallocate cursor_conceptos

    begin tran
         delete cob_conta..cb_ica
    where ic_empresa = @i_empresa and    /* JCG10 */
	  ic_codigo = @i_codigo and
          ic_ciudad = @i_ciudad and
          ic_debcred = @i_debcred

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

         insert into ts_concica
         values (@i_empresa,@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
 	 @w_codigo,
         @w_descripcion,
         @w_base,
         @w_retencion,
	 @w_ciudad,
	 @w_debcred)

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

/* Consulta opcion ALL */
/***********************/

if @i_operacion = 'A'
begin
        set rowcount 20

	if @i_modo = 0
	begin
	     select
		    'CIUDAD'		= ic_ciudad,
		    'DESCRIP. CIUDAD'   = substring(ci_descripcion,1,20),
		    'CODIGO'            = ic_codigo,
                    'DESCRIPCION'       = ic_descripcion,
                    'BASE'              = ic_base,
                    'RETENCION'         = convert(money,ic_porcentaje),
                    'DEB/CRED'		= ic_debcred
	     from cob_conta..cb_ica, cobis..cl_ciudad
	     where ic_ciudad = ci_ciudad  and
                   ic_empresa = @i_empresa
	     order by convert(int,ic_ciudad),
                      convert(int,ic_codigo),
		      ic_debcred

	     if @@rowcount = 0
    	     begin
               if @@error <> 0
               begin
                 /*No existen registros */
                 exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 601159
                 return 1
               end
               set rowcount 0
             end
             set rowcount 0
             return 0
	end
	if @i_modo = 1
	begin
	     select
		    'CIUDAD'		= ic_ciudad,
		    'DESCRIP. CIUDAD'   = substring(ci_descripcion,1,20),
		    'CODIGO'            = ic_codigo,
                    'DESCRIPCION'       = ic_descripcion,
                    'BASE'              = ic_base,
                    'RETENCION'         = convert(money,ic_porcentaje),
                    'DEB/CRED'   	= ic_debcred
	     from cob_conta..cb_ica, cobis..cl_ciudad
	     where ic_ciudad = ci_ciudad and
                   ((convert(int,ic_ciudad) = convert(int,@i_codiciud) and
                     ic_codigo > @i_codigo) or
                     convert(int,ic_ciudad) > convert(int,@i_codiciud)) and
                   ic_empresa = @i_empresa
	     order by convert(int,ic_ciudad),
		      convert(int,ic_codigo),
		      ic_debcred

	     if @@rowcount = 0
    	     begin
               if @@error <> 0
               begin
                 /*No existen registros */
                 exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 601159
                 return 1
               end
               select @w_flag = '10'
               select @w_flag
               set rowcount 0
             end
             set rowcount 0
             return 0
	end

	return 0
end


if @i_operacion = 'F'
begin
	if @i_modo = 0 or @i_modo = 1
	begin
		select @w_ciudad = ic_ciudad
		from cobis..cl_oficina a, cob_conta..cb_oficina b,
		cob_conta..cb_relofi c, cob_conta..cb_ica d
		where a.of_oficina = c.re_ofadmin
		and a.of_filial = c.re_filial
		and c.re_empresa = b.of_empresa
		and c.re_empresa = b.of_empresa
		and c.re_empresa = @i_empresa
		and b.of_oficina = c.re_ofconta
		and b.of_estado = 'V'
		and b.of_movimiento = 'S'
		and d.ic_empresa = b.of_empresa
		and d.ic_ciudad = a.of_ciudad
		and c.re_ofconta = @i_ofic_destino
		and d.ic_debcred = 'C'
	end

	set rowcount 20
	if @i_modo = 0
	begin
		select	'CODIGO'	= ic_codigo,
			'DESCRIPCION'	= substring(ic_descripcion,1,40),
			'BASE'		= ic_base,
			'PORCENTAJE'	= ic_porcentaje
		from cob_conta..cb_ica
		where ic_empresa = @i_empresa
		and ic_ciudad = isnull(@w_ciudad,11001)
		and ic_debcred = 'C'
		order by convert(int,ic_codigo)
		if @@rowcount = 0
		begin	/*No existen registros */
			set rowcount 0
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
		select	'CODIGO'	= ic_codigo,
			'DESCRIPCION'	= substring(ic_descripcion,1,40),
			'BASE'		= ic_base,
			'PORCENTAJE'	= ic_porcentaje
		from cob_conta..cb_ica
		where ic_empresa = @i_empresa
		and convert(int,ic_codigo) > convert(int,@i_codigo)
		and ic_ciudad = isnull(@w_ciudad,11001)
		and ic_debcred = 'C'
		order by convert(int,ic_codigo)
		if @@rowcount = 0
		begin	/*No existen registros */
			set rowcount 0
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 601159
			return 1
		end
	end


	if @i_modo = 2
	begin
		if @i_ofic_destino is null
		begin
			select ic_descripcion, ic_porcentaje, ic_base
			from cob_conta..cb_ica
			where ic_empresa = @i_empresa
			and convert(int,ic_codigo) = convert(int,@i_codigo)
			and ic_debcred = 'C'
			if @@rowcount = 0
			begin	/*No existen registros */
				set rowcount 0
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file  = @t_file,
				@t_from  = @w_sp_name,
				@i_num   = 601159
				return 1
			end

			set rowcount 0
			return 0
		end


		select @w_ciudad = ic_ciudad
		from cobis..cl_oficina a, cob_conta..cb_oficina b,
		cob_conta..cb_relofi c, cob_conta..cb_ica d
		where a.of_oficina = c.re_ofadmin
		and a.of_filial = c.re_filial
		and c.re_empresa = b.of_empresa
		and c.re_empresa = b.of_empresa
		and c.re_empresa = @i_empresa
		and b.of_oficina = c.re_ofconta
		and b.of_estado = 'V'
		and b.of_movimiento = 'S'
		and d.ic_empresa = b.of_empresa
		and d.ic_ciudad = a.of_ciudad
		and d.ic_codigo = @i_codigo
		and c.re_ofconta = @i_ofic_destino
		and d.ic_debcred = 'C'

		select ic_descripcion, ic_porcentaje, ic_base
		from cob_conta..cb_ica
		where ic_empresa = @i_empresa
		and convert(int,ic_codigo) = convert(int,@i_codigo)
		and ic_ciudad = @w_ciudad
		and ic_debcred = 'C'
		if @@rowcount = 0
		begin	/*No existen registros */
			set rowcount 0
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 601159
			return 1
		end
	end

	set rowcount 0
	return 0
end



/* Busca un concepto de ica */
if @i_operacion = 'Q'
begin

--	 if @w_existe = 1
--         begin
--          select @w_codigo,
--                  @w_descripcion,
 --                 @w_base,
  --                @w_retencion,
--		  @w_debcred     /* JCG10 */
 --        end
  --       else
   --      begin
	     select
		    @w_codigo = ic_codigo,
                    @w_descripcion = ic_descripcion,
                    @w_base = ic_base,
                    @w_retencion = convert(money,ic_porcentaje)
	     from cob_conta..cb_ica, cobis..cl_ciudad, cb_cuenta_proceso
	     where ic_ciudad = ci_ciudad and
		   ic_ciudad = @w_ciudad_admin and
                   ((convert(int,ic_ciudad) = convert(int,@i_codiciud) and
                     ic_codigo > @i_codigo) or
                     convert(int,ic_ciudad) > convert(int,@i_codiciud)) and
                   ic_debcred = @i_debcred and
                   ic_empresa = @i_empresa and
		   @i_cuenta like (cp_cuenta + '%') and
		   cp_proceso = 6004 and
		  cp_condicion = ic_codigo and
		  ic_codigo = @i_codigo
	     order by convert(int,ic_ciudad), convert(int,ic_codigo),
		      ic_debcred

             if @@rowcount = 0
    	     begin
               if @@error <> 0
               begin
                 /*No existen registros */
                 exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 601159
                 return 1
               end
             end
--         end
          select @w_codigo,
                 @w_descripcion,
                 @w_base,
                 @w_retencion,
        	 @w_debcred     /* JCG10 */

   return 0
end

/* Busca conceptos con codigo 88 y 99 */
if @i_operacion = 'B'
begin
        set rowcount 20
	select @w_oficina_admin = re_ofadmin
           from cb_relofi
           where
              re_ofconta = @i_ofic_destino and re_empresa = @i_empresa

	if @@rowcount = 0
    	     begin
              /*No existen registros */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 607132
                return 1
             end

         /* averigua la ciudad de la oficina admin  */

	select @w_ciudad_admin = of_ciudad
           from cobis..cl_oficina
           where
              of_oficina = @w_oficina_admin

	if @@rowcount = 0
    	   begin
           /*No existen registros */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 601159
             return 1
           end

	if @i_modo = 0
	begin
	     select
		    'CIUDAD'		= ic_ciudad,
		    'DESCRIP. CIUDAD'   = substring(ci_descripcion,1,20),
                    'CODIGO'            = ic_codigo,
                    'DESCRIPCION'       = ic_descripcion,
                    'BASE'              = ic_base,
                    'RETENCION'         = convert(money,ic_porcentaje)
	     from cob_conta..cb_ica, cobis..cl_ciudad, cb_cuenta_proceso
	     where ic_ciudad = ci_ciudad and
                   ic_debcred = @i_debcred and
                   ic_empresa = @i_empresa and
		   ic_ciudad = @w_ciudad_admin and
		   @i_cuenta like (cp_cuenta + '%') and
		   cp_proceso = 6004 and
		   cp_condicion = ic_codigo
	     order by convert(int,ic_ciudad), convert(int,ic_codigo),
		      ic_debcred

	     if @@rowcount = 0
    	     begin
            /*No existen registros */
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
	     select
		    'CIUDAD'		= ic_ciudad,
		    'DESCRIP. CIUDAD'   = substring(ci_descripcion,1,20),
                    'CODIGO'            = ic_codigo,
                    'DESCRIPCION'       = ic_descripcion,
                    'BASE'              = ic_base,
                    'RETENCION'         = convert(money,ic_porcentaje)
	     from cob_conta..cb_ica, cobis..cl_ciudad, cb_cuenta_proceso
	     where ic_ciudad = ci_ciudad and
		   ic_ciudad = @w_ciudad_admin and
                   ((convert(int,ic_ciudad) = convert(int,@i_codiciud) and
                     ic_codigo > @i_codigo) or
                     convert(int,ic_ciudad) > convert(int,@i_codiciud)) and
                   ic_debcred = @i_debcred and
                   ic_empresa = @i_empresa and
		   @i_cuenta like (cp_cuenta + '%') and
		   cp_proceso = 6004 and
		  cp_condicion = ic_codigo
	     order by convert(int,ic_ciudad), convert(int,ic_codigo),
		      ic_debcred

	     if @@rowcount = 0
    	     begin
               if @@error <> 0
               begin
                 /*No existen registros */
                 exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 601159
                 return 1
               end
               select @w_flag = '10'
               select @w_flag
               set rowcount 0
             end
             set rowcount 0
             return 0
	end

	return 0
end

/* operacion para traer la ciudad */

if @i_operacion = 'V'
begin
         /* encuentra la oficina admin de la oficina destino */

	     select @w_oficina_admin = re_ofadmin
             from cb_relofi
             where
                re_ofconta = @i_ofic_destino

	     if @@rowcount = 0
    	     begin
              /*No existen registros */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 607132
                return 1
             end

         /* averigua la ciudad de la oficina admin  */

	     select @w_ciudad_admin = of_ciudad
             from cobis..cl_oficina
             where
                of_oficina = @w_oficina_admin

	     if @@rowcount = 0
    	     begin
              /*No existen registros */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 601159
                return 1
             end

             select @w_ciudad_admin

        return 0
end


if @i_operacion = 'S'
begin

         /* encuentra la oficina admin de la oficina destino */

	     select @w_oficina_admin = re_ofadmin
             from cb_relofi
             where
                re_ofconta = @i_ofic_destino

	     if @@rowcount = 0
    	     begin
              /*No existen registros */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 607132
                return 1
             end

         /* averigua la ciudad de la oficina admin  */

	     select @w_ciudad_admin = of_ciudad
             from cobis..cl_oficina
             where
                of_oficina = @w_oficina_admin

	     if @@rowcount = 0
    	     begin
              /*No existen registros */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 601159
                return 1
             end

        set rowcount 20

	if @i_modo = 0
	begin
	     select
		    'CIUDAD'		= ic_ciudad,
		    'DESCRIP. CIUDAD'   = substring(ci_descripcion,1,20),
		    'CODIGO'            = ic_codigo,
                    'DESCRIPCION'       = ic_descripcion,
                    'BASE'              = ic_base,
                    'RETENCION'         = convert(money,ic_porcentaje),
                    'DEB/CRED'		= ic_debcred
	     from cob_conta..cb_ica, cobis..cl_ciudad
	     where ic_ciudad = ci_ciudad  and
                   ic_empresa = @i_empresa and
                   ci_ciudad = @w_ciudad_admin
	     order by convert(int,ic_ciudad),
                      convert(int,ic_codigo),
		      ic_debcred

	     if @@rowcount = 0
    	     begin
               if @@error <> 0
               begin
                 /*No existen registros */
                 exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 601159
                 return 1
               end
               set rowcount 0
             end
             set rowcount 0
             return 0
	end
	if @i_modo = 1
	begin
	     select
		    'CIUDAD'		= ic_ciudad,
		    'DESCRIP. CIUDAD'   = substring(ci_descripcion,1,20),
		    'CODIGO'            = ic_codigo,
                    'DESCRIPCION'       = ic_descripcion,
                    'BASE'              = ic_base,
                    'RETENCION'         = convert(money,ic_porcentaje),
                    'DEB/CRED'   	= ic_debcred
	     from cob_conta..cb_ica, cobis..cl_ciudad
	     where ic_ciudad = ci_ciudad and
                   ((convert(int,ic_ciudad) = convert(int,@i_codiciud) and
                     ic_codigo > @i_codigo) or
                     convert(int,ic_ciudad) > convert(int,@i_codiciud)) and
                   ic_empresa = @i_empresa and
                   ci_ciudad = @w_ciudad_admin
	     order by convert(int,ic_ciudad),
		      convert(int,ic_codigo),
		      ic_debcred

	     if @@rowcount = 0
    	     begin
               if @@error <> 0
               begin
                 /*No existen registros */
                 exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 601159
                 return 1
               end
               select @w_flag = '10'
               select @w_flag
               set rowcount 0
             end
             set rowcount 0
             return 0
	end

	return 0
end




go
