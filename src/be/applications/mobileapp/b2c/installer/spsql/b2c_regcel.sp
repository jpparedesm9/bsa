/************************************************************************/
/*      Base de datos:          cob_bvirtual                            */
/*      Producto:               B2C                                     */
/*      Disenado por:           DFu                                     */
/*      archivo:                b2c_regcel.sp                           */
/*      Fecha de escritura:     12/11/2018                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA'.                                                       */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/  
/*                         PROPOSITO                                    */
/*      Registro de numero telefonico                                   */
/*                        MOFICIACIONES                                 */
/* 12/11/2018         DFU                  Emision inicial              */
/************************************************************************/  
use cob_bvirtual
go

IF OBJECT_ID ('dbo.sp_b2c_registrar_celular') IS NOT NULL
    DROP PROCEDURE dbo.sp_b2c_registrar_celular
GO

create proc sp_b2c_registrar_celular
(
@s_ssn           int         = null,
@s_sesn          int         = null,
@s_date          datetime    = null,
@s_user          varchar(14) = null,
@s_term          varchar(30) = null,
@s_ofi           smallint    = null,
@s_srv           varchar(30) = null,
@s_lsrv          varchar(30) = null,
@s_rol           smallint    = null,
@s_org           varchar(15) = null,
@s_culture       varchar(15) = null,
@t_rty           char(1)     = null,
@t_debug         char(1)     = 'N',
@t_file          varchar(14) = null,
@t_trn           int    = null,     
@i_ente          int,
@i_nro_celular   varchar(16),
@o_msg           varchar(255)= null OUT
)
as 

declare 
@w_error        int,
@w_sp_name      varchar(30),
@w_operacion    char(1),
@w_sec_dir      tinyint,
@w_sec_telefono tinyint,
@w_telefono     varchar(16)

select @w_sp_name = 'sp_b2c_registrar_celular'



select top 1 
@w_sec_dir      = te_direccion,
@w_sec_telefono = te_secuencial,
@w_telefono     = te_valor
from cobis..cl_telefono  
where te_ente        = @i_ente  
and te_tipo_telefono = 'C' 
order by te_direccion, te_secuencial

if @@rowcount = 0
   select @w_operacion = 'I'
else begin
   select @w_operacion = 'U'
   if @w_telefono = @i_nro_celular select @w_operacion = 'X'
end
   
if @w_operacion = 'I' begin

   select @w_sec_dir = di_direccion 
   from cobis..cl_direccion 
   where di_ente    =  @i_ente 
   and di_principal = 'S'
   
   if @@rowcount = 0 begin
      select top 1 @w_sec_dir = di_direccion 
      from cobis..cl_direccion 
      where di_ente    =  @i_ente 
      order by di_direccion 
      
      if @@rowcount = 0 begin
        select @w_error = 101059 --No existe direccion
        goto ERROR
      end 
   end   
   
   exec @w_error = cobis..sp_telefono
   @s_ssn              = @s_ssn,
   @s_user             = @s_user,
   @s_term             = @s_term,
   @s_sesn             = @s_sesn,
   @s_culture          = @s_culture,
   @s_date             = @s_date,
   @s_srv              = @s_srv,
   @s_lsrv             = @s_lsrv,
   @s_ofi              = @s_ofi,
   @s_rol              = @s_rol,
   @s_org              = @s_org,
   @t_trn              = 111,
   @i_operacion        = 'I',
   @i_ente             = @i_ente,
   @i_direccion        = @w_sec_dir,
   @i_valor            = @i_nro_celular,
   @i_tipo_telefono    = 'C'
   
   if @w_error != 0 goto ERROR 
   
end
if @w_operacion = 'U' begin

   exec @w_error = cobis..sp_telefono
   @s_ssn              = @s_ssn,
   @s_user             = @s_user,
   @s_term             = @s_term,
   @s_sesn             = @s_sesn,
   @s_culture          = @s_culture,
   @s_date             = @s_date,
   @s_srv              = @s_srv,
   @s_lsrv             = @s_lsrv,
   @s_ofi              = @s_ofi,
   @s_rol              = @s_rol,
   @s_org              = @s_org,
   @t_trn              = 112,
   @i_operacion        = 'U',
   @i_ente             = @i_ente,
   @i_direccion        = @w_sec_dir,
   @i_secuencial       = @w_sec_telefono,
   @i_valor            = @i_nro_celular,
   @i_tipo_telefono    = 'C'
   
   if @w_error != 0 goto ERROR 
   
end

return 0

ERROR:

select @o_msg   = mensaje
from cobis..cl_errores 
where numero = @w_error

return @w_error

GO

