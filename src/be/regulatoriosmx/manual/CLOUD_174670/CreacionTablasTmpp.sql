use cob_conta_super
go
------------->>>>>>>>>>>>
if OBJECT_ID('sb_est_cuenta_xml_venc') is not null begin
   drop table sb_est_cuenta_xml_venc
end

create table sb_est_cuenta_xml_venc(
   ecx_fecha                           datetime          ,
   ecx_banco                           cuenta            ,
   ecx_tipo_operacion                  varchar(10)   null,
   ecx_secuencial                      int           null,
   ecx_ente                            int               ,             
   ecx_buc                             varchar(20)   null,
   ecx_metodo_pago                     varchar(10)   null,
   ecx_forma_pago                      varchar(10)   null,
   ---------------------- Emisor - INI --------------------
   ecx_ri                              varchar(12)   null,
   ---------------------- Receptor - INI --------------------
   ecx_rfc                             varchar(25)   null,
   ecx_id_externo                      varchar(25)   null,
   ecx_nombre                          varchar(254)  null,
   ecx_telefono                        varchar(20)   null,
   ecx_email                           varchar(100)  null,
   ecx_cfdi_uso_cfdi                   varchar(3)    null,
   ecx_residencia_fiscal               varchar(3)    null,
   -- -------------------- Domicilio - INI --------------------
   -- @Ente
   ecx_calle                           varchar(250)  null,
   ecx_no_exterior                     varchar(200)  null,
   ecx_no_interior                     varchar(200)  null,
   ecx_colonia_parroquia               varchar(250)  null,
   ecx_localidad                       varchar(250)  null,
   ecx_municipio_ciudad                varchar(100)  null,
   ecx_estado_provincia                varchar(100)  null,
   ecx_cod_pais                        varchar(100)  null,
   ecx_codigo_postal                   varchar(80)   null,
   -- -------------------- Encabezado - INI --------------------
   ecx_tipo_documento                  varchar(50)   null,
   ecx_lugar_expedicion                varchar(100)  null,
   ecx_cfdi_metodo_pago                varchar(50)   null,
   ecx_regimen_fiscal_emisor           varchar(3)    null,
   ecx_moneda                          varchar(3)    null,
   ecx_sub_total                       numeric(20,2) null,
   ecx_total                           numeric(20,2) null,
   ecx_cfdi_forma_pago                 varchar(2)    null,
   -- -------------------- Encabezado - Cuerpo - INI --------------------
   ecx_u_x0020_de_x0020_m              varchar(100)  null,
   -- -------------------- Encabezado - Cuerpo - Traslado - INI --------------------
   ecx_codigo_multiple                 varchar(50)   null,
   ecx_cfdi_base                       numeric(20,2) null,
   ecx_cfdi_impuesto                   varchar(3)    null,
   ecx_cfdi_tipo_factor                varchar(10)   null,
   ecx_cfdi_tasao_cuota                varchar(20)   null,
   ecx_cfdi_importe                    numeric(20,2) null,
   -- -------------------- Encabezado - Impuestos - INI --------------------
   ecx_total_impuestos_trasladados     numeric(20,2) null,
    -------------------- Encabezado - Impuestos - Traslado - INI --------------------
   ecx_codigo_multiple_impuesto         varchar(50),
   ecx_cuota_ini                       int           null,
   ecx_cuota_fin                       int           null,
   ecx_int                             numeric(20,2) null, 
   ecx_comision                        numeric(20,2) null,
   ecx_int_anticipado                  numeric(20,2) null,
   ecx_iva                             numeric(20,2) null,
   ecx_file                            varchar(100)  null,
   ecx_pago_complemento                numeric(20,2) null,
   ecx_int_pagado                      numeric(20,2) null,
   ecx_deuda_por_pagar                 numeric(20,2) null,
   ecx_sec_id                          int           null,
   ecx_comisiones_efec_mes             money         null,
   ecx_estado_cartera                  int           null
   
)
go
