/************************************************************************/
/*  Archivo:            sumprop.sp                                      */
/*  Stored procedure:   sp_sum_propiedad                                */
/*  Base de datos:      cobis                                           */
/*  Producto:       Clientes                                            */
/*  Disenado por:   Sandra Ortiz                                        */
/*  Fecha de escritura: 22-May-1995                                     */
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
/*  Este stored procedure totaliza los montos de propiedas agrupadas    */
/*  tipo de bien.                                                       */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  22-May-95   S.Ortiz M.  Emision Inicial                             */
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
           where  name = 'sp_sum_propiedad')
           drop proc sp_sum_propiedad
go

create proc sp_sum_propiedad
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_ente         int = null
)
as
  declare @w_sp_name varchar(32)

  select
    @w_sp_name = 'sp_sum_propiedad'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn <> 1273
  begin
    /*  'No corresponde codigo de transaccion' */
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 151051
    return 1
  end

  create table #suma
  (
    tbien  varchar(10),
    total  money,
    moneda tinyint
  )

  insert into #suma
              (tbien,total,moneda)
    select
      pr_tbien,sum(pr_valor),pr_moneda
    from   cl_propiedad
    where  pr_persona = @i_ente
    group  by pr_tbien,
              pr_moneda

  select
    'T.Bien' = substring(valor,
                         1,
                         20),
    'Valor' = total,
    'Moneda' = substring(mo_descripcion,
                         1,
                         15)
  from   #suma,
         cl_moneda,
         cl_catalogo c,
         cl_tabla t
  where  t.tabla   = 'cl_tbien'
     and c.tabla   = t.codigo
     and c.codigo  = tbien
     and mo_moneda = moneda

go

