/******************************************************/
--Fecha Creación del Script: 2016/08/04               */
--Desarrollo Asociacion de Contartos                 */
--Modulo : PERSON                                    */
--Creado por : Javier Calderopn Vera                  */
/******************************************************/

use cob_remesas
go

-- pe_table   validado jca

print 'Creacion de tabla ==> re_contrato_producto'

if exists (select 1 from sysobjects where id = object_id('re_contrato_producto'))
begin
    drop table cob_remesas..re_contrato_producto
end
go



create table cob_remesas..re_contrato_producto
(
    cp_producto           tinyint       null,
    cp_prod_banc           smallint     not null,
    cp_tipo_persona     char(1)       null,
    cp_titularidad      char(1)       null,
    cp_estado           char(1)       not null,
    cp_plantilla          varchar(20) not null,
    cp_descripcion         varchar(60) not null,
    cp_es_especial      char(2)     null

)
go

--pe_trser.sql  validado jca

if not exists (select 1 from sysobjects where id = object_id('pe_tran_servicio'))
begin
   
    CREATE TABLE dbo.pe_tran_servicio
    (
    ts_secuencial       INT NOT NULL,
    ts_tipo_transaccion SMALLINT NOT NULL,
    ts_oficina          SMALLINT NULL,
    ts_usuario          VARCHAR (64) COLLATE Latin1_General_BIN NULL,
    ts_terminal         VARCHAR (64) COLLATE Latin1_General_BIN NULL,
    ts_reentry          CHAR (1) COLLATE Latin1_General_BIN NULL,
    ts_cod_alterno      INT NULL,
    ts_servicio_per     SMALLINT NULL,
    ts_categoria        VARCHAR (10) COLLATE Latin1_General_BIN NULL,
    ts_tipo_rango       TINYINT NULL,
    ts_grupo_rango      SMALLINT NULL,
    ts_rango            TINYINT NULL,
    ts_operacion        CHAR (1) COLLATE Latin1_General_BIN NULL,
    ts_tipo             CHAR (1) COLLATE Latin1_General_BIN NULL,
    ts_minimo           REAL NULL,
    ts_maximo           REAL NULL,
    ts_val_medio        REAL NULL,
    ts_en_linea         CHAR (1) COLLATE Latin1_General_BIN NULL,
    ts_tipo_default     CHAR (1) COLLATE Latin1_General_BIN NULL,
    ts_rol              CHAR (1) COLLATE Latin1_General_BIN NULL,
    ts_producto         TINYINT NULL,
    ts_codigo           INT NULL,
    ts_valor_con        REAL NULL,
    ts_tipo_variacion   CHAR (1) COLLATE Latin1_General_BIN NULL,
    ts_cuenta           VARCHAR (24) COLLATE Latin1_General_BIN NULL,
    ts_fecha_cambio     SMALLDATETIME NULL,
    ts_fecha_vigencia   SMALLDATETIME NULL,
    ts_fecha            SMALLDATETIME NULL,
    ts_pro_final        SMALLINT NULL,
    ts_servicio_dis     SMALLINT NULL,
    ts_rubro            VARCHAR (10) COLLATE Latin1_General_BIN NULL,
    ts_hora             DATETIME NULL,
    ts_especie          VARCHAR (64) COLLATE Latin1_General_BIN NULL,
    ts_origen           VARCHAR (64) COLLATE Latin1_General_BIN NULL,
    ts_valor_chq        MONEY NULL,
    ts_valor_chq_otra   MONEY NULL,
    ts_valor_efe        MONEY NULL,
    ts_valor_efe_otra   MONEY NULL,
    ts_plantilla        VARCHAR (20) COLLATE Latin1_General_BIN NULL,
    ts_prod_banc        SMALLINT NULL,
    ts_estado           CHAR (1) COLLATE Latin1_General_BIN NULL,
    ts_descripcion      VARCHAR (64) COLLATE Latin1_General_BIN NULL,
    ts_posteo           CHAR (1) COLLATE Latin1_General_BIN NULL
    )


end

print 'Alter tabla transaccion de servicio ==> cob_remesas..pe_tran_servicio'


if NOT exists(select 1 from INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pe_tran_servicio' 
                                          AND COLUMN_NAME = 'ts_plantilla') 
BEGIN
      ALTER TABLE cob_remesas..pe_tran_servicio
              add ts_plantilla        varchar(20)  null
          
end  
go



if NOT exists(select 1 from INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pe_tran_servicio' 
                                          AND COLUMN_NAME = 'ts_prod_banc') 
BEGIN
      ALTER TABLE cob_remesas..pe_tran_servicio
              add ts_prod_banc        smallint     null
          
end  
GO


if NOT exists(select 1 from INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pe_tran_servicio' 
                                          AND COLUMN_NAME = 'ts_descripcion') 
BEGIN
      ALTER TABLE cob_remesas..pe_tran_servicio
              add ts_descripcion       varchar(64)  NULL
          
end  
GO


if NOT exists(select 1 from INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pe_tran_servicio' 
                                          AND COLUMN_NAME = 'ts_posteo') 
BEGIN
      ALTER TABLE cob_remesas..pe_tran_servicio
              add ts_posteo           char(1)      null
          
end  
GO


if NOT exists(select 1 from INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pe_tran_servicio' 
                                          AND COLUMN_NAME = 'ts_estado') 
BEGIN
      ALTER TABLE cob_remesas..pe_tran_servicio
              add ts_estado           char(1)      null
          
end  
GO


print 'Creacion de la vista ==> pe_ts_contrato_producto'

if exists(select * from sysobjects where name = 'pe_ts_contrato_producto')   
            DROP VIEW   pe_ts_contrato_producto
go

create view pe_ts_contrato_producto (
        fecha, secuencial, tipo_transaccion,oficina,usuario,
        terminal, reentry,operacion, tipo_variacion,producto,
        prod_banc, tipo_persona, titularidad, estado, plantilla, descripcion,hora, es_especial)
as
select 
        ts_fecha,ts_secuencial, ts_tipo_transaccion,ts_oficina, ts_usuario, 
        ts_terminal, ts_reentry,ts_operacion,ts_tipo_variacion,ts_producto,
        ts_prod_banc, ts_tipo, ts_posteo, ts_estado, ts_plantilla, ts_descripcion,ts_hora, ts_rubro
from pe_tran_servicio
where ts_tipo_transaccion = 2946
   
go


use cobis
go

--pe_trser.sql

print 'Insert ==>  cobis..ad_vistas_trnser'

delete from cobis..ad_vistas_trnser
where vt_producto = 17
and vt_base_datos = 'cob_remesas'
and vt_tabla      = 'pe_ts_contrato_producto'

insert into ad_vistas_trnser values (17,'cob_remesas','pe_ts_contrato_producto','MANTENIMIENTO DE ASOCIACIÓN DE CONTRATOS','V','fecha','secuencial','tipo_variacion','N','P','A','B','usuario','terminal',null,'moneda',null)               

/*************/
/*  catalogos */
/*************/

--pe_catlgo.sql  validado jca

delete cl_catalogo_pro
  from cl_tabla
 where tabla in ('cl_est_plantillas_contratos','re_plantillas')
   and codigo = cp_tabla

go

delete cl_catalogo
  from cl_tabla
 where cl_tabla.tabla in ('cl_est_plantillas_contratos','re_plantillas') 
   and cl_tabla.codigo = cl_catalogo.tabla

go

delete cl_tabla
 where cl_tabla.tabla in ('cl_est_plantillas_contratos','re_plantillas')
go


declare @w_codigo smallint
select @w_codigo = max(codigo) + 1
from cl_tabla

print 'cl_est_plantillas_contratos'


insert into cobis..cl_tabla values(@w_codigo,'cl_est_plantillas_contratos','Estados de Plantillas de Contratos')
insert into cobis..cl_catalogo(tabla,codigo,valor,estado)  values(@w_codigo,'V','VIGENTE','V')
insert into cobis..cl_catalogo(tabla,codigo,valor,estado) values(@w_codigo,'I','INACTIVO','V')
insert into cobis..cl_catalogo_pro values('AHO',@w_codigo)
go



declare @w_codigo smallint
select @w_codigo = max(codigo) + 1
from cl_tabla

print 're_plantillas'

insert into cobis..cl_tabla values(@w_codigo,'re_plantillas','Plantillas de Contratos')

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_codigo, 'AHORRO.RPT', 'CONTRATO AHORROS - PER NAT', 'V',NULL,NULL,NULL)
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_codigo, 'AH_AAP.RPT', 'CONTRATO AHO APORTE ADI - PER NAT', 'V',NULL,NULL,NULL)
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_codigo, 'AH_ASC.RPT', 'CONTRATO AHO APORTE SOC - PER JUR', 'V',NULL,NULL,NULL)
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_codigo, 'AH_ASP.RPT', 'CONTRATO AHO APORTE SOC - PER NAT', 'V',NULL,NULL,NULL)
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_codigo, 'AH_PRO.RPT', 'CONTRATO AHORRO PRO - PERS NATL', 'V',NULL,NULL,NULL)
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) VALUES (@w_codigo, 'CNTAHO.RPT', 'CONTRATO AHO PERSONA NATURAL - CUENTA PRUEBA', 'V',NULL,NULL,NULL)
insert into cobis..cl_catalogo_pro(cp_producto, cp_tabla) values('REM',@w_codigo)


update cobis..cl_seqnos
set siguiente = @w_codigo
where tabla = 'cl_tabla'
go
 
/*********************************************/
/*   CReacion de Opción del Menú             */
/*********************************************/

--menu-person-conrol.sql  validado jca

USE cobis
GO

-- Registros para: PP.PER.FTra2946  
print ' CReacion de Opción del Menú --> Asociacion de Contarto' 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
print 'Registros para: PP.PER.FTra2946'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FTra2946') 
begin                                                                                                                                                                                                                                                                                                                                                                                                                                       
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'  
select @w_la_cod = 'ES_EC'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label   
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Asociación de contratos a productos bancarios', 'M-PER')                                                                                                                                                                                                                                                                                                                                                                                                                                           
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page 
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Productos1'                                                                                                                                                                                                                                                                                                                                                                                                                                               
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.PER.FTra2946', 'icono pagina', @w_pa_id_parent, 10, 'horizontal', 'Nemonic', 'M-PER', '', null)                                                                                                                                                                                                                                                                                                                                                                    
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
if not exists (select * from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end                                                                                                                                                                                                                                                                                                                                                                                                    
if not exists (select * from cobis..an_module_group where mg_name = 'PER.Products') begin                                                                                                                                                                                                                                                                                                                                                                                                                                        
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'PER.Products', '4.0.0.1', 'http://[servername]/PER.Products.Installer/PER.Products.Installer.application', 'COBISExplorer')                                                                                                                                                                                                                                                                                                                                               
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Products'                                                                                                                                                                                                                                                                                                                                                                                                                                      
if not exists (select * from cobis..an_module where mo_name = 'PER.Products') begin                                                                                                                                                                                                                                                                                                                                                                                                                                              
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Products', 'COBISCorp.tCOBIS.PER.Products.dll', 0, null)                                                                                                                                                                                                                                                                                                                                                                                                 
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Products'                                                                                                                                                                                                                                                                                                                                                                                                                                            
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)                                                                                                                                                                                                                                                                                                                                                                    
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'PER.FTra2946', 'FTra2946Class', 'COBISCorp.tCOBIS.PER.Products', 'SV', '', 'M-PER')                                                                                                                                                                                                                                                                                                                                                                                 
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
if not exists (select 1 from cobis..an_label where la_label = 'Asociación de contratos a productos bancarios') begin                                                                                                                                                                                                                                                                                                                                                                                                                                       
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Asociación de contratos a productos bancarios', 'M-PER')                                                                                                                                                                                                                                                                                                                                                                                                                                           
end                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
else select @w_la_id = la_id from cobis..an_label where la_label = 'Asociación de contratos a productos bancarios'                                                                                                                                                                                                                                                                                                                                                                                                                                         
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
if @w_pz_id is null select @w_pz_id = 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin                                                                                                                                                                                                                                                                                                                                                                                                                        
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)                                                                                                                                                                                                                                                                                                                                                                                                  
end                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
end                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
go                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               


-- pe_proc.sql validado jca

if exists (SELECT * FROM cobis..ad_procedure WHERE pd_procedure = 2940)
begin
       DELETE FROM ad_procedure WHERE pd_procedure = 2940
end
go

insert into cobis..ad_procedure values(2940,'sp_contrato_producto','cob_remesas','V',getdate(),'contra_prod.sp')
GO

--pe_tran.sql validado jca

if exists (SELECT * FROM cobis..cl_ttransaccion WHERE tn_trn_code = 2946)
begin
       delete FROM cobis..cl_ttransaccion WHERE tn_trn_code = 2946
end
go


INSERT INTO cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (2946, 'ASIOCIACION DE CONTRATO A PRODUCTO BANC', 'ACPB', 'ASIOCIACION DE CONTRATO A PRODUCTO BANCARIO')
GO

--pe_protran.sql validado jca

if exists (SELECT * FROM cobis..ad_pro_transaccion WHERE pt_producto = 17 and pt_transaccion = 2946 )
begin
delete from cobis..ad_pro_transaccion WHERE pt_producto = 17 and pt_transaccion = 2946
end
go

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (17, 'R', 0, 2946, 'V', getdate(), 2940, NULL)
GO


--pe_traut.sql validado jca

if exists (SELECT * FROM cobis..ad_tr_autorizada WHERE ta_transaccion = 2946)
begin
    DELETE FROM cobis..ad_tr_autorizada WHERE ta_transaccion = 2946
end
go

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (17, 'R', 0, 2946, 3, getdate(), 1, 'V', getdate())
GO



