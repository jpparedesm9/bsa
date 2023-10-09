/************************************************************************/
/*      Archivo:                vencimop.sp                             */
/*      Stored procedure:       sp_vence_op                             */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Miryam Davila                           */
/*      Fecha de documentacion: 24/Oct/94                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este script crea el Procedimiento para pasar a vencida la op.   */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      11-Dic-94   Juan Lam           Creacion                         */
/*      28-Ago-95   Carolina Alvarado  XXXXXX                           */
/*      21-Sep-95   Erika Sanchez B.   XXXXXX                           */
/*      25-Abr-2008 N. Silva           Correcciones e identacion        */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_vence_op' and type = 'P')
   drop proc sp_vence_op
go

create proc sp_vence_op (
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = 'PRESSRVP',
@s_lsrv                 varchar(30)     = 'PRESSRVP',
@s_ofi                  smallint        = 1,   
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  int             = NULL,
@i_en_linea             char(1)         = 'N',
@i_fecha_proceso        datetime,
@i_num_banco            cuenta,
@o_monto                money out,
@o_intereses            money out )
with encryption
as
declare @w_sp_name              descripcion,
        @w_string               varchar(30),
        @w_descripcion          descripcion,
        @w_return               int,
	@w_fecha                datetime,
	@w_fecha_hoy            datetime,
	@w_moneda               int,
        @w_secuencial           int,
        @w_error                int,
	@w_money                money,
        @w_impuesto             money,

	@w_ret_paga_int         varchar(30),
/** VARIABLES PARA PF_OPERACION **/
        @w_num_banco            cuenta,
	@w_operacionpf          int,
	@w_oficina_ing          int,
        @w_tplazo               catalogo, 
	@w_toperacion           catalogo,
	@w_fpago                catalogo,
        @w_producto             tinyint,
	@w_categoria            catalogo,
	@w_accion_sgte          catalogo,
	@w_estado               catalogo,
	@w_monto                money,
	@w_monto_pg_int         money,
	@w_int_estimado         money,
	@w_fecha_valor          datetime,
	@w_fecha_ven            datetime,
	@w_intereses            money,
	@w_total_int_pagados    money,
	@w_total_int_ganados    money,
	@w_oficina              smallint,
	@w_historia             smallint,
	@w_fecha_mod            datetime,
	@w_causa_mod            catalogo,
	@w_mon_sgte             int,
	@v_historia             smallint,
	@v_estado               catalogo,
	@v_fecha_mod            datetime,
	@v_causa_mod            catalogo,
	@v_total_int_pagados    money,
	@v_mon_sgte             int,
/** VARIABLES PARA PF_MOV_MONET **/
	@w_mm_sub_secuencia     tinyint,
	@w_mm_secuencial        int,
	@w_mm_producto          catalogo,
	@w_mm_cuenta            cuenta,
	@w_mm_valor             money

select @w_sp_name = 'sp_vence_op',
       @i_en_linea = isnull(@i_en_linea,'N')

/*----------------------------------*/
/*  Verificar codigo de transaccion */
/*----------------------------------*/
if @t_trn <> 14921
begin
   return 141018 
end

select @w_fecha_hoy = convert(datetime,convert(varchar,@i_fecha_proceso,101)),
       @w_oficina_ing = @s_ofi

--------------------------------------
-- Seccion de lectura de pf_operacion
--------------------------------------
select @w_num_banco  	    = op_num_banco,  
       @w_operacionpf       = op_operacion,       
       @w_toperacion	    = op_toperacion,
       @w_producto          = op_producto,
       @w_tplazo            = op_tipo_plazo,
       @w_categoria         = op_categoria,
       @w_monto 	    = op_monto,
       @w_monto_pg_int	    = op_monto_pg_int,
       @w_int_estimado      = op_int_estimado,
       @w_fpago	            = op_fpago,
       @w_fecha_valor       = op_fecha_valor,
       @w_fecha_ven   	    = op_fecha_ven,
       @w_oficina   	    = op_oficina,
       @w_moneda            = op_moneda,
       @w_total_int_pagados = op_total_int_pagados,
       @w_total_int_ganados = op_total_int_ganados,
       @w_historia	    = isnull(op_historia,2),
       @w_estado 	    = op_estado,
       @w_accion_sgte	    = op_accion_sgte,
       @w_fecha_mod 	    = op_fecha_mod,
       @w_moneda 	    = op_moneda,
       @w_causa_mod 	    = op_causa_mod,
       @w_mon_sgte          = op_mon_sgte
  from pf_operacion
 where op_num_banco = @i_num_banco   

if @@rowcount = 0
begin
   return  141004
end

-----------------------------------------------------
-- Ajuste de variables e inicializacion de variables
-----------------------------------------------------
select @w_fecha_ven   = convert(datetime,convert(varchar,@w_fecha_ven,101)),
       @w_intereses   = @w_total_int_ganados - @w_total_int_pagados,
       @v_historia    = @w_historia,
       @v_fecha_mod   = @w_fecha_mod,
       @v_causa_mod   = @w_causa_mod,
       @v_mon_sgte    = @w_mon_sgte,
       @v_estado      = @w_estado

--------------------------
-- Proceso de vencimiento
--------------------------
begin tran 
   save tran vencimiento_op

   if @w_fpago = 'ANT'
      select @w_intereses = 0

   select @o_monto = @w_monto_pg_int,@o_intereses = @w_intereses 

   ---------------------------------
   -- Actualizacion de la operacion
   ---------------------------------
   select @v_total_int_pagados = @w_total_int_pagados 
   select @w_total_int_pagados = @v_total_int_pagados + @w_intereses
   select @w_historia = @w_historia + 1, 
          @w_estado   = 'VEN',
          @w_mon_sgte = @w_mon_sgte + 1,
          @w_causa_mod = 'TVEN'

   update pf_operacion set 
          op_historia     = @w_historia, 
          op_estado	  = @w_estado,
          op_fecha_mod    = @s_date,
          op_causa_mod    = @w_causa_mod,
          op_mon_sgte     = @w_mon_sgte
    where op_operacion = @w_operacionpf

   if @@error <> 0
   begin
       select @w_error = 145001
       goto ERROR
   end

   if exists (select * from pf_tipo_deposito 
                where td_mantiene_stock = 'S' 
                  and td_mnemonico = @w_toperacion)

      update pf_det_lote set dl_estado = @w_estado
       where dl_operacion = @w_operacionpf
        
   
   insert pf_historia (hi_operacion  , hi_secuencial  , hi_fecha,
                       hi_trn_code   , hi_valor       , hi_funcionario,
                       hi_oficina    , hi_fecha_crea  , hi_fecha_mod) 
               values (@w_operacionpf, @v_historia    , @s_date,
                       @t_trn        , @w_monto_pg_int, @s_user,
                       @s_ofi        , @s_date        , @s_date)

   if @@error <> 0
   begin
      select @w_error = 143006
      goto ERROR
   end

   -----------------------------------------------
   -- Insercion de transaccion de servicio previa
   -----------------------------------------------
   insert ts_operacion (secuencial  , tipo_transaccion, clase       , usuario,
                        terminal    , srv             , lsrv        , fecha,
                        num_banco   , operacion       , historia    , estado,
                        causa_mod   , mon_sgte        , fecha_mod   , total_int_pagados)
                values (@s_ssn      , @t_trn          , 'P'         , @s_user,
                        @s_term     , @s_srv          , @s_lsrv     , @s_date, 
                        @w_num_banco, @w_operacionpf  , @v_historia , @v_estado,
                        @v_causa_mod, @v_mon_sgte     , @v_fecha_mod, @v_total_int_pagados)
   if @@error <> 0
   begin
      select @w_error = 143005
      goto ERROR
   end

   --------------------------------------------------------
   -- Insercion de transaccion de servicio y actualizacion
   --------------------------------------------------------
   insert ts_operacion (secuencial  , tipo_transaccion, clase      , usuario,
                        terminal    , srv             , lsrv       , fecha,
                        num_banco   , operacion       , historia   , estado,
                        causa_mod   , mon_sgte        , fecha_mod  , total_int_pagados)
                values (@s_ssn      , @t_trn          , 'A'        , @s_user,
                        @s_term     , @s_srv          , @s_lsrv    , @s_date, 
                        @w_num_banco, @w_operacionpf  , @w_historia, @w_estado,
                        @w_causa_mod, @w_mon_sgte     , @s_date    , @w_total_int_pagados )

   if @@error <> 0
   begin
      select @w_error = 143005
      goto ERROR
   end

   commit tran 
return 0

---------------------------------
-- Proceso para control de error
---------------------------------
ERROR:
  rollback tran vencimiento_op
  if @i_en_linea = 'N'
  begin
     exec sp_errorlog 
          @i_fecha   = @s_date,
          @i_error   = @w_error,
          @i_usuario = @s_user,
          @i_tran    = @t_trn,
          @i_cuenta  = @w_num_banco
     commit tran
  end
  else
  begin
     exec cobis..sp_cerror 
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = @w_error
  end
  return @w_error
go

