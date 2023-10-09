/************************************************************************/
/*	Archivo: 		    asientfe.sp			                            */
/*	Stored procedure: 	sp_asientot_fe				                    */
/*	Base de datos:  	cob_conta  				                        */
/*	Producto:               contabilidad                		        */
/*	Disenado por:           Sandra Y. Robayo                	        */
/*	Fecha de escritura:     17-noviembre-1999			                */
/************************************************************************/
/*				    IMPORTANTE				                            */
/*	Este programa es parte de los paquetes bancarios propiedad de	    */
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	        */
/*	"NCR CORPORATION".						                            */
/*	Su uso no autorizado queda expresamente prohibido asi como	        */
/*	cualquier alteracion o agregado hecho por alguno de sus		        */
/*	usuarios sin el debido consentimiento por escrito de la 	        */
/*	Presidencia Ejecutiva de MACOSA o su representante.		            */
/*				PROPOSITO				                                */
/*	Este programa procesa las transacciones de:			                */
/*	Inserta los asientos de un comprobante a la tabla temporal          */
/*				MODIFICACIONES				                            */
/*	FECHA		AUTOR		RAZON				                        */
/*	17/Nov/1999	Sandra Robayo   Emision Inicial			                */
/************************************************************************/
use cob_conta
go

if exists (select 1 from sysobjects where name = 'sp_asientot_fe')
	drop proc sp_asientot_fe  

go

create proc sp_asientot_fe   (
	@s_ssn		    int = null,
	@s_date		    datetime = null,
	@s_user		    login = null,
	@s_term		    descripcion = null,
	@s_corr		    char(1) = null,
	@s_ssn_corr	    int = null,
    @s_ofi		    smallint = null,
	@t_rty		    char(1) = null,
    @t_trn		    smallint = null,
	@t_debug	    char(1) = 'N',
	@t_file		    varchar(14) = null,
	@t_from		    varchar(30) = null,
	@i_operacion	char(1) = null,
	@i_modo		    smallint = null,
	@i_fecha_tran	datetime = null,
    @i_comprobante	int = null,    
	@i_empresa 	    tinyint = null,
	@i_asiento	    smallint = null,
	@i_cuenta   	cuenta = null,
	@i_oficina_dest smallint = null,
	@i_oficina_orig smallint = null,
	@i_area_dest    smallint  = null,
	@i_credito	    money = null,
	@i_debito	    money = null,
	@i_concepto	    descripcion = null,
	@i_credito_me	money = null,
	@i_debito_me	money = null,
	@i_cotizacion	money = null,
	@i_tipo_doc	    char(1) =null,
	@i_tipo_tran	char(1) = null,
	@i_mayorizado	char(1) = null,
    @i_moneda	    tinyint =  null , 
    
    -- SOLO PARA COMPROBANTES DE MOVIMIENTOS DE PROVISION
    @i_cod_nov      char(2)         = NULL,
    @i_desc_mov     varchar(30)     = NULL
)
as 
declare
	@w_today 	   datetime,  	/* fecha del dia */
	@w_return	   int,		/* valor que retorna */
	@w_sp_name	   varchar(32),	/* nombre del stored procedure*/
	@w_siguiente   tinyint,
	@w_moneda	   tinyint,	/* codigo de moneda de la cuenta */
	@w_existe	   int,		/* codigo existe = 1 
				               no existe = 0 */
    @w_flag        int 

select @w_today = getdate()
select @w_sp_name = 'sp_asientot_fe'

/************************************************/
/*  Tipo de Transaccion =  			*/

if (@t_trn <> 6343)
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
	t_file		    = @t_file,
	t_from		    = @t_from,
	i_operacion	    = @i_operacion,
	i_fecha_tran	= @i_fecha_tran,
	i_comprobante	= @i_comprobante,
	i_empresa   	= @i_empresa,      
	i_asiento	    = @i_asiento,
	i_cuenta     	= @i_cuenta ,
	i_oficina_dest	= @i_oficina_dest,
	i_area_dest	    = @i_area_dest,
	i_credito	    = @i_credito,
	i_debito	    = @i_debito,
	i_concepto	    = @i_concepto,
	i_credito_me	= @i_credito_me,
	i_debito_me	    = @i_debito_me,
	i_cotizacion	= @i_cotizacion,
	i_tipo_doc	    = @i_tipo_doc,
	i_tipo_tran	    = @i_tipo_tran,
	i_mayorizado	= @i_mayorizado
	exec cobis..sp_end_debug
end

/**************** VALIDACIONES ***********************/

if @i_operacion = 'I' begin

   if @i_mayorizado is NULL begin
          /* posee campos Nulos  */
	    exec cobis..sp_cerror
	    @t_debug = @t_debug,
	    @t_file	 = @t_file,
	    @t_from	 = @w_sp_name,
	    @i_num	 = 601001
	    return 1
   end

   if NOT EXISTS (select 1 from cb_empresa 
			where em_empresa = @i_empresa)
   begin
		/* 'Empresa especificada no existe    ' */
      exec cobis..sp_cerror
      @t_debug   = @t_debug,
      @t_file	 = @t_file,
      @t_from	 = @w_sp_name,
      @i_num	 = 601018
      return 1
   end
   if NOT EXISTS (select 1 from cob_conta..cb_cuenta 
                  where cu_estado = 'V' and cu_cuenta = @i_cuenta)
   begin
      /* cuenta no existe o no se encuentra vigente  */
      exec cobis..sp_cerror
      @t_debug   = @t_debug,
      @t_file	 = @t_file,
      @t_from	 = @w_sp_name,
      @i_num	 = 601028
      return 1
   end

   if NOT EXISTS ( select 1 from cob_conta..cb_cuenta
                   where cu_cuenta = @i_cuenta and
                   cu_acceso = 'N' ) 
   begin
      /* cuenta no tiene acceso Normal  */
      exec cobis..sp_cerror
      @t_debug   = @t_debug,
      @t_file	 = @t_file,
      @t_from	 = @w_sp_name,
      @i_num	 = 601066
      return 1
   end

   if NOT EXISTS ( select 1 from cob_conta..cb_cuenta
                   where cu_cuenta = @i_cuenta and
                   cu_movimiento = 'S' ) 
   begin
           /* cuenta no es de movimiento  */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file	 = @t_file,
      @t_from	 = @w_sp_name,
      @i_num	 = 601067
      return 1
   end
        
   if NOT EXISTS (select 1 from cob_conta..cb_plan_general
                  where pg_empresa = @i_empresa and
                  pg_cuenta = @i_cuenta and
                  pg_oficina = @i_oficina_dest and
                  pg_area = @i_area_dest)
   begin
      /* cuenta no se encuentra asociada a oficina y area de destino */
      exec cobis..sp_cerror
      @t_debug   = @t_debug,
      @t_file	 = @t_file,
      @t_from	 = @w_sp_name,
      @i_num	 = 601068
      return 1
   end

   if @i_moneda is null
   begin
      select @w_moneda = cu_moneda
      from cob_conta..cb_cuenta
      where cu_empresa = @i_empresa and
      cu_cuenta  = @i_cuenta
   end
   else
   begin
      select @w_moneda = @i_moneda
   end

   begin tran

   -- select @w_moneda = 0 MANEJO DE MONEDA EXTRANJERA

   insert into cb_tasiento     (
   ta_fecha_tran,ta_comprobante,ta_empresa,
   ta_asiento,ta_cuenta,
   ta_oficina_dest,ta_area_dest,
   ta_credito,ta_debito,ta_concepto,
   ta_credito_me,ta_debito_me,ta_cotizacion,
   ta_tipo_doc,ta_tipo_tran,ta_mayorizado,ta_moneda,ta_oficina_orig)
   values (@i_fecha_tran,@i_comprobante,@i_empresa,
   @i_asiento,@i_cuenta,
   @i_oficina_dest,@i_area_dest,
   @i_credito,@i_debito,@i_concepto,
   @i_credito_me,@i_debito_me,@i_cotizacion,
   @i_tipo_doc,@i_tipo_tran,@i_mayorizado,@w_moneda,@i_oficina_orig)

   if @@error <> 0  
   begin
   /*'Error en insercion del detalle del comprobante en la tabla temporal' */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file	 = @t_file,
      @t_from	 = @w_sp_name,
      @i_num	 = 603020
      
      delete cob_conta..cb_tasiento
      where  ta_fecha_tran    = @i_fecha_tran and
      ta_comprobante   = @i_comprobante       and
      ta_empresa       = @i_empresa           and
      ta_oficina_orig  = @i_oficina_orig
      
      delete cob_conta..cb_tcomprobante
      where  ct_fecha_tran   = @i_fecha_tran    and
      ct_comprobante         = @i_comprobante   and
      ct_empresa             = @i_empresa       and
      ct_oficina_orig        = @i_oficina_orig
      return 1
	end

   if @i_cod_nov is not null and @i_desc_mov is not null
   begin 
      insert  into cob_conta..cb_tconcepto_asiento
      values (@i_empresa,6,@i_fecha_tran,@i_comprobante,@i_asiento,@i_cod_nov,@i_desc_mov,@i_oficina_orig)
      
      if @@error <> 0  
      begin
              /*'Error en insercion del detalle del comprobante en la tabla temporal' */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file	 = @t_file,
         @t_from	 = @w_sp_name,
         @i_num	 = 603020
      
         delete cob_conta..cb_tasiento
         where  ta_fecha_tran    = @i_fecha_tran     and
                ta_comprobante   = @i_comprobante    and
                ta_empresa       = @i_empresa        and
                ta_oficina_orig  = @i_oficina_orig
         
         delete cob_conta..cb_tcomprobante
         where  ct_fecha_tran    = @i_fecha_tran     and
                ct_comprobante   = @i_comprobante    and
                ct_empresa       = @i_empresa        and
                ct_oficina_orig  = @i_oficina_orig
                
         delete cob_conta..cb_tconcepto_asiento
         where  ca_fecha_tran     = @i_fecha_tran     and
                ca_comprobante    = @i_comprobante    and
                ca_empresa        = @i_empresa        and
                ca_oficina_ori  = @i_oficina_orig      
         return 1
      end
   end
   commit tran
end

if @i_operacion = 'D' begin

   delete cob_conta..cb_tasiento
   where  ta_fecha_tran       = @i_fecha_tran 
   and	   ta_comprobante      = @i_comprobante 
   and	   ta_empresa          = @i_empresa 
   and    ta_oficina_orig     = @i_oficina_orig 
   and  (ta_concepto = 'ASIENTO AUTOMATICO ENTRE SUCURSALES'
   or ta_concepto = 'ASIENTO AUTOMATICO POSICION MONEDA EXTRANJERA')

end

return 0

go



