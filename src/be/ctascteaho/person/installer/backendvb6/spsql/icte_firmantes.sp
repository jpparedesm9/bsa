/****************************************************************************/
/*     Archivo           :    icte_firmantes.sp                             */
/*     Stored procedure  :    sp_icte_firmantes                             */
/*     Base de datos     :    cob_interfase                                 */
/*     Producto          :    Sub-Modulo de Personalizacion                 */
/*     Disenado por      :    Mireya Velastegui                             */
/*     Fecha de escritura:    28 de Junio de 2009                           */
/****************************************************************************/
/*                                           IMPORTANTE                     */
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
/*                                  PROPOSITO                               */
/*     Este programa se encarga de retornan exito o 0 , en ausencia del     */
/*     producto de firmas.                                                  */
/****************************************************************************/
/*                                                      MODIFICACIONES      */
/*       FECHA          AUTOR           RAZON                               */
/*     22/JuL/2009      M.Velastegui    Emision Inicial                     */
/*      02/Mayo/2016   Roxana Sánchez    Migración a CEN                    */
/****************************************************************************/

use cob_interfase
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_icte_firmantes')
  drop proc sp_icte_firmantes
go

create proc sp_icte_firmantes
(
  @s_ssn          int,
  @s_srv          varchar(30),
  @s_lsrv         varchar(30) = null,
  @s_user         varchar(30),
  @s_sesn         int,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_ofi          smallint,
  @s_rol          smallint,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,
  @s_org          char(1),
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint,
  @t_show_version bit = 0,
  @p_lssn         int = null,
  @p_rssn         int = null,
  @i_cuenta       cuenta = null,
  @i_producto     char(3) = null,
  @i_moneda       smallint = null,
  @i_ente         int = null,
  @i_cedula       varchar(20) = null,
  @i_operacion    char(1)
)
as
  declare
    @w_return   int,
    @w_sp_name  varchar(30),
    @w_det_prod int,
    @w_rol      char(1),
    @w_producto tinyint

  select
    @w_sp_name = 'sp_icte_firmantes'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @i_producto = 'AHO'
    select
      @w_producto = 4
  else if @i_producto = 'CTE'
    select
      @w_producto = 3
  else
  begin
    print 'Producto no contemplado'
    return 1
  end

  select
    @w_det_prod = dp_det_producto
  from   cobis..cl_det_producto
  where  dp_cuenta   = @i_cuenta
     and dp_producto = @w_producto
     and dp_moneda   = @i_moneda

  select
    @w_rol = cl_rol
  from   cobis..cl_cliente
  where  cl_det_producto = @w_det_prod
     and cl_cliente      = @i_ente

  if @@rowcount = 0
  begin
    exec cobis..sp_cerror
      @i_num = 301018
    return 1
  end

  exec @w_return = firmas..sp_firmantes
    @s_ssn       = @s_ssn,
    @s_srv       = @s_srv,
    @s_lsrv      = @s_lsrv,
    @s_user      = @s_user,
    @s_sesn      = @s_sesn,
    @s_term      = @s_term,
    @s_date      = @s_date,
    @s_ofi       = @s_ofi,
    @s_rol       = @s_rol,
    @s_org       = @s_org,
    @t_trn       = 3030,
    @i_cuenta    = @i_cuenta,
    @i_producto  = @i_producto,
    @i_moneda    = @i_moneda,
    @i_ente      = @i_ente,
    @i_operacion = @i_operacion,
    @i_rol       = @w_rol

  if @w_return <> 0
      or @@error <> 0
    return @w_return

  return 0

go 
