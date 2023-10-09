/****************************************************************************/
/*     Archivo           : pe_rango_tran.sp                                 */
/*     Stored procedure  : sp_rango_tran                                    */
/*     Base de datos     : cob_remesas                                      */
/*     Producto          : Personalizacion                                  */
/*     Disenado por      :                                                  */
/*     Fecha de escritura: 01-Ene-1994                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad            */
/*  de 'COBISCorp'.                                                         */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como        */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus        */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.       */
/*  Este programa esta protegido por la ley de   derechos de autor          */
/*  y por las    convenciones  internacionales   de  propiedad inte-        */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para     */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir            */
/*  penalmente a los autores de cualquier   infraccion.                     */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*     Este programa inserta/elimina/actualiza/consulta de productos        */
/*     bancarios.                                                           */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*    30/Sep/2003    Gloria Rueda   Retornar c¢digos de error               */
/*    02/Mayo/2016   Roxana Sánchez    Migración a CEN                      */
/****************************************************************************/
use cob_remesas
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_rango_tran')
  drop proc sp_rango_tran
go

create proc sp_rango_tran
(
  @s_ssn          int,
  @s_srv          varchar(30)=null,
  @s_lsrv         varchar(30)=null,
  @s_user         varchar(30)=null,
  @s_sesn         int,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_org          char (1),
  @s_ofi          smallint,
  @s_rol          smallint =1,
  @s_org_err      char(1)=null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,
  @t_debug        char(1)='N',
  @t_file         varchar(14)=null,
  @t_from         varchar(32)=null,
  @t_rty          char(1)='N',
  @t_trn          smallint,
  @t_show_version bit = 0,
  @i_operacion    char (1),
  @i_modo         tinyint,
  @i_producto     tinyint,
  @i_transaccion  smallint
)
as
  declare
    @w_sp_name varchar(32),
    @w_return  int

  select
    @w_sp_name = 'sp_rango_tran'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/**Store Procedure**/' = @w_sp_name,
      s_ssn = @s_ssn,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
      s_user = @s_user,
      s_sesn = @s_sesn,
      s_term = @s_term,
      s_date = @s_date,
      s_org = @s_org,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      s_org_err = @s_org_err,
      s_error = @s_error,
      s_sev = @s_sev,
      s_msg = @s_msg,
      t_debug = @t_debug,
      t_file = @t_file,
      t_from = @t_from,
      t_rty = @t_rty,
      t_trn = @t_trn,
      i_modo = @i_modo,
      i_operacion = @i_operacion,
      i_transaccion = @i_transaccion
    exec cobis..sp_end_debug
  end

/*Operaciones */
  /**BUSQUEDA **/
  if @i_operacion = 'S'
  begin
    set rowcount 15

    if @i_modo = 0
    begin
      select
        'Codigo' = tn_trn_code,
        'Descripcion' = tn_descripcion
      from   cobis..cl_ttransaccion,
             cobis..ad_pro_transaccion
      where  pt_producto = @i_producto
         and tn_trn_code = pt_transaccion
      order  by tn_trn_code

      if @@rowcount = 0
      begin
        /*No existe el dato que se solicito*/
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 351532
        return 351532
      end

    end

    if @i_modo = 1
    begin
      select
        'Codigo' = tn_trn_code,
        'Descripcion' = tn_descripcion
      from   cobis..cl_ttransaccion,
             cobis..ad_pro_transaccion
      where  pt_producto = @i_producto
         and tn_trn_code = pt_transaccion
         and tn_trn_code > @i_transaccion
      order  by tn_trn_code

      if @@rowcount = 0
      begin
        /*No existe el dato que se solicito*/
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 351533
        return 351533
      end

    end

  end

  set rowcount 0
  return 0

go 
