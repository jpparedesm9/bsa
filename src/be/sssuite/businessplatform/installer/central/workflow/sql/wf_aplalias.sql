print 'APLALIAS'
use cob_workflow
go

set nocount on
go

declare @w_i int,
        @w_nombre varchar(64)

select @w_i = 0
while @w_i < 17
begin
        select @w_nombre = '%syb%' + CONVERT(char(2), @w_i)
		select @w_nombre = rtrim(@w_nombre)

		if exists(	select 	* 
					from 	master..syslogins A, 
							sysalternates B 
					where 	name = '%syb%' + CONVERT(char(2), @w_i)
					and 	A.suid = B.suid	)
			exec sp_dropalias @w_nombre

        exec sp_addalias @w_nombre, dbo

        select @w_i = @w_i + 1

end

if exists(	select 	* 
			from 	master..syslogins A, 
					sysalternates B 
			where 	name = 'REENTRY' 
			and 	A.suid = B.suid	)
	exec sp_dropalias 'REENTRY'

exec sp_addalias REENTRY, dbo

if exists(	select 	* 
			from 	master..syslogins A, 
					sysalternates B 
			where 	name = 'LOGGER' 
			and 	A.suid = B.suid	)
	exec sp_dropalias 'LOGGER'

exec sp_addalias LOGGER, dbo
go
