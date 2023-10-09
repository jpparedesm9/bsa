/* *********************************************************************/
/*      Archivo:              rol_asesores_colectivos.sp               */
/*      Stored procedure:     sp_rol_asesor_colectivo                  */
/*      Base de datos:        cobis                                    */
/*      Producto:             Clientes                                 */
/*      Disenado por:         Andres Cusme                             */
/*      Fecha de escritura:   03-DIC-2019                              */
/* *********************************************************************/
/*                              IMPORTANTE                             */
/*      Este programa es parte de los paquetes bancarios propiedad de  */
/*      "MACOSA", representantes exclusivos para el Ecuador de la      */
/*      "NCR CORPORATION".                                             */
/*      Su uso no autorizado queda expresamente prohibido asi como     */
/*      cualquier alteracion o agregado hecho por alguno de sus        */
/*      usuarios sin el debido consentimiento por escrito de la        */
/*      Presidencia Ejecutiva de MACOSA o su representante.            */
/* *********************************************************************/
/*                              PROPOSITO                              */
/*      Script para manejo de roles asesores de colectivos             */
/* *********************************************************************/
/*                              MODIFICACIONES                         */
/*      FECHA           AUTOR                 RAZON                    */
/*      03/DIC/2019     Andres Cusme      	 Emision Inicial           */
/* *********************************************************************/

use cob_cartera
go

if exists (select * from sysobjects where name = 'sp_rol_asesor_colectivo')
   drop proc sp_rol_asesor_colectivo
go 

create proc sp_rol_asesor_colectivo
   (
      @s_ssn                  int             = null,
      @s_sesn                 int             = null,
      @s_culture              varchar(10)     = null,
      @s_user                 login           = null,
      @s_term                 varchar(32)     = null,
      @s_date                 datetime        = null,
      @s_srv                  varchar(30)     = null,
      @s_lsrv                 varchar(30)     = null,
      @s_ofi                  smallint        = null,
      @s_rol                  smallint        = null,
      @s_org_err              char(1)         = null,
      @s_error                int             = null,
      @s_sev                  tinyint         = null,
      @s_msg                  descripcion     = null,
      @s_org                  char(1)         = null,
      @t_debug                char(1)         = 'N',
      @t_file                 varchar(10)     = null,
      @t_from                 varchar(32)     = null,
      @t_trn                  smallint        = null,
      @i_ente                 int             = null,
      @i_operacion            char(1)         = null,
      @i_role_desc            varchar(64)     = null,
      @i_collective_desc      varchar(255)    = null,
      @i_business_officer     varchar(255)    = null,
      @o_mensaje              varchar(255)    = null out
   )
as
declare @w_oficina            smallint,       -- Codigo de oficina 
        @w_sp_name            descripcion,
		@w_error              int,
        @w_numero_registros   int,
        @w_mensaje            varchar(255)

select @w_oficina = of_oficina
from cobis..cl_oficina
where of_nombre = @i_collective_desc

select @w_sp_name = 'sp_collective_advisor_role'

if @t_trn = 1720 and @i_operacion = 'Q'
begin
   select 
      'Descripcion Colectivo' = cc_colectivo,
      'ID Oficial' = cc_funcionario,
      'Nombre Oficial' = fu_nombre,
      'Rol' = cc_rol 
      from cob_cartera..ca_colectivo_cargo, cobis..cl_funcionario 
      where cc_funcionario = fu_funcionario
end

if @t_trn = 1720 and @i_operacion = 'I'
begin
   if @i_role_desc <> 'ASESOR' and not exists(select 1 from cob_cartera..ca_colectivo_cargo where cc_colectivo = @i_collective_desc and cc_rol =  @i_role_desc and cc_funcionario = @i_business_officer)
   begin
      INSERT INTO ca_colectivo_cargo (cc_colectivo, cc_oficina, cc_rol, cc_funcionario)
      VALUES (@i_collective_desc, @w_oficina, @i_role_desc, @i_business_officer)
   end
   else if @i_role_desc = 'ASESOR' and not exists(select 1 from cob_cartera..ca_colectivo_cargo 
                                                  where cc_colectivo = @i_collective_desc 
                                                  and cc_rol         = @i_role_desc 
                                                  and cc_funcionario = @i_business_officer 
                                                  and cc_oficina     = @w_oficina)
   begin
      INSERT INTO ca_colectivo_cargo (cc_colectivo, cc_oficina, cc_rol, cc_funcionario)
      VALUES (@i_collective_desc, @w_oficina, @i_role_desc, @i_business_officer)
   end
   else
   begin
      --'El registro ya existe'
      select @w_error = 109000
      GOTO ERROR
   end
end	

if @t_trn = 1720 and @i_operacion = 'D'
begin
	
	select @w_numero_registros = COUNT(*) FROM ca_colectivo_cargo WHERE cc_rol = @i_role_desc AND cc_oficina = @w_oficina
	
   if exists(select 1 from cob_cartera..ca_colectivo_cargo where cc_colectivo = @i_collective_desc and cc_rol =  @i_role_desc and cc_funcionario = @i_business_officer) and @w_numero_registros > 1
   begin
      delete from ca_colectivo_cargo
      where cc_colectivo = @i_collective_desc and cc_rol =  @i_role_desc and cc_funcionario = @i_business_officer
   end
   else if exists(select 1 from cob_cartera..ca_colectivo_cargo where cc_colectivo = @i_collective_desc and cc_rol =  @i_role_desc and cc_funcionario = @i_business_officer) and @w_numero_registros = 1
   begin
      select @o_mensaje = 'Debe existir almenos 1 registro con el rol ' + @i_role_desc + ' para la oficina ' + @i_collective_desc
	  delete from ca_colectivo_cargo
      where cc_colectivo = @i_collective_desc and cc_rol =  @i_role_desc and cc_funcionario = @i_business_officer
   end
   else 
   begin
      --'El registro que se intenta eliminar no existe'
      select @w_error = 109001
      GOTO ERROR
   end
end

--Este tipo permite consultar los oficiales en base al rol
if @t_trn = 1720 and @i_operacion = 'O'
begin
   select   'Id Oficial' = fu_funcionario,
            'Nombre' = fu_nombre
   from cobis..cl_funcionario, 
   cob_workflow..wf_usuario,
   cob_workflow..wf_usuario_rol,
   cob_workflow..wf_rol
   where fu_login        = us_login
   and   us_id_usuario  = ur_id_usuario
   and   ur_id_rol      = ro_id_rol
   and   ro_nombre_rol  = @i_role_desc
   order by fu_funcionario desc
   
   --Error al cargar la lista de oficiales para el rol seleccionado
   if @@rowcount = 0
   begin
      select @w_error = 109002
      GOTO ERROR
   end
end

return 0

ERROR:
exec cobis..sp_cerror
   @t_from = @w_sp_name,
   @i_num  = @w_error
   return @w_error

go