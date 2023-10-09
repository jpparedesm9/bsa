/*************************************************************************************/
--No Historia				 : H84619
--Título de la Historia		 : Paso de datos a cob_conta_super
--Fecha					     : 09/28/2016
--Descripción del Problema	 : Determinar los procesos que realizan el paso de datos a cob_externos
--                             Determinar los procesos que realizan el paso de datos a cob_conta_super
--Descripción de la Solución : Creacion de cotizacion moneda MXN: MEXICANOS
--Autor						 : Jorge Salazar Andrade
--Instalador                 : conversion_moneda.sql
--Ruta Instalador            : $/COB/Releases/REL_SaaSMX_4.1.0.0/ParamMX/sql
/*************************************************************************************/

use cob_conta
go

declare @w_moneda tinyint

select @w_moneda = mo_moneda 
  from cobis..cl_moneda
 where mo_nemonico = 'MXN' 

if exists (select 1 from cob_conta..cb_cotizacion 
            where ct_moneda = @w_moneda)
   delete cob_conta..cb_cotizacion 
    where ct_moneda = @w_moneda 
      and ct_fecha  = (select max(ct_fecha)
                         from cob_conta..cb_cotizacion
                        where ct_moneda = @w_moneda)

insert into cob_conta..cb_cotizacion (ct_moneda, ct_fecha, ct_valor, ct_compra, ct_venta, ct_factor1, ct_factor2)
values (@w_moneda, getdate(), 1, 1, 1, 1, 1)
go


/*************************************************************************************/
--No Historia				 : H84619
--Título de la Historia		 : Paso de datos a cob_conta_super
--Fecha					     : 09/28/2016
--Descripción del Problema	 : Determinar los procesos que realizan el paso de datos a cob_externos
--                             Determinar los procesos que realizan el paso de datos a cob_conta_super
--Descripción de la Solución : Alteracion de tipo de dato campo sb_reporte_r08.NUMERO_CUENTA
--Autor						 : Jorge Salazar Andrade
--Instalador                 : reg_tabla.sql
--Ruta Instalador            : $/COB/Releases/REL_SaaSMX_4.1.0.0/RegulatoriosMX/BackEnd/sql
/*************************************************************************************/
use cob_conta_super
go

if not object_id('sb_reporte_r08') is null
drop table sb_reporte_r08
go

create table sb_reporte_r08
(
   PERIODO             varchar(6)      not null,
   CLAVE_ENTIDAD       numeric(6)      not null,
   SUBREPORTE          numeric(4)      not null,
   IDENTIFICACION      varchar(12)     not null,
   TIPO_SOCIO          numeric(3)      not null,
   NOM_RAZ_SOCIAL      varchar(150)    not null,
   APELLIDO_MATERNO    varchar(150)    not null,
   APELLIDO_PATERNO    varchar(150)    not null,
   RFC_SOCIO           varchar(13)     not null,
   CURP_SOCIO          varchar(18)     not null,
   GENERO              numeric(3)      not null,
   FECHA_NAC_CONS      varchar(8)      not null,
   POSTAL_DOMICILIO    numeric(25)     not null,
   LOCAL_DOMICILIO     numeric(12)     not null,
   ESTADO_DOMICILIO    numeric(4)      not null,
   PAIS_DOMICILIO      numeric(4)      not null,
   NUM_CERTI_APO       numeric(21)     not null,
   MONTO_CERTI_APO     numeric(21)     not null,
   NUM_CERTI_EXCED     numeric(21)     not null,
   MONTO_CERTI_EXCED   numeric(21)     not null,
   NUMERO_CONTRATO     varchar(12)     not null,
   NUMERO_CUENTA       varchar(24)     not null,
   NOMBRE_SUCURSAL     varchar(150)    not null,
   FECHA_CONTRATO      varchar(8)      not null,
   TIPO_PRODUCTO       numeric(3)      not null,
   TIPO_MODALIDAD      numeric(3)      not null,
   TASA_ANUAL_REND     numeric(6)      not null,
   MONEDA              numeric(3)      not null,
   PLAZO               numeric(4)      not null,
   FECHA_VENCIMIENTO   varchar(8)      not null,
   SALDO_PERIODO_INI   numeric(21)     not null,
   MONTO_DEPOSITO      numeric(21)     not null,
   MONTO_RETIRO        numeric(21)     not null,
   INTERES_DEVENGADO   numeric(18,2)   not null,
   SALDO_PERIODO_FIN   numeric(21)     not null,
   FECHA_ULT_MOV       varchar(8)      not null,
   TIPO_APERTURA_CTA   numeric(3)      not null
)
go

create clustered index sb_reporte_r08_key
    on sb_reporte_r08 (PERIODO,CLAVE_ENTIDAD,SUBREPORTE,NUMERO_CUENTA)
go

