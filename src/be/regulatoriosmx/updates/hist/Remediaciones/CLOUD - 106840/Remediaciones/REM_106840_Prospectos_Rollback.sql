--ASESOR ASIGNADO: ANGÉLICA  ARANDA VÁZQUEZ USUARIO: aarandava -- 266
--ASESOR A REASIGNAR: RAÚL FLORES ROMERO USUARIO: rfloresro -- 267
--Prospectos
--33458 - GUADALUPE ANAHÍ OLIVARES VERDIGUEL
--33518 - ADRIANA PELENCO GARCIA
--33455 - ROSALVA XOCHIMANCA PEÑA 
--33460 - MARÍA FERNANDA PASCUAL MIGUEL


USE cobis 
go

declare @w_oficial_ant   login,
@w_oficial_dest   login,
@w_commit        char(1),
@w_login_dest login,
@w_oficina_dest   int,
@w_msg           varchar(255),
@w_funcionario_dest   int

select @w_funcionario_dest =  266 -- antes 266

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
   where  en_ente in (33458, 33518, 33455, 33460)

ERROR:
print isnull(@w_msg ,'no hay mensaje')

if @w_commit = 'S' begin 
   select @w_commit = 'N'
  rollback tran 
end

----------------------------------------------------------------------------

--ASESOR ACTUAL: CARLA LIZETH ESTRADA SOTELO USUARIO: clestrada -- 250
--ASESOR PARA REASIGNAR: RAÚL FLORES ROMERO USUARIO: rfloresro -- 267
--28377 - SELENE  SÁNCHEZ CHILLOPA


USE cobis 
go

declare @w_oficial_ant   login,
@w_oficial_dest   login,
@w_commit        char(1),
@w_login_dest login,
@w_oficina_dest   int,
@w_msg           varchar(255),
@w_funcionario_dest   int

select @w_funcionario_dest =  250 -- antes 250

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
   where  en_ente in (28377)

ERROR:
print isnull(@w_msg ,'no hay mensaje')

if @w_commit = 'S' begin 
   select @w_commit = 'N'
  rollback tran 
end