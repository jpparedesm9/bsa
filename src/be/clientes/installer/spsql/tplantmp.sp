/************************************************************************/
/*  Archivo:        tplantmp.sp                                         */
/*  Stored procedure:   sp_tplan_tmp                                    */
/*  Base de datos:      cobis                                           */
/*  Producto:       Clientes                                            */
/*  Disenado por:       Sandra Ortiz                                    */
/*  Fecha de escritura: 9-May-1994                                      */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.   Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Este programa procesa las transacciones de:                         */
/*  Insercion de tipos de plan en la tabla temporal                     */
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  9/may/1994  S.Ortiz     Emision inicial                             */
/*     12/Mar/2003      E.Laguna        Ajustes Cuenta int              */
/*  05/May/2016 T. Baidal   Migracion a CEN                             */
/************************************************************************/
use cobis
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_tplan_tmp')
           drop proc sp_tplan_tmp
go

create proc sp_tplan_tmp
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_rol          smallint = null,
  @s_ofi          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_tbalance     char (3) = null,
  @i_cuenta       int = null,
  @i_secuencial   int = null /* 03/25/2003 Gcastaneda */
)
as
  declare
    @w_return  int,
    @w_sp_name varchar(32),
    @w_estado  estado

  select
    @w_sp_name = 'sp_tplan_tmp'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* ** Insert ** */
  if @i_operacion = 'I'
  begin
    if @t_trn = 1196
    begin
      /*  Verificacion de existencias  */
      select
        @w_estado = tb_estado
      from   cl_tbalance
      where  tb_tbalance = @i_tbalance
         and tb_estado   = 'V'
      if @@rowcount <> 1
      begin
        /*  No existe Tipo de Balance  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101125
        return 1
      end
      if @w_estado <> 'V'
      begin
        /*  Tipo de Balance no esta vigente  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101126
        return 1
      end

      --print 'cuenta %1!', @i_cuenta

      select
        @w_estado = ct_estado
      from   cl_cuenta
      where  ct_cuenta = @i_cuenta
         and ct_estado = 'V'
      if @@rowcount <> 1
      begin
        /*  No existe Cuenta  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101127
        return 1
      end
      if @w_estado <> 'V'
      begin
        /*  Cuenta no esta vigente  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101128
        return 1
      end

      begin tran
      /*  Insercion en la Tabla Temporal  */
      insert into cl_tplan_tmp
                  (tpt_tbalance,tpt_cuenta,tpt_usuario,tpt_terminal,
                   tpt_secuencial
      )
      values      (@i_tbalance,@i_cuenta,@s_user,@s_term,@i_secuencial)
      /* campo adicional @i_secuencial Gcastaneda */
      if @@error <> 0
      begin
        /*  'Error en insercion en Tabla Temporal'  */
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103067
        return 1
      end
      commit tran
      return 0

    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

  end

go

