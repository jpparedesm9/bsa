-- VALIDACION REGISTROS PASADOS AL REPOSITORIO
-- exec sp_cons_paso_repo


use cob_conta
go

set nocount on

if exists (select * from sysobjects where name = 'sp_cons_paso_repo')
   drop proc sp_cons_paso_repo
go

create proc sp_cons_paso_repo (
   @i_param1   varchar(25)
)
as
declare @w_fecha     varchar(10),
        @w_tabla     varchar(50),
        @w_campo     varchar(50),
        @w_comando   varchar(255),
        @w_basedatos varchar(50),
        @w_cant_his  int,
        @w_cant_prod int,
        @w_server    varchar(50),
        @w_tabla1    varchar(50),
        @w_path      varchar(100),
        @w_path_lis  varchar(100),
        @w_ruta      varchar(100),
        @w_s_app     varchar(100),
        @w_destino   varchar(100),
        @w_errores   varchar(100),
        @w_error     int,
        @w_anio      int,
        @w_mes       int,
        @w_dia       int
        
select @w_cant_prod = 0
select @w_cant_his  = 0
select @w_fecha = convert(varchar(10), @i_param1, 101)

--select @w_fecha = convert(varchar(10),fp_fecha,101)
--from cobis..ba_fecha_proceso

select @w_path = pa_char
from cobis..cl_parametro
where pa_producto = 'SIT'
and   pa_nemonico = 'RAIS'

select @w_path_lis = pp_path_destino
from cobis..ba_path_pro  
where pp_producto = 6

select @w_ruta = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

select tabla = pd_tabla , campo = pd_campo, secuencia = 1, pd_basedatos
into #tablas
from cob_conta..cb_paramdep
where pd_tipo = 'D'
and   pd_tabla like 'cob_conta_super..%'
and   pd_campo is not null
and   pd_campo != ''
order by pd_tabla

select @w_server = pa_char
from cobis..cl_parametro
where pa_nemonico = 'LSCP'
and   pa_producto = 'ADM'

if exists (select 1 from sysobjects where name = 'resultado' and type = 'U')
   drop table resultado
   
select tabla=convert(varchar(50),''), cantidad_his=0, cantidad_prod = 0
into resultado

create table #registro_his
(
   registros   int
)

while 1 = 1 begin

   select @w_cant_prod = 0
   select @w_cant_his  = 0

   set rowcount 1

   select @w_tabla = tabla,
          @w_campo = campo,
          @w_basedatos = pd_basedatos 
   from  #tablas
   where secuencia > 0

   if @@rowcount = 0 begin
      set rowcount 0
      break
   end 

   set rowcount 0
   
   select @w_tabla1 = substring (@w_tabla, charindex  ('..', @w_tabla)+2, len(@w_tabla))
   
   if isnull(@w_server, 'NOHIST') <> 'NOHIST' begin
      
      select @w_comando = 'insert into #registro_his select count(1) from ' + @w_server + '.' + @w_basedatos + '.dbo.' + @w_tabla1 + ' where ' +  @w_campo + ' = ' + '''' + @w_fecha + ''''
      
      exec sp_sqlexec @w_comando
      
      select @w_cant_his = registros
      from #registro_his
      
      delete #registro_his
      
   end

   select @w_comando = 'insert into #registro_his select count(1) from ' + @w_basedatos + '..' + @w_tabla1 + ' where ' +  @w_campo + ' = ' + '''' + @w_fecha + ''''

   exec sp_sqlexec @w_comando   
   
   select @w_cant_prod = registros
   from #registro_his
   
   delete #registro_his

   insert into resultado 
   values (@w_tabla, @w_cant_his, @w_cant_prod)
   
   update #tablas set
   secuencia = 0
   from  #tablas
   where tabla = @w_tabla

end

delete resultado
where tabla = ''

select @w_anio = datepart(yy, convert(datetime,@w_fecha))
select @w_mes  = datepart(mm, convert(datetime,@w_fecha))
select @w_dia  = datepart(dd, convert(datetime,@w_fecha))

select @w_s_app =  's_app bcp -auto -login cob_conta..resultado out '
select @w_destino  = 'rep_paso_repo_'+ convert(varchar, @w_anio)+ convert(varchar, @w_mes) + convert(varchar, @w_dia) + '.lis',
       @w_errores  = @w_path_lis + 'rep_paso_repo' + '.err'
select @w_comando = @w_s_app + @w_path_lis + @w_destino + ' -b5000 -c -e' + @w_errores + ' -t"|" ' + '-config '+  + @w_ruta + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   print 'Error Cargando numero de registros del archivo'
   print @w_comando
   return 1
end

return 0

go