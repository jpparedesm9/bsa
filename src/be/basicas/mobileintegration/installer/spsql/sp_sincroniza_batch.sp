use cob_sincroniza
go

IF EXISTS (select * from sys.objects where name = 'sp_sincroniza_batch' and [type] = 'P')
	DROP PROCEDURE sp_sincroniza_batch
go

CREATE PROCEDURE sp_sincroniza_batch
as
declare
@w_secuencial	INT,
@w_error        INT,
@w_msg			VARCHAR(100),
@w_sp_name      VARCHAR(30),
@w_official		int,
@w_login		varchar(30),
@w_sync_result	int

select
	@w_sp_name = 'sp_sincroniza_batch',
	@w_error = 2109109,
	@w_secuencial = 0

while 1 = 1
begin

	select top 1
        @w_secuencial = sb_secuencial
    from cob_sincroniza.dbo.si_sincroniza_batch
    where sb_secuencial > @w_secuencial
    and sb_estado = 'P'
    order by sb_secuencial

    if @@rowcount = 0 break
    
    select
    	@w_official = sb_oficial
    from cob_sincroniza.dbo.si_sincroniza_batch
    where sb_secuencial = @w_secuencial
    
    select @w_login = fu_login
	from  cobis.dbo.cl_funcionario, cobis.dbo.cc_oficial
	where oc_oficial = @w_official 
	and oc_funcionario = fu_funcionario

	IF @w_login is not NULL
	BEGIN
		update cob_sincroniza.dbo.si_sincroniza_batch
		set sb_estado = 'S'
		where sb_secuencial = @w_secuencial
		
		exec @w_sync_result = cob_credito.dbo.sp_sync_device @s_user = @w_login, @i_oficial = @w_official
		
		if @w_sync_result = 0
		BEGIN
			
			update cob_sincroniza.dbo.si_sincroniza_batch
			set sb_estado = 'C', sb_fecha_ultima_sincronizacion = getdate()
			where sb_secuencial = @w_secuencial
			
		END
		ELSE
		BEGIN
			select @w_error = @w_sync_result
			GOTO ERROR
		END
	END
end
	
return 0

ERROR:
	begin 
		exec cobis..sp_cerror
			@t_debug = 'N',
			@t_file  = 'S',
			@t_from  = @w_sp_name,
			@i_num   = @w_error
	end
return @w_error;
GO