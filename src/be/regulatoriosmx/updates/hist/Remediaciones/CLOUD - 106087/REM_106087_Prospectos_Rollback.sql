--ASESOR ASIGNADO: JESSYCA LOZADA CERVANTES USUARIO: jlozadace  --90
--ASESOR A REASIGNAR: JORGE ARMANDO PIÑA SALAZAR USUARIO: japina --160
--PROSPECTO:
--10120 - JORGE JAIR ORTEGA CEDILLO --cliente
--38695 - CARLOS HUGO KANTUN JIMENEZ -- prospecto
--9352 - VERONICA QUIROZ MARTINEZ -- cliente


USE cobis 
go

declare @w_oficial_ant   login,
@w_oficial_dest   login,
@w_commit        char(1),
@w_login_dest login,
@w_oficina_dest   int,
@w_msg           varchar(255),
@w_funcionario_dest   int

select @w_funcionario_dest =  90 -- antes 90

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
   where  en_ente in (10120, 38695, 9352)

ERROR:
print isnull(@w_msg ,'no hay mensaje')

if @w_commit = 'S' begin 
   select @w_commit = 'N'
  rollback tran 
end