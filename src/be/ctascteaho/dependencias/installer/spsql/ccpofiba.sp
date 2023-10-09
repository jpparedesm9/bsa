/************************************************************************/
/*  Archivo:                ccpofiba.sp                                 */
/*  Stored procedure:       sp_tr_crea_ofibanco                         */
/*  Base de datos:          cob_cuentas                                 */
/*  Producto:               Cuentas Corrientes                          */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*  Este programa procesa la transaccion de:                            */
/*  Mantenimiento de Oficinas del Banco.                                */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*  FECHA         AUTOR           RAZON                                 */
/*  18/07/2016    Walther Toledo  Migracion a CEN                       */
/************************************************************************/

use cob_cuentas
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_tr_crea_ofibanco')
  drop proc sp_tr_crea_ofibanco
go

create proc sp_tr_crea_ofibanco (
	@s_ssn		      int,
	@s_srv		      varchar(30),
	@s_lsrv		      varchar(30),
	@s_user		      varchar(30),
	@s_sesn		      int,
	@s_term		      varchar(10),
	@s_date		      datetime,
	@s_ofi		      smallint,
	@s_rol		      smallint    = 1,
	@s_org_err	      char(1)     = null,
	@s_error	      int         = null,
	@s_sev		      tinyint     = null,
	@s_msg		      varchar(240)     = null,
	@s_org		      char(1),
	@t_debug	      char(1)     = 'N',
	@t_file		      varchar(14) = null,
	@t_from		      varchar(32) = null,
	@t_rty		      char(1)     = 'N',
	@t_trn		      smallint,
	@t_show_version   bit = 0,
    @i_tran               char(1)     = null,
--	@i_banco	      smallint    = null,
	@i_oficina            smallint    = null,
--        @i_ofi_cobis          smallint    = null,
	@i_ciudad             int    = null,
	@i_desc		      varchar(64) = null,
	@i_direccion          varchar(120)   = null,
	@i_telefono           varchar(12) = null,
	@i_formato_fecha      smallint    = 103
--	@i_identificacion     varchar(8)  = null
)
as
declare
        @w_return	      int,
	@w_sp_name	      varchar(30),
        @w_descripcion        varchar(64),
        @w_fecha              smalldatetime,
        @w_direccion          varchar(120),
        @w_telefono           char(1),
        @w_ofi_cobis          tinyint,	
	@w_banco	      smallint 

/*  Captura nombre de Stored Procedure  */

select	@w_sp_name = 'sp_tr_crea_ofibanco'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
  print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
  return 0
end

/*  Activacion del Modo de debug  */

if @t_trn = 2591                /*      Consulta     */

    if @i_tran = 'Q'

      begin
        set rowcount 20
        select   'OFICINA'        = ob_oficina,
                 'CIUDAD'         = ob_ciudad,
                 'DESCRIPCION'    = substring(ob_descripcion,1,30),
				 'FECHA'          = convert(char(10),ob_fecha,@i_formato_fecha),
                 'DIRECCION'      = substring(ob_direccion,1,30),
                 'TELEFONO'       = ob_telefono
         from cob_remesas..re_ofi_banco
         where ob_oficina > @i_oficina 
         order by ob_oficina   
         if @@rowcount = 0
            begin	
               exec cobis..sp_cerror
                  @t_debug  = @t_debug,
                  @t_file   = @t_file,
                  @t_from   = @w_sp_name,
                  @i_num    = 351048
               return 351048
            end        
         set rowcount 0
     end

if @t_trn = 2589                   /*    Crear Registros          */

  begin

  select @w_banco = pa_tinyint
    from cobis..cl_parametro
   where pa_nemonico = 'CBCO'
     and pa_producto = 'CTE'

  if @@rowcount = 0  
  begin
      exec cobis..sp_cerror
           @i_num       = 201196
      return 201196
  end

    /* Valida existencia de la oficina */
      if exists (select *
                 from cob_remesas..re_ofi_banco
                 where ob_banco   = @w_banco 
                   and ob_oficina = @i_oficina
                   and ob_ciudad  = @i_ciudad)
         begin
            exec cobis..sp_cerror
               @t_debug    = @t_debug,
               @t_file     = @t_file,
               @t_from     = @w_sp_name,
               @i_num      = 351047
            return 351047
         end         

      insert into cob_remesas..re_ofi_banco 
                  (ob_banco, ob_oficina, ob_ciudad,
                   ob_descripcion, ob_fecha, ob_direccion, 
                   ob_telefono, ob_ofi_cobis)
         values   (@w_banco, @i_oficina, @i_ciudad,
                   @i_desc, @s_date, @i_direccion, 
                   @i_telefono, @i_oficina) 
      if @@error != 0
        begin
          exec cobis..sp_cerror
               @t_debug	 = @t_debug,
               @t_file	 = @t_file,
               @t_from	 = @w_sp_name,
               @i_num	 = 353014
          return 353014
        end

    /* Creacion de Transaccion de Servicio */

       insert into cob_cuentas..cc_tran_servicio
				(ts_secuencial, ts_tipo_transaccion, ts_tsfecha, 
				 ts_usuario,ts_terminal, ts_oficina, ts_hora)
                         values (@s_ssn, @t_trn, @s_date, @s_user, @s_term, 
                                 @s_ofi, getdate()) 

    /* Error en creacion de transaccion de servicio */

       if @@error != 0
          begin
             exec cobis..sp_cerror
                @t_debug	 = @t_debug,
                @t_file	 = @t_file,
                @t_from	 = @w_sp_name,
                @i_num	 = 203005
             return 203005
          end

  end               

if @t_trn = 2592            /*     Eliminacion de Registros     */

  begin

  select @w_banco = pa_tinyint
    from cobis..cl_parametro
   where pa_nemonico = 'CBCO'
     and pa_producto = 'CTE'

  if @@rowcount = 0  
  begin
      exec cobis..sp_cerror
           @i_num       = 201196
      return 201196
  end

    /* Valida existencia de la Oficina */
    if not exists (select *
                   from cob_remesas..re_ofi_banco
                   where ob_banco   = @w_banco
                     and ob_oficina = @i_oficina
                     and ob_ciudad  = @i_ciudad)
      begin
        /* No existe oficina del Banco */
        exec cobis..sp_cerror
             @t_debug	 = @t_debug,
             @t_file	 = @t_file,
             @t_from	 = @w_sp_name,
             @i_num	 = 351049
        return 351049
      end

      delete cob_remesas..re_ofi_banco 
      where ob_banco   = @w_banco
        and ob_oficina = @i_oficina
        and ob_ciudad  = @i_ciudad 
      if @@rowcount != 1
         begin
           exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file	 = @t_file,
                @t_from	 = @w_sp_name,
                @i_num	 = 357006
           return 357006
         end

    /* Creacion de Transaccion de Servicio */

       insert into cob_cuentas..cc_tran_servicio
				(ts_secuencial, ts_tipo_transaccion, ts_tsfecha, 
				 ts_usuario,ts_terminal, ts_oficina, ts_hora)
                         values (@s_ssn, @t_trn, @s_date, @s_user, @s_term, 
                                 @s_ofi, getdate()) 

    /* Error en creacion de transaccion de servicio */

       if @@error != 0
          begin
             exec cobis..sp_cerror
                @t_debug	 = @t_debug,
                @t_file	 = @t_file,
                @t_from	 = @w_sp_name,
                @i_num	 = 203005
             return 203005
          end
   end

if @t_trn = 2590            /*     Actualizacion de Oficinas     */

  begin

  select @w_banco = pa_tinyint
    from cobis..cl_parametro
   where pa_nemonico = 'CBCO'
     and pa_producto = 'CTE'

  if @@rowcount = 0  
  begin
      exec cobis..sp_cerror
           @i_num       = 201196
      return 201196
  end

     /* Valida Existencia de la Oficina */      
     if not exists (select *
                    from cob_remesas..re_ofi_banco
                    where ob_banco   = @w_banco
                      and ob_oficina = @i_oficina
                      and ob_ciudad  = @i_ciudad)
        begin
           exec cobis..sp_cerror
              @t_debug	 = @t_debug,
              @t_file	 = @t_file,
              @t_from	 = @w_sp_name,
              @i_num	 = 351049
           return 351049
        end

      update cob_remesas..re_ofi_banco 
         set ob_descripcion = @i_desc,
             ob_fecha       = convert(varchar(10), @s_date,@i_formato_fecha),
             ob_direccion   = @i_direccion,
             ob_telefono    = @i_telefono,
             ob_ofi_cobis   = @i_oficina
       where ob_banco   = @w_banco
         and ob_oficina = @i_oficina
         and ob_ciudad  = @i_ciudad
       if @@rowcount != 1
         begin
           exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file	 = @t_file,
                @t_from	 = @w_sp_name,
                @i_num	 = 355020
           return 355020
         end

    /* Creacion de Transaccion de Servicio */

       insert into cob_cuentas..cc_tran_servicio
				(ts_secuencial, ts_tipo_transaccion, ts_tsfecha, 
				 ts_usuario,ts_terminal, ts_oficina, ts_hora)
                         values (@s_ssn, @t_trn, @s_date, @s_user, @s_term, 
                                 @s_ofi, getdate()) 

    /* Error en creacion de transaccion de servicio */

       if @@error != 0
          begin
             exec cobis..sp_cerror
                @t_debug	 = @t_debug,
                @t_file	 = @t_file,
                @t_from	 = @w_sp_name,
                @i_num	 = 203005
             return 203005
          end

  end       

  return 0
go
IF OBJECT_ID('sp_tr_crea_ofibanco') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE sp_tr_crea_ofibanco >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE sp_tr_crea_ofibanco >>>'
go

go
use cob_cuentas
go
