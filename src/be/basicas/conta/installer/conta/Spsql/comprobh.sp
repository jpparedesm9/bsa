/************************************************************************/
/*   Archivo:                   comprobh.sp                             */
/*   Stored procedure:          sp_comprobante                          */
/*   Base de datos:             cob_conta                               */
/*   Producto:                  contabilidad                            */
/*   Disenado por:                                                      */
/*   Fecha de escritura:        30-julio-1993                           */
/************************************************************************/
/*                      IMPORTANTE                                      */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   "MACOSA", representantes exclusivos para el Ecuador de la          */
/*   "NCR CORPORATION".                                                 */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/*                        PROPOSITO                                     */
/*  Este programa procesa las transacciones de:                         */
/*  copia desde las tablas temporales de comprobantes y asientos        */
/*  a las tablas definitivas, Mayorizacion de los asientos              */
/*                       MODIFICACIONES                                 */
/*   FECHA          AUTOR           RAZON                               */
/*   30/Jul/1993    G Jaramillo     Emision Inicial                     */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_comprobanteh')
	drop proc sp_comprobanteh
go
create proc sp_comprobanteh   (
   @s_ssn			    int = null,
   @s_date			    datetime = null,
   @s_user			    login = null,
   @s_term			    descripcion = null,
   @s_corr			    char(1) = null,
   @s_ssn_corr		    int = null,
   @s_ofi			    smallint = null,
   @t_rty			    char(1) = null,
   @t_trn			    smallint = null,
   @t_debug		    char(1) = 'N',
   @t_file			    varchar(14) = null,
   @t_from			    varchar(30) = null,
   @i_operacion		char(1) = null,
   @i_modo			    smallint = null,
   @i_empresa 		    tinyint = null, 
   @i_fecha_tran		datetime = null,
   @i_comprobante 		int = null, 
   @i_oficina          smallint = null,
   @i_mayorizar		char(1) = null,
   @i_asiento		    smallint = null,
   @i_detalles		    smallint = null,
   @i_tot_debito		money = null,
   @i_tot_credito  	money = null,
   @i_tot_debito_me 	money = null,
   @i_tot_credito_me 	money = null,
   @i_formato_fecha 	tinyint = 1,
   @i_autorizado   	char(1) = null,
   @i_autorizante 		descripcion = null,
   @i_anula		    char(2) = null ,	
   @i_mayorizado   	char(1) = 'N',
   @i_comprobante1 	int     = null,
   @i_msg          	tinyint = 0,
   @i_usuario     		login =null,
   @i_tipo_compro		char(1) = null,  /*RV001*/
   @i_estado		    char(1) = null,   /*RV001*/		
   @i_cuenta		    cuenta = null, /*RV003*/
   @i_oficina_orig     smallint = null,
   @i_proceso          char(1)  = null,
   @i_reversa          char(1)  = null,
   @i_fecha_tran1      datetime = null,
   @i_comprobante2		int = null,
   @i_origen           char(1) = 'B'
	)
as 
declare
   @w_today 	       char(12),  	/* fecha del dia */
   @w_return	       int,		/* valor que retorna */
   @w_sp_name	       varchar(32),	/* nombre del stored procedure*/
   @w_siguiente	   int,
   @w_numero          int,
   @w_numeretencion   int,
   @w_comprobante 	   int,
   @w_empresa	       tinyint,
   @w_oficina_dest    smallint,
   @w_oficina_orig    smallint,
   @w_area_orig	   smallint,
   @w_detalles 	   int,
   @w_reversado       char(1),
   @wa_reversado	   char(1),
   @w_autorizado      char(1),
   @w_tipo_doc	       char(1),
   @wa_autorizado	   char(1),
   @w_tipo_tran	   char(1),
   @w_tot_debito 	   money,
   @w_tot_credito 	   money,
   @w_tot_debito_me   money,
   @w_tot_credito_me  money,
   @w_td_detalles 	   int,
   @w_td_debito 	   money,
   @w_td_credito 	   money,
   @flag1		       int,
   @w_fecha_tran      datetime,
   @w_asiento	       int,
   @w_cuenta          cuenta,
   @w_debito	       money,
   @w_credito	       money,
   @w_debito_me	   money,
   @w_credito_me	   money,
   @w_moneda	       tinyint,
   @w_area_dest	   smallint,
   @wa_area_orig	   smallint,
   @w_operacion       int ,
   @w_descripcion 	   char(255),
   @w_comp_tipo  	   int,
   @wt_mayorizado 	   char(1),
   @wta_concepto	   descripcion, 
   @w_num_reg	       int,
   @w_mayorizado	   char(1),
   @w_mayoriza	       char(1),
   @wa_oficina_orig   smallint,
   @wa_depto_orig	   tinyint,
   @wa_fecha_tran 	   datetime,
   @wa_descripcion	   char(255),
   @wa_comp_tipo	   int,
   @wa_detalles	   smallint,
   @wa_tot_debito	   money,
   @wa_tot_credito	   money,
   @wa_tot_debito_me  money,
   @wa_tot_credito_me money,
   @wa_oficina_dest   smallint,
   @w_cotizacion	   money,
   @wa_automatico	   smallint,
   @w_automatico	   smallint,
   @w_numerror        int,
   @w_salida	       varchar(20),
   @w_tabla	       int,
   @w_tipo		       varchar(3),
   @w_error	       int,
   @w_cuenta_ind	   cuenta_contable,
   @w_cuenta_ind_base cuenta_contable,
   @w_cuenta_ind_max  cuenta_contable,
   @w_asientos_cuenta int	

select @w_today = convert(char(12),getdate(),@i_formato_fecha)
select @w_sp_name = 'sp_comprobanteh' , @w_numerror = 0
-- temporal error del kernel select @s_user =@i_usuario


/************************************************/
/*  Tipo de Transaccion = 611X 			*/

if (@t_trn <> 6112 and @i_operacion = 'M') or
   (@t_trn <> 6308 and @i_operacion = 'Q') or
   (@t_trn <> 6114 and @i_operacion = 'S')
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


if @i_operacion = 'M'
begin
   delete cob_conta..cb_usu_capt_comp where cc_oficina = @s_ofi and cc_terminal = @s_term
   insert cob_conta..cb_usu_capt_comp values (@s_ofi,@s_term,@s_user,@i_proceso,'E',getdate())
    
   select co_autorizado
   from cob_conta_historico..cb_comprobante
   where co_fecha_tran   = @i_fecha_tran 
   and   co_comprobante  = @i_comprobante 
   and   co_empresa      = @i_empresa  
   and   co_oficina_orig = @i_oficina_orig
   and   isnull(co_traslado, 'N') = 'N'
   if @@rowcount > 0
   begin
        begin tran
   update cob_conta_historico..cb_comprobante set 
   co_fecha_mod   = getdate(),
   co_autorizado  = @i_autorizado,
   co_autorizante = @i_autorizante ,
   co_causa_anula	= @i_anula
   from cob_conta_historico..cb_comprobante
   where co_fecha_tran   = @i_fecha_tran 
   and   co_comprobante  = @i_comprobante 
   and   co_empresa      = @i_empresa 
   and   co_oficina_orig = @i_oficina_orig
   if @@error <> 0
   begin
   /* 'error en actualizacion de comprobante' */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 603022
      return 1
   end
   /***************************/
   /* TRANSACCION DE SERVICIO */
   /***************************/
   insert into ts_comprobante
   values (@i_comprobante,@t_trn,'U',getdate(),@s_user,
   @s_term,@s_ofi,@i_empresa,@wa_oficina_dest,@i_comprobante,
   @wa_oficina_orig,@wa_depto_orig,@wa_fecha_tran,@wa_descripcion,@wa_comp_tipo,
   @wa_detalles,@wa_tot_debito,@wa_tot_credito,@wa_tot_debito_me,@wa_tot_credito_me)
   if @@error <> 0
   begin
   /* 'Error en insercion de transaccion de servicio' */
       exec cobis..sp_cerror
       @t_debug = @t_debug,
       @t_file  = @t_file,
       @t_from  = @w_sp_name,
       @i_num   = 603032
       return 1
   end
        commit tran
        delete cob_conta..cb_usu_capt_comp where cc_oficina = @s_ofi and cc_terminal = @s_term
        return 0
     end
     else begin
      /* 'No existen Comprobantes ' */
      exec cobis..sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from	  = @w_sp_name,
      @i_num    = 601060
      return 1
   end
end
   
/********************** ALL   SEARCH *****************/
/* Operacion search retorna comprobantes nomayorizados y del grabados en 
   en el dia */

if @i_operacion = 'S' begin
set rowcount 20
   if @i_modo = 0 begin
      select 
      'Oficina'   = co_oficina_orig,
      'No.Comp.'  = co_comprobante,
      'Fecha'     = convert(char(10),co_fecha_tran,@i_formato_fecha),
      'Digitado'  = convert(char(10),co_fecha_dig,@i_formato_fecha),
      'Digitador' = co_digitador,
      'Aut.'      = co_autorizado,
      'May.'      = co_mayorizado
      from cob_conta_historico..cb_comprobante, cob_conta..cb_control b
      where co_mayorizado = @i_mayorizado
      and   co_digitador  = @s_user
      and   co_fecha_tran >= '01/01/1900'
      and   co_empresa    = @i_empresa 
      and   co_oficina_orig in (select je_oficina
                                from cb_jerarquia
                                where je_empresa = 1 and
                              	(je_oficina = b.cn_oficina or 
                              	je_oficina_padre = b.cn_oficina)) 
      and co_area_orig in (select ja_area
                           from cb_jerararea
                           where ja_empresa = 1 
                           and   (ja_area = b.cn_area or ja_area_padre =b.cn_area))
      and cn_empresa = @i_empresa
      and cn_login = @s_user
      and cn_tipo = 'M'
      order by co_fecha_tran, co_oficina_orig,co_comprobante

      if @@rowcount = 0
      begin
         /* 'No existen Comprobantes ' */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 601060
         set rowcount 0
         return 1
      end
      set rowcount 0
      return 0
   end
   if  @i_modo = 1 begin
      select 
      'Oficina'   = co_oficina_orig,
      'No.Comp.'  = co_comprobante,
      'Fecha'     = convert(char(10),co_fecha_tran,@i_formato_fecha),
      'Digitado'  = convert(char(10),co_fecha_dig,@i_formato_fecha),
      'Digitador' = co_digitador,
      'Aut.'      = co_autorizado,
      'May.'      = co_mayorizado
      from cob_conta_historico..cb_comprobante, cob_conta..cb_control b
      where   co_mayorizado = @i_mayorizado
      and co_digitador = @s_user
      and co_fecha_tran >= '01/01/1900'
      and co_empresa = @i_empresa 
      and co_oficina_orig in (select je_oficina
                              from cb_jerarquia
                              where je_empresa = 1 and
                              (je_oficina = b.cn_oficina or 
                              je_oficina_padre = b.cn_oficina)) 
      and co_area_orig in (select ja_area
                           from cb_jerararea
                           where ja_empresa = 1 and
                           (ja_area = b.cn_area or ja_area_padre =b.cn_area))
      and ((co_fecha_tran > @i_fecha_tran) or 
            (co_fecha_tran = @i_fecha_tran and
             co_oficina_orig > @i_oficina) or 
            (co_fecha_tran = @i_fecha_tran and 
             co_oficina_orig = @i_oficina and
             co_comprobante > @i_comprobante))
      and cn_empresa = @i_empresa
      and cn_login = @s_user
      and cn_tipo = 'M'
   	  order by co_fecha_tran, co_oficina_orig,co_comprobante

      if @@rowcount = 0 begin
         /* 'No existen Comprobantes ' */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file	 = @t_file,
         @t_from	 = @w_sp_name,
         @i_num	 = 601060
         set rowcount 0
         return 1
      end
      set rowcount 0
      return 0
   end

   if  @i_modo = 2 begin
      select co_comprobante,
      convert(char(10),co_fecha_tran,@i_formato_fecha),
      co_mayorizado,
      convert(char(12),co_fecha_dig,@i_formato_fecha),
      convert(char(12),getdate(),@i_formato_fecha),
      co_oficina_orig, co_area_orig
      from cob_conta_historico..cb_comprobante, cb_control
      where co_empresa = @i_empresa 
      and co_fecha_tran = @i_fecha_tran
      and co_comprobante = @i_comprobante
      and co_oficina_orig >= 0
      and cn_empresa = @i_empresa
      and cn_login = @s_user
      and cn_oficina = co_oficina_orig 
      and cn_area = co_area_orig 

      if @@rowcount = 0
      begin
         /* 'No existen Comprobantes ' */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file	 = @t_file,
         @t_from	 = @w_sp_name,
         @i_num	 = 601060
         set rowcount 0
         return 1
      end
      set rowcount 0
      return 0
   end

   if  @i_modo = 3 begin
      set rowcount 1
      select 
      co_comprobante,
      convert(char(10),co_fecha_tran,@i_formato_fecha),
      co_mayorizado,
      convert(char(12),co_fecha_dig,@i_formato_fecha),
      convert(char(12),getdate(),@i_formato_fecha)
      from cob_conta_historico..cb_comprobante, cob_conta..cb_control
      where co_empresa = @i_empresa 
      and co_mayorizado = 'N' 
      and co_comprobante > @i_comprobante
      and cn_login = @s_user
      and co_oficina_orig = cn_oficina
      and co_area_orig    = cn_area
      and cn_empresa = @i_empresa
      and cn_login = @s_user
      and cn_oficina = co_oficina_orig
      and cn_area = co_area_orig
      order by co_comprobante 

      if @@rowcount = 0 begin
         /* 'No existen Comprobantes ' */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file	 = @t_file,
         @t_from	 = @w_sp_name,
         @i_num	 = 601060
         set rowcount 0
         return 1
      end
      set rowcount 0
      return 0
   end

   if  @i_modo = 4 begin
      set rowcount 1
      select co_comprobante,
      convert(char(10),co_fecha_tran,@i_formato_fecha),
      co_mayorizado,
      convert(char(12),co_fecha_dig,@i_formato_fecha),
      convert(char(12),getdate(),@i_formato_fecha)
      from cob_conta_historico..cb_comprobante, cob_conta..cb_control
      where co_empresa = @i_empresa 
      and co_mayorizado = 'N' 
      and co_comprobante < @i_comprobante
      and co_oficina_orig = cn_oficina
      and co_area_orig    = cn_area
      and cn_empresa = @i_empresa
      and cn_login = @s_user
      and cn_oficina = co_oficina_orig
      and cn_area = co_area_orig
      order by co_comprobante desc

      if @@rowcount = 0 begin
         /* 'No existen Comprobantes ' */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from	 = @w_sp_name,
         @i_num	 = 601060
         set rowcount 0
         return 1
      end
      set rowcount 0
      return 0
   end
end

/********* Query *******/
if @i_operacion = 'Q' begin
   set rowcount 20
   if @i_modo = 0 begin
   
      select 
      co_oficina_orig,
      co_area_orig,
      co_comprobante,
      substring(co_descripcion,1,120),
      convert(char(12),co_fecha_tran,@i_formato_fecha),
      co_mayorizado,
      co_comp_tipo,
      co_tot_debito,
      co_tot_credito,
      co_tot_debito_me,
      co_tot_credito_me,
      substring(of_descripcion,1,40),
      substring(ar_descripcion,1,40), 
      co_autorizado,
      substring(co_digitador,1,15),
      substring(co_autorizante,1,15),
      substring(co_referencia,1,10),
      co_estado,co_tipo_compro, 
      convert(char(12),co_fecha_dig,@i_formato_fecha),
      co_causa_anula, 
      co_reversado
      from cob_conta_historico..cb_comprobante ,
           cob_conta..cb_oficina , 
           cob_conta..cb_area 
      where co_fecha_tran      =       @i_fecha_tran       
      and   co_empresa         =       @i_empresa          
      and   co_comprobante     =       @i_comprobante      
      and   co_oficina_orig    =       @i_oficina_orig     
      and   of_empresa         =       @i_empresa          
      and   of_oficina         =       co_oficina_orig     
      and   ar_empresa         =       @i_empresa          
      and   ar_area            =       co_area_orig        
      
      if @@rowcount = 0
      begin
         /* 'Comprobante consultado no existe'*/
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file	 = @t_file,
         @t_from	 = @w_sp_name,
         @i_num	 = 601061
         return 1
      end
           
      select  
      as_oficina_dest,
      as_area_dest,
      as_cuenta,
      as_tipo_doc,
      as_debito,
      as_credito,
      as_debito_me,
      as_credito_me,
      as_cotizacion,
      as_tipo_tran,
      substring(as_concepto,1,60),
      as_moneda,
      ca_cod_concepto = (select ca_cod_concepto
                         from cob_conta..cb_concepto_asiento
                         where ca_comprobante = a.as_comprobante 
                         and   ca_asiento     = a.as_asiento),	
      ca_concepto = (select ca_concepto
                     from cob_conta..cb_concepto_asiento
                     where ca_comprobante = a.as_comprobante 
                     and   ca_asiento     = a.as_asiento)
      from cob_conta_historico..cb_asiento a
      where as_fecha_tran   = @i_fecha_tran     
      and   as_comprobante  = @i_comprobante    
      and   as_empresa      = @i_empresa         
      and   as_oficina_orig = @i_oficina_orig
      order by as_asiento

   end
   else begin
      select  as_oficina_dest,as_area_dest,as_cuenta,
      as_tipo_doc,as_debito,as_credito,as_debito_me,
      as_credito_me,as_cotizacion,as_tipo_tran,
      substring(as_concepto,1,60),as_moneda,
      ca_cod_concepto = (select ca_cod_concepto
                         from cob_conta..cb_concepto_asiento
                         where ca_comprobante = a.as_comprobante 
                         and   ca_asiento     = a.as_asiento),	
      ca_concepto = (select ca_concepto
                     from cob_conta..cb_concepto_asiento
                     where ca_comprobante = a.as_comprobante 
                     and   ca_asiento     = a.as_asiento)
      from cob_conta_historico..cb_asiento a
      where as_fecha_tran = @i_fecha_tran 
      and   as_comprobante = @i_comprobante 
      and   as_empresa = @i_empresa 
      and   as_oficina_orig = @i_oficina_orig 
      and   as_asiento > @i_asiento
      order by as_asiento
      
      if @@rowcount = 0 begin
      /*  if @i_msg = 0 */
      /*    begin */
      /* 'Comprobante consultado no existe'*/
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file	 = @t_file,
         @t_from	 = @w_sp_name,
         @i_num	 = 601150
                   /*    end */
         return 1
      end
   end
   return 0
end
