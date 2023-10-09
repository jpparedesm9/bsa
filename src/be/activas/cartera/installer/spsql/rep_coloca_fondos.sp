/************************************************************************/
/*      Archivo:                rep_coloca_fondos.sp                    */
/*      Stored procedure:       sp_rep_coloca_fondos                    */
/*      Producto:               Cartera                                 */
/*      Disenado por:           Miguel Roa                              */
/*      Fecha de escritura:     Jul. 2008                               */
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
/*      Genera datos para el reporte                                    */
/*      "Reporte colocaciones por fondos                                */
/************************************************************************/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_rep_coloca_fondos')
   drop proc sp_rep_coloca_fondos
go
create proc sp_rep_coloca_fondos
    @i_fecha_ini  datetime  = null, --Fecha inicial de fechas de desembolso
    @i_fecha_fin  datetime  = null  --Fecha final de fechas de desembolso

as

declare @w_sp_name            varchar(32),
        @w_return             int,
        @w_error              int,
        @w_est_vigente        tinyint,
        @w_est_vencido        tinyint,
        @w_est_cancelado      tinyint,
        @w_est_castigado      tinyint,
        @w_est_suspenso       tinyint,
        @w_pa_char_tdr        char(3),
        @w_pa_char_tdn        char(3),
        @w_en_tipo_ced        char(2),
        @w_des_tipo_ced       descripcion,
        @w_en_ced_ruc         numero,
        @w_op_nombre          descripcion,
        @w_op_banco           cuenta,
        @w_cod_estrato        varchar(10),
        @w_des_estrato        descripcion,
        @w_p_fecha_nac        datetime,
        @w_p_ciudad_nac       int,
        @w_nom_ciudad_nac     descripcion,
        @w_tr_fecha_apr       datetime,
        @w_op_tplazo          catalogo,
        @w_op_plazo           smallint,
        @w_plazo_meses        smallint,
        @w_p_sexo             sexo,
        @w_des_sexo           varchar(10),
        @w_dir_microempresa   varchar(254),
        @w_tel_microempresa   varchar(16),
        @w_op_ciudad          int,
        @w_nom_ciudad         descripcion,
        @w_tas_nominal        float,
        @w_edad_deudor        int,
        @w_tot_activos        money,
        @w_op_monto           money,
        @w_sal_capital        money

/* ESTADO DE LAS OPERACIONES */
select @w_est_vigente = es_codigo
from   ca_estado
where  ltrim(rtrim(es_descripcion)) = 'VIGENTE'

select @w_est_vencido = es_codigo
from   ca_estado
where  ltrim(rtrim(es_descripcion)) = 'VENCIDO'

select @w_est_cancelado = es_codigo
from   ca_estado
where  ltrim(rtrim(es_descripcion)) = 'CANCELADO'

select @w_est_castigado = es_codigo
from   ca_estado
where  ltrim(rtrim(es_descripcion)) = 'CASTIGADO'

select @w_est_suspenso = es_codigo
from   ca_estado
where  ltrim(rtrim(es_descripcion)) = 'SUSPENSO'

/* PARAMETROS DE TIPOS DE DIRECCION */
select @w_pa_char_tdr = pa_char
from   cobis..cl_parametro
where  ltrim(rtrim(pa_nemonico)) = 'TDR'

select @w_pa_char_tdn = pa_char
from   cobis..cl_parametro
where  ltrim(rtrim(pa_nemonico)) = 'TDN'

/*CREACION DE TABLA TEMPORAL PARA EL REPORTE */
if exists (select 1 from dbo.sysobjects where id = object_id(N'[dbo].[ca_rep_coloca_fondos]') and OBJECTPROPERTY(id, N'IsTable') = 1) begin
    drop table cob_cartera..ca_rep_coloca_fondos
end
create table cob_cartera..ca_rep_coloca_fondos
   (
   tmp_en_tipo_ced         char(2)      null,  --C�digo del tipo de documento del cliente
   tmp_des_tipo_ced        descripcion  null,  --Descripci�n del tipo de documento del cliente
   tmp_en_ced_ruc          numero       null,  --N�mero de identificaci�n del cliente
   tmp_op_nombre           descripcion  null,  --Nombre del cliente
   tmp_op_banco            cuenta       null,  --N�mero de operaci�n de cr�dito
   tmp_cod_estrato         varchar(10)  null,  --C�digo del estrato del cliente
   tmp_des_estrato         descripcion  null,  --Descripci�n del estrato del cliente
   tmp_p_fecha_nac         datetime     null,  --Fecha de nacimiento del cliente
   tmp_p_ciudad_nac        int          null,  --C�digo ciudad de nacimiento del cliente
   tmp_nom_ciudad_nac      descripcion  null,  --Nombre de la ciudad de nacimiento del cliente
   tmp_tr_fecha_apr        datetime     null,  --Fecha de aprobaci�n del tr�mite
   tmp_op_tplazo           catalogo     null,  --Tipo de plazo de la operaci�n
   tmp_op_plazo            smallint     null,  --Plazo de la operaci�n seg�n el tipo de plazo
   tmp_pla_meses           smallint     null,  --Plazo de la operaci�n en meses
   tmp_p_sexo              sexo         null,  --Sexo del deudor principal
   tmp_des_sexo            descripcion  null,  --Descripci�n del sexo del deudor principal
   tmp_dir_microempresa    varchar(254) null,  --Direcci�n de la microempresa
   tmp_tel_microempresa    varchar(16)  null,  --Tel�fono de la microempresa
   tmp_op_ciudad           int          null,  --C�digo de la ciudad del pr�stamo
   tmp_nom_ciudad          descripcion  null,  --Nombre de la ciudad del pr�stamo
   tmp_tas_nominal         float        null,  --Valor de la tasa nominal de inter�s
   tmp_edad_deudor         int          null,  --Edad del deudor principal
   tmp_tot_activos         money        null,  --Total activos de la microempresa
   tmp_op_monto            money        null,  --Monto del desembolso
   tmp_sal_capital         money        null,  --Saldo de capital a la fecha
   tmp_nit_empresa         numero       null,  --Nit de la microempresa
   tmp_nom_empresa         descripcion  null,  --Nombre de la microempresa
   tmp_cod_act_eco         catalogo     null,  --C�digo de la actividad econ�mica del cliente
   tmp_nom_act_eco         descripcion  null,  --Descripci�n de la actividad econ�mica del cliente
   tmp_cod_sec_eco         catalogo     null,  --C�digo del sector econ�mico del cliente
   tmp_nom_sec_eco         descripcion  null,  --Descripci�n del sector econ�mico del cliente
   tmp_can_tra_emp         int          null,  --N�mero de trabajadores de la microempresa
   tmp_fec_liq             datetime     null,  --Fecha de liquidaci�n de la operaci�n
   tmp_tas_efectiva        float        null,  --Tasa efectiva de inter�s corriente
   tmp_op_cuota            money        null,  --Valor de la cuota inicial del pr�stamo
   tmp_num_cuo_pen         int          null,  --N�mero de cuotas pendientes
   tmp_sal_cap_int_imo     money        null,  --Saldo de capital con intereses
   tmp_vlr_com_hon         money        null,
   tmp_cod_destino         catalogo     null,  --C�digo destino del pr�stamo
   tmp_des_destino         descripcion  null,  --Descripci�n del destino econ�mico del pr�stamo
   tmp_cod_ciu_mic         int          null,  --C�digo de la ciudad de la microempresa
   tmp_nom_ciu_mic         descripcion  null,  --Nombre de la ciudad de la microempresa
   tmp_num_tel_mic         descripcion  null,  --N�mero de tel�fono de la microempresa
   tmp_cod_lin_cre         catalogo     null,  --C�digo de la l�nea de cr�dito de la operaci�n
   tmp_des_lin_cre         descripcion  null,  --Descripci�n de la linea de cr�dito de la operaci�n
   tmp_cod_ofi_pre         smallint     null,  --C�digo de la oficina de la operaci�n
   tmp_des_ofi_pre         descripcion  null,  --Descripci�n de la oficina de la operaci�n
   tmp_cod_bar_mic         smallint     null,  --C�digo del barrio de la microempresa
   tmp_des_bar_mic         descripcion  null,  --Descripci�n del barrio de la microempresa
   tmp_vlr_cuot            money        null,
   tmp_cod_est_ope         tinyint      null,  --C�digo del estado de la operaci�n
   tmp_des_est_ope         descripcion  null,  --Descripci�n del estado de la operaci�n
   tmp_com_pym             money        null,  --Valor rubro mipymes
   tmp_cuo_otr_rub         money        null,  --Valor cuota con otros rubros sin iva
   tmp_tot_gar_pre         money        null,   --Valor garant�as prendarias
   tmp_num_obl_int         int          null,    -- Numero de obligacion del intermediario
   tmp_tipo_soc            char(3)      null,
   tmp_fec_desembolso      datetime     null,
   tmp_sector              char(1)      null
   )

/* crear tabla con codigos de fuentes de recurso emprender */
select c.codigo 
into #temp_cod
from cobis..cl_tabla as t ,
cobis..cl_catalogo as c
where t.tabla='cr_fuente_recurso'
and t.codigo = c.tabla
and c.valor like '%EMPRENDER%'


/* INSERCION EN TABLA TEMPORAL DE LOS DATOS DEL REPORTE */
insert into cob_cartera..ca_rep_coloca_fondos
select
      en_tipo_ced,                                --C�digo del tipo de documento del cliente
      (select valor                               --Nombre del tipo de documento del cliente
       from cobis..cl_tabla t,
            cobis..cl_catalogo c
       where t.tabla = 'cl_tipo_documento'
       and   c.tabla = t.codigo
       and   c.codigo = en_tipo_ced) ,
      en_ced_ruc,                                 --N�mero de identificaci�n del cliente
      op_nombre,                                  --Nombre del cliente
      op_banco,                                   --N�mero de la operaci�n de cr�dito
      en_estrato,                                 --Estrato del cliente
      (select valor                               --Descripci�n del estrato del cliente
       from cobis..cl_tabla t,
            cobis..cl_catalogo c
       where t.tabla = 'cl_estrato'
       and   c.tabla = t.codigo
       and   c.codigo = en_estrato),
      p_fecha_nac,                                --Fecha de nacimiento del cliente
      p_ciudad_nac,                               --C�digo de ciudad de nacimiento del cliente
      (select valor                               --Descripci�pn de la ciudad de nacimiento del cliente
       from cobis..cl_tabla t,
            cobis..cl_catalogo c
       where t.tabla = 'cl_ciudad'
       and   c.tabla = t.codigo
       and   c.codigo = p_ciudad_nac),
      tr_fecha_apr,                               --Fecha de aprobaci�n del tr�mite
      op_tplazo,                                  --Tipo de plazo de la operaci�n
      op_plazo,                                   --Plazo de la operaci�n
      (select (op_plazo * td_factor)/30           --Plazo en meses de la operaci�n
       from cob_cartera..ca_tdividendo
       where td_tdividendo = op_tplazo),
      p_sexo,                                     --C�digo del sexo del cliente
      (select substring(isnull(valor,''),1,10)                               --Descripci�n del sexo del cliente
       from cobis..cl_tabla t,
            cobis..cl_catalogo c
       where t.tabla = 'cl_sexo'
       and   c.tabla = t.codigo
       and   c.codigo = p_sexo),
      isnull((select di_descripcion                 --Direcci�n de la microempresa
       from   cobis..cl_direccion
              left outer join cobis..cl_telefono
              on  te_ente      = di_ente
              and te_direccion = di_direccion
       where di_ente      = op_cliente
       and   di_direccion = @w_pa_char_tdn),'SIN DIRECCION'),
      isnull((select isnull(te_valor,0)                     --Tel�fono de la microempresa
       from   cobis..cl_direccion
              left outer join cobis..cl_telefono
              on  te_ente      = di_ente
              and te_direccion = di_direccion
       where di_ente      = op_cliente
       and   di_direccion = @w_pa_char_tdn),''),
      op_ciudad,                                     --C�digo de ciudad de colocaci�n
      (select valor                                  --Nombre de la ciudad de colocaci�n
       from cobis..cl_tabla t,
            cobis..cl_catalogo c
       where t.tabla = 'cl_ciudad'
       and   c.tabla = t.codigo
       and   c.codigo = op_ciudad),
      (select ro_porcentaje                          --Tasa nominal del pr�stamo
       from cob_cartera..ca_rubro_op
       where ro_operacion = op_operacion
       and   ro_concepto = 'INT'),
      (select datediff(yy, p_fecha_nac, getdate())   --Edad del cliente
       from cobis..cl_ente
       where en_ente = op_cliente),
      isnull((select sum(mi_total_eyb + mi_total_cxc + mi_total_mp + mi_total_pep + mi_total_pt + mi_total_af) --Total activos de la microempresa
       from cob_credito..cr_microempresa
       where mi_tramite = op_tramite),0),
      op_monto,                                      --Monto del desembolso de la operaci�n
      (select sum(am_cuota + am_gracia - am_pagado)  --Saldo de capital de la operaci�n
       from cob_cartera..ca_amortizacion
       where am_operacion = op_operacion
       and   am_concepto  = 'CAP'),
      isnull((select mi_identificacion                      --Nit de la empresa
       from cob_credito..cr_microempresa
       where mi_tramite = tr_tramite),''),
      isnull((select mi_nombre                              --Nombre de la empresa
       from cob_credito..cr_microempresa
       where mi_tramite = tr_tramite),''),
      en_actividad,                                         --Actividad econ�mica del cliente
      isnull((select valor                                  --Nombre de la actividad econ�mica del cliente
       from cobis..cl_tabla t,
            cobis..cl_catalogo c
       where t.tabla = 'cl_actividad'
       and   c.tabla = t.codigo
       and   c.codigo = en_actividad),''),
      en_sector,                                            --C�digo del sector econ�mico del cliente
      (select valor                                         --Nombre del sector econ�mico del cliente
       from cobis..cl_tabla t,
            cobis..cl_catalogo c
       where t.tabla = 'cl_sectoreco'
       and   c.tabla = t.codigo
       and   c.codigo = en_sector),
      isnull((select isnull(mi_num_trabaj_remu,0) + isnull(mi_num_trabaj_no_remu,0)   --N�mero de trabajadores de la microempresa
       from cob_credito..cr_microempresa
       where mi_tramite = tr_tramite),0),                       -- numero de trabajadores
      op_fecha_liq,                                             --Fecha de liquidaci�n de la operaci�n
      (select ro_porcentaje_efa                                 --Tasa efectiva anual
       from cob_cartera..ca_rubro_op
       where ro_operacion = op_operacion
       and   ro_concepto = 'INT'),
      op_cuota,                                             --Valor de la cuota mensual
      (select isnull(count(*),0)                            --N�mero de cuotas pendientes
       from ca_dividendo
       where di_operacion = op_operacion
       and   di_estado    = 0),
      (select sum(am_cuota + am_gracia - am_pagado)         --Saldo de capital de la operaci�n
       from cob_cartera..ca_amortizacion
       where am_operacion = op_operacion
       and   am_concepto  not in ('CAP','INT','IMO')),
       0,
      tr_destino,                                           --C�digo destino del pr�stamo
      isnull((select valor                                  --Descripci�n destino del pr�stamo
       from cobis..cl_tabla t,
            cobis..cl_catalogo c
       where t.tabla = 'cr_destino'
       and   c.tabla = t.codigo
       and   c.codigo = tr_destino),0) ,
      isnull((select mi_ciudad                               --C�digo ciudad de la microempresa
       from cob_credito..cr_microempresa
       where mi_tramite = tr_tramite),0),
      isnull((select valor                                   --Nombre de la ciudad de la microempresa
       from cobis..cl_tabla t,
            cobis..cl_catalogo c
       where t.tabla = 'cl_ciudad'
       and   c.tabla = t.codigo
       and   c.codigo = (select top 1 mi_ciudad
                         from cob_credito..cr_microempresa
                         where mi_tramite = tr_tramite)),''),
      isnull((select mi_telefono                                --N�mero de tel�fono de la microempresa
       from cob_credito..cr_microempresa
       where mi_tramite = tr_tramite),''),
      op_toperacion,                                            --C�digo de la l�nea de cr�dito
      isnull((select valor                                      --Descripci�n de la l�nea de cr�dito
       from cobis..cl_tabla t,
            cobis..cl_catalogo c
       where t.tabla = 'ca_toperacion'
       and   c.tabla = t.codigo
       and   c.codigo = op_toperacion),0),
      op_oficina,                                               --C�digo de la oficina
      (select of_nombre                                         --Nombre de la oficina
       from cobis..cl_oficina
       where of_oficina = op_oficina),

      isnull((select mi_barrio                               --C�digo barrio de la microempresa
       from cob_credito..cr_microempresa
       where mi_tramite = tr_tramite),''),
      isnull((select valor                                   --Nombre del barrio de la microempresa
       from cobis..cl_tabla t,
            cobis..cl_catalogo c
       where t.tabla = 'cl_parroquia'
       and   c.tabla = t.codigo
       and   c.codigo = (select top 1 mi_barrio
                         from cob_credito..cr_microempresa
                         where mi_tramite = tr_tramite)),''),
       0,
       op_estado,                                               --C�digo del estado de la operaci�n
      isnull((select es_descripcion                             --Descripci�n del estado de la operaci�n
       from ca_estado
       where es_codigo = op_estado),''),
      isnull((select ro_valor                                   --Valor MIPYMES
       from cob_cartera..ca_rubro_op
       where ro_operacion = op_operacion
       and   ro_concepto = 'MIPYMES'),''),
      (select sum(ro_valor)                                     --Valor cuota con otros rubros sin iva
       from cob_cartera..ca_rubro_op
       where ro_operacion = op_operacion
       and   ro_tipo_rubro in ('C','Q','M','I')),
      isnull((select sum(dj_total_bien)                         --Sumatoria de garantias prendarias de la microempresa
       from cob_credito..cr_microempresa,
            cob_credito..cr_dec_jurada
       where mi_tramite    = tr_tramite
       and   dj_codigo_mic = mi_secuencial
       group by mi_secuencial),0),
       isnull(tr_op_redescuento,''),
       '',
       isnull((select dm_fecha
        from cob_cartera..ca_desembolso
        where dm_operacion= op_operacion),''),
       ' '


from  cob_cartera..ca_operacion,
      cob_credito..cr_tramite,
      cobis..cl_ente
where op_estado     in (@w_est_vigente,@w_est_vencido,@w_est_cancelado,@w_est_castigado,@w_est_suspenso)
and   op_fecha_liq  between @i_fecha_ini and @i_fecha_fin
and   tr_tramite    = op_tramite
and   en_ente       = op_cliente
and   tr_fuente_recurso  in (select * from #temp_cod)    -- fondo emprender

order by op_oficina

select * from ca_rep_coloca_fondos

return 0

ERROR:

exec cobis..sp_cerror
   @t_debug = 'N',
   @t_from  = @w_sp_name,
   @i_num   = @w_error

return @w_error

go
