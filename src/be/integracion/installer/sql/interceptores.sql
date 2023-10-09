/************************************************************************/
/*                   MODIFICACIONES                                     */
/*      FECHA          AUTOR              RAZON                         */
/*      31/MAY/2017     M. Taco           Emision inicial               */
/************************************************************************/

use cobis
go

/* ****************** ELIMINACION DE INTERCEPTORES   *********************************/
declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cob_pac..sp_deudores_busin')
begin
    select @w_interceptor_id = interceptor_id from cts_interceptor where name = 'cob_pac..sp_deudores_busin'
    if exists (select 1 from cts_interceptor_transaction where interceptor_id = @w_interceptor_id and trn in (21513,21013,21413))
       delete from cts_interceptor_transaction  where interceptor_id = @w_interceptor_id and trn in (21513,21013,21413)
    delete from cts_interceptor where name = 'cob_pac..sp_deudores_busin'
end
go

declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cob_pac..sp_qr_operacion_busin')
begin
    select @w_interceptor_id = interceptor_id from cts_interceptor where name = 'cob_pac..sp_qr_operacion_busin'
    if exists (select 1 from cts_interceptor_transaction where interceptor_id = @w_interceptor_id and trn in (7145))
       delete from cts_interceptor_transaction  where interceptor_id = @w_interceptor_id and trn in (7145)
    delete from cts_interceptor where name = 'cob_pac..sp_qr_operacion_busin'
end
go

/* ******************  INSERCION DE INTERCEPTORES  **************************************/

declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cob_pac..sp_deudores_busin')
begin
    select @w_interceptor_id = interceptor_id from cts_interceptor where name = 'cob_pac..sp_deudores_busin'
    PRINT 'ya existe el interceptor' 
 END
ELSE
BEGIN
   select @w_interceptor_id = isnull(max(interceptor_id), 0) + 1 from cts_interceptor
   insert into cts_interceptor values (@w_interceptor_id, 'cob_pac..sp_deudores_busin', null, 'P')
   insert into cts_interceptor_transaction values (21513, @w_interceptor_id, @w_interceptor_id * 100, null, null, 'A')
   insert into cts_interceptor_transaction values (21013, @w_interceptor_id, @w_interceptor_id * 100, null, null, 'A')
   insert into cts_interceptor_transaction values (21413, @w_interceptor_id, @w_interceptor_id * 100, null, null, 'A')
END
GO

declare @w_interceptor_id SMALLINT
if exists (select 1 from cts_interceptor where name = 'cob_pac..sp_deudores_busin')
begin
    select @w_interceptor_id = interceptor_id from cts_interceptor where name = 'cob_pac..sp_deudores_busin'
    PRINT 'ya existe el interceptor' 
 END
ELSE
BEGIN
   select @w_interceptor_id = isnull(max(interceptor_id), 0) + 1 from cts_interceptor
   insert into cts_interceptor values (@w_interceptor_id, 'cob_pac..sp_deudores_busin', null, 'P')
   insert into cts_interceptor_transaction values (7145, @w_interceptor_id, @w_interceptor_id * 100, null, null, 'A')
END
GO