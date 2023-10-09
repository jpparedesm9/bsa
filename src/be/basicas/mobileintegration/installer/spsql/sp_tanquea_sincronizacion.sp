use cob_sincroniza
go

IF EXISTS (select * from sys.objects where name = 'sp_tanquea_sincronizacion' and [type] = 'P')
	DROP PROCEDURE sp_tanquea_sincronizacion
go

CREATE PROCEDURE sp_tanquea_sincronizacion (
	@i_oficial	int			= null,
	@i_usuario	varchar(30)	= null,
	@i_imei     varchar(30) = null,
	@i_estado_dis   char(1)     = null
)
as
declare
@w_secuencial	int,
@w_error      int,
@w_msg        varchar(200),
@w_sp_name    varchar(30),
@w_pending		int,
@w_min_days   int,
@w_diff_days  int,
@w_last_sync  date,
@w_time_min   int,
@w_estado_sinc varchar(1),
@w_time_espera int

select
	@w_sp_name = 'sp_tanquea_sincronizacion',
	@w_error = 1,
	@w_secuencial = 0
	
select 	@w_time_espera = 10

if not exists (select 1 from cobis..cl_funcionario 
           where fu_funcionario = (select oc_funcionario from cobis..cc_oficial where oc_oficial = @i_oficial))
begin
    select @w_error = 201121
	select @w_msg = mensaje from cobis.dbo.cl_errores where numero = @w_error
	goto ERROR
end

/*Comproabacion de estado*/
if exists (select 1 from cob_sincroniza..si_dispositivo
	       where di_imei = @i_imei 
	       and   di_oficial = @i_oficial 
	       and   @i_estado_dis in (select C.codigo from cobis..cl_catalogo C , cobis..cl_tabla T where T.tabla = 'mo_device_status_no_sincro' and T.codigo = C.tabla)) 
begin
    select @w_error = 2109114
	select @w_msg = mensaje from cobis.dbo.cl_errores where numero = @w_error
	goto ERROR
end

select @w_pending = count(*) from cob_sincroniza.dbo.si_sincroniza_batch
where sb_oficial = @i_oficial
and sb_estado != 'C'

select @w_estado_sinc = sb_estado
from cob_sincroniza.dbo.si_sincroniza_batch
where sb_oficial = @i_oficial
and sb_estado != 'C'

if @w_pending = 0
begin 

  select @w_min_days = pa_int
  from cobis.dbo.cl_parametro where pa_producto = 'ADM' and pa_nemonico = 'SMDES'  

  select
    @w_diff_days = datediff(day, max(sb_fecha_ultima_sincronizacion), getdate()),
    @w_last_sync = max(sb_fecha_ultima_sincronizacion)
  from cob_sincroniza.dbo.si_sincroniza_batch
  where sb_oficial = @i_oficial
  and sb_estado = 'C'  

  if @w_last_sync is null or @w_diff_days > @w_min_days
  begin
    select	@w_secuencial = coalesce(max(sb_secuencial),0)
    from	cob_sincroniza.dbo.si_sincroniza_batch

    insert into cob_sincroniza.dbo.si_sincroniza_batch (sb_secuencial, sb_estado, sb_usuario_registro, sb_fecha_registro, sb_oficial)
    VALUES(@w_secuencial + 1, 'P', @i_usuario, getdate(), @i_oficial)
  end
  else
  begin
    select @w_error = 2109113
    select @w_msg = replace(mensaje,'{ult_sync}',convert(varchar, @w_last_sync)) from cobis.dbo.cl_errores where numero = @w_error
    select @w_msg = replace(@w_msg,'{min_days}',convert(varchar, @w_min_days))
    goto ERROR
  end

end
else
begin
   
   select @w_time_min = datediff(minute,max(sb_fecha_registro),getdate())
   from cob_sincroniza.dbo.si_sincroniza_batch
   where sb_oficial = @i_oficial
   and sb_estado = 'S'
   
   
   if  @w_estado_sinc = 'P' or @w_time_min < @w_time_espera
   begin
 
	select @w_error = 2109112
	select @w_msg = mensaje from cobis.dbo.cl_errores where numero = @w_error
	goto ERROR
end
   else
   begin
      if @w_time_min > @w_time_espera
	  begin
	     update cob_sincroniza.dbo.si_sincroniza_batch
		 set sb_estado = 'C'
		 where sb_oficial = @i_oficial
         and sb_estado = 'S'
		 
	     select	@w_secuencial = coalesce(max(sb_secuencial),0)
         from	cob_sincroniza.dbo.si_sincroniza_batch
         
         insert into cob_sincroniza.dbo.si_sincroniza_batch (sb_secuencial, sb_estado, sb_usuario_registro, sb_fecha_registro, sb_oficial)
         VALUES(@w_secuencial + 1, 'P', @i_usuario, getdate(), @i_oficial)
	  end	 
   end   	
end

return 0

ERROR:
	begin 
		exec cobis..sp_cerror
			@t_debug = 'N',
			@t_file  = 'S',
			@t_from  = @w_sp_name,
			@i_num   = @w_error,
			@i_msg   = @w_msg
	end
return @w_error;
GO
