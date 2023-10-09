/* Script para la creacion de la tabla mc_business_transaction y transacciones de negocio */

use cob_mc
go

/* Eliminacion de Transacciones de Negocio */
-- print 'Eliminacion de Transacciones de Negocio'
-- go

-- delete from mc_business_transaction_detail where bt_id between 1001 and 1006
-- go
-- delete from mc_business_transaction where bt_id between 1001 and 1006
-- go

/* Creacion de Transacciones de Negocio */
print 'Creacion de Transacciones de Negocio'
go

if not exists (select 1 from mc_business_transaction where bt_id = 1001)
insert into mc_business_transaction values(1001,'Ing, Mod de Funcionarios',1,'Permite el Ingreso y Modificacion de Funcionarios','Y')
else
print 'Transaccion de Negocio 1001 ya existe'
go

if not exists (select 1 from mc_business_transaction where bt_id = 1002)
insert into mc_business_transaction values(1002,'Ing, Elim, de Roles a Funcionarios',1,'Permite el Ingreso, Modificacion y Eliminacion  de Roles a Funcionarios','Y')
else
print 'Transaccion de Negocio 1002 ya existe'
go

if not exists (select 1 from mc_business_transaction where bt_id = 1003)
insert into mc_business_transaction values(1003,'Ing, Mod, Elim de Login de Usuario',1,'Permite el Ingreso, Modificacion y Eliminacion de Login de Usuario','Y')
else
print 'Transaccion de Negocio 1003 ya existe'
go

if not exists (select 1 from mc_business_transaction where bt_id = 1004)
insert into mc_business_transaction values(1004,'Ing, Mod, Elim de Roles',1,'Permite el Ingreso, Modificacion y Eliminacion de Roles','Y')
else
print 'Transaccion de Negocio 1004 ya existe'
go

if not exists (select 1 from mc_business_transaction where bt_id = 1005)
insert into mc_business_transaction values(1005,'Ing, Mod, Elim de Oficiales',1,'Permite el Ingreso, Modificacion y Eliminacion de Oficiales','Y')
else
print 'Transaccion de Negocio 1005 ya existe'
go

if not exists (select 1 from mc_business_transaction where bt_id = 1006)
insert into mc_business_transaction values(1006,'Eliminacion de Funcionarios',1,'Permite la Eliminacion  de Funcionarios','Y')
else
print 'Transaccion de Negocio 1006 ya existe'
go

/*
declare @w_dt_process_id           varchar(30),  --Código del proceso de autorización dentro de COBIS Workflow
        @code                      int,
        @id_process                varchar(5),
        @version                   int

        select @code       = pr_codigo_proceso from cob_workflow..wf_proceso where  pr_nombre_proceso ='MAKER AND CHECKER'
        select @id_process = convert(varchar(5),@code )
        select @w_dt_process_id   = @id_process   --Código del proceso de autorización dentro de COBIS Workflow

update mc_business_transaction_detail set dt_enabled_production = 'N' where bt_id between 1001 and 1006

select @version = isnull(max(dt_version), 0) + 1 from mc_business_transaction_detail where bt_id = 1001
insert into mc_business_transaction_detail values(1001,@version,@w_dt_process_id,'MAKER AND CHECKER',0,0,'Y','Y')

select @version = isnull(max(dt_version), 0) + 1 from mc_business_transaction_detail where bt_id = 1002
insert into mc_business_transaction_detail values(1002,@version,@w_dt_process_id,'MAKER AND CHECKER',0,0,'Y','Y')

select @version = isnull(max(dt_version), 0) + 1 from mc_business_transaction_detail where bt_id = 1003
insert into mc_business_transaction_detail values(1003,@version,@w_dt_process_id,'MAKER AND CHECKER',0,0,'Y','Y')

select @version = isnull(max(dt_version), 0) + 1 from mc_business_transaction_detail where bt_id = 1004
insert into mc_business_transaction_detail values(1004,@version,@w_dt_process_id,'MAKER AND CHECKER',0,0,'Y','Y')

select @version = isnull(max(dt_version), 0) + 1 from mc_business_transaction_detail where bt_id = 1005
insert into mc_business_transaction_detail values(1005,@version,@w_dt_process_id,'MAKER AND CHECKER',0,0,'Y','Y')

select @version = isnull(max(dt_version), 0) + 1 from mc_business_transaction_detail where bt_id = 1006
insert into mc_business_transaction_detail values(1006,@version,@w_dt_process_id,'MAKER AND CHECKER',0,0,'Y','Y')
*/

go
