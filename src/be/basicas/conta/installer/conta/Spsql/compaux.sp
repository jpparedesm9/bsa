/************************************************************************/
/*	Archivo: 		compaux.sp			        */
/*	Stored procedure: 	sp_comprobante_aux       		*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     22-Feb-2000 				*/
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
/*      Consulta de comprobantes desde auxiliares de contabilidad.      */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	22/Feb/2000     Nancy P.P.G.    Emision Inicial			*/
/*	16/Jun/2005     Julio Quintero  Operaci¢n Consulta de Auxiliares*/
/*                                      En FrontEnd Consulta Estado Cta */
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_comprobante_aux')
	drop proc sp_comprobante_aux
go

create proc sp_comprobante_aux   (
	@s_ssn			int = null,
	@s_date			datetime = null,
	@s_user			login = null,
	@s_term			descripcion = null,
	@s_corr			char(1) = null,
	@s_ssn_corr		int = null,
	@s_ofi			smallint = null,
	@t_rty			char(1) = null,
	@t_trn			smallint = null,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(30) = null,
	@i_operacion		char(1) = null,
	@i_modo			smallint = null,
	@i_empresa 		tinyint = null,
	@i_fecha_tran		datetime = null,
	@i_comprobante 		int = null,
	@i_oficina              smallint = null,
	@i_formato_fecha 	tinyint = 1,
	@i_comprobante1 	int     = null,
	@i_msg          	tinyint = 0,
	@i_usuario     		login =null,
	@i_estado		char(1) = null,
	@i_cuenta		cuenta = null,
	@i_asiento              int = null,
	@i_producto             tinyint = null
)
as
declare
	@w_today 	char(12),  	/* fecha del dia               */
	@w_return	int,		/* valor que retorna           */
	@w_sp_name	varchar(32),	/* nombre del stored procedure */
	@w_siguiente	int,
        @w_numero       int,
	@w_comprobante 	int,
	@w_empresa	tinyint,
        @flag1		int,
	@w_operacion    int ,
	@wa_automatico	smallint,
	@w_automatico	smallint,
        @w_numerror     int,
        @w_descripcion  descripcion


select @w_sp_name = 'sp_comprobante_aux' , @w_numerror = 0


/************************************************/
/*  Tipo de Transaccion  			*/
if (@t_trn <> 6134 and @i_operacion = 'Q') or
   (@t_trn <> 6134 and @i_operacion = 'A') or
   (@t_trn <> 6134 and @i_operacion = 'O') or
   (@t_trn <> 6134 and @i_operacion = 'S') or
   (@t_trn <> 6134 and @i_operacion = 'R') or
   (@t_trn <> 6134 and @i_operacion = 'T')
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end
/************************************************/


if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_empresa	= @i_empresa,
		i_fecha_tran	= @i_fecha_tran,
		i_comprobante	= @i_comprobante
	exec cobis..sp_end_debug
end



/********* Query *******/
if @i_operacion = 'Q'
begin
        set rowcount 20
	if @i_modo = 0
	begin
		select 	sc_oficina_orig,
                        sc_area_orig,
			sc_comprobante,
                        substring(sc_descripcion,1,64),
			convert(char(12),sc_fecha_tran,@i_formato_fecha),
			sc_mayorizado,
			sc_tot_debito,
			sc_tot_credito,
                        sc_tot_debito_me,
                        sc_tot_credito_me,
		 	substring(of_descripcion,1,40),
			substring(ar_descripcion,1,40),
                        substring(sc_digitador,1,15),
			sc_estado,
			convert(char(12),sc_fecha_gra,@i_formato_fecha)
                from    cob_conta_tercero..ct_scomprobante,cob_conta..cb_oficina, cob_conta..cb_area
                where   sc_empresa = @i_empresa and
                        sc_producto = @i_producto and
                        sc_fecha_tran = @i_fecha_tran and
                        sc_comprobante = @i_comprobante and
                        of_empresa = @i_empresa and
                        of_oficina = sc_oficina_orig and
                        ar_empresa = @i_empresa and
                        ar_area = sc_area_orig
		if @@rowcount = 0
		begin	/* 'Comprobante consultado no existe'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601061
			return 1
		end
		select  sa_oficina_dest,
                        sa_area_dest,
                        sa_cuenta,
			sa_debito,
                        sa_credito,
                        sa_debito_me,
			sa_credito_me,
                        substring(sa_concepto,1,60),
                        sa_moneda
                from cob_conta_tercero..ct_sasiento
		where 	sa_empresa = @i_empresa and
                        sa_producto = @i_producto and
                        sa_fecha_tran = @i_fecha_tran and
			sa_comprobante = @i_comprobante
                order by sa_asiento
	end
	else
	begin
               select   sa_oficina_dest,
                        sa_area_dest,
                        sa_cuenta,
			sa_debito,
                        sa_credito,
                        sa_debito_me,
			sa_credito_me,
                        substring(sa_concepto,1,60),
                        sa_moneda
                from cob_conta_tercero..ct_sasiento
		where 	sa_empresa = @i_empresa and
                        sa_producto =  @i_producto and
                        sa_fecha_tran = @i_fecha_tran and
			sa_comprobante = @i_comprobante and
                        sa_asiento > @i_asiento
	        order by sa_asiento
		if @@rowcount = 0
		begin	/* 'Comprobante consultado no existe'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601150
			return 1
		end
	end
	return 0
end


if @i_operacion = 'A'
begin
        set rowcount 20
        if @i_modo = 0
          begin
	     select 'ASIENTO'		= sa_asiento,
		    'CUENTA' 		= sa_cuenta,
		    'IDENTIFICACION'	= en_ced_ruc,
		    'TIPO ID'  		= en_tipo_ced,
		    'CONCEPTO'		= sa_con_rete,
                    'CONCEPTO IVA'      = sa_con_iva,
                    'CONCEPTO ICA'      = sa_con_ica,
                    'CONCEPTO TIMBRE'   = sa_con_timbre,
		    'BASE'		= sa_base,
                    'VALOR DEBITO'      = sa_debito,
                    'VALOR CREDITO.'    = sa_credito,
                    'IVA CALCULADO'     = sa_iva_retenido,
                    'VALOR IVAPAGADO'   = sa_valor_ivapagado,
                    'ICA PAGADO'        = 0,
		    'RETENCION'		= sa_valret,
                    'VALOR IVA'         = sa_valor_iva,
                    'VALOR ICA'         = sa_valor_ica,
                    'VALOR TIMBRE'      = sa_valor_timbre,
                    'CONCEPTO PAGADO'   = sa_con_ivapagado,
                    'CALCULADO PAGADO'  = 0,
                    'VALOR PAGADO'      = sa_valor_ivapagado,
		    'ENTE'      	= sa_ente,
                    'DOCUMENTO'         = sa_documento
                from cob_conta_tercero..ct_sasiento, cobis..cl_ente
		where 	sa_empresa = @i_empresa and
                        sa_producto = @i_producto and
                        sa_fecha_tran = @i_fecha_tran and
			sa_comprobante = @i_comprobante and
                        en_ente = sa_ente
                order by sa_asiento
             if @@rowcount = 0
    	        begin	/*No existen registros */
                    exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 609125
                set rowcount 0
                return 1
             end
             set rowcount 0
             return 0
	end
	else
	begin
             select 'ASIENTO'		= sa_asiento,
		    'CUENTA' 		= sa_cuenta,
		    'IDENTIFICACION'	= en_ced_ruc,
		    'TIPO ID'  		= en_tipo_ced,
		    'CONCEPTO'		= sa_con_rete,
                    'CONCEPTO IVA'      = sa_con_iva,
                    'CONCEPTO ICA'      = sa_con_ica,
                    'CONCEPTO TIMBRE'   = sa_con_timbre,
		    'BASE'		= sa_base,
                    'VALOR DEBITO'      = sa_debito,
                    'VALOR CREDITO.'    = sa_credito,
                    'IVA CALCULADO'     = sa_iva_retenido,
                    'VALOR IVAPAGADO'   = sa_valor_ivapagado,
                    'ICA PAGADO'        = 0,
		    'RETENCION'		= sa_valret,
                    'VALOR IVA'         = sa_valor_iva,
                    'VALOR ICA'         = sa_valor_ica,
                    'VALOR TIMBRE'      = sa_valor_timbre,
                    'CONCEPTO PAGADO'   = sa_con_ivapagado,
                    'CALCULADO PAGADO'  = 0,
                    'VALOR PAGADO'      = sa_valor_ivapagado,
		    'ENTE'      	= sa_ente,
                    'DOCUMENTO'         = sa_documento
                from cob_conta_tercero..ct_sasiento, cobis..cl_ente
		where 	sa_empresa = @i_empresa and
                        sa_producto = @i_producto and
                        sa_fecha_tran = @i_fecha_tran and
			sa_comprobante = @i_comprobante and
                        sa_asiento > @i_asiento and
                        en_ente = sa_ente
                  order by sa_asiento
                   if @@rowcount = 0
    	           begin
                    /*No existen registros */
                      exec cobis..sp_cerror
                      @t_debug = @t_debug,
                      @t_file  = @t_file,
                      @t_from  = @w_sp_name,
                      @i_num   = 609125
                      set rowcount 0
                      return 1
                   end
             set rowcount 0
             return 0
        end
end

-- OPERACION DE CONSULTA DESCRIPCION OFICINA ORIGEN
IF @i_operacion = 'O'
BEGIN
   SELECT @w_descripcion = of_descripcion
   FROM   cob_conta..cb_oficina
   WHERE  of_empresa = 1
   and    of_oficina = @i_oficina

   IF @@rowcount = 0
   BEGIN
      -- NO EXISTE OFICINA
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 141035
      return 1
   END
  
   select @w_descripcion

END

-- OPERACION DE CONSULTA COMPROBANTES AUXILIARES
IF @i_operacion = 'S'
BEGIN
  SET ROWCOUNT 20
  IF @i_modo = 0
  BEGIN
    SELECT 'Oficina Origen     ' = sc_oficina_orig,      -- 1
           'Producto           ' = sc_producto,          
           'Comprobante        ' = sc_comprobante,
           'Area Or¡gen        ' = sc_area_orig,
           'Digitador          ' = sc_digitador,         
           'Fecha Grabaci¢n    ' = convert(varchar(10),sc_fecha_gra,101), -- 6
           'Descripci¢n        ' = sc_descripcion,
           'Perfil             ' = sc_perfil,
           'Estado             ' = sc_estado,
           'Valor D‚bito M.N.  ' = sc_tot_debito,        
           'Valor Cr‚dito M.N. ' = sc_tot_credito,      -- 11
           'Valor D‚bito M.E.  ' = sc_tot_debito_me,
           'Valor Cr‚dito M.E. ' = sc_tot_credito_me,
           'Usuario M¢dulo     ' = sc_usuario_modulo,
           'Transacci¢n M¢dulo ' = sc_tran_modulo       -- 15
    FROM   cob_conta_tercero..ct_scomprobante
    WHERE  sc_fecha_tran     = @i_fecha_tran
    AND    sc_producto       > 0	
    AND    sc_comprobante    > 0
    AND    sc_empresa        = @i_empresa
    AND    sc_comp_definit   = @i_comprobante
    ORDER  BY sc_comprobante

    IF @@rowcount = 0
    BEGIN
       -- NO EXISTEN REGISTROS PARA LA CONSULTA DADA
       exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 601153
       return 1
    END
    SET ROWCOUNT 0
  END

  IF @i_modo = 1
  BEGIN
    SELECT 'Oficina Origen     ' = sc_oficina_orig,      -- 1
           'Producto           ' = sc_producto,          
           'Comprobante        ' = sc_comprobante,
           'Area Or¡gen        ' = sc_area_orig,
           'Digitador          ' = sc_digitador,         
           'Fecha Grabaci¢n    ' = convert(varchar(10),sc_fecha_gra,101), -- 6
           'Descripci¢n        ' = sc_descripcion,
           'Perfil             ' = sc_perfil,
           'Estado             ' = sc_estado,
           'Valor D‚bito M.N.  ' = sc_tot_debito,        
           'Valor Cr‚dito M.N. ' = sc_tot_credito,      -- 11
           'Valor D‚bito M.E.  ' = sc_tot_debito_me,
           'Valor Cr‚dito M.E. ' = sc_tot_credito_me,
           'Usuario M¢dulo     ' = sc_usuario_modulo,
           'Transacci¢n M¢dulo ' = sc_tran_modulo       -- 15
    FROM   cob_conta_tercero..ct_scomprobante
    WHERE  sc_fecha_tran     = @i_fecha_tran
    AND    sc_producto       > 0	
    AND    sc_comprobante    > @i_comprobante1
    AND    sc_empresa        = @i_empresa
    AND    sc_comp_definit   = @i_comprobante

    IF @@rowcount = 0
    BEGIN
       -- NO EXISTEN MAS REGISTROS
       exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 601150
       return 1
    END
    SET ROWCOUNT 0

  END

END

if @i_operacion = 'R'
begin
        set rowcount 20
	if @i_modo = 0
	begin
		select 	sc_oficina_orig,
                        sc_area_orig,
			sc_comprobante,
                        substring(sc_descripcion,1,64),
			convert(char(12),sc_fecha_tran,@i_formato_fecha),
			sc_mayorizado,
			sc_tot_debito,
			sc_tot_credito,
                        sc_tot_debito_me,
                        sc_tot_credito_me,
		 	substring(of_descripcion,1,40),
			substring(ar_descripcion,1,40),
                        substring(sc_digitador,1,15),
			sc_estado,
			convert(char(12),sc_fecha_gra,@i_formato_fecha)
                from    cob_conta_historico..ct_scomprobante,cob_conta..cb_oficina, cob_conta..cb_area
                where   sc_empresa = @i_empresa and
                        sc_producto = @i_producto and
                        sc_fecha_tran = @i_fecha_tran and
                        sc_comprobante = @i_comprobante and
                        of_empresa = @i_empresa and
                        of_oficina = sc_oficina_orig and
                        ar_empresa = @i_empresa and
                        ar_area = sc_area_orig
		if @@rowcount = 0
		begin	/* 'Comprobante consultado no existe'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601061
			return 1
		end
		select  sa_oficina_dest,
                        sa_area_dest,
                        sa_cuenta,
			sa_debito,
                        sa_credito,
                        sa_debito_me,
			sa_credito_me,
                        substring(sa_concepto,1,60),
                        sa_moneda
                from cob_conta_historico..ct_sasiento
		where 	sa_empresa = @i_empresa and
                        sa_producto = @i_producto and
                        sa_fecha_tran = @i_fecha_tran and
			sa_comprobante = @i_comprobante
                order by sa_asiento
	end
	else
	begin
               select   sa_oficina_dest,
                        sa_area_dest,
                        sa_cuenta,
			sa_debito,
                        sa_credito,
                        sa_debito_me,
			sa_credito_me,
                        substring(sa_concepto,1,60),
                        sa_moneda
                from cob_conta_historico..ct_sasiento
		where 	sa_empresa = @i_empresa and
                        sa_producto =  @i_producto and
                        sa_fecha_tran = @i_fecha_tran and
			sa_comprobante = @i_comprobante and
                        sa_asiento > @i_asiento
	        order by sa_asiento
		if @@rowcount = 0
		begin	/* 'Comprobante consultado no existe'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601150
			return 1
		end
	end
	return 0
end


if @i_operacion = 'T'
begin
        set rowcount 20
        if @i_modo = 0
          begin
	     select 'ASIENTO'		= sa_asiento,
		    'CUENTA' 		= sa_cuenta,
		    'IDENTIFICACION'	= en_ced_ruc,
		    'TIPO ID'  		= en_tipo_ced,
		    'CONCEPTO'		= sa_con_rete,
                    'CONCEPTO IVA'      = sa_con_iva,
                    'CONCEPTO ICA'      = sa_con_ica,
                    'CONCEPTO TIMBRE'   = sa_con_timbre,
		    'BASE'		= sa_base,
                    'VALOR DEBITO'      = sa_debito,
                    'VALOR CREDITO.'    = sa_credito,
                    'IVA CALCULADO'     = sa_iva_retenido,
                    'VALOR IVAPAGADO'   = sa_valor_ivapagado,
                    'ICA PAGADO'        = 0,
		    'RETENCION'		= sa_valret,
                    'VALOR IVA'         = sa_valor_iva,
                    'VALOR ICA'         = sa_valor_ica,
                    'VALOR TIMBRE'      = sa_valor_timbre,
                    'CONCEPTO PAGADO'   = sa_con_ivapagado,
                    'CALCULADO PAGADO'  = 0,
                    'VALOR PAGADO'      = sa_valor_ivapagado,
		    'ENTE'      	= sa_ente,
                    'DOCUMENTO'         = sa_documento
                from cob_conta_historico..ct_sasiento, cobis..cl_ente
		where 	sa_empresa = @i_empresa and
                        sa_producto = @i_producto and
                        sa_fecha_tran = @i_fecha_tran and
			sa_comprobante = @i_comprobante and
                        en_ente = sa_ente
                order by sa_asiento
             if @@rowcount = 0
    	        begin	/*No existen registros */
                    exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 609125
                set rowcount 0
                return 1
             end
             set rowcount 0
             return 0
	end
	else
	begin
             select 'ASIENTO'		= sa_asiento,
		    'CUENTA' 		= sa_cuenta,
		    'IDENTIFICACION'	= en_ced_ruc,
		    'TIPO ID'  		= en_tipo_ced,
		    'CONCEPTO'		= sa_con_rete,
                    'CONCEPTO IVA'      = sa_con_iva,
                    'CONCEPTO ICA'      = sa_con_ica,
                    'CONCEPTO TIMBRE'   = sa_con_timbre,
		    'BASE'		= sa_base,
                    'VALOR DEBITO'      = sa_debito,
                    'VALOR CREDITO.'    = sa_credito,
                    'IVA CALCULADO'     = sa_iva_retenido,
                    'VALOR IVAPAGADO'   = sa_valor_ivapagado,
                    'ICA PAGADO'        = 0,
		    'RETENCION'		= sa_valret,
                    'VALOR IVA'         = sa_valor_iva,
                    'VALOR ICA'         = sa_valor_ica,
                    'VALOR TIMBRE'      = sa_valor_timbre,
                    'CONCEPTO PAGADO'   = sa_con_ivapagado,
                    'CALCULADO PAGADO'  = 0,
                    'VALOR PAGADO'      = sa_valor_ivapagado,
		    'ENTE'      	= sa_ente,
                    'DOCUMENTO'         = sa_documento
                from cob_conta_historico..ct_sasiento, cobis..cl_ente
		where 	sa_empresa = @i_empresa and
                        sa_producto = @i_producto and
                        sa_fecha_tran = @i_fecha_tran and
			sa_comprobante = @i_comprobante and
                        sa_asiento > @i_asiento and
                        en_ente = sa_ente
                  order by sa_asiento
                   if @@rowcount = 0
    	           begin
                    /*No existen registros */
                      exec cobis..sp_cerror
                      @t_debug = @t_debug,
                      @t_file  = @t_file,
                      @t_from  = @w_sp_name,
                      @i_num   = 609125
                      set rowcount 0
                      return 1
                   end
             set rowcount 0
             return 0
        end
end
go


RETURN	
go

