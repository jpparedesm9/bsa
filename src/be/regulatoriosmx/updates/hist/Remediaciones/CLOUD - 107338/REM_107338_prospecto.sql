--SOLICITAMOS DE SU APOYO PARA LAS SIGUIENTES REASIGNACIONES:
--ASESOR ASIGNADO: MIRNA IVONNE VALDEZ ASCENSIÓN USUARIO: mivaldez-mivaldez-106
--ASESOR A REASIGNAR: CARINA LEÓN DÁVILA USUARIO: cleond-cleond-303
--CLIENTE:
--34600 - ADRIANA ESPAÑAMARINEZ
--34592 - FELICITAS ALVAREZ SALVADOR
--34587 - ROSENDA ELIGIO MARTINEZ
--34586 - ALBERTA GIL AMADO
--34589 - ADRIANA MARTINEZ ALVAREZ
--34607 - JACINTA ESTANISLAO CRUZ
--34576 - IRIDIAN SEGUNDO SECUNDINO

USE cobis 
go

declare @w_oficial_ant   login,
@w_oficial_dest   login,
@w_commit        char(1),
@w_login_dest login,
@w_oficina_dest   int,
@w_msg           varchar(255),
@w_funcionario_dest   int

select @w_funcionario_dest =  303 -- antes 106

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
   where  en_ente in (34600,34592,34587,34586,34589,34607,34576)

ERROR:
print isnull(@w_msg ,'no hay mensaje')

if @w_commit = 'S' begin 
   select @w_commit = 'N'
  rollback tran 
end