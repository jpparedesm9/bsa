/************************************************************************/
/*	Archivo: 		inc_suspenso.sp                                     */
/*	Stored procedure: 	sp_incremento_supenso                    		*/
/*	Base de datos:  	cob_pfijo			                         	*/
/*	Producto:               Plazo Fijo	 		                     	*/
/*	Disenado por:           Luis Im	                	            	*/
/*	Fecha de escritura:     03-Oct-2005				                    */
/************************************************************************/
/*				IMPORTANTE			                                   	*/
/*	Este programa es parte de los paquetes bancarios propiedad de	    */
/*	'MACOSA', representantes exclusivos para el Ecuador de la       	*/
/*	'NCR CORPORATION'.					                                */
/*	Su uso no autorizado queda expresamente prohibido asi como	        */
/*	cualquier alteracion o agregado hecho por alguno de sus		        */
/*	usuarios sin el debido consentimiento por escrito de la 	        */
/*	Presidencia Ejecutiva de MACOSA o su representante.		            */
/*				PROPOSITO			                                 	*/
/*	Este proceso registra los valores de incremento por suspenso        */
/*      que no se han aplicado al plazo fijo                    	    */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_incremento_suspenso')
	drop proc sp_incremento_suspenso
go

create proc sp_incremento_suspenso (
	@s_ssn	    	int,
	@s_srv	        varchar(30),
	@s_lsrv	        varchar(30),
	@s_user	    	varchar(30),
	@s_sesn	        int         = NULL,
	@s_term	     	varchar(10),
	@s_date		    datetime,
	@s_ofi		    smallint,	        -- Localidad origen transaccion 
	@s_rol		    smallint,
	@s_org_err	    char(1)	    = NULL,	-- Origen de error: [A], [S] 
	@s_error	    int	    = NULL,
	@s_sev	        tinyint	    = NULL,
	@s_msg		    mensaje	    = NULL,
	@s_org		    char(1),
    @s_ssn_branch   int,
	@t_corr   	    char(1)     = 'N',
	@t_ssn_corr	    int         = NULL,	-- Trans a ser reversada 
	@t_debug	    char(1)     = 'N',
	@t_file		    varchar(14) = NULL,
	@t_from		    varchar(32) = NULL,
	@t_rty			char(1)     = 'N',
	@t_trn			smallint,
	@i_operacion	char(1),
    @i_total    	money       = 0,
	@i_efe	        money       = 0,        -- Efectivo
	@i_prop	        money       = 0,        -- Cheques propios
	@i_cib			money       = 0,        -- Cheques propios CIB
	@i_loc	        money       = 0,        -- Cheques locales
	@i_cext			money       = 0,        -- Cheques del exterios
	@i_otros		money       = 0,        -- Otros Valores
	@i_inter        money       = 0,        -- Tramite interno
	@i_plaz	        money       = 0,
	@i_moneda       tinyint,
	@i_nocaja	    char(1)     = 'N',
    @i_empresa      tinyint     = 1,
    @i_secuencial   int         = 0,	-- Cambio Global
    @i_filial		smallint    = 1,
    @i_num_banco    cuenta,
	@i_impuesto     money       = 0,
	@i_producto     catalogo,
	@i_cotizacion   money           = 0,
	@i_valor_ext    money           = NULL,
	@i_valor        money           = NULL,
	@i_sub_secuencia        tinyint         = NULL,
	@i_tipo_cotiza          char(1)         = 'N',
	@i_cuenta               cuenta          = NULL,
	@i_beneficiario         int             = NULL,
	@i_tipo                 char(1)         = NULL,	
	@i_impuesto_capital_me  money           = 0,
	@i_tipo_cliente	        char(1)	      = 'M',
	@i_autorizado	        char(1)	      = 'N',
	@i_ttransito	        smallint        = NULL,
	@i_fecha_valor          datetime        = NULL,
	@i_cta_corresp          cuenta          = NULL,
	@i_cod_corresp          catalogo        = NULL,
   	@i_benef_corresp        varchar(245)    = NULL,
   	@i_ofic_corresp         int             = NULL,
    @i_transaccion          int             = NULL,
    @i_secuencia            int             = NULL,
    @i_revordpago           char(1)         = 'N',
    @i_op_operacion         int             = NULL,
    @i_tr_sec_mov           int             = NULL,   --GAR para atar con transferencia
    @i_sec_emicheq          int             = NULL,
    @i_estado               catalogo         = NULL,
    @i_num_cheque           int             = NULL,
    @i_tipo_cuenta_ach      char(1)         = NULL,
    @i_banco_ach            descripcion     = NULL
)
with encryption
as
declare	@w_return            		int,
	@w_sp_name           		varchar(30),
        @w_estado            		catalogo,
	@w_operacionpf       		int,
        @w_valor_inc_susp    		money,
	@w_moneda_base       		tinyint,
	@w_cotizacion_compra_billete    money,
	@w_cotizacion_conta  		money,
	@w_impuesto                     money,	
	@w_cotizacion			money,
	@w_valor_ext			money,
	@w_valor                        money,
	@w_tipo_cotiza                  char(1),
	@w_cotizacion_venta_billete     money,
	@w_secuencia_aplm               int,
        @w_retiene_capital              char(1),
	@w_mm_sub_secuencia             int,
	@w_mm_producto                  int,
	@w_mm_moneda                    tinyint,
	@w_valor1                       money,
	@w_contador                     int,
        @w_producto                     catalogo,
	@w_registros                    int,
        @w_ttransito                    smallint,
	@w_moneda_op                    tinyint,
        @w_historia                     int,
	@w_total			money,
        @w_incremento_suspenso          money,
        @w_oficina                      int,
        @w_toperacion                   catalogo,
        @w_fpago                        catalogo,
        @w_mon_sgte                     int,
        @w_tplazo                       catalogo,
        @w_fecha                        datetime,
        @w_descripcion                  varchar(255),
        @w_afectacion                   char(1),
        @w_tran_conta                   int,
        @w_codval                       varchar(20),
        @w_debcred                      char(1),
        @w_movmonet                     char(1),
        @w_retieneimp                   char(1),
/** Seccion Variables output **/
        @o_comprobante                  int
 

	
/*  Captura nombre de Stored Procedure  */
select	@w_sp_name = 'sp_incremento_suspenso'


if ( @i_operacion <> 'I' or  @t_trn <> 14995 ) and

   ( @i_operacion <> 'R' or  @t_trn <> 14995 )

begin

   exec cobis..sp_cerror

        @t_debug = @t_debug,

        @t_file  = @t_file,

        @t_from  = @w_sp_name,

        @i_num   = 141040

   return 141040

end


 

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

   return  601018

end      




select  @w_operacionpf	        = op_operacion, 
	@w_moneda_op 	        = op_moneda,
        @w_historia             = op_historia,
        @w_incremento_suspenso  = isnull(op_incremento_suspenso,0),
        @i_estado               = op_estado,
        @w_oficina              = op_oficina,
        @w_toperacion           = op_toperacion,
        @w_tplazo               = op_tipo_plazo,
        @w_estado               = op_estado,
        @w_mon_sgte             = op_mon_sgte,
        @w_retieneimp           = op_retienimp
from pf_operacion
where op_num_banco = @i_num_banco


select @w_total = 0

/********************************/
/*  INCREMENTO EN SUSPENSO      */
/********************************/
if @i_operacion = 'I'
begin

   select @w_contador = 0 

   if @i_efe > 0   
      select @w_contador = @w_contador + 1
   if @i_prop > 0   
      select @w_contador = @w_contador + 1
   if @i_loc > 0
      select @w_contador = @w_contador + 1
   if @i_cext > 0
      select @w_contador = @w_contador + 1

   select @w_registros = 1


   while @w_registros <= @w_contador
   begin        
	   if @i_efe > 0   
	      begin
	         select @w_valor1   = @i_efe
	         select @i_efe      = 0 
	   	 select @w_producto = 'EFEC'   
	      end
	   else
	      if @i_prop > 0   
	      begin
	         select @w_valor1 = @i_prop
	         select @i_prop = 0	
		 select @w_producto = 'CHQP'
	      end
	   else
	      if @i_loc > 0
	      begin
	         select @w_valor1 = @i_loc
	         select @i_loc   = 0	
                 select @w_producto = 'CHQL'
              end
	   else
	      if @i_cext > 0
	      begin
	         select @w_valor1 = @i_cext
	         select @i_cext = 0
	         select @w_producto = 'CHQE'
	      end

	select @i_producto = @w_producto

	select @w_ttransito = fp_ttransito from pf_fpago
	where fp_mnemonico = @i_producto

	select @i_valor     = @w_valor1, 
               @i_valor_ext = @w_valor1

      

      -------------------------------------------------------------------

      -- Calculo del valor en moneda nacional de acuerdo a la cotizacion

      -------------------------------------------------------------------

      if @i_moneda <> @w_moneda_base

      begin
	 if @i_valor = @i_valor_ext

         begin

            set rowcount 1

            select @w_cotizacion_compra_billete = co_compra_billete ,

                   @w_cotizacion_venta_billete  = co_venta_billete,

                   @w_cotizacion_conta          = co_conta

              from cob_pfijo..pf_cotizacion

             where co_moneda = @i_moneda

               and co_fecha = (select max(co_fecha)

                                 from cob_pfijo..pf_cotizacion

                                where co_moneda = @i_moneda)

            set rowcount 0



	    if @w_moneda_op = @i_moneda
            begin
               select @i_cotizacion = @w_cotizacion_conta, @w_tipo_cotiza = 'N'
            end
            else
            begin
              if @w_moneda_op = @w_moneda_base    
              begin
                select @i_cotizacion = @w_cotizacion_venta_billete, @w_tipo_cotiza = 'V'
              end
              else
              begin
                 select @i_cotizacion = @w_cotizacion_compra_billete, @w_tipo_cotiza = 'C'
              end
  	    end
 

            if @i_cotizacion = 0       

               select @w_cotizacion = @w_cotizacion_conta

            else

               select @w_cotizacion = isnull(@i_cotizacion, @w_cotizacion_conta)

                 

            select @w_valor       = @w_valor1 * @w_cotizacion,

                   @w_valor_ext   = @w_valor1,
                   @w_cotizacion  = @w_cotizacion,

                   @w_tipo_cotiza = 'V'

         end

         else

            select @w_valor       = @w_valor1,

                   @w_valor_ext   = 0,

                   @w_cotizacion  = @i_cotizacion,

                   @w_tipo_cotiza = @i_tipo_cotiza -- Se aumenta cotiz y tipo



      end

      else

      begin

         select @w_valor_ext = 0,

                @w_valor     = @i_valor

      end


      insert pf_mov_monet

                (mm_usuario         , mm_operacion  , mm_sub_secuencia,

                 mm_producto        , mm_cuenta     , mm_valor              , mm_beneficiario,

                 mm_impuesto        , mm_moneda     , mm_valor_ext          , mm_tipo,    

                 mm_fecha_crea      , mm_fecha_mod  , mm_impuesto_capital_me, mm_tipo_cliente,

                 mm_autorizado      , mm_cotizacion , mm_tipo_cotiza        , mm_ttransito, 

                 mm_fecha_valor     , mm_cta_corresp, mm_cod_corresp        , mm_benef_corresp,

                 mm_ofic_corresp    , mm_tran       , mm_secuencia          , mm_secuencial,

                 mm_sec_mov         , mm_estado     , mm_secuencia_emis_che , mm_num_cheque,

                 mm_tipo_cuenta_ach , mm_banco_ach  , mm_ssn_branch, mm_user)  

         values (@s_user            , @w_operacionpf, @w_registros,

                 @i_producto        , @i_cuenta     , @w_valor              , @i_beneficiario,

                 @w_impuesto        , @i_moneda     , @w_valor_ext          , @i_tipo,

		 @s_date            , @s_date       , @i_impuesto_capital_me, @i_tipo_cliente,

                 @i_autorizado      , @i_cotizacion , @i_tipo_cotiza        , @w_ttransito,

                 @i_fecha_valor     , @i_cta_corresp, @i_cod_corresp        , @i_benef_corresp,

                 --@i_ofic_corresp    , @i_transaccion, @i_secuencia          , @i_secuencial,
                 @i_ofic_corresp    , @i_transaccion, @w_mon_sgte          , @i_secuencial,

                 @i_tr_sec_mov      , null     ,      @i_sec_emicheq        , @i_num_cheque,

                 @i_tipo_cuenta_ach , @i_banco_ach  , @s_ssn_branch, @s_user)

      if @@error <> 0

      begin

         exec cobis..sp_cerror

              @t_debug = @t_debug,

              @t_file  = @t_file,

              @t_from  = @w_sp_name,

              @i_num   = 143022

         return 143022

      end

   ----------------------------------------
   -- Aplicacion de movimientos monetarios
   ----------------------------------------
       /*Aplicacion de los movimientos*/
       exec @w_return = sp_aplica_mov
           @s_ssn             = @s_ssn,
           @s_user            = @s_user,
           @s_ofi             = @s_ofi, 
           @s_date            = @s_date,
           @s_srv             = @s_srv,
           @s_term            = @s_term,
           @s_ssn_branch      = @s_ssn_branch,
	   @t_file            = @t_file,
           @t_from            = @w_sp_name, 
           @t_debug           = @t_debug,
           @t_trn             = @t_trn,
           @i_tipo            = 'N', 
           @i_operacionpf     = @w_operacionpf,
           @i_secuencia       = @w_mon_sgte,	--@i_secuencia, 
	   @i_sub_secuencia   = @w_registros,
           @i_retiene_capital = 'N'  
	 if @w_return <> 0
	 begin
         	exec cobis..sp_cerror
              	       @t_debug = @t_debug,
                       @t_file  = @t_file,
                       @t_from  = @w_sp_name,  
                       @i_num   = @w_return
                return @w_return
         end	
   
        select @w_total = @w_total + @w_valor 	

        select @w_registros = @w_registros + 1

   end     /*End while 1= 1*/

   -----------------------------------
   -- Contabilizacion de la operacion           
   -----------------------------------
   select @w_fpago = pa_char 
   from   cobis..cl_parametro,pf_fpago
   where  pa_producto = 'PFI'
     and  pa_nemonico = 'NSUS'
     and  pa_char = fp_mnemonico
     and  fp_estado = 'A'

   select @w_descripcion    = 'INCREMENTO EN SUSPENSO ('+ @i_num_banco + ')',
          @w_tran_conta     = 14995,
          @w_afectacion     = 'N',
          @w_codval         = '27',
          @w_debcred        = '2',
          @w_movmonet       = '1'
-- print 'incsusp.sp VALOR %1! I_SECUENCIA %2!', @w_total, @w_mon_sgte
    select @w_fecha = @s_date              

/**************

    exec @w_return = cob_pfijo..sp_aplica_conta
         @s_ssn         = @s_ssn,
         @s_date        = @s_date,
         @s_user        = @s_user,
         @s_term        = @s_term,
         @s_ofi         = @s_ofi,
         @t_debug       = @t_debug,
         @t_file        = @t_file,
         @t_from        = @t_from,
         @t_trn         = 14937,
         @i_empresa     = 1,
         @i_fecha       = @w_fecha,
         @i_tran        = @w_tran_conta,
         @i_producto    = 14,	  
         @i_oficina_oper= @w_oficina,	  -- op_oficina   
         @i_oficina     = @s_ofi,         -- oficina de transacci¢n
         @i_toperacion  = @w_toperacion,
         @i_tplazo      = @w_tplazo,    
         @i_operacionpf = @w_operacionpf,  
         @i_estado      = @w_estado ,   
         @i_afectacion  = @w_afectacion,	--'N',               -- N=Normal,  R=Reverso 
         @i_codval      = @w_codval,	        --'27', 
         @i_debcred     = @w_debcred,	        --'2',               -- Si es debito = 1 o credito = 2       
         @i_movmonet    = @w_movmonet,		--'1',
         @i_descripcion = @w_descripcion,
         @i_valor       = @w_total,             -- Valor total de la recepcion        
         @i_forma_pago  = @w_fpago,
         @i_retieneimp  = @w_retieneimp,     -- Trae valor real retiene impuestos para calculo de cotizacion
         @i_fecha_tran  = @s_date,           -- Tomar reg. de esta fecha.
         @i_secuencia   = @w_mon_sgte,       -- Toma reg. de sec. adec
         @i_moneda      = @w_moneda_op,
         @i_moneda_pago = @i_moneda,	     -- Moneda de pago mm_moneda 
         @o_comprobante = @o_comprobante out
                                 
      if @w_return <> 0
      begin
         /* Error en contabilizacion de la operacion */
         exec cobis..sp_cerror
              @t_debug         = @t_debug,
              @t_file          = @t_file,
              @t_from          = @w_sp_name,
              @i_num           = 143041
                    
         return 143041
      end
                         
      --------------------------------  
      -- Insertar en pf_relacion_comp
      --------------------------------
      insert into pf_relacion_comp 
             values (@i_num_banco,@o_comprobante,@w_tran_conta,'SUSP','N', @w_mon_sgte, 0, @w_fecha)                

***************/

      /* Insercion en pf_historia*/
	insert pf_historia (hi_operacion,     hi_secuencial,   hi_fecha,
                          hi_trn_code,        hi_funcionario,  hi_oficina,
                          hi_observacion,     hi_fecha_crea,   hi_fecha_mod, 
                          hi_valor)
                  values (@w_operacionpf,     @w_historia,   @s_date,
                          @t_trn,             @s_user,       @s_ofi, 
                          'INCREMENTO EN SUSPENSO',          @s_date,       
			  @s_date,            @i_total) 
      if @@error <> 0
         begin
            exec cobis..sp_cerror 
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,   
               @i_num = 143006
            return 143006
         end  

      select @w_historia = @w_historia + 1      	

      /*Actualizacion de monto de incrementos en suspenso*/
      if @i_estado in ('ACT','VEN')
      begin 

        select @w_incremento_suspenso = @w_incremento_suspenso + @i_total

	update pf_operacion
	    set op_incremento_suspenso = @w_incremento_suspenso,
                op_historia            = @w_historia,
                op_mon_sgte            = @w_mon_sgte + 1
	where op_operacion = @w_operacionpf
       	if @@error <> 0
        begin
	  exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 145001
          return 145001
        end
      end
end

/****************************************/
/*  REVERSO DEL INCRMENETO DESDE CAJAS  */
/****************************************/

if @i_operacion = 'R'
begin
          if @i_estado in ('ACT','VEN')
          begin
	     select @w_contador = 0 

             select @w_contador  = count(mm_operacion) 
	       from pf_mov_monet
              where mm_operacion  = @w_operacionpf
                and mm_tran	  = @t_trn
                and mm_estado     = 'A'
	     
	     select @w_mm_sub_secuencia	= 0	
		
	     select @w_registros = 0

   	     while 1=1
             begin		   
    		set rowcount 1    	
    		select  @w_mm_sub_secuencia       = mm_sub_secuencia,
           		    @w_secuencia_aplm         = mm_secuencia
        	 from pf_mov_monet
       		where mm_operacion        = @w_operacionpf
       		  and mm_fecha_aplicacion = CONVERT(varchar(10),@s_date,101)
         	  and mm_tran             = @t_trn
		      and mm_sub_secuencia    > @w_mm_sub_secuencia 
		      and mm_estado           = 'A'	
       		order by mm_sub_secuencia
              
              if @@rowcount = 0
                 break 
		
	      exec @w_return = sp_aplica_mov
           	   @s_ssn             = @s_ssn,
           	   @s_user            = @s_user,
           	   @s_ofi             = @s_ofi, 
           	   @s_date            = @s_date,
           	   @s_srv             = @s_srv,
           	   @s_term            = @s_term,
           	   @s_ssn_branch      = @s_ssn_branch,
	           @t_file            = @t_file,
           	   @t_from            = @w_sp_name, 
           	   @t_debug           = @t_debug,
           	   @t_trn             = @t_trn,
           	   @i_tipo            = 'R', 
           	   @i_operacionpf     = @w_operacionpf,
           	   @i_secuencia       = @w_secuencia_aplm, 
	   	       @i_sub_secuencia   = @w_mm_sub_secuencia,
           	   @i_retiene_capital = @w_retiene_capital  
           	   
		 if @w_return <> 0
      		 begin
         	    exec cobis..sp_cerror
              	       @t_debug = @t_debug,
                       @t_file  = @t_file,
                       @t_from  = @w_sp_name,  
                       @i_num   = @w_return
                    return @w_return
                 end	
               
          end    /*End while 1 = 1*/ 

	/* Insercion en pf_historia*/
	insert pf_historia (hi_operacion,     hi_secuencial, hi_fecha,
                          hi_trn_code,      hi_funcionario, hi_oficina,
                          hi_observacion,   hi_fecha_crea, hi_fecha_mod, 
                          hi_valor)
                  values (@w_operacionpf,     @w_historia,   @s_date,
                          @t_trn,      @s_user,       @s_ofi, 
                          'REVERSO DE INCREMENTO EN SUSPENSO',   @s_date,       @s_date, 
                          @i_total) 
        if @@error <> 0
         begin
            exec cobis..sp_cerror 
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,   
               @i_num = 143006
            return 143006
         end  

        select @w_historia = @w_historia + 1

        select @w_incremento_suspenso = @w_incremento_suspenso - @i_total

      update pf_operacion
	set op_historia  	   = @w_historia,
	    op_incremento_suspenso = @w_incremento_suspenso
      where op_operacion = @w_operacionpf

      if @@error <>0
      begin
	exec cobis..sp_cerror 
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,   
               @i_num = 143006
            return 143006
      end 

      ---------------------------------------
      -- REVERSO DE COMPROBANTES CONTABLES --
      ---------------------------------------

	 set rowcount 0
	 update pf_relacion_comp 
         set rc_estado = 'R'
	 where rc_num_banco = @i_num_banco 
           and rc_tran      = 'SUSP' 
           and rc_estado    = 'N'

	 update pf_scomprobante 
         set    sc_estado = 'R'
	 from   pf_relacion_comp 
	 where  sc_comprobante = rc_comp
           and  sc_estado      = 'I'
           and  rc_estado      = 'R'
           and  rc_tran        = 'SUSP'
           and  rc_num_banco   = @i_num_banco
          
         if @@error  <> 0
         begin
           exec cobis..sp_cerror
                     @t_debug         = @t_debug,
                     @t_file          = @t_file,
                     @t_from          = @w_sp_name,
                     @i_num           = 143041
           return 1
         end 
    end ---@i_estado in (ACT,VEN)

end --R

return 0 
go
