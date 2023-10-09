use cobis
go

declare @w_return      int,
        @w_s_app       varchar(50),
        @w_path        varchar(50),
        @w_error       int,
        @w_errores     varchar(1500),
        @w_comando     varchar(2500),
        @w_usuario     login,
        @w_mensaje     varchar(255),
		@w_destino     varchar(2500)
        
if (OBJECT_ID('tempdb..##catalogos_activa')) IS NOT NULL
   drop table tempdb..##catalogos_activa

if (OBJECT_ID('tempdb..##catalogos_activa_det')) IS NOT NULL
   drop table tempdb..##catalogos_activa_det

select @w_s_app = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto = 'ADM'
and pa_nemonico = 'S_APP'


select @w_path = ba_path_destino
   from cobis..ba_batch
   where ba_batch = 21060

--if @@error > 0 or @@rowcount <> 1
--begin
--   select   @w_mensaje  = 'NO EXISTE PARAMETRO S_APP',
--            @w_error    = 1
--   goto ERRORFIN
--end 
--
--select top 5 * 
--from cl_tabla 
--where codigo in (select cp_tabla 
--                 from cl_catalogo_pro 
--                 where cp_producto in ('CRE','GAR','CCA'))
--
--if @@rowcount = 0
--begin
--    select @w_mensaje = 'NO HAY REGISTROS DE CCA-GAR-CRE',
--           @w_error   = 1
--    goto ERRORFIN
--end

select a.*, b.cp_producto
into ##catalogos_activa
from cl_tabla a, cl_catalogo_pro b
where codigo = cp_tabla
and cp_producto in ('CRE','GAR','CCA')
order by tabla

select tabla, codigo, valor, estado
into ##catalogos_activa_det
from cl_catalogo
where tabla in (select cp_tabla 
                 from cl_catalogo_pro 
                 where cp_producto in ('CRE','GAR','CCA'))



select @w_comando = @w_s_app + 's_app bcp -auto -login tempdb..##catalogos_activa out '

select @w_destino = @w_path + 'tabla.txt',
       @w_errores = @w_path + 'tabla.err'
       
select @w_comando = @w_comando + @w_destino + ' -b5000 -c -e -T -C' + @w_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando

print @w_comando
exec @w_error = xp_cmdshell @w_comando

--if @w_error <> 0 begin
--   select   @w_mensaje  = 'ERROR EN EJECUCION ' + @w_comando,
--            @w_error    = 1
--   --goto ERRORFIN
--end

select @w_comando = ''

select @w_comando = @w_s_app + 's_app bcp -auto -login tempdb..##catalogos_activa_det out '
select @w_destino = @w_path + 'catalogo.txt',
       @w_errores = @w_path + 'catalogo.err'

select @w_comando = @w_comando + @w_destino + ' -b5000 -c -e -T -C' + @w_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando

print @w_comando
exec @w_error = xp_cmdshell @w_comando

go


