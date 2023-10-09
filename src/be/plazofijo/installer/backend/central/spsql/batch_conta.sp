/************************************************************************/
/*	Archivo: 		bt_conta.sp			        */
/*	Stored procedure: 	sp_batch_conta				*/
/*	Base de datos:  	cob_pfijo  				*/
/*	Producto:               plazo fijo                		*/
/*	Disenado por:           G. CALDERON                        	*/
/*	Fecha de escritura:     10-May/1996   				*/
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
/*	Este programa procesa las transacciones de:			*/
/*	copia desde las tablas temporales de comprobantes y asientos    */
/*	a las tablas definitivas, de contabilidad cb_scomprobante,      */
/*	cb_sasiento                                                     */
/************************************************************************/ 
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	10/Oct/1995	M.Suarez        Emision Inicial			*/
/*      20-Ene-2003     N. Silva        Encriptacion Cliente            */
/*      24-May-2006     Clotilde Vargas Inclusion de Estado X           */
/*      05/Dic/2016     A.Zuluaga       Desacople                       */
/************************************************************************/
use cob_pfijo
go
if exists (select * from sysobjects where name = 'sp_batch_conta')
	drop proc sp_batch_conta
go
create proc sp_batch_conta   (
		@s_ssn		 int         = null,
		@s_date		 datetime    = null,
		@s_user		 login       = null,
		@s_term		 descripcion = null,
		@s_corr		 char(1)     = null,
		@s_ssn_corr	 int         = null,
        	@s_ofi		 int         = null,
		@t_rty		 char(1)     = null,
        	@t_trn		 int         = null,
		@t_debug	 char(1)     = 'N',
		@t_file		 varchar(14) = null,
		@t_from		 varchar(30) = null,
		@i_empresa 	 tinyint     = null, 
		@i_fecha_proceso datetime    = null
	)
as 
declare
	@w_today 	  datetime,  	-- fecha del dia
	@w_return	  int,		-- valor que retorna 
	@w_sp_name	  varchar(32),	-- nombre del stored procedure
        @w_string         varchar(30),
        @w_error          int,
	@w_concepto       varchar(150),		
	@w_asiento        smallint,
	@w_oficina_orig   smallint,
	@w_oficina_orig_c smallint,
	@w_oficina_dest   smallint,
	@w_oficina        int,
	@w_area_orig	  int,
        @w_detalles 	  int,
        @w_producto 	  tinyint,
        @w_perfil 	  varchar(3),
        @w_digitador 	  login,
        @w_fecha_dig 	  datetime,
	@w_autorizado     char(1),
	@w_tipo_doc	  char(1),
	@w_tipo_docum	  char(1),
	@w_tipo_tran	  char(1),
        @w_tot_debito     money,
        @w_tot_credito    money,
	@w_tot_debito_me  money,
	@w_tot_credito_me money,
        @w_td_detalles 	  int,
        @w_td_debito 	  money,
        @w_td_credito 	  money,
        @w_td_debito_me   money,
        @w_td_credito_me  money,
        @w_cuenta         char(20),
	@w_debito	  money,
	@w_credito	  money,
	@w_debito_me      money,
	@w_credito_me	  money,
	@w_moneda	  tinyint,
	@w_moneda_cu	  tinyint,
	@w_moneda_base	  tinyint,
	@w_area_dest	  int,
	@w_descripcion 	  varchar(150),
	@w_comp_tipo  	  int,
	@w_debcred  	  char(1),
	@w_ok  	          tinyint,
	@w_cotizacion	  float,
	@w_comprobante	  int,
	@w_comp		  int,
	@w_param_imp	  catalogo,	--ral06-13-2000 Contab. de Terceros
	@w_base_impuesto  money,	--ral06-13-2000 Contab. de Terceros
	@w_imp_cobrado    money,	--ral06-13-2000 Contab. de Terceros
	@w_cont_ter	  char(1),	--ral06-13-2000 Contab. de Terceros
	@w_ente		  int,		--ral06-13-2000 Contab. de Terceros
	@w_tipo		  char(1),	--ral06-13-2000 Contab. de Terceros
	@w_identifica     varchar(35),	--ral06-13-2000 Contab. de Terceros
	-- Imp. a la Renta
	@w_con_ret	  char(3),	--ral06-13-2000 Contab. de Terceros
	@w_base_ret	  money,	--ral06-13-2000 Contab. de Terceros
	@w_valret	  money,	--ral06-13-2000 Contab. de Terceros
	-- IVA
	@w_con_iva	  char(3),	--ral06-13-2000 Contab. de Terceros
	@w_valor_iva	  money,	--ral06-13-2000 Contab. de Terceros
	@w_iva_retenido	  money,	--ral06-13-2000 Contab. de Terceros
	-- Timbre
	@w_con_timbre	  char(3),	--ral06-13-2000 Contab. de Terceros
	@w_valor_timbre	  money,		--ral06-13-2000 Contab. de Terceros
	@w_tran_cont	  int,		--ral06-13-2000 Contab. de Terceros
	@w_num_banco	  cuenta,		--ral06-13-2000 Contab. de Terceros
	@w_operacion      int,		--ral06-13-2000 Contab. de Terceros
        @w_sa_perfil      varchar(3),
        @w_sa_tran_modulo varchar(20),
        @w_sc_perfil      varchar(3),
        @w_sc_tran_modulo varchar(20),
        @w_desc_error     varchar(255),
        @w_num_oper       varchar(20),
        @w_sc_comprobante   int,
        @w_sc_fecha_tran    datetime,
        @w_perfil_boc       varchar(3),
        @w_tran_name        varchar(20),			--LIM 18/ENE/2006
        @w_tot_monto_db        money,				--LIM 18/ENE/2006
        @w_tot_monto_cr	    money,				--LIM 18/ENE/2006
        @w_mensaje          varchar(255),			--LIM 18/ENE/2006
        @w_err_msg 	    varchar(255),			--LIM 18/ENE/2006
        @w_desc_tran        descripcion,			--LIM 18/ENE/2006
        @w_cuenta_error     cuenta,				--LIM 26/ENE/2006
        @w_area_error	    int

select @w_sp_name = 'sp_batch_conta'

select @w_tran_name = @w_sp_name			--LIM 18/ENE/2006
---------------------------------------------------------------------------
-- Cambios para Control del BOC y borrado de errores en reproceso contable
---------------------------------------------------------------------------

exec @w_return = cob_interfase..sp_iccontable
     @t_trn       = 60025,
     @i_operacion = 'D',
     @i_empresa   =  1,
     @i_producto  = 14,
     @i_fecha     = @i_fecha_proceso   -- Faltaria en el Documento de Boc?

-----------------------
-- Contab. de Terceros
-----------------------
select @w_cont_ter = pa_char 
  from cobis..cl_parametro 
 where pa_nemonico = 'CTE'
   and pa_tipo = 'C'
   and pa_producto = 'PFI'

-------------------------------------------------------
-- Carga de Comprobantes aplicados a tablas historicas
-------------------------------------------------------
/* Actualizacion de Fecha de Transaccion de las operaciones */
Update cob_pfijo..pf_sasiento
   set sa_fecha_tran = @i_fecha_proceso
 where sa_fecha_tran < @i_fecha_proceso

/* Actualizacion de Comprobantes contables */
Update cob_pfijo..pf_scomprobante 
   set sc_fecha_tran = @i_fecha_proceso
 where sc_fecha_tran < @i_fecha_proceso

/* Carga de Comprobantes */
insert into cob_pfijo..pf_scomprobante_his
select * from cob_pfijo..pf_scomprobante
 where sc_estado in ('A','R','X') --CVA MAY-30-06

    /* Insercion de Asientos aplicados */
    insert into cob_pfijo..pf_sasiento_his
    select sa_fecha_tran, sa_comprobante , sa_empresa   , sa_asiento,
           sa_cuenta    , sa_oficina_dest, sa_area_dest , sa_credito,
           sa_debito    , sa_concepto    , sa_credito_me, sa_debito_me,
           sa_cotizacion, sa_tipo_doc    , sa_tipo_tran , sa_moneda,
           sa_opcion    , sa_fecha_est   , sa_estado    , sa_ente,
           sa_param_imp         
      from cob_pfijo..pf_sasiento,
           cob_pfijo..pf_scomprobante
     where sa_comprobante = sc_comprobante
       and sa_fecha_tran =  sc_fecha_tran
       and sc_estado in ('A','R','X') --CVA MAY-30-06

------------------------------------------------
-- Borrado de Asientos y Comprobantes Aplicados
------------------------------------------------
/* Borrado de Asientos */
delete from cob_pfijo..pf_sasiento
  from cob_pfijo..pf_sasiento,
       cob_pfijo..pf_scomprobante
     where sa_comprobante = sc_comprobante
       and sa_fecha_tran =  sc_fecha_tran
       and sc_estado in ('A','R','X') --CVA MAY-30-06

delete from cob_pfijo..pf_sasiento
  from cob_pfijo..pf_sasiento,
       cob_pfijo..pf_scomprobante
     where sa_comprobante = sc_comprobante
       and sa_fecha_tran =  sc_fecha_tran
       and sc_detalles = 0

/* Borrado de Comprobantes */
delete cob_pfijo..pf_scomprobante 
 where sc_estado in ('A','R','X') --CVA MAY-30-06

delete cob_pfijo..pf_scomprobante 
 where sc_detalles = 0

/* Borrado de comprobantes */
select @w_comp = 0


while (1= 1 )
begin
   --------------------------------
   -- Lee Cabecera del Comprobante
   --------------------------------
   set rowcount 1
   select @w_detalles       = sc_detalles,
          @w_tot_debito     = sc_tot_debito,
          @w_tot_credito    = sc_tot_credito,
          @w_tot_debito_me  = sc_tot_debito_me,
          @w_tot_credito_me = sc_tot_credito_me,
          @w_descripcion    = sc_descripcion,
          @w_fecha_dig      = sc_fecha_gra,
          @w_digitador      = sc_digitador,
          @w_perfil         = sc_perfil,
          @w_oficina_orig   = sc_oficina_orig,
          @w_comp           = sc_comprobante,
          @w_area_orig      = sc_area_orig,
          @w_sc_perfil      = sc_perfil,
          @w_sc_fecha_tran  = sc_fecha_tran        
     from cob_pfijo..pf_scomprobante 
    where sc_estado = 'I'
      and sc_fecha_tran  <= @i_fecha_proceso
      and sc_comprobante > @w_comp
      and sc_empresa 	 = @i_empresa

   if @@rowcount <> 1 
   begin
      break
   end

   select @w_desc_tran = substring(@w_descripcion,1,64) 		--LIM 18/ENE/2006

      ------------------------------------------
      -- Obtener oficina Origen del Comprobante
      ------------------------------------------
      select @w_oficina_orig_c = @w_oficina_orig

      select @w_oficina_orig = re_ofconta 
        from cob_conta..cb_relofi
       where re_ofadmin = @w_oficina_orig
         and re_filial = 1
         and re_empresa = 1

      if @@rowcount = 0
      begin
         select @w_oficina_orig = 99
         select @w_descripcion = @w_descripcion +' NO_RELOF'
      end

      begin tran 
	 --print 'bt_conta.sp DISPARA cob_conta..sp_scomprobante '
         exec @w_error          = cob_conta..sp_scomprobante
              @i_operacion      = 'I',
              @i_modo           = 0,
              @i_producto       = 14,
              @i_empresa        = 1,
              @i_fecha_tran     = @i_fecha_proceso,
              @i_oficina_orig   = @w_oficina_orig,
              @i_area_orig      = @w_area_orig,
              @i_fecha_gra      = @i_fecha_proceso,
              @i_digitador      = @w_digitador,
              @i_descripcion    = @w_descripcion,
              @i_perfil         = @w_perfil,
              @i_detalles       = @w_detalles,
              @i_tot_debito     = @w_tot_debito,
              @i_tot_credito    = @w_tot_credito,
              @i_tot_debito_me  = @w_tot_debito_me,
              @i_tot_credito_me = @w_tot_credito_me,
              @i_automatico     = 0,
              @i_reversado      = 'N',
              @i_estado         = 'I',
              @i_comprobante    = 0,
              @i_perfil         = @w_sc_perfil,       -- Numero de perfil  -  se aniadio en sp_sasiento,  en sp_scomprobante ya existia antes 
              @o_comprobante    = @w_comprobante out,
              @o_desc_error     = @w_desc_error  out

         if @w_error != 0
         begin
            print 'bt_conta.sp ERROR AL REGRESAR DE cob_conta..sp_scomprobante  '+ cast( @w_error as varchar)
            select @w_perfil_boc = @w_sc_perfil
            select @w_asiento = 0
            select @w_cuenta_error = convert(varchar(10),@w_oficina_orig_c),				--LIM 26/ENE/2006
                   @w_area_error   = @w_area_orig,				--LIM 26/ENE/2006
                   @w_tran_name    = 'sp_scomprobante',			--LIM 18/ENE/2006
                   @w_tot_monto_db = @w_tot_debito,			--LIM 18/ENE/2006
                   @w_tot_monto_cr = @w_tot_credito_me 			--LIM 18/ENE/2006
            select @w_mensaje = @w_desc_error
	    GOTO ERROR
         end

         select @w_tipo_doc = 'N'

         if @w_tot_credito_me >@w_tot_debito_me
            select @w_tipo_doc = 'C'

         if @w_tot_credito_me <@w_tot_debito_me
            select @w_tipo_doc = 'V'

         select @w_ok = 1,@w_asiento = 0,
                @w_td_detalles 	= 0

         while (@w_error = 0)
         begin
            set rowcount 1
            select @w_asiento         = sa_asiento,
	   	   @w_cuenta          = sa_cuenta,
		   @w_oficina_dest    = sa_oficina_dest,
	   	   @w_area_dest       = sa_area_dest,
		   @w_credito         = sa_credito,
	 	   @w_debito          = sa_debito,
	 	   @w_concepto        = sa_concepto,
		   @w_credito_me      = sa_credito_me,
		   @w_debito_me       = sa_debito_me,
		   @w_cotizacion      = sa_cotizacion,
  		   @w_moneda          = sa_moneda,
		   @w_ente	      = sa_ente,            -- ral06-13-2000 Contab. Tercer.
		   @w_param_imp       = sa_param_imp
            from pf_sasiento
  	   where sa_empresa     = @i_empresa
             and sa_comprobante = @w_comp
             and sa_asiento > @w_asiento
           order by sa_asiento

           if @@rowcount = 0
	      if @w_asiento = 0
              begin
    	          print 'ERROR numero de detalles'
                  select @w_descripcion = 'ERROR numero de detalles ',
                         @w_cuenta_error = @w_cuenta,
                         @w_area_error   = @w_area_dest 
                  select @w_mensaje = 'No existen mas asientos para comprobante' + ' ' + rtrim(convert(varchar(10),@w_comp)) + ' ' + @w_sp_name --LIM 18/ENE/2006
                  select @w_tot_monto_cr = @w_credito,		--LIM 19/ENE/2006
                         @w_tot_monto_db = @w_debito	
		  select @w_perfil_boc = @w_sc_perfil
                  GOTO ERROR
              end
              else
	          break

            select @w_oficina_dest = re_ofconta 
              from cob_conta..cb_relofi
             where re_ofadmin = @w_oficina_dest
               and re_filial = 1
               and re_empresa = 1

            if @@rowcount = 0
            begin
               select @w_oficina_dest = 99
               select @w_descripcion = @w_descripcion +' NO_RELOF'
            end

            if @w_tipo_doc != 'N' and @w_moneda <> 0  --no moneda nacional
            begin
               if @w_credito_me > 0
                  select @w_tipo_docum = 'V'
	       if @w_debito_me > 0
                  select @w_tipo_docum = 'C'
            end
            else
               select @w_tipo_docum = 'N'

            if @w_debito > @w_credito
               select @w_debcred = '1'
            else
               select @w_debcred = '2'

 
            if @w_param_imp is not null and @w_cont_ter = 'S'
	    begin
               select @w_tran_cont = rc_cod_tran,
                      @w_num_banco = rc_num_banco
                 from pf_relacion_comp 
                where rc_comp = @w_comp

               select @w_operacion = op_operacion
                 from pf_operacion 
                where op_num_banco = @w_num_banco

               select @w_base_impuesto = mm_valor,
                      @w_imp_cobrado = mm_impuesto
                 from pf_mov_monet 
                where mm_operacion = @w_operacion
                  and mm_tran = @w_tran_cont
	
               if @w_param_imp = 'RETE'
               begin
                  select @w_con_ret = 'RETE' --este concepto deberia cambiar dependiendo de la parametrizacion
                  select @w_base_ret = @w_base_impuesto
                  select @w_valret = @w_imp_cobrado
               end
                  if @w_param_imp = 'IVA'
                     select @w_valor_iva = @w_base_impuesto
            end

            --print 'bt_conta.sp DISPARA cob_conta..sp_sasiento'
            exec @w_error = cob_conta..sp_sasiento 
                 @i_operacion    = 'I',
                 @i_fecha_tran   = @i_fecha_proceso,
                 @i_empresa      = 1,
                 @i_comprobante  = @w_comprobante,
                 @i_asiento      = @w_asiento,
                 @i_cuenta       = @w_cuenta,
                 @i_oficina_dest = @w_oficina_dest,
                 @i_area_dest    = @w_area_dest,
                 @i_credito      = @w_credito,
                 @i_debito       = @w_debito,
                 @i_concepto     = @w_concepto ,
                 @i_credito_me   = @w_credito_me,
                 @i_debito_me    = @w_debito_me,
                 @i_moneda       = @w_moneda,
                 @i_cotizacion   = @w_cotizacion,
                 @i_tipo_doc     = @w_tipo_docum,
                 @i_tipo_tran    = 'B',
                 @i_producto     = 14,
                 @i_debcred      = @w_debcred,
                 @i_perfil       = @w_sa_perfil,       -- Numero de perfil  -  se aniadio en sp_sasiento,  en sp_scomprobante ya existia antes 
                 @i_tran_modulo  = @w_sa_tran_modulo,  -- cadena que identifique a la transaccion del modulo 
                 @o_desc_error   = @w_desc_error  out

             if @w_error <> 0
             begin
                  print 'bt_conta.sp ERROR REGRESA de cob_conta..sp_sasiento'+ cast( @w_error as varchar)
                  select @w_num_oper = substring(@w_concepto,charindex('(',@w_concepto),20)
                  select @w_tran_name = 'sp_sasiento',					--LIM 18/ENE/2006
                         @w_tot_monto_cr = @w_credito,
                         @w_tot_monto_db = @w_debito,
		         @w_cuenta_error = @w_cuenta,					--LIM 26/ENE/2006
                         @w_area_error   = @w_area_dest					--LIM 26/ENE/2006
                  select @w_descripcion = substring(@w_sc_tran_modulo,1,7) +  rtrim(ltrim(@w_num_oper)) 
                  select @w_mensaje = @w_desc_error
                  if isnull(@w_num_oper,'0') = '0'
                     select @w_descripcion = substring(@w_concepto,1,20)
                  select @w_perfil_boc = @w_sc_perfil
                  GOTO ERROR
                  select @w_ok = 0
	          break
            end
	    select @w_td_debito   = @w_td_debito + @w_debito,
                   @w_td_credito  = @w_td_credito + @w_credito,
                   @w_td_detalles = @w_td_detalles + 1 
         end --while 2 = 2
         
         if @w_detalles <> @w_td_detalles 
         begin
             print 'bt_conta.sp NUM. DETALLES NO COINCIDEN'
             select @w_asiento = 0
             select @w_perfil_boc = @w_perfil
	     select @w_tot_monto_db = @w_tot_debito,		--LIM 19/ENE/2006
                    @w_tot_monto_cr = @w_tot_credito,
		    @w_cuenta_error = @w_cuenta, 		--LIM 26/ENE/2006
		    @w_area_error   = @w_area_dest,		--LIM 26/ENE/2006
                    @w_mensaje = 'Num. detalles no coinciden comprobante ' + ' ' + rtrim(convert(varchar(10),@w_comp)) + ' ' + @w_sp_name --LIM 18/ENE/2006		
             GOTO ERROR
             select @w_ok = 0
         end

         if @w_ok = 1
         begin
            update pf_scomprobante 
               set sc_estado = 'A'
             where sc_comprobante = @w_comp
               and sc_empresa     = @i_empresa
            if @@rowcount <> 1
            begin
               print 'bt_conta.sp ERROR ACTUALIZAR PF_SCOMPROBANTE'
               select @w_descripcion = 'Numero de detalles incorrecto'
               select @w_tot_monto_db = @w_tot_debito,			--LIM 18/ENE/2006
                      @w_tot_monto_cr = @w_tot_credito,                  
                      @w_cuenta_error = @w_cuenta,			--LIM 26/ENE/2006
		      @w_area_error   = @w_area_dest			--LIM 26/ENE/2006
               select @w_mensaje = 'Error actualizar pf_scomprobante' + ' ' + rtrim(convert(varchar(10), @w_comp)) + @w_sp_name	--LIM 18/ENE/2006
               select @w_asiento = 0
               select @w_perfil_boc = @w_sa_perfil
               GOTO ERROR
            end
            commit tran
         end

     GOTO SIGUIENTE

     -------------------------------------------------
     -- Control de error para la herramienta contable
     -------------------------------------------------
ERROR:
     rollback tran
     select @w_err_msg = mensaje
       from cobis..cl_errores
      where numero = @w_error 


     select @w_err_msg = @w_mensaje + ' ' + rtrim(@w_err_msg)
     

     insert into pf_error_conta (
	ec_fecha, 		ec_moneda, 	ec_ofi_orig,
	ec_ofi_dest,		ec_perfil, 	ec_valor,
	ec_valor_me,		ec_descripcion, ec_tipo_tran,
        ec_cuenta,		ec_area)
     values(
        @i_fecha_proceso,	@w_moneda,	@w_oficina_orig,
        @w_oficina_dest, 	@w_perfil,      @w_tot_monto_db,    
        @w_tot_monto_cr, 	@w_err_msg,	@w_desc_tran,
        @w_cuenta_error,        @w_area_error) 

    select @w_error = 0
        
    --I. CVA May-13-2006 
        
           update pf_scomprobante 
	      set sc_estado = 'X'
             where sc_comprobante = @w_comp
               and sc_empresa = @i_empresa
    --F. CVA May-13-2006      



SIGUIENTE:
   end  --while 1= 1

   if @w_return != 0
   begin
      select @w_error = @w_return

      return 1
   end

return 0  
go
