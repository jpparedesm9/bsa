/************************************************************************/
/*  Archivo:            upddatos.sp                                     */
/*  Stored procedure:   sp_actualiza_datos                              */
/*  Base de datos:      cobis                                           */
/*  Producto:       Clientes                                            */
/*  Disenado por:   Jaime Loyo H.  CORFINSURA.                          */
/*  Fecha de escritura: 17-Dic-1999                                     */
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
/*                        PROPOSITO                                     */
/*  Esta Stored procedure actualiza  los datos  de  tipo y  numero      */
/*  del documento y el nombre del ente, en todos los demas modulos      */
/*  para mantener la integridad referencial                             */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*    FECHA           AUTOR            RAZON                            */
/*  17/Dic/99   Jaime Loyo        Emision Inicial. CORFINSURA.          */
/*  01/Abr/03   D. Duran      Comento Update Comercio Exterior          */
/*  05/May/2016 T. Baidal   Migracion a CEN                             */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_actualiza_datos')
           drop proc sp_actualiza_datos
go

create proc sp_actualiza_datos
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @s_rol          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,

  /**     @t_trn          smallint    = null,**/
  @t_show_version bit = 0,
  @i_ente         int = null,
  @i_subtipo      char(2) = null,
  @i_tipo_cli     char(1) = null,
  @i_nomlar       varchar(64) = null,
  @i_ced_ruc      numero = null
)
as
  declare
    @w_today   datetime,
    @w_sp_name varchar(32)

  select
    @w_sp_name = 'sp_actualiza_datos'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_today = @s_date

  /***************** Actualizacion en Contabilidad ********************/
  update cob_conta..cb_retencion
  set    re_tipo = @i_subtipo,
         re_identifica = @i_ced_ruc
  where  re_ente = @i_ente

  if @@error <> 0
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 105026
    /* 'Error en actualizacion de persona'*/
    return 1
  end

  /***************** Actualizacion en Cartera ********************/
  update cob_cartera..ca_operacion
  set    op_nombre = @i_nomlar
  where  op_cliente = @i_ente

  if @@error <> 0
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 105026
    /* 'Error en actualizacion de persona'*/
    return 1
  end
  /***************** Actualizacion en Custodia ********************/
  update cob_custodia..cu_cliente_garantia
  set    cg_nombre = @i_nomlar
  where  cg_ente = @i_ente

  if @@error <> 0
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 105026
    /* 'Error en actualizacion de persona'*/
    return 1
  end

  update cob_custodia..cu_custodia
  set    cu_propietario = @i_nomlar
  where  cu_garante = @i_ente

  if @@error <> 0
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 105026
    /* 'Error en actualizacion de persona'*/
    return 1
  end

  /*
     /*  DDU 01/ABRIL/03 */
  
      /***************** Actualizacion en Comercio Exterior *****************/
      update  cob_comext..ce_operacion
      set     op_ced_ruc  = @i_ced_ruc
      where   op_ordenante    = @i_ente
  
      if @@error <> 0
      begin
          exec sp_cerror  @t_debug    = @t_debug,
                  @t_file     = @t_file,
                  @t_from     = @w_sp_name,
                  @i_num      = 105026
          /* 'Error en actualizacion de persona'*/
          return 1
      end
  
      */

  return 0

go

