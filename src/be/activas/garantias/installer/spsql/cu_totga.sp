/***********************************************************************/
/*	Archivo:                  cu_totga.sp                          */
/*	Stored procedure:         sp_totga                             */
/*	Base de Datos:            cob_custodia                         */
/*	Producto:                 Custodia                             */
/*	Disenado por:             Silvia Portilla                      */
/*	Fecha de Documentacion:   05/Abril/2005                        */
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
/*	Permite almacenar la informacion en la tabla cu_totgar con     */
/*      datos para generacion de informe por cada tipo de garantíad    */
/***********************************************************************/
/*			MODIFICACIONES				       */
/*	FECHA		AUTOR			RAZON		       */
/*	05/04/2005	Angela Tovar	Emision Inicial	               */
/***********************************************************************/
use cob_custodia
go


if exists (select 1 from sysobjects where name = 'sp_totga')
    drop proc sp_totga
go


create proc sp_totga 
(
   @i_fecha_ini          datetime,
   @i_fecha_fin          datetime
)

as
declare
   @w_today            datetime,     /* fecha del dia */ 
   @w_sp_name          varchar(32),  /* nombre stored proc*/
   @w_error            int, 
   @w_operacion        int,
   @w_tipo_cobro       char(1),
   @w_saldo            money,
   @w_anulado          tinyint,
   @w_cancelado        tinyint,
   @w_saldo_capital    money

select @w_today = getdate()
select @w_sp_name = 'sp_totga'


--ESTADO CANCELADO Y ANULADO DE LAS OPERACION
select @w_anulado = pa_tinyint
from cobis..cl_parametro
where pa_producto = 'CRE'
and pa_nemonico = 'ESTANU'


select @w_cancelado = pa_tinyint
from cobis..cl_parametro
where pa_producto = 'CRE'
and pa_nemonico = 'ESTCAN'

  
truncate table cob_custodia..cu_totgar


-- 1. Insercion de datos en la tabla cu_totgar
insert into cob_custodia..cu_totgar
-- 2. Seleccionar los campos en 
select cu_codigo_externo,
cu_tipo,
cu_estado,
isnull(cu_valor_inicial,0),
isnull(gp_porcentaje,0),
cu_ubicacion,
'',
isnull(cu_valor_actual,0),
op_operacion,
op_banco,
op_cliente,
'',
op_nombre,
0,
0,
op_tipo_cobro,
op_oficina,
0,
'',
''
from cob_custodia..cu_custodia,cob_cartera..ca_operacion,cob_credito..cr_gar_propuesta
where cu_codigo_externo = gp_garantia
and gp_tramite = op_tramite
and cu_estado in ('P','F', 'V', 'X')
and cu_filial = 1
and cu_custodia >0
and cu_tipo > ''
and cu_sucursal > 0
and op_operacion > 0
and op_tramite > 0
and op_estado not in (@w_anulado, @w_cancelado)
and cu_fecha_ingreso between @i_fecha_ini and @i_fecha_fin

--3. Actualizacion de datos en cu_totgar
update cob_custodia..cu_totgar
set to_identific = en_ced_ruc
from cobis..cl_ente
where en_ente = to_cliente
and to_cliente > 0

--6. Actualizacion del campo to_regional

update cob_custodia..cu_totgar
set to_regional = convert(int,codigo_sib)
from cobis..cl_oficina,
     cob_credito..cr_corresp_sib
where of_oficina = to_oficina
and   of_regional = convert(int,codigo)
and   tabla = 'T21'
and   to_oficina > 0
and   to_ubicacion > ''

-- 5. Campo de determinacion de campo to_desc_ubica
update cob_custodia..cu_totgar
set to_desc_ubica = b.valor
from cobis..cl_tabla a,cobis..cl_catalogo b
where a.tabla = 'cu_ubicacion_doc'
and a.codigo = b.tabla
and b.codigo = to_ubicacion
and to_oficina > 0
and to_ubicacion > ''

--7. Actualizacion del campo to_desc_regional

update cob_custodia..cu_totgar
set to_desc_regional = of_nombre
from cobis..cl_oficina
where of_oficina = to_regional
and to_oficina > 0
and to_ubicacion > ''
and to_regional > 0


--7. Actualizacion del campo to_desc_oficina

update cob_custodia..cu_totgar
set to_desc_oficina = of_nombre
from cobis..cl_oficina
where of_oficina = to_oficina
and to_oficina > 0
and to_ubicacion > ''
and to_regional > 0



--8. Declaracion de cursor 

declare cursor_totga cursor 
        for select to_operacion,
                   to_tipo_cobro
        from cob_custodia..cu_totgar
        where to_estado in ('P','F','V','X')
        
        open cursor_totga
        
        fetch cursor_totga into
                @w_operacion,
                @w_tipo_cobro
         
        while (@@fetch_status = 0)
             begin   

             select @w_saldo = 0

             exec @w_error = cob_cartera..sp_calcula_saldo
                   @i_operacion = @w_operacion,
                   @i_tipo_pago = @w_tipo_cobro,
                   @o_saldo     = @w_saldo out

	     select @w_saldo = isnull(@w_saldo,0)


	     select @w_saldo_capital =  sum(am_cuota + am_gracia - am_pagado)
	     from cob_cartera..ca_amortizacion, cob_cartera..ca_rubro_op
	     where am_operacion  = ro_operacion
             and   am_concepto   = ro_concepto
	     and   ro_tipo_rubro = "C"     --CAPITAL
             and   am_operacion  = @w_operacion



        update cob_custodia..cu_totgar
        set to_saldo_cap  = @w_saldo_capital,
	    to_saldo_xpag = @w_saldo
        where to_operacion = @w_operacion
                  
               
        fetch cursor_totga into
                @w_operacion,
                @w_tipo_cobro
  
        end -- while

      close cursor_totga
      deallocate cursor_totga

go