/************************************************************************/
/*      Archivo:                aprobar.sp                              */
/*      Stored procedure:       sp_aprueba_deposito                     */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrcob_ito de la     */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este script cambia a las op.  de plazo fijo a aprobadas.        */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA        AUTOR               RAZON                          */
/*      03/17/2005  Gabriela Estupinan   Emision Inicial                */
/*      06-Jun-2005 N. Silva             Correcciones e identacion      */
/*	2005/11/15  Carlos Cruz D.       Verificacion de Tipo de Deposi-*/
/*                                       to                             */
/*      20-ABR-2010 RICADO MARTINEZ      Interfase de plazo fijo        */
/*                                       con ahorros                    */
/*      17-NOV-2016 ALFREDO ZULUAGA      DESACOPLE DEL MOD. AHORROS     */
/************************************************************************/ 
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if object_id('sp_aprueba_deposito') is not null
   drop proc sp_aprueba_deposito
go

create proc sp_aprueba_deposito(
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_sesn                 int             = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  smallint        = NULL,
@i_num_banco            cuenta,
@i_aprobado             char(1))
with encryption
as
declare
  @w_return                       int,
  @w_sp_name                      varchar(32),
  @w_funcionario                  login, 

  /* Variables para pf_operacion  */
  @w_operacionpf                  int,										
  @w_estado                       catalogo,
  @w_historia                     smallint,
  @w_aprobado                     char(1),
  @w_usuario                      login,
  @w_fecha_mod                    datetime,
  @w_mm_tipo			  char(1),


  /* Variables anteriores pf_operacion */
  @v_historia                     smallint,
  @v_aprobado                     char(1),
  @v_fecha_mod                    datetime,

  /* Variables para verificacion de saldos y bloqueos */
  @w_cuenta                       int,
  @w_saldo_disponible             money,
  @w_saldo_contable               money,
  @w_mensaje                      varchar(64),
  @w_tipo_bloqueo                 varchar(3), 

  /* Variables de movimiento monetario */
  @w_mm_subsecuencia              int,
  @w_mm_producto                  catalogo,
  @w_mm_moneda                    tinyint,
  @w_mm_cuenta                    cuenta,
  @w_mm_valor                     money,
  @w_toperacion                   catalogo,     --ccr Verificacion de tipo de deposito
  @w_estado_cuenta                varchar(10),
  @w_error                        int 

select @w_sp_name = 'sp_aprueba_deposito'

/*--------------------------------*/ 
/* Verifica codigo de transaccion */
/*--------------------------------*/
if @t_trn <> 14984
begin
   exec cobis..sp_cerror 
        @t_debug = @t_debug, 
        @t_file  = @t_file,
        @t_from  = @w_sp_name, 
        @i_num   = 141040
   return 141040
end

------------------------
-- Lectura del deposito
------------------------
select @w_operacionpf        = op_operacion,
       @w_estado             = op_estado,
       @w_aprobado           = op_aprobado,
       @w_historia           = op_historia,
       @w_usuario            = op_oficial,
	@w_toperacion		= op_toperacion
  from pf_operacion
 where op_num_banco = @i_num_banco  

if @@rowcount = 0
begin
   exec cobis..sp_cerror 
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name, 
        @i_num   = 141004
   return  141004
end

if not exists(	select 1 from pf_tipo_deposito
		where	td_mnemonico	= @w_toperacion
		and	td_estado	= 'A')
begin
	exec cobis..sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 141115
	return 141115
end

select @v_historia = @w_historia,
       @v_aprobado = @w_aprobado 

------------------------------------------------------------------------------------------
-- Verificar en las formas de pago si existe cuenta corriente/ahorros el saldo y bloqueo
------------------------------------------------------------------------------------------
select @w_mm_subsecuencia = 0
while 1 = 1
begin
   set rowcount 1
   select @w_mm_subsecuencia = mm_sub_secuencia,
          @w_mm_producto     = mm_producto,
          @w_mm_moneda       = mm_moneda,
          @w_mm_cuenta       = mm_cuenta,
          @w_mm_valor        = isnull(mm_valor,0) + isnull(mm_impuesto,0),
	  @w_mm_tipo         = mm_tipo  
     from pf_mov_monet
    where mm_operacion   = @w_operacionpf
      and mm_tran        = 14901
      and mm_secuencia   = 0
      and mm_sub_secuencia > @w_mm_subsecuencia
      and mm_producto in ('CTE','AHO')      
    order by mm_sub_secuencia 
    if @@rowcount = 0
    begin
       set rowcount 0
       break
    end

    select @w_mensaje = ''

    --------------------------------------------
    -- Busqueda de saldo para cuenta de ahorros
    --------------------------------------------    
    if @w_mm_producto = 'AHO'
    begin

       /* Obtener el numero secuencial de la cuenta */
       --DESACOPLE LAZ
       --select @w_cuenta = ah_cuenta
       --  from cob_interfase..iaho_ah_cuenta  -- BRON: 15/07/09  cob_ahorros..ah_cuenta
       --  where ah_cta_banco =  @w_mm_cuenta

       exec @w_error = cob_interfase..sp_iahorros
            @i_operacion      = 'A',
            @i_cuenta_banco   = @w_mm_cuenta,
            @o_cuenta         = @w_cuenta        out,
            @o_estado_cuenta  = @w_estado_cuenta out,
            @o_tipo_bloqueo   = @w_tipo_bloqueo  out

       if @w_error <> 0
       begin
          select @w_mensaje = 'Error Ejecutando cob_interfase..sp_iahorros. Estado Cuenta'
          exec cobis..sp_cerror 
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name, 	      
	       @i_msg   = @w_mensaje,
               @i_num   = 141004
          return  141004
       end

      if @w_cuenta is null   --if @@rowcount = 0
      begin
	 select @w_mensaje = 'Cuenta de Ahorros no existe'
         exec cobis..sp_cerror 
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name, 	      
	      @i_msg   = @w_mensaje,
              @i_num   = 141004
         return  141004
      end
   
      /* Validar si la operacion esta bloqueada */
      --DESACOPLE LAZ
      --select @w_tipo_bloqueo = cb_tipo_bloqueo
      --  from cob_interfase..iaho_ah_ctabloqueada   -- BRON: 15/07/09  cob_ahorros..ah_ctabloqueada
      -- where cb_cuenta = @w_cuenta
      --   and cb_estado = 'V'
      --   and (cb_tipo_bloqueo = '2'
      --    or  cb_tipo_bloqueo = '3')
	
      if @w_tipo_bloqueo <> ''   --if @@rowcount <> 0
      begin
         select @w_mensaje = rtrim(valor)
           from cobis..cl_catalogo
          where tabla = (select codigo 
                           from cobis..cl_tabla
   	                  where tabla = 'ah_tbloqueo')
                            and codigo = @w_tipo_bloqueo

         select @w_mensaje = 'Cuenta bloqueada: ' + @w_mensaje
         
         exec cobis..sp_cerror 
              @t_debug  = null,
      	      @t_file   = null,
     	      @t_from   = @w_sp_name,
     	      @i_num    = 201008, 
     	      @i_sev    = 1, 
     	      @i_msg    = @w_mensaje
         return 201008 
      end

      /* Obtener el numero secuencial de la cuenta */    

      exec @w_error = cob_interfase..sp_iahorros    -- BRON: 15/07/09  cob_ahorros..sp_ahcalcula_saldo 
           @i_operacion         = 'S',
           @i_cuenta_banco      = @w_mm_cuenta,
           @i_cuenta            = @w_cuenta,
           @i_fecha             = @s_date,
           @o_saldo_girar       = @w_saldo_disponible out,
           @o_saldo_cont        = @w_saldo_contable   out

       if @w_error <> 0
       begin
          select @w_mensaje = 'Error Ejecutando cob_interfase..sp_iahorros. Saldos'
          exec cobis..sp_cerror 
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name, 	      
	       @i_msg   = @w_mensaje,
               @i_num   = 141004
          return  141004
       end

      if @w_mm_tipo = 'B' 
      begin
         --DESACOPLE
         if @w_saldo_disponible > 0
         begin	
	      if @w_saldo_disponible < @w_mm_valor
	      begin
		 select @w_mensaje = 'El cliente no tiene saldo disponible en cuenta de ahorros'
	         exec cobis..sp_cerror 
        	      @t_debug = @t_debug,
	              @t_file  = @t_file,
        	      @t_from  = @w_sp_name, 
		      @i_msg   = @w_mensaje,
	              @i_num   = 141004
	         return  141004
	      end 
         end     
      end
   end

   -------------------------------------------
   -- Busqueda de saldo para cuenta corriente
   -------------------------------------------
   if @w_mm_producto = 'CTE'
   begin

      /* Obtener el numero secuencial de la cuenta */
      exec @w_return           = cob_interfase..sp_icuentas
           @i_operacion        = 'A',
		   @i_cta_bco_gerencia = @w_mm_cuenta,
		   @o_cta_gerencia     = @w_cuenta out

      if @w_cuenta is null
      begin
	     select @w_mensaje = 'Cuenta Corriente no existe'
         exec cobis..sp_cerror 
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name, 
              @i_msg   = @w_mensaje,
              @i_num   = 141004
         return  141004
      end

      exec @w_return       = cob_interfase..sp_icuentas
           @i_operacion    = 'AE',
           @i_cuenta       = @w_cuenta,
           @o_tipo_bloqueo = @w_tipo_bloqueo out

      if @w_tipo_bloqueo is not null
      begin
         select @w_mensaje = rtrim(valor)
         from   cobis..cl_catalogo
         where  tabla      = (select codigo from cobis..cl_tabla where tabla = 'cc_tbloqueo')
		 and    codigo     = @w_tipo_bloqueo
     
         select @w_mensaje = 'Cuenta bloqueada: ' + @w_mensaje
         exec cobis..sp_cerror 
     	      @t_from   = @w_sp_name,
     	      @i_num    = 201008, 
     	      @i_sev    = 1, 
     	      @i_msg    = @w_mensaje
         return 201008
      end
	  
      exec @w_return    = cob_interfase..sp_icuentas
           @s_ofi       = @s_ofi,
           @i_operacion = 'V',
           @t_from      = @w_sp_name,
           @i_cuenta    = @w_cuenta,
           @s_date      = @s_date,
           @o_saldo_d   = @w_saldo_disponible out,
           @o_saldo_c   = @w_saldo_contable   out

      if @w_mm_tipo = 'B' 
      begin	
	     if @w_saldo_disponible > 0
		 begin
	      if @w_saldo_disponible < @w_mm_valor
	      begin
		 select @w_mensaje = 'El cliente no tiene saldo disponible en cuenta corriente'
	         exec cobis..sp_cerror 
        	      @t_debug = @t_debug,
	              @t_file  = @t_file,
	              @t_from  = @w_sp_name, 
		      @i_msg   = @w_mensaje,
	              @i_num   = 141004
	         return  141004
	      end      
	     end      
      end
   end

   set rowcount 0       
   
end

-----------------------------------------------------
-- Verificar si el deposito fue Aprobado o Ingresado
-----------------------------------------------------

if @v_aprobado = @i_aprobado or @w_estado <> 'ING'
begin
   exec cobis..sp_cerror 
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name, 
        @i_num   = 141112
   return  141112
end

---------------------------------------------------------------
-- Verifica usuario autorizado y sus funcionarios relacionados
---------------------------------------------------------------

select @w_funcionario = fu_funcionario
  from pf_funcionario
 where fu_funcionario = @s_user			-- funcionario que se logea
   and fu_tautorizacion = 'APRO'
   and fu_func_relacionado = @w_usuario         -- funcionario que aperturo la operacion
   and fu_estado = 'A'

if @@rowcount = 0
begin
   exec cobis..sp_cerror 
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,   
        @i_num   = 141134
   return 141134
end

begin tran

   ----------------------------------
   -- Insercion en archivo historico
   ----------------------------------
   insert pf_historia (hi_operacion  , hi_secuencial, hi_fecha     , hi_trn_code,
                       hi_funcionario, hi_oficina   , hi_fecha_crea, hi_fecha_mod) 
               values (@w_operacionpf, @v_historia  , @s_date      , @t_trn,
                       @s_user       , @s_ofi       , @s_date      , @s_date)

   if @@error <> 0
   begin
      exec cobis..sp_cerror 
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,   
           @i_num   = 143006
      return 1
   end

   -------------------------------------------------------
   -- Actualizacion en operacion de historia y aprobacion
   -------------------------------------------------------
   select @w_historia = @w_historia + 1

   update pf_operacion 
      set op_aprobado      = 'S',  
          op_fecha_mod     = @s_date,
          op_historia      = @w_historia
    where op_operacion = @w_operacionpf

   if @@error <> 0
   begin
      exec cobis..sp_cerror 
           @t_debug=@t_debug,
           @t_file=@t_file,
           @t_from=@w_sp_name,   
           @i_num = 145001
      return 145001
   end

   ----------------------------------------
   -- Insercion de transaccion de servicio
   ----------------------------------------
   insert ts_operacion (secuencial  , tipo_transaccion, clase      , usuario,
                        terminal    , srv             , lsrv       , fecha,
                        num_banco   , operacion       , historia   , aprobado,
                        fecha_mod)
                values (@s_ssn      , @t_trn          , 'P'        , @s_user,
                        @s_term     , @s_srv          , @s_lsrv    , @s_date,
                        @i_num_banco, @w_operacionpf  , @v_historia, @v_aprobado,
                        @v_fecha_mod )

   if @@error <> 0
   begin
      exec cobis..sp_cerror 
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 143005
      return 143005
   end

   ----------------------------------------------------------
   -- Insercion de transaccion de servicio por actualizacion
   ----------------------------------------------------------
   insert ts_operacion (secuencial  , tipo_transaccion, clase      , usuario,
                        terminal    , srv             , lsrv       , fecha,
                        num_banco   , operacion       , historia   , aprobado,
                        fecha_mod)
                values (@s_ssn      , @t_trn          , 'A'        , @s_user,
                        @s_term     , @s_srv          , @s_lsrv    , @s_date,
                        @i_num_banco, @w_operacionpf  , @w_historia, @w_aprobado,
                        @s_date) 

   if @@error <> 0
   begin
      exec cobis..sp_cerror 
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 143005
      return 143005
   end

   -------------------------------------------
   -- Insercion de Aprobacion para activacion
   -------------------------------------------
   insert pf_autorizacion (au_operacion  , au_autoriza , au_oficina, au_tautorizacion,
                           au_fecha_crea , au_num_banco, au_oficial)
                   values (@w_operacionpf, @s_user     , @s_ofi    , 'APRO',
                           @s_date       , @i_num_banco, @w_usuario)
   if @@error <> 0
   begin
      exec cobis..sp_cerror
           @t_debug          = @t_debug,
           @t_file           = @t_file,
           @t_from           = @w_sp_name,
           @i_num            = 143040
      return 143040
   end

commit tran
return 0

go
