/************************************************************************/
/*	Archivo: 		ivapagado.sp  				*/
/*	Stored procedure: 	sp_iva_pagado				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Fernando Salgado/Sandra Robayo   	*/
/*	Fecha de escritura:     23-febrero-1998				*/
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
/*	   Mantenimiento de la tabla cb_iva_pagado			*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		           RAZON		*/
/*	23/Feb/1998	F.Salgado/Sandra Robayo	Emision Inicial		*/
/*									*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_iva_pagado')
    drop proc sp_iva_pagado

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_iva_pagado (
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
   @i_empresa		 tinyint = null,
   @i_codigo             char(4) = null,
   @i_descripcion        varchar(150) = null,
   @i_base               money = 0,
   @i_porcentaje         float = 0,
   @i_cuenta		 cuenta = null,
   @i_debcred		 char(1) = null	
)
as

declare
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,        /* existe el registro*/
   @w_descontado	 char(1),
   @w_des_porcen	 float,
   @w_retencion  	 float,
   @w_empresa		 tinyint,     
   @w_codigo             char(4),
   @w_descripcion        varchar(150),
   @w_flag               char(2),    /* Indica que no hay mas registros */
   @w_base               money,
   @w_debcred		 char(1),      
   @w_debito             money,
   @w_credito            money


select @w_sp_name = 'sp_iva_pagado'
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
    		i_empresa		   = @i_empresa,   
		i_codigo                   = @i_codigo,
                i_descripcion              = @i_descripcion,
                i_base                     = @i_base,
                i_porcentaje               = @i_porcentaje,
		i_descontado		   = @i_descontado,
		i_des_porcen		   = @i_des_porcen,
		i_debcred		   = @i_debcred    

	exec cobis..sp_end_debug
end

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 6293 and @i_operacion = 'I') or /* Insercion */
   (@t_trn <> 6294 and @i_operacion = 'U') or /* Update */
   (@t_trn <> 6288 and @i_operacion = 'D') or /* Eliminacion */
   (@t_trn <> 6289 and @i_operacion = 'Q') or /* Busqueda uno */
   (@t_trn <> 6290 and @i_operacion = 'A') or /* Search */
   (@t_trn <> 6292 and @i_operacion = 'B')    /* Search param. iva */

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

    select @w_empresa = ip_empresa,     
	   @w_codigo = ip_codigo,
           @w_descripcion = ip_descripcion,
           @w_retencion = ip_porcentaje,
	   @w_debcred = ip_debcred     
    from cob_conta..cb_iva_pagado
    where ip_empresa = @i_empresa and   
          ip_codigo = @i_codigo and
          ip_debcred = @i_debcred

    if @@rowcount = 0
            select @w_existe = 0
    else
            select @w_existe = 1
end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U'
begin
    if   @i_empresa is NULL or      
         @i_codigo  is NULL or
         @i_descripcion is NULL or
         @i_porcentaje  is NULL or
	 @i_debcred is NULL 	   
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
         insert into cb_iva_pagado(
   	      ip_empresa,      
	      ip_codigo,
              ip_descripcion,
              ip_porcentaje,
              ip_debcred,
              ip_base)
         values (
              @i_empresa,      
              @i_codigo,
              @i_descripcion,
              @i_porcentaje,
	      @i_debcred,
	      @i_base)   

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

         insert into ts_concivapagado    
         values (@i_empresa,@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
	 @i_codigo,
         @i_descripcion,
         @i_porcentaje,
	 @i_debcred)		

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
         update cob_conta..cb_iva_pagado
	    set ip_empresa = @i_empresa,     
		ip_codigo = @i_codigo,
                ip_descripcion = @i_descripcion,
                ip_porcentaje = @i_porcentaje,
                ip_debcred = @i_debcred,
                ip_base = @i_base
         where  ip_empresa = @i_empresa and   
		ip_codigo = @i_codigo and
                ip_debcred = @i_debcred

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

         insert into ts_concivapagado   
         values (@i_empresa,@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
 	 @w_codigo,
         @w_descripcion,
         @w_retencion, 
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
            

         /* Transaccion de Servicio */
         /***************************/

         insert into ts_concivapagado    
         values (@i_empresa,@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,
 	 @i_codigo,
         @i_descripcion,
         @i_porcentaje, 
	 @i_debcred)		

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
         delete cob_conta..cb_iva_pagado
    where  ip_empresa = @i_empresa and    
	   ip_codigo = @i_codigo and
           ip_debcred = @i_debcred
                            
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

         insert into ts_concivapagado   
         values (@i_empresa, @s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
 	 @w_codigo,
         @w_descripcion,
         @w_retencion, 
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
	     select 'CODIGO'            = ip_codigo,
                    'DESCRIPCION'       = ip_descripcion,
                    'RETENCION'         = convert(money,ip_porcentaje),
		    'DEB/CRED'          = ip_debcred,
		    'BASE'		= isnull(ip_base,0)
	     from cob_conta..cb_iva_pagado
             where
               ip_empresa = @i_empresa
	     order by ip_codigo, ip_debcred

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
	     select 'CODIGO'            = ip_codigo,
                    'DESCRIPCION'       = ip_descripcion,
                    'RETENCION'         = convert(money,ip_porcentaje),
		    'DEB/CRED'          = ip_debcred,
		    'BASE'		= isnull(ip_base,0)
	     from cob_conta..cb_iva_pagado
             where ip_codigo > @i_codigo and
                   ip_empresa = @i_empresa
	     order by ip_codigo, ip_debcred

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
        set rowcount 20

	if @i_modo = 0
	begin
	     select 'CODIGO'            = ip_codigo,
                    'DESCRIPCION'       = ip_descripcion,
                    'RETENCION'         = convert(money,ip_porcentaje),
                    'BASE'		= isnull(ip_base,0)
	     from cob_conta..cb_iva_pagado, cb_cuenta_proceso
             where
                ip_debcred = @i_debcred and
                ip_empresa = @i_empresa and
		cp_empresa = @i_empresa and
		cp_cuenta like (@i_cuenta + '%') and
		cp_proceso = 6004 and
		cp_condicion = ip_codigo
	     order by ip_codigo, ip_debcred

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
	     select 'CODIGO'            = ip_codigo,
                    'DESCRIPCION'       = ip_descripcion,
                    'RETENCION'         = convert(money,ip_porcentaje),
                    'BASE'		= isnull(ip_base,0)
	     from cob_conta..cb_iva_pagado, cb_cuenta_proceso
             where ip_codigo > @i_codigo and
                   ip_empresa = @i_empresa and
                   ip_debcred = @i_debcred and
  		   cp_empresa = @i_empresa and
		   cp_cuenta like (@i_cuenta + '%') and
		   cp_proceso = 6004 and
		   cp_condicion = ip_codigo
	     order by ip_codigo, ip_debcred

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


if @i_operacion = 'Q'
begin

   if @w_existe = 1  
   begin
        select @w_codigo,
               @w_descripcion,
               @w_retencion 

   end
   else
   begin
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
end


go
