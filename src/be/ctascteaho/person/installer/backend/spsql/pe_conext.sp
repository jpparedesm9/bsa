/****************************************************************************/
/*     Archivo:          pe_conext.sp                                       */
/*     Stored procedure: sp_control_manejo_extracto                         */
/*     Base de datos:    cob_remesas                                        */
/*     Producto:         Personalizacion                                    */
/*     Disenado por:     S.Molano                                           */
/*     Fecha de escritura: 27-Sep-2011                                      */
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
/*     Este programa inserta/elimina/actualiza/control manejo de            */
/*     extractos                                                            */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*    FECHA          AUTOR          RAZON                                   */
/*    Sep/2011       S.Molano       Emision Inicial                         */
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
           where  name = 'sp_control_manejo_extracto')
  drop proc sp_control_manejo_extracto

go

create proc sp_control_manejo_extracto
(
  @s_ssn          int = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_user         varchar(30) = null,
  @s_sesn         int = null,
  @s_term         varchar(10) = null,
  @s_date         datetime = null,
  @s_org          char (1) = null,
  @s_ofi          smallint = null,
  @s_rol          smallint = 1,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_rty          char(1) = 'N',
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_modo         tinyint = null,
  @i_cta          varchar(16) = null,
  @i_mes          smallint = null,
  @i_ano          smallint = null,
  @i_opcion       char(1) = null,
  @i_frontend     char(1) = 'N',
  @i_escliente    char(1) = 'N',
  @o_pro_final    smallint = null out
)
as
  declare
    @w_sp_name       varchar(32),
    @w_return        int,
    @w_pro_final     smallint,
    @w_fecha_proceso datetime,
    @w_cant          smallint,
    @w_desde         smallint,
    @w_hasta         smallint,
    @w_anos          smallint,
    @w_cont          smallint,
    @w_producto      smallint,
    @w_prod_banc     smallint,
    @w_sucursal      smallint,
    @w_oficina       smallint,
    @w_mercado       smallint,
    @w_prodfinal     smallint,
    @w_valor         int,
    @w_cumple        char(1),
    @w_tipocta       char(1),
    @w_categoria     char(1),
    @w_conext        tinyint

  select
    @w_sp_name = 'sp_control_manejo_extracto'
  truncate table cob_ahorros..ah_ano

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_fecha_proceso = fp_fecha
  from   cobis..ba_fecha_proceso

  if @i_opcion = 'Q'
  begin
    select
      @w_conext = pa_tinyint
    from   cobis..cl_parametro
    where  pa_nemonico = 'COEX'

    select
      @w_conext
  end

  if @i_opcion = 'S'
  begin
    if exists (select
                 1
               from   re_his_extracto with (nolock)
               where  he_cta_banco = @i_cta
                  and he_mes       = @i_mes
                  and he_ano       = @i_ano)
    begin
      if @i_escliente = 'S'
      begin
        update re_his_extracto with (rowlock)
        set    he_cont = he_cont + 1
        where  he_cta_banco = @i_cta
           and he_mes       = @i_mes
           and he_ano       = @i_ano

        if @@error <> 0
        begin
          exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 357531
          return 357531
        end
      end

      insert into re_tran_servicio
                  (ts_secuencial,ts_tipo_transaccion,ts_tsfecha,ts_terminal,
                   ts_oficina,
                   ts_login,ts_char1,ts_varchar5,ts_tinyint1,ts_smallint1,
                   ts_char2,ts_varchar6,ts_varchar7,ts_smallint2)
      values      ( @s_ssn,@t_trn,getdate(),@s_term,@s_ofi,
                    @s_user,'C',@i_cta,@i_mes,@i_ano,
                    @i_escliente,@s_srv,@s_lsrv,@s_rol)

      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 353515
        return 353515
      end

    end
    else
    begin
      --Insertar un nuevo producto
      insert into re_his_extracto with (rowlock)
                  (he_producto,he_cta_banco,he_mes,he_ano,he_cont,
                   he_fecha)
      values      ( substring(@i_cta,
                              5,
                              2),@i_cta,@i_mes,@i_ano,isnull(@w_cont, 0) + 1,
                    @w_fecha_proceso)

      /*Ocurrio un error en la insercion de producto final*/
      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 353506
        return 353506
      end

      insert into re_tran_servicio
                  (ts_secuencial,ts_tipo_transaccion,ts_tsfecha,ts_terminal,
                   ts_oficina,
                   ts_login,ts_char1,ts_varchar5,ts_tinyint1,ts_smallint1,
                   ts_char2,ts_varchar6,ts_varchar7,ts_smallint2)
      values      ( @s_ssn,@t_trn,getdate(),@s_term,@s_ofi,
                    @s_user,'C',@i_cta,@i_mes,@i_ano,
                    @i_escliente,@s_srv,@s_lsrv,@s_rol)

      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 353515
        return 353515
      end
    end

    if @i_frontend = 'S'
    begin
      select
        @w_producto = ah_producto,
        @w_prod_banc = ah_prod_banc,
        @w_oficina = ah_oficina,
        @w_tipocta = ah_tipocta,
        @w_categoria = ah_categoria
      from   cob_ahorros..ah_cuenta
      where  ah_cta_banco = @i_cta

      select
        @w_sucursal = of_regional
      from   cobis..cl_oficina
      where  of_oficina = @w_oficina

      select
        @w_mercado = me_mercado
      from   pe_mercado
      where  me_pro_bancario = @w_prod_banc
         and me_tipo_ente    = @w_tipocta

      select
        @w_prodfinal = pf_pro_final
      from   pe_pro_final
      where  pf_sucursal = @w_sucursal
         and pf_mercado  = @w_mercado
         and pf_producto = @w_producto

      --print 're_parametro_extracto'  + cast(@w_producto as varchar(3)) + cast(@w_prodfinal as varchar(3)) + cast(@w_categoria as char(2))
      select
        @w_valor = pe_valor
      from   cob_remesas..re_parametro_extracto
      where  pe_producto  = @w_producto
         and pe_prodbanc  = @w_prodfinal
         and pe_categoria = @w_categoria

      --print '@w_valor ' + convert(varchar(5),@w_valor)

      select
        @w_cant = he_cont
      from   re_his_extracto with (nolock)
      where  he_cta_banco = @i_cta
         and he_mes       = @i_mes
         and he_ano       = @i_ano

      --print '@w_cant ' + convert(varchar(5),@w_cant)

      select
        @w_cumple = 'N'

      if @w_cant >= @w_valor
        select
          @w_cumple = 'S'

      select
        @w_cumple
    end
  end

  return 0

GO 
