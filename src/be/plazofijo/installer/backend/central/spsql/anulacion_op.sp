/************************************************************************/
/*      Archivo:                anula_op.sp                             */
/*      Stored procedure:       sp_anulacion_op                         */
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
/*      Este script crea los procedimientos para las anulaciones de     */
/*      operaciones de plazos fijos.                                    */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      24-Oct-94  Juan Lam           Creacion                          */
/*      04-Sep-95  Carolina Alvarado  XXXXX                             */
/*                                                                      */
/************************************************************************/

use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_anulacion_op')
   drop proc sp_anulacion_op
go
create proc sp_anulacion_op (
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
@i_observacion          descripcion     = NULL,
@i_empresa              tinyint         = 1,
@i_en_linea             char(1)         = 'S',
@i_login_captador       login           = NULL
)
with encryption
as
declare
@w_sp_name             varchar(32),
@w_return              int,
@w_secuencial          int,
@w_num_oficial         int,
@w_money               money,
@w_total_monet         money,
/* VARIABLES NECESARIAS PARA PF_OPERACION */
@w_operacionpf         int,
@w_int_pagados         money,
@w_total_int_pagados   money,
@w_historia            smallint,
@w_anulaciones         tinyint,
@w_mantiene_stock      char(1),
@w_monto               money,
@w_estado              catalogo,
@w_toperacion          catalogo,
@w_fecha_mod           datetime,
@v_historia            smallint,
@v_anulaciones         tinyint,
@v_estado              catalogo,
@v_fecha_mod           datetime,
@w_mm_producto         catalogo,
@w_mm_cuenta           cuenta,
@w_mm_valor            money,
@w_mm_valor_ext        money,
@w_operacion_cancelada int,
@w_mm_sub_secuencia    tinyint,
@w_valor_utilizado     money,
@w_moneda              smallint,
@w_operacion_ant       int,
@w_num_banco_ant       cuenta,
@w_ofi                 smallint ,
@w_moneda_base         tinyint,
@w_aprobado            char(1),
@w_captador            login,
@w_oficial             login,
@w_error               int

select 
@w_sp_name    = 'sp_anulacion_op',
@w_secuencial = @s_ssn

/**  VERIFICAR CODIGO DE TRANSACCION DE ANULACION  **/
if  ( @t_trn <> 14908)
begin
   select @w_error = 141040
   goto ERROR
end

/* GES 03/24/1999 Generar secuencial */
if @s_ssn is null
begin
  exec @w_secuencial = sp_gen_sec
  select @s_ssn = @w_secuencial
end

select @w_moneda_base = em_moneda_base
from   cob_conta..cb_empresa
where  em_empresa = @i_empresa

if @@rowcount = 0
begin
   select @w_error = 601018
   goto ERROR
end

/** LECTURA DEPOSITO **/

select
@w_operacionpf        = op_operacion,
@w_toperacion         = op_toperacion,
@w_estado             = op_estado,
@w_monto              = op_monto,
@w_historia           = op_historia,
@w_int_pagados        = op_int_pagados,
@w_total_int_pagados  = op_total_int_pagados,
@w_fecha_mod          = op_fecha_mod,
@w_moneda             = op_moneda,
@w_aprobado           = op_aprobado,
@w_captador           = op_captador,
@w_oficial            = op_oficial
from   pf_operacion
where  op_num_banco  = @i_num_banco
and    op_estado     = 'ING'

if @@rowcount = 0
begin
  select @w_error = 141090
  goto ERROR
end

--if @i_en_linea = 'S'  --CVA Oct-06-05
--begin
--   if @w_oficial <> @i_login_captador
--   begin
--      --EL USUARIO QUE QUIERE ANULAR NO ES EL MISMO QUE HIZO LA APERTURA
--      select @w_error = 141173
--      goto ERROR
--   end
--end

if @w_int_pagados > 0 or @w_total_int_pagados > 0
begin
   select @w_error = 141089
   goto ERROR
end

/* GES 11/24/1998 REVISAR PF_SECUEN TICKET PARA VER SI YA SE COBRO EN CAJA */
if exists (select * from pf_secuen_ticket
           where (st_estado = 'A' or st_estado = 'C')
           and    st_operacion = @w_operacionpf)
begin
   select @w_error = 141152
   goto ERROR
end
/* FIN REVISION EN PF_SECUEN_TICKET */


select @w_mantiene_stock = td_mantiene_stock
from   pf_tipo_deposito
where  td_mnemonico=@w_toperacion

select 
@v_historia    = @w_historia,
@v_estado      = @w_estado,
@v_fecha_mod   = @w_fecha_mod,
@w_historia    = @w_historia + 1,
@w_estado      = 'ANU'


/** REVERSION DE APERTURA **/
begin tran
   
/** Actualizacion del estado de productos de clientes**/

update cobis..cl_det_producto
set dp_estado_ser = 'X'
from  pf_operacion, cobis..cl_det_producto
where op_num_banco = dp_cuenta
and   op_num_banco = @i_num_banco
and   dp_producto  = 14

if @@error <> 0
begin
   print 'error actualiz'
   select @w_error = 145002
   goto ERROR
end

/** ACTUALIZACION DE LA OPERACION **/
update pf_operacion set
op_estado      = 'ANU',
op_historia    = @w_historia,
op_fecha_mod   = @s_date
where op_operacion = @w_operacionpf

if @@error <> 0
begin
   select @w_error = 145001
   goto ERROR
end

/** GES 11/23/1998 SE MODIFICAN LOS REGISTROS NO APLICADOS EN PF_SECUEN_TICKET*/
update pf_secuen_ticket
set st_estado = 'N', st_fecha_modificacion = @s_date
where st_operacion = @w_operacionpf

if @@error <> 0
begin
   select @w_error = 145042
   goto ERROR
end

/**  INSERCION TRANSACCION DE SERVICIO PREVIO  **/
insert ts_operacion (secuencial, tipo_transaccion, clase,
usuario, terminal, srv, lsrv, fecha, num_banco,
operacion, historia, estado, fecha_mod)
values (@s_ssn, @t_trn,'P',
@s_user, @s_term, @s_srv, @s_lsrv, @s_date, @i_num_banco,
@w_operacionpf, @v_historia, @v_estado, @v_fecha_mod )

if @@error <> 0
begin
   select @w_error = 143005
   goto ERROR
end

/**  INSERCION TRANSACCION DE SERVICIO ACTUALIZADO  **/
insert ts_operacion (secuencial, tipo_transaccion, clase,
usuario, terminal, srv, lsrv, fecha, num_banco,
operacion, historia, estado, fecha_mod)
values (@s_ssn, @t_trn,'A',
@s_user, @s_term, @s_srv, @s_lsrv, @s_date, @i_num_banco,
@w_operacionpf, @v_historia, @w_estado,@s_date)

if @@error <> 0
begin
   select @w_error = 143005
   goto ERROR
end

if @w_mantiene_stock='S'
begin
   set rowcount 0
   update pf_det_lote
   set dl_estado = @w_estado
   where dl_lote=@i_num_banco
   
   if @@error <> 0 begin
      select @w_error = 145005
      goto ERROR
   end
end /* si mantiene stock */

/**  INSERCION HISTORICO **/
insert pf_historia (hi_operacion, hi_secuencial, hi_fecha,
hi_trn_code, hi_valor, hi_funcionario, hi_oficina,
hi_observacion, hi_fecha_crea, hi_fecha_mod)
values (@w_operacionpf, @w_historia,@s_date,
@t_trn,@w_monto, @s_user, @s_ofi,
@i_observacion, @s_date,@s_date)

if @@error <> 0
begin
   select @w_error = 143006
   goto ERROR
end

/* GES 03/17/1999 Reversar la renovacion si esta operacion
                 proviene de una renovacion */

if exists(select * from pf_renovacion
         where re_operacion_new = @w_operacionpf
         and   re_estado = 'A')
begin
   select 
   @w_operacion_ant = re_operacion,
   @w_ofi           = re_oficina
   from  pf_renovacion
   where re_operacion_new = @w_operacionpf
   and   re_estado        = 'A'
   
   select @w_num_banco_ant = op_num_banco
   from   pf_operacion
   where  op_operacion = @w_operacion_ant
   
   exec @w_return=sp_reverso_renovacion
   @s_ssn        = @s_ssn,
   @s_user       = @s_user,
   @s_term       = @s_term,
   @s_date       = @s_date,
   @s_srv        = @s_srv,
   @s_lsrv       = @s_lsrv,
   @s_ofi        = @w_ofi,
   @t_debug      = @t_debug,
   @t_file       = @t_file,
   @t_from       = @w_sp_name,
   @i_num_banco  = @w_num_banco_ant,
   @i_autorizado = 'jrla',
   @t_trn        = 14929,
   @i_en_linea   = @i_en_linea
   
   if @w_return <> 0
   begin
      select @w_error = 145004
      goto ERROR
   end
end


/* GES 03/17/1999 Fin de reverso de renovacion */


/* GES 03/17/1999 Control de apertura con forma de pago renovacion */
if exists(select * from pf_mov_monet
         where mm_operacion = @w_operacionpf
         and mm_producto = 'REN'
         and mm_tipo <> 'T'
         and mm_cuenta <> '')
begin
   select @w_mm_sub_secuencia = 0
   while 1 = 1
   begin
      set rowcount 1
      select @w_mm_cuenta = mm_cuenta,
      @w_mm_sub_secuencia = mm_sub_secuencia,
      @w_mm_producto = mm_producto,
      @w_mm_cuenta = mm_cuenta,
      @w_mm_valor_ext = mm_valor_ext + mm_impuesto_capital_me,
      @w_mm_valor = mm_valor + mm_impuesto
      from pf_mov_monet
      where mm_operacion = @w_operacionpf
      and mm_sub_secuencia > @w_mm_sub_secuencia
      
      if @@rowcount = 0
         break

      set rowcount 0

      if @w_mm_producto = 'REN' and @w_mm_cuenta <> ''
      begin
         /*Actualizar campo en la pf_renovacion*/
         update pf_renovacion
         set re_estado = 'R'
         where re_operacion_new = @w_operacionpf
         
         if @@error <> 0 begin
            select @w_error = 145004
            goto ERROR
         end
         
         select @w_valor_utilizado = re_valor_utilizado
         from pf_nueva_renovacion
         where re_num_banco = @w_mm_cuenta
         and re_estado <> 'R'
         
         if @@rowcount = 0
         begin
            print 'error busqueda pf_nueva'
            select @w_error = 145004
            goto ERROR
         end

         if @w_moneda = @w_moneda_base
            select @w_valor_utilizado = @w_valor_utilizado + @w_mm_valor
         else
            select @w_valor_utilizado = @w_valor_utilizado + @w_mm_valor_ext

         update pf_nueva_renovacion set
         re_valor_utilizado = @w_valor_utilizado,
         re_estado          = 'V'
         where re_num_banco = @w_mm_cuenta
         
         if @@error <> 0
         begin
            print 'error actualiz'
            select @w_error = 145004
            goto ERROR
         end

         update pf_operacion
         set op_estado = 'CAN'
         where op_num_banco = @w_mm_cuenta
         
         if @@error <> 0
         begin
            print 'error actualiz'
            select @w_error = 145004
            goto ERROR
         end
      end
   end
   set rowcount 0
end
/* GES 03/17/1999 Fin de actualizacion de operacion cancelada
con forma de pago renovacion */
commit tran
return 0

ERROR:
if @i_en_linea = 'N'
begin
   exec  sp_errorlog
   @i_fecha   = @s_date,
   @s_date    = @s_date,
   @i_error   = @w_error,
   @i_usuario = @s_user,
   @i_tran    = @t_trn,
   @i_cuenta  = @i_num_banco,
   @i_descripcion = @w_sp_name
end else begin
   exec cobis..sp_cerror
   @t_from = @w_sp_name,   
   @i_num  = @w_error
end
select @w_error = isnull(@w_error, 1)
return @w_error

go

