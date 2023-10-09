/************************************************************************/
/*	Archivo: 		concrete.sp  				*/
/*	Stored procedure: 	sp_conc_retencion			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Mauricio F. Morales R.              	*/
/*	Fecha de escritura:     19-Julio-1996 				*/
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
/*	   Mantenimiento de la tabla cb_conc_retencion                  */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	19/Jul/1996	M.Morales       Emision Inicial			*/
/*      20/Nov/1997     Sandra Robayo   Insercion Operacion B.          */
/*      28/Nov/1997     Juan Carlos Gomez Modifica operacion A.         */
/*	02/Dic/1997	Juan Carlos Gomez Modificacion de longitud de   */
/*				          @i_codigo de 3 a 4		*/
/*	12/Dic/1997	Juan Carlos Gomez Nuevos parametros		*/
/*			JCG10						*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_conc_retencion')
    drop proc sp_conc_retencion

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_conc_retencion (
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
   @i_codigo		 char(4) = null,
   @i_empresa	  	 tinyint = null, /* JCG10 */
   @i_descripcion        varchar(150) = null,
   @i_base	 	 money = 0,
   @i_porcentaje	 float = 0,
   @i_cuenta		 cuenta = null,
   @i_debcred            char(1) = null, /* JCG10 */
   @i_tipo               char(1) = null  /* JCG10 */

)
as

declare
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,        /* existe el registro*/
   @w_empresa            tinyint,     /* JCG10 */
   @w_codigo		 char(4),
   @w_descripcion        varchar(150),
   @w_base		 money,
   @w_flag               char(2),    /* Indica que no hay mas registros */
   @w_retencion	         float,
   @w_debcred            char(1),     /* JCG10 */
   @w_tipo               char(1),     /* JCG10 */
   @w_debito             money,
   @w_credito            money,
   @w_con_renta          char(1),
   @w_con_timbre         char(1)
   

select @w_sp_name = 'sp_conc_retencion'
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
                i_empresa    		   = @i_empresa, /* JCG10 */
   		i_codigo		   = @i_codigo,
   		i_descripcion		   = @i_descripcion,
   		i_base			   = @i_base,
   		i_retencion		   = @i_porcentaje,
		i_debcred		   = @i_debcred, /*JCG10 */
		i_tipo			   = @i_tipo     /* JCG10 */

	exec cobis..sp_end_debug
end

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 6954 and @i_operacion = 'I') or /* Insercion */
   (@t_trn <> 6955 and @i_operacion = 'E') or /* Existencia */
   (@t_trn <> 6956 and @i_operacion = 'Q') or /* Query de uno */
   (@t_trn <> 6956 and @i_operacion = 'V') or /* Query de uno */
   (@t_trn <> 6957 and @i_operacion = 'U') or /* Update de nombre */
   (@t_trn <> 6958 and @i_operacion = 'A') or /* Search de todos */
   (@t_trn <> 6580 and @i_operacion = 'B') or /* Search de 88 y 99 */
   (@t_trn <> 6587 and @i_operacion = 'C') or /* Search de timbre o renta */
   (@t_trn <> 6959 and @i_operacion = 'D')    /* Eliminacion */

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
if @i_operacion <> 'A' AND @i_operacion <> 'B'
begin
    select @w_empresa = cr_empresa,  /* JCG10 */
           @w_codigo = cr_codigo,
	   @w_descripcion = cr_descripcion,
	   @w_base = cr_base,
	   @w_retencion = cr_porcentaje,
	   @w_debcred = cr_debcred,  /* JCG10 */
   	   @w_tipo = cr_tipo         /* JCG10 */
    from cob_conta..cb_conc_retencion
    where cr_empresa = @i_empresa and /* JCG10 */
          cr_codigo  = @i_codigo and
	  cr_tipo = @i_tipo and 
          cr_debcred = @i_debcred

    if @@rowcount != 1
            select @w_existe = 0
    else
            select @w_existe = 1
end

if @i_operacion = 'E'
begin
   if @w_existe = 1
   begin
     select @w_codigo /* pendiente */
     select 'S'
   end
   else
   begin
     select ''
     select 'N'
   end
   return 0
end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U'
begin
    if 
         @i_empresa is NULL or /* JCG10 */
         @i_codigo  is NULL or 
         @i_descripcion is NULL or 
         @i_porcentaje is NULL or 
         @i_base is NULL or
         @i_debcred is NULL or /* JCG10 */
	 @i_tipo is NULL       /* JCG10 */ 
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
         insert into cb_conc_retencion(
   	      cr_empresa,  /* JCG10 */
              cr_codigo,
              cr_descripcion,
              cr_base,
	      cr_porcentaje,
              cr_debcred,  /* JCG10 */
	      cr_tipo)     /* JCG10 */
         values (
      	      @i_empresa,  /* JCG10 */
              @i_codigo,
              @i_descripcion,
              @i_base,
	      @i_porcentaje,
              @i_debcred,  /* JCG10 */
              @i_tipo)     /* JCG10 */

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

         insert into ts_conc_retencion   
         values (@i_empresa,@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
         @i_codigo,
         @i_descripcion,
         @i_base,
	 @i_porcentaje,
	 @i_debcred,		/* JCG10 */
	 @i_tipo)		/* JCG10 */

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
         update cob_conta..cb_conc_retencion
            set cr_empresa = @i_empresa,  /* JCG10 */ 
		cr_codigo = @i_codigo,
		cr_descripcion = @i_descripcion,
                cr_base = @i_base,
		cr_porcentaje = @i_porcentaje,
		cr_debcred = @i_debcred,  /* JCG10 */
		cr_tipo = @i_tipo         /* JCG10 */
         where  cr_empresa = @i_empresa and   /* JCG10 */ 
                cr_codigo = @i_codigo and
                cr_tipo = @i_tipo and
                cr_debcred = @i_debcred

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

         insert into ts_conc_retencion     
         values (@i_empresa,@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
         @w_codigo,
         @w_descripcion,
         @w_base,
	 @w_retencion,
	 @w_debcred,		/* JCG10 */
	 @w_tipo)		/* JCG10 */

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

         insert into ts_conc_retencion   
	 values (@i_empresa,@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,
         @i_codigo,
         @i_descripcion,
         @i_base,
	 @i_porcentaje,
	 @i_debcred,		/* JCG10 */
	 @i_tipo)		/* JCG10 */

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

/***** Integridad Referencial *****/
/*****                        *****/
    declare cursor_conceptos cursor for 
    select as_debito,
           as_credito,
           re_con_timbre,
           re_concepto
    from cb_retencion, cb_asiento  
    where (re_concepto = @i_codigo  or 
           re_con_timbre = @i_codigo) and
           as_comprobante = re_comprobante and
           as_empresa = re_empresa and
           re_empresa = @i_empresa and
           as_asiento = re_asiento
    
    open cursor_conceptos 

    fetch cursor_conceptos into @w_debito, @w_credito, @w_con_timbre, @w_con_renta

    while @@fetch_status = 0
    begin
      /* verificar que corresponda a la naturaleza */
      if (@w_debito > 0 and @i_debcred = 'D') or 
           (@w_credito > 0 and @i_debcred = 'C') 
      begin

           if (@w_con_timbre is not null and @i_tipo = 'T') or 
              (@w_con_renta is not null and @i_tipo = 'R')
           begin 

               /* Registro a eliminar esta relacionado con otra tabla */

               exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file, 
               @t_from  = @w_sp_name,
               @i_num   = 607127
               close cursor_conceptos
               deallocate cursor_conceptos 
               return 1 
           end
      end 
      fetch cursor_conceptos into @w_debito, @w_credito, @w_con_timbre, @w_con_renta
    end 

    close cursor_conceptos
    deallocate cursor_conceptos

    begin tran
         delete cob_conta..cb_conc_retencion
    where 
         cr_codigo = @i_codigo and
         cr_tipo = @i_tipo and
         cr_debcred = @i_debcred and
         cr_empresa = @i_empresa

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

         insert into ts_conc_retencion   
         values (@i_empresa,@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
         @w_codigo,
         @w_descripcion,
         @w_base,
	 @w_retencion,
	 @w_debcred,		/* JCG10 */
	 @w_tipo)		/* JCG10 */

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

/* Consulta opcion Value */
/*************************/

if @i_operacion = 'V'
begin
    select @w_empresa = cr_empresa,  /* JCG10 */
           @w_codigo = cr_codigo,
	   @w_descripcion = cr_descripcion,
	   @w_base = cr_base,
	   @w_retencion = cr_porcentaje,
	   @w_debcred = cr_debcred,  /* JCG10 */
   	   @w_tipo = cr_tipo         /* JCG10 */
    from cob_conta..cb_conc_retencion, cob_conta..cb_cuenta_proceso
    where cr_empresa = @i_empresa and /* JCG10 */
          cr_codigo  = @i_codigo and
	  cr_tipo = @i_tipo and 
          cr_debcred = @i_debcred and
	  cr_empresa = cp_empresa and
	  cp_proceso = 6004 and
 	  cp_cuenta = @i_cuenta and
	  cr_codigo = cp_condicion

    if @@rowcount != 1
    begin
    /*Registro no existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 601159
        return 1 
    end
    else
    begin
         select
	      @w_empresa,   /* JCG10 */ 
              @w_codigo,
              @w_descripcion,
              @w_base,
	      @w_retencion,
	      @w_debcred,   /* JCG10 */
	      @w_tipo       /* JCG10 */
    end
end

/* Consulta opcion QUERY */
/*************************/

if @i_operacion = 'Q'
begin
    if @w_existe = 1
    begin
         select
	      @w_empresa,   /* JCG10 */ 
              @w_codigo,
              @w_descripcion,
              @w_base,
	      @w_retencion,
	      @w_debcred,   /* JCG10 */
	      @w_tipo       /* JCG10 */
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

/* Consulta opcion ALL */
/***********************/

if @i_operacion = 'A'
begin
        set rowcount 20

	if @i_modo = 0
	begin
	     select 'CODIGO'  		= cr_codigo,
		    'DESCRIPCION'	= cr_descripcion,
		    'BASE' 		= cr_base,
		    'RETENCION'		= convert(money,cr_porcentaje),
		    'DEB/CRED'          = cr_debcred,   /* JCG10 */
		    'TIPO'              = cr_tipo       /* JCG10 */
	     from cob_conta..cb_conc_retencion
             where
               cr_empresa = @i_empresa
	     order by cr_codigo, cr_debcred

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
                    'CODIGO'  		= cr_codigo,
		    'DESCRIPCION'	= cr_descripcion,
		    'BASE' 		= cr_base,
		    'RETENCION'		= convert(money,cr_porcentaje),
		    'DEB/CRED'          = cr_debcred,    /* JCG10 */
	  	    'TIPO'              = cr_tipo        /* JCG10 */
	     from cob_conta..cb_conc_retencion
             where
               cr_empresa = @i_empresa and
               cr_codigo > @i_codigo 
	     order by cr_codigo, cr_debcred

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

/* SYR 20/Nov/1997  esto para cuando el asiento sea debito */

if @i_operacion = 'B'
begin
        set rowcount 20
	if @i_modo = 0
	begin
	     select 'CODIGO'  		= cr_codigo,
		    'DESCRIPCION'	= cr_descripcion,
		    'BASE' 		= cr_base,
		    'RETENCION'		= convert(money,cr_porcentaje)
	     from cob_conta..cb_conc_retencion
             where
               cr_debcred = @i_debcred and
               cr_tipo = @i_tipo and
               cr_empresa = @i_empresa
	     order by cr_codigo, cr_debcred

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
                    'CODIGO'  		= cr_codigo,
		    'DESCRIPCION'	= cr_descripcion,
		    'BASE' 		= cr_base,
		    'RETENCION'		= convert(money,cr_porcentaje)
	     from cob_conta..cb_conc_retencion
             where
               cr_debcred = @i_debcred and
               cr_tipo = @i_tipo and
               cr_empresa = @i_empresa and
               cr_codigo > @i_codigo 
	     order by cr_codigo, cr_debcred

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

if @i_operacion = 'C'
begin
        set rowcount 20

	if @i_modo = 0
	begin
	     select 'CODIGO'  		= cr_codigo,
		    'DESCRIPCION'	= cr_descripcion
	     from cob_conta..cb_conc_retencion
             where
               cr_tipo = @i_tipo and
               cr_debcred = @i_debcred and
               cr_empresa = @i_empresa
	     order by cr_codigo

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
                    'CODIGO'  		= cr_codigo,
		    'DESCRIPCION'	= cr_descripcion
	     from cob_conta..cb_conc_retencion
             where
               cr_tipo = @i_tipo and
               cr_debcred = @i_debcred and
               cr_empresa = @i_empresa and
               cr_codigo > @i_codigo 
	     order by cr_codigo

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

if @i_operacion = 'Z'
begin
        set rowcount 20
	if @i_modo = 0
	begin
	     select 'CODIGO'  		= cr_codigo,
		    'DESCRIPCION'	= cr_descripcion,
		    'BASE' 		= cr_base,
		    'RETENCION'		= convert(money,cr_porcentaje)
	     from cob_conta..cb_conc_retencion, cb_cuenta_proceso
             where
               cr_debcred = @i_debcred and
               cr_tipo = @i_tipo and
               cr_empresa = @i_empresa and
	       cr_empresa = cp_empresa and
	       cp_proceso = 6004 and
 	       cp_cuenta = @i_cuenta and
	       cr_codigo = cp_condicion
	     order by cr_codigo, cr_debcred

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
                    'CODIGO'  		= cr_codigo,
		    'DESCRIPCION'	= cr_descripcion,
		    'BASE' 		= cr_base,
		    'RETENCION'		= convert(money,cr_porcentaje)
	     from cob_conta..cb_conc_retencion, cb_cuenta_proceso
             where
               cr_debcred = @i_debcred and
               cr_tipo = @i_tipo and
               cr_empresa = @i_empresa and
               cr_codigo > @i_codigo and
	       cr_empresa = cp_empresa and
	       cp_proceso = 6004 and
 	       cp_cuenta = @i_cuenta and
	       cr_codigo = cp_condicion
	     order by cr_codigo, cr_debcred

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
