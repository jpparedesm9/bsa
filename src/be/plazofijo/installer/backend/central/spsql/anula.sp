/************************************************************************/
/*      Archivo:                anula.sp                                */
/*      Stored procedure:       sp_anula                                */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           JJMD                                    */
/*      Fecha de documentacion: 23-Sep-2009                             */
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
/*                                                                      */
/*                                                                      */
/************************************************************************/
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA        AUTOR              RAZON                           */
/*      23-Sep-2009  JJMD               Emision Inicial.                */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_anula' and type = 'P')
   drop proc sp_anula
go
create proc sp_anula(
@i_fecha  datetime
)
with encryption
as
declare
@w_contador   int,
@w_registros  int,
@w_oficina    smallint,
@w_operacion  int,
@w_num_banco  cuenta

DECLARE @tmp_pf_operacion TABLE
( posicion INT IDENTITY (1,1),
  operacion int,
  num_banco cuenta,
  oficina   smallint
)

--Primero se limpia la tabla temporal
--truncate table pf_temp_anular



insert into @tmp_pf_operacion (operacion,  num_banco, oficina)
select op_operacion, op_num_banco, op_oficina
from pf_operacion
where op_fecha_ingreso = @i_fecha
and   op_estado        = 'ING'



--Insertando los valores del reporte en la tabla temporal.
--insert into pf_temp_anular (ta_num_banco, ta_oficina)
--select num_banco, oficina from @tmp_pf_operacion


--Anular secuencia de ticket
update pf_secuen_ticket
set st_estado = 'N'
from @tmp_pf_operacion A
where st_operacion = A.operacion
and   st_estado    = 'I'






select @w_registros = 0, @w_contador = 1
select @w_registros = count(1)
from @tmp_pf_operacion



--Anular Certificado.
while @w_contador <= @w_registros begin

	select @w_oficina = oficina,
           @w_num_banco = num_banco,
           @w_operacion = operacion
	from @tmp_pf_operacion
	where posicion = @w_contador



	exec sp_anulacion_op
	@s_user = 'sa',
	@s_ofi = @w_oficina,
	@s_date = @i_fecha,
	@t_trn = 14908,
	@s_srv = '',
	@s_term = 'consola',
	@i_num_banco = @w_num_banco,
	@i_observacion = 'Anulada por no existir ingreso en caja/Activacion',
	@i_en_linea = 'N'



	set @w_contador = @w_contador + 1
end


/* SE HACE EN EL SQR

select op_operacion into #tmp_pf_operacion2 
from pf_operacion
where (op_estado = 'ACT' OR op_estado = 'ANU')
and   op_fecha_valor = @i_fecha
*/

--Insertando informaci¾n en tablas hist¾ricas.



insert into pf_hist_secuen_ticket
select
st_num_banco,
st_operacion,
st_secuencial,
st_secuencia,
st_fpago,
st_valor,
st_estado,
st_moneda,
st_valor_ext,
st_fecha_crea,
st_fecha_modificacion,
st_oficina,
st_subsecuencia
from pf_secuen_ticket, #tmp_pf_operacion2
where st_operacion = op_operacion
and (st_estado = 'C' or st_estado = 'A' or st_estado = 'N' or st_estado = 'R')




--Borrando los datos de la tabla pf_secuen_ticket
/*
delete from pf_secuen_ticket
where exists(select 1 from #tmp_pf_operacion2
						  where st_operacion   = op_operacion)
and (st_estado  = 'C' or st_estado = 'A' or st_estado = 'N' or st_estado = 'R')
*/






return 0
go



