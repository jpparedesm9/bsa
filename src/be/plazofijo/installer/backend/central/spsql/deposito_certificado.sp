/*depcerti.sp*/
/************************************************************************/
/*	Archivo: 		depcerti.sp                             */
/*	Stored procedure: 	sp_deposito_certificado        		*/
/*	Base de datos:  	cob_pfijo				*/
/*	Producto:               Plazo Fijo	 			*/
/*	Disenado por:           Marcelo Cartagena			*/
/*	Fecha de escritura:     23-Oct-1999				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	'MACOSA', representantes exclusivos para el Ecuador de la 	*/
/*	'NCR CORPORATION'.						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa procesa la transaccion de cajeros         	*/
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*  07/09/2001   Memito Saborio		Ingreso de nuevas variables     */
/*  24-May-2005  N. Silva               Correcciones e identacion       */
/*  22-Feb-2007  P. Coello              Grabar numero de DPF en la trn  */
/*  22-Feb-2007  P. Coello              de servicio de cuenta corriente */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_deposito_certificado')
	drop proc sp_deposito_certificado
go
create proc sp_deposito_certificado (
@s_ssn                  int,
@s_srv                  varchar(30),
@s_lsrv                 varchar(30),
@s_user                 varchar(30),
@s_sesn                 int         = NULL,
@s_term                 varchar(10),
@s_date                 datetime,
@s_ofi                  smallint,           -- Localidad origen transaccion 
@s_rol                  smallint,
@s_org_err              char(1)     = NULL,   -- Origen de error: [A], [S] 
@s_error                int         = NULL,
@s_sev                  tinyint     = NULL,
@s_msg                  mensaje     = NULL,
@s_org                  char(1),
@s_ssn_branch           int,
@t_corr                 char(1)     = 'N',
@t_ssn_corr             int         = NULL,   -- Trans a ser reversada 
@t_debug                char(1)     = 'N',
@t_file                 varchar(14) = NULL,
@t_from                 varchar(32) = NULL,
@t_rty                  char(1)     = 'N',
@t_trn                  smallint,
@i_cert                 cuenta,
@i_total                money,
@i_efe                  money       = 0,        -- Efectivo
@i_prop                 money       = 0,        -- Cheques propios
@i_cib                  money       = 0,        -- Cheques propios CIB
@i_loc                  money       = 0,        -- Cheques locales
@i_cext                 money       = 0,        -- Cheques del exterios
@i_otros                money       = 0,        -- Otros Valores
@i_inter                money       = 0,        -- Tramite interno
@i_plaz                 money       = 0,
@i_mon                  tinyint,
@i_nocaja               char(1)     = 'N',
@i_empresa              tinyint     = 1,
@i_secuencial           int         = NULL,   -- Cambio Global
@i_causa                char(1),
@i_filial               smallint    = 1,
@i_sld_caja             money       = 0,
@i_idcierre             int         = 0,
@i_idcaja               int         = 0,
@o_nombre               varchar(25) = NULL out)
with encryption
as
declare
@w_return               int,
@w_sp_name              varchar(30),
@w_factor               int,
@w_estado               varchar(1),
@w_signo                char(1),
@w_tot_efectivo         money,
@w_tot_chqlocal         money,
@w_tot_chqremes         money,
@w_fondo                money,
@w_diferencia           money,
@w_efectivo_dep         money,
@w_efec_cert            money, 
@w_loc_cert             money,
@w_plaz_cert            money,
@w_cbco_cert            money,
@w_ccib_cert            money,
@w_cext_cert            money,
@w_oval_cert            money,
@w_trai_cert            money,
@w_ente                 int,
@w_operacion            int,
@w_fecha_activacion     datetime,
@w_fecha_vencimiento    datetime,
@w_monto                money,
@w_tasa                 float,
@w_plazo                smallint,
@w_periodicidad         catalogo,
@w_retiene_impuesto     char(1), 
@w_moneda               tinyint,
@w_oficina              smallint,
@w_moneda_base          tinyint,
@w_st_secuencia         int,       
@w_tran_totales         int,
@w_aprobado             char(1),
@w_op_estado            char(3),
@w_valor                money,       --LIM 04/OCT/2005
@w_producto             catalogo,     --LIM 04/OCT/2005
@w_contador             tinyint,     --LIM 04/OCT/2005
@w_registros            tinyint,      --LIM 04/OCT/2005
@w_secuencia            int,
@w_sub_secuencia        tinyint,
@s_ssn_branch_rev       int,
@w_plazo_orig           int,
@w_cuenta_new           varchar(24),
@w_nombre               varchar(64),
@w_max_fecha_crea       datetime,
@w_existe_caja          int
   
/*  Captura nombre de Stored Procedure  */
select	@w_sp_name = 'sp_deposito_certificado'

----------------------------------------
-- Obtener el codigo de moneda nacional
----------------------------------------
select @w_moneda_base = em_moneda_base
  from cob_conta..cb_empresa
 where em_empresa = @i_empresa

if @@rowcount = 0 
begin
    exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 601018 
    return  1
end 

-----------------------------------
-- Valida si se ha aperturado caja
-----------------------------------
if @s_org = 'U' and @i_nocaja <> 'S'
begin
   if @i_idcaja = 0 /*Version ATX*/ 
   begin   
      exec @w_return          = cob_interfase..sp_iremesas
           @i_operacion       = 'U',
           @i_filial          = @i_filial,
           @s_ofi		      = @s_ofi,
           @s_rol		      = @s_rol,
           @s_user		      = @s_user,
           @i_moneda		  = @i_mon,
           @i_transaccion	  = 15,
		   @o_existe_caja     = @w_existe_caja out
      
	  if @w_existe_caja > 0 begin
	     select @t_debug = 'N'
      end else
      begin
	     exec cobis..sp_cerror
	     @t_debug  = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 201063
         return 201063
      end
   end
   else  /*Version Branch Explorer*/
   begin
      /** Verificar que la caja se encuentre aperturada **/
      exec @w_return          = cob_interfase..sp_iremesas
           @i_operacion       = 'X',
           @s_srv             = @s_srv,
           @s_ofi             = @s_ofi,
           @t_trn             = @t_trn,
           @s_user            = @s_user,
           @s_date            = @s_date,
           @i_filial          = @i_filial,
           @s_ofi             = @s_ofi,
           @i_moneda          = @i_mon,
           @i_idcaja          = @i_idcaja

      if @w_return <> 0
         return @w_return
   end
end


if @t_trn <> 14545 
begin
   /* Error en codigo de transaccion */
   exec cobis..sp_cerror
        @t_debug     = @t_debug,
	@t_file      = @t_file,
	@t_from      = @w_sp_name,
	@i_num	     = 141040 
   return 141040 
end

if @i_causa = '1'
   select @w_tran_totales = 14901 --Apertura
if @i_causa = '2'
   select @w_tran_totales = 14995 --Incrementos de Renovacion

------------------------------------------------------------------------------------------------------
-- Verificacion de Datos con certificado, Modificacion por JSA: introduccion de nuevas formas de pago 
------------------------------------------------------------------------------------------------------
if @t_corr = 'N' --and  @i_causa = '1' 
begin
   if @i_mon = @w_moneda_base
   begin
      select @w_efec_cert =isnull(sum(st_valor),0)
        from cob_pfijo..pf_secuen_ticket
       where st_num_banco = @i_cert
         and st_estado = 'I'
         and st_fpago = 'EFEC'
         and st_moneda = @i_mon

/*
      select @w_cbco_cert= isnull(sum(st_valor),0)
        from cob_pfijo..pf_secuen_ticket
       where st_num_banco = @i_cert
        and st_estado = 'I'
        and st_fpago in ('CHQP', 'CHG')
        and st_moneda = @i_mon
*/

      select @w_loc_cert = isnull(sum(st_valor),0)
        from cob_pfijo..pf_secuen_ticket
       where st_num_banco = @i_cert
         and st_estado = 'I'
         and st_fpago in ('CHQL','CHQI') --CVA Set-15-05
         and st_moneda = @i_mon


 /*     select @w_cext_cert = isnull(sum(st_valor),0)
        from cob_pfijo..pf_secuen_ticket
       where st_num_banco = @i_cert
         and st_estado = 'I'
         and st_fpago in ('CHQE')
         and st_moneda = @i_mon
*/         
   end
   else
   begin
      select @w_efec_cert =isnull(sum(st_valor_ext),0)
        from cob_pfijo..pf_secuen_ticket
       where st_num_banco = @i_cert
         and st_estado = 'I'
         and st_fpago = 'EFEC'
         and st_moneda = @i_mon

/*
      select @w_cbco_cert= isnull(sum(st_valor_ext),0)
        from cob_pfijo..pf_secuen_ticket
       where st_num_banco = @i_cert
        and st_estado = 'I'
        and st_fpago in ('CHQP', 'CHG')
        and st_moneda = @i_mon
*/

      select @w_loc_cert = isnull(sum(st_valor_ext),0)
        from cob_pfijo..pf_secuen_ticket
       where st_num_banco = @i_cert
         and st_estado = 'I'
         and st_fpago in ('CHQL','CHQI') --CVA Set-15-05
         and st_moneda = @i_mon

/*
      select @w_cext_cert = isnull(sum(st_valor_ext),0)
        from cob_pfijo..pf_secuen_ticket
       where st_num_banco = @i_cert
         and st_estado = 'I'
         and st_fpago in ('CHQE')
         and st_moneda = @i_mon
*/

   end




if @t_debug = 'S' print ' @w_efec_cert ' + cast  ( @w_efec_cert as varchar)
if @t_debug = 'S' print ' @i_efe ' + cast  ( @i_efe as varchar)



if @t_debug = 'S' print ' @w_loc_cert ' + cast  ( @w_loc_cert as varchar)
if @t_debug = 'S' print ' @i_loc ' + cast  ( @i_loc as varchar)


   if (isnull(@w_efec_cert,0) <> @i_efe)   or  
      --(isnull(@w_cbco_cert,0) <> @i_prop)  or
      (isnull(@w_loc_cert, 0) <> @i_loc)   
      --(isnull(@w_cext_cert,0) <> @i_cext)  or 
      --(isnull(@w_ccib_cert,0) <> @i_cib)   or 
      --(isnull(@w_oval_cert,0) <> @i_otros) or
      --(isnull(@w_trai_cert,0) <> @i_inter)
   begin
      exec cobis..sp_cerror
           @t_debug  = @t_debug,
           @t_file   = @t_file,
           @t_from   = @w_sp_name,
           @i_num    = 141012 
      return 141012 

   end
end

if not exists(select 1
              from cobis..re_estado_sucursal
              where es_filial        = @i_filial
              and   es_oficina       = @s_ofi
              and   es_fecha_estado  = @s_date
              and   es_estado = 'A' ) begin

      exec cobis..sp_cerror
           @t_debug  = @t_debug,
           @t_file   = @t_file,
           @t_from   = @w_sp_name,
           @i_num    = 141256
      return 141256
end

if not exists(SELECT  1
              FROM    cobis..ad_estado_producto  
              WHERE   ep_modulo       = 14
              AND     ep_oficina      = @s_ofi
              AND     ep_fecha_estado = @s_date
              and     ep_estado = 'A') begin

      exec cobis..sp_cerror
           @t_debug  = @t_debug,
           @t_file   = @t_file,
           @t_from   = @w_sp_name,
           @i_num    = 141257
      return 141257
end



------------------------------------------------
-- Se lee la secuencia del movimiento a aplicar 
------------------------------------------------
set rowcount 1
select @w_st_secuencia = st_secuencia
  from cob_pfijo..pf_secuen_ticket
 where st_num_banco = @i_cert
   and st_moneda    = @i_mon
   and st_estado    = 'I'

set rowcount 0
begin tran	--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*
---------------------------------------------------------------------------------------
-- Actualizacion de Totales de cajero, Modificaci=n ingresando los otros tipos de pago 
---------------------------------------------------------------------------------------
if @t_trn = 14545 and @i_nocaja <> 'S'
begin

   exec @w_return          = cob_interfase..sp_iremesas
        @i_operacion       = 'X',
        @s_ofi             = @s_ofi,
        @s_rol             = @s_rol,	
        @s_user            = @s_user,
        @i_moneda          = @i_mon,
        @t_trn             = @t_trn,
        @s_srv             = @s_srv,
        @i_tipo            = 'L',
        @t_corr            = @t_corr,
        @i_efectivo        = @i_efe,
        @i_prop            = @i_prop,
        @i_loc             = @i_loc,
        @i_cext            = @i_cext,
        @s_ssn             = @s_ssn,
        @i_filial          = @i_filial,
        @i_idcaja          = @i_idcaja,
        @i_idcierre        = @i_idcierre,
        @i_sld_caja        = @i_sld_caja,
        @i_causa           = @i_causa

   if @w_return <> 0
   begin
      exec cobis..sp_cerror
           @t_debug  = @t_debug,
           @t_file   = @t_file,
           @t_from   = @w_sp_name,
           @i_num    = 205000
      return 205000
   end
end

if @t_corr = 'N'	--No es reverso
begin

if @t_debug = 'S' print ' @i_causa ' + cast  ( @i_causa as varchar)


	if @i_causa = '1'			--LIM 04/OCT/2005  APERTURA
	begin   	
		update  cob_pfijo..pf_secuen_ticket
		set st_estado       = 'C'
		where st_num_banco = @i_cert
			and st_estado = 'I'
			and st_fpago  in ('EFEC','CHQP','CHQL','CHQE','CHG','OVAL','TRAI', 'CCIB','CHQI') --CVA Set-15-05)
			and st_moneda = @i_mon
		if @@rowcount = 0
		begin
			/* No encontrs el registro en ticket */
			exec cobis..sp_cerror
				@t_debug     = @t_debug,
				@t_file      = @t_file,
				@t_from      = @w_sp_name,
				@i_num       = 141111 
			return 141111 
		end
	end	

	select 	@w_ente              = op_ente,
		@w_operacion         = op_operacion,
		@w_fecha_activacion  = op_fecha_valor,
		@w_fecha_vencimiento = op_fecha_ven,
		@w_monto             = op_monto,
		@w_tasa              = op_tasa,
		@w_plazo             = op_num_dias,
		@w_periodicidad      = op_ppago,
		@w_retiene_impuesto  = op_retienimp, 
		@w_moneda            = op_moneda,
		@w_oficina           = op_oficina,
		@w_aprobado          = op_aprobado,
		@w_op_estado         = op_estado
	from cob_pfijo..pf_operacion
	where op_num_banco = @i_cert
		and op_estado in ('ING','ACT','VEN')
	if @@rowcount = 0
	begin
		exec cobis..sp_cerror
			@t_debug     = @t_debug,
			@t_file      = @t_file,
			@t_from      = @w_sp_name,
			@i_num       = 141004
		return 141004
	end 


if @t_debug = 'S' print ' @w_op_estado ' + cast  ( @w_op_estado as varchar)


	--------------------------------------------
	-- Incremento de Operacion para Renovacion
	--------------------------------------------
	if @i_causa = '2' 	--INCREMENTOS POR SUSPENSO
	begin
		if @w_op_estado in ('ACT','VEN')	
		begin
		        select @w_operacion = op_operacion--,
		               --@w_plazo_orig = op_tipo_plazo
                        from   pf_operacion
                        where  op_num_banco = @i_cert

			select 	@w_plazo_orig = re_plazo 
			from 	pf_renovacion
			where 	re_operacion = @w_operacion
			and	re_estado = 'I'


		        if @t_debug = 'S' print 'cert ' + @i_cert + ' @i_mon  ' + cast(@i_mon as varchar)
                        update cob_pfijo..pf_secuen_ticket
     		        set    st_estado    = 'A'
   		        where  st_num_banco = @i_cert
		        and    st_estado = 'I'
		        and    st_fpago  in ('EFEC','CHQP','CHQL','CHQE','CHG','OVAL','TRAI', 'CCIB','CHQI') --CVA Set-15-05)
		        and    st_moneda = @i_mon
		        declare @w_cod_error int
		        select @w_cod_error  = @@error
    		        if @@error <> 0
   		        begin
			  /* No encontrs el registro en ticket */
			  exec cobis..sp_cerror
				@t_debug     = @t_debug,
				@t_file      = @t_file,
				@t_from      = @w_sp_name,
				@i_num       = 145042 
    		          return 145042 
  		        end



			select @w_secuencia = max(mm_secuencia) + 1
			from   pf_mov_monet
			where  mm_operacion = @w_operacion 
			and    mm_tran      = 14995

if @t_debug = 'S' print ' @w_secuencia ' + cast  ( @w_secuencia as varchar)

				
			if @w_secuencia is null
				select @w_secuencia = 1

			exec @w_return = cob_pfijo..sp_incremento_suspenso
				@t_trn       	= 14995,
				@s_ssn          = @s_ssn,
				@s_srv          = @s_srv,
				@s_lsrv         = @s_lsrv,
				@s_user         = @s_user,
				@s_sesn         = @s_sesn,
				@s_term         = @s_term,
				@s_date         = @s_date,
				@s_ofi          = @s_ofi,
				@s_rol          = @s_rol,
				
				@s_ssn_branch   = @s_ssn_branch,
				@s_org          = @s_org,
				@i_transaccion  = 14995,
				@i_operacion    = 'I',
				@i_producto     = @w_producto,
				@i_moneda       = @i_mon,        
				@i_cuenta       = @i_cert,
				@i_total        = @i_total,
				@i_num_banco    = @i_cert,
				@i_secuencia    = @w_secuencia,
				@i_tipo         = 'B',
				@i_fecha_valor  = @s_date,
				@i_efe    	= @i_efe,
				@i_prop         = @i_prop,
				@i_loc          = @i_loc,
				@i_cext         = @i_cext	   
			if @w_return <>0
			begin
				return @w_return            	
			end	

if @t_debug = 'S' print ' @i_cert ' + cast  ( @i_cert as varchar)
if @t_debug = 'S' print ' @w_operacion ' + cast  ( @w_operacion as varchar)
if @t_debug = 'S' print ' @w_plazo_orig ' + cast  ( @w_plazo_orig as varchar)
if @t_debug = 'S' print ' @w_cuenta_new ' + cast  ( @w_cuenta_new as varchar)

	
                        exec @w_return = sp_renova_op 
                            @s_ssn           = @s_ssn,
                            @s_user          = @s_user, 
                            @s_term          = @s_term,		
	                    @s_date          = @s_date,
                            @s_srv           = @s_srv,
     	                    @s_lsrv          = @s_lsrv,
                            @s_ofi           = @s_ofi,  --CVA May-05-06
	                    @s_rol           = @s_rol,
	                    --@s_ssn_branch    = @s_ssn_branch, 
                            @t_debug         = @t_debug,
                            @t_file          = @t_file,
                            @t_from          = @w_sp_name,	
                            @t_trn           = 14918,
                            @i_fecha_proceso = @s_date,
	                    @i_cuenta_ant    = @i_cert,
                            @i_operacion     = @w_operacion, 
                            @i_cuenta_banco  = @i_cert,
                            @i_en_linea      = 'S',
	                    @i_inicio        = 0,
                            @i_fin           = 99999999,
                            @i_plazo_orig    = @w_plazo_orig,
                            @o_operacion_new = @w_cuenta_new out
                       if @w_return <> 0   
                       begin   
                          return @w_return	             	
                       end 			

if @t_debug = 'S' print ' @w_cuenta_new ' + cast  ( @w_cuenta_new as varchar)
                       
                       update pf_det_pago
                       set    dp_estado_xren = 'N',
                              dp_estado      = 'I'
                       where  dp_operacion   = @w_operacion 
                       and    dp_estado      = 'A'
                       and    dp_estado_xren = 'S'
                       --and    dp_forma_pago  = 'EFEC'
                       and    dp_fecha_crea  = @s_date
                       if @@error <> 0
   		       begin
			  /* Error en actualizacion de Detalle de pago incremento renovacion */
			  exec cobis..sp_cerror
				@t_debug     = @t_debug,
				@t_file      = @t_file,
				@t_from      = @w_sp_name,
				@i_num       = 145057 
    		          return 145057 
  		       end                     
                       
                       
		end
		else
		begin
			rollback tran
			--+-+print 'HACE ROLLBACK...'
			exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file  = @t_file,
				@t_from  = @w_sp_name,
				@i_msg = 'Operacion debe estar activa para recibir incrementos...',
				@i_num   = 141111
			return 141111		
		end
	end  --      if @w_op_estado in ('ACT','VEN')     

	---------------------------
	-- Activacion de Depositos
	---------------------------
	if @i_causa = '1'  --APERTURA DE DEPOSITO
	begin
		if @w_aprobado <> 'S'
		begin
			exec cobis..sp_cerror
				@t_debug     = @t_debug,
				@t_file      = @t_file,
				@t_from      = @w_sp_name,
				@i_num       = 141180
			return 141180
		end  
                
if @t_debug = 'S' print 'depcerti  @s_ssn_branch '+ cast( @s_ssn_branch as varchar)

		exec @w_return = cob_pfijo..sp_activa_deposito
			@s_ssn 		= @s_ssn,
			@s_srv 		= @s_srv,
		        @s_ssn_branch   = @s_ssn_branch,
			@s_lsrv 	= @s_lsrv,
			@s_user 	= @s_user,
			@s_sesn 	= @s_sesn,
			@s_term 	= @s_term,
			@s_date 	= @s_date,
			@s_ofi	 	= @s_ofi,
			@s_rol 	= @s_rol,
			@t_trn         = 14914,
			@i_num_banco   = @i_cert
		if @w_return <> 0
		begin
			exec cobis..sp_cerror
				@t_debug     = @t_debug,
				@t_file      = @t_file,
				@t_from      = @w_sp_name,
				@i_num       = 141031
			return 141031
		end
	end --if @i_causa = '1'  


   if @t_debug = 'S' print ' @i_mon ' + cast  ( @i_mon as varchar)
   if @t_debug = 'S' print ' @i_prop ' + cast  ( @i_prop as varchar)
   if @t_debug = 'S' print ' @i_loc ' + cast  ( @i_loc as varchar)
   if @t_debug = 'S' print ' @i_cext ' + cast  ( @i_cext as varchar)

	
   --Actiualizacion en caso de time_out
   exec @w_return      = cob_interfase..sp_icuentas
        @i_operacion   = 'AG',
        @s_ssn         = @s_ssn,
        @s_ssn_branch  = @s_ssn_branch,
        @t_trn         = @t_trn,
        @s_date        = @s_date,
        @s_user        = @s_user,
        @s_term        = @s_term,
        @s_ofi         = @s_ofi,
        @i_reentry     = 'N',
        @s_org         = @s_org,
        @i_cert        = @i_cert,
        @i_efe         = i_efe,
        @i_moneda      = @i_mon,
        @i_oficina     = 0,
        @i_prod_banc   = 0,
        @i_categoria   = ' ',
        @t_corr        = @t_corr,
        @t_ssn_corr    = null,
        @i_estado      = null,
        @i_monto       = @i_prop,
        @i_contratado  = @i_loc,
        @i_ocasional   = @i_cext
   
   if @w_return <> 0
      return @w_return
	

	--insert into cob_cuentas..cc_tran_servicio
	--	(ts_secuencial, ts_ssn_branch, ts_tipo_transaccion, ts_tsfecha,
	--	ts_usuario, ts_terminal, ts_oficina,
	--	ts_reentry, ts_origen, ts_cta_banco,
	--	ts_saldo, ts_moneda, ts_oficina_cta,
	--	ts_prod_banc, ts_categoria,
	--	/*ts_tipocta_super,*/	-- NYMPSQL
	--	ts_correccion,
	--	ts_monto, ts_contratado, ts_ocasional)
	--values (@s_ssn, @s_ssn_branch, @t_trn, @s_date,
	--	@s_user, @s_term, @s_ofi,
	--	'N', @s_org, @i_cert,
	--	@i_efe, @i_mon, 0,
	--	0, ' ',
	--	/*' ',*/ -- NYMPSQL
	--	@t_corr,
	--	@i_prop, @i_loc,@i_cext)
	--if @@error <> 0
	--begin
	--	/* Error en actualizacion de registro en cc_tran_servicio */
	--	exec cobis..sp_cerror
	--		@t_debug      = @t_debug,
	--		@t_file       = @t_file,
	--		@t_from       = @w_sp_name,
	--		@i_num        = 143005
	--	return 143005
	--end

		
end      /* Corrida Normal */
else
begin
	if @i_causa = '2'	
	begin
                select @w_operacion = op_operacion
                from pf_operacion
                where op_num_banco = @i_cert
		
		select @w_secuencia = max(mm_secuencia)
		from pf_mov_monet
		where mm_operacion = @w_operacion 
		and mm_tran        = 14995
                and mm_estado      = 'A'
                
				
		if @w_secuencia is null
		   select @w_secuencia = 1

		select @w_sub_secuencia = mm_sub_secuencia,
                       @s_ssn_branch_rev = mm_ssn_branch
		from pf_mov_monet
		where mm_operacion = @w_operacion 
		and mm_tran        = 14995
                and mm_estado      = 'A'
                and mm_secuencia   = @w_secuencia 

                if @t_debug = 'S' print '@w_secuencia ' + cast(@w_secuencia as varchar) +  ' @w_sub_secuencia ' + cast(@w_sub_secuencia as varchar) + ' @s_ssn_branch_rev '+ cast(@s_ssn_branch_rev as varchar) + + ' @s_ssn_branch '+ cast(@s_ssn_branch as varchar)             
		exec	@w_return = cob_pfijo..sp_incremento_suspenso
		        @t_trn       	= 14995,
		        @s_ssn          = @s_ssn,
		        @s_srv          = @s_srv,
		        @s_lsrv         = @s_lsrv,
		        @s_user         = @s_user,
		        @s_sesn         = @s_sesn,
		        @s_term         = @s_term,
		        @s_date         = @s_date,
		        @s_ofi          = @s_ofi,
		        @s_rol          = @s_rol,
			@s_ssn_branch   = @s_ssn_branch,
			@s_org          = @s_org,
		        @i_transaccion  = 14995,
		        @i_operacion    = 'R',
		        @i_producto     = @w_producto,
		        @i_moneda       = @i_mon,
		        @i_valor	= @w_valor,
		        @i_valor_ext    = @w_valor,	
		        @i_cuenta       = @i_cert,
		        @i_total        = @i_total,
		        @i_num_banco    = @i_cert,
			@i_sub_secuencia= @w_sub_secuencia,
		        @i_secuencia    = @w_secuencia,
			@i_secuencial   = @s_ssn,
			@i_tipo         = 'B',
			@i_fecha_valor  = @s_date
		if @w_return <>0
		begin
			return @w_return
		end
		
		update pf_secuen_ticket
                set    st_estado='I'
                where  st_num_banco=@i_cert
                and    st_estado='A'
                and    st_fpago in('EFEC')               
                if @@error <> 0
		begin
			/* No encontrs el registro en ticket */
			exec cobis..sp_cerror
				@t_debug     = @t_debug,
				@t_file      = @t_file,
				@t_from      = @w_sp_name,
				@i_num       = 145058
			return 145058 
		end
                
                /* habilito ultimo det pago 
                
		select 	@w_max_fecha_crea = max(dp_fecha_crea)
     		from 	cob_pfijo..pf_det_pago 
    		where 	dp_operacion          = @w_operacion
      		and 	ltrim(rtrim(dp_tipo)) in ('INT','INTV')
      		and 	dp_estado_xren        = 'N'   --CVA Oct-20-05
      		and 	dp_estado             = 'E'   --CVA Oct-20-05
   
   		update 	cob_pfijo..pf_det_pago
      		set 	dp_estado_xren = 'N', 
          		dp_estado      = 'I'
    		where 	dp_operacion          = @w_operacion
      		and 	ltrim(rtrim(dp_tipo)) in ('INT','INTV')
      		and 	dp_fecha_crea         = @w_max_fecha_crea
   
   		if @@error <> 0
   		begin
      			exec cobis..sp_cerror
	           	@t_debug       = @t_debug,
	           	@t_file        = @t_file,
	           	@t_from        = @w_sp_name,
	           	@i_num         = 145037
	      		return 1
	   	end  */

                
		/* elimino det pago de ultima renovacion */                
                
                update pf_det_pago
                set    dp_estado_xren = 'S',
                       dp_estado      = 'R'
                where  dp_operacion   = @w_operacion 
                and    dp_estado      = 'I'
                and    dp_estado_xren = 'N'
                --and    dp_forma_pago  = 'EFEC'
                and    dp_fecha_crea  = @s_date

                if @@error <> 0
   		begin
		   /* Error en actualizacion de Detalle de pago */
		   exec cobis..sp_cerror
				@t_debug     = @t_debug,
				@t_file      = @t_file,
				@t_from      = @w_sp_name,
				@i_num       = 145037 
    		          return 145037 
  		end
                
	end

	if @i_causa = '1' --Reverso de Activaci¢n
	begin
		exec @w_return = cob_pfijo..sp_reverso_activa
			@s_ssn          = @s_ssn,
			@s_srv          = @s_srv,
			@s_lsrv         = @s_lsrv,
			@s_user         = @s_user,
			@s_sesn         = @s_sesn,
			@s_term         = @s_term,
			@s_date         = @s_date,
			@s_ofi          = @s_ofi,
			@s_rol          = @s_rol,
			@s_ssn_branch   = @s_ssn_branch,
			@t_trn          = 14915,
			@i_num_banco    = @i_cert,
			@i_autorizado   = @s_user,
			@i_caja         = 'S'
		if @w_return <> 0
		begin
			return @w_return
		end
	end   
	
   exec @w_return      = cob_interfase..sp_icuentas
        @i_operacion   = 'AG',
        @s_ssn         = @s_ssn,
        @s_ssn_branch  = @s_ssn_branch,
        @t_trn         = @t_trn,
        @s_date        = @s_date,
        @s_user        = @s_user,
        @s_term        = @s_term,
        @s_ofi         = @s_ofi,
        @i_reentry     = 'N',
        @s_org         = @s_org,
        @i_cert        = @i_cert,
        @i_efe         = i_efe,
        @i_moneda      = @i_mon,
        @i_oficina     = 0,
        @i_prod_banc   = 0,
        @i_categoria   = ' ',
        @t_corr        = @t_corr,
        @t_ssn_corr    = @t_ssn_corr,
        @i_estado      = 'R',
        @i_monto       = @i_prop,
        @i_contratado  = @i_loc,
        @i_ocasional   = @i_cext
   
   if @w_return <> 0
      return @w_return
	  
   exec @w_return      = cob_interfase..sp_icuentas
        @i_operacion   = 'AH',
		@i_estado      = 'R',
		@t_ssn_corr    = @t_ssn_corr,
		@s_ofi         = @s_ofi
		
   if @w_return <> 0
      return @w_return
end 

select @o_nombre = op_descripcion
from cob_pfijo..pf_operacion
where op_num_banco = @i_cert


select 	'results_submit_rpc',
	r_nombre = @o_nombre


if @t_debug = 'S' print ' @i_sld_caja ' + cast  ( @i_sld_caja as varchar)
if @t_debug = 'S' print ' @i_idcierre ' + cast  ( @i_idcierre as varchar)
if @t_debug = 'S' print ' @s_ssn ' + cast  ( @s_ssn as varchar)

exec @w_return          = cob_interfase..sp_iremesas
     @i_operacion       = 'Z',
     @i_sld_caja        = @i_sld_caja,
     @i_idcierre        = @i_idcierre,
     @s_ssn             = @i_idcierre

if @w_return <> 0
	return @w_return

commit tran	--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*
if @w_nombre is not null
   select @w_nombre
   
--waitfor delay  '02:00:00' 
return 0
go
