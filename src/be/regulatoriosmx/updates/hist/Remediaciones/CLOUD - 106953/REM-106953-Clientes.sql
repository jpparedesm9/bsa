
--ASESOR ASIGNADO: SOCORRO PEREZ TELLES  Usuario: sperezte	159
--ASESOR A REASIGNAR: ILSE ELIZABETH ISLAS CRUZ Usuario: gulinares ieislas	337

--PROSPECTO:
--42835	VILCHIS HERNANDEZ MARIA ADRIANA
--43458	MARTINEZ GONZALEZ JANET 
--44560	MENDOZA JUAREZ MARIAN VALERIA
--41067	ROMERO ALARCON MAGALY 
--41087	MARTINEZ MARTINEZ TEOFILA 
--41081	VILCHIS HERNANDEZ MARIA VERONICA
--41064	RODRIGUEZ CASILDO MARIA DEL CARMEN
--44566	MARTINEZ GONZALEZ OLIVIA 



USE cobis 
go

declare @w_oficial_ant   login,
@w_oficial_dest   login,
@w_commit        char(1),
@w_login_dest login,
@w_oficina_dest   int,
@w_msg           varchar(255),
@w_funcionario_dest   int

select @w_funcionario_dest = 337 -- antes 159

   select
   @w_login_dest   = fu_login, 
   @w_oficina_dest = fu_oficina
   from cobis..cl_funcionario
   where fu_funcionario = @w_funcionario_dest

   if @@rowcount = 0 begin
   select @w_msg = 'ERROR: FUNCIONARIO '+CONVERT(varchar, isnull(@w_funcionario_dest,'n/a')) + ' NO EXISTE'
      goto ERROR
   end
   
   select @w_oficial_dest = oc_oficial
   from cobis..cc_oficial
   where oc_funcionario = @w_funcionario_dest
   
   if @@rowcount = 0 begin 
   select @w_msg = 'ERROR: OFICIAL '+CONVERT(varchar, isnull(@w_oficial_dest, 'n/a')) + ' NO EXISTE'
      goto ERROR   
   end 
   
   update cobis..cl_ente set
   en_oficial     = @w_oficial_dest,
   c_funcionario  = @w_login_dest,
   en_oficina     = @w_oficina_dest
   where  en_ente in (42835, 43458,44560,41067,41087,41081,41064,44566)
   
   

ERROR:
print isnull(@w_msg ,'no hay mensaje')

if @w_commit = 'S' begin 
   select @w_commit = 'N'
  rollback tran 
end