/*  Archivo:            b2c_sp_registro_opt.sp                        */
/*  Stored procedure:   sp_validacion_opt_gen                         */
/*  Base de datos:      cob_bvirtual                                  */
/*  Producto:           Mobil                                         */
/*  Disenado por:       Javier Ariza                                  */
/*  Fecha de escritura: 22-Ago-2022                                   */
/**********************************************************************/
/*                        IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de     */
/*  'COBISCORP SA',representantes exclusivos para el Ecuador de la    */
/*  AT&T                                                              */
/*  Su uso no autorizado queda expresamente prohibido asi como        */
/*  cualquier autorizacion o agregado hecho por alguno de sus         */
/*  usuario sin el debido consentimiento por escrito de la            */
/*  Presidencia Ejecutiva de COBISCORP SA o su representante          */
/**********************************************************************/
/*                          PROPOSITO                                 */
/* - Almacenar los datos de geolocalización por cada operación        */
/* que realice el cliente a través de la App Tuiio Móvil.             */
/**********************************************************************/
/*                    MODIFICACIONES                                  */
/*  FECHA          AUTOR            RAZON                             */
/*  22-Ago-2022    J. Ariza      191122 Versión Inicial              */
/*          														  */
/**********************************************************************/

use cob_bvirtual
go

if exists (select 1 from sysobjects where name = 'sp_validacion_opt_gen')
        drop proc sp_validacion_opt_gen
go

CREATE PROCEDURE sp_validacion_opt_gen(
  @t_show_version bit              = 0,
  @s_user         login            =null,
  @s_date         datetime         =null,
  @s_srv          varchar(30)      =null,
  @s_ofi          smallint         =null,
  @s_term         varchar(30)      =null,
  @i_operacion    char(1)          =null,
  @i_tipo         varchar(10)      =null,
  @i_canal        varchar(10)      =null,
  @i_num_mail     varchar(70)      =null,
  @i_otp          varchar(6)       =null,
  @i_fecha        datetime         =null
)
As
declare
    @w_sp_name              varchar(30),
    @w_return               int,
    @w_fecha_inicio         datetime,
	@w_error                int

select @w_sp_name      = 'sp_validacion_opt_gen'
print 'Nombre sp: ' + convert(varchar(20),@w_sp_name)


select @w_fecha_inicio = getdate()


       if exists(select 1 from cob_bvirtual..bv_otp_seguridad where se_canal=@i_canal and se_tipo=@i_tipo and se_num_mail=@i_num_mail and se_codigo=@i_otp)
       begin
          if exists(select 1 from cob_bvirtual..bv_otp_seguridad where se_canal=@i_canal and se_tipo=@i_tipo and se_num_mail=@i_num_mail and se_codigo=@i_otp and @w_fecha_inicio BETWEEN se_fecha_ingreso and se_fecha_vencimiento)
          begin
          return 0
          end
          else
          begin
           select @w_error = 1890025
           goto ERROR	
          end
          
       end 
       
       else 
	   begin 
	    select @w_error = 1890024
        goto ERROR
	   end
   
        

ERROR:
exec cobis..sp_cerror
@t_from  = @w_sp_name,
@i_num   = @w_error

return @w_error