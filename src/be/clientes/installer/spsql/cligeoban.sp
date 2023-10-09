/************************************************************************/
/*   Archivo:            cligeoban.sp                                   */
/*   Stored procedure:   sp_dgeobanca                                   */
/*   Base de datos:      cobis                                          */
/*   Producto:           Clientes                                       */
/************************************************************************/
/*                  IMPORTANTE                                          */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de 'COBISCorp'.                                                     */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                            PROPOSITO                                 */
/*      Totaliza el numero de Entes por Banca segun el Oficial asignado */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*   FECHA          AUTOR          RAZON                                */
/*      28/Mar/2001     J Anaguano      Emision Inicial                 */
/*      18/Jul/2003     D Duran         Contador registros para funcion */
/*                                      Actualizar_Reg_Proc             */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
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
           where  name = 'sp_dgeobanca')
  drop proc sp_dgeobanca
go

create proc sp_dgeobanca
  @t_show_version bit = 0,
  @o_registros2   int = 0 output
as
  declare
    @w_sp_name       varchar(32),
    @w_ente          int,
    @w_max_ente      int,
    @w_en_ente       int,
    @w_en_banca      catalogo,
    @w_en_oficial    smallint,
    @w_en_oficina    smallint,
    @w_pr_ente       int,
    @w_pr_banca      catalogo,
    @w_pr_oficial    smallint,
    @w_ente_ant      int,
    @w_di_tipo       char(1),
    @w_di_parroquia  smallint,
    @w_di_ciudad     int,
    @w_pv_pais       smallint,
    @w_pv_region_nat char(2),
    @w_pv_region_ope char(3),
    @w_pv_provincia  smallint,
    @w_ci_ciudad     int,
    @w_pq_parroquia  smallint,
    @w_parametro     varchar(10),
    @w_di_zona       catalogo,
    @w_pq_zona       char(3),
    @w_numero        int

  select
    @w_sp_name = 'sp_dgeobanca'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  insert cl_dgeobanca
         (dg_oficial,dg_banca,dg_numero)
    select
      isnull(en_oficial,
             0),isnull(en_banca,
             '0'),count(en_ente)
    from   cl_ente
    group  by en_oficial,
              en_banca

  select
    @o_registros2 = count(*)
  from   cl_dgeobanca
  select
    @o_registros2

  return 0

go

