/************************************************************************/
/*      Archivo:                cr_actsalfue.sp                         */
/*      Stored procedure:       sp_actualiza_resal_fuente               */
/*      Base de datos:          cob_credito                             */
/*      Producto:               Crédito                                 */
/*      Disenado por:           Soraya Ramírez                          */
/*      Fecha de escritura:     Marzo 2009                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA".                                                       */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Actualiza el reservado y el saldo de una Fuente de Recursos     */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*      FECHA           AUTOR             RAZON                         */
/*  26/Mar/2009      S. Ramírez           Emisión Inicial               */
/************************************************************************/
use cob_credito
go

if exists(select 1 from sysobjects where name = 'sp_actualiza_resal_fuente')
   drop proc sp_actualiza_resal_fuente
go

create proc sp_actualiza_resal_fuente
@s_user             login    = null,
@i_fuente_recurso   char(10),
@i_modo             char(1)  = 'N',
@i_valor            money,
@i_operacion        char(1)  = 'C', --CREDITO
@i_banco            cuenta   = null,
@i_tramite          int      = null

as
declare
@w_sp_name              varchar(30),
@w_return               int,
@w_fecha_proc           datetime,
@w_error                int,
@w_tipo_fuente          char(1),
@w_valor                money,
@w_valor_uti            money,
@w_valor_res            money


/* INICIALIZACION VARIABLES */
select @w_sp_name        = 'sp_actualiza_resal_fuente'

if @i_valor = 0 return 0

select
@w_fecha_proc = fp_fecha
from  cobis..ba_fecha_proceso

select
@w_valor_uti = 0,
@w_valor_res = 0

select @w_tipo_fuente = fr_tipo_fuente
from   cr_fuente_recurso
where  fr_fuente = @i_fuente_recurso

/* EN EL CASO DE REVERSA SE ASUME EL VALOR COMO NEGATIVO PARA HACER LA AFECTACION OPUESTA */
select @w_valor = case when @i_modo = 'R' then (-1)*@i_valor else @i_valor end

/* SI SE LLAMA CON OPCION CREDITO AUMENTA EL VALOR DEL RESERVADO */
if @i_operacion = 'C' begin
   select @w_valor_res = @w_valor
end

/* SI SE LLAMA CON OPCION DESDEMBOLSO AUMENTA EL VALOR DEL UTILIZADO Y DISMINUYE EL RESERVADO */
if @i_operacion = 'D' begin
   select
   @w_valor_uti = @w_valor,
   @w_valor_res = (-1)*@w_valor
end

/* SI SE LLAMA CON OPCION PAGOS, Y SE TRATA DE UNA FUENTE ROTATIVA DISMINUYE EL VALOR UTILIZADO */
if @i_operacion = 'P' and @w_tipo_fuente = 'R' begin 
   select @w_valor_uti = (-1)*@w_valor
end

select 
@w_valor_res = isnull(@w_valor_res, 0),
@w_valor_uti = isnull(@w_valor_uti, 0)

if @w_valor_res <> 0 or @w_valor_uti <> 0 begin

   /* INSERTO EL MOVIMIENTO */
   insert into cr_mov_fuente_recurso(
   mf_fecha,      mf_hora,           mf_user,
   mf_saldo_ini,  mf_valor_inc,      mf_valor_res,
   mf_saldo_fin,  mf_fuente,         mf_banco,
   mf_tramite,    mf_procesado)
   values(
   @w_fecha_proc, getdate(),         @s_user,
   0,             @w_valor_uti,      @w_valor_res,
   0,             @i_fuente_recurso, @i_banco,
   @i_tramite,    'N')

   if @@error <> 0
   begin
      select @w_error = 710002 --Error en la actualizacion del registro
      goto ERROR
   end
end
return 0

ERROR:
return @w_error         --SIEMPRE ES INTERNO


go

