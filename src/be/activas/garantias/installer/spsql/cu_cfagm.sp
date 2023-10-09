/***********************************************************************/
/*	Archivo:                  cu_cfagm.sp                          */
/*	Stored procedure:         sp_cfagm                             */
/*	Base de Datos:            cob_custodia                         */
/*	Producto:                 Custodia                             */
/*	Disenado por:             Silvia Portilla                      */
/*	Fecha de Documentacion:   07/Abril/2005                        */
/***********************************************************************/
/*			IMPORTANTE		       		       */
/*	Este programa es parte de los paquetes bancarios propiedad de  */
/*	"MACOSA",representantes exclusivos para el Ecuador de la       */
/*	AT&T							       */
/*	Su uso no autorizado queda expresamente prohibido asi como     */
/*	cualquier autorizacion o agregado hecho por alguno de sus      */
/*	usuario sin el debido consentimiento por escrito de la         */
/*	Presidencia Ejecutiva de MACOSA o su representante	       */
/***********************************************************************/
/*			PROPOSITO				       */
/*	Genera reporte mensual de las comisiones de IVA liquidadas     */
/*	para pagar el FAG.                               	       */
/*								       */
/***********************************************************************/
/*			MODIFICACIONES				       */
/*	FECHA		AUTOR			RAZON		       */
/*	07/04/2005	Angela Tovar	Emision Inicial	               */
/***********************************************************************/
use cob_custodia
go


if exists (select 1 from sysobjects where name = 'sp_cfagm')
    drop proc sp_cfagm
go


create proc sp_cfagm 
(
@i_fecha_ini     datetime   = null,
@i_fecha_fin     datetime   = null
)

as
declare
   @w_today            datetime,     /* fecha del dia */ 
   @w_sp_name          varchar(32),  /* nombre stored proc*/
   @w_error            int,
   @w_ivafag           varchar(64),
   @w_regional         smallint,
   @w_identific        varchar(30),
   @w_codigo_externo   varchar(64),
   @w_ival             money,
   @w_ivam             money,
   @w_oficina          smallint,
   @w_cliente          int,
   @w_tipo_gar         descripcion,
   @w_operacion        int,
   @w_valiva           money,
   @w_porc_cob         float,
   @w_val_cob          float,
   @w_certif           varchar(13),
   @w_tramite          int,
   @w_fag              descripcion, 
   @w_comisi           descripcion,
   @w_banco            char(24),
   @w_llave_red        char(24),
   @w_nombre           descripcion,
   @w_valor_com        float,
   @w_desc_tg          descripcion,
   @w_fecha_ven        datetime,
   @w_fecha_ini        datetime,
   @w_iva              money,
   @w_fecha_fin        datetime,
   @w_comiva           catalogo,
   @w_dividendo        smallint,
   @w_anulado          tinyint,
   @w_cancelado        tinyint,
   @w_credito          tinyint,
   @w_tram_activa      int,
   @w_op_pas           int,
   @w_tipo_pago         char(1),
   @w_saldo            money,
   @w_return           int



select @w_today = getdate()
select @w_sp_name = 'sp_cfagm'

truncate table cob_custodia..cu_cifagm

-- 2. Establecer los parametros generales

select @w_comisi = null

select @w_comisi  = pa_char
from cobis..cl_parametro
where pa_producto = 'GAR'
and pa_nemonico = 'COMISI'

if @w_comisi is null
goto ERROR

select @w_fag = null
select @w_fag   = pa_char 
from cobis..cl_parametro
where pa_producto = 'GAR'
and pa_nemonico = 'FAG'

if @w_fag is null
goto ERROR

select @w_ivafag = null
select @w_ivafag   = pa_char 
from cobis..cl_parametro
where pa_producto = 'GAR'
and pa_nemonico = 'IVAFAG'

if @w_ivafag is null
goto ERROR

select @w_credito = null
select @w_credito = pa_tinyint
from cobis..cl_parametro
where pa_producto = 'CRE'
and pa_nemonico = 'ESTCRE'

if @w_credito is null
goto ERROR

--ESTADO CANCELADO Y ANULADO DE LAS OPERACION
select @w_anulado = null
select @w_anulado = pa_tinyint
from cobis..cl_parametro
where pa_producto = 'CRE'
and pa_nemonico = 'ESTANU'

if @w_anulado is null
goto ERROR

select @w_cancelado = null
select @w_cancelado = pa_tinyint
from cobis..cl_parametro
where pa_producto = 'CRE'
and pa_nemonico = 'ESTCAN'

if @w_cancelado is null
goto ERROR

--3. En una tabla temporal se almacenaran todos los tipos de garantias FAG

create table #tipo (tipo varchar(64))

insert into #tipo

select tc_tipo
from cob_custodia..cu_tipo_custodia
where tc_tipo       = @w_fag
union
select tc_tipo
from cob_custodia..cu_tipo_custodia
where tc_tipo_superior  = @w_fag
union
select tc_tipo
from cob_custodia..cu_tipo_custodia
where tc_tipo_superior in (select tc_tipo
                           from cob_custodia..cu_tipo_custodia
                           where tc_tipo_superior = @w_fag)

--4. Cursor 
declare cursor_op cursor 
for select of_oficina
from cobis..cl_oficina
where of_filial = 1
and of_oficina > 0	

open cursor_op           
         
fetch cursor_op into @w_oficina

while (@@fetch_status = 0)
begin   

   insert into cu_cifagm
   (cm_oficina, cm_operacion, cm_banco, cm_llave_red, cm_cliente, cm_val_com, cm_tramite, cm_fecha, cm_dividendo, cm_nombre )
   select op_oficina, op_operacion,op_banco,op_codigo_externo,op_cliente, (am_cuota - am_pagado), op_tramite,di_fecha_ven,di_dividendo, op_nombre
   from cob_cartera..ca_amortizacion,cob_cartera..ca_operacion, cob_cartera..ca_dividendo
   where op_operacion  = am_operacion
   and am_operacion    = di_operacion
   and am_dividendo    = di_dividendo
   and op_operacion    = di_operacion
   and am_concepto     = @w_comisi
   and am_dividendo    > 0
   and di_fecha_ven  between @i_fecha_ini and @i_fecha_fin
   and op_estado not in (@w_cancelado, @w_anulado,@w_credito)
   and di_dividendo > 0
   and di_estado <> @w_cancelado
   and am_estado = 0
   and op_oficina = @w_oficina

   fetch cursor_op into @w_oficina
end
close cursor_op
deallocate cursor_op


--CODIGO DE LA REGIONAL
update cu_cifagm
set cm_regional = of_regional
from cobis..cl_oficina
where of_oficina = cm_oficina
and cm_oficina > 0


--IDENTIFICACION DEL CLIENTE
update cu_cifagm
set cm_identific = en_ced_ruc
from cobis..cl_ente
where en_ente = cm_cliente
and cm_cliente > 0


--DATOS DE LA GARANTIA. BUSCAR TRAMITE ACTIVO

update cu_cifagm
set  cm_codigo_externo  = cu_codigo_externo,
     cm_porc_resp        = gp_porcentaje,
     cm_valor_resp      = cu_valor_actual,
     cm_certificado     = cu_num_dcto
from cob_credito..cr_gar_propuesta,cob_custodia..cu_custodia
where gp_garantia   = cu_codigo_externo
and gp_tramite = cm_tramite
and cu_tipo in (select tipo from #tipo)
and cu_estado in ('P','V','F','X')
and cm_tramite > 0


--VALOR DEL IVA
update cu_cifagm
set cm_val_iva = isnull((am_cuota - am_pagado),0)
from cob_cartera..ca_amortizacion,cob_cartera..ca_dividendo
where am_operacion = cm_operacion
and am_operacion = di_operacion
and am_dividendo = di_dividendo
and  am_concepto   = @w_ivafag
and  di_dividendo  = cm_dividendo
and  cm_operacion > 0


declare cursor_op cursor 
for select cm_operacion
from cob_custodia..cu_cifagm
where cm_operacion > 0
open cursor_op           
         
fetch cursor_op into @w_operacion

while (@@fetch_status = 0)
begin   

  select @w_saldo = 0
  select @w_saldo = isnull(sum(am_cuota + am_gracia - am_pagado),0)
  from cob_cartera..ca_amortizacion, cob_cartera..ca_rubro_op
  where ro_operacion = am_operacion
  and ro_tipo_rubro= 'C'
  and ro_concepto  = am_concepto
  and am_operacion = @w_operacion

  update cu_cifagm
  set cm_saldo = @w_saldo
  where cm_operacion = @w_operacion

  fetch cursor_op into @w_operacion
end


return 0

ERROR:
    exec cobis..sp_cerror
       @t_from  = @w_sp_name,
       @i_num   = 1912115
    return 1 
go



