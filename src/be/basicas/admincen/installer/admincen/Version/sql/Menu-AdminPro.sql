/************************************************************************/	
/*  Archivo:                 Menu-AdminPro.sql                          */
/*  Base de datos:           cobis                                      */
/*  Producto:                ADMIN-PRO                                  */
/*  Disenado por:  	         Mario Velez P.                             */
/*  Fecha de documentacion:	 04/Ago/2012                                */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de              */
/*  "NCR".                                                              */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/*                         PROPOSITO                                    */
/*  Este script permite crear las opciones de menu para la              */
/*  administracion de seguridades                                       */
/*  FECHA		AUTOR		RAZON                                       */
/*  21-04-2016  BBO         Migracion Sybase-SQL FAL                    */
/************************************************************************/

/*********************************************************************/
/*                ADMINISTRACION DE PRODUCTOS (ADMPROD)              */
/*********************************************************************/


--====================================================
--SERVIDORES DE DISTRIBUCION
--====================================================

use cobis
go

declare @w_codigo int 
select @w_codigo=codigo from cl_tabla where tabla='an_product'
if not exists( select 1 from  cl_catalogo  where tabla=@w_codigo and codigo ='M-ADM.Prod')
   insert into  cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo,'M-ADM.Prod','ADMINISTRADOR DE PRODUCTOS','V')  
go

declare @w_co_id int
select @w_co_id = co_id  from an_component where co_name = 'Adm.Prod.FGServidoresDistribucion' and  co_prod_name  = 'M-ADM.Prod'

-- BASE PROD-NAME
if exists (select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 15171 and tc_oc_nemonic  is null)
   delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 15171 and tc_oc_nemonic  is null
insert into an_transaction_component values (@w_co_id,15171,null)

-- BASE PROD-NAME
if exists (select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 15170 and tc_oc_nemonic  is null)
   delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 15170 and tc_oc_nemonic  is null
insert into an_transaction_component values (@w_co_id,15170,null)
print 'SE APLICO CON EXITO LA SEGURIDAD PARA: SERVIDORES DE DISTRIBUCION'
go

--====================================================
--TRANSACCIONES DE UN PRODUCTO
--====================================================
use cobis
go

declare @w_co_id int
select @w_co_id = co_id from an_component where co_name = 'Adm.Prod.FConsTraProducto' and  co_prod_name  = 'M-ADM.Prod'

-- BASE COMPONENT
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15037 and tc_oc_nemonic  = 'M-ADM.Prod' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15037 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,15037,'M-ADM.Prod')
print 'SE APLICO CON EXITO LA SEGURIDAD PARA: TRANSACCIONES DE UN PRODUCTO'
go

--====================================================
--TRANSACCIONES POR PROCEDIMIENTO
--====================================================

use cobis
go

declare @w_co_id int
select @w_co_id = co_id from an_component where co_name = 'Adm.Prod.FConsTraProcedimiento' and  co_prod_name  = 'M-ADM.Prod'

-- BASE COMPONENT
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15028 and tc_oc_nemonic  = 'M-ADM.Prod' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15028 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,15028,'M-ADM.Prod')
print 'SE APLICO CON EXITO LA SEGURIDAD PARA: TRANSACCIONES POR PROCEDIMIENTO'
go

--====================================================
-- SERVIDORES POR PRODUCTO
--====================================================
use cobis
go

declare @w_co_id int
select @w_co_id = co_id from an_component where co_name = 'Adm.Prod.FConsSerProducto' and  co_prod_name  = 'M-ADM.Prod'

-- BASE COMPONENT
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15048 and tc_oc_nemonic  = 'M-ADM.Prod')
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15048 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,15048,'M-ADM.Prod')

-- BASE PROD-NAME
if exists (select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 15034 and tc_oc_nemonic  is null)
   delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 15034 and tc_oc_nemonic  is null
insert into an_transaction_component values (@w_co_id,15034,null)

-- BASE COMPONENT
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1571 and tc_oc_nemonic  = 'M-ADM.Prod' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1571 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,1571,'M-ADM.Prod')

-- BASE PROD-NAME
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 568 and tc_oc_nemonic  = 'M-ADM.Prod' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 568 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,568,'M-ADM.Prod')

if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1574 and tc_oc_nemonic  = 'M-ADM.Prod' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1574 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,1574,'M-ADM.Prod')
print 'SE APLICO CON EXITO LA SEGURIDAD PARA: SERVIDORES POR PRODUCTO'
go

--====================================================
--PRODUCTOS INSTALADOS
--====================================================
use cobis
go

declare @w_co_id int

select @w_co_id = co_id from an_component
where co_class = 'FConsProdInstaladoClass' and co_prod_name  = 'M-ADM.Prod'

-- BASE COMPONENT
if exists (select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 15016 and tc_oc_nemonic  is null )
   delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 15016 and tc_oc_nemonic  is null
insert into an_transaction_component values (@w_co_id,15016,null)
print 'SE APLICO CON EXITO LA SEGURIDAD PARA: PRODUCTOS INSTALADOS'
go

--====================================================
--CONSULTA GENERICA DE PRODUCTOS
--====================================================
use cobis
go

declare @w_co_id int

select @w_co_id = co_id from an_component
where co_class = 'FConsGenProductosClass' and co_prod_name  = 'M-ADM.Prod'

-- BASE PROD-NAME
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15032 and tc_oc_nemonic  = 'M-ADM.Prod' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15032 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,15032,'M-ADM.Prod')

-- BASE PROD-NAME
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1574 and tc_oc_nemonic  = 'M-ADM.Prod' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1574 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,1574,'M-ADM.Prod')

-- BASE PROD-NAME
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1556 and tc_oc_nemonic  = 'M-ADM.Prod' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1556 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,1556,'M-ADM.Prod')

-- BASE PROD-NAME
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15031 and tc_oc_nemonic  = 'M-ADM.Prod' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15031 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,15031,'M-ADM.Prod')

-- BASE PROD-NAME
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15035 and tc_oc_nemonic  = 'M-ADM.Prod' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15035 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,15035,'M-ADM.Prod')

-- BASE PROD-NAME
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15037 and tc_oc_nemonic  = 'M-ADM.Prod' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15037 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,15037,'M-ADM.Prod')

-- BASE COMPONENT
if exists (select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 15023 and tc_oc_nemonic  is null )
   delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 15023 and tc_oc_nemonic  is null
insert into an_transaction_component values (@w_co_id,15023,null)

-- BASE COMPONENT
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1571 and tc_oc_nemonic  = 'M-ADM.Prod' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1571 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,1571,'M-ADM.Prod')
print 'SE APLICO CON EXITO LA SEGURIDAD PARA: CONSULTA GENERICA DE PRODUCTOS'
go

--====================================================
--PRODUCTOS POR SERVIDOR
--====================================================
use cobis
go

declare @w_co_id int

select @w_co_id = co_id from an_component
where co_class = 'FConsProdServidorClass' and co_prod_name  = 'M-ADM.Prod'

-- BASE PROD-NAME
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15048 and tc_oc_nemonic  = 'M-ADM.Prod')
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15048 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,15048,'M-ADM.Prod')

-- BASE PROD-NAME
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1571 and tc_oc_nemonic  = 'M-ADM.Prod')
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1571 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,1571,'M-ADM.Prod')

-- BASE PROD-NAME
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1574 and tc_oc_nemonic  = 'M-ADM.Prod')
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1574 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,1574,'M-ADM.Prod')

-- BASE COMPONENT
if exists (select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 15015 and tc_oc_nemonic  is null)
   delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 15015 and tc_oc_nemonic  is null
insert into an_transaction_component values (@w_co_id,15015,null)
print 'SE APLICO CON EXITO LA SEGURIDAD PARA: PRODUCTOS POR SERVIDOR'
go

--====================================================
--PRODUCTOS POR TRANSACCION
--====================================================
use cobis
go

declare @w_co_id int

select @w_co_id = co_id from an_component
where co_class = 'FConsProdTransaccionClass' and co_prod_name  = 'M-ADM.Prod'

-- BASE PROD-NAME
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15020 and tc_oc_nemonic  = 'M-ADM.Prod')
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15020 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,15020,'M-ADM.Prod')

-- BASE PROD-NAME
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15074 and tc_oc_nemonic  = 'M-ADM.Prod')
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15074 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,15074,'M-ADM.Prod')
print 'SE APLICO CON EXITO LA SEGURIDAD PARA: PRODUCTOS POR TRANSACCION'
go

--====================================================
--PRODUCTO - OFICINA (consulta)
--====================================================
use cobis
go

declare @w_co_id int

select @w_co_id = co_id from an_component
where co_class = 'FGProductosOficinaClass' and co_prod_name  = 'M-ADM.Prod'

-- BASE PROD-NAME
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15032 and tc_oc_nemonic  = 'M-ADM.Prod')
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15032 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,15032,'M-ADM.Prod')

-- BASE COMPONENT
if exists (select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 1523 and tc_oc_nemonic  is null)
   delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 1523 and tc_oc_nemonic  is null
insert into an_transaction_component values (@w_co_id,1523,null)
print 'SE APLICO CON EXITO LA SEGURIDAD PARA: PRODUCTO - OFICINA (consulta)'
go

--====================================================
--PRODUCTO - MONEDA (CONSULTA)
--====================================================
use cobis
go

declare @w_co_id int

select @w_co_id = co_id from an_component
where co_class = 'FGProductosMonedaClass' and co_prod_name  = 'M-ADM.Prod'

-- BASE PROD-NAME
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15035 and tc_oc_nemonic  = 'M-ADM.Prod')
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15035 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,15035,'M-ADM.Prod')

-- BASE COMPONENT
if exists (select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 1525 and tc_oc_nemonic  is null)
   delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 1525 and tc_oc_nemonic  is null
insert into an_transaction_component values (@w_co_id,1525,null)

-- BASE COMPONENT
if exists (select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 15036 and tc_oc_nemonic  is null)
   delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 15036 and tc_oc_nemonic  is null
insert into an_transaction_component values (@w_co_id,15036,null)
go
print 'SE APLICO CON EXITO LA SEGURIDAD PARA: PRODUCTO - MONEDA (CONSULTA)'
go
--====================================================
--PRODUCTO - MONEDA (INGRESAR/ACTUALIZAR)
--====================================================
use cobis
go

declare @w_co_id int

select @w_co_id = co_id from an_component
where co_class = 'FGProductosMonedaClass' and co_prod_name  = 'M-ADM.Prod'

-- BASE COMPONENT
if exists (select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 1524 and tc_oc_nemonic  is null)
   delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 1524 and tc_oc_nemonic  is null
insert into an_transaction_component values (@w_co_id,1524,null)

-- BASE COMPONENT
if exists (select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 15149 and tc_oc_nemonic  is null)
   delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 15149 and tc_oc_nemonic  is null
insert into an_transaction_component values (@w_co_id,15149,null)

-- BASE PROD-NAME
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15031 and tc_oc_nemonic  = 'M-ADM.Prod')
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15031 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,15031,'M-ADM.Prod')

-- BASE PROD-NAME
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1556 and tc_oc_nemonic  = 'M-ADM.Prod')
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1556 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,1556,'M-ADM.Prod')

-- BASE PROD-NAME
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15031 and tc_oc_nemonic  = 'M-ADM.Prod')
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15031 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,15031,'M-ADM.Prod')

-- BASE PROD-NAME
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1556 and tc_oc_nemonic  = 'M-ADM.Prod')
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1556 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,1556,'M-ADM.Prod')
go

print 'SE APLICO CON EXITO LA SEGURIDAD PARA: PRODUCTO - MONEDA (INGRESAR/ACTUALIZAR)'
go


--====================================================
--PRODUCTO - OFICINA (Transmitir)
--====================================================
use cobis
go

declare @w_co_id int

select @w_co_id = co_id from an_component
where co_class = 'FGProductosOficinaClass' and co_prod_name  = 'M-ADM.Prod'

-- BASE COMPONENT
if exists (select 1 from an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 1521 and tc_oc_nemonic  is null)
   delete an_transaction_component where tc_co_id = @w_co_id and tc_tn_trn_code = 1521 and tc_oc_nemonic  is null
insert into an_transaction_component values (@w_co_id,1521,null)

-- BASE PROD-NAME
if exists (select 1 from an_transaction_component where tc_co_id = 0and tc_tn_trn_code = 1571 and tc_oc_nemonic  = 'M-ADM.Prod' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1571 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,1571,'M-ADM.Prod')

-- BASE PROD-NAME
if exists (select 1 from an_transaction_component where tc_co_id = 0and tc_tn_trn_code = 1574 and tc_oc_nemonic  = 'M-ADM.Prod' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1574 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,1574,'M-ADM.Prod')

-- BASE PROD-NAME
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15037 and tc_oc_nemonic  = 'M-ADM.Prod' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15037 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,15037,'M-ADM.Prod')

go
print 'SE APLICO CON EXITO LA SEGURIDAD PARA: PRODUCTO - OFICINA (Transmitir)'

go

--====================================================
--TRANSACCIONES DE UN PRODUCTO
--====================================================
use cobis
go

declare @w_co_id int, 
        @w_sco_id int, 
        @w_la_cod varchar(10), 
        @w_la_label varchar(100), 
        @w_co_prod_name varchar(10),
        @w_la_id int, 
        @w_mo_id int

--COBISCorp.tCOBIS.ADMPRO.Transaction - fprodtra.vb

select @w_co_prod_name = 'M-ADM.Prod', 
       @w_la_cod = 'ES_EC'

select @w_co_id = co_id from an_component 
where co_class like 'FProductoTransaccionClass' and co_prod_name like @w_co_prod_name

delete from an_transaction_component where tc_co_id = @w_co_id and  tc_tn_trn_code in (534,535,536) and tc_oc_nemonic is null --base component
delete from an_transaction_component where tc_co_id = 0 and  tc_tn_trn_code in (15020,15028,15037,15074) and tc_oc_nemonic = @w_co_prod_name -- BASE_PROD_NAME

insert into an_transaction_component values (@w_co_id, 534, null) --INSERTAR "I"   --base component
insert into an_transaction_component values (@w_co_id, 535, null) --ACTUALIZAR "U" --base component
insert into an_transaction_component values (@w_co_id, 536, null) --BORRAR "D"     --base component

insert into an_transaction_component values (0, 15020, @w_co_prod_name) --BUSCAR "S" -- BASE_PROD_NAME
insert into an_transaction_component values (0, 15028, @w_co_prod_name) --HELP "H"   -- BASE_PROD_NAME
insert into an_transaction_component values (0, 15037, @w_co_prod_name) --HELP "H"   -- BASE_PROD_NAME
insert into an_transaction_component values (0, 15074, @w_co_prod_name) --HELP "H"   -- BASE_PROD_NAME
go
print 'SE APLICO CON EXITO LA SEGURIDAD PARA: TRANSACCIONES DE UN PRODUCTO'
go

--====================================================
--TRANSACCIONES ELIMINAR/ACTUALIZAR
--====================================================
use cobis
go

--COBISCorp.tCOBIS.ADMPRO.Transaction - FGTRANSA.vb
--ES LLAMADA DESDE fprodtra.vb Y DESDE EL MENU "Transacciones-Eliminar", "Transacciones-Actualizar"
declare @w_co_id int, 
        @w_sco_id int, 
        @w_la_cod varchar(10), 
        @w_la_label varchar(100), 
        @w_co_prod_name VARCHAR(10), 
        @w_la_id int, 
        @w_mo_id int

SELECT	@w_co_prod_name = 'M-ADM.Prod', 
        @w_la_cod = 'ES_EC'

select @w_co_id = co_id from an_component 
where co_class like 'FProductoTransaccionClass' and co_prod_name like @w_co_prod_name

DELETE FROM an_transaction_component WHERE tc_co_id = @w_co_id and  tc_tn_trn_code in (529,563,15071,15073) and tc_oc_nemonic is null --base component

insert into an_transaction_component values (@w_co_id, 529, null)   --ACTUALIZAR                --base component
insert into an_transaction_component values (@w_co_id, 563, null)   --BORRAR                    --base component
insert into an_transaction_component values (@w_co_id, 15071, null) --LLAMADO DE cmdBoton_Click --base component
insert into an_transaction_component values (@w_co_id, 15073, null) --BUSCAR "Q"                --base component

SELECT @w_la_label = 'Transacciones'
if not exists (select 1 from an_label where la_label = @w_la_label) 
begin                                                                                                                                                                            
   select @w_la_id = isnull(max(la_id), 0) + 1 from an_label                                                                                                                                                                                                  
   insert into an_label values (@w_la_id, @w_la_cod, @w_la_label, @w_co_prod_name)                                                                                                                                                                         
end                                                                                                                                                                                                                                                                 
else select @w_la_id = la_id from an_label where la_label = @w_la_label

select @w_sco_id = co_id from an_component where co_name = 'Adm.Prod.FGTransacciones'
delete from an_referenced_components where rc_parent_co_id = @w_co_id and rc_child_co_id = @w_sco_id
insert into an_referenced_components values (@w_co_id, @w_sco_id, @w_la_id)
go
print 'SE APLICO CON EXITO LA SEGURIDAD PARA: TRANSACCIONES ELIMINAR/ACTUALIZAR'

go

--====================================================
--TRANSACCIONES INSERTAR
--====================================================
use cobis
go

--'******* [FTransaccionesClass] ***********'
--COBISCorp.tCOBIS.ADMPRO.Transaction - Ftransac.vb
declare @w_co_id int, 
        @w_sco_id int, 
        @w_la_cod varchar(10), 
        @w_la_label varchar(100), 
        @w_co_prod_name VARCHAR(10), 
        @w_la_id int, 
        @w_mo_id int

SELECT	@w_co_prod_name = 'M-ADM.Prod', 
        @w_la_cod = 'ES_EC'

select @w_co_id = co_id from an_component 
where co_class like 'FTransaccionesClass' and co_prod_name like @w_co_prod_name

DELETE FROM an_transaction_component 
WHERE tc_co_id = @w_co_id and  tc_tn_trn_code in (561,562) and tc_oc_nemonic is null --base component

insert into an_transaction_component values (@w_co_id, 561, null) --INSERTAR "I"   --base component
insert into an_transaction_component values (@w_co_id, 562, null) --ACTUALIZAR "U" --base component
go
print 'SE APLICO CON EXITO LA SEGURIDAD PARA: TRANSACCIONES INSERTAR'

go

--====================================================
--TRANSACCIONES PROCEDIMIENTOS
--====================================================
use cobis
go

--'******* [FGProcedimientosClass] ***********'
--COBISCorp.tCOBIS.ADMPRO.Transaction - FGPROCED.vb
declare @w_co_id int, 
        @w_sco_id int, 
        @w_la_cod varchar(10), 
        @w_la_label varchar(100), 
        @w_co_prod_name VARCHAR(10), 
        @w_la_id int, 
        @w_mo_id int

SELECT	@w_co_prod_name = 'M-ADM.Prod', 
        @w_la_cod = 'ES_EC'

select @w_co_id = co_id
from an_component
where co_class like 'FGProcedimientosClass'
and co_prod_name like @w_co_prod_name

DELETE FROM an_transaction_component WHERE tc_co_id = @w_co_id and  tc_tn_trn_code in (15026,530) and tc_oc_nemonic is null --base component
DELETE FROM an_transaction_component WHERE tc_co_id = 0 and  tc_tn_trn_code in (15027) and tc_oc_nemonic = @w_co_prod_name -- BASE_PROD_NAME

insert into an_transaction_component values (@w_co_id, 15026, null) --base component
insert into an_transaction_component values (@w_co_id, 530, null) --base component

insert into an_transaction_component values (0, 15027, @w_co_prod_name) -- BASE_PROD_NAME
go

-- BASE COMPONENT
if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15020 and tc_oc_nemonic  = 'M-ADM.Prod' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15020 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,15020,'M-ADM.Prod')


if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1570 and tc_oc_nemonic  = 'M-ADM.Prod' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1570 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,1570,'M-ADM.Prod')


if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1577 and tc_oc_nemonic  = 'M-ADM.Prod' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 1577 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,1577,'M-ADM.Prod')


if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15037 and tc_oc_nemonic  = 'M-ADM.Prod' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15037 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,15037,'M-ADM.Prod')

if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15168 and tc_oc_nemonic  = 'M-ADM.Prod' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15168 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,15168,'M-ADM.Prod')

if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15315 and tc_oc_nemonic  = 'M-ADM.Prod' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15315 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,15315,'M-ADM.Prod')


if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15316 and tc_oc_nemonic  = 'M-ADM.Prod' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15316 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,15316,'M-ADM.Prod')


if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15317 and tc_oc_nemonic  = 'M-ADM.Prod' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15317 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,15317,'M-ADM.Prod')


if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15318 and tc_oc_nemonic  = 'M-ADM.Prod' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15318 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,15318,'M-ADM.Prod')


if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15319 and tc_oc_nemonic  = 'M-ADM.Prod' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15319 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,15319,'M-ADM.Prod')


if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15320 and tc_oc_nemonic  = 'M-ADM.Prod' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15320 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,15320,'M-ADM.Prod')

if exists (select 1 from an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15222 and tc_oc_nemonic  = 'M-ADM.Prod' )
   delete an_transaction_component where tc_co_id = 0 and tc_tn_trn_code = 15222 and tc_oc_nemonic  = 'M-ADM.Prod'
insert into an_transaction_component values (0,15222,'M-ADM.Prod')

----------------
print 'SE APLICO CON EXITO LA SEGURIDAD PARA: TRANSACCIONES PROCEDIMIENTOS'
go
