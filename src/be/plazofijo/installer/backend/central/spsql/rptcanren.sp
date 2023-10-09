/************************************************************************/
/*  Archivo               : rptcanren.sp                                */
/*  Stored procedure      : sp_rptcanren                                */
/*  Base de datos         : cob_pfijo                                   */
/*  Producto              : Plazo Fijo                                  */
/*  Disenado por          : ALF                                         */
/*  Fecha de documentacion: 24/Mar/10                                   */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'COBISCORP'                                                         */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de COBISCORP o su representante.              */
/*                          PROPOSITO                                   */
/*  reporte de inversiones canceladas y renovadas en el mes,            */
/*  almacena datos en la tabla cob_externos..re_inversion_canren        */
/*  todos los saldos e interes pagado estan en dolares                  */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA           AUTOR              RAZON                            */ 
/*  24-Mar-2010     M. Jimenez(ALF)    Emision Inicial                  */
/*  24-Ago-2011     N. Silva           Cambios Renovaciones             */
/*  05-Ene-2017     N. Martillo        Ajustes VBatch                   */
/************************************************************************/ 
use cob_pfijo
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select name from sysobjects where name = 'sp_rptcanren')
   drop proc sp_rptcanren
go

create proc sp_rptcanren (
       @i_param1           varchar(255)
)
with encryption
as

declare @w_sp_name       varchar(30),
        @w_msg           varchar(240),
        @w_retorno       int,
        @w_retorno_ej    int,
        @w_error         int,
        @w_error_msg     int,
        @w_fin_mes       datetime,
        @w_fecha_proceso datetime

declare @rangos table
(rango int null,
 desde int null, 
 hasta int null
)

declare @cotizacion table
(ct_empresa tinyint  null,
 ct_fecha   datetime null,
 ct_moneda  tinyint  null,
 ct_valor   money    null,
 ct_compra  money    null,
 ct_venta   money    null
)

select @w_fecha_proceso  = convert(datetime, @i_param1),
       @w_sp_name = 'sp_rptcanren',
       @w_error   = 0,
       @w_fin_mes = dateadd(dd,-datepart(dd,dateadd(mm,1,@w_fecha_proceso)),dateadd(mm,1,@w_fecha_proceso))

insert into @cotizacion
select 1,
       ct_fecha,
       ct_moneda,
       ct_valor,
       ct_compra,
       ct_venta
from cob_conta..cb_cotizacion a
where ct_fecha   = ( select max(ct_fecha)
                     from cob_conta..cb_cotizacion
                     where ct_moneda  = a.ct_moneda
                       and ct_fecha   <= @w_fecha_proceso )

if @@rowcount = 0
begin
     select @w_retorno_ej = 149051,
            @w_error_msg = '[' + @w_sp_name + '] ' + 'Error en consulta cob_conta..cb_cotizacion'
     goto ERROR
end




--Normales, Cancelaciones y Renovaciones----
insert into @rangos
values (1, -1, -999999)  --PRECANCELADOS
insert into @rangos
values (2, 0, 0)
insert into @rangos
values (3, 1, 7)
insert into @rangos
values (4, 8, 15)
insert into @rangos
values (5, 16, 30)
insert into @rangos
values (6, 31, 60)
insert into @rangos
values (7, 61, 999998)
insert into @rangos
values (8, 999999, 999999) --VENCIDOS


delete cob_externos..re_inversion_canren
where ic_fecha = @w_fin_mes

select @w_error = @@error

if @w_error != 0
begin
       select @w_retorno_ej = 14000,
              @w_error_msg = '[' + @w_sp_name + '] ' + 'Error al eliminar datos en cob_externos..re_inversion_canren'
       goto ERROR
end

insert into cob_externos..re_inversion_canren
( ic_fecha,
  ic_tipo_can, 
  ic_tipo_tran, 
  ic_tipo_prod,
  ic_rango,
  ic_desde,
  ic_hasta,
  ic_sld_cap,
  ic_sld_int,
  ic_cta_contable
)
-- DPF
select @w_fin_mes,
       1,     
       14903, ---cancelacion
       op_toperacion,
       rango,
       desde,
       hasta,
       sum(op_monto*isnull(ct_valor,1)),
       sum(op_total_int_pagados*isnull(ct_valor,1)),
       case substring(op_toperacion ,1,4)
       when 'CICA' then '2105'
       else case op_pignorado
            when 'S' then '2105'
            else case op_estado
                 when 'VEN' then '2101'
                 else 2103
                 end
             end
       end
from cob_pfijo..pf_operacion left outer join  @cotizacion on (op_moneda = ct_moneda),
     @rangos    
where op_estado                                                 in ('CAN')
  and substring(convert(char(8),op_fecha_ven,112),1,6)          = substring(convert(char(8),@w_fin_mes,112),1,6) 
  and isnull(datediff(dd,op_fecha_ven,op_fecha_cancela),999999) between desde and hasta
group by op_toperacion, rango, desde, hasta, op_pignorado, op_estado
union --vencidos
select @w_fin_mes,
       1,     
       14903, ---cancelacion
       op_toperacion,
       rango,
       desde,
       hasta,
       sum(op_monto*isnull(ct_valor,1)),
       sum(op_total_int_pagados*isnull(ct_valor,1)),
       case substring(op_toperacion ,1,4)
       when 'CICA' then '2105'
       else case op_pignorado
            when 'S' then '2105'
            else case op_estado
                 when 'VEN' then '2101'
                 else 2103
                 end
           end
       end
from cob_pfijo..pf_operacion left outer join  @cotizacion on (op_moneda = ct_moneda),
     @rangos    
where op_estado                                        in ('VEN')
  and substring(convert(char(8),op_fecha_ven,112),1,6) = substring(convert(char(8),@w_fin_mes,112),1,6) 
  and rango                                            = 8
group by op_toperacion, rango, desde, hasta, op_pignorado, op_estado
-- Bonos
-- Repos Pasivos

select @w_error = @@error

if @w_error != 0
begin
       select @w_retorno_ej = 14000,
              @w_error_msg = '[' + @w_sp_name + '] ' + 'Error al registrar datos en cob_externos..inversion_canren' 
       goto ERROR
end


--Precancelados, Cancelaciones y Renovaciones----
delete @rangos

insert into @rangos
values (0, 0, 0)  
insert into @rangos
values (1, 1, 7)  
insert into @rangos
values (2, 8, 15)
insert into @rangos
values (3, 16,30)
insert into @rangos
values (4, 31,60)
insert into @rangos
values (5, 61,999999)


insert into cob_externos..re_inversion_canren
( ic_fecha,
  ic_tipo_can,  --1 - Normal  / 2 - Precancelado
  ic_tipo_tran, 
  ic_tipo_prod,
  ic_rango,
  ic_desde,
  ic_hasta,
  ic_sld_cap,
  ic_sld_int,
  ic_cta_contable
)
select @w_fin_mes,
       2,     
       14903, ---cancelacion
       op_toperacion,
       rango,
       desde,
       hasta,
       sum(op_monto*isnull(ct_valor,1)),
       sum(op_total_int_pagados*isnull(ct_valor,1)),
       case substring(op_toperacion ,1,4)
       when 'CICA' then '2105'
       else case op_pignorado
            when 'S' then '2105'
            else case op_estado
                 when 'VEN' then '2101'
                 else 2103
                 end
            end
       end
from cob_pfijo..pf_operacion left outer join  @cotizacion on (op_moneda = ct_moneda),
     @rangos    
where op_estado = 'CAN'
  and substring(convert(char(8),op_fecha_ven,112),1,6) = substring(convert(char(8),@w_fin_mes,112),1,6) 
  and datediff(dd,op_fecha_cancela,op_fecha_ven)       between desde and hasta
  and op_fecha_cancela                                 is not null
  and datediff(dd,op_fecha_cancela,op_fecha_ven)       > 0 
group by op_toperacion, rango, desde, hasta, op_pignorado, op_estado
union 
select @w_fin_mes,
       2,
       14904, --renovacion  
       op_toperacion,  
       rango,
       desde,
       hasta,
       sum(op_monto*isnull(ct_valor,1)),
       sum(op_total_int_pagados*isnull(ct_valor,1)),
       case substring(op_toperacion ,1,4)
       when 'CICA' then '2105'
       else case op_pignorado
            when 'S' then '2105'
            else case op_estado
                 when 'VEN' then '2101'
                 else 2103
                 end
            end
       end
from cob_pfijo..pf_operacion left outer join  @cotizacion on (op_moneda = ct_moneda),
     cob_pfijo..pf_operacion_renov,
     @rangos    
where op_estado                                in ('ACT','VEN')
  and op_operacion                             = or_operacion
  and datepart(mm,op_fecha_valor)              = datepart(mm,@w_fin_mes)
  and datepart(yyyy,op_fecha_valor)            = datepart(yyyy,@w_fin_mes)
  and op_renovaciones                          > 0 
  and or_estado_renov                          = 'REN'
  and datediff(dd,or_fecha_ven,op_fecha_valor) between desde and hasta
group by op_toperacion, rango, desde, hasta, op_pignorado, op_estado

return 0

ERROR:

exec @w_retorno     = cob_pfijo..sp_errorlog
     @i_fecha       = @w_fecha_proceso, 
     @i_error       = @w_retorno_ej, 
     @i_usuario     = 'OPERADOR',
     @i_tran        = 14000, 
     @i_tran_name   = @w_sp_name, 
     @i_rollback    = 'N',
     @i_cuenta      = 'sp_rptcanren', 
     @i_descripcion = @w_error_msg

if @w_retorno > 0
    return @w_retorno
else
    return @w_retorno_ej 
go
-- exec sp_rptcanren @i_fecha_proceso = '01/31/2012' -- se demora 3 segundos
-- select * from cob_externos..re_inversion_canren where ic_cta_contable is not null
