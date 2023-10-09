use cob_conta
go

if exists(select 1 from cob_conta..sysobjects where name = 'sp_ejecmaysifp' and xtype = 'P')
   drop proc sp_ejecmaysifp
go

create proc sp_ejecmaysifp
(
   @i_empresa    tinyint,
   @i_fecha      datetime
)
as
declare @w_particion  tinyint,
        @w_return     int

select @w_particion = 1

select @w_return = 0

begin tran
   execute @w_return = cob_conta..sp_maysifp
   @i_empresa      = @i_empresa,
   @i_fecha_tran   = @i_fecha,
   @i_nro_procesos = @w_particion,
   @i_opcion       = 0

   if @w_return <> 0
   begin
      print 'Error opcion 0 sp_maysifp'
      rollback tran
      return 1
   end
   

   execute @w_return = cob_conta..sp_maysifp
   @i_empresa    =  @i_empresa,
   @i_fecha_tran =  @i_fecha,
   @i_opcion     =  1,
   @i_proceso    =  1

   if @w_return <> 0
   begin
      print 'Error opcion 1 sp_maysifp'
      rollback tran
      return 1
   end

   execute @w_return = cob_conta..sp_maysifp
   @i_empresa      = 1,
   @i_fecha_tran   = @i_fecha,
   @i_opcion       = 2

   if @w_return <> 0
   begin
      print 'Error opcion 2 sp_maysifp'
      rollback tran
      return 1
   end
commit tran
return 0

go
