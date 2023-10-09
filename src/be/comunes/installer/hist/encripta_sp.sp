use master
go
set nocount on
go
if object_id('sp_encripta_sp') != null
		drop proc sp_encripta_sp
go

create proc sp_encripta_sp
as
declare @w_nombre	varchar(30),
	@w_comando	varchar(255)

create table #tmp_script (
	ts_texto varchar(255)
)

declare bases_datos cursor
    for select nombre
   from master..parambd_cobis

open bases_datos

fetch bases_datos into
	@w_nombre

while (@@sqlstatus = 0)
begin
  select @w_comando = 'insert into #tmp_script '
  select @w_comando = @w_comando + 'select "exec sp_hidetext @objname = ''" +  name '   + '+ "''" '
  select @w_comando = @w_comando + 'from ' + @w_nombre + '..sysobjects '
  select @w_comando = @w_comando + 'where type = ''P'' '
  select @w_comando = @w_comando + 'and name like "sp_%"'

  exec (@w_comando)

  select 'select ''***** ' + @w_nombre + ' *****'''
  print 'go'

  select 'dump tran master with truncate_only'
  print 'go'

  select 'dump tran tempdb with truncate_only'
  print 'go'

  select 'dump tran ' + @w_nombre + ' with truncate_only'
  print 'go'

  select 'use ' + @w_nombre
  print 'go'

  select '--PARA ENCRIPTAR' = ts_texto
    from #tmp_script
  print 'go'

  select 'dump tran master with truncate_only'
  print 'go'

  select 'dump tran tempdb with truncate_only'
  print 'go'

  select 'dump tran ' + @w_nombre + ' with truncate_only'
  print 'go'

  delete #tmp_script

  fetch bases_datos into
	@w_nombre
end

close bases_datos
deallocate cursor bases_datos

drop table #tmp_script

return 0
go
set nocount off
go
