/************************************************************************/
/*                   MODIFICACIONES                                     */
/*      FECHA          AUTOR              RAZON                         */
/*      12/ABR/2016     BBO             Migracion SYBASE-SQLServer FAL  */
/************************************************************************/

/* ************************************************************************************************************ */
/*   CREACION DE INTERCEPTORES   REQ 008-3-4                                                           			*/
/* ************************************************************************************************************	*/
----------------------------------------------------------------------------------
-- CREACION DE INTERCEPTORES  -- cobis..sp_usuario  consulta departamento
----------------------------------------------------------------------------------
use cobis
go

/* ******************ELIMINACION DE INTERCEPTORES     *********************************/
declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_usuario')
begin
    select @w_interceptor_id = interceptor_id from cts_interceptor where name = 'cobis..sp_usuario'
    if exists (select * from cts_interceptor_transaction where interceptor_id = @w_interceptor_id and trn in (15093))
       delete from cts_interceptor_transaction  where interceptor_id = @w_interceptor_id and trn in (15093)
    delete from cts_interceptor where name = 'cobis..sp_usuario'
END
GO

declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_usuario_hsbc')
begin
    select @w_interceptor_id = interceptor_id from cts_interceptor where name = 'cobis..sp_usuario_hsbc'
    if exists (select * from cts_interceptor_transaction where interceptor_id = @w_interceptor_id and trn in (15093))
       delete from cts_interceptor_transaction  where interceptor_id = @w_interceptor_id and trn in (15093)
    delete from cts_interceptor where name = 'cobis..sp_usuario_hsbc'
END
GO

declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_ad_rol')
begin
    select @w_interceptor_id = interceptor_id from cts_interceptor where name = 'cobis..sp_ad_rol'
    if exists (select * from cts_interceptor_transaction where interceptor_id = @w_interceptor_id and trn in (15043,15042,540,541,542))
       delete from cts_interceptor_transaction  where interceptor_id = @w_interceptor_id and trn in (15043,15042,540,541,542)
    delete from cts_interceptor where name = 'cobis..sp_ad_rol'
END
GO

declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_ad_rol_hsbc')
begin
    select @w_interceptor_id = interceptor_id from cts_interceptor where name = 'cobis..sp_ad_rol_hsbc'
    if exists (select * from cts_interceptor_transaction where interceptor_id = @w_interceptor_id and trn in (15043,15042,540,541,542))
       delete from cts_interceptor_transaction  where interceptor_id = @w_interceptor_id and trn in (15043,15042,540,541,542)
    delete from cts_interceptor where name = 'cobis..sp_ad_rol_hsbc'
END
GO

declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_usuario_rol')
begin
    select @w_interceptor_id = interceptor_id from cts_interceptor where name = 'cobis..sp_usuario_rol'
    if exists (select * from cts_interceptor_transaction where interceptor_id = @w_interceptor_id and trn in (570,571,572,15075,15076))
       delete from cts_interceptor_transaction  where interceptor_id = @w_interceptor_id and trn in (570,571,572,15075,15076)
    delete from cts_interceptor where name = 'cobis..sp_usuario_rol'
END
GO

declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_usuario_rol_hsbc')
begin
    select @w_interceptor_id = interceptor_id from cts_interceptor where name = 'cobis..sp_usuario_rol_hsbc'
    if exists (select * from cts_interceptor_transaction where interceptor_id = @w_interceptor_id and trn in (570,571,572,15075,15076))
       delete from cts_interceptor_transaction  where interceptor_id = @w_interceptor_id and trn in (570,571,572,15075,15076)
    delete from cts_interceptor where name = 'cobis..sp_usuario_rol_hsbc'
END
GO

declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_rolbusq')
begin
    select @w_interceptor_id = interceptor_id from cts_interceptor where name = 'cobis..sp_rolbusq'
    if exists (select * from cts_interceptor_transaction where interceptor_id = @w_interceptor_id and trn in (15044))
       delete from cts_interceptor_transaction  where interceptor_id = @w_interceptor_id and trn in (15044)
    delete from cts_interceptor where name = 'cobis..sp_rolbusq'
END
GO

declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_rolbusq_hsbc')
begin
    select @w_interceptor_id = interceptor_id from cts_interceptor where name = 'cobis..sp_rolbusq_hsbc'
    if exists (select * from cts_interceptor_transaction where interceptor_id = @w_interceptor_id and trn in (15044))
       delete from cts_interceptor_transaction  where interceptor_id = @w_interceptor_id and trn in (15044)
    delete from cts_interceptor where name = 'cobis..sp_rolbusq_hsbc'
END
GO

--Sp_ciudad
declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_ciudad')
begin
    select @w_interceptor_id = interceptor_id from cts_interceptor where name = 'cobis..sp_ciudad'
    if exists (select * from cts_interceptor_transaction where interceptor_id = @w_interceptor_id and trn in (588, 589, 1560, 1561, 1562))
       delete from cts_interceptor_transaction  where interceptor_id = @w_interceptor_id and trn in (588, 589, 1560, 1561, 1562)
    delete from cts_interceptor where name = 'cobis..sp_ciudad'
END
GO

declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_ciudad_cr')
begin
    select @w_interceptor_id = interceptor_id from cts_interceptor where name = 'cobis..sp_ciudad_cr'
    if exists (select * from cts_interceptor_transaction where interceptor_id = @w_interceptor_id and trn in (588, 589, 1560, 1561, 1562))
       delete from cts_interceptor_transaction  where interceptor_id = @w_interceptor_id and trn in (588, 589, 1560, 1561, 1562)
    delete from cts_interceptor where name = 'cobis..sp_ciudad_cr'
END
GO

--sp_parroquia
declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_parroquia')
begin
    select @w_interceptor_id = interceptor_id from cts_interceptor where name = 'cobis..sp_parroquia'
    if exists (select * from cts_interceptor_transaction where interceptor_id = @w_interceptor_id and trn in (1528, 1529, 1557, 1558, 1559))
       delete from cts_interceptor_transaction  where interceptor_id = @w_interceptor_id and trn in (1528, 1529, 1557, 1558, 1559)
    delete from cts_interceptor where name = 'cobis..sp_parroquia'
END
GO

declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_parroquia_cr')
begin
    select @w_interceptor_id = interceptor_id from cts_interceptor where name = 'cobis..sp_parroquia_cr'
    if exists (select * from cts_interceptor_transaction where interceptor_id = @w_interceptor_id and trn in (1528, 1529, 1557, 1558, 1559))
       delete from cts_interceptor_transaction  where interceptor_id = @w_interceptor_id and trn in (1528, 1529, 1557, 1558, 1559)
    delete from cts_interceptor where name = 'cobis..sp_parroquia_cr'
END
GO


/* ******************************************************************/
/* ******************************************************************/
/* ******************************************************************/

declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_moneda_dml')
begin
    select @w_interceptor_id = interceptor_id from cts_interceptor where name = 'cobis..sp_moneda_dml'
    if exists (select * from cts_interceptor_transaction where interceptor_id = @w_interceptor_id and trn in (1511, 1512))
       delete from cts_interceptor_transaction  where interceptor_id = @w_interceptor_id and trn in (1511, 1512)
    delete from cts_interceptor where name = 'cobis..sp_moneda_dml'
END
GO

declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_moneda_dml_cr')
begin
    select @w_interceptor_id = interceptor_id from cts_interceptor where name = 'cobis..sp_moneda_dml_cr'
    if exists (select * from cts_interceptor_transaction where interceptor_id = @w_interceptor_id and trn in (1511, 1512))
       delete from cts_interceptor_transaction  where interceptor_id = @w_interceptor_id and trn in (1511, 1512)
    delete from cts_interceptor where name = 'cobis..sp_moneda_dml_cr'
END
GO


declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_moneda_cr')
begin
    select @w_interceptor_id = interceptor_id from cts_interceptor where name = 'cobis..sp_moneda_cr'
    if exists (select * from cts_interceptor_transaction where interceptor_id = @w_interceptor_id and trn in (1555))
       delete from cts_interceptor_transaction  where interceptor_id = @w_interceptor_id and trn in (1555)
    delete from cts_interceptor where name = 'cobis..sp_moneda_cr'
END
GO
/* ******************************************************************/
/* ******************************************************************/
/* ******************************************************************/


/* ******************INSERCION DE INTERCEPTORES  **************************************************************   *********************************/

declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_usuario')
begin
   select @w_interceptor_id = interceptor_id from cts_interceptor where name = 'cobis..sp_usuario'
   PRINT 'ya existe el interceptor' 
END
ELSE
BEGIN
   select @w_interceptor_id = isnull(max(interceptor_id), 0) + 1 from cts_interceptor
   insert into cts_interceptor values (@w_interceptor_id, 'cobis..sp_usuario', null, 'P')
END
GO

/* ******************************************************************/
declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_usuario_hsbc')
begin
    select @w_interceptor_id = interceptor_id from cts_interceptor where name = 'cobis..sp_usuario_hsbc'
    PRINT 'ya existe el interceptor' 
 END
ELSE
BEGIN
   select @w_interceptor_id = isnull(max(interceptor_id), 0) + 1 from cts_interceptor
   insert into cts_interceptor values (@w_interceptor_id, 'cobis..sp_usuario_hsbc', null, 'P')
   insert into cts_interceptor_transaction values (15093, @w_interceptor_id, @w_interceptor_id * 100, 'BO', 'FIE', 'A')
END
GO

/* ******************************************************************/
declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_ad_rol')
begin
    select @w_interceptor_id = interceptor_id from cts_interceptor where name = 'cobis..sp_ad_rol'
    PRINT 'ya existe el interceptor' 
 END
ELSE
BEGIN
   select @w_interceptor_id = isnull(max(interceptor_id), 0) + 1 from cts_interceptor
   insert into cts_interceptor values (@w_interceptor_id, 'cobis..sp_ad_rol', null, 'P')
   insert into cts_interceptor_transaction values (540, @w_interceptor_id, @w_interceptor_id * 100, null, null, 'A')
   insert into cts_interceptor_transaction values (541, @w_interceptor_id, @w_interceptor_id * 100, null, null, 'A')
   insert into cts_interceptor_transaction values (542, @w_interceptor_id, @w_interceptor_id * 100, null, null, 'A')
END
GO

/* ******************************************************************/
declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_ad_rol_hsbc')
begin
    select @w_interceptor_id = interceptor_id from cts_interceptor where name = 'cobis..sp_ad_rol_hsbc'
    PRINT 'ya existe el interceptor' 
 END
ELSE
BEGIN
   select @w_interceptor_id = isnull(max(interceptor_id), 0) + 1 from cts_interceptor
   insert into cts_interceptor values (@w_interceptor_id, 'cobis..sp_ad_rol_hsbc', null, 'P')
   insert into cts_interceptor_transaction values (15043, @w_interceptor_id, @w_interceptor_id * 100, 'BO', 'FIE', 'A')
   insert into cts_interceptor_transaction values (15042, @w_interceptor_id, @w_interceptor_id * 100, 'BO', 'FIE', 'A')
   insert into cts_interceptor_transaction values (540, @w_interceptor_id, @w_interceptor_id * 100, 'BO', 'FIE', 'A')
   insert into cts_interceptor_transaction values (541, @w_interceptor_id, @w_interceptor_id * 100, 'BO', 'FIE', 'A')
   insert into cts_interceptor_transaction values (542, @w_interceptor_id, @w_interceptor_id * 100, 'BO', 'FIE', 'A')
END
GO

/* *******************************************************************/
declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_usuario_rol')
begin
    select @w_interceptor_id = interceptor_id from cts_interceptor where name = 'cobis..sp_usuario_rol'
	PRINT 'ya existe el interceptor'
 END
ELSE
BEGIN
   select @w_interceptor_id = isnull(max(interceptor_id), 0) + 1 from cts_interceptor
   insert into cts_interceptor values (@w_interceptor_id, 'cobis..sp_usuario_rol', null, 'P')
   insert into cts_interceptor_transaction values (570, @w_interceptor_id, @w_interceptor_id * 100, null, null, 'A')
   insert into cts_interceptor_transaction values (571, @w_interceptor_id, @w_interceptor_id * 100, null, null, 'A')
   insert into cts_interceptor_transaction values (572, @w_interceptor_id, @w_interceptor_id * 100, null, null, 'A')
END
GO

/* ******************************************************************/
declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_usuario_rol_hsbc')
begin
    select @w_interceptor_id = interceptor_id from cts_interceptor where name = 'cobis..sp_usuario_rol_hsbc'
	PRINT 'ya existe el interceptor' 
 END
ELSE
BEGIN
   select @w_interceptor_id = isnull(max(interceptor_id), 0) + 1 from cts_interceptor
   insert into cts_interceptor values (@w_interceptor_id, 'cobis..sp_usuario_rol_hsbc', null, 'P')
   insert into cts_interceptor_transaction values (570, @w_interceptor_id, @w_interceptor_id * 100, 'BO', 'FIE', 'A')
   insert into cts_interceptor_transaction values (571, @w_interceptor_id, @w_interceptor_id * 100, 'BO', 'FIE', 'A')
   insert into cts_interceptor_transaction values (572, @w_interceptor_id, @w_interceptor_id * 100, 'BO', 'FIE', 'A')
   insert into cts_interceptor_transaction values (15075, @w_interceptor_id, @w_interceptor_id * 100, 'BO', 'FIE', 'A')
   insert into cts_interceptor_transaction values (15076, @w_interceptor_id, @w_interceptor_id * 100, 'BO', 'FIE', 'A')
END
GO

/* ******************************************************************/
declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_rolbusq')
begin
    select @w_interceptor_id = interceptor_id from cts_interceptor where name = 'cobis..sp_rolbusq'
    PRINT 'ya existe el interceptor' 
 END
ELSE
BEGIN
   select @w_interceptor_id = isnull(max(interceptor_id), 0) + 1 from cts_interceptor
   insert into cts_interceptor values (@w_interceptor_id, 'cobis..sp_rolbusq', null, 'P')
END
GO

/* ******************************************************************/
declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_rolbusq_hsbc')
begin
    select @w_interceptor_id = interceptor_id from cts_interceptor where name = 'cobis..sp_rolbusq_hsbc'
    PRINT 'ya existe el interceptor' 
 END
ELSE
BEGIN
   select @w_interceptor_id = isnull(max(interceptor_id), 0) + 1 from cts_interceptor
   insert into cts_interceptor values (@w_interceptor_id, 'cobis..sp_rolbusq_hsbc', null, 'P')
   insert into cts_interceptor_transaction values (15044, @w_interceptor_id, @w_interceptor_id * 100, 'BO', 'FIE', 'A')
END
GO

--sp_ciudad
declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_ciudad')
begin
   select * from cts_interceptor where name = 'cobis..sp_ciudad'
   PRINT 'ya existe el interceptor sp_ciudad' 
END
ELSE
BEGIN
   select @w_interceptor_id = isnull(max(interceptor_id), 0) + 1 from cts_interceptor
   insert into cts_interceptor values (@w_interceptor_id, 'cobis..sp_ciudad', null, 'P')
END
GO

/* ******************************************************************/
declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_ciudad_cr')
begin
    select * from cts_interceptor where name = 'cobis..sp_ciudad_cr'
    PRINT 'ya existe el interceptor cobis..sp_ciudad_cr' 
 END
ELSE
BEGIN
   select @w_interceptor_id = isnull(max(interceptor_id), 0) + 1 from cts_interceptor
   insert into cts_interceptor values (@w_interceptor_id, 'cobis..sp_ciudad_cr', null, 'P')
   
   insert into cts_interceptor_transaction values (1561, @w_interceptor_id, 100, 'BO', null, 'A')
   
   
END
GO

--sp_parroquia
declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_parroquia')
begin
   select * from cts_interceptor where name = 'cobis..sp_parroquia'
   PRINT 'ya existe el interceptor cobis..sp_parroquia' 
END
ELSE
BEGIN
   select @w_interceptor_id = isnull(max(interceptor_id), 0) + 1 from cts_interceptor
   insert into cts_interceptor values (@w_interceptor_id, 'cobis..sp_parroquia', null, 'P')
END
GO

/* ******************************************************************/
declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_parroquia_cr')
begin
    select * from cts_interceptor where name = 'cobis..sp_parroquia_cr'
    PRINT 'ya existe el interceptor cobis..sp_parroquia_cr' 
 END
ELSE
BEGIN
   select @w_interceptor_id = isnull(max(interceptor_id), 0) + 1 from cts_interceptor
   insert into cts_interceptor values (@w_interceptor_id, 'cobis..sp_parroquia_cr', null, 'P')   
   insert into cts_interceptor_transaction values (1557, @w_interceptor_id, 100, 'BO', null, 'A')
   insert into cts_interceptor_transaction values (1558, @w_interceptor_id, 100, 'BO', null, 'A')
   insert into cts_interceptor_transaction values (1559, @w_interceptor_id, 100, 'BO', null, 'A')
   
END
GO


/* ******************************************************************/
/* ******************************************************************/
/* ******************************************************************/
declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_moneda_dml')
begin
    select * from cts_interceptor where name = 'cobis..sp_moneda_dml'
    PRINT 'ya existe el interceptor cobis..sp_moneda_dml' 
 END
ELSE
BEGIN
   select @w_interceptor_id = isnull(max(interceptor_id), 0) + 1 from cts_interceptor
   insert into cts_interceptor values (@w_interceptor_id, 'cobis..sp_moneda_dml', null, 'P')   
   insert into cts_interceptor_transaction values (1511, @w_interceptor_id, 10, null, null, 'A') 
   insert into cts_interceptor_transaction values (1512, @w_interceptor_id, 10, null, null, 'A') 

END
GO


/* ******************************************************************/
declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_moneda_dml_cr')
begin
    select * from cts_interceptor where name = 'cobis..sp_moneda_dml_cr'
    PRINT 'ya existe el interceptor cobis..sp_moneda_dml_cr' 
 END
ELSE
BEGIN
   select @w_interceptor_id = isnull(max(interceptor_id), 0) + 1 from cts_interceptor
   insert into cts_interceptor values (@w_interceptor_id, 'cobis..sp_moneda_dml_cr', null, 'P')   
   insert into cts_interceptor_transaction values (1511, @w_interceptor_id, 20, 'BO', null, 'A')   
   insert into cts_interceptor_transaction values (1512, @w_interceptor_id, 20, 'BO', null, 'A')   
END
GO

/* ******************************************************************/
declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cobis..sp_moneda_cr')
begin
    select * from cts_interceptor where name = 'cobis..sp_moneda_cr'
    PRINT 'ya existe el interceptor ccobis..sp_moneda_cr' 
 END
ELSE
BEGIN
   select @w_interceptor_id = isnull(max(interceptor_id), 0) + 1 from cts_interceptor
   insert into cts_interceptor values (@w_interceptor_id, 'cobis..sp_moneda_cr', null, 'P')   
   insert into cts_interceptor_transaction values (1555, @w_interceptor_id, 10, 'BO', null, 'A')
END
GO

/* ******************************************************************/
/* ******************************************************************/
/* ******************************************************************/
