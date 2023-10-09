/************************************************************************/
/*	Archivo: 		iva.sp  				*/
/*	Stored procedure: 	sp_iva					*/
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
/*	   Mantenimiento de la tabla cb_iva				*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	02/Abr/1997	F.Salgado	Emision Inicial			*/
/*      20/Nov/1997     Sandra Robayo   Insercion operacion B           */
/*	01/Dic/1997     Juan Carlos Gomez Modificacion en operacion 'A' */
/*	02/Dic/1997	Juan Carlos Gomez Modificacion de longitud de   */
/*				          @i_codigo de 2 a 4		*/
/*	12/Dic/1997	Juan Carlos Gomez Ingreso de nuevos parametros	*/
/*			JCG10						*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_iva')
    drop proc sp_iva
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_iva (
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
   @i_descontado	 char(1) = null, 
   @i_des_porcen	 float = 0,
   @i_empresa		 tinyint = null,   /* JCG10 */
   @i_codigo             char(4) = null,
   @i_descripcion        varchar(150) = null,
   @i_base               money = 0,
   @i_cuenta             cuenta = null,
   @i_porcentaje         float = 0,
   @i_debcred		 char(1) = null,
   @i_porc_espec         float   = 0     /* JCG10 */
)
as

declare
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,        /* existe el registro*/
   @w_descontado	 char(1),
   @w_des_porcen	 float,
   @w_retencion  	 float,
   @w_empresa		 tinyint,     /* JCG10 */
   @w_codigo             char(4),
   @w_descripcion        varchar(150),
   @w_flag               char(2),    /* Indica que no hay mas registros */
   @w_base               money,
   @w_debcred		 char(1),      /* JCG10 */
   @w_debito             money,
   @w_credito            money,
   @w_condicion          char(4),
   @w_porc_espec         float 


select @w_sp_name = 'sp_iva'
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
    		i_empresa		   = @i_empresa,   /* JCG10 */
		i_codigo                   = @i_codigo,
                i_descripcion              = @i_descripcion,
                i_base                     = @i_base,
                i_porcentaje               = @i_porcentaje,
		i_descontado		   = @i_descontado,
		i_des_porcen		   = @i_des_porcen,
		i_debcred		   = @i_debcred,
                i_porc_espec               = @i_porc_espec    /* JCG10 */

	exec cobis..sp_end_debug
end

/***********************************************************/
/* Codigos de Transacciones                                */
/* SYR 13/11/1997  insercion transaccion Q y B */

if (@t_trn <> 6964 and @i_operacion = 'I') or /* Insercion */
   (@t_trn <> 6965 and @i_operacion = 'U') or /* Update */
   (@t_trn <> 6966 and @i_operacion = 'D') or /* Eliminacion */
   (@t_trn <> 6584 and @i_operacion = 'Q') or /* Busqueda uno */
   (@t_trn <> 6967 and @i_operacion = 'A') or /* Search */
   (@t_trn <> 6582 and @i_operacion = 'B') or /* Search param. iva */
   (@t_trn <> 6583 and @i_operacion = 'P')    /* Search param. iva en parametros*/

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
if @i_operacion <> 'A' AND @i_operacion <> 'B' AND @i_operacion <> 'P'
begin
/*  SYR 10/11/1997 no se utiliza descontado ni des_porcen */
/*    select 
           @w_codigo = iva_codigo,
           @w_descripcion = iva_descripcion,
           @w_base = iva_base,
           @w_retencion = iva_porcentaje,
	   @w_descontado = iva_descontado,
           @w_des_porcen = iva_des_porcen
    from cob_conta..cb_iva
    where 
         iva_codigo = @i_codigo */

    select @w_empresa = iva_empresa,    /* JCG10 */ 
	   @w_codigo = iva_codigo,
           @w_descripcion = iva_descripcion,
           @w_retencion = iva_porcentaje,
           @w_debcred = iva_debcred,     /* JCG10 */
           @w_des_porcen = iva_des_porcen,
           @w_porc_espec  = iva_porc_espec
    from cob_conta..cb_iva
    where iva_empresa = @i_empresa and  /* JCG10 */ 
          iva_codigo = @i_codigo and
          iva_debcred = @i_debcred

    if @@rowcount = 0
            select @w_existe = 0
    else
            select @w_existe = 1
end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U'
begin
    /*if 
         @i_codigo = NULL or
         @i_descripcion = NULL or
         @i_porcentaje = NULL or
         @i_base = NULL or*/

    if   @i_empresa is NULL or     /* JCG10 */ 
         @i_codigo  is NULL or
         @i_descripcion is NULL or
         @i_porcentaje  is NULL or
	 @i_debcred is NULL    or
         @i_porc_espec is NULL   /* JCG10 */ 
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
         insert into cb_iva(
   	      iva_empresa,      /* JCG10 */
	      iva_codigo,
              iva_descripcion,
              iva_base,
              iva_porcentaje,
	      iva_debcred,
              iva_des_porcen,
              iva_porc_espec)      /* JCG10 */

	      /*iva_descontado,
	      iva_des_porcen)*/
         values (
              @i_empresa,       /* JCG10 */
              @i_codigo,
              @i_descripcion,
              @i_base,
              @i_porcentaje,
	      @i_debcred,
              @i_des_porcen,
              @i_porc_espec)        /* JCG10 */

	      /*@i_descontado,
	      @i_des_porcen)*/ 

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

         insert into ts_conciva    
         values (@i_empresa,@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
	 @i_codigo,
         @i_descripcion,
         @i_base,
         @i_porcentaje,
	 @i_descontado,
	 @i_des_porcen,
	 @i_debcred,
         @i_porc_espec)	  	/* JCG10 */

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
         update cob_conta..cb_iva
	    set iva_empresa = @i_empresa,    /* JCG10 */ 
		iva_codigo = @i_codigo,
                iva_descripcion = @i_descripcion,
                iva_base = @i_base,
                iva_porcentaje = @i_porcentaje,
                iva_debcred = @i_debcred,
		iva_des_porcen = @i_des_porcen,
                iva_porc_espec = @i_porc_espec
		/* iva_descontado = @i_descontado, */
         where  iva_empresa = @i_empresa and  /* JCG10 */ 
		iva_codigo = @i_codigo and
                iva_debcred = @i_debcred

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

         insert into ts_conciva   
         values (@i_empresa,@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
 	 @w_codigo,
         @w_descripcion,
         @w_base,
         @w_retencion, 
	 @w_descontado,
	 @w_des_porcen,
	 @w_debcred,
         @w_porc_espec)  		/* JCG10 */

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

         insert into ts_conciva    
         values (@i_empresa,@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,
 	 @i_codigo,
         @i_descripcion,
         @i_base,
         @i_porcentaje, 
	 @i_descontado,
	 @i_des_porcen,
	 @i_debcred,
         @i_porc_espec) 		/* JCG10 */

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

   /**** Integridad referencial  ***/

    declare cursor_conceptos cursor for 
    select as_debito, as_credito
    from cb_retencion, cb_asiento
    where re_con_iva = @i_codigo and
          as_comprobante = re_comprobante and
          as_empresa = re_empresa and
          re_empresa = @i_empresa and
          re_asiento = as_asiento
         
    open cursor_conceptos


    fetch cursor_conceptos into @w_debito, @w_credito 

    while @@fetch_status = 0
    begin
      /*verificar que corresponda a la naturaleza  */

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
	delete cob_conta..cb_iva
	where iva_empresa = @i_empresa and   /* JCG10 */ 
	iva_codigo = @i_codigo and
	iva_debcred = @i_debcred
	if @@error <> 0
	begin	/*Error en eliminacion de registro */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file, 
		@t_from  = @w_sp_name,
		@i_num   = 607022
		return 1 
	end

	if exists (select 1 from cb_exencion_ciudad
		where ec_empresa = @i_empresa
		and ec_impuesto = "I"
		and ec_concepto = @i_codigo
		and ec_debcred = @i_debcred
		and ec_ciudad > 0)
	begin
		delete cb_exencion_ciudad
		where ec_empresa = @i_empresa
		and ec_impuesto = "I"
		and ec_concepto = @i_codigo
		and ec_debcred = @i_debcred
		and ec_ciudad > 0
		if @@error <> 0
		begin
			/* 'Error en eliminacion de ciudad' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 107019
			return 1
		end
	end

	/* Transaccion de Servicio */
	/***************************/
	insert into ts_conciva   
        values (@i_empresa, @s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
	@w_codigo,@w_descripcion,@w_base,
        @w_retencion, @w_descontado,@w_des_porcen,@w_debcred,@w_porc_espec)  
	if @@error <> 0 
	begin	/* Error en insercion de transaccion de servicio */
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
	     select 'CODIGO'            = iva_codigo,
                    'DESCRIPCION'       = iva_descripcion,
                    'BASE'              = isnull(iva_base,0),
                    'RETENCION'         = convert(money,iva_porcentaje),
		    'DEB/CRED'          = iva_debcred,   /* JCG10 */
		    /* 'DESCONTADO'	= iva_descontado, */
		    --'PORCENTAJE DESC'   = iva_des_porcen 
                     'IVA'   = iva_des_porcen,
                     'PORCENTAJE ESPEC'  = iva_porc_espec
	     from cob_conta..cb_iva
             where
               iva_empresa = @i_empresa
	     order by iva_codigo, iva_debcred

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
	     select 'CODIGO'            = iva_codigo,
                    'DESCRIPCION'       = iva_descripcion,
                    'BASE'              = isnull(iva_base,0),
                    'RETENCION'         = convert(money,iva_porcentaje),
		    'DEB/CRED'          = iva_debcred,   /* JCG10 */
		    /* 'DESCONTADO'	= iva_descontado,*/
--		    'PORCENTAJE DESC'   = iva_des_porcen 
		    'IVA'   = iva_des_porcen,
                    'PORCENTAJE ESPEC'  = iva_porc_espec         
	     from cob_conta..cb_iva
             where iva_codigo > @i_codigo and
                   iva_empresa = @i_empresa
	     order by iva_codigo, iva_debcred

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
end    

if @i_operacion = 'B'
begin

	select @w_condicion = cp_condicion
	from cob_conta..cb_cuenta_proceso
	where cp_empresa = @i_empresa
	and   cp_proceso = 6095
        and   @i_cuenta like rtrim(cp_cuenta) + '%'

        set rowcount 20
	if @w_condicion = 'V'
	begin
	if @i_modo = 0
	begin
	     select 'CODIGO'            = iva_codigo,
                    'DESCRIPCION'       = iva_descripcion,
                    'BASE'              = isnull(iva_base,0),
                    'RETENCION'         = convert(money,iva_des_porcen)
		    /* 'DESCONTADO'	= iva_descontado,
		    'PORCENTAJE DESC'   = iva_des_porcen */
	     from cob_conta..cb_iva, cb_cuenta_proceso
             where
                iva_debcred = @i_debcred and
                iva_empresa = @i_empresa and 
		cp_empresa = @i_empresa and
		rtrim(cp_cuenta) like (rtrim(@i_cuenta) + '%') and
		cp_proceso = 6004 and
		cp_condicion = iva_codigo
	     order by iva_codigo, iva_debcred

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
	     select 'CODIGO'            = iva_codigo,
                    'DESCRIPCION'       = iva_descripcion,
                    'BASE'              = isnull(iva_base,0),
                    'RETENCION'         = convert(money,iva_des_porcen)
		    /* 'DESCONTADO'	= iva_descontado,
		    'PORCENTAJE DESC'   = iva_des_porcen */
	     from cob_conta..cb_iva, cb_cuenta_proceso
             where iva_codigo > @i_codigo and
                   iva_empresa = @i_empresa and
                   iva_debcred = @i_debcred and
    		   rtrim(cp_cuenta) like rtrim(@i_cuenta) + '%' and
		   cp_proceso = 6004 and
		   cp_condicion = iva_codigo
	     order by iva_codigo, iva_debcred

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

	end
	if @w_condicion = 'I'
	begin
	if @i_modo = 0
	begin
	     select 'CODIGO'            = iva_codigo,
                    'DESCRIPCION'       = iva_descripcion,
                    'BASE'              = isnull(iva_base,0),
                    'RETENCION'         = convert(money,iva_porcentaje)
		    /* 'DESCONTADO'	= iva_descontado,
		    'PORCENTAJE DESC'   = iva_des_porcen */
	     from cob_conta..cb_iva, cb_cuenta_proceso
             where
                iva_debcred = @i_debcred and
                iva_empresa = @i_empresa and 
		cp_empresa = @i_empresa and
		rtrim(cp_cuenta) like (rtrim(@i_cuenta) + '%') and
		cp_proceso = 6004 and
		cp_condicion = iva_codigo
	     order by iva_codigo, iva_debcred

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
	     select 'CODIGO'            = iva_codigo,
                    'DESCRIPCION'       = iva_descripcion,
                    'BASE'              = isnull(iva_base,0),
                    'RETENCION'         = convert(money,iva_porcentaje)
		    /* 'DESCONTADO'	= iva_descontado,
		    'PORCENTAJE DESC'   = iva_des_porcen */
	     from cob_conta..cb_iva, cb_cuenta_proceso
             where iva_codigo > @i_codigo and
                   iva_empresa = @i_empresa and
                   iva_debcred = @i_debcred and
    		   rtrim(cp_cuenta) like rtrim(@i_cuenta) + '%' and
		   cp_proceso = 6004 and
		   cp_condicion = iva_codigo
	     order by iva_codigo, iva_debcred

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

	end

end    

if @i_operacion = 'P'
begin
	     select pa_tinyint
	     from cobis..cl_parametro
             where
             pa_nemonico = 'IVA'

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
	
	return 0

end   

if @i_operacion = 'Q'
begin

--   if @w_existe = 1  
--  begin
--        select @w_codigo,
--               @w_descripcion,
--               @w_retencion,
--               @w_des_porcen 
--
--   end
--   else-
--   begin
     select @w_codigo = iva_codigo,
            @w_descripcion = iva_descripcion,
	    @w_retencion = convert(money,iva_porcentaje),
	    @w_des_porcen = iva_des_porcen
	     from cob_conta..cb_iva, cb_cuenta_proceso
             where
                iva_debcred = @i_debcred and
                iva_empresa = @i_empresa and 
		cp_empresa = @i_empresa and
		rtrim(cp_cuenta) like (rtrim(@i_cuenta) + '%') and
		cp_proceso = 6004 and
		cp_condicion = iva_codigo
		and iva_codigo = @i_codigo
	     order by iva_codigo, iva_debcred

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
        select @w_codigo,
               @w_descripcion,
               @w_retencion,
               @w_des_porcen 
	
	return 0
--   end
end 


go
