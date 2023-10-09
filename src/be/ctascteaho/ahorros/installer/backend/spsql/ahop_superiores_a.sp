/************************************************************************/
/*  Archivo:                ahopesup.sp                                 */
/*  Stored procedure:       sp_aho_superiores_a                         */
/*  Base de datos:          cob_Ahorros                                 */
/*  Producto:               Cuentas de Ahorros                          */
/*  Disenado por:           George George                               */
/*  Fecha de escritura:     21-Sep-1998                                 */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                              PROPOSITO                               */
/*  Este programa procesa la transaccion de:                            */
/*  Consulta de Operaciones Superiores a un monto                       */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA           AUTOR           RAZON                               */
/*  21/Sep/1998     G. George       Emision Inicial                     */
/*  06/Jun/2002     A. Pazmiño      Personalización Agro Mercantil      */
/*  05/Mar/2010     C. Munoz        agrega parametros zona/territorial  */
/*  02/May/2016     J. Calderon      Migración a CEN                    */
/************************************************************************/

use cob_ahorros
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ahop_superiores_a')
  drop proc sp_ahop_superiores_a
go

create proc sp_ahop_superiores_a
(
  @s_ssn          int = null,
  @s_ssn_branch   int = null,
  @s_srv          varchar(30) = null,
  @s_user         login = null,
  @s_sesn         int = null,
  @s_term         varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_date         datetime = null,
  @s_ofi          smallint = null,/* Localidad origen transaccion */
  @s_rol          smallint = null,
  @s_sev          tinyint = null,
  @s_org_err      char(1) = null,
  @s_org          char(1) = null,
  @s_error        int = null,
  @s_msg          descripcion = null,
  @t_show_version bit = 0,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_trn          int = null,
  @i_monto        money,
  @i_modo         tinyint,
  @i_moneda       tinyint,
  @i_secuencial   int = null,
  @i_cod_alterno  int = null,
  @i_oficina      smallint =null,
  @i_turno        smallint = null,
  @i_zona         int = null,
  @i_territorial  int = null
)
as
  declare
    @w_return   int,
    @w_sp_name  varchar(30),
    @w_monto    money,
    @w_hora_ini datetime

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ahop_superiores_a'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  /*  Modo de debug  */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/**  Stored Procedure  **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_srv = @s_srv,
      s_user = @s_user,
      s_sesn = @s_sesn,
      s_term = @s_term,
      s_date = @s_date,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      s_sev = @s_sev,
      t_debug = @t_debug,
      t_from = @t_from,
      t_file = @t_file,
      s_ori = @s_org,
      t_trn = @t_trn,
      i_monto = @i_monto,
      i_modo = @i_modo,
      i_secuencial = @i_secuencial,
      i_cod_alterno = @i_cod_alterno
    exec cobis..sp_end_debug
  end

  if @t_trn <> 302
  begin
    /* Error en codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201048
    return 1
  end

  /* Buscar el monto promedio de las transacciones, para seleccionar el indice mas eficiente */
  select
    @w_monto = pa_money
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'VPSA'

  if @@rowcount <> 1
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201196
    return 201196
  end

  /* Tomar el tiempo de la consulta */
  select
    @w_hora_ini = getdate()

  if @i_turno is null
    select
      @i_turno = @s_rol

  /* Query que entrega los resultados */

  if @i_modo = 0
  begin
    set rowcount 20

    /* Se determino que con montos mayores al promedio del valor de las transacciones es mas optimo
       utilizar el indice (tm_moneda, tm_valor, tm_estado, tm_secuencial, tm_cod_alterno) y para
       montos menores (tm_secuencial, tm_cod_alterno) */
    if @i_monto >= @w_monto
    begin
      select
        'No. CUENTA' = tm_cta_banco,
        'NOMBRE' = substring (ah_nombre,
                              1,
                              30),
        'DESC. PB' = substring (pb_descripcion,
                                1,
                                15),
        'TRAN.' = tm_tipo_tran,
        'CAUSA' = tm_causa,
        'SIGNO' = tm_signo,
        'MONTO' = tm_valor,
        'OFICINA' = substring (of_nombre,
                               1,
                               25),
        'USUARIO' = tm_usuario,
        'HORA' = convert(varchar(5), tm_hora, 108),
        'SEC' = tm_secuencial,
        'SEC ALT' = tm_cod_alterno
      from   cob_ahorros..ah_tran_monet,--(INDEX ah_tran_monet_valor),
             cob_ahorros..ah_cuenta,
             cobis..cl_oficina,
             cob_remesas..pe_pro_bancario
      where  tm_moneda             = @i_moneda
         and tm_valor              >= @i_monto
         and isnull(tm_estado,
                    '*') <> 'R'
         and tm_secuencial         >= -2147483648
         -- and tm_cod_alterno >= 0
         and (tm_oficina            = @i_oficina
               or @i_oficina is null)
         and ah_cta_banco          = tm_cta_banco
         and of_oficina            = tm_oficina
         and pb_pro_bancario       = tm_prod_banc
         --INI CMU REQ 023 BPT 05/03/2010
         and (of_zona               = @i_zona
               or @i_zona is null)
         and (of_regional           = @i_territorial
               or @i_territorial is null)
      --FIN CMU REQ 023 BPT 05/03/2010
      order  by tm_secuencial,
                tm_cod_alterno

    end
    else
    begin
      select
        'No. CUENTA' = tm_cta_banco,
        'NOMBRE' = substring (ah_nombre,
                              1,
                              30),
        'DESC. PB' = substring (pb_descripcion,
                                1,
                                15),
        'TRAN.' = tm_tipo_tran,
        'CAUSA' = tm_causa,
        'SIGNO' = tm_signo,
        'MONTO' = tm_valor,
        'OFICINA' = substring (of_nombre,
                               1,
                               25),
        'USUARIO' = tm_usuario,
        'HORA' = convert(varchar(5), tm_hora, 108),
        'SEC' = tm_secuencial,
        'SEC ALT' = tm_cod_alterno
      from   cob_ahorros..ah_tran_monet,--(INDEX ah_tran_monet_sec),
             cob_ahorros..ah_cuenta,
             cobis..cl_oficina,
             cob_remesas..pe_pro_bancario
      where  tm_moneda             = @i_moneda
         and tm_valor              >= @i_monto
         and isnull(tm_estado,
                    '*') <> 'R'
         and tm_secuencial         >= -2147483648
         -- and tm_cod_alterno >= 0
         and (tm_oficina            = @i_oficina
               or @i_oficina is null)
         and ah_cta_banco          = tm_cta_banco
         and of_oficina            = tm_oficina
         and pb_pro_bancario       = tm_prod_banc
         --INI CMU REQ 023 BPT 05/03/2010
         and (of_zona               = @i_zona
               or @i_zona is null)
         and (of_regional           = @i_territorial
               or @i_territorial is null)
      --FIN CMU REQ 023 BPT 05/03/2010
      order  by tm_secuencial,
                tm_cod_alterno

    end

    set rowcount 0

  end
  else /* El @i_modo = 1 */
  begin
    set rowcount 21

    /* Se determino que con montos mayores al promedio del valor de las transacciones es mas optimo
       utilizar el indice (tm_moneda, tm_valor, tm_estado, tm_secuencial, tm_cod_alterno) y para
       montos menores (tm_secuencial, tm_cod_alterno) */
    if @i_monto >= @w_monto
    begin
      select
        'No. CUENTA' = tm_cta_banco,
        'NOMBRE' = substring (ah_nombre,
                              1,
                              30),
        'DESC. PB' = substring (pb_descripcion,
                                1,
                                15),
        'TRAN.' = tm_tipo_tran,
        'CAUSA' = tm_causa,
        'SIGNO' = tm_signo,
        'MONTO' = tm_valor,
        'OFICINA' = substring (of_nombre,
                               1,
                               25),
        'USUARIO' = tm_usuario,
        'HORA' = convert(varchar(5), tm_hora, 108),
        'SEC' = tm_secuencial,
        'SEC ALT' = tm_cod_alterno
      from   cob_ahorros..ah_tran_monet,--(INDEX ah_tran_monet_valor),
             cob_ahorros..ah_cuenta,
             cobis..cl_oficina,
             cob_remesas..pe_pro_bancario
      where  tm_moneda             = @i_moneda
         and tm_valor              >= @i_monto
         and isnull(tm_estado,
                    '*') <> 'R'
         /*     and ((tm_secuencial = @i_secuencial and tm_cod_alterno > @i_cod_alterno)
                   or tm_secuencial > @i_secuencial)*/
         --PUEDEN VENIR REGISTROS DUPLICADO, EL FE LOS ELIMINA
         and tm_secuencial         >= @i_secuencial
         and tm_cod_alterno        >= 0--@i_cod_alterno
         and (tm_oficina            = @i_oficina
               or @i_oficina is null)
         and ah_cta_banco          = tm_cta_banco
         and of_oficina            = tm_oficina
         and pb_pro_bancario       = ah_prod_banc
         --INI CMU REQ 023 BPT 05/03/2010
         and (of_zona               = @i_zona
               or @i_zona is null)
         and (of_regional           = @i_territorial
               or @i_territorial is null)
      --FIN CMU REQ 023 BPT 05/03/2010
      order  by tm_secuencial,
                tm_cod_alterno

    end
    else
    begin
      select
        'No. CUENTA' = tm_cta_banco,
        'NOMBRE' = substring (ah_nombre,
                              1,
                              30),
        'DESC. PB' = substring (pb_descripcion,
                                1,
                                15),
        'TRAN.' = tm_tipo_tran,
        'CAUSA' = tm_causa,
        'SIGNO' = tm_signo,
        'MONTO' = tm_valor,
        'OFICINA' = substring (of_nombre,
                               1,
                               25),
        'USUARIO' = tm_usuario,
        'HORA' = convert(varchar(5), tm_hora, 108),
        'SEC' = tm_secuencial,
        'SEC ALT' = tm_cod_alterno
      from   cob_ahorros..ah_tran_monet,-- (INDEX ah_tran_monet_sec),
             cob_ahorros..ah_cuenta,
             cobis..cl_oficina,
             cob_remesas..pe_pro_bancario
      where  tm_moneda             = @i_moneda
         and tm_valor              >= @i_monto
         and isnull(tm_estado,
                    '*') <> 'R'
         /*     and ((tm_secuencial = @i_secuencial and tm_cod_alterno > @i_cod_alterno)
                   or tm_secuencial > @i_secuencial)*/
         --PUEDEN VENIR REGISTROS DUPLICADO, EL FE LOS ELIMINA
         and tm_secuencial         >= @i_secuencial
         and tm_cod_alterno        >= 0--@i_cod_alterno
         and (tm_oficina            = @i_oficina
               or @i_oficina is null)
         and ah_cta_banco          = tm_cta_banco
         and of_oficina            = tm_oficina
         and pb_pro_bancario       = ah_prod_banc
         --INI CMU REQ 023 BPT 05/03/2010
         and (of_zona               = @i_zona
               or @i_zona is null)
         and (of_regional           = @i_territorial
               or @i_territorial is null)
      --FIN CMU REQ 023 BPT 05/03/2010
      order  by tm_secuencial,
                tm_cod_alterno

    end

    set rowcount 0

  end

  /* Grabar transaccion de servicio */
  insert into cob_ahorros..ah_tran_servicio
              (ts_secuencial,ts_ssn_branch,ts_tipo_transaccion,ts_tsfecha,
               ts_usuario,
               ts_terminal,ts_oficina,ts_origen,ts_monto,ts_endoso,
               ts_numero,ts_turno)
  values      (@s_ssn,@s_ssn_branch,@t_trn,@s_date,@s_user,
               @s_term,@s_ofi,@s_org,@i_monto,@i_modo,
               datediff (ss,
                         @w_hora_ini,
                         getdate()),@i_turno)

  if @@error <> 0
  begin
    /* Error en creacion de transaccion de servicio */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 203005

    return 1
  end

  return 0

go

