/************************************************************************/
/*   Archivo             :   hpsucur.sp                                 */
/*   Stored procedure    :   sp_hp_sucursal                             */
/*   Base de datos       :   cob_remesas                                */
/*   Producto            :   Clientes                                   */
/*   Disenado por        :   Mauricio Bayas/Sandra Ortiz                */
/*   Fecha de escritura  :   06-Nov-1992                                */
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
/*                       PROPOSITO                                      */
/*   Este programa procesa las transacciones del stored procedure       */
/*   Query de empleo                                                    */
/************************************************************************/
/*                  MODIFICACIONES                                      */
/*   FECHA          AUTOR          RAZON                                */
/*   06/Nov/92 M. Davila Emision Inicial                                */
/*   15/Ene/93 L. Carvajal    Tabla de errores, variablesde debug       */
/*      30/Sep/2003     Gloria Rueda    Retornar c¢digos de error       */
/*      02/Mayo/2016   Roxana Sánchez    Migración a CEN                */
/************************************************************************/
use cobis
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_hp_sucursal')
  drop proc sp_hp_sucursal
go

create proc sp_hp_sucursal
(
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          int,
  @t_show_version bit = 0,
  @i_tipo         char(1),
  @i_filial       tinyint = null,
  @i_codigo       smallint = null
)
as
  declare @w_sp_name varchar(32)

  select
    @w_sp_name = 'sp_hp_sucursal'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file = @t_file
    select
      '/** Stored Procedure **/ ' = @w_sp_name,
      t_file = @t_file,
      t_from = @t_from,
      i_tipo = @i_tipo,
      i_filial = @i_filial,
      i_codigo = @i_codigo
    exec cobis..sp_end_debug
  end

  if @i_tipo = 'A'
  begin
    if @t_trn != 4079
    begin
      /* Error en el codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    select
      '1881' = of_oficina,
      '1896' = of_nombre
    from   cobis..cl_oficina
    where  of_filial  = @i_filial
       and of_subtipo = 'R'
    order  by of_filial,
              of_oficina
    if @@rowcount = 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101028
      /* 'No existe agencia'*/
      return 101028
    end
    return 0
  end
  if @i_tipo = 'V'
  begin
    if @t_trn != 4078
    begin
      /* Error en el codigo de transaccion */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351516
      return 351516
    end

    select
      of_nombre
    from   cobis..cl_oficina
    where  of_oficina = @i_codigo
       and of_filial  = @i_filial
       and of_subtipo = 'R'
    if @@rowcount = 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101028
      /* 'No existe agencia'*/
      return 101028
    end
  end
go 
