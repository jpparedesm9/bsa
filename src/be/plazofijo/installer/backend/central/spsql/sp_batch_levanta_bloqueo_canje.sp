/************************************************************************/
/*      Archivo:                sp_batch_levanta_bloqueo_canje.sp       */
/*      Stored procedure:       sp_batch_levanta_bloqueo_canje          */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Yecid Martinez                          */
/*      Fecha de documentacion: 16/Dic/10                               */
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
/*      Levantar del bloqueo Adminsitrativo por concepto de 'Bloqueo    */
/*      Cheque Canje', a las operaciones que fueron constituidas en     */
/*      en cheque local 'CHQL' despues de los dais de gracias           */
/*      establecidos                                                    */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA        AUTOR              RAZON                           */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_batch_levanta_bloqueo_canje' and type = 'P')
   drop proc sp_batch_levanta_bloqueo_canje
go

create proc sp_batch_levanta_bloqueo_canje (
@s_ssn                  int             = NULL,
@s_user                 login           = 'sa',
@s_term                 varchar(30)     = 'consola',
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = 'PRESRV',
@s_lsrv                 varchar(30)     = 'PRESRV',
@s_ofi                  smallint        = 1,   
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL
)
with encryption
as
declare 
@w_sp_name              descripcion,
@w_return               int,
@w_error                int,
@w_fecha_hoy            datetime,
@w_ndias                tinyint,
@w_op_operacion         int,
@w_mpago_chql	        varchar(20),
@w_op_num_banco         cuenta,
@w_monto                money,
@w_rt_secuencial        tinyint,
@w_tipo_deposito	    varchar(10),
@w_fecha_temp		    datetime,
@w_fecha_def	        datetime,
@w_op_fecha_valor       datetime,
@w_td_tipo_deposito	    int

select  @w_error = 0

select  @w_fecha_hoy = fp_fecha
from    cobis..ba_fecha_proceso

select @s_date = @w_fecha_hoy

-- Dias gracias para levantar bloqueo cheques en canje
select @w_ndias = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'DCP'
   and pa_producto = 'PFI'

-- MEDIO DE PAGO CHEQUE LOCAL
select @w_mpago_chql = pa_char
from cobis..cl_parametro
where pa_nemonico = 'NCHQL'
and   pa_producto = 'PFI'


declare cursor_operacion_bloqueo cursor local
for   select  op_operacion, op_num_banco , rt_valor, rt_secuencial, op_oficina, op_toperacion, op_fecha_valor
      from    pf_operacion,
	      pf_mov_monet,
              pf_retencion
      where   op_operacion = mm_operacion
      and     op_operacion = rt_operacion
      and     op_estado    = 'ACT'
      and     mm_estado    = 'A'
      and     mm_tran      = 14901
      and     mm_producto  = @w_mpago_chql 

for update

open cursor_operacion_bloqueo

-----------------------------
-- Acceso al primer registro
-----------------------------
fetch cursor_operacion_bloqueo into   @w_op_operacion, @w_op_num_banco, @w_monto, @w_rt_secuencial, @s_ofi, @w_tipo_deposito, @w_op_fecha_valor

while @@fetch_status = 0
begin  


   select @w_td_tipo_deposito =  td_tipo_deposito
   from   cob_pfijo..pf_tipo_deposito
   where  td_mnemonico = @w_tipo_deposito

   select @w_fecha_def = dateadd(dd, @w_ndias, @w_op_fecha_valor) 

   exec sp_primer_dia_labor 
        @t_debug       = @t_debug, 
        @t_file        = @t_file,
        @t_from        = @w_sp_name, 
        @i_fecha       = @w_fecha_def,
        @s_ofi         = @s_ofi,
        @i_tipo_deposito = @w_td_tipo_deposito,
        @o_fecha_labor = @w_fecha_temp out
   	

print 'w_op_fecha_valor ' + cast(@w_op_fecha_valor as varchar)
print 'w_ndias ' + cast(@w_ndias as varchar)
print 'w_fecha_def ' + cast(@w_fecha_def as varchar)
print 'w_fecha_temp ' + cast(@w_fecha_temp as varchar)
print 'w_fecha_hoy ' + cast(@w_fecha_hoy as varchar)

   if @w_fecha_hoy >= @w_fecha_temp begin
   
      print 'Levanta Bloqueo de op : ' + cast(@w_op_operacion as varchar)

      exec @w_return = cob_pfijo..sp_retencion
         @s_ssn             = @s_ssn,
         @s_user            = 'sa',
         @s_ofi             = @s_ofi,
         @s_date            = @s_date,
         @s_srv             = 'COBPROD',
         @s_term            = 'consola',
         @t_file            = null,
         @t_from            = @w_sp_name,
         @t_debug           = @t_debug,
         @t_trn	         = 14308,
         @i_operacion       = 'D',
         @i_cuenta          = @w_op_num_banco,
         @i_secuencial      = @w_rt_secuencial,
         @i_valor           = @w_monto,
         @i_observacion     = 'LEVANTAMIENTO BLOQUEO CHEQUE CANJE',
         @i_motivo          = 'BCHQL',
         @i_funcionario     = @s_user,
         @i_tipo            = 'D',
         @i_batch            = 'S'
         
         if @@error<> 0 begin
           exec sp_errorlog 
              @i_fecha       = @s_date,
              @i_error       = 143008, 
              @i_usuario     = @s_user,
              @i_tran        = 14308,
              @i_descripcion = 'ERROR LEVANTAMIENTO BLOQUEO CHEQUE CANJE',
              @i_cuenta      = @w_op_num_banco
         end

   end

   fetch cursor_operacion_bloqueo into   @w_op_operacion, @w_op_num_banco, @w_monto, @w_rt_secuencial, @s_ofi, @w_tipo_deposito, @w_op_fecha_valor
            
end /*end del while*/

close cursor_operacion_bloqueo
deallocate cursor_operacion_bloqueo

return @w_error
go

	
