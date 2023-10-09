use cob_conta_tercero
go
declare @w_name varchar(64),
@w_tipo char(1),
@w_count int

print 'use cob_conta_tercero'
print 'go'
print "print ' ' "

print "print '>> ELIMINANDO ESTRUCTURAS DE CONTA TERCERO' "
print "print ' ' "
set nocount on
select @w_name = ' ', @w_count = 0
while 1=1
begin
   set rowcount 1
   select @w_name= name , @w_tipo = type
    from sysobjects 
   where type in ('U', 'V', 'P')
    and name > @w_name
   order by name

   if @@rowcount = 0 break  --Si no registros, sale

   select @w_count = @w_count +1

   if @w_tipo = 'U'  --User table
   begin
      --print "print 'Eliminando tabla %1!'", @w_name --Sybase
      print "print 'Eliminando tabla " + @w_name + "'" --SQLServer
      print 'go'
      --print "if exists (select 1 from sysobjects where name = '%1!' and type = '%2!')", @w_name, @w_tipo --Sybase
      print "if exists (select 1 from sysobjects where name = '" + @w_name + "' and type = '" + @w_tipo + "')" --SQLServer
      --print 'drop table  %1!', @w_name --Sybase
      print "drop table " + @w_name --SQLServer
      print 'go'
   end
   if @w_tipo = 'V' --Vistas
   begin
      --print "print 'Eliminando vista %1!'", @w_name --Sybase
      print "print 'Eliminando vista " + @w_name + "'" --SQLServer
      print 'go'
      --print "if exists (select 1 from sysobjects where name = '%1!' and type = '%2!')", @w_name, @w_tipo --Sybase
      print "if exists (select 1 from sysobjects where name = '" + @w_name + "' and type = '" + @w_tipo + "')" --SQLServer
      --print 'drop view  %1!', @w_name --Sybase
      print "drop view " + @w_name --SQLServer
      print 'go'
   end
   if @w_tipo = 'P' --Procedures
   begin
      --print "print 'Eliminando Procedure %1!'", @w_name --Sybase
      print "print 'Eliminando Procedure " + @w_name + "'" --SQLServer
      print 'go'
      --print "if exists (select 1 from sysobjects where name = '%1!' and type = '%2!')", @w_name, @w_tipo --Sybase
      print "if exists (select 1 from sysobjects where name = '" + @w_name + "' and type = '" + @w_tipo + "')" --SQLServer
      --print 'drop proc  %1!', @w_name
      print "drop proc " + @w_name --SQLServer
      print 'go'
   end
   
--   if @w_count = 10
--   begin
--      print 'dump tran cob_conta_tercero with no_log'
--      print 'go'
--      select @w_count = 0
--   end

   if @@error <> 0 break
end
go
