/************************************************************************/
/*	Archivo: 		rechqdev.sp                             */
/*	Stored procedure: 	sp_rem_chequedev            		*/
/*	Base de datos:  	cob_remesas				*/
/*	Producto: 		Remesas 				*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 08-Abr-1993					*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa procesa la transaccion:                    	*/
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	08/Abr/1993	J Navarrete	Emision inicial			*/
/*      18/Mar/1996     D Villafuerte   Control de Calidad (revers)     */ 
/*      24/Oct/1996     A Villarreal    Control de Calidad (revers)     */ 
/*      24/Ene/2001     E.Pulido        Aumentar el campo ciudad a 4 dig*/ 
/*      21/Ene/2003     J. Loyo         Aumentar el campo oficna a 4 dig*/ 
/*      21/Ene/2003     J. Loyo         Cobro de portes por dev al Corre*/ 
/*      26/Ago/2003     G. Rueda        Retornar c+digos de error       */      
/*      20/Sep/2004     O. Ligua        Correccion act. trans. original */
/*					en reverso			*/
/*      28/Sep/2004     O. Ligua        Indicador 0 cuando es Remesa	*/
/*					Negociada			*/
/*	10/Nov/2004	O. Ligua	Utilizacion de Causa Contable	*/
/*					para contabilizacion correcta	*/
/*      14/Ene/2004     Julissa Colorado reclasificacion de remesas 15  */
/*      02/Nov/2005     Julissa Colorado Codigo de ente de banco corresp*/
/************************************************************************/

use cob_remesas
go

if exists (select * from sysobjects where name = 'sp_rem_chequedev')
	drop proc sp_rem_chequedev

go
create proc sp_rem_chequedev (
	@s_ssn		int,
	@s_srv	        varchar(30),
	@s_lsrv	        varchar(30),
	@s_user		varchar(30),
	@s_sesn	        int=null,
	@s_term		varchar(10),
	@s_date		datetime,
	@s_ofi		smallint,	/* Localidad origen transaccion */
	@s_rol		smallint,
	@s_org_err	char(1)	= null,	/* Origen de error: [A], [S] */
	@s_error	int	= null,
	@s_sev	        tinyint	= null,
	@s_msg		mensaje	= null,
	@s_org		char(1),
	@t_corr   	char(1) = 'N',
	@t_ssn_corr	int = null,	/* Trans a ser reversada */
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(32) = null,
	@t_rty		char(1) = 'N',
	@t_trn		smallint,
	@p_lssn		int	= null,
	@p_rssn		int	= null,
	@p_rssn_corr	int	= null,
	@p_envio	char(1) = 'N',
	@p_rpta	        char(1) = 'N',
        --IU ERP 24/01/2001 cc00194
	@i_corres	char(11),
        @i_emisor       char(11),
	@i_propie       char(11),
        --FU ERP 24/01/2001 cc00194
	@i_fecha	datetime,
	@i_secuen	int,
	@i_chq	        int,
	@i_val	        money,
	@i_prddep       char(3),
	@i_ctadep       cuenta,
	@i_hablt        char(1) = 'C',
	@i_mon	        tinyint,
      @i_causadev     char(3),
      @i_pit          char(1) = 'N'
)
as
declare	@w_return	int,
	@w_sp_name	varchar(30),
	@w_cuenta	int,
	@w_ssn_corr	int,
	@w_filial 	tinyint,
	@w_fecha_hoy	datetime,
	@w_fecha	datetime,
	@w_oficina	smallint,
	@w_ofi_bco	smallint,
	@w_banco	smallint,
	@w_ciudad	smallint,
	@w_producto	tinyint,
	@w_nom_producto	descripcion,
	@w_interes	money,
	@w_rssn_corr	int,
	@w_server_rem	descripcion,
	@w_server_local	descripcion,
	@w_rpc		descripcion,
	@w_tipo		char(1),
	@w_signo	char(1),
	@w_dias_rete	tinyint,
	@w_num_cheques	tinyint,
	@w_carta	int,
	@w_valor	money,
	@w_bco_p	smallint,
	@w_ofi_p	smallint,
	@w_ciu_p	smallint,
        @w_bco_e        smallint,
        @w_ofi_e        smallint,
        @w_ciu_e        smallint,    
	@w_bco_c	smallint,
	@w_ofi_c	smallint,
	@w_ciu_c	smallint,
	@w_filial_p 	tinyint,
	@w_oficina_p	smallint,
	@w_tipo_promedio char(1),
	@w_oficial	smallint,
	@w_cheque_rec	int,
	@w_factor	int,
	@w_control	int,
        @w_status       char(1),
        @w_fecha_efe    smalldatetime,
        @w_cajeroint    char(1),
        @w_cta_girada   varchar(15),
        @w_num_cheque   int,
        @w_codigo       smallint,
        @w_ref          int,
        @w_estado       varchar(15),
        @w_reverso      char(1),
        @w_numchqs      tinyint,
        @w_valorc       money,
        @w_causa_cont   varchar(3),
        @w_saldocont    money,
        @w_saldodisp    money,
	@w_tasa_icc     float,
        @w_cobro_icc    char(1),
	@w_ente         int,
	@w_ente_corr    int,
	@w_val_icc      money,
--II CHE 07/27/2002
	@w_monto_aut	money,
	@w_monto_ori	money,
	@w_val_dif	money,
	@w_valor_tot	money,
	@w_ant_fec_lab		datetime,
--FI CHE 07/27/2002
	@w_valor_neto   money,
	@w_numdeci	int,
	@w_clase_clte   char(1),
	@w_tipo_rem	char(1),
	@w_prod_banc	int,
	@w_bco_corr	int,
	@o_exento	char(1),
	@o_base		money,
	@o_porcentaje	float,
	@w_piva		float,
	@w_iva 		money,
	@w_portes	money,
        @w_ofic_dep     smallint,
	@w_indicador	tinyint,			--OLI 09282004
	@w_ofi_destino	smallint,			--OLI 11102004
        @w_proc_conta  char(1),
        @w_valor_chq     money,
        @w_efectivo_chq  money,
        @w_cod_bco		tinyint,
	@w_cob           int




	
/*  Captura nombre de Stored Procedure  */
select	@w_sp_name = 'sp_rem_chequedev'

/*  Modo de debug  */

/* Chequeo de errores generados remotamente */
if @s_org_err is not null       	/*  Error del Sistema  */
begin
        exec cobis..sp_cerror1
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = @s_error,
               @i_sev          = @s_sev,
               @i_msg          = @s_msg,
               @i_pit          = @i_pit
        return @s_error
end

select @w_fecha = @i_fecha
select @w_fecha_hoy = @s_date
select @w_valor_chq  = 0,  
       @w_efectivo_chq = 0


/* Valida datos */
if @i_chq = 0 or @i_val = 0 or @i_secuen = 0
begin
	exec cobis..sp_cerror1
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 351002,
            @i_pit          = @i_pit
	return 351002
end
 
select @w_tipo_rem   = dc_tipo_rem,
       @w_bco_corr  = dc_banco_c,
       @w_proc_conta  = isnull(dc_proc_conta, 'S')
from cob_remesas..re_det_carta
where dc_cheque = @i_chq
  and dc_carta  = @i_secuen

if @@rowcount != 1
   select @w_tipo_rem = 'C' --Cambiar 'N' a 'C' VMA 08/15/2002

/* OLI 09282004. Indicador depende del tipo de remesa */
if @w_tipo_rem = 'C'
   select @w_indicador = 4
else
   if @w_tipo_rem = 'N'
      select @w_indicador = 0


/* Selecciona Datos del cheque */
   select @w_status     = cr_status,
          @w_cta_girada = cr_cta_girada,
          @w_num_cheque = cr_num_cheque,
          @w_fecha_efe  = cr_fecha_efe
     from cob_remesas..re_cheque_rec
    where cr_cheque_rec = @i_chq

/* Valida operacion de Reverso */
   if @t_corr = 'S' and (@w_fecha_hoy != @w_fecha_efe)
      begin
         exec cobis..sp_cerror1
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 351043,
            @i_pit          = @i_pit
         return 351043
      end

--IU ERP 24/01/2001 cc00194
/* Separa codigo de banco del corresponsal en sus componentes */
   select @w_bco_c = convert(smallint, substring(@i_corres,1,2))
   select @w_ofi_c = convert(smallint, substring(@i_corres,3,5))
   --select @w_ciu_c = convert(smallint, substring(@i_corres,6,3))
   select @w_ciu_c = convert(smallint, substring(@i_corres,8,4))

/* Separa codigo de banco del emisor en sus componentes */
   select @w_bco_e = convert(smallint, substring(@i_emisor,1,2))
   select @w_ofi_e = convert(smallint, substring(@i_emisor,3,5))
   --select @w_ciu_e = convert(smallint, substring(@i_emisor,6,3))
   select @w_ciu_e = convert(smallint, substring(@i_emisor,8,4))

/* Separa codigo de banco del propietario en sus componentes */
   select @w_bco_p = convert(smallint, substring(@i_propie,1,2))
   select @w_ofi_p = convert(smallint, substring(@i_propie,3,5))
   --select @w_ciu_p = convert(smallint, substring(@i_propie,6,3))
   select @w_ciu_p = convert(smallint, substring(@i_propie,8,4))
--FU ERP 24/01/2001 cc00194

/* Valida Transaccion de Cajero Interno y la existencia del Cheque */ 
   if @i_ctadep = '9999999999' and @i_prddep = 'CTE'
      begin
         select @w_cajeroint = 'S'
         if not exists (select * from cob_cuentas..cc_chq_otrdept
                        where cd_banco_chq = @w_bco_p
                          and cd_cta_chq   = @w_cta_girada
                          and cd_num_chq   = @w_num_cheque)
            begin
               exec cobis..sp_cerror1
                  @t_debug        = @t_debug,
                  @t_file         = @t_file,
                  @t_from         = @w_sp_name,
                  @i_num          = 201188,
                  @i_pit          = @i_pit
               return 201188
            end       
       end
   else
         select @w_cajeroint = 'N' 

if @i_prddep = 'CTE' 
begin
     select @w_nom_producto = 'CUENTA CORRIENTE'
     select @i_hablt = 'C'
end
else 
   if @i_prddep = 'AHO'
   begin
     select @w_nom_producto = 'CUENTA DE AHORROS'
     select @i_hablt = 'A'
   end
   else
     select @w_nom_producto = 'OTRAS CUENTAS'
     
/*  Busqueda de parametros  */
select	@w_cod_bco  = pa_tinyint
from	cobis..cl_parametro
where	pa_nemonico = 'CBCO'
and		pa_producto = 'CTE'
if @@rowcount <> 1
begin
   exec cobis..sp_cerror
       @i_num       = 201196
   return 1
end     

/* Captura de parametros de la oficina  */
   exec @w_return = cobis..sp_parametros 
			@t_debug	= @t_debug,
			@t_file	= @t_file,
			@t_from	= @w_sp_name,
			@s_lsrv	= @s_lsrv,
			@i_nom_producto	= @w_nom_producto,
                  @i_pit      = @i_pit,
			@o_banco 	= @w_banco out, 
			@o_ciudad 	= @w_ciudad out, 
			@o_oficina 	= @w_oficina out,
			@o_ofi_bco 	= @w_ofi_bco out,
			@o_producto 	= @w_producto out
   if @w_return != 0
	return @w_return

/* Determinacion de condicion de local o remoto */
   if @w_cajeroint = 'N' 
      begin
         exec @w_return = cob_cuentas..sp_cta_origen 
			@t_debug	= @t_debug,
			@t_file	        = @t_file,
			@t_from	        = @w_sp_name,
			@i_cta 	        = @i_ctadep, 
			@i_producto	= @w_producto,
		 	@i_mon	        = @i_mon, 
			@i_oficina	= @w_oficina,
                  @i_pit      = @i_pit,
 		 	@o_tipo		= @w_tipo out, 
			@o_srv_local	= @w_server_local out,
			@o_srv_rem	= @w_server_rem out
         if @w_return != 0
	    return @w_return
      end
   else
         select @w_tipo         = 'L',
                @w_server_local = @s_lsrv,
                @w_server_rem   = null

select @w_server_local = @s_lsrv

if @i_prddep = 'CTE'  
   select @w_rpc = 'cob_cuentas..sp_cta_vigente'
else
   if @i_prddep = 'AHO'
      select @w_rpc = 'cob_ahorros..sp_ctah_vigente'

/* Determinacion de vigencia de cuenta  */
 if @w_cajeroint = 'N' 
  begin
   exec @w_return = @w_rpc 
 	  @t_debug	= @t_debug,
	  @t_file	= @t_file,
	  @t_from	= @w_sp_name,
        @i_cta_banco 	= @i_ctadep, 
        @i_moneda = @i_mon,
        @i_pit    = @i_pit, 
        @o_cuenta	= @w_cuenta out, 
        @o_filial	= @w_filial_p out, 
        @o_oficina    = @w_oficina_p out,
	@o_tipo_promedio= @w_tipo_promedio out,
	@o_oficial	= @w_oficial out
   if @w_return != 0
       	return @w_return
  end


 /* codigo de ente de banco corresponsal */
 select @w_ente_corr = ba_ente
  from cob_remesas..re_banco
 where ba_banco = @w_bco_corr

 if @@rowcount = 0
 begin
       exec cobis..sp_cerror1
             @t_debug  = @t_debug,
             @t_file   = @t_file,
             @t_from   = @w_sp_name,
             @i_num    = 201160,
             @i_pit    = @i_pit
         return 201160
 end


	/*** Invoco el sp para conocer el porcentaje del iva a cobrar	***/
	exec @w_return = cob_cuentas..sp_exento_impuestos
		@i_trn 		= @t_trn,
		@i_empresa	= 1,
		@i_impuesto	= 'V',
		@i_debcred	= 'C',
--		@i_ofiadmin   	= @s_ofi,
		@i_oforig_admin	= @s_ofi,
		@i_ofdest_admin = @w_ofi_e,
		@i_ente   	= @w_ente_corr,
		@i_producto	= @w_producto,
                @i_pit          = @i_pit,
		@o_exento	= @o_exento  out,
		@o_base		= @o_base out,
		@o_porcentaje	= @o_porcentaje	out

	if @w_return <> 0
	begin
		exec cobis..sp_cerror1
        	     @t_debug        = @t_debug,
	           @t_file         = @t_file,
        	     @t_from         = @w_sp_name,
	           @i_num          = @w_return,
                 @i_pit          = @i_pit
		return @w_return	
	end

	if @o_exento = 'N'
		select @w_piva = @o_porcentaje
	else
		select @w_piva = 0

/* Modo de correccion  */
if @t_corr = 'N'
begin
	select @w_factor = 1

	
	


	/** Tomo los datos del porte e iva por devolucion para el corresponsal **/
	select 
		@w_portes 	= isnull(bc_portes_dev,0)
	  from cob_remesas..re_bcocedente
	 where bc_banco = @w_bco_corr

	select @w_iva = ((  @w_portes * @w_piva)/100) 

end
else
begin
	select @w_factor = -1
	
	select @w_portes 	= isnull(bc_portes_dev,0)
	from cob_remesas..re_bcocedente
	where bc_banco = @w_bco_corr

	select @w_iva = ((  @w_portes * @w_piva)/100) 
end	



/* Obtengo datos para ICC */
if @i_prddep = 'CTE' 
	select @w_ente = cc_cliente,
		@w_oficial=cc_oficial,
		@w_filial=cc_filial,
		@w_clase_clte= cc_clase_clte,
		@w_prod_banc=cc_prod_banc
	from cob_cuentas..cc_ctacte
	where cc_ctacte = @w_cuenta
else
	select @w_ente = ah_cliente,
		@w_oficial=ah_oficial,
		@w_filial=ah_filial,
		@w_clase_clte= ah_clase_clte,
		@w_prod_banc=ah_prod_banc
	  from cob_ahorros..ah_cuenta
	 where ah_cuenta = @w_cuenta


 --II ERP 26/01/2001 
 -- Busqueda de el Numero de decimales 
   select @w_numdeci = pa_tinyint
   from cobis..cl_parametro
   where pa_nemonico = 'DCI'
   and pa_producto = @i_prddep
   if @@rowcount = 0
   begin
      -- Parametro no encontrado
         exec cobis..sp_cerror1
             @t_debug  = @t_debug,
             @t_file   = @t_file,
             @t_from   = @w_sp_name,
             @i_num    = 201196,
             @i_pit    = @i_pit
         return 201196 
   end
 --FI ERP 26/01/2001

 --Calculo del valor icc
    select @w_cobro_icc = isnull(en_retencion, 'S')
    from cobis..cl_ente
    where en_ente = @w_ente

 -- Manejo de porcentaje de ICC
     if @w_cobro_icc = 'S'
     begin

     -- Tasa para cuentas de aportes 
        select @w_tasa_icc = pa_float
        from cobis..cl_parametro
        where pa_nemonico = 'ICC'
        and pa_producto = @i_prddep
        if @@rowcount = 0
        begin
        -- Parametro no encontrado
              exec cobis..sp_cerror1
                  @t_debug  = @t_debug,
                  @t_file   = @t_file,
                  @t_from   = @w_sp_name,
                  @i_num    = 201196,
                  @i_pit    = @i_pit
              return 201196 
         end
        -- Calculo del valor
          select @w_val_icc = isnull(round((@i_val  * @w_tasa_icc)/100, @w_numdeci), 0)
        end
        else
        select @w_val_icc = 0

     --Calculo valor neto
       select @w_valor_neto = round(@i_val - @w_val_icc, @w_numdeci)

/* Valido la existencia de la carta */
begin tran

   select @w_num_cheques = ct_num_cheques,
          @w_valor       = ct_valor,
          @w_ofic_dep    = ct_oficina,
          @w_cob         = ct_cob
     from cob_remesas..re_carta
    where ct_banco_e   = @w_bco_e
      and ct_oficina_e = @w_ofi_e
      and ct_ciudad_e  = @w_ciu_e
      and ct_banco_p   = @w_bco_p
      and ct_oficina_p = @w_ofi_p
      and ct_ciudad_p  = @w_ciu_p
      and ct_fecha_emi = @w_fecha
      and ct_moneda    = @i_mon
      and ct_carta     = @i_secuen
      and ct_banco_c   = @w_bco_c
      and ct_oficina_c = @w_ofi_c
      and ct_ciudad_c  = @w_ciu_c
   if @@rowcount = 0
      begin
         exec cobis..sp_cerror1
              @t_debug        = @t_debug,
              @t_file         = @t_file,
              @t_from         = @w_sp_name,
              @i_num          = 351003,
              @i_pit          = @i_pit
         return 351003
      end

/* Actualiza el cheque de la carta */
if @w_factor = -1
begin
	update cob_remesas..re_cheque_rec
	   set 	cr_status         = 'P',
		cr_fecha_efe      = null,
		cr_cau_devolucion = null,
		cr_procesado  	  = 'S'
	where cr_cheque_rec = @i_chq
	if @@error != 0
	begin
		exec cobis..sp_cerror1
			@t_debug        = @t_debug,
			@t_file         = @t_file,
			@t_from         = @w_sp_name,
			@i_num          = 355000,
                  @i_pit          = @i_pit
		return 355000
	end

	update cob_remesas..re_det_carta
	   set 	dc_status	= 'P',
		dc_fecha_efe	= null,
		dc_portes_dev 	= 0,
		dc_iva_dev 	= 0
	 where dc_carta  = @i_secuen
	   and dc_cheque = @i_chq
	if @@error != 0
	begin
		exec cobis..sp_cerror1
			@t_debug        = @t_debug,
			@t_file         = @t_file,
			@t_from         = @w_sp_name,
			@i_num          = 355019,
                  @i_pit          = @i_pit
		return 355019
	end  
	if @w_cajeroint = 'S' 
	begin  
		update cob_cuentas..cc_chq_otrdept
		   set 	cd_estado          = 'I',
			cd_fecha_ope       = null,
			cd_causadev        = null
		 where cd_banco_chq = @w_bco_p
		   and cd_cta_chq   = @w_cta_girada
		   and cd_num_chq   = @w_num_cheque  
		if @@error != 0
		begin
			exec cobis..sp_cerror1
				@t_debug        = @t_debug,
				@t_file         = @t_file,
				@t_from         = @w_sp_name,
				@i_num          = 355019,
                        @i_pit          = @i_pit
			return 355019
		end  
	end
end
else
begin
	if @w_status = 'P'
	begin
		update cob_remesas..re_cheque_rec
		   set cr_status         = 'D',
			cr_fecha_efe      = @w_fecha_hoy,
			cr_cau_devolucion = @i_causadev,
			cr_procesado  	  = 'N'
		 where cr_cheque_rec = @i_chq
		if @@error != 0
		begin
			exec cobis..sp_cerror1
				@t_debug        = @t_debug,
				@t_file         = @t_file,
				@t_from         = @w_sp_name,
				@i_num          = 355000,
                        @i_pit          = @i_pit
			return 355000
		end

		update cob_remesas..re_det_carta
		   set dc_status	= 'D',
			dc_fecha_efe	= @w_fecha_hoy,
			dc_portes_dev	= @w_portes,
			dc_iva_dev	= @w_iva
		where dc_carta   = @i_secuen
		  and dc_cheque  = @i_chq
		if @@error != 0
		begin
			exec cobis..sp_cerror1
				@t_debug        = @t_debug,
				@t_file         = @t_file,
				@t_from         = @w_sp_name,
				@i_num          = 355019,
                        @i_pit          = @i_pit
			return 355019
		end    
		if @w_cajeroint = 'S'
		begin 
			update cob_cuentas..cc_chq_otrdept
			   set cd_estado      = 'D',
				cd_fecha_ope       = @w_fecha_hoy,
				cd_causadev        = @i_causadev
			 where cd_banco_chq = @w_bco_p
			   and cd_cta_chq   = @w_cta_girada
			   and cd_num_chq   = @w_num_cheque
			if @@error != 0
			begin
				exec cobis..sp_cerror1
					@t_debug        = @t_debug,
					@t_file         = @t_file,
					@t_from         = @w_sp_name,
					@i_num          = 355019,
                              @i_pit          = @i_pit
				return 355019
			end                                
		end 
	end
else
begin
	if @w_status = 'D'
	begin
		exec cobis..sp_cerror1
			@t_debug        = @t_debug,
			@t_file         = @t_file,
			@t_from         = @w_sp_name,
			@i_num          = 355018,
                  @i_pit          = @i_pit
		return 355018
	end
	if @w_status = 'C'
	begin
		exec cobis..sp_cerror1
			@t_debug        = @t_debug,
			@t_file         = @t_file,
			@t_from         = @w_sp_name,
			@i_num          = 355017,
                  @i_pit          = @i_pit
		return 355017
	end
end 
end

/* Actualiza la carta del cheque */
   if @w_num_cheques > 1
      begin
        update cob_remesas..re_carta
           set ct_num_cheques = ct_num_cheques - @w_factor,
               ct_valor = ct_valor - (@i_val * @w_factor)
         where ct_banco_e   = @w_bco_e
           and ct_oficina_e = @w_ofi_e
           and ct_ciudad_e  = @w_ciu_e
           and ct_banco_p   = @w_bco_p
           and ct_oficina_p = @w_ofi_p
           and ct_ciudad_p  = @w_ciu_p
           and ct_fecha_emi = @i_fecha
           and ct_moneda    = @i_mon
           and ct_carta     = @i_secuen
           and ct_banco_c   = @w_bco_c
           and ct_oficina_c = @w_ofi_c
           and ct_ciudad_c  = @w_ciu_c
           and ct_estado    = 'N'
      end
   else
      begin
         if @w_factor = 1
            begin 
     	       update cob_remesas..re_carta
     	          set ct_num_cheques = ct_num_cheques - @w_factor,
         	      ct_valor = ct_valor - (@i_val * @w_factor),
		      ct_estado = 'C',
		      ct_fecha_efe       = @w_fecha_hoy
     	        where ct_banco_e   = @w_bco_e
     	          and ct_oficina_e = @w_ofi_e
     	          and ct_ciudad_e  = @w_ciu_e
     	          and ct_banco_p   = @w_bco_p
     	          and ct_oficina_p = @w_ofi_p
     	          and ct_ciudad_p  = @w_ciu_p
     	          and ct_fecha_emi = @i_fecha
     	          and ct_moneda    = @i_mon
                  and ct_carta     = @i_secuen
     	          and ct_banco_c   = @w_bco_c
     	          and ct_oficina_c = @w_ofi_c
     	          and ct_ciudad_c  = @w_ciu_c
     	          and ct_estado    = 'N'
            end
          else
             begin
     	        update cob_remesas..re_carta
     	           set ct_num_cheques = ct_num_cheques - @w_factor,
         	       ct_valor = ct_valor - (@i_val * @w_factor),
		       ct_estado = 'N'
     	         where ct_banco_e   = @w_bco_e
     	           and ct_oficina_e = @w_ofi_e
     	           and ct_ciudad_e  = @w_ciu_e
     	           and ct_banco_p   = @w_bco_p
     	           and ct_oficina_p = @w_ofi_p
     	           and ct_ciudad_p  = @w_ciu_p
     	           and ct_fecha_emi = @i_fecha
     	           and ct_moneda    = @i_mon
                   and ct_carta     = @i_secuen
     	           and ct_banco_c   = @w_bco_c
     	           and ct_oficina_c = @w_ofi_c
     	           and ct_ciudad_c  = @w_ciu_c
     	           and ct_estado    = 'C'
             end
      end

   select @w_reverso = null,
          @w_signo = 'D'
   if @t_corr = 'S' and @w_cajeroint = 'N'
    begin
       select @w_reverso = 'R',
              @w_signo = 'C'
       if @i_hablt = 'C'
        begin
           select @w_ssn_corr = tm_secuencial
             from cob_cuentas..cc_tran_monet
            where tm_cta_banco   = @i_ctadep
              and tm_cod_alterno = 19
              and tm_tipo_tran   = 2645
              and tm_oficina     = @s_ofi
              and tm_usuario     = @s_user
              and tm_correccion  = 'N'
              and tm_nodo        = @s_lsrv
              and tm_signo       = 'D'
              and tm_valor       = @i_val
              and tm_indicador   = @w_indicador
              and tm_cheque      = @i_chq
              and tm_moneda      = @i_mon
              and tm_estado is null

           if @@rowcount != 1
              begin
                 exec cobis..sp_cerror1
                      @t_debug        = @t_debug,
                      @t_file         = @t_file,
                      @t_from         = @w_sp_name,
                      @i_num          = 251067,
                      @i_pit          = @i_pit
                 return 251067
              end
        end

       if @i_hablt = 'A'
        begin
           select @w_ssn_corr = tm_secuencial
             from cob_ahorros..ah_tran_monet
            where tm_cta_banco   = @i_ctadep
              and tm_cod_alterno = 19
              and tm_tipo_tran   = 224
              and tm_oficina     = @s_ofi
              and tm_usuario     = @s_user
              and tm_correccion  = 'N'
              and tm_nodo        = @s_lsrv
              and tm_signo       = 'D'
              and tm_valor       = @i_val
              and tm_indicador   = 4
              and tm_moneda      = @i_mon
              and tm_estado is null

           if @@rowcount != 1
              begin
                 exec cobis..sp_cerror1
                      @t_debug        = @t_debug,
                      @t_file         = @t_file,
                      @t_from         = @w_sp_name,
                      @i_num          = 251067,
                      @i_pit          = @i_pit
                 return 251067
              end
        end
    end
/* Actualiza la cuenta depositada */
   select @w_rpc = 'cob_remesas.sp_actualiza_cuenta'
   if @w_tipo = 'L'
      select @w_rpc = 'cob_remesas..sp_actualiza_cuenta'
    else
       if @w_tipo = 'R'
          select @w_rpc = @w_server_local + '.' + @w_server_rem + '.' + @w_rpc

/* Actualiza la cuentas */
   if @s_org = 'U' and @w_cajeroint = 'N'
      begin
	exec @w_return = @w_rpc
		@t_debug	     = @t_debug,
                @t_from              = @w_sp_name,
                @t_file              = @t_file,
                @t_trn               = @t_trn,
                @s_ssn               = @s_ssn,
                @s_term              = @s_term,
                @s_user              = @s_user,
                @s_srv               = @s_srv,
                @s_lsrv              = @s_lsrv,
                @t_ssn_corr          = @w_ssn_corr,
                @i_cta               = @i_ctadep,
                @i_cuenta            = @w_cuenta,
                @i_fecha             = @w_fecha_hoy,
--		@i_val 	             = @i_val,
		@i_val 	             = @w_valor_neto,
		@i_prddep            = @i_prddep,
		@i_mon               = @i_mon,
		@i_factor            = @w_factor,
		@i_ofi		     = @s_ofi,
                @i_oficina_dep       = @w_ofic_dep,
                @i_pit               = @i_pit,
                @i_chq               = @i_chq,
                @o_saldocont         = @w_saldocont out,
                @o_saldodisp         = @w_saldodisp out,
                @o_control           = @w_control out
	if @w_return <> 0
	    return @w_return
      end
      
   select @w_causa_cont = convert(varchar(3),convert(int, tn_causa_contab))
   from cob_remesas..re_transito
   where tn_nombre  = @w_ciu_p
     and tn_banco_p = @w_bco_c		--Banco Corresponsal
   if @@rowcount <> 1
   begin
       /* Ruta y transito no existe */
       exec cobis..sp_cerror
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 201150
       return 201150
   end                      

/* Actualiza totales y transaccion de servicio */
   if @i_hablt = 'C'
      begin
             /* Correccion de Transaccion Monetaria */
             if @t_corr = 'S' and @w_cajeroint = 'N'
                begin   
                   update cob_cuentas..cc_tran_monet
                      set tm_estado = 'R'
                    where tm_secuencial  = @w_ssn_corr
                      and tm_cod_alterno = 19		--OLI 09202004
                   if @@rowcount <> 1
                     begin
                        exec cobis..sp_cerror1
                                @t_debug        = @t_debug,
                                @t_file         = @t_file,
                                @t_from         = @w_sp_name,
                                @i_num          = 251067,
                                @i_pit          = @i_pit
                        return 251067
                     end
                end
                
             /* OLI 11102004. Si es Al Cobro la oficina destino es la oficina emisora */
             if @w_tipo_rem = 'C'
                select @w_ofi_destino = @w_ofic_dep
             else
                select @w_ofi_destino = @w_oficina_p

              if     @w_proc_conta = 'P'   and  @w_tipo_rem     = 'N'
                     select  @w_indicador = 1

                            
             /* Transaccion Monetaria */
	     insert into cob_cuentas..cc_tran_monet
	                 (tm_secuencial, tm_cod_alterno, tm_tipo_tran,
                          tm_oficina, tm_usuario, tm_terminal, tm_correccion,
	                  tm_sec_correccion, tm_reentry, tm_origen,
	                  tm_nodo, tm_fecha, tm_cta_banco, tm_signo,
	                  tm_valor, tm_indicador, tm_cheque, tm_moneda,
                          tm_filial, tm_oficina_cta, tm_causa, tm_identifi_sol,
			  tm_nombre_sol, tm_tarjeta_atm, tm_estado,
			  tm_saldo_contable, tm_saldo_disponible, 
                          tm_valor_impuesto,tm_oficial,tm_cliente,tm_clase_clte,tm_prod_banc)
	         values (@s_ssn, 19, 2645,
                          @s_ofi, @s_user, @s_term, @t_corr,
	                 @w_ssn_corr, @t_rty, 'L',
	                 @s_lsrv, @s_date, @i_ctadep, @w_signo,
	                 @i_val, @w_indicador, @i_chq, @i_mon, 
	                 @w_filial, @w_ofi_destino, @w_causa_cont, @i_corres,
                         @i_propie, @i_secuen, @w_reverso,
                         @w_saldocont, @w_saldodisp, @w_val_icc,@w_oficial,@w_ente_corr,@w_clase_clte,@w_prod_banc)
	     if @@error != 0
	        begin
	           exec cobis..sp_cerror1
	                @t_debug        = @t_debug,
	                @t_file         = @t_file,
	                @t_from         = @w_sp_name,
	                @i_num          = 203000,
                      @i_pit          = @i_pit
	           return 203000
	        end

	  if @w_tipo_rem = 'N'  --CAMBIO TIPO DE REMESA DE 'S' A 'N' VMA 08/15/2002
	  begin  --3
           if exists (select * from cob_cuentas..cc_sobregiro
	                 where sb_cuenta = @w_cuenta
		             and sb_tipo = 'R'
		             and sb_fecha_ven >= @s_date)
	     begin  ---4    
	        if @w_factor = 1
	        begin
		     update cob_cuentas..cc_sobregiro
                    set sb_monto_aut = sb_monto_aut - @i_val
                  where sb_cuenta = @w_cuenta
                    and sb_tipo = 'R'
                    and sb_fecha_ven >= @s_date

                 if @@error != 0
                 begin
                    exec cobis..sp_cerror
                         @t_debug        = @t_debug,
                         @t_file         = @t_file,
                         @t_from         = @w_sp_name,
                         @i_num          = 355000
                    return 355000
                 end
              end
              else
	        if @w_factor = -1
	        begin
		     update cob_cuentas..cc_sobregiro
                    set sb_monto_aut = sb_monto_aut + @i_val
                  where sb_cuenta = @w_cuenta
                    and sb_tipo = 'R'
                    and sb_fecha_ven >= @s_date

                 if @@error != 0
                 begin
	              exec cobis..sp_cerror
                            @t_debug        = @t_debug,
                            @t_file         = @t_file,
                            @t_from         = @w_sp_name,
                            @i_num          = 355000
                    return 355000
                 end
              end
	     end  --4  
        end  ---3
   end
  else
     if @i_hablt = 'A'
        begin
             /* Correccion de Transaccion Monetaria */
             if @t_corr = 'S' and @w_cajeroint = 'N'
             begin
                update cob_ahorros..ah_tran_monet
                   set tm_estado = 'R'
                 where tm_secuencial  = @w_ssn_corr
 		   and tm_cod_alterno = 19		--OLI 09202004
                if @@rowcount <> 1
                   begin
                        exec cobis..sp_cerror1
                             @t_debug        = @t_debug,
                             @t_file         = @t_file,
                             @t_from         = @w_sp_name,
                             @i_num          = 251067,
                             @i_pit          = @i_pit
                        return 251067
                   end                 
             end


              if     @w_proc_conta = 'P'   and  @w_tipo_rem     = 'N'
                     select  @w_indicador = 1

              /* Transaccion Monetaria */
	     insert into cob_ahorros..ah_tran_monet
	                 (tm_secuencial, tm_cod_alterno, tm_tipo_tran,
                          tm_oficina, tm_usuario, tm_terminal, tm_correccion,
	                  tm_sec_correccion, tm_reentry, tm_origen,
	                  tm_nodo, tm_fecha, tm_cta_banco, tm_signo,
	                  tm_valor, tm_indicador, tm_moneda,
                          tm_filial, tm_oficina_cta, tm_causa, tm_ctadestino,
			  tm_concepto, tm_control, tm_estado,
			  tm_saldo_contable, tm_saldo_disponible, 
                          tm_valor_comision,tm_oficial,tm_cliente,tm_clase_clte,tm_prod_banc)
	         values (@s_ssn, 19, 224,
                         @s_ofi, @s_user, @s_term, @t_corr,
	                 @w_ssn_corr, @t_rty, 'L',
	                 @s_lsrv, @s_date, @i_ctadep, @w_signo,
	                 @i_val, 4, @i_mon, 
	                 @w_filial, @w_ofic_dep, @w_causa_cont, @i_corres,
                         @i_propie, @w_control, @w_reverso,
                         @w_saldocont, @w_saldodisp, @w_val_icc,@w_oficial,@w_ente_corr,@w_clase_clte,@w_prod_banc)
	     if @@error != 0
	        begin
	           exec cobis..sp_cerror1
	                @t_debug        = @t_debug,
	                @t_file         = @t_file,
	                @t_from         = @w_sp_name,
	                @i_num          = 203000,
                      @i_pit          = @i_pit
	           return 203000
	        end
        end

if @w_bco_c <> @w_cod_bco
begin
	     insert into cob_cuentas..cc_tsrem_chequeconf
	                 (secuencial, tipo_tran, oficina,
	                  usuario, terminal, correccion,
	                  ssn_corr, reentry, origen,
	                  nodo, fecha, cta_banco_dep,
	                  valor, corresponsal, propietario, nro_cheque, 
			  		  producto, moneda, carta,oficina_cta,
                          prod_banc, clase_clte, oficial,                      
                      cliente, efectivo)
	         values (@s_ssn, @t_trn,  @w_cob,		
	                 @s_user, @s_term, @t_corr,
	                 @t_ssn_corr, @t_rty, 'L',
	                 @s_lsrv, @s_date, @i_ctadep,
                         @w_iva, @i_corres, @i_propie, @i_chq,   -- @i_val, 	                
			 10, @i_mon, @i_secuen,@w_cob,
                         1,'P',@w_oficial,
                         @w_ente_corr, @w_portes)
	     if @@error != 0
	     begin
	         exec cobis..sp_cerror1
	                 @t_debug        = @t_debug,
	                 @t_file         = @t_file,
	                 @t_from         = @w_sp_name,
	                 @i_num          = 353004,
                       @i_pit          = @i_pit
	         return 353004
	     end

end
	
/* Obtiene codigo de tabla para Tipos de Cheque Remesa */
   select @w_codigo = codigo
     from cobis..cl_tabla
    where tabla = 're_tcheque'

/* Devuelve Datos del Cheque Actualizado */
select @w_ref       = cr_cheque_rec,
       @w_estado    = substring(valor,1,15)
  from cob_remesas..re_cheque_rec,
       cobis..cl_catalogo 
 where cr_cheque_rec = @i_chq
   and cr_status     = codigo
   and tabla         = @w_codigo

select @w_valorc  = ct_valor,
       @w_numchqs = ct_num_cheques
  from cob_remesas..re_carta
 where ct_carta = @i_secuen

select @w_ref,
       @w_estado,
       @w_numchqs,
       @w_valorc  

commit tran

return 0
go
