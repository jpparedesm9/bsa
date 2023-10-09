/***********************************************************************/
/*	Archivo:                  cu_cfagd.sp                          */
/*	Stored procedure:         sp_cfagd                             */
/*	Base de Datos:            cob_custodia                         */
/*	Producto:                 Custodia                             */
/*	Disenado por:          	  Silvia Portilla                      */
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
/*	Genera diariamente reporte de las comisiones de IVA liquidadas */
/*	para pagar el FAG.                               	       */
/***********************************************************************/
/*			MODIFICACIONES				       */
/*	FECHA		AUTOR			RAZON		       */
/*	07/04/2005	Angela Tovar    Emision Inicial	               */
/***********************************************************************/
use cob_custodia
go


if exists (select 1 from sysobjects where name = 'sp_cfagd')
    drop proc sp_cfagd
go


create proc sp_cfagd 
(
@i_fecha        datetime   = null
)

as
declare
   @w_today		       datetime,     /* fecha del dia */ 
   @w_sp_name          varchar(32),  /* nombre stored proc*/
   @w_error            int,
   @w_ivafag         varchar(64),
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
   @w_anulado          tinyint,
   @w_cancelado        tinyint,
   @w_op_pas           int,
   @w_credito          tinyint,
   @w_tram_activa      int


select @w_today = getdate()
select @w_sp_name = 'sp_cfagd'

truncate table cob_custodia..cu_cifagd

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

select @w_credito = null
select @w_credito = pa_tinyint
from cobis..cl_parametro
where pa_producto = 'CRE'
and pa_nemonico = 'ESTCRE'

if @w_credito is null
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


--BORRAR DATOS DE LA TABLA DEL REPORTE
truncate table cu_cifagd

declare cursor_op cursor for 
select of_oficina
from cobis..cl_oficina
where of_filial = 1
and of_oficina > 0	

open cursor_op
fetch cursor_op into @w_oficina
           
while (@@fetch_status = 0)
begin   
   --INSERCION DE LOS DATOS PRINCIPALES DE LAS OPERACIONES
   insert into cu_cifagd
   (co_oficina, co_operacion, co_banco, co_llave_red, co_cliente, co_nombre, co_val_com, co_tramite)
   select op_oficina, op_operacion,op_banco,op_codigo_externo,op_cliente,op_nombre,ro_valor,op_tramite
   from cob_cartera..ca_rubro_op,cob_cartera..ca_operacion
   where ro_fpago = 'L'
   and op_operacion = ro_operacion
   and op_fecha_liq = @i_fecha
   and ro_operacion > 0
   and ro_concepto = @w_comisi
   and op_oficina = @w_oficina
   and op_estado not in (@w_cancelado, @w_anulado,@w_credito)
   union
   select op_oficina, op_operacion,op_banco,op_codigo_externo,op_cliente,op_nombre,ro_valor,op_tramite
   from cob_cartera..ca_rubro_op,cob_cartera..ca_operacion
   where ro_fpago = 'A'
   and op_operacion = ro_operacion
   and op_fecha_liq = @i_fecha
   and ro_operacion > 0
   and ro_concepto = @w_comisi
   and op_oficina = @w_oficina
   and op_estado not in (@w_cancelado, @w_anulado,@w_credito)        
   fetch cursor_op into @w_oficina
end --while
close cursor_op
deallocate cursor_op

--ACTUALIZACION CODIGO DE LA REGIONAL
update cu_cifagd
set co_regional = of_regional
from cobis..cl_oficina
where of_oficina = co_oficina
and co_oficina > 0

--ACTUALIZACION IDENTIFICACION CLIENTE
update cu_cifagd
set co_identific = en_ced_ruc
from cobis..cl_ente
where en_ente = co_cliente
and co_cliente > 0


--DATOS DE LA GARANTIA. BUSCAR TRAMITE ACTIVO

   update cu_cifagd
   set  co_codigo_externo  = cu_codigo_externo,
        co_tipo_gar        = cu_tipo,
        co_porc_resp        = gp_porcentaje,
        co_valor_resp      = cu_valor_cobertura,
        co_certificado     = cu_num_dcto
   from cob_credito..cr_gar_propuesta,cob_custodia..cu_custodia
   where gp_garantia   = cu_codigo_externo
   and gp_tramite = co_tramite
   and cu_tipo in (select tipo from #tipo)
   and cu_estado in('P','V','F','X')
   and co_tramite > 0

   --Descripcion del tipo de garantia
   update cu_cifagd
   set  co_desc_tg = tc_descripcion
   from cob_custodia..cu_tipo_custodia
   where tc_tipo = co_tipo_gar



--Valor IVA

update cob_custodia..cu_cifagd
set co_val_iva  = ro_valor
from cob_cartera..ca_rubro_op
where ro_fpago = 'L'
and ro_operacion = co_operacion
and ro_concepto = @w_ivafag
and co_tramite > 0
and co_operacion > 0

update cob_custodia..cu_cifagd
set co_val_iva = isnull(co_val_iva,0) + ro_valor
from cob_cartera..ca_rubro_op
where ro_fpago = 'A'
and ro_operacion = co_operacion
and ro_concepto = @w_ivafag
and co_tramite > 0
and co_operacion > 0


return 0

ERROR:
    exec cobis..sp_cerror
       @t_from  = @w_sp_name,
       @i_num   = 1912115
    return 1 

go

