/************************************************************************/
/*  Archivo:                entxofi.sp                                  */
/*  Stored procedure:       sp_ente_oficina_count                       */
/*  Base de datos:          cobis                                       */
/*  Producto:               Clientes                                    */
/*  Disenado por:           Carlos Rodriguez Victorero                  */
/*  Fecha de documentacion: 02-Nov-1995                                 */
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
/*  Selecciona la ciudad y el numero de entes por oficina del banco     */
/*  de la vista cl_cliente_ciud                                         */
/*  NOTA: No hay control de select de 20 en 20. el control debe         */
/*        ser administrativo                                            */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA           AUTOR           RAZON                               */
/*  04/Jul/1996    A. Ramirez       Cambio Entes por Prospectos CEPP    */
/*  24/Jun/2004    E. Laguna        Tunnig                              */
/*  04/May/2016    T. Baidal        Migracion a CEN                     */
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
           where  name = 'sp_ente_oficina_count') 
           drop proc sp_ente_oficina_count
go

create proc sp_ente_oficina_count
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
    @w_sp_name = 'sp_ente_oficina_count'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn = 1274
  begin
    select
      en_oficina,
      'total' = count(en_ente)
    into   #cl_ente_oficina_count
    from   cobis..cl_ente
    where  en_oficina    = isnull(@i_oficina,
                                  en_oficina)
       and en_fecha_crea > '01/01/1900'
       and en_filial     = 1
       and en_cliente is null
    group  by en_oficina

    select
      @w_total = sum(total)
    from   #cl_ente_oficina_count

    select
      'OFICINA' = (select
                     substring(of_nombre,
                               1,
                               20)
                   from   cobis..cl_oficina
                   where  of_oficina = c.en_oficina),
      'PROSPECTOS' = total,
      'PORCENTAJES '= convert (char(3), ((total*100) / @w_total )) + '%'
    from   #cl_ente_oficina_count c
    group  by c.en_oficina,
              total
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
  return 0

go

