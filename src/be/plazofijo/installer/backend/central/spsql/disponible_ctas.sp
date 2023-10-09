/************************************************************************/
/*      Archivo:                disponible.sp                           */
/*      Stored procedure:       sp_disponible_ctas                      */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Yolanda Moya                            */
/*      Fecha de documentacion: 22-Nov-1995                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                                                                      */
/*                              PROPOSITO                               */
/*      Comprueba si existe disponible en la Cta.Cte o de Ahorros       */
/*      de la que el cliente quiere invertir.                           */
/*      Si existe retorna 0 caso contrario retorna 1.                   */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      22-Nov-95  Yolanda Moya       Creacion                          */
/*      25-Ago-00  Veronica Molina    BUsca Saldo a girar               */
/*  20-ABR-2010     RICADO MARTINEZ Interfase de plazo fijo con ahorros */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_disponible_ctas')
   drop proc sp_disponible_ctas
go

create proc sp_disponible_ctas (
      @s_ssn                  int             = NULL,
      @s_user                 login           = NULL,
      @s_term                 varchar(30)     = NULL,
      @s_date                 datetime        = NULL,
      @s_srv                  varchar(30)     = NULL,
      @s_lsrv                 varchar(30)     = NULL,
      @s_ofi                  smallint        = NULL,
      @s_rol                  smallint        = NULL,
      @t_debug                char(1)         = 'N',
      @t_file                 varchar(10)     = NULL,
      @t_from                 varchar(32)     = NULL,
      @t_trn                  smallint        = NULL,
      @i_operacion            char(1),
      @i_producto             tinyint,
      @i_cuenta               cuenta,
      @i_valor                money,
      @i_tipo                 char(1)         = NULL, -- 2=Debito/1=Credito
      @i_valida_saldo         char(1)         = 'S',  -- 'S' si valida, 'N' no valida el saldo(Pagos de interes)
      @i_valida_gmf           char(1)         = 'N'
)
with encryption
as
declare
      @w_sp_name              varchar(32),
      @w_disponible           money,
      @w_cuenta               int, 
      @w_return               int, 
      @w_saldo_para_girar     money,
      @w_saldo_contable       money,
      @w_mensaje              varchar(60),
      @w_tipo_bloqueo         catalogo,
      @w_total_gmf  	      money,
      @w_acumu_deb            money,
      @w_base_gmf             money,
      @w_actualiza            char(1)

select @w_sp_name = 'sp_disponible_ctas'

/**  VERIFICAR CODIGO DE TRANSACCION PARA QUERY  **/
if ( @i_operacion = 'Q' ) and ( @t_trn <> 14445 )
   begin
      /**  ERROR : CODIGO DE TRANSACCION PARA QUERY NO VALIDO  **/
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141042
      return 1
   end

if @i_operacion = 'Q'
   begin

      if @i_producto = 3
      begin   
         exec @w_return    = cob_interfase..sp_icuentas
              @i_operacion = 'AB',
              @i_cta_banco = @i_cuenta,
		      @o_ctacte    = @w_cuenta out
	  
	     if @w_return <> 0 or @w_cuenta is null
		 begin
	        exec cobis..sp_cerror
	        @t_from   = @w_sp_name,
	        @i_num    = 201004
	        return 201004
	     end    

	     ----------------------------------------
	     --Verifica que la cuenta no este bloqueda
	     ----------------------------------------
         if @i_tipo is not null
         begin		 
            exec @w_return       = cob_interfase..sp_icuentas
                 @i_operacion    = 'AC',
                 @i_cuenta       = @w_cuenta,
				 @i_tipo         = @i_tipo,
		         @o_tipo_bloqueo = @w_tipo_bloqueo out
		     
			if @w_return <> 0 or @w_tipo_bloqueo is not null
	        begin
	           exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 141189
               return 1
        	end
         end
		 
		 if @i_valida_saldo = 'S'
		 begin
		    exec @w_return = cob_interfase..sp_icuentas
			@s_ofi         = @s_ofi,
			@i_operacion   = 'V',
			@t_from        = @w_sp_name,
			@i_cuenta      = @w_cuenta,
            @s_date        = @s_date,
            @o_saldo_d     = @w_saldo_para_girar out,
            @o_saldo_c     = @w_saldo_contable   out
	          
            if @w_return <> 0
        	   return @w_return
			   
			if @i_valor > @w_saldo_para_girar
			begin			
               exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 141144
               return 1
            end
         end --if @i_valida_saldo = 'S'
      end --prodcuto 3


      if @i_producto = 4
      begin
	     exec @w_return       = cob_interfase..sp_iahorros
              @i_operacion    = 'A',
              @i_cuenta_banco = @i_cuenta,
              @o_cuenta       = @w_cuenta        out,
              @o_tipo_bloqueo = @w_tipo_bloqueo  out

         if @w_return <> 0
         begin
            select @w_mensaje = 'Error ejecutando sp_iahorros para hallar la cuenta'
            exec cobis..sp_cerror 
            @t_debug  = NULL,
            @t_file   = NULL,
            @t_from   = @w_sp_name,
            @i_num    = 251025, 
            @i_sev    = 1, 
            @i_msg    = @w_mensaje
         end
		 
		 if @w_cuenta > 0 and @i_tipo is not null
		 begin		 
		    if @w_tipo_bloqueo <> ''
            begin			   
			   select @w_mensaje = rtrim(valor)
		       from   cobis..cl_catalogo
		       where  tabla  = (select codigo from cobis..cl_tabla where tabla = 'ah_tbloqueo')
               and    codigo = @w_tipo_bloqueo

               select @w_mensaje = 'Cuenta bloqueada: ' + @w_mensaje
	   	       exec cobis..sp_cerror 
        	        @t_debug  = NULL,
	     	        @t_file   = NULL,
	     	        @t_from   = @w_sp_name,
	     	        @i_num    = 251025, 
		  	        @i_sev    = 1, 
                    @i_msg    = @w_mensaje
               end
            end
			
			if @i_valida_saldo = 'S'
			begin
			   exec @w_return       = cob_interfase..sp_iahorros
                    @i_operacion    = 'S',
                    @i_fecha        = @s_date,
                    @i_cuenta_banco = @i_cuenta,
                    @o_saldo_cont   = @w_saldo_contable   out,
                    @o_saldo_girar  = @w_saldo_para_girar out

	           if @w_return <> 0
                  return @w_return

               select @w_total_gmf = 0

               if @i_valida_gmf = 'S'  and @w_saldo_para_girar > 0 begin
			   
			      exec @w_return    = cob_interfase..sp_iahorros --sp_calcula_gmf
                       @i_operacion = 'Z',
                       @i_cuenta    = @w_cuenta,    
                       @i_fecha     = @s_date,
                       @i_val       = @w_disponible,
                       @o_total_gmf = @w_total_gmf out,
                       @o_acumu_deb = @w_acumu_deb out,
                       @o_base_gmf  = @w_base_gmf  out,
                       @o_actualiza = @w_actualiza out

	              if @w_return <> 0
                     return @w_return
	           end
			   
			   if @w_saldo_para_girar > 0 and @w_disponible > 0
               begin
                  select @w_disponible = @w_disponible - @w_total_gmf

   	           if @i_valor > @w_disponible    
	   	       begin
      			  exec cobis..sp_cerror
                       @t_debug = @t_debug,
                       @t_file  = @t_file,
                       @t_from  = @w_sp_name,
                       @i_num   = 141144
      		  	  return 1
               end
            end   	       
	     end --valida saldo
      end  --producto 4
      return 1
   end
else
   return 1
go
