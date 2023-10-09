/*************************************************************************************/
--No Historia				 : H81321
--Título de la Historia		 : Reporte Regulatorio R08
--Fecha					     : 08/18/2016
--Descripción del Problema	 : Se requiero de la generacion del reporte regulatorio R08
--Descripción de la Solución : Creacion de equivalencias de catalogos
--Autor						 : Jorge Salazar Andrade
--Instalador                 : validacion_equivalencias.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/ParamMX/sql
/*************************************************************************************/

use cob_conta_super
go

delete sb_equivalencias where eq_catalogo in ('TIPO_ENTE','CL_SEXO','AH_TIPOCTA','TIPO_MODO')
go

insert into sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
values ('TIPO_ENTE', '1', 'P', 'SOCIO PERSONA FISICA', 'V')

insert into sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
values ('TIPO_ENTE', '2', 'C', 'SOCIO PERSONA MORAL', 'V')


insert into sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
values ('CL_SEXO', '1', 'F', 'FEMENINO', 'V')

insert into sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
values ('CL_SEXO', '2', 'M', 'MASCULINO', 'V')


insert into sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
values ('AH_TIPOCTA', '1', '16', 'SOCIO EN MATRIZ O SUCURSAL', 'V')

insert into sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
values ('AH_TIPOCTA', '3', '17', 'SOCIO A TRAVES DE COMISIONISTAS', 'V')

insert into sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
values ('AH_TIPOCTA', '4', '21', 'CUENTAS ABIERTAS EN LA SOCIEDAD', 'V')


insert into sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
values ('TIPO_MODO', '2', 'I', 'SOCIO INDIVIDUAL', 'V')

insert into sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
values ('TIPO_MODO', '3', 'O', 'SOCIO MANCOMUNADA', 'V')

go


/*************************************************************************************/
--No Historia				 : H81321
--Título de la Historia		 : Reporte Regulatorio R08
--Fecha					     : 08/18/2016
--Descripción del Problema	 : Se requiero de la generacion del reporte regulatorio R08
--Descripción de la Solución : Inclusion de campo sb_dato_cliente.dc_nit
--                             Inclusion de campo sb_dato_pasivas.dp_origen
--                             Inclusion de campo sb_dato_pasivas.dp_provisiona
--                             Inclusion de campo sb_dato_pasivas.dp_blqpignoracion
--Autor						 : Jorge Salazar Andrade
--Instalador                 : cobsup_table.sql
--Ruta Instalador            : $/COB/Test/TEST_SaaSMX/CtasCteAho/Dependencias/sql
/*************************************************************************************/
use cob_conta_super
go

if not exists(select 1 from syscolumns c, sysobjects o where c.id = o.id and o.name = 'sb_dato_cliente' and c.name = 'dc_nit')
   alter table cob_conta_super..sb_dato_cliente add dc_nit numero null

go

if not exists(select 1 from syscolumns c, sysobjects o where c.id = o.id and o.name = 'sb_dato_pasivas' and c.name = 'dp_origen')
   alter table cob_conta_super..sb_dato_pasivas add dp_origen char(3) null

go

if not exists(select 1 from syscolumns c, sysobjects o where c.id = o.id and o.name = 'sb_dato_pasivas' and c.name = 'dp_provisiona')
   alter table cob_conta_super..sb_dato_pasivas add dp_provisiona char(1) null

go

if not exists(select 1 from syscolumns c, sysobjects o where c.id = o.id and o.name = 'sb_dato_pasivas' and c.name = 'dp_blqpignoracion')
   alter table cob_conta_super..sb_dato_pasivas add dp_blqpignoracion char(1) null

go


/*************************************************************************************/
--No Historia				 : H81321
--Título de la Historia		 : Reporte Regulatorio R08
--Fecha					     : 08/18/2016
--Descripción del Problema	 : Se requiero de la generacion del reporte regulatorio R08
--Descripción de la Solución : Creacion de tabla sb_reporte_r08
--Autor						 : Jorge Salazar Andrade
--Instalador                 : reg_tabla.sql
--Ruta Instalador            : $/COB/Test/TEST_SaaSMX/RegulatoriosMX/sql
/*************************************************************************************/
use cob_conta_super
go
if exists (select 1 from sysobjects where name = 'sb_reporte_r08')
   drop table cob_conta_super..sb_reporte_r08
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
   NUMERO_CUENTA       varchar(12)     not null,
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


/*************************************************************************************/
--No Historia				 : H81321
--Título de la Historia		 : Reporte Regulatorio R08
--Fecha					     : 08/18/2016
--Descripción del Problema	 : Se requiero de la generacion del reporte regulatorio R08
--Descripción de la Solución : Creacion de parametros CLAVEN, SUBREP
--Autor						 : Jorge Salazar Andrade
--Instalador                 : reg_parametria.sql
--Ruta Instalador            : $/COB/Test/TEST_SaaSMX/RegulatoriosMX/sql
/*************************************************************************************/
use cobis
go

delete cl_parametro
 where pa_nemonico in ('CLAVEN','SUBREP')
   and pa_producto = 'REC'
go

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CLAVE DE ENTIDAD', 'CLAVEN', 'C', '123456', null, null, null, null, null, null, 'REC')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('SUBREPORTE', 'SUBREP', 'C', '841', null, null, null, null, null, null, 'REC')

go


/*************************************************************************************/
--No Historia				 : H81321
--Título de la Historia		 : Reporte Regulatorio R08
--Fecha					     : 08/18/2016
--Descripción del Problema	 : Se requiero de la generacion del reporte regulatorio R08
--Descripción de la Solución : Inclusion de campo ex_dato_cliente.dc_nit
--                             Inclusion de campo ex_dato_pasivas.dp_origen
--                             Inclusion de campo ex_dato_pasivas.dp_provisiona
--                             Inclusion de campo ex_dato_pasivas.dp_blqpignoracion
--Autor						 : Jorge Salazar Andrade
--Instalador                 : cobex_table.sql
--Ruta Instalador            : $/COB/Test/TEST_SaaSMX/CtasCteAho/Dependencias/sql
/*************************************************************************************/
use cob_externos
go

if not exists(select 1 from syscolumns c, sysobjects o where c.id = o.id and o.name = 'ex_dato_cliente' and c.name = 'dc_nit')
   alter table cob_externos..ex_dato_cliente add dc_nit numero null

go

if not exists(select 1 from syscolumns c, sysobjects o where c.id = o.id and o.name = 'ex_dato_pasivas' and c.name = 'dp_origen')
   alter table cob_externos..ex_dato_pasivas add dp_origen char(3) null

go

if not exists(select 1 from syscolumns c, sysobjects o where c.id = o.id and o.name = 'ex_dato_pasivas' and c.name = 'dp_provisiona')
   alter table cob_externos..ex_dato_pasivas add dp_provisiona char(1) null

go

if not exists(select 1 from syscolumns c, sysobjects o where c.id = o.id and o.name = 'ex_dato_pasivas' and c.name = 'dp_blqpignoracion')
   alter table cob_externos..ex_dato_pasivas add dp_blqpignoracion char(1) null

go


/*************************************************************************************/
--No Historia				 : H81321
--Título de la Historia		 : Reporte Regulatorio R08
--Fecha					     : 08/18/2016
--Descripción del Problema	 : Se requiero de la generacion del reporte regulatorio R08
--Descripción de la Solución : Modificacion en catalogos de Tipo de Cuentas de Ahorro
--Autor						 : Jorge Salazar Andrade
--Instalador                 : ah_catlgo.sql
--Ruta Instalador            : $/COB/Test/TEST_SaaSMX/CtasCteAho/Ahorros/Backend/sql
/*************************************************************************************/
use cobis
go

declare @w_codigo smallint

select @w_codigo = codigo
  from cobis..cl_tabla
 where tabla = 'ah_tipocta'

delete cobis..cl_catalogo
 where tabla = @w_codigo
   and codigo in (16,17)
   
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '16', 'SOCIO EN MATRIZ O SUCURSAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '17', 'SOCIO A TRAVES DE COMISIONISTAS', 'V')
go


/*************************************************************************************/
--No Historia				 : H81321
--Título de la Historia		 : Reporte Regulatorio R08
--Fecha					     : 08/29/2016
--Descripción del Problema	 : Se requiero de la generacion del reporte regulatorio R08
--Descripción de la Solución : Creacion de la sarta 36005: REPORTES TRIMESTRALES REC
--Autor						 : Jorge Salazar Andrade
--Instalador                 : reg_batch.sql
--Ruta Instalador            : $/COB/Test/TEST_SaaSMX/RegulatoriosMX/sql
/*************************************************************************************/
use cobis
go

declare @w_usuario       varchar(60),
        @w_servidor      varchar(100),
        @w_path_destino  varchar(100),
        @w_path_fuente   varchar(100),
        @w_producto      int,
        @w_fecha_proceso datetime

select  @w_usuario      = 'admuser',
        @w_producto     = 36

--Fecha cierre
delete cobis..ba_fecha_cierre where fc_producto = @w_producto

select @w_fecha_proceso = isnull(fp_fecha, getdate()) from ba_fecha_proceso   

insert into cobis..ba_fecha_cierre (fc_producto, fc_fecha_cierre, fc_fecha_propuesta)
values (@w_producto, @w_fecha_proceso, null)

--Path de producto
delete cobis..ba_path_pro where pp_producto = @w_producto

insert into cobis..ba_path_pro (pp_producto, pp_path_fuente, pp_path_destino)
values (@w_producto, 'C:/Cobis/vbatch/Regulatorios/objetos/', 'C:/Cobis/vbatch/Regulatorios/listados/')

select @w_servidor = pa_char
  from cobis..cl_parametro
 where pa_producto = 'ADM'
   and pa_nemonico = 'SRVR'

select @w_path_destino = pp_path_destino
  from ba_path_pro
 where pp_producto = @w_producto

select @w_path_destino = isnull(@w_path_destino, 'C:/Cobis/vbatch/Regulatorios/objetos/')

select @w_path_fuente = pp_path_fuente
  from ba_path_pro
 where pp_producto = @w_producto

select @w_path_fuente = isnull(@w_path_fuente, 'C:/Cobis/vbatch/Regulatorios/listados/')

--Sarta 36005
delete from ba_sarta where sa_sarta = 36005

insert into cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
values (36005, 'REPORTES TRIMESTRALES REC', 'REPORTES TRIMESTRALES REC', getdate(), @w_usuario, @w_producto, null, null)

--Batch 36001

delete from ba_batch where ba_batch in (36001)

insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (36001, 'REPORTE REGULATORIO R08 CAPTACION SOCAP', 'REPORTE REGULATORIO R08 CAPTACION SOCAP', 'SP', getdate(), @w_producto, 'P', 1, null, null, 'cob_conta_super..sp_reporte_r08', 10000, null, @w_servidor, 'S', @w_path_fuente, @w_path_destino)

--ba_sarta_batch 36005, 36001

delete ba_sarta_batch where sb_sarta = 36005

insert into cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
values (36005, 36001, 1, null, 'S', 'N', 510, 645, 36005, 'S')
go

--ba_enlace
DELETE FROM ba_enlace WHERE en_sarta = 36005

INSERT INTO cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (36005, 36001, 1, 0, 0, 'S', NULL, 'N')
GO

--ba_parametro 36005, 36001
delete from ba_parametro where pa_batch in (36001)

insert into cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
values (0, 36001, 0, 1, 'FECHA PROCESO', 'D', '08/09/2016')
go

insert into cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
values (0, 36001, 0, 2, 'PERIODICIDAD', 'I', '1')
go

insert into cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
values (36005, 36001, 1, 1, 'FECHA PROCESO', 'D', '08/09/2016')
go

insert into cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
values (36005, 36001, 1, 2, 'PERIODICIDAD', 'I', '1')
go


/*************************************************************************************/
--No Historia				 : H81321
--Título de la Historia		 : Reporte Regulatorio R08
--Fecha					     : 08/18/2016
--Descripción del Problema	 : Se requiero de la generacion del reporte regulatorio R08
--Descripción de la Solución : Modificacion de tipo de dato campo cl_direccion.di_parroquia
--Autor						 : Jorge Salazar Andrade
--Instalador                 : cl_table.sql
--Ruta Instalador            : $/COB/Test/TEST_SaaSMX/Clientes/Backend/sql
/*************************************************************************************/
use cobis
go

drop index cl_direccion.cl_direccion_key3
drop index cl_direccion.i_d_parroquia

alter table cobis..cl_direccion
alter column di_parroquia int not null

create nonclustered index cl_direccion_key3 
    on cl_direccion (di_tipo,di_ciudad,di_parroquia,di_oficina)

create nonclustered index i_d_parroquia 
    on cl_direccion (di_ciudad,di_parroquia)
go

