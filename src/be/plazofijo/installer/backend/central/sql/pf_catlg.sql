/************************************************************************/
/*                 Descripcion                                          */
/*  Script para crear los catalogos necesarios para el modulo           */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor              Comentario                         */
/*                N. Silva           Adaptación DAVIVIENDA/COL          */
/************************************************************************/
use cobis
go

set nocount on
go

print '**********************************'
print '***** CREACION DE CATALOGOS  *****'
print '**********************************'

/************************************************************************/
/*                      cl_tabla                                        */
/************************************************************************/
go

delete cl_catalogo 
where tabla in (select codigo
                from cl_tabla
                where tabla like 'pf_%')
go

delete cl_tabla
where tabla like 'pf_%'
go

delete cl_catalogo_pro
where cp_producto like 'PFI'
go

print 'pf_nivel'
go
declare  @w_tabla    int
select @w_tabla = isnull(max(codigo), 0) + 1 
from cl_tabla 

insert into cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'pf_nivel', 'Nivel de la consulta')

insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'C', 'NIVEL DE CIUDAD', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'F', 'NIVEL DE FUNCIONARIO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'O', 'NIVEL DE OFICINA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'T', 'NIVEL GENERAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'R', 'NIVEL TERRITORIAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'Z', 'NIVEL ZONAL', 'V')
go


print 'pf_accion_sgte'
go
declare  @w_tabla    int
select @w_tabla = isnull(max(codigo), 0) + 1 
from cl_tabla 

insert into cl_tabla (codigo, tabla, descripcion)
values (@w_tabla , 'pf_accion_sgte', 'Acciones siguientes')

insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'XREN', 'POR RENOVAR', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'XCAN', 'POR CANCELAR', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'NULL', 'NINGUNA', 'V')
go

print 'pf_plazo_contable'
go

declare @w_tabla int
select  @w_tabla = isnull(max(codigo), 0) + 1
from  cl_tabla
 
insert into cl_tabla values(@w_tabla,'pf_plazo_contable','Plazos para contabilizacion')
 
insert into cl_catalogo (tabla, codigo, valor, estado)
values(@w_tabla,'P1' ,'DE 30  A 60   DIAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values(@w_tabla,'P2' ,'DE 61  A 90   DIAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values(@w_tabla,'P3','DE 91  A 120  DIAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values(@w_tabla,'P4','DE 121 A 150  DIAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values(@w_tabla,'P5','DE 151 A 180  DIAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values(@w_tabla,'P6','DE 181 A 270 DIAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values(@w_tabla,'P7','DE 271 A 360 DIAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values(@w_tabla,'P8','DE 361 A 540 DIAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values(@w_tabla,'P9','DE 541 A 720 DIAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values(@w_tabla,'P10','DE 721 A 1080 DIAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values(@w_tabla,'P11','MAYOR E IGUAL A 1081 DIAS','V')
go

print 'pf_basecc'
go
declare @w_tabla    int
select @w_tabla = isnull(max(codigo), 0) + 1 
from cl_tabla 

insert into cl_tabla (codigo, tabla, descripcion)
values (@w_tabla , 'pf_basecc', 'Base de calculo')

insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '360', '360 DIAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '365', '365 DIAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '366', '366 DIAS AÑOS BISIESTOS', 'V')
go

print 'pf_banco'
go
declare @w_tabla   int
select @w_tabla = isnull(max(codigo), 0) + 1
  from cl_tabla
insert into cl_tabla (codigo, tabla, descripcion)
values (@w_tabla , 'pf_banco', 'Bancos para cheques') 

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '0' , 'BANCO DE LA REPUBLICA'        , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1' , 'BANCO DE BOGOTA'              , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10', 'HSBC COLOMBIA S.A.'           , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12', 'BANCO SUDAMERIS COLOMBIA'     , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '13', 'BANCO BBVA COLOMBIA'          , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14', 'HELM BANK S.A.'               , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19', 'BANCO COLPATRIA'              , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2' , 'BANCO POPULAR'                , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '22', 'BANCO UNION COLOMBIANO'       , 'B')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23', 'BANCO DE OCCIDENTE'           , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24', 'BANCO STANDARD CHARTERED'     , 'B')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26', 'BANK OF AMERICA COLOMBIA'     , 'B')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '29', 'BANCO TEQUENDAMA'             , 'B')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '31', 'BANCOLDEX'                    , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '32', 'BANCO CAJA SOCIAL'            , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '34', 'BANCO SUPERIOR'               , 'B')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '36', 'MEGABANCO'                    , 'B')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '37', 'BANK BOSTON'                  , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '40', 'BANCO AGRARIO DE COLOMBIA'    , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '48', 'BANCO ALIADAS S.A.'           , 'B')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5' , 'BANCAFE'                      , 'B')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '50', 'GRANBANCO S.A'                , 'B')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '51', 'BANCO DAVIVIENDA'             , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '52', 'AV. VILLAS'                   , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '54', 'BANCO GRANAHORRAR'            , 'B')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '55', 'CONAVI'                       , 'B')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '57', 'COLMENA'                      , 'B')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '58', 'BANCO PROCREDIT COLOMBIA S.A.', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '59', 'BANCAMIA'                     , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6' , 'BANCO SANTANDER'              , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '60', 'BANCO PICHINCHA'              , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '61', 'BANCOOMEVA'                   , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '62', 'BANCO FALABELLA'              , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '63', 'BANCO FINANDINA S.A.'         , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7' , 'BANCOLOMBIA'                  , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8' , 'SCOTIABANK COLOMBIA'          , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9' , 'CITIBANK COLOMBIA'            , 'V')

print 'pf_causa_mod'
go

declare @w_tabla int
select @w_tabla = isnull(max(codigo), 0) + 1
from cl_tabla

insert into cl_tabla (codigo, tabla, descripcion)
values (@w_tabla , 'pf_causa_mod', 'Causa de la modificacion')

insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'CACT', 'CONFIRMACION DE ACTIVACION','V')
go

print 'pf_forma_pago'
go
declare @w_tabla    int
select  @w_tabla = isnull(max(codigo), 0) + 1
from  cl_tabla

insert into cl_tabla (codigo, tabla, descripcion)
values (@w_tabla , 'pf_forma_pago', 'Forma de Pago')

insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'PER', 'PERIODICA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'VEN', 'VENCIMIENTO', 'V')
go


print 'pf_tipo_aut'
go
declare @w_tabla    int
select @w_tabla = isnull(max(codigo), 0) + 1
from cl_tabla

insert into cl_tabla (codigo, tabla, descripcion) 
values (@w_tabla , 'pf_tipo_aut', 'Tipo de Autorizacion')

insert into cl_catalogo (tabla, codigo, valor, estado)
values(@w_tabla,'APRO','APROBACION DE DEPOSITOS PARA ACTIVACION','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values(@w_tabla,'ASP','AUTORIZACION DE SPREAD TASA FIJA','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values(@w_tabla,'CIERRE', 'CIERRE PLAZO FIJO','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values(@w_tabla,'FCIERRE', 'FORZAR CIERRE PLAZO FIJO','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values(@w_tabla,'LCIERRE', 'LEVANTAMIENTO CIERRE PLAZO FIJO','V')
go

print 'pf_categoria'
go
declare    @w_tabla    int
select @w_tabla = isnull(max(codigo), 0) + 1 
from cl_tabla

insert into cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'pf_categoria', 'Categoria de Deposito')

insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'NOM', 'NOMINATIVO', 'V')
go

print 'pf_estado'
declare @w_tabla    int
select @w_tabla = isnull(max(codigo), 0) + 1
from cl_tabla

insert into cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'pf_estado', 'Estados de un Deposito')

insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'ING', 'INGRESADO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'ACT', 'ACTIVO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'XACT', 'POR ACTIVAR', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'CAN', 'CANCELADO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'VEN', 'VENCIDO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'ANU', 'ANULADO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'REN', 'RENOVADO', 'E')
go

print 'pf_motivo_pig'
go
declare @w_tabla    int
select @w_tabla = isnull(max(codigo), 0) + 1
from cl_tabla

insert into cl_tabla (codigo, tabla, descripcion)
values(@w_tabla,'pf_motivo_pig','Motivos de pignoracion')

insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'CCRE','CARTAS DE CREDITO','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'GAR','GARANTIAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'GARBAN','GARANTIAS BANCARIAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'LEAS','LEASING','V') 
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'TC','TARJETA DE CREDITO','V') 
go

 
print 'pf_motivo_ret'
go
declare @w_tabla    int
select @w_tabla = isnull(max(codigo), 0) + 1
from cl_tabla
 
insert into cl_tabla (codigo, tabla, descripcion)
values(@w_tabla,'pf_motivo_ret','Motivo de Bloqueo')
 
insert into cl_catalogo (tabla, codigo, valor, estado)
values(@w_tabla,'INOP', 'INSTRUCCION OPERATIVA','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values(@w_tabla,'PER', 'PERDIDA','V')    
insert into cl_catalogo (tabla, codigo, valor, estado)
values(@w_tabla,'ROBOHUR', 'ROBO O HURTO','V') 
go


print 'pf_cat_pago_recep'
go
declare @w_tabla int
select  @w_tabla = isnull(max(codigo), 0)  + 1
        from cl_tabla

insert into cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'pf_cat_pago_recep', 'Tipo de Transaccion Monetaria')

insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'P','PAGO','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'R','RECEPCION','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'A','PAGO O RECEPCION','V')
go

print 'pf_tipo_persona'
go
declare    @w_tabla    int
select @w_tabla = isnull(max(codigo), 0) + 1 
from cl_tabla 

insert into cl_tabla (codigo, tabla, descripcion)
values (@w_tabla , 'pf_tipo_persona', 'Tipo de Persona')

insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'N','NATURAL','V') 
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'J','JURIDICA','V')
go


print 'pf_otros_prod_bancarios'
go
declare    @w_tabla    int
select @w_tabla = isnull(max(codigo), 0) + 1 
from cl_tabla

insert into cl_tabla (codigo, tabla, descripcion)
values (@w_tabla , 'pf_otros_prod_bancarios', 'Otros Productos Bancarios') 

insert into cl_catalogo (tabla, codigo, valor, estado) 
values(@w_tabla,'AHO','CUENTA DE AHORROS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) 
values(@w_tabla,'BTLF','BANCA POR TELEFONO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) 
values(@w_tabla,'CTE','CUENTA CORRIENTE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) 
values(@w_tabla,'FACT','FACTORING','V')
insert into cl_catalogo (tabla, codigo, valor, estado) 
values(@w_tabla,'CNET','COBIS NET','V')
insert into cl_catalogo (tabla, codigo, valor, estado) 
values(@w_tabla,'INVE','INVERSIONES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) 
values(@w_tabla,'LEAS','LEASING','V')
insert into cl_catalogo (tabla, codigo, valor, estado) 
values(@w_tabla,'PTMO','PRESTAMOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) 
values(@w_tabla,'TCLV','TARJETA CLAVE','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values(@w_tabla,'TCRE','TARJETA DE CREDITO','V')
go

print 'pf_producto_custodia'
go
declare    @w_tabla    int
select @w_tabla = isnull(max(codigo), 0) + 1 
from cl_tabla 

insert into cl_tabla (codigo, tabla, descripcion)
values (@w_tabla , 'pf_producto_custodia', 'Productos que se garantizan a traves de un DPF')

insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'CTE', 'CUENTA CORRIENTE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'OTR', 'OTROS PRODUCTOS BANCARIOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'CEX', 'COMERCIO EXTERIOR', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'TC', 'TARJETA DE CREDITO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'GAR','GARANTIAS','V') 
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'PFI','DEPOSITOS A PLAZO FIJO','V') 
go

print 'pf_causa_dep'
declare    @w_tabla    int
select  @w_tabla = isnull(max(codigo), 0) + 1
from cl_tabla

insert into cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'pf_causa_dep', 'Causa de apertura por caja')

insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '1', 'APERTURA DE DEPOSITO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '2', 'INCREMENTO RENOVACION', 'V')
go

print 'pf_trx_no_estadistica'
declare    @w_tabla    int
select  @w_tabla = isnull(max(codigo), 0) + 1
from cl_tabla

insert into cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'pf_trx_no_estadistica', 'Transaccion No Utilizada en la Estadistica')

insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '14231', 'ACTUALIZACION DE EMISION DE CHEQUE'       , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '14759', 'ORDEN DE PAGO POR PLATAFORMA - FRONT END' , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '14901', 'APERTURA DPF'                             , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '14908', 'ANULACION DE LA OPERACION'                , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '14914', 'ACTIVACION DE OPERACION'                  , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '14916', 'MODIFICACION DE DEPOSITOS'                , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '14924', 'CONFIRMACION DE DEPOSITO POR ACTIVAR'     , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '14948', 'CALCULO DE TASA VARIABLE'                 , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '14984', 'ACTUALIZACION POR APROBACION OPERACION'   , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '14995', 'INCREMENTO DPF'                           , 'V')
go

print 'pf_fpagcob_ImpEmerEco'
declare    @w_tabla    int
select  @w_tabla = isnull(max(codigo), 0) + 1
from cl_tabla

insert into cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'pf_fpagcob_ImpEmerEco', 'Medios de Pago\Cobro Impuesto Emergencia Economica')

insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'AHO'   , 'CUENTA DE AHORRO'          , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'CHC'   , 'CHEQUE COMERCIAL'          , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'CHG'   , 'CHEQUE DE GERENCIA'        , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'CTE'   , 'CUENTA CORIENTE'           , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'EFEC'  , 'EFECTIVO'                  , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'RENINC', 'INCREMENTO DE RENOVACION'  , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'SEBRA' , 'SEBRA'                     , 'V')
go

print 'pf_tipo_banca'
declare    @w_tabla    int
select  @w_tabla = isnull(max(codigo), 0) + 1
from cl_tabla

insert into cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'pf_tipo_banca', 'Tipo de Banca')

insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'COM',  'COMERCIAL'        , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'COR',  'CORPORATIVO'      , 'V')
go

print 'pf_causa_can'
declare @w_tabla    int
select @w_tabla = isnull(max(codigo), 0) + 1
from cl_tabla

insert into cobis..cl_tabla
values (@w_tabla,'pf_causa_can','Causales de transaccion cancelacion/pago')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'1','CANCELACION CAPITAL','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'2','CANCELACION INTERES','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'3','CANCELACION DECREMENTO DE RENOVACION','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'4','CANCELACION POR CHEQUE DEVUELTO','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'5','ENAJENACION (DEVOLUCION DE RETENCION)','V')
go

print 'pf_bloqueo'
declare @w_tabla    int
select @w_tabla = isnull(max(codigo), 0) + 1
from cl_tabla

insert into cobis..cl_tabla
values (@w_tabla,'pf_bloqueo','Valores a Bloquear')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'CAP', 'BLOQUEO CAPITAL'           , 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'CIN', 'BLOQUEO CAPITAL E INTERES' , 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'INT', 'INTERES'                   , 'V')
go

print 'pf_tipo_trn'
declare @w_tabla    int
select @w_tabla = isnull(max(codigo), 0) + 1
from cl_tabla

insert into cobis..cl_tabla
values (@w_tabla,'pf_tipo_trn','Tipos de Transaccion')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'APE', 'APERTURA'                , 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'CAN', 'CANCELACION'             , 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'CAU', 'CAUSACION'               , 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'END', 'ENDOSO'                  , 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'ENJ', 'ENAJENACION'             , 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'EOP', 'EJECUCION ORDEN DE PAGO' , 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'REN', 'RENOVACION'              , 'V')
go

print 'pf_tipo_ente'
declare @w_tabla    int
select @w_tabla = isnull(max(codigo), 0) + 1
from cl_tabla

insert into cobis..cl_tabla
values (@w_tabla,'pf_tipo_ente', 'Tipos de ente')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'PA', 'PARTICULAR', 'V')
go

print 'pf_dias'
declare @w_tabla    int
select @w_tabla = isnull(max(codigo), 0) + 1
from cl_tabla

insert into cobis..cl_tabla
values (@w_tabla,'pf_dias', 'Dias de la Semana')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '1', 'DOMINGO'  , 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '2', 'LUNES'    , 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '3', 'MARTES'   , 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '4', 'MIERCOLES', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '5', 'JUEVES'   , 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '6', 'VIERNES'  , 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '7', 'SABADO'   , 'V')
go

print 'pf_tasa_dia_ant'
declare @w_tabla    int
select @w_tabla = isnull(max(codigo), 0) + 1
from cl_tabla

insert into cobis..cl_tabla
values (@w_tabla,'pf_tasa_dia_ant', 'Tasas Ref Opera con dia anterior')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'COMGARPTUM', 'COMGARPTUM'                 , 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'COMGARTUM' , 'COMGARTUM'                  , 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'IBR'       , 'INDICE BANCARIO REFERENCIA' , 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'IVACOMGART', 'IVACOMGART'                 , 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'IVACOMPTUM', 'IVACOMPTUM'                 , 'V')
go

print 'pf_rangos_reporte_vencimientos'
declare @w_tabla    int
select @w_tabla = isnull(max(codigo), 0) + 1
from cl_tabla

insert into cobis..cl_tabla
values (@w_tabla,'pf_rangos_reporte_vencimientos', 'Rangos para reporte de DPF Vencimientos')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '1', '0'      , 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '2', '50000'  , 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '3', '50001'  , 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '4', '500000' , 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '5', '500001' , 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '6', '5000000', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '7', '5000001', 'V')
go

print 'pf_mot_des_msv'
declare @w_tabla    int
select @w_tabla = isnull(max(codigo), 0) + 1
from cl_tabla

insert into cobis..cl_tabla
values (@w_tabla,'pf_mot_des_msv', 'Motivo Desbloqueo masivo')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'INOP', 'INSTRUCCION OPERATIVA', 'V')
go

print 'pf_origen_fondos'
go
declare    @w_tabla    int
select @w_tabla = isnull(max(codigo), 0) + 1 
from cl_tabla
insert into cl_tabla (codigo, tabla, descripcion)
values (@w_tabla , 'pf_origen_fondos', 'Origen de Fondos')

insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'AHO','AHORROS','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'HER','HERENCIA','V')
go


print 'pf_prop_cuenta'
go
declare    @w_tabla    int
select @w_tabla = isnull(max(codigo), 0) + 1 
from cl_tabla
insert into cl_tabla (codigo, tabla, descripcion)
values (@w_tabla , 'pf_prop_cuenta', 'Uso de la Cuenta')

insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'AHO','AHORROS','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'INV','INVERSION','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'GAR','GARANTIA DE CREDITO','V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'OTR','OTRO','V')
go

print 'pf_transer_reporte'
go

declare @w_tabla    int
select @w_tabla = isnull(max(codigo),0) + 1
from  cl_tabla

insert into cl_tabla (codigo, tabla, descripcion)
values (@w_tabla , 'pf_transer_reporte', 'Reporte de Transacciones de Servicio')

insert into cl_catalogo (tabla, codigo, valor, estado)
select @w_tabla, rtrim(convert(varchar(10),tn_trn_code)),tn_descripcion, 'V'
from cobis..cl_ttransaccion
where tn_trn_code in (14109,14132,14134,14234,14334,14901,14905,14914,14984,
                      14112,14121,14212,14214,14221,14232,14312,14314,14321,14330)
go

print 'pf_ivc'
go

declare @w_tabla    int
select @w_tabla = isnull(max(codigo),0) + 1
from  cl_tabla

insert into cl_tabla (codigo, tabla, descripcion)
values (@w_tabla , 'pf_ivc', 'Indice de Venta Cruzada')

insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'1', 'ROJO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'2', 'AMARILLO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'3', 'NARANJA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'4', 'NEGRO', 'V')
go

print 'pf_momento'
go

declare @w_tabla    int
select @w_tabla = isnull(max(codigo),0) + 1
from  cl_tabla

insert into cl_tabla (codigo, tabla, descripcion)
values (@w_tabla , 'pf_momento', 'Momento')

insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'N', 'NUEVO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'R', 'RENOVACION', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla,'P', 'PRORROGA', 'V')
go

print 'pf_segmento'
go

declare @w_tabla int
select  @w_tabla = isnull(max(codigo),0) + 1
from    cl_tabla

insert into cl_tabla (codigo, tabla, descripcion)
values (@w_tabla , 'pf_segmento', 'Tipo de Segmento')

insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '01', 'FORMACION'    , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '02', 'CONSOLIDACION', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '03', 'EXPANSION'    , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '04', 'ASOCIATIVO'   , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '05', 'POR DEFINIR'  , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '06', 'INCLUSION'    , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '07', 'CONSUMO'      , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '08', 'HIPOTECARIO'  , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '09', 'PE-RURAL'     , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '10', 'AGRICOLA'     , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '11', 'PECUARIO'     , 'V')
go

print 'pf_segmento'
go

declare @w_tabla int
select  @w_tabla = isnull(max(codigo),0) + 1
from    cl_tabla

insert into cl_tabla (codigo, tabla, descripcion)
values (@w_tabla , 'pf_segmento', 'Tipo de Segmento')

insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '01', 'FORMACION'    , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '02', 'CONSOLIDACION', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '03', 'EXPANSION'    , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '04', 'ASOCIATIVO'   , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '05', 'POR DEFINIR'  , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '06', 'INCLUSION'    , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '07', 'CONSUMO'      , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '08', 'HIPOTECARIO'  , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '09', 'PE-RURAL'     , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '10', 'AGRICOLA'     , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, '11', 'PECUARIO'     , 'V')
go

print 'pf_carga_archivo_tasas'
go

declare @w_tabla int
select  @w_tabla = isnull(max(codigo),0) + 1
from    cl_tabla

insert into cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'pf_carga_archivo_tasas', 'Estado Carga Archivo Tasas')

insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'A', 'APROBADO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'C', 'CANCELADO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'E', 'ERROR EN INFORMACION', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'I', 'INGRESADO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'P', 'PROCESADO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'R', 'RECHAZADO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'V', 'VALIDADO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
values (@w_tabla, 'X', 'ERROR EN ESTRUCTURA' , 'V')
go

declare @w_tabla    int
select  @w_tabla = isnull(max(codigo), 0)  + 1
from cl_tabla

update  cl_seqnos
set siguiente = @w_tabla
where tabla = 'cl_tabla'
go


insert into cl_catalogo_pro
       (cp_producto, cp_tabla) 
select 'PFI',        codigo
from cl_tabla
where tabla like 'pf_%'
go




/***************************************************/
/*     PARAMETROS GENERALES DEPOSITOS A PLAZO      */
/***************************************************/

print '--> Parametros Generales'
go

delete cobis..cl_parametro
where pa_producto = 'PFI'
go

delete
from   cobis..cl_parametro
where  pa_producto <> 'PFI'
and   (pa_parametro like '%CDT%' or pa_parametro like '%PLAZO FIJO%')
go

insert into cobis..cl_parametro values ('CONCEPTO PARA ICA CDT'                                                , 'CICDT'    , 'C', '4010'          , NULL, NULL, NULL, NULL       , NULL        , NULL , 'CON')
insert into cobis..cl_parametro values ('CONCEPTO PARA RETEFUENTE CDT'                                         , 'CRCDT'    , 'C', '0215'          , NULL, NULL, NULL, NULL       , NULL        , NULL , 'CON')
insert into cobis..cl_parametro values ('MONTO CDTS REFERIDOS'                                                 , 'MCDTRD'   , 'M', NULL            , NULL, NULL, NULL, 500000.00  , NULL        , NULL , 'MIS')
insert into cobis..cl_parametro values ('PLAZO DIAS CDTS REFERIDOS'                                            , 'PCDTRD'   , 'I', NULL            , NULL, NULL, 90  ,  NULL      , NULL        , NULL , 'MIS')
insert into cobis..cl_parametro values ('MOVIMIENTOS DE CUENTAS Y CDTS'                                        , 'MAHC'     , 'M', NULL            , NULL, NULL, NULL, 50000000.00, NULL        , NULL , 'SUP')
insert into cobis..cl_parametro values ('EN LINEA ACTIVAS COBIS'                                               , 'ACT'      , 'C', 'N'             , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('CODIGO AGENTE COLOCADOR/ADMINISTRADOR PARA DECEVAL'                   , 'AGDCVL'   , 'C', '824'           , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('ANO EMISION DCVAL'                                                    , 'ANOEMI'   , 'C', 'GRAL'          , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('PERMITIR BLOQUEOS, PIGNORACIONES A CLIENTES CIFRADOS'                 , 'BCI'      , 'C', 'N'             , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('PERMITIR BLOQUEOS LEGALES A CLIENTES CIFRADOS'                        , 'BCL'      , 'C', 'S'             , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('PERMITIR BLOQUEOS,BLOQUEOS LEGALES,PIGNORACIONES MENORES EDAD'        , 'BME'      , 'C', 'N'             , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('BLOQUEO TOTAL'                                                        , 'BTPA'     , 'C', 'S'             , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('CONCEPTO PARA CAPITALIZACION'                                         , 'CAPIT'    , 'C', 'PFI'           , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('EN LINEA COMERCIO EXTERIOR COBIS'                                     , 'CEX'      , 'C', 'S'             , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('FORMA DE PAGO CHEQUES COMERCIALES'                                    , 'CHQCOM'   , 'C', 'CHC'           , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('COMPONENTE INFLACCIONARIO ANIO GRAVABLE'                              , 'CIAG'     , 'F', 'NULL'          , NULL, NULL, NULL, NULL       , NULL        , 76.39, 'PFI')
insert into cobis..cl_parametro values ('CLASER TITULO DCVAL'                                                  , 'CLATI'    , 'C', 'CD'            , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('CODIGO EMISOR DCVAL'                                                  , 'CODEM'    , 'C', 'COB59'         , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('MANEJA CONTABILIDAD DE TERCEROS'                                      , 'CTE'      , 'C', 'S'             , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('NUMERO DE DECIMALES'                                                  , 'DCI'      , 'T', 'NULL'          , 2   , NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('DIAS MAXIMO PARA RECIBIR CHEQUE PROTESTADO'                           , 'DCP'      , 'T', 'NULL'          , 3   , NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('#DIAS DENTRO DE LOS CUALES SE PERMITE CAMBIO DE TASA'                 , 'DCT'      , 'T', 'NULL'          , 29  , NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('DECEVAL CON ANNA'                                                     , 'DCVANN'   , 'C', 'S'             , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('DIAS ANTES DE IMPRIMIR CERTIFICADO'                                   , 'DIC'      , 'T', 'NULL'          , 0   , NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('NUMERO DE DIAS PARA INACTIVACION'                                     , 'DINAC'    , 'I', 'NULL'          , NULL, NULL, 5   , NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('EMISION DE CHEQUE LOCAL POR CANCELACION DE OPERACION'                 , 'EMCANC'   , 'C', '43'            , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('EMISION DE CHEQUE LOCAL POR PAGOS PENDIENTES'                         , 'EMPAPE'   , 'C', '42'            , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('EMISION DE CHEQUE LOCAL POR RENOVACION DE OPERACION'                  , 'EMRENO'   , 'C', '44'            , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('NUMERO DE FILIAL PARA BASE DATOS'                                     , 'FILI'     , 'T', 'NULL'          , 1   , NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('FECHA DE MIGRACION'                                                   , 'FMI'      , 'D', 'NULL'          , NULL, NULL, NULL, NULL       , '11/30/2011', NULL , 'PFI')
insert into cobis..cl_parametro values ('FORMATO DE FECHA DE PLAZO FIJO'                                       , 'FORF'     , 'I', 'NULL'          , NULL, NULL, 103 , NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('NEMONICO DE FORMA DE PAGO AHORRO'                                     , 'FPAH'     , 'C', 'CAHO'          , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('NEMONICO DE FORMA DE PAGO CTA CTE'                                    , 'FPCC'     , 'C', 'CCTE'          , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('FORMA DE PAGO DE DEVOLUCION'                                          , 'FPDE'     , 'C', 'VXP'           , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('FORMA DE PAGO A INTERESES DE TITULO EMBARGADO'                        , 'FPITE'    , 'C', 'CHG'           , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('NEMONICO FUNDACION'                                                   , 'FUND'     , 'C', 'FUNDACION'     , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('RUBRO GRAVAMEN MOVIMIENTO FINANCIERO'                                 , 'GMF'      , 'C', 'GMF'           , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('HORA A LA QUE INICIA EL HORARIO DIFERIDO'                             , 'HDI'      , 'T', 'NULL'          , NULL, NULL, NULL, NULL       , '12/14/1998', NULL , 'PFI')
insert into cobis..cl_parametro values ('RUBRO ICA'                                                            , 'ICA'      , 'C', 'ICA'           , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('INSTRUMENTO CHEQUES DE GERENCIA'                                      , 'ICHDG'    , 'I', 'NULL'          , NULL, NULL, 1   , NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('IMPUESTO SOBRE EL CAPITAL'                                            , 'IMC'      , 'F', 'NULL'          , NULL, NULL, NULL, NULL       , NULL        , 0.8  , 'PFI')
insert into cobis..cl_parametro values ('CODIGO DE FIRMA IMPRESA'                                              , 'IMC1'     , 'I', 'NULL'          , NULL, NULL, 4434, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('CODIGO DE FIRMA SECUNDARIA IMPRESA'                                   , 'IMC2'     , 'I', 'NULL'          , NULL, NULL, 1848, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('IMPUESTO EMERGENCIA ECONOMICA'                                        , 'IMDB'     , 'F', 'NULL'          , NULL, NULL, NULL, NULL       , NULL        , 0.004, 'PFI')
insert into cobis..cl_parametro values ('IMPUESTO A LA RENTA'                                                  , 'IMP'      , 'F', 'NULL'          , NULL, NULL, NULL, NULL       , NULL        , 7    , 'PFI')
insert into cobis..cl_parametro values ('IMPUESTO A LA RENTA PARA RESIDENTES EN EL EXTRANJERO'                 , 'IMRE'     , 'F', 'NULL'          , NULL, NULL, NULL, NULL       , NULL        , 15   , 'PFI')
insert into cobis..cl_parametro values ('INSTRUMENTO ASOCIADO A CDTS'                                          , 'INCDT'    , 'T', 'NULL'          , 2   , NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('INSTRUMENTO ASOCIADO A CHEQUES COMERCIALES'                           , 'INCHCO'   , 'T', 'NULL'          , 5   , NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('MASCARA PARA CUENTAS DE PLAZO FIJO'                                   , 'KOP'      , 'C', '##-###-#####-#', NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('LONGITUD PARA CUENTAS DE PLAZO FIJO'                                  , 'LOP'      , 'T', 'NULL'          , 13  , NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('CANTIDAD DE DIAS MINIMO EN UNA CUOTA'                                 , 'MINDCU'   , 'S', 'NULL'          , NULL, 15  , NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('MONEDA LOCAL DEFAULT DE PFIJO'                                        , 'MLOPFI'   , 'T', 'NULL'          , 0   , NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('MONTO MINIMO PARA FRACCIONAMIENTO DE UN TITULO'                       , 'MMPFT'    , 'M', 'NULL'          , NULL, NULL, NULL, 50000      , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('MODULO PARA CUENTAS DE PLAZO FIJO'                                    , 'MOP'      , 'T', 'NULL'          , 11  , NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('CARTERA EN MORA PARA CLIENTES CON CDT'                                , 'MORCDT'   , 'I', 'NULL'          , NULL, NULL, 60  , NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('MEDIO DE PAGO DE INTERESES AL CLIENTE DESPUES DE LIBERADO EL EMB'     , 'MPICLE'   , 'C', 'VXP'           , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('NEMONICO DE FORMA DE PAGO CAMARA DE COMPENSACION'                     , 'NCAM'     , 'C', 'CAMC'          , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('NEMONICO DE CHEQUE DEL BANCO CENTRAL'                                 , 'NCHB'     , 'C', 'BCR'           , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('NEMONICO DE CHEQUE DE GERENCIA'                                       , 'NCHG'     , 'C', 'CHG'           , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('NEMONICO DE CHEQUE PAIS'                                              , 'NCHP'     , 'C', 'CHEP'          , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('NEMONICO CHEQUE LOCAL (CANJE)'                                        , 'NCHQL'    , 'C', 'CHQL'          , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('NEMONICO MEDIO DE PAGO CTA CONTROL'                                   , 'NCTRL'    , 'C', 'CTRL'          , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('NEMONICO DE FORMA DE PAGO DE CUPONES'                                 , 'NCUP'     , 'C', 'CUP'           , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('NEMONICO DE EFECTIVO'                                                 , 'NEFE'     , 'C', 'EFEC'          , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('NEMONICO INSTRUCCIONES ESPECIALES'                                    , 'NIES'     , 'C', 'INSTRUC'       , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('NEMONICO PAGOS JUDICIALES'                                            , 'NJUD'     , 'C', 'JUDIC'         , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('NEMONICO DE LETRA INTERNACIONAL 1013'                                 , 'NLI1'     , 'C', 'GIRO'          , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('Numero maximo de Fus/Fracc'                                           , 'NMFUF'    , 'M', 'NULL'          , NULL, NULL, NULL, 50         , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('Numero Maximo de Reimpresiones'                                       , 'NMRI'     , 'T', 'NULL'          , 6   , NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('NEMONICO DE FORMA OTROS'                                              , 'NOTR'     , 'C', 'OTRO'          , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('NEMONICO DE POPULAR BANK OF FLORIDA'                                  , 'NPBF'     , 'C', 'PBF'           , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('NEMONICO CUENTAS EN SUSPENSO PAGOS PENDIENTES'                        , 'NSUS'     , 'C', 'SUSPAG'        , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('NEMONICO MEDIO DE PAGO VALOR POR PAGAR'                               , 'NVXP'     , 'C', 'VXP'           , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('CONTROL OVERNIGHT'                                                    , 'OVER'     , 'C', 'OVER'          , 1   , NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('PESOS PARA CUENTAS DE PLAZO FIJO'                                     , 'POP'      , 'C', '765432765432'  , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('FORMA DE PAGO CUENTA PUENTE CHEQUES COMERCIALES'                      , 'PTCHCO'   , 'C', 'PCHC'          , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('RUBRO RETENCION EN LA FUENTE'                                         , 'RETFUE'   , 'C', 'RET'           , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('RETENCION POR INACTIVACION'                                           , 'RINAC'    , 'M', 'NULL'          , NULL, NULL, NULL, 11.5       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('RETENCIONES PAGAN INTERESES'                                          , 'RPI'      , 'C', 'S'             , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('SUBTIPO INSTRUMENTO CHEQUES DE GERENCIA'                              , 'SICHDG'   , 'I', 'NULL'          , NULL, NULL, 1   , NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('SUBTIPO DE INSTRUMENTO ASOCIADO A CDTS'                               , 'SINCDT'   , 'T', 'NULL'          , 2   , NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('SUBTIPO INSTRUMENTO CHEQUES COMERCIALES'                              , 'SINCHC'   , 'T', 'NULL'          , 5   , NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('SUCURSAL DECEVAL'                                                     , 'SUDCVL'   , 'C', '1'             , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('TASA LIBOR'                                                           , 'TLIB'     , 'C', 'TLIB'          , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('VALOR POR PAGAR'                                                      , 'VXP'      , 'C', 'VXP'           , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('DIAS CALENDARIO PLAZO FIJO'                                           , 'DCAL'     , 'S', NULL            , NULL, 360 , NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('SEPARADOR COLUMNA CARGA ARHIVO TASAS'                                 , 'SCCT'     , 'C', '@'             , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('SEPARADOR REGISTRO CARGA ARHIVO TASAS'                                , 'SRCT'     , 'C', '|'             , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('COBRO IMPUESTO RENTA SOBRE CAPITAL'                                   , 'ISCAP'    , 'C', 'S'             , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('COBRO IMPUESTO RENTA SOBRE INTERES'                                   , 'ISINT'    , 'C', 'N'             , NULL, NULL, NULL, NULL       , NULL        , NULL , 'PFI')
insert into cobis..cl_parametro values ('PORCENTAJE IMPUESTO RENTA'                                            , 'IMPREN'   , 'F', NULL            , NULL, NULL, NULL, NULL       , NULL        , 0.5  , 'PFI')
go


use cob_pfijo
go

set nocount on
go

print 'Antes de ejecucion'
go

select *
from cob_pfijo..pf_equivalencias
where eq_tabla in ('CATPRODUCT', 'TIPESTPRY', 'TIPCONCEPT')
GO

delete cob_pfijo..pf_equivalencias
where eq_tabla in ('CATPRODUCT', 'TIPESTPRY', 'TIPCONCEPT')

insert into pf_equivalencias values 
(36, 'CATPRODUCT', NULL, 30, 999999999, 'CDT', 'CERTIFICADO DE DEPOSITO A TERMINO')

insert into pf_equivalencias values 
(36, 'CATPRODUCT', NULL, 1, 29, 'CDAT', 'CERTIFICADO DE DEPOSITO A TERMINO FIJO')
go

insert into pf_equivalencias values 
(36, 'TIPCONCEPT', 'CAP',  NULL, NULL, 'CAP', 'CAPITAL')

insert into pf_equivalencias values 
(36, 'TIPCONCEPT', 'INT', NULL, NULL, 'INT', 'INTERES')

insert into pf_equivalencias values 
(36, 'TIPCONCEPT', 'RET', NULL, NULL, 'RET', 'RETENCION')

insert into pf_equivalencias values 
(36, 'TIPCONCEPT', 'GMF', NULL, NULL, 'GMF', 'GRAVAMEN MOVIMIENTO FINANCIERO')

insert into pf_equivalencias values 
(36, 'TIPCONCEPT', 'CHC', NULL, NULL, 'CHCOMER', 'CHEQUE LOCAL')

insert into pf_equivalencias values 
(36, 'TIPCONCEPT', 'CHQL', NULL, NULL, 'CHLOCAL', 'CHEQUE LOCAL')

insert into pf_equivalencias values 
(36, 'TIPCONCEPT', 'CHG', NULL, NULL, 'CHGEREN', 'CHEQUE LOCAL')

insert into pf_equivalencias values 
(36, 'TIPCONCEPT', 'PCHC', NULL, NULL, 'CTAPTE', 'CHEQUE LOCAL')

insert into pf_equivalencias values 
(36, 'TIPCONCEPT', 'CTRL', NULL, NULL, 'CTAPTE', 'EFECTIVO')

insert into pf_equivalencias values 
(36, 'TIPCONCEPT', 'EFEC', NULL, NULL, 'EFMN', 'EFECTIVO')

insert into pf_equivalencias values 
(36, 'TIPCONCEPT', 'OTROS', NULL, NULL, 'CTAPTE', 'EFECTIVO')

insert into pf_equivalencias values 
(36, 'TIPCONCEPT', 'VXP', NULL, NULL, 'CTAPTE', 'EFECTIVO')

insert into pf_equivalencias values 
(36, 'TIPCONCEPT', 'SEBRA', NULL, NULL, 'SEBRA', 'EFECTIVO')

insert into pf_equivalencias values 
(36, 'TIPCONCEPT', 'AHO', NULL, NULL, 'AHO', 'AHORROS')
go

insert into pf_equivalencias values 
(36, 'TIPESTPRY', 'ING', NULL, NULL, '0', 'NO VIGENTE')

insert into pf_equivalencias values 
(36, 'TIPESTPRY',  'ACT', NULL, NULL, '1', 'VIGENTE')

insert into pf_equivalencias values 
(36, 'TIPESTPRY',  'VEN', NULL, NULL, '2', 'VENCIDO')

insert into pf_equivalencias values 
(36, 'TIPESTPRY',  'CAN', NULL, NULL, '4', 'CANCELADO')

insert into pf_equivalencias values 
(36, 'TIPESTPRY',  'XACT', NULL, NULL, '0', 'NO VIGENTE')
go



print 'Desspues de ejecucion'
go

select *
from cob_pfijo..pf_equivalencias
where eq_tabla in ('CATPRODUCT', 'TIPESTPRY', 'TIPCONCEPT')
GO
