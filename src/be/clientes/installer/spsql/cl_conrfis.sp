/************************************************************************/
/*   Stored procedure:     sp_cons_regfiscal                            */
/*   Base de datos:        cobis                                        */
/************************************************************************/
/*                           IMPORTANTE                                 */
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
/*                            PROPOSITO                                 */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*    FECHA             AUTOR         RAZON                             */
/*    May/02/2016     DFu             Migracion CEN                     */
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
           where  name = 'sp_cons_regfiscal')
  drop proc sp_cons_regfiscal
go

create proc sp_cons_regfiscal
(
  @i_codigo       int,
  @i_rows         int = 0,
  @i_modo         smallint = null,
  @i_operacion    char(1),
  @i_consecutivo  int = 0,
  @t_debug        char(1) = 'N',
  @t_trn          int = null,
  @t_show_version bit = 0,
  @t_file         varchar(10) = null,
  @i_formato      smallint = 101
)
as
  declare
    @w_today   datetime,
    @w_sp_name varchar(64)

  select
    @w_sp_name = 'sp_cons_regfiscal'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @i_operacion = 'Q'
  begin
    if @t_trn = 168
    begin
      set rowcount 20

      if @i_modo = 0
      begin
        select
          'SECUENCIAL' = lf_secuencial,
          'OFICINA' = en_oficina,
          'ENTE' = lf_ente,
          'NOMBRE' = en_nomlar,
          'FECHA' = convert(varchar(10), lf_fecha_modifica, @i_formato),
          'REGIMEN FISCAL ANTERIOR' = lf_regimenf_ant,
          'REGIMEN FISCAL NUEVO' = lf_regimenf_nue,
          'USUARIO' = lf_usuario,
          'TERMINAL' = lf_terminal,
          'SUJETO DE RTE FTE (SI/NO)' = en_retencion,
          'GRAN CONTRIBUYENTE (SI/NO)' = en_gran_contribuyente
        from   cl_log_fiscal,
               cl_ente
        where  lf_ente = @i_codigo
           and en_ente = lf_ente
        order  by lf_secuencial

      end

      else
      begin
        if @i_modo = 1
        begin
          select
            'SECUENCIAL' = lf_secuencial,
            'OFICINA' = en_oficina,
            'ENTE' = lf_ente,
            'NOMBRE' = en_nomlar,
            'FECHA' = convert(varchar(10), lf_fecha_modifica, @i_formato),
            'REGIMEN FISCAL ANTERIOR' = lf_regimenf_ant,
            'REGIMEN FISCAL NUEVO' = lf_regimenf_nue,
            'USUARIO' = lf_usuario,
            'TERMINAL' = lf_terminal,
            'SUJETO DE RTE FTE (SI/NO)' = en_retencion,
            'GRAN CONTRIBUYENTE (SI/NO)' = en_gran_contribuyente
          from   cl_log_fiscal,
                 cl_ente
          where  lf_ente       = @i_codigo
             and en_ente       = lf_ente
             and lf_secuencial > @i_consecutivo
          order  by lf_secuencial

        end

      end

      set rowcount 0

      return 0

    end

    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 15100033 --Error al consultar datos en cl_log_fiscal

      return 1

    end

  end

  return 0

go

