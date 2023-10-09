/*bt_fidia*/
/************************************************************************/
/*      Archivo:                fechaconta.sp                           */
/*      Stored procedure:       sp_fecha_contable                       */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Clotilde Vargas                         */
/*      Fecha de documentacion: 30/Jun/06                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este script devuelve la £ltinma fecha laborable en base a la    */
/*      fecha de cierre que se este realizando                          */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_fecha_contable' and type = 'P')
   drop proc sp_fecha_contable
go

create proc sp_fecha_contable(
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
@t_trn                  int             = NULL,
@i_fecha_proceso        datetime        = NULL,
@o_fecha_contable       datetime        = NULL out)
with encryption
as
declare
@w_siguiente_dia        datetime,
@w_ciudad_feriados      smallint,  
@w_anterior_dia         datetime,   
@w_ciu                  int,
@w_fecha_contable       datetime

select @w_ciudad_feriados  = 9999

declare dias_calculo cursor for
select   of_ciudad
from cobis..cl_oficina
for read only

open dias_calculo

fetch dias_calculo into @w_ciu
   
while @@fetch_status <> -1
begin
   if @@fetch_status = -2
   begin
      close dias_calculo
      deallocate  dias_calculo
      raiserror ('200001 - Fallo lectura del cursor dias_calculo', 16, 1)
      return 1
   end
   
   --Busca dia siguiente habil para ciudad
   select @w_siguiente_dia = dateadd(day,1,@i_fecha_proceso) 

   while exists(select 1 from cobis..cl_dias_feriados
           where df_fecha  =  @w_siguiente_dia
             and df_ciudad =  @w_ciudad_feriados) 
   begin
      select @w_siguiente_dia = dateadd(day,1,@w_siguiente_dia)
   end -- WHILE
   
   --Busca hacia atras el dia anterior habil
   select @w_anterior_dia = dateadd(day,-1,@i_fecha_proceso) 
   while exists(select 1 from cobis..cl_dias_feriados
           where df_fecha  =  @w_anterior_dia
             and df_ciudad =  @w_ciudad_feriados) 
   begin
      select @w_anterior_dia = dateadd(day,-1,@w_anterior_dia)
   end -- WHILE      
   
   --*-*Si es feriado el dia de ejecucion => evaluar
   if exists(select 1 from cobis..cl_dias_feriados
           where df_fecha  =  @i_fecha_proceso
             and df_ciudad =  @w_ciudad_feriados) 
   begin
      --Preguntar si paso por un fin de mes iendo hacia adelante
      if datepart(mm,@i_fecha_proceso) < datepart(mm,@w_siguiente_dia)  
      begin
         --*-*=> Toma el ultimo dia habil anterior
         select @w_fecha_contable = @w_anterior_dia
      end
      else  --No paso por fin de mes
      begin
         --Preguntar si paso por un fin de mes iendo hacia atras
         if datepart(mm,@i_fecha_proceso) > datepart(mm,@w_anterior_dia) or (datepart(yy,@i_fecha_proceso) > datepart(yy,@w_anterior_dia))
            select @w_fecha_contable = @w_siguiente_dia
         else -- => Estoy dentro del mes
            select @w_fecha_contable = @w_anterior_dia
      end
   end
   else
      select @w_fecha_contable = @i_fecha_proceso

   select @o_fecha_contable = @w_fecha_contable
   
   fetch dias_calculo into @w_ciu
end
close dias_calculo
deallocate  dias_calculo
return 0
go

