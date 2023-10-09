use cob_compensacion
go

if exists(select 1 from sysobjects
           where name = 'cr_dato_operacion_rep')
   drop table cr_dato_operacion_rep
go
		   
create table cr_dato_operacion_rep
(
   do_fecha                    datetime      not null,
   do_tipo_reg                 char(1)       not null,
   do_numero_operacion         int           not null,
   do_numero_operacion_banco   varchar(24)   not null,
   do_tipo_operacion           varchar(10)   not null,
   do_codigo_producto          tinyint       not null,
   do_codigo_cliente           int           not null,
   do_oficina                  smallint      not null,
   do_sucursal                 smallint      not null,
   do_regional                 varchar(10)   not null,
   do_moneda                   tinyint       not null,
   do_monto                    money         not null,
   do_tasa                     float         null,
   do_codigo_destino           varchar(10)   not null,
   do_clase_cartera            varchar(10)   not null,
   do_codigo_geografico        int           not null,
   do_departamento             smallint      not null,
   do_tipo_garantias           varchar(10)   null,
   do_valor_garantias          money         null,
   do_admisible                char(1)       null,
   do_saldo_cap                money         not null,
   do_saldo_int                money         not null,
   do_saldo_otros              money         not null,
   do_saldo_int_contingente    money         not null,
   do_saldo                    money         not null,
   do_estado_contable          tinyint       not null,
   do_periodicidad_cuota       smallint      null,
   do_edad_mora                int           null,
   do_valor_mora               money         null,
   do_valor_cuota              money         null,
   do_cuotas_pag               smallint      null,
   do_cuotas_ven               smallint      null,
   do_num_cuotas               smallint      null,
   do_fecha_pago               datetime      null,
   do_fecha_ini                datetime      not null,
   do_fecha_fin                datetime      not null,
   do_estado_cartera           tinyint       null,
   do_reestructuracion         char(1)       null,
   do_fecha_ult_reest          datetime      null,
   do_plazo_dias               int           null,
   do_gerente                  smallint      not null,
   do_calificacion             varchar(10)   null,
   do_prov_cap                 money         null,
   do_prov_int                 money         null,
   do_prov_cxc                 money         null,
   do_situacion_cliente        catalogo      null,
   do_gracia_cap               smallint      null,
   do_gracia_int               smallint      null,
   do_probabilidad_default     float         null,
   do_nat_reest                catalogo      null,
   do_num_reest                tinyint       null,
   do_acta_cas                 catalogo      null,
   do_fecha_cas                datetime      null,
   do_capsusxcor               money         null,
   do_intsusxcor               money         null,
   do_moneda_op                money         null,
   do_calificacion_mr          varchar(10)   null,
   do_proba_incum              float         null,
   do_prov_con_int             money         null,
   do_prov_con_cxc             money         null,
   do_perd_incum               float         null,
   do_tipo_emp_mr              char(2)       null,
   do_prov_con_cap             money         null,
   do_fecha_cambio             datetime      null,
   do_ciclo_fact               datetime      null,
   do_valor_ult_pago           money         null,
   do_fecha_castigo            datetime      null,
   do_num_acta                 varchar(24)   null,
   do_clausula                 char(1)       null
)
create nonclustered index cr_dato_operacion_rep_Key
    on cr_dato_operacion_rep(do_numero_operacion_banco)
go

