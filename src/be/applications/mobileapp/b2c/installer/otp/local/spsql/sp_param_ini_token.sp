/************************************************************************/
/*      Archivo:                sp_param_ini_token.sp                   */
/*      Stored procedure:       sp_param_ini_token                      */
/************************************************************************/
/*      Base de datos:          cob_bvirtual                            */
/*      Producto:               OTP                                     */
/*      Disenado por:           Galo Quisiguiña                         */
/*      Fecha de escritura:     28/01/2017                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Consulta parametro de longitud y duracion de token              */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR             RAZON                         */
/*      28/01/2017      Galo Quisiguiña   Emisión Inicial               */
/************************************************************************/

use cob_bvirtual
go

if exists (select 1 from sysobjects where name = 'sp_param_ini_token')
        drop proc sp_param_ini_token
go

Create Procedure sp_param_ini_token(
  @t_show_version bit              = 0,
  @s_user         login            =null,
  @s_date         datetime         =null,
  @s_srv          varchar(30)      =null,
  @s_ofi          smallint         =null,
  @s_term         varchar(30)      =null,
  @i_operacion    char(1)          =null,
  @i_producto     varchar(10)      =null,
  @i_nemonico     varchar(10)      =null,
  @s_culture      varchar(10)      ='NEUTRAL',
  @o_horario_ivr  char(1)          =null output
)
As

declare
  @w_hora_hoy   smallint,
  @w_hora_ini   smallint,
  @w_hora_fin   smallint ,
  @w_dia        varchar(30),
  @w_ciudad_matriz int,
  @w_sp_name    varchar(64)

select @w_sp_name = 'sp_param_ini_token'
-- Mostrar la version del programa
if @t_show_version = 1
begin
   print 'Stored procedure = ' + @w_sp_name + ' 4.0.0.0'
   return 0
end

---- INTERNACIONALIZACION ----
EXEC cobis..sp_ad_establece_cultura
    @o_culture = @s_culture OUT
------------------------------


if @i_operacion = 'V'
begin
   IF ( @i_nemonico = 'BVMAIL'
        AND @i_producto = 'BVI' )
      BEGIN
         SELECT 'PARAMETRO'=@i_nemonico,
               'VALOR'=re_valor
         FROM cobis..bv_correo_soporte_i18n
         WHERE pc_codigo='S'
           and re_cultura=@s_culture
      END
   ELSE
      select 'PARAMETRO' = pa_parametro,
             'VALOR' = case pa_tipo
                        when 'T' then convert(varchar, pa_tinyint)
                        when 'S' then convert(varchar, pa_smallint)
                        when 'I' then convert(varchar, pa_int)
                        when 'C' then pa_char
                        when 'M' then convert(varchar, pa_money)
                        when 'F' then convert(varchar, pa_float)
                        when 'D' then convert(varchar(10), pa_datetime, 101)
                      end
      from cobis..cl_parametro
      where pa_producto = @i_producto
        and pa_nemonico = @i_nemonico
end

return 0


go