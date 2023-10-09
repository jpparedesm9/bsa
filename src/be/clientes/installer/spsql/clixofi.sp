/************************************************************************/
/*   Archivo:            clixofi.sp                                     */
/*   Stored procedure:   sp_cliente_oficina_count                       */
/*   Base de datos:      cobis                                          */
/*   Producto:           Clientes                                       */
/*   Disenado por:       Euripides Triana T.                            */
/*   Fecha de documentacion: 21-Nov-1995                                */
/************************************************************************/
/*                            IMPORTANTE                                */
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
/*      Selecciona el Total de clientes por cada una de las oficinas    */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*        FECHA          AUTOR               RAZON                      */
/*      21/Nov/1995     E.Triana T.     Emision Inicial                 */
/*      28/Jul/2001     E. Laguna       Adicion calculo Porcentajes     */
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
           where  name = 'sp_cliente_oficina_count')
  drop proc sp_cliente_oficina_count
go

create proc sp_cliente_oficina_count
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
  @i_oficina      smallint = null
)
as
  declare
    @w_sp_name varchar(32),
    @w_total   int

  select
    @w_sp_name = 'sp_cliente_oficina_count'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn = 1275
  begin
    select
      en_oficina,
      total = count(en_ente)
    into   #cl_clientes_oficina_count
    from   cobis..cl_ente
    where  en_oficina    = isnull(@i_oficina,
                                  en_oficina)
       and en_fecha_crea > '01/01/1900'
       and en_filial     = 1
       and en_cliente    = 'S'
    group  by en_oficina

    select
      @w_total = sum(total)
    from   #cl_clientes_oficina_count

    select
      'OFICINA' = (select
                     substring(of_nombre,
                               1,
                               20)
                   from   cobis..cl_oficina
                   where  of_oficina = c.en_oficina),
      'CLIENTES' = total,
      'PORCENTAJES '= convert (char(3), ((total*100) / @w_total )) + '%'
    from   #cl_clientes_oficina_count c
    group  by en_oficina,
              total

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

go

