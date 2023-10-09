/*cr_diahab.sp***********************************************************/
/*	Archivo:                        cr_diahab.sp                         */
/*	Stored procedure:               sp_dia_habil_cierre                  */
/*	Base de Datos:                  cob_credito                          */
/*	Producto:                       CREDITO                              */
/*	Disenado por:                   Alfredo Zuluaga                      */
/*	Fecha de Documentacion:         Nov 12/2010                          */
/************************************************************************/
/*                            IMPORTANTE                                */
/*	Este programa es parte de los paquetes bancarios propiedad de        */
/*	"MACOSA",representantes exclusivos para el Ecuador de la             */
/*	AT&T                                                                 */
/*	Su uso no autorizado queda expresamente prohibido asi como           */
/*	cualquier autorizacion o agregado hecho por alguno de sus            */
/*	usuario sin el debido consentimiento por escrito de la               */
/*	Presidencia Ejecutiva de MACOSA o su representante                   */
/************************************************************************/
/*                            PROPOSITO                                 */
/*	Este stored procedure devuelve para una fecha dada si es fin         */
/*      mes o no lo es                                                  */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*	FECHA       AUTOR             RAZON                                  */
/*	11/26/09    Alfredo Zuluaga   Emision Inicial                        */
/************************************************************************/

use cob_conta_super
go

if exists (select * from sysobjects where name = 'sp_dia_habil_cierre')
   drop proc sp_dia_habil_cierre
go

create proc sp_dia_habil_cierre
(
   @i_fecha            datetime,
   @o_periodicidad     varchar(1)    output,
   @o_msg              varchar(200)  output
) 
as

declare
@w_sig_habil      datetime, 
@w_ciudad         int,
@w_periodicidad   varchar(1),
@w_msg            varchar(200)

select @w_periodicidad = null, @w_msg = null

select @w_ciudad = pa_int
   from cobis..cl_parametro
   where pa_nemonico = 'CIUN'
   and   pa_producto = 'ADM'

select @w_sig_habil = dateadd(dd, 1, @i_fecha)

if exists(select 1
          from cobis..cl_dias_feriados
          where df_fecha   = @i_fecha
          and   df_ciudad  = @w_ciudad)
begin
   select @w_periodicidad = ''
   select @w_msg = 'ERROR. DIA FERIADO'
end

while exists (select 1
              from cobis..cl_dias_feriados
              where df_fecha   = @w_sig_habil
              and   df_ciudad  = @w_ciudad)

begin
   select @w_sig_habil = dateadd(dd, 1, @w_sig_habil)
end

if datepart(mm, @w_sig_habil) <> datepart(mm, @i_fecha)
   select @w_periodicidad = 'M'
else
   select @w_periodicidad = 'S'

select @o_periodicidad = @w_periodicidad
select @o_msg          = @w_msg

return 0
go

/*

declare @w_periodicidad varchar(1), @w_msg varchar(200)

exec sp_dia_habil_cierre
@i_fecha      = '09/30/2010',
@o_periodicidad = @w_periodicidad out,
@o_msg          = @w_msg out

select @w_periodicidad
select @w_msg


*/
