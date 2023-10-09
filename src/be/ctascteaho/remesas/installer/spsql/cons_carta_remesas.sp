/****************************************************************************/
/*     Archivo:     cons_carta_remesas.sp                                   */
/*     Stored procedure: sp_cons_carta_remesas                              */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:    Jorge Baque                                         */
/*     Fecha de escritura: 13/May/2016                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*                                                                          */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     13/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_cons_carta_remesas')
  drop proc sp_cons_carta_remesas
go

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_cons_carta_remesas (
    @s_ssn          int,
    @s_srv          varchar(30),
    @s_lsrv         varchar(30),
    @s_user         varchar(30),
    @s_sesn         int=null,
    @s_term         varchar(10),
    @s_date         smalldatetime,
    @s_ofi          smallint,   /* Localidad origen transaccion */
    @s_rol          smallint,
    @s_org_err      char(1) = null, /* Origen de error: [A], [S] */
    @s_error        int = null,
    @s_sev          tinyint = null,
    @s_msg          mensaje = null,
    @s_org          char(1),
    @t_corr         char(1) = 'N',
    @t_ssn_corr     int = null, /* Trans a ser reversada */
    @t_debug        char(1) = 'N',
    @t_file         varchar(14) = null,
    @t_from         varchar(32) = null,
    @t_rty          char(1) = 'N',
    @t_trn          smallint,
    @p_lssn         int = null,
    @p_rssn         int = null,
    @p_rssn_corr    int = null,
    @p_envio        char(1) = 'N',
    @p_rpta         char(1) = 'N',
    @i_tipo         char(1),
    @i_mon          tinyint,
    @i_carta        smallint = null,
    @i_oficina      smallint,
    @i_nref         int = null,
    @i_fecha        datetime = null
)
as
declare @w_return   int,
    @w_sp_name      varchar(30),
    @w_codigo       smallint,
    @w_bco_c        smallint,
    @w_ciudad       int,
    @w_fecha        smalldatetime,
    @w_codbco       tinyint
        
/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_cons_carta_remesas'

/* Chequeo de errores generados remotamente */
if @s_org_err is not null           /*  Error del Sistema  */
begin
   exec cobis..sp_cerror
   @t_from         = @w_sp_name,
   @i_num          = @s_error,
   @i_sev          = @s_sev,
   @i_msg          = @s_msg
   return 1
end

if  @t_trn != 602
begin
  /* Error en codigo de transaccion */
   exec cobis..sp_cerror
   @t_debug     = @t_debug,
   @t_file      = @t_file,
   @t_from      = @w_sp_name,
   @i_num       = 201048
   return 1
end


if @i_fecha is null
   select @w_fecha = @s_date
else
   select @w_fecha = @i_fecha

--Codigo propio de compensacion
select @w_codbco = pa_tinyint
from   cobis..cl_parametro 
where  pa_nemonico = 'CBCO' 
and    pa_producto = 'CTE'

if @@rowcount <> 1
begin
   exec cobis..sp_cerror
   @t_from         = @w_sp_name,
   @i_num          = 201196
   return 201196
end

-- Determinar la ciudad de la oficina
select @w_ciudad = of_ciudad
from   cobis..cl_oficina
where  of_oficina = @s_ofi

if @i_tipo = 'C' 
begin
   set rowcount 20

   select 
   'No.CARTA'     = ct_carta,
   'VALOR'        = ct_valor,
   'CORRESPONSAL' = b1.ba_descripcion,
   'COD CORRESP'  = right(('000' + convert(varchar(3),ct_banco_c)),3)
                  + right(('0000' + convert(varchar(4),ct_oficina_c)),4)
                  + right(('0000' + convert(varchar(4),ct_ciudad_c)),4),
   'EMISOR'       = b3.ba_descripcion,
   'COD EMISOR'   = right(('000' + convert(varchar(3),ct_banco_e)),3)
                  + right(('0000' + convert(varchar(4),ct_oficina_e)),4)
                  + right(('0000' + convert(varchar(4),ct_ciudad_e)),4),
   'No.CHEQUES'   = ct_num_cheques,
   'DESTINO'      = ci_descripcion + '-' + convert(char(5),ct_oficina_c),
   'TIPO REMESA'  = ct_tipo_rem
   from   cob_remesas..re_carta,
          cob_remesas..re_banco b1,
          cob_remesas..re_banco b3,
          cobis..cl_ciudad
   where  ct_carta      > @i_carta    
   and    ct_moneda      = @i_mon
   and    ct_oficina     = @i_oficina
   and    b1.ba_banco    = ct_banco_c
   and    b3.ba_banco    = ct_banco_e
   and    ct_fecha_emi   = @w_fecha    
   --and    ct_oficina     = @i_oficina 
   and    ci_cod_remesas = ct_ciudad_c
   
   if @@rowcount = 0 
   begin
      exec cobis..sp_cerror
      @t_from         = @w_sp_name,
      @i_num          = 351092
      return 351092
   end

   set rowcount 0
end 

if @i_tipo = 'D' /* Detalle de los cheques */
begin
   select @w_bco_c = ct_banco_c
   from cob_remesas..re_carta
   where ct_carta = @i_carta

   set rowcount 20
   /* Envio de los cheques de la Carta */
   select  
   'CTA GIRADA' = dc_cta_girada,
   'CTA DEPOS'  = substring(dc_cta_depositada,1,13),
   'CHEQUE'     = dc_num_cheque,
   'VALOR'      = dc_valor,
   'No.REM'     = dc_cheque,
   'BANCO GIR.' = dc_banco_p,
   'DESC. BCO.' = substring(ba_descripcion,1,25),
   'CIUDAD GIR' = dc_ciudad_p,
   'DESC. CIUD' = substring(ci_descripcion,1,17),
   'DEPARTAMENTO' = pv_descripcion,
   'ESTADO'     = dc_status
   from  cob_remesas..re_det_carta,
         cob_remesas..re_banco,
         cobis..cl_ciudad,
         cobis..cl_provincia
   where dc_fecha_emi   <= @w_fecha
   and   dc_moneda      = @i_mon
   and   dc_carta       = @i_carta
   and   dc_cheque      > @i_nref 
   and   ba_banco       = dc_banco_p
   and   ci_cod_remesas = dc_ciudad_p
   and   pv_provincia   = ci_provincia
   and  (@w_bco_c       = @w_codbco or (@w_bco_c <> @w_codbco and dc_status <> 'B'))
   order by dc_cheque
   set rowcount 0
end
return 0


GO


