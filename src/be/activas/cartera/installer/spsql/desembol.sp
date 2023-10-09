/************************************************************************/
/*   Archivo             :       desembol.sp                            */
/*   Stored procedure    :       sp_desembolso                          */
/*   Base de datos       :       cob_cartera                            */
/*   Producto            :       Cartera                                */
/*   Disenado por        :       Fabian de la Torre                     */
/*   Fecha de escritura  :       Jul 95                                 */
/************************************************************************/
/*                                IMPORTANTE                            */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                                 PROPOSITO                            */
/*   Este programa da mantenimiento a la tabla de desembolsos de        */
/*   una operacion de Cartera.                                          */
/*   I: Insercion del desembolso                                        */
/*   D: Eliminacion del desembolso                                      */
/*   S: Search del desembolso                                           */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*     XSA (GRUPO CONTEXT)      07/May/1999    Convertir los datos Money*/
/*                                             que se envian al frontend*/
/*                                             a Float para que muestre */
/*                                             todos los decimales      */
/*     RBU (GRUPO CONTEXT)      26/Jul/1999    cambiar a cotizacion     */
/*                                             unica TRM                */
/*     E. Pelaez                07/Feb/2001    Interfaz ACH             */
/*     E. Laguna                14/Ene/2002    Cheques Propios          */
/*     E. Laguna                28/Ene/2002    Fecha desembolso         */
/*     E. Laguna                18/Feb/2002    Desarrollo ACH- ELA ACH  */
/*     Elcira PElaez            18/feb/2004    EPB:18FEB2004            */
/*     Fabian Quintero          Mar-2006       defecto 6156 Op. FNG UVR */
/*     Elcira PElaez            04/May/2006    DEF:6433                 */
/*     Elcira PElaez            07/Jul/2006    NR-296                   */
/*     Elcira PElaez            20/Nov/2006    NR-175 Bancamia          */
/*     Johan Ardila             16/Dic/2010    REQ 197 - USAID FAG      */
/*     Luis Guzman              30/Jul/2013     Req. 366 Seguros        */
/*     Elcira PElaez            09/Jul/2014     ORS 866 BAncamia        */
/*     Luis Carlos Moreno       05/Nov/2014    CCA 436 Normalizacion    */
/*     Luis C. Moreno           02/Ene/2015    CCA 479 Finagro Fase 2   */
/*     Julian Mendigaña         15/Abr/2015    REQ500 obligatoriedad FAG*/
/*     Milton Custode           24/Abr/2017    Actualizacion de cuentas */
/*                                             grupales                 */
/*     M. Taco                  12/Jul/2019    Caso 116911 Exigible LCR */
/*     AGO                      18/Nov/2020    Mejoras                  */
/************************************************************************/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_desembolso')
   drop proc sp_desembolso
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO
---NR436ART12 Normalizacion de Cartera

create proc sp_desembolso
   @s_sesn                 int          = null,
   @s_date                 datetime,
   @s_user                 login        = null,
   @s_culture              varchar(10)  = null,
   @s_term                 varchar(30)  = null,
   @s_ssn                  int          = null,
   @s_org                  char(1)      = null,
   @s_srv                  varchar (30) = null,
   @s_ofi                  smallint     = null,
   @s_lsrv                 varchar (30) = null,
   @s_rol                  int          = null,
   @t_trn                  int          = null,
   @i_operacion            char(1),
   @i_banco_real           cuenta,
   @i_banco_ficticio       cuenta,
   @i_secuencial           int          = null,
   @i_originador           char(1)      = null,
   @i_desembolso           tinyint      = null,
   @i_producto             catalogo     = '',
   @i_cuenta               cuenta       = '',
   @i_oficina_chg          int          = 0,
   @i_beneficiario         descripcion  = '',
   @i_monto_ds             money        = null,
   @i_monto_ds_dec         money        = null,
   @i_moneda_ds            smallint     = null,
   @i_cotiz_ds             money        = null,
   @i_tcotiz_ds            char(1)      = null,
   @i_moneda_op            tinyint      = null,
   @i_cotiz_op             money        = null,
   @i_tcotiz_op            char(1)      = null,
   @i_pasar_tmp            char(1)      = null,
   @i_formato_fecha        int          = null,
   @i_consulta             char(1)      = null,
   @i_capitalizacion       char(1)      = 'N',
   @i_externo              char(1)      = 'S',
   @i_operacion_ach        char(1)      = null,
   @i_nom_producto         char(3)      = null,
   @i_cod_banco_ach        int          = null,
   @i_desde_cre            char(1)      = null,
   @i_cheque               int          = null,
   @i_prenotificacion      int          = null,
   @i_carga                int          = null,
   @i_concepto             varchar(255) = null,
   @i_fecha_liq            datetime     = null,
   @o_respuesta            char(1)      = null out,
   @o_secuencial           descripcion  = null out,
   @i_ente_benef           int          = null,
   @i_idlote               int          = null,
   @i_renovaciones         char(1)      = null,
   @i_origen               char(1)      = 'F',       -- [F]RONTEND / [B]ACKEND
   @i_crea_ext             char(1)      = null,
   @i_cruce_restrictivo    char(1)      = null,      --Ceh Req 264 - Desembolsos GMF
   @i_destino_economico    char(1)      = null,      --Ceh Req 264 - Desembolsos GMF
   @i_carta_autorizacion   char(1)      = null,      --Ceh Req 264 - Desembolsos GMF
   @i_calcular_gmf         char(1)      = 'N',
   @i_tramite              int          = null,      --Tramite grupal
   @i_grupal               char(1)      = null,      --bandera en el cual indica que es desembolso grupal
   @i_grupo_id             int          = null,      --id de grupo
   @o_anticipado           money        = null out,   -- CONSULTA DEL VALOR ANTICIPADO PARA BACKEND
   @o_msg_msv              varchar(255) = null out

as declare
   @w_sp_name              varchar(30),
   @w_error                int,
   @w_operacionca          int,
   @w_operacionca_real     int,
   @w_secuencial           int,
   @w_desembolso           int,
   @w_num_dec_mn           tinyint,
   @w_num_dec_op           tinyint,
   @w_num_dec_ds           tinyint,
   @w_op_monto             float,
   @w_total                money,
   @w_monto_op             money,
   @w_monto_mn             money,
   @w_anticipados          money,
   @w_dividendo            smallint,
   @w_int_ant              money,
   @w_estado               tinyint,
   @w_tipo                 char(1),
   @w_fecha_proceso        datetime,
   @w_dias_contr           int,
   @w_dias_hoy             int,
   @w_instrucciones        char(1),
   @w_tramite_des          int,
   @w_fecha_ini_oper       datetime,
   @w_siglas_int           catalogo,
   @w_tasa_aplicar         catalogo,
   @w_porcentaje           float,
   @w_tasa_referencial     catalogo,
   @w_sector               char(1),
   @w_modalidad            char(1),
   @w_periodicidad         char(1),
   @w_moneda_local         smallint,
   @w_convertir_valor      char(1),
   @w_siglas_intant        catalogo,
   @w_estado_gar           char(1),
   @w_tramite              int,
   @w_moneda_uvr           int,
   @w_moneda               int,
   @w_monto_pesos          float,
   @w_monto_uvr            float,
   @w_cot_mn               float,
   @w_toperacion           catalogo,
   @w_moneda_op            smallint,
   @w_timbre               catalogo,
   @w_rango_min            money,
   @w_op_monto_aprobado    money,
   @w_cotizacion           float,
   @w_monto_timbre         money,
   @w_tipogar_hipo         catalogo,
   @w_aceptable            float,
   @w_diff                 float,
   @w_calcular             char(1),
   @w_parametro_fag        catalogo,
   @w_parametro_fng        catalogo,
   @w_parametro_fga        catalogo,
   @w_parametro_fng_des    catalogo,
   @w_parametro_fogacafe   catalogo,
   @w_parametro_ong        catalogo,
   @w_fag                  char(1),
   @w_fng                  char(1),
   @w_fog                  char(1),
   @w_garantia_especial    char(1),
   @w_tipo_esp             catalogo,
   @w_op_naturaleza        char(1),
   @w_montod_pesos         money,
   @w_montod_uvr           float,
   @w_op_toperacion        catalogo,
   @w_op_tipo              char(1),
   @w_lin_credito          cuenta,
   @w_rowcount             int,
   @w_parametro_apecr      catalogo,
   @w_concepto_micseg      catalogo,
   @w_concepto_exequi      catalogo,
   @w_cod_gar_fng          catalogo,
   @w_valor_respaldo       money,
   @w_segdeuant            catalogo,
   @w_nro_utilizacionres   smallint,
   @w_cobra_apercre        char(1),
   @w_tipo_tramite         char(1),
   @w_porcentaje_gar       float,   -- JAR REQ 197
   @w_iva_fng_des          catalogo,
   @w_plazo                int,
   @w_op_banca             catalogo,
-- INI JAR REQ 173
   @w_cod_gar_fag          catalogo,
   @w_cod_gar_usaid        catalogo,
   @w_par_fag_des          catalogo,
   @w_par_fag_uni          catalogo,
   @w_iva_fag_des          catalogo,
   @w_iva_fag_uni          catalogo,
   @w_iva_usaid_des        catalogo,
   @w_parametro_usaid      catalogo,
   @w_par_usaid_des        catalogo,
   @w_usaid                char(1),
   @w_rubro_des            catalogo,
   @w_iva_des              catalogo,
   @w_msg                  varchar(20),
   @w_tipo_sup             catalogo,
-- FIN JAR REQ 173
   @w_cliente              int,           -- JAR REQ 218
   @w_clave1            varchar(255),  -- CEH REQ 264
   @w_concepto_capital     catalogo,      -- CEH REQ 264
   @w_concepto_gmf         catalogo,      -- CEH REQ 264
   @w_vlr_gmf              float,         -- CEH REQ 264
   @w_sum_desc             money,         -- CEH REQ 264
   @w_vlr_cap              money,         -- CEH REQ 264
   @w_base_gmf             money,          -- CEH REQ 264
   @w_monto_mop            money,
   @w_vlr_despreciable     float,
   @w_parametro_fga_iva_uni varchar(30),
   @w_cod_gar_fga          catalogo,
   @w_monto_seguros        money,
   @w_monto_seguros_gar    money,
   @w_plazo_gar            int,
   @w_tplazo               varchar(10),
   @w_num_dias             int,
   --REQ379
   @w_parametro_fgu          catalogo,--REQ379
   @w_cod_gar_fgu            catalogo,--REQ379
   @w_parametro_fgu_iva      catalogo,--REQ379
   @w_parametro_fgu_per      catalogo,--REQ379
   @w_parametro_fgu_iva_per  catalogo,--REQ379
   --REQ 402
   @w_tipo_gar               varchar(20), --REQ 402
   @w_colateral              varchar(10), --REQ 402
   @w_tabla_rubros           varchar(64), --REQ 402
   @w_rubros                 varchar(5) ,  --REQ 402
   @w_cu_estado              catalogo,    ---ORS 866
   @w_cod_pagare             catalogo,     ---ORS 866
   @w_param_fusaid           datetime,
   @w_tr_grupo               int, --CCA 436: NORMALIZACION DE CARTERA
   @w_retorno                int,
   @w_linea_tramite          catalogo     -- REQ 500

-- FQ: NR-392
declare
   @w_tflexible                     catalogo,
   @w_op_tipo_amortizacion          catalogo,
   @w_op_fecha_ini                  datetime,
   @w_solicitud_tflex               char(1)

select @w_tflexible = ''

select @w_tflexible = pa_char
from   cobis..cl_parametro
where  pa_producto  = 'CCA'
and    pa_nemonico  = 'TFLEXI'
set transaction isolation level read uncommitted

delete tmp_rubros_d where spid = @@spid
delete tmp_gar_especiales where spid = @@spid
--delete tmp_garantias_tramite where spid = @@spid

create table #conceptos (
 codigo    varchar(10)  null,
 tipo_gar  varchar(64)  null
 )

create table #rubros_des (
garantia      varchar(10),
rre_concepto  varchar(64),
tipo_concepto varchar(10),
iva           varchar(5),
rre_tipo      varchar(10)
)


SET ARITHABORT ON
-- VARIABLES INICIALES
select   @w_sp_name    = 'sp_desembolso'

select @w_monto_op          = 0,
       @w_op_monto_aprobado = 0,
       @w_calcular          = 'S',
       @w_porcentaje_gar    = 0

/*CODIGO PAGARE DEL CREDITO*/
select @w_cod_pagare = pa_char
from cobis..cl_parametro
where pa_producto  = 'GAR'
and   pa_nemonico  = 'CODPAC'

/*CODIGO PADRE GARANTIA DE FNG*/
select @w_cod_gar_fng = pa_char
from cobis..cl_parametro
where pa_producto  = 'GAR'
and   pa_nemonico  = 'CODFNG'

-- INI JAR REQ 197
/*CODIGO PADRE GARANTIA DE FAG*/
select @w_cod_gar_fag = pa_char
from   cobis..cl_parametro
where  pa_producto = 'GAR'
and    pa_nemonico = 'CODFAG'

/*CODIGO PADRE GARANTIA DE USAID*/
select @w_cod_gar_usaid = pa_char
from   cobis..cl_parametro
where  pa_producto = 'GAR'
and    pa_nemonico = 'CODUSA'
-- FIN JAR REQ 197

-- CODIGO DEL MONEDA UVR
select @w_moneda_uvr = pa_tinyint
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'MUVR'
select @w_rowcount = @@rowcount
set transaction isolation level read uncommitted
if @w_rowcount = 0
begin
   select @w_error = 710120
   goto ERROR
end

---CODIGO DEL RUBRO TIMBRE
select @w_timbre = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'TIMBRE'
select @w_rowcount = @@rowcount
set transaction isolation level read uncommitted
if @w_rowcount = 0
begin
   select @w_error = 710120
   goto ERROR
end


if @i_monto_ds <= 0
begin
   select @w_error = 710017 --710556
   goto ERROR
end

---CODIGO DEL RUBRO COMISION FAG
select @w_parametro_fag = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'CMFAGP'  -- JAR REQ 197
set transaction isolation level read uncommitted

---CODIGO DEL RUBRO COMISION FAG UNICO
select @w_par_fag_uni = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'COMUNI'
set transaction isolation level read uncommitted

select @w_iva_fag_uni = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'ICFAGU'
set transaction isolation level read uncommitted


-- INI JAR REQ 197
---CODIGO DEL RUBRO COMISION FAG DES
select @w_par_fag_des = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'CMFAGD'  -- JAR REQ 197
set transaction isolation level read uncommitted

select @w_iva_fag_des = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'ICFAGD'
set transaction isolation level read uncommitted

---CODIGO DEL RUBRO COMISION USAID
select @w_parametro_usaid = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'CMUSAP'
set transaction isolation level read uncommitted

---CODIGO DEL RUBRO COMISION USAID DES
select @w_par_usaid_des = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'CMUSAD'
set transaction isolation level read uncommitted

select @w_iva_usaid_des = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'ICUSAD'
set transaction isolation level read uncommitted
-- FIN JAR REQ 197

---CODIGO DEL RUBRO COMISION FNG
select @w_parametro_fng = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'COMFNG'
set transaction isolation level read uncommitted

---CODIGO DEL RUBRO COMISION FNG
select @w_parametro_fng_des = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'COFNGD'
set transaction isolation level read uncommitted

---CODIGO DEL RUBRO COMISION FGA
select @w_parametro_fga = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'COMFGA'
set transaction isolation level read uncommitted

select @w_parametro_fga_iva_uni = pa_char
from   cobis..cl_parametro with (nolock)
where  pa_producto = 'CCA'
and    pa_nemonico = 'IVAFGA'
set transaction isolation level read uncommitted

-- Tipo Garantia Padre FGA
select @w_cod_gar_fga = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto = 'GAR'
and   pa_nemonico = 'CODFGA'

select @w_iva_fng_des = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'IVFNGD'
set transaction isolation level read uncommitted


---CODIGO DEL RUBRO COMISION FOGACAFE
select @w_parametro_fogacafe = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'COMFOG'
set transaction isolation level read uncommitted


--LECTURA DEL PARAMETRO CODIGO APERTURA DE CREDITO
select @w_parametro_apecr = pa_char
from cobis..cl_parametro
where pa_producto = 'CCA'
and   pa_nemonico = 'APECR'
set transaction isolation level read uncommitted

---CODIGO DEL CONCEPTO MICROSEGURO
select @w_concepto_micseg = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'MICSEG'
and    pa_producto = 'CCA'
set transaction isolation level read uncommitted

---CODIGO DEL CONCEPTO SEGURO EXEQUIAL
select @w_concepto_exequi = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'EXEQUI'
and    pa_producto = 'CCA'
set transaction isolation level read uncommitted

---CODIGO DEL CONCEPTO CAPITAL
select @w_concepto_capital = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'CAP'
and    pa_producto = 'CCA'
set transaction isolation level read uncommitted

---CODIGO DEL CONCEPTO GMF
select @w_concepto_gmf = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'GMF'
and    pa_producto = 'CCA'
set transaction isolation level read uncommitted


----------------------------------------
-- REQ 379
----------------------------------------
select @w_parametro_fgu = pa_char
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'COMGAR'
set transaction isolation level read uncommitted

select @w_parametro_fgu_iva = pa_char
from   cobis..cl_parametro with (nolock)
where  pa_producto = 'CCA'
and    pa_nemonico = 'IVAGAR'
set transaction isolation level read uncommitted

select @w_cod_gar_fgu = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto = 'GAR'
and   pa_nemonico = 'CODGAR'
set transaction isolation level read uncommitted


select @w_parametro_fgu_iva_per = pa_char
from   cobis..cl_parametro with (nolock)
where  pa_producto = 'CCA'
and    pa_nemonico = 'IVAGRP'
set transaction isolation level read uncommitted

select @w_parametro_fgu_per = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto = 'CCA'
and   pa_nemonico = 'COMGRP'
set transaction isolation level read uncommitted

select @w_fecha_proceso = fc_fecha_cierre
from   cobis..ba_fecha_cierre
where  fc_producto = 7  -- 7 pertenece a Cartera

select @w_tramite = null

select @w_vlr_despreciable = 1.0 / power(10,  isnull(@w_num_dec_op, 4))

select @w_fecha_ini_oper       = op_fecha_ini,
       @w_tramite              = op_tramite,
       @w_op_tipo_amortizacion = op_tipo_amortizacion,
       @w_moneda               = op_moneda,
       @w_op_monto             = op_monto,
       @w_operacionca          = op_operacion,
       @w_op_monto_aprobado    = op_monto_aprobado,
       @w_op_naturaleza        = op_naturaleza,
       @w_op_toperacion        = op_toperacion,
       @w_op_tipo              = op_tipo,
       @w_lin_credito          = op_lin_credito,
       @w_plazo                = op_plazo,
       @w_cliente              = op_cliente  -- JAR REQ 218
from   ca_operacion
where  op_banco = @i_banco_real

select @w_op_monto_aprobado = tr_monto_solicitado
from   cob_credito..cr_tramite
where  tr_tramite = @w_tramite

/*if exists (select 1 from cob_credito..cr_op_renovar
           where or_tramite = @w_tramite)
           and @i_renovaciones = 'N'
begin

   if @@rowcount = 0
   begin
     -- 436: VALIDA SI EL DESEMBOLSO ES POR NORMALIZACION DE CARTERA
     if exists(select 1 from cob_credito..cr_normalizacion
               where nm_tramite = @w_tramite)
        select @w_error = 724561
     else
        select @w_error = 724507

     goto ERROR
   end
end*/

if exists (select 1
          from cob_custodia..cu_custodia,cob_credito..cr_gar_propuesta,cob_custodia..cu_convenios_garantia
         where gp_tramite = @w_tramite
         and cu_tipo =  cg_tipo_garantia
         and gp_garantia = cu_codigo_externo
         and cg_estado = 'V'
         and cu_estado not in ('X','C','A')
         )
begin
    ---Existe la garantia USAID y Hay que VAlidar SU VIGENCIA AL CONVENIO
    select @w_param_fusaid = pa_datetime
    from cobis..cl_parametro
    where pa_nemonico = 'FUSAID'
    and   pa_producto = 'GAR'

     if @w_param_fusaid is null
      begin
         PRINT 'desembol.sp No se ha Creado el Parametro FUSAID'
         select @w_error = 2101001
         goto ERROR
      end

      if @w_fecha_proceso > @w_param_fusaid
      begin
         PRINT 'desembol.sp La Fecha desembolso del Credito Excede el Valor del Parametro <FUSAID> para USAID. Revise la Parametrizacion '
         select @w_error = 2101001
         goto ERROR
     end

end

if exists (select 1 from  cob_cartera..ca_operacion,cob_credito..cr_normalizacion
           where op_banco = nm_operacion
           and nm_tramite = @w_tramite
           and op_estado = 1)
           and @i_origen = 'F'
begin
   if @@rowcount = 0
   begin
     select @w_error = 724560
     goto ERROR
   end
end

--REQ 402
select @w_colateral = pa_char
from cobis..cl_parametro with (nolock)
where pa_producto = 'GAR'
and   pa_nemonico = 'GARESP'

select tipo_u  = tc_tipo
into #garantias_colaterales
from cob_custodia..cu_tipo_custodia
where  tc_tipo_superior = @w_colateral


select tc_tipo as tipo,
       tc_tipo_superior as tipo_sup
into #tipo_garantia
from cob_custodia..cu_tipo_custodia
where  tc_tipo_superior in (select tipo_u from #garantias_colaterales)
--FIN REQ 402


if exists (select 1
           from cob_custodia..cu_custodia,
           cob_credito..cr_gar_propuesta,
           cob_credito..cr_tramite
           where gp_tramite  = @w_tramite
           and gp_garantia = cu_codigo_externo
           and cu_estado   <> 'A'
           and tr_tramite  = gp_tramite
           and    substring(gp_garantia,6,4) <>  ltrim(rtrim(@w_cod_pagare))
           and cu_tipo in (select tipo from #tipo_garantia))
begin
   select @w_porcentaje_gar = 0,
          @w_valor_respaldo = 0

   select @w_valor_respaldo = isnull(gp_valor_resp_garantia,0),
          @w_porcentaje_gar = gp_porcentaje,
          @w_tipo_sup       = tipo_sup,        -- JAR REQ 197
          @w_tipo_gar       = cu_tipo,    --REQ402
          @w_cu_estado      = cu_estado
   from cob_credito..cr_gar_propuesta,
   cob_custodia..cu_custodia, #tipo_garantia  -- JAR REQ 197
   where gp_garantia = cu_codigo_externo
   and gp_tramite    = @w_tramite
   and cu_tipo       = tipo                   -- JAR REQ 197
   and cu_estado   <> 'A'
   and substring(gp_garantia,6,4) <> ltrim(rtrim(@w_cod_pagare))

end


	--NR 296 SE COMENTA DADO QUE NO MANEJAMOS LINEAS DE CREDITO VERSION MX
	--if @w_op_tipo = 'O'
	--begin

	-- if @w_lin_credito is null
	-- begin
	--  select @w_error = 701065
	-- goto ERROR
	--end

	--   if exists (select 1
	--               from cob_credito..cr_corresp_sib
	--              where codigo = @w_op_toperacion
	--             and tabla = 'T45'
	--             and convert(money,codigo_sib) > @i_monto_ds
	--              )
	-- begin
	--   select @w_error = 710304
	--   goto ERROR
	--- end

--end
--NR 296

-- CONSULTA CODIGO DE MONEDA LOCAL
select  @w_moneda_local = pa_tinyint
from    cobis..cl_parametro
where   pa_nemonico = 'MLO'
and     pa_producto = 'ADM'
set transaction isolation level read uncommitted


-- PARAMENTRO INTERES CORRIENTE
select @w_siglas_int = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'INT' --INTERES CORRIENTE
and    pa_producto = 'CCA'
set transaction isolation level read uncommitted

-- PARAMENTRO INTERES CORRIENTE
select @w_siglas_intant = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'INTANT' --INTERES CORRIENTE
and    pa_producto = 'CCA'
set transaction isolation level read uncommitted



select @w_segdeuant = pa_char
from   cobis..cl_parametro
where pa_producto  = 'CCA'
AND pa_nemonico = 'SEDEAN'

select @w_dias_contr = pa_smallint
from   cobis..cl_parametro
where  pa_producto = 'CCA'
and    pa_nemonico = 'DFVAL'
select @w_rowcount = @@rowcount
set transaction isolation level read uncommitted

if @w_rowcount = 0
begin
   delete tmp_rubros_d where spid = @@spid
   delete tmp_gar_especiales where spid = @@spid
   --delete tmp_garantias_tramite where spid = @@spid
   if @i_crea_ext is null
   begin
   exec cobis..sp_cerror
        @t_debug  = 'N',
        @t_file   = null,
        @t_from   = @w_sp_name,
        @i_num    = 710215
        return 710215
   end
   ELSE
   begin
     select @o_msg_msv = 'Error en borrado de tablas temporales ' + @w_sp_name
     return 710215
   end
end

select @w_fecha_proceso = fc_fecha_cierre
from   cobis..ba_fecha_cierre
where  fc_producto = 7  -- 7 pertenece a Cartera

select @w_dias_hoy = datediff(dd, @w_fecha_ini_oper, @w_fecha_proceso)

if @w_dias_hoy > @w_dias_contr
begin
   delete tmp_rubros_d where spid = @@spid
   delete tmp_gar_especiales where spid = @@spid
   --delete tmp_garantias_tramite where spid = @@spid
   if @i_crea_ext is null
   begin
       exec cobis..sp_cerror
       @t_debug='N',
       @t_file = null,
       @t_from =@w_sp_name,
       @i_num = 710212
       return 710212
   end
   ELSE
   begin
      select @o_msg_msv = 'Error en borrado de tablas temporales ' + @w_sp_name
      return 710212
   end
end

if @i_desde_cre = 'S' and @w_op_naturaleza = 'A'
begin
   select @i_banco_ficticio = op_banco,
          @i_banco_real     = op_banco,
          @w_tramite        = op_tramite
   from   ca_operacion
   where  op_tramite = convert(int,@i_banco_ficticio)

   -- CONTROL DEL ESTADO DE LA GARANTIA
   select @w_estado_gar = isnull(cu_estado,'X')
   from   cob_custodia..cu_custodia,
          cob_credito..cr_gar_propuesta
   where  gp_tramite = @w_tramite
   and    cu_estado  <> 'A'  --ANULADA
   and    gp_garantia = cu_codigo_externo
   and    substring(gp_garantia,6,4) <> ltrim(rtrim(@w_cod_pagare))

   if @@rowcount <> 0
   begin
      if @w_estado_gar in ('X', 'C', 'P')
      begin
         print 'La Garantia del tramite debe estar en estado VIGENTE FUTUROS CREDITOS O VIGENTE CON OBLIGACION'
         delete tmp_rubros_d where spid = @@spid
         delete tmp_gar_especiales where spid = @@spid
         --delete tmp_garantias_tramite where spid = @@spid
         return 0
      end
   end
end

if @w_op_naturaleza = 'A' -- ESTE CONTROL TAMBIEN SE DEBE PERMITIR DESDE CCA. POR ESE MOTIVO SE COMENTA (i_desde_cre)
begin
   -- GARANTIAS DE UN TRAMITE
   -- ***********************
   select @w_estado_gar = isnull(cu_estado,'X')
          from   cob_credito..cr_gar_propuesta, cob_custodia..cu_custodia
          where  gp_tramite  = @w_tramite
          and    gp_garantia = cu_codigo_externo
          and    cu_estado <> 'A'
          and    substring(gp_garantia,6,4) <> ltrim(rtrim(@w_cod_pagare))
   if @@rowcount <> 0
   begin
      if @w_estado_gar not in ('X','C','A')
      begin
         insert into tmp_garantias_tramite
               (spid, gp_garantia, cu_tipo)
         select @@spid, gp_garantia, cu_tipo
         from   cob_credito..cr_gar_propuesta, cob_custodia..cu_custodia
         where  gp_tramite  = @w_tramite
         and    gp_garantia = cu_codigo_externo
         and    cu_estado in ('V','F','P')
         and    substring(gp_garantia,6,4) <> ltrim(rtrim(@w_cod_pagare))

         if @@error <> 0 or @@rowcount = 0
            print '..ERROR EN TMP_GARANTIAS_TRAMITE'
      end
   end
  

   -- ANALIZA SI EL CREDITO TIENE GARANTIA ESPECIAL
   -- *********************************************
   select @w_garantia_especial  = 'N'

   -- PARAMETRO PARA DEFINIR LAS GARANTIAS ESPECIALES
   -- ***********************************************
   select @w_tipo_esp = pa_char
   from   cobis..cl_parametro
   where  pa_producto = 'GAR'
   and    pa_nemonico   = 'GARESP'

   if @@rowcount = 0
   begin
      delete tmp_rubros_d where spid = @@spid
      delete tmp_gar_especiales where spid = @@spid
     -- delete tmp_garantias_tramite where spid = @@spid
     if @i_crea_ext is null
     begin
       exec cobis..sp_cerror
       @t_from  = @w_sp_name,
       @i_msg   = 'No existe parametro con el nemonico GARESP',
       @i_num   = 2101084
       return 1
     end
     ELSE
     begin
        select @o_msg_msv = 'Error en borrado de tablas temporales ' + @w_sp_name
        return 2101084
     end
   end

   -- TABLA DE LOS TIPOS DE GARANTIAS ESPECIALES
   -- ******************************************
   insert into tmp_gar_especiales
   select @@spid, tc_tipo
   from   cob_custodia..cu_tipo_custodia
   where  tc_tipo  = @w_tipo_esp
   union
   select @@spid, tc_tipo
   from   cob_custodia..cu_tipo_custodia
   where  tc_tipo_superior  = @w_tipo_esp
   union
   select @@spid, tc_tipo
   from   cob_custodia..cu_tipo_custodia
   where  tc_tipo_superior in (select tc_tipo from cob_custodia..cu_tipo_custodia
                               where  tc_tipo_superior = @w_tipo_esp)

   if exists (select 1 from tmp_garantias_tramite
              where spid = @@spid
              and   cu_tipo in (select ge_tipo from tmp_gar_especiales where spid = @@spid))
      select @w_garantia_especial  = 'S'
   else
      select @w_garantia_especial  = 'N'

   if @w_garantia_especial  = 'S'   ---si tiene garantia especial
   begin
       -- Inicio IFJ 09/DIC/2005  - REQ 433
       If  @w_moneda = @w_moneda_uvr
       begin
            if exists (select 1
                    from   ca_rubro_op
                    where  ro_concepto   = @w_parametro_fag
                    and    ro_operacion  = @w_operacionca)
            begin
                PRINT 'sp_desembolso este tramite no debe tener garantia FAG asociada'
                select @w_error = 711010
                goto ERROR
            end
       end
      -- Fin IFJ 09/DIC/2005  - REQ 433

       /*BUSQUEDA DE CONCEPTOS*/ --REQ 402
      select @w_rubros = valor
      from  cobis..cl_tabla t, cobis..cl_catalogo c
      where t.tabla  = 'ca_conceptos_rubros'
      and   c.tabla  = t.codigo
      and   c.codigo = convert(bigint, @w_tipo_gar)

      if @w_rubros = 'S' begin

         select @w_tabla_rubros = 'ca_conceptos_rubros_' + cast(@w_tipo_gar as varchar)

         insert into #conceptos
         select
         codigo = c.codigo,
         tipo_gar = @w_tipo_gar
         from cobis..cl_tabla t, cobis..cl_catalogo c
         where t.tabla  = @w_tabla_rubros
         and   c.tabla  = t.codigo
      end
      --FIN REQ 402


      -- INI JAR REQ 197

      if exists (select 1 from ca_rubro_op
                  where ro_operacion = @w_operacionca
                  and @w_estado_gar not in ('X','C','A')
                  and (ro_concepto in (@w_parametro_fag, @w_parametro_fng, @w_parametro_fogacafe, @w_parametro_usaid,@w_par_usaid_des, @w_par_fag_uni, @w_parametro_fga, @w_parametro_fgu)
                   or  ro_concepto in (select codigo from #conceptos))) --REQ 402
      begin
        select @w_operacionca = @w_operacionca
      end
      -- FIN JAR REQ 197
      else
      begin
         delete tmp_rubros_d where spid = @@spid
         delete tmp_gar_especiales where spid = @@spid
        -- delete tmp_garantias_tramite where spid = @@spid
          print 'Favor ingrese el rubro COMISION, porque la obligacion tiene GARANTIA ESPECIAL esTGar' + cast ( @w_estado_gar as varchar)
         return 1
      end
   end
end

if @i_operacion = 'Q'
begin
   -- Req. 366 Seguros, Recalcula las fechas de vigencia de las polizas
   if exists (select 1 from cob_credito..cr_seguros_tramite
                 where st_tramite = @w_tramite)
   begin
      if @w_op_tipo_amortizacion <> @w_tflexible
         exec @w_error = cob_credito..sp_seguros_tramite
              @i_tramite   = @w_tramite,
              @i_operacion = 'P'
      ELSE
         exec @w_error = cob_credito..sp_seguros_tramite
              @i_tramite   = @w_tramite,
              @i_operacion = 'P',
              @i_tflexible = 'S'

      if @w_error <> 0
      begin
         select @w_error = @w_error
         goto ERROR
      end
   end

   if @i_externo = 'S'
      BEGIN TRAN

   --EXISTE EL TRAMITE Y ES OBLIGACION EN UVR SE DEBE ACTUALIZAR EL MONTO PARA AJUSTAR EL VALOR A PESOS
   if @w_tramite is not null and @w_moneda = @w_moneda_uvr
   begin
      select @w_calcular = 'S'

      if @w_calcular = 'S'
      begin
         select @w_monto_pesos = isnull(tr_montop,0),   ---MONTO EN PESOS SIN DESCONTAR VALORES ANTICIPADOS (MONTO APROBADO)
                @w_montod_pesos = isnull(tr_monto_desembolsop,0)   ---MONTO EN PESOS SIN DESCONTAR VALORES ANTICIPADOS (A DESEMBOLSAR)
         from   cob_credito..cr_tramite
         where  tr_tramite = @w_tramite

         if @w_monto_pesos = 0
         begin
             select @w_error = 710498
             goto ERROR
         end

         --ACTUALIZAR EL MONTO APROBADO DE LA OBLIGACION SEGUN EL VALOR
         exec @w_error = sp_conversion_moneda
              @s_date             = @s_date,
              @i_opcion           = 'L',
              @i_moneda_monto     = @w_moneda_local,
              @i_moneda_resultado = @w_moneda_uvr,
              @i_monto            = @w_monto_pesos,
              @i_fecha            = @w_fecha_ini_oper,
              @o_monto_resultado  = @w_monto_uvr out,
              @o_tipo_cambio      = @w_cot_mn out

         if @w_error <> 0
         begin
            if @i_externo = 'S' ROLLBACK TRAN
            select @w_error = @w_error
            goto ERROR
         end

         --ACTUALIZAR EL MONTO A DESEMBOLSAR
         exec @w_error = sp_conversion_moneda
              @s_date             = @s_date,
              @i_opcion           = 'L',
              @i_moneda_monto     = @w_moneda_local,
              @i_moneda_resultado = @w_moneda_uvr,
              @i_monto            = @w_montod_pesos,
              @i_fecha            = @w_fecha_ini_oper,
              @o_monto_resultado  = @w_montod_uvr out,
              @o_tipo_cambio      = @w_cot_mn out

         if @w_error <> 0
         begin
            if @i_externo = 'S' ROLLBACK TRAN
            select @w_error = @w_error
            goto ERROR
         end
      end

      update ca_operacion
      set    op_monto = @w_montod_uvr,             ---MONTO A DESEMBOLSAR
             op_monto_aprobado = @w_monto_uvr      ---MONTO APROBADO
      where  op_banco = @i_banco_real

      if @@error <> 0
      begin
        select @w_error = 705076
        goto ERROR
      end

      update ca_rubro_op
      set    ro_valor = @w_monto_uvr
      where  ro_operacion = @w_operacionca
      and    ro_tipo_rubro = 'C'

      if @@error <> 0
      begin
        select @w_error = 707003
        goto ERROR
      end

      exec @w_error     = sp_pasotmp
           @s_user            = @s_user,
           @s_term            = @s_term,
           @i_banco           = @i_banco_real,
           @i_operacionca     = 'S',
           @i_dividendo       = 'S',
           @i_amortizacion    = 'N',
           @i_cuota_adicional = 'S',
           @i_rubro_op        = 'S',
           @i_relacion_ptmo   = 'S',
           @i_nomina          = 'S',
           @i_acciones        = 'S',
           @i_valores         = 'S'

      if @w_error <> 0
      begin
         if @i_externo = 'S' ROLLBACK TRAN

         select @w_error = @w_error
         goto ERROR
      end


      exec @w_error = sp_modificar_operacion_int
           @s_user              = @s_user,
           @s_sesn              = @s_sesn,
           @s_date              = @s_date,
           @s_ofi               = @s_ofi,
           @s_term              = @s_term,
           @i_calcular_tabla    = 'S',
           @i_tabla_nueva       = 'D',
           @i_salida            = 'N',
           @i_operacionca       = @w_operacionca,
           @i_banco             = @i_banco_real

      if @w_error <> 0
      begin
         if @i_externo = 'S' ROLLBACK TRAN

         select @w_error = @w_error
         goto ERROR
      end

      exec @w_error = sp_pasodef
           @i_banco        = @i_banco_real,
           @i_operacionca  = 'S',
           @i_dividendo    = 'S',
           @i_amortizacion = 'S',
           @i_cuota_adicional = 'S',
           @i_rubro_op     = 'S',
           @i_relacion_ptmo = 'S',
           @i_nomina       = 'S',
           @i_acciones     = 'S',
           @i_valores      = 'S'

      if @w_error <> 0
      begin
         if @i_externo = 'S' ROLLBACK TRAN

         select @w_error = @w_error
         goto ERROR
      end

      exec @w_error = sp_borrar_tmp
           @s_user       = @s_user,
           @s_sesn       = @s_sesn,
           @s_term       = @s_term,
           @i_desde_cre  = 'N',
           @i_banco      = @i_banco_real

      if @w_error <> 0
      begin
         if @i_externo = 'S' ROLLBACK TRAN

         select @w_error = @w_error
         goto ERROR
      end
   end   -- FIN UVR

   if @i_pasar_tmp = 'S'
   begin
      ---SE borra de las temporales antes de volver a cargarlas
      exec @w_error = sp_borrar_tmp
           @s_user       = @s_user,
           @s_sesn       = @s_sesn,
           @s_term       = @s_term,
           @i_desde_cre  = 'N',
           @i_banco      = @i_banco_real

      if @w_error <> 0
      begin
         if @i_externo = 'S' ROLLBACK TRAN

         select @w_error = @w_error
         goto ERROR
      end

      exec @w_error      = sp_pasotmp
           @s_user            = @s_user,
           @s_term            = @s_term,
           @i_banco           = @i_banco_real,
           @i_operacionca     = 'S',
           @i_dividendo       = 'S',
           @i_amortizacion    = 'S',
           @i_cuota_adicional = 'S',
           @i_rubro_op        = 'S',
           @i_relacion_ptmo   = 'S',
           @i_nomina          = 'S',
           @i_acciones        = 'S',
           @i_valores         = 'S'

      if @w_error <> 0
      begin
         if @i_externo = 'S' ROLLBACK TRAN
         select @w_error = @w_error
         goto ERROR
      end

      -- Inicio Fin Req. 366 Seguros
      if exists (select 1 from cob_credito..cr_seguros_tramite
                 where st_tramite = @w_tramite)
      and @w_op_tipo_amortizacion <> @w_tflexible
      begin
         exec @w_error      = sp_seguros
              @i_opcion     = 'G'       ,
              @i_tramite    = @w_tramite

         if @w_error <> 0
         begin
            select @w_error = @w_error
            goto ERROR
         end
      end   -- Fin Req. 366 Seguros
   end

   -- CABECERA

   select @w_operacionca   = opt_operacion,
          @w_estado        = opt_estado,
          @w_tipo          = opt_tipo,
          @w_tramite_des   = opt_tramite,
          @w_toperacion    = opt_toperacion,
          @w_moneda_op     = opt_moneda,
          @w_op_banca      = opt_banca,
          @w_op_fecha_ini  = opt_fecha_ini
   from   ca_operacion_tmp
   where  opt_banco = @i_banco_ficticio

   select @w_solicitud_tflex = 'N'

   select @w_solicitud_tflex = tfc_solicitud_tflex
   from   ca_tabla_flexible_control with (nolock)
   where  tfc_operacion = @w_operacionca

   if  @w_solicitud_tflex = 'S'
   and exists(select 1
              from   ca_operacion with (nolock)
              where  op_banco = @i_banco_ficticio
              and    op_tipo_amortizacion <> @w_tflexible)
   begin
      begin try
         exec @w_error = sp_actualizar_tflexible_int
               @s_user        = @s_user,
               @s_date        = @s_date,
               @s_term        = @s_term,
               @s_ofi         = @s_ofi,
               @s_sesn        = @s_sesn,
               @i_debug       = 'N',
               @i_banco       = @i_banco_ficticio,
               @i_fecha_liq   = @w_op_fecha_ini

         if @w_error <> 0
         begin
            select @w_error = @w_error
            goto ERROR
         end
         print 'Se aplico tabla de amortizacion flexible'
         select @w_op_tipo_amortizacion = opt_tipo_amortizacion
         from   ca_operacion_tmp
         where  opt_banco = @i_banco_ficticio

      end try
      begin catch
         declare
            @w_linea       int,
            @w_sp          varchar(100)

         select @w_linea = ERROR_LINE(),
                @w_sp = ERROR_PROCEDURE()

         print 'Error ' + @w_sp +  '  ' + convert(varchar, @w_linea)
            + ': ' + ERROR_MESSAGE()

         select @w_error = 70010002
         goto ERROR
      end catch
   end

   if  @i_externo = 'S'
       COMMIT TRAN

   /*MROA:  ACTUALIZACION DEL RUBRO COBRO CONSULTA CENTRAL DE RIESGO PARA EL DESEMBOLSO */
   if exists(select 1 from ca_rubro_op_tmp
             where rot_operacion = @w_operacionca
             and   rot_concepto  = @w_parametro_apecr)
   begin
      /*...si el tipo de tramite es UNIFICACION UTILIZACION DE CUPO ..no se debe cobrar APERCRED*/
      select @w_tipo_tramite =  tr_tipo,
             @w_tr_grupo     =  tr_grupo
      from cob_credito..cr_tramite
      where tr_tramite  = @w_tramite_des

      if @w_tipo_tramite = 'U' or (@w_tipo_tramite = 'M' and @w_tr_grupo = 2)  --CCA 436 TRAMITES DE NORMALIZACION
      begin
         update ca_rubro_op_tmp
         set    rot_valor            = 0
         where  rot_operacion  = @w_operacionca
         and    rot_concepto   = @w_parametro_apecr

         if @@error <> 0
         begin
            select @w_error = 707003
            goto ERROR
         end

         update ca_rubro_op_tmp
         set    rot_valor            = 0
         where  rot_operacion           = @w_operacionca
         and    rot_concepto_asociado   = @w_parametro_apecr

         if @@error <> 0
         begin
            select @w_error = 707003
            goto ERROR
         end
      end
      else
      begin
         if @w_lin_credito is null
         begin
            exec @w_error  = sp_rubro_tmp
                 @s_user        = @s_user,
                 @s_term        = @s_term,
                 @s_date        = @s_date,
                 @s_ofi         = @s_ofi,
                 @i_operacion   = 'U',
                 @i_banco       = @i_banco_ficticio,
                 @i_concepto    = @w_parametro_apecr

            if @w_error <> 0 return @w_error
         end
         else
         begin
            select @w_nro_utilizacionres = 0

            select @w_nro_utilizacionres = count(1)
              from ca_operacion_tmp
             where opt_lin_credito  = @w_lin_credito

            if @w_nro_utilizacionres = 1  --PRIMERA UTILIZACION SE COBRA APERCRE
               select @w_cobra_apercre = 'S'
            else
            begin    --CUANDO EXISTEN VARIAS UTILIZACIONES A DESEMBOLSAR
               select opt_operacion into #oper_analisis
                 from ca_operacion_tmp
                where opt_lin_credito  = @w_lin_credito

               if exists(select 1 from ca_transaccion, #oper_analisis   --VALIDA SI EXISTE UNA UTILIZACION DESEMBOLSADA
                          where tr_tran = 'DES'
                            and tr_estado in ('CON','ING')
                            and tr_operacion  = opt_operacion)
                 select @w_cobra_apercre = 'N'
                 else
                 select @w_cobra_apercre = 'S'
            end


            if @w_cobra_apercre = 'S'
            begin

               exec @w_error = sp_rubro_tmp
               @s_user        = @s_user,
               @s_term        = @s_term,
               @s_date        = @s_date,
               @s_ofi         = @s_ofi,
               @i_operacion   = 'U',
               @i_banco       = @i_banco_ficticio,
               @i_concepto    = @w_parametro_apecr

               if @w_error <> 0 return @w_error

            end
            else
            begin
               update ca_rubro_op_tmp set
               rot_valor            = 0
               where rot_operacion  = @w_operacionca
               and   rot_concepto   = @w_parametro_apecr
               if @@error <> 0
               begin
                  print 'desembol.sp Error en actualizacion ca_rubro_tmp '
                  select @w_error = 710568
                  goto ERROR
               end
            end
         end
      end
   end


   /*REQ 402*/
   insert into #rubros_des
   select tipo_gar,
          ru_concepto,
          tipo_concepto = 'DES',
          iva = 'N',
          rre_tipo = ''
   from cob_cartera..ca_rubro, #conceptos
   where ru_fpago = 'L'
   and   codigo = ru_concepto
   and   ru_concepto_asociado is  null


   /*COMICION PERIODICO*/
   insert into #rubros_des
   select tipo_gar,
          ru_concepto,
          tipo_concepto = 'PER',
          iva = 'N',
          rre_tipo = ''
   from cob_cartera..ca_rubro, #conceptos
   where ru_fpago = 'P'
   and   codigo = ru_concepto
   and   ru_concepto_asociado is  null

   /*IVA DESEMBOLSO*/
   insert into #rubros_des
   select tipo_gar,
          ru_concepto,
          tipo_concepto = 'DES',
          iva = 'S',
          rre_tipo = ''
   from cob_cartera..ca_rubro, #conceptos
   where ru_fpago = 'L'
   and   codigo = ru_concepto
   and   ru_concepto_asociado is not null


   /*IVA PERIODICO*/
   insert into #rubros_des
   select tipo_gar,
          ru_concepto,
          tipo_concepto = 'PER',
          iva = 'S',
          rre_tipo = ''
   from cob_cartera..ca_rubro, #conceptos
   where ru_fpago = 'P'
   and   codigo = ru_concepto
   and   ru_concepto_asociado is not null


   /*PADRE*/
   update #rubros_des set
   rre_tipo = tipo_sup
   from #tipo_garantia
   where garantia = tipo

   create table #rubros_esp(
      re_rubro_des    catalogo   null,
      re_iva_des      catalogo   null,
      re_tipo         catalogo   null)

   if ltrim(rtrim(@w_cu_estado)) in ('V','F','P')
   begin
      insert into #rubros_esp   -- FNG
      values (@w_parametro_fng_des, @w_iva_fng_des, @w_cod_gar_fng)

      insert into #rubros_esp   -- FAG
      values (@w_par_fag_des, @w_iva_fag_des, @w_cod_gar_fag)

      insert into #rubros_esp   -- FAG UNICO
      values (@w_par_fag_uni, @w_iva_fag_uni, @w_cod_gar_fag)

      insert into #rubros_esp   -- USAID
      values (@w_par_usaid_des, @w_iva_usaid_des, @w_cod_gar_usaid)

      insert into #rubros_esp   -- FGA
      values (@w_parametro_fga, @w_parametro_fga_iva_uni,@w_cod_gar_fga)
      --REQ379
      insert into #rubros_esp   -- FGU
      values (@w_parametro_fgu, @w_parametro_fgu_iva,@w_cod_gar_fgu)
   end

   /*REQ 402*/
   insert into #rubros_esp
   select
   re_rubro_des = rre_concepto,
   re_iva_des   = '',
   re_tipo      = rre_tipo
   from #rubros_des
   where tipo_concepto = 'DES'
   and   iva = 'N'

   update #rubros_esp set
   re_iva_des = rre_concepto
   from #rubros_des
   where tipo_concepto = 'DES'
   and   iva = 'S'
   and   rre_concepto = re_rubro_des


   select @w_rubro_des = ''

   while 1=1
   begin
      select top 1
             @w_rubro_des = re_rubro_des,
             @w_iva_des   = re_iva_des
        from #rubros_esp
       where re_rubro_des > @w_rubro_des
       order by re_rubro_des

      if @@rowcount = 0
      begin
         break
      end

      if exists (select 1 from ca_rubro_op_tmp, #rubros_esp
                  where rot_operacion     = @w_operacionca
                    and rot_concepto      = @w_rubro_des
                    and re_rubro_des      = rot_concepto)
      begin

         --print 'desembol.sp... @w_rubro_des ' + CAST (@w_rubro_des as varchar)

         exec @w_error = sp_rubro_tmp
            @s_user      = @s_user,
            @s_term      = @s_term,
            @s_date      = @s_date,
            @s_ofi       = @s_ofi,
            @i_operacion = 'U',
            @i_banco     = @i_banco_ficticio,
            @i_concepto  = @w_rubro_des

        if @w_error <> 0
      begin
          print 'desembol.sp... Error en  @w_rubro_des ' + CAST (@w_rubro_des as varchar) + ' @w_error: ' + CAST (@w_error as varchar)
           return @w_error
      end


         update ca_rubro_op set
                ro_valor         = rot_valor,
                ro_porcentaje     = rot_porcentaje,
                ro_porcentaje_efa = rot_porcentaje_efa,
                ro_porcentaje_aux = rot_porcentaje_efa,
                ro_base_calculo  = rot_base_calculo
           from ca_rubro_op_tmp
          where rot_operacion = @w_operacionca
            and rot_concepto in (@w_rubro_des, @w_iva_des)
            and rot_operacion = ro_operacion
            and rot_concepto  = ro_concepto

          if @@error <> 0
         begin
           select @w_error = 707006
           goto ERROR
         end

      end -- if exists
      else
      begin
         --print 'calculo DES ' + @w_rubro_des + ' ' + @w_iva_des
         update ca_rubro_op_tmp set
                rot_valor = 0
          where rot_operacion = @w_operacionca
            and rot_concepto in (@w_rubro_des, @w_iva_des)

        if @@error <> 0
         begin
           select @w_error = 707006
           goto ERROR
         end


         update ca_rubro_op set
                ro_valor = 0
          where ro_operacion = @w_operacionca
            and ro_concepto in (@w_rubro_des, @w_iva_des)

         if @@error <> 0
         begin
           select @w_error = 707006
           goto ERROR
         end

      end
   end -- while 1=1
   -- FIN JAR REQ 197

   ---ACTUALIZAR LOS VALORES SI EL ESTADO DE A GARANTIA NO ES VALIDO
   if ltrim(rtrim(@w_cu_estado)) not in ('V','F','P')
   begin
      update ca_rubro_op_tmp
      set    rot_valor = 0
      where  rot_operacion = @w_operacionca
      and    rot_concepto in (@w_parametro_fag, @w_parametro_fng, @w_parametro_fogacafe, @w_parametro_usaid,@w_par_usaid_des, @w_par_fag_uni, @w_parametro_fga, @w_parametro_fgu,
                             @w_iva_usaid_des,@w_iva_fag_uni,@w_iva_fag_des,@w_iva_fng_des,@w_parametro_fga_iva_uni)
      or     rot_concepto in (select  re_rubro_des   from #rubros_esp)

        if @@error <> 0
	      begin
	        select @w_error = 711028
	        goto ERROR
	      end

         update ca_rubro_op set
                ro_valor = 0
          where ro_operacion = @w_operacionca
            and ro_concepto in(  @w_parametro_fag, @w_parametro_fng, @w_parametro_fogacafe, @w_parametro_usaid,@w_par_usaid_des, @w_par_fag_uni, @w_parametro_fga, @w_parametro_fgu,
            @w_iva_usaid_des,@w_iva_fag_uni,@w_iva_fag_des,@w_iva_fng_des,@w_parametro_fga_iva_uni)
            or  ro_concepto in (select re_rubro_des   from #rubros_esp)
         if @@error <> 0
	      begin
	        select @w_error = 711028
	        goto ERROR
	      end
   end --Estados no validos de GARANTIA ESPECIAL

   if @w_estado in (0, 99)
   begin
      if @w_tipo = 'D'
      begin
         --SE COBRAN INTERESES ANTICIPADOS SOLO EN LA LIQUIDACION
         select @w_int_ant = round(sum(amt_cuota),2)
         from   ca_amortizacion_tmp,ca_rubro_op_tmp
         where  amt_operacion  = @w_operacionca
         and    rot_operacion  = @w_operacionca
         and    rot_concepto   = amt_concepto
         and    rot_tipo_rubro = 'I'
         and    rot_fpago      = 'A'

         select @w_anticipados = round((@w_anticipados + isnull(@w_int_ant,0)),2)
      end
      else
      begin
         --SE COBRAN INTERESES ANTICIPADOS SOLO EN LA LIQUIDACION
         select @w_int_ant = sum(amt_cuota)
         from   ca_amortizacion_tmp,ca_rubro_op_tmp
         where  amt_operacion  = @w_operacionca
         and    amt_dividendo  = 1
         and    rot_operacion  = @w_operacionca
         and    rot_concepto   = amt_concepto
         and    rot_fpago      = 'A'

         select @w_anticipados = @w_anticipados + isnull(@w_int_ant,0)
      end
   end

   ---  INSTRUCCION OPERATIVA
   select @w_instrucciones = 'N'
   if exists (select 1 from cob_credito..cr_instrucciones
              where in_tramite = @w_tramite_des
              and in_login_eje is null
              and in_fecha_eje is null
              and in_estado    = 'A')
   select @w_instrucciones = 'S'

   -- SI SE TRATA DE CAPITALIZACION, NO GENERAR GASTOS ANTICIPADOS
   if @i_capitalizacion = 'S'
      select @w_anticipados = 0.00

   insert into tmp_rubros_d
   select rot_concepto, co_descripcion, rot_valor, @@spid
   from   ca_rubro_op_tmp,
          ca_concepto,
          ca_rubro
   where  rot_operacion = @w_operacionca
   and    co_concepto   = rot_concepto
   and    ru_concepto   = rot_concepto
   and    ru_concepto   = co_concepto
   and    ru_toperacion = @w_toperacion
   and    ru_moneda     = @w_moneda_op
   and    (rot_valor     > 0.00 or  @w_concepto_gmf = ru_concepto)
   and   ((rot_fpago = 'L' and ru_banco = 'S' ) or rot_tipo_rubro = 'C')
   order by rot_tipo_rubro, rot_concepto

   if @w_estado in (0, 99)
   begin
      if @w_tipo = 'D'
      begin
         insert into tmp_rubros_d
         select amt_concepto, substring(co_descripcion,1,40), convert(float, sum(amt_cuota)), @@spid
         from   ca_amortizacion_tmp,ca_concepto,ca_rubro_op_tmp
         where  amt_operacion = @w_operacionca
         and    amt_concepto  = co_concepto
         and    rot_operacion  = @w_operacionca
         and    rot_concepto   = amt_concepto
         and    amt_cuota      > 0.00
         and    rot_fpago      ='A'
         group by amt_concepto,co_descripcion
      end
      else
      begin
         insert into tmp_rubros_d
         select amt_concepto, substring(co_descripcion,1,40), convert(float, amt_cuota), @@spid
         from   ca_amortizacion_tmp,ca_concepto,ca_rubro_op_tmp
         where  amt_operacion = @w_operacionca
         and    amt_dividendo = 1
         and    amt_concepto  = co_concepto
         and    rot_operacion  = @w_operacionca
         and    rot_concepto   = amt_concepto
         and    amt_cuota      > 0
         and    rot_fpago    ='A'
      end
   end

   if exists(select 1 from tmp_rubros_d where rot_concepto = @w_concepto_gmf)
   begin

        select @w_monto_mop = sum(dm_monto_mop)
        from ca_desembolso
        where dm_operacion  = @w_operacionca
        and   (dm_cruce_restrictivo = 'N'
        or    (dm_cruce_restrictivo = 'S' and dm_destino_economico = 5))

        select @w_monto_mop = isnull(@w_monto_mop,0) + isnull(@i_monto_ds,0)

        select @w_vlr_gmf  = isnull((@w_monto_mop * ro_porcentaje) /100,0)
        from   ca_rubro_op
        where  ro_operacion = @w_operacionca
        and    ro_concepto  = @w_concepto_gmf

        update tmp_rubros_d
        set    rot_valor   =  @w_vlr_gmf
        where  rot_concepto = @w_concepto_gmf

        update ca_rubro_op
        set    ro_valor        = @w_vlr_gmf ,
               ro_base_calculo = @w_monto_mop
        where  ro_operacion    = @w_operacionca
        and    ro_concepto     = @w_concepto_gmf

        if @@error <> 0
         begin
           select @w_error = 707006
           goto ERROR
         end


        update ca_rubro_op_tmp
        set    rot_valor        = @w_vlr_gmf ,
               rot_base_calculo = @w_monto_mop
        where  rot_operacion    = @w_operacionca
        and    rot_concepto     = @w_concepto_gmf

        if @@error <> 0
         begin
           select @w_error = 707006
           goto ERROR
         end


   end
   ---  CALCULA ANTICIPADOS PARA DESCONTAR DEL DESEMBOLSO
   select @w_anticipados = round(isnull(sum(rot_valor),0),2)
   from   ca_rubro_op_tmp,
          ca_rubro
   where  rot_operacion = @w_operacionca
   and    rot_fpago     = 'L'
   and    rot_concepto  = ru_concepto
   and    ru_banco      = 'S'
   and    ru_toperacion = @w_toperacion
   and    ru_moneda     = @w_moneda_op

   select @w_anticipados = isnull(@w_anticipados, 0)

   -- REQ. 366 GENERA MONTO BASE DE LA OPERACION
   -- Validacion Seguros asociados

   if exists (select 1 from cob_credito..cr_seguros_tramite
            where st_tramite = @w_tramite)
   and @w_op_tipo_amortizacion <> @w_tflexible -- 392
   begin

      select @w_monto_seguros = 0

      -- Calcula el valor total del seguro, incluyendo tipos de seguros antiguos o totalmente nuevos
      select @w_monto_seguros = isnull(sum(isnull(ps_valor_mensual,0) * isnull(datediff(mm,as_fecha_ini_cobertura,as_fecha_fin_cobertura),0)),0)
      from cob_credito..cr_seguros_tramite with (nolock),
           cob_credito..cr_asegurados      with (nolock),
           cob_credito..cr_plan_seguros_vs
      where st_tramite           = @w_tramite
      and   st_secuencial_seguro = as_secuencial_seguro
      and   as_plan              = ps_codigo_plan
      and   st_tipo_seguro       = ps_tipo_seguro
      and   ps_estado            = 'V'
      and   as_tipo_aseg         = (case when ps_tipo_seguro in(2,3,4) then 1 else as_tipo_aseg end)

     update ca_operacion_tmp
     set opt_monto       = opt_monto + @w_monto_seguros
     where opt_operacion = @w_operacionca

      if @@ERROR <> 0
      begin
         select @w_error = 724533
         goto ERROR
      end

      update ca_operacion_tmp
     set opt_monto_aprobado = opt_monto
     where opt_operacion    = @w_operacionca

      if @@ERROR <> 0
      begin
         select @w_error = 724533
         goto ERROR
      end

      update ca_rubro_op_tmp
     set rot_valor = rot_valor + @w_monto_seguros
     where rot_operacion = @w_operacionca
     and   rot_concepto  = 'CAP'

      if @@ERROR <> 0
      begin
         select @w_error = 724533
         goto ERROR
      end

     update tmp_rubros_d
     set rot_valor = rot_valor + @w_monto_seguros
     where rot_concepto = 'CAP'

      if @@ERROR <> 0
      begin
         select @w_error = 724533
         goto ERROR
      end
   end  -- Fin Generar monto base de la operación Req. 366


   if @i_origen = 'F'
   begin
      select opt_toperacion,
             B.valor,
             opt_moneda,
             mo_descripcion,
             convert(float, opt_monto),
             convert(float, opt_monto_aprobado),
             convert(varchar(10),opt_fecha_ult_proceso, @i_formato_fecha),
             of_nombre,
             convert(float, @w_anticipados),
             convert(float, opt_monto - @w_anticipados),
             opt_cliente ,
             opt_prd_cobis,
             opt_tipo,
             opt_sujeta_nego,
             opt_tipo_cambio,
             opt_nombre,
             @w_instrucciones,
             CT.valor clase_cartera,
             es_descripcion desc_estado,
             of_oficina,
             opt_tramite, --21
             opt_operacion -- 22 REQ 392
      from   ca_operacion_tmp,
             cobis..cl_moneda,
             cobis..cl_oficina,
             cobis..cl_tabla A,
             cobis..cl_catalogo B,
             cobis..cl_tabla CC,
             cobis..cl_catalogo CT,
             ca_estado
      where  opt_operacion = @w_operacionca
      and    opt_moneda    = mo_moneda
      and    opt_oficina   = of_oficina
      and    A.codigo      = B.tabla
      and    A.tabla       = 'ca_toperacion'
      and    B.codigo      = opt_toperacion
      and    CC.tabla      = 'cr_clase_cartera'
      and    CC.codigo     = CT.tabla
      and    CT.codigo     = opt_clase
      and    es_codigo     = opt_estado

      if @@rowcount = 0
      begin
          print 'desembol.sp linea no existe end el  catalogo ca_toperacion o clase en cr_clase_cartera Revisar '
          select @w_error = 710088
          goto ERROR
      end
   end
   else
   begin
      if @i_renovaciones = 'S'
      begin
         select @o_anticipado = isnull(@w_anticipados,0) - isnull(@w_monto_seguros,0)
         if @o_anticipado < 0
            select @o_anticipado = 0
      end
      else
         select @o_anticipado = isnull(@w_anticipados,0)
   end

   if @i_origen = 'F'
   begin
      select 'RUBRO'       = substring(rot_concepto,1,15),
             'DESCRIPCION' = substring(co_descripcion,1,35),
             'VALOR      ' = convert(float, rot_valor)
      from   tmp_rubros_d
      where  spid = @@spid
   end

   if @i_consulta is null and @i_origen = 'F'
      select @i_operacion = 'S'

end

-- NUEVO DESEMBOLSO
if @i_operacion = 'I'
begin
   select @w_retorno = 0
   -- RQ500, VALIDAR OBLIGATORIEDAD DE GARANTIA FAG PARA FINAGRO
   if @w_tramite <> 0 or @w_tramite is not null
   begin

      -- obtiene linea de credito del tramite
      select @w_linea_tramite = tr_toperacion,
             @w_monto_op      = tr_monto
      from cob_credito..cr_tramite
      where tr_tramite = @w_tramite

      if exists (select top 1 1
                 from cob_credito..cr_corresp_sib s, cobis..cl_tabla t, cobis..cl_catalogo c
                 where s.descripcion_sib = t.tabla
                 and s.tabla             = 'T301'
                 and t.codigo            = c.tabla
                 and c.estado            = 'V'
                 and c.codigo            = @w_linea_tramite)
      begin
         --CCA 500 EVALUACION DEL MONTO PARA LINEAS DE CREDITO FINAGRO
         exec @w_error   = cob_credito..sp_val_monto_finagro
	         @i_monto    = @w_monto_op,
            @i_linea    = @w_linea_tramite,
            @i_cliente  = @w_cliente,
	         @o_retorno  = @w_retorno out

         if @w_retorno <> 0
         begin
            select @w_error = @w_retorno
            goto   ERROR
         end
      end

      exec @w_error = cob_credito..SP_VAL_OBLI_FAG
        @i_tramite = @w_tramite,
        @o_retorno = @w_retorno out

      if @w_retorno <> 0
      begin
         select @w_error = @w_retorno
         goto   ERROR
      end
   end

   -- CCA 479 - VALIDA HORA DE DESEMBOLSO PARA FINAGRO
   exec @w_error       = sp_val_hora_des_finagro
        @i_operacionca = @w_operacionca

   if @w_error <> 0
   begin
      if @i_externo = 'S' ROLLBACK TRAN
      select @w_error = @w_error
      goto ERROR
   end

   -- DETERMINAR EL VALOR DE COTIZACION DEL DIA
   if @w_moneda = @w_moneda_local
      select @w_cotizacion = 1.0
   else
   begin
      exec sp_buscar_cotizacion
      @i_moneda     = @w_moneda,
      @i_fecha      = @w_fecha_ini_oper,
      @o_cotizacion = @w_cotizacion output
   end

   select @w_aceptable = 1.0 / @w_cotizacion

   select @w_operacionca = opt_operacion,
          @w_op_monto    = opt_monto,
          @w_tramite     = opt_tramite,
          @w_tipo        = opt_tipo
   from   ca_operacion_tmp
   where  opt_banco = @i_banco_ficticio

   select @w_operacionca_real = op_operacion,
          @w_sector           = op_sector,
          @w_tramite          = op_tramite
   from   ca_operacion
   where  op_banco = @i_banco_real

   if exists ( select 1 from ca_operacion, ca_rubro_op
               where ro_operacion =  op_operacion
               and   ro_porcentaje = 0.03
               and   ro_concepto = 'SEGDEUVEN'
               and   op_operacion  = @w_operacionca_real)
   begin
      print 'POR FAVOR COMUNICARSE CON OPERACIONES, DESISTIR TRAMITE, TRAMITE CON TASA DE SEGURO (SEGDEUVEN): 0.03'
      return 0
   end

   -- CONTROL DE LA TASA IBC ANTES DEL DESEMBOLSO
   -- PORQUE PUEDE HABER PASADO ALGUN TIEMPO DESDE
   -- QUE SE APROBABO EL CREDITO Y LA FECHA DEL
   -- DESEMBOLSO
   -- ********************************************

   select @w_tasa_aplicar     = ro_referencial,
          @w_porcentaje       = ro_porcentaje
   from   ca_rubro_op
   where  ro_operacion = @w_operacionca_real
   and    ro_concepto  = @w_siglas_int

   if @@rowcount = 0
   begin
       select @w_tasa_aplicar     = ro_referencial,
              @w_porcentaje       = ro_porcentaje
       from   ca_rubro_op
       where  ro_operacion = @w_operacionca_real
       and    ro_concepto  = @w_siglas_intant

       select @w_siglas_int = @w_siglas_intant
   end

   select @w_tasa_referencial = vd_referencia
   from   ca_valor_det
   where  vd_tipo   =  @w_tasa_aplicar
   and    vd_sector =  @w_sector

   select @w_modalidad         = tv_modalidad,
          @w_periodicidad      = tv_periodicidad
   from   ca_tasa_valor
   where  tv_nombre_tasa = @w_tasa_referencial
   and    tv_estado        = 'V'
/*   NO REALIZAR ESTE CONTROL PARA LA VERSION DE CAJA NOR PERU
   if @@rowcount = 0
   begin
      select @w_error = 710438
      goto   ERROR
   end

   exec @w_error    = sp_rubro_control_ibc
        @i_operacionca    = @w_operacionca_real,
        @i_concepto       = @w_siglas_int,
        @i_porcentaje     = @w_porcentaje,
        @i_periodo_o      = @w_periodicidad,
        @i_modalidad_o    = @w_modalidad,
        @i_num_periodo_o  = 1

   if @w_error <> 0
   begin
       print 'desembol.sp...Mensaje Informativo Tasa Total de Interes supera el maximo permitido...'
   end
*/
   -- DECIMALES DE LA MONEDA DE LA OPERACION Y NACIONAL
   exec @w_error = sp_decimales
        @i_moneda       = @i_moneda_ds,
        @o_decimales    = @w_num_dec_ds out,
        @o_dec_nacional = @w_num_dec_mn out

   if @w_error <> 0
   begin
       select @w_error = @w_error
       goto ERROR
   end

   -- DECIMALES DE LA MONEDA DEL DESEMBOLSO
   exec @w_error = sp_decimales
        @i_moneda       = @i_moneda_op,
        @o_decimales    = @w_num_dec_op out,
        @o_dec_nacional = @w_num_dec_mn out

   if @w_error <> 0
   begin
       select @w_error = @w_error
       goto ERROR
   end

   -- VERIFICAR DECIMALES DE ENTRADA
   if round(@i_monto_ds, @w_num_dec_ds)  <> round(@i_monto_ds, @w_num_dec_ds)
   begin
       select @w_error = 708193
       goto ERROR
   end

   -- VERIFICAR QUE LAS COTIZACIONES NO SEAN CERO
   if @i_cotiz_op * @i_cotiz_ds = 0
   begin
       select @w_error = 701070
       goto ERROR
   end
   
   select @i_monto_ds  = round(@i_monto_ds,@w_num_dec_op)

   ---CALCULAR MONTO OP Y MONTO MN
   if @i_moneda_ds = @i_moneda_op
   begin
       if @i_moneda_op = @w_moneda_local
          select @w_convertir_valor = 'N'
       else
       select @w_convertir_valor = 'S'
   end
   ELSE
   begin
       select @w_convertir_valor = 'S'
   end

   if @w_convertir_valor = 'S'
   begin
       select @i_monto_ds  = round(@i_monto_ds,@w_num_dec_mn)
       select @w_monto_mn  = @i_monto_ds * @i_cotiz_ds
       select @w_monto_mn  = round(@w_monto_mn,@w_num_dec_mn)
       select @w_monto_op  = round(convert(float,@w_monto_mn) / convert(float,@i_cotiz_op), @w_num_dec_op)
   end
   else
   begin
       select @w_monto_mn = round(@i_monto_ds,@w_num_dec_op)
       select @w_monto_op = round(@i_monto_ds,@w_num_dec_op)
   end

   -- CALCULAR NUMERO SECUENCIAL
   select @w_secuencial = isnull(max(dm_secuencial),-1)--------------------------LGU
   from   ca_desembolso
   where  dm_operacion = @w_operacionca_real
   and    dm_estado    = 'NA'

   if @@rowcount = 0 OR @w_secuencial = -1   OR @i_secuencial > 0
   begin
       exec @w_secuencial = sp_gen_sec
            @i_operacion  = @w_operacionca_real
   end

   --- CALCULAR NUMERO DE LINEA
   select @w_desembolso = max(dm_desembolso) + 1
   from   ca_desembolso
   where  dm_secuencial = @w_secuencial
   and    dm_operacion  = @w_operacionca_real
   and    dm_estado     = 'NA'

   if @w_desembolso is null
      select @w_desembolso = 1

   -- CONTROLES PARA NO SOBREPASAR MONTO DE LA OPERACION
   select @w_total = sum(dm_monto_mop)
   from   ca_desembolso
   where  dm_operacion  = @w_operacionca_real
   and    dm_secuencial = @w_secuencial
   and    dm_desembolso > 0
   and    dm_monto_mop  > 0

   select @w_total = isnull(@w_total, 0)
   select @w_diff  = sum(@w_total + @w_monto_op - @w_op_monto)

   if (@w_total + @w_monto_op > @w_op_monto) and @w_moneda_uvr <> @w_moneda
   begin
--     PRINT 'desembol.sp REVISAR  VALORES  @w_total ' + CAST(@w_total AS VARCHAR) + ' @w_monto_op ' + CAST(@w_monto_op AS VARCHAR) + ' @w_op_monto ' + CAST(@w_op_monto AS VARCHAR)
     select @w_error = 708215
     goto ERROR
   end

   if (@w_diff > @w_aceptable) and (@w_moneda_uvr = @w_moneda)
   begin
--       PRINT 'desembol.sp REVISAR  VALORES  @w_total ' + CAST(@w_total AS VARCHAR) + ' @w_monto_op ' + CAST(@w_monto_op AS VARCHAR) + ' @w_op_monto ' + CAST(@w_op_monto AS VARCHAR)
       select @w_error = 708215
       goto ERROR
   end

   --EPB:18FEB2004
   --VALIDACION PARA QUE TODA OBLIGACION TENGA EL RUBRO TIMBRE CON EXCEPCION DE
   --LAS OBLIGACIONES QUE TIENEN GARANTIA HIPOTECARIA
   if @w_tramite is not null and @w_tipo  not in ('R','G','O')
   begin
       select @w_rango_min = tur_valor_min
       from   ca_tablas_un_rango
       where  tur_concepto = @w_timbre

       select @w_monto_timbre = round((@w_op_monto_aprobado * @w_cotizacion),@w_num_dec_mn)

       if  @w_monto_timbre >= @w_rango_min and (@i_concepto is null   or @i_concepto = '')
       begin
           if not exists (select 1 from ca_rubro_op
                          where ro_operacion = @w_operacionca_real
                          and   ro_concepto = @w_timbre
                          and   ro_valor > 0   )
           begin
               select @w_tipogar_hipo = pa_char
               from cobis..cl_parametro
               where pa_producto = 'CCA'
               and   pa_nemonico = 'GARHIP'
               set transaction isolation level read uncommitted

               --SI EL VALOR DEL TIMBRE ESA EN 0 Y ES HIPOTECARIO NO HAY PROBLEMA
               if exists (select 1
                          from cob_credito..cr_gar_propuesta,
                               cob_custodia..cu_custodia,
                               cob_custodia..cu_tipo_custodia
                          where cu_codigo_externo = gp_garantia
                          and gp_tramite = @w_tramite
                          and tc_tipo    = cu_tipo
                          and cu_estado  in ('V','F','P')
                          and tc_tipo_superior = @w_tipogar_hipo )
               begin
                   select @i_concepto  = 'SEGUN ARTICULO 530 NUMEROL 54 DEL ESTATUTO TRIBUTARIO, CONCEPTO 001195 DEL 10 DE ENERO 2002 EXPEDIDO POR La  DIAN'
                   select @w_rango_min = @w_rango_min
               end
               else
               begin
                   select @w_error = 710500
                   goto ERROR
               end
           end
           else
               select @i_concepto  = null,
                      @w_rango_min = null
       end ---MONTO DA PARA COBRO DE TIMBRE
   end --TRAMITE <> NULL

   -- DIVIDENDO DEL ESTADO VIGENTE
   select @w_dividendo = di_dividendo
   from   ca_dividendo
   where  di_operacion = @w_operacionca_real
   and    di_estado    = 1

   if @@rowcount = 0
      select @w_dividendo = 1

   --VALIDACION DE LA EXISTENCIA DEL RUBRO INT EN LA TABLA CON
   --CAUSACION = 'S'
   if not exists (select 1 from  ca_rubro_op
                  where ro_operacion = @w_operacionca_real
                  and ro_tipo_rubro = 'I'
                  and  ro_provisiona = 'S')
   Begin
       select @w_error = 710538
       goto ERROR
   end
   
    --MC Actualizacion de las cuentas individuales
    if @i_grupal = 'S'
        update cob_credito..cr_tramite_grupal
        set tg_cuenta = ea_cta_banco
        from cobis..cl_ente_aux
        where tg_cliente= ea_ente
        and tg_grupo    = @i_grupo_id
        and tg_tramite  = @i_tramite
        and tg_grupal   = @i_grupal

   insert into ca_desembolso
         (dm_secuencial,      dm_operacion,         dm_desembolso,
          dm_producto,        dm_cuenta,            dm_beneficiario,
          dm_oficina_chg,     dm_usuario,           dm_oficina,
          dm_terminal,        dm_dividendo,         dm_moneda,
          dm_monto_mds,       dm_monto_mop,         dm_monto_mn,
          dm_cotizacion_mds,  dm_cotizacion_mop,    dm_tcotizacion_mds,
          dm_tcotizacion_mop, dm_estado,            dm_cod_banco,
          dm_cheque,          dm_fecha,             dm_prenotificacion,
          dm_carga,           dm_concepto,          dm_valor,
          dm_ente_benef,      dm_idlote,          dm_cruce_restrictivo,
          dm_destino_economico,  dm_carta_autorizacion)
   values(@w_secuencial,      @w_operacionca_real,  @w_desembolso,
          @i_producto,        @i_cuenta,            @i_beneficiario,
          @i_oficina_chg,     @s_user,              @s_ofi,
          @s_term,            @w_dividendo,         @i_moneda_ds,
          @i_monto_ds,        @w_monto_op,          @w_monto_mn,
          @i_cotiz_ds,        @i_cotiz_op,          @i_tcotiz_ds,
          @i_tcotiz_op,       'NA',                 @i_cod_banco_ach,
          @i_cheque,          @w_fecha_proceso,     @i_prenotificacion,
          @i_carga,           @i_concepto,          @w_rango_min,
          @i_ente_benef,      0,               @i_cruce_restrictivo,
          @i_destino_economico,   @i_carta_autorizacion)

   if @@error <> 0
   begin
       select @w_error = 710001
       goto ERROR
   end

   if exists (select 1 from cob_credito..cr_seguros_tramite       -- Req. 366 Seguros
              where st_tramite = @w_tramite)
   begin
      if @i_renovaciones = 'S'
      begin
         exec @w_error      = sp_seguros
              @i_opcion          = 'R'       ,
              @i_tramite         = @w_tramite

         if @w_error <> 0 return @w_error
      end
   end          -- Fin Req. 366 Seguros

   --CEH REQ 00264   - DESEMBOLSOS GMF
   select @w_clave1 = convert(varchar(255),@w_operacionca_real)

   exec @w_error = sp_tran_servicio
        @s_user    = @s_user,
        @s_date    = @s_date,
        @s_ofi     = @s_ofi,
        @s_term    = @s_term,
        @i_tabla   = 'ca_desembolso',
        @i_clave1  = @w_clave1

   if @w_error <> 0
   begin
      goto ERROR
   end
   -- FIN REQ 00264

   -- INI JAR REQ 218 - ALERTAS CUPOS
   exec @w_error = cob_credito..sp_alertas
        @i_cliente = @w_cliente

   if @w_error <> 0 goto ERROR
   -- FIN JAR REQ 218

   ---32097
   if @w_tramite is not null and @w_tramite > 0
   begin
       if not exists (select 1 from cob_credito..cr_deudores
                      where de_tramite =   @w_tramite
                      and   de_cliente =   @w_cliente)
       begin
         insert into cob_credito..cr_deudores
         select op_tramite,op_cliente,'D',en_ced_ruc,null,'S'
          from ca_operacion,cobis..cl_ente
         where op_tramite  = @w_tramite
         and op_cliente = en_ente
       end
   end

   if @i_externo = 'S'
   begin
       select @o_secuencial = convert(varchar(20),@w_secuencial)
       select @i_operacion = 'S'
   end
end --FIN @i_operacion = 'I'
    -- se comenta para la version MX--
	--if @w_op_tipo = 'O'
	---begin
	--Desde un inicio la operacion se trabajara como manual por el tipo de tabla que se
	--manejara en los desembolsos parciales
	-- update ca_operacion
	-- set    op_tipo_amortizacion = 'MANUAL'
	-- where  op_banco = @i_banco_real

	--  if @@error <> 0
	-- begin
	--    select @w_error = 705076
	--   goto ERROR
	--end

--end

-- ELIMINAR REGISTRO DESEMBOLSO
if @i_operacion = 'D'
begin
    select @w_operacionca_real = op_operacion
    from   ca_operacion
    where  op_banco = @i_banco_real

    delete ca_desembolso
    where dm_secuencial = @i_secuencial
    and   dm_desembolso = @i_desembolso
    and   dm_operacion  = @w_operacionca_real

    if @@error <> 0
    begin
        select @w_error = 710003
        goto ERROR
   end
    --Actualizar los numeros de cheque a 0 cuando se elimina la forma  de desembolo
    UPDATE cob_credito..cr_tramite_grupal SET tg_cheque=0 WHERE tg_referencia_grupal=@i_banco_real AND tg_operacion=@w_operacionca_real 
end --Fin @i_operacion = 'D'

-- SEARCH
if @i_operacion = 'S'
begin
    select @w_operacionca = opt_operacion
    from   ca_operacion_tmp
    where  opt_banco = @i_banco_real

    if @i_secuencial is null
    begin
        select @i_secuencial = min(dm_secuencial)
        from   ca_desembolso
        where  dm_operacion  = @w_operacionca
        and    dm_estado     = 'NA'
        select @i_secuencial = isnull(@i_secuencial, 0)
    end

    select 'No.'                    = dm_desembolso,
           'Forma'                  = dm_producto,
           'Mon.'                   = dm_moneda,
           'Moneda'                 = substring((select mo_descripcion from cobis..cl_moneda
                                                 where mo_moneda = x.dm_moneda),1,10),
           'Valor             '     = convert(float, dm_monto_mds),
           'TC.  '                  = 'COT',
           'Cotiz.        '         = convert(float, dm_cotizacion_mds),
           'Valor OP          '     = convert(float, dm_monto_mop),
           'TC. OP'                 = dm_tcotizacion_mop + 'RM',
           'Cotiz OP      '         = convert(float,dm_cotizacion_mop),
           'Valor MN          '     = convert(float, dm_monto_mn),
           'Referencia'             = substring(dm_cuenta,1,16),
           'Beneficiario.'          = substring(dm_beneficiario,1,30),
           'Cod.Oficina'            = dm_oficina_chg,
           'Oficina '               = substring(of_nombre,1,20),
           --'Temporal SMO'           = '2',
           'Secuencial'             = dm_secuencial,
           'Categoria '             = cp_categoria,
           'Ins. ACH '              = dm_prenotificacion,
           'Concepto General'       = dm_concepto
    from ca_desembolso x
         inner join cobis..cl_oficina on
                    dm_secuencial = @i_secuencial
             and    dm_operacion  = @w_operacionca
             and    dm_desembolso  >= 0
                    left outer join ca_producto on
                         dm_oficina_chg = of_oficina
                         where dm_producto = cp_producto
end --Fin @i_operacion = 'S'

if exists (select 1
           from cob_custodia..cu_custodia,
           cob_credito..cr_gar_propuesta,
           cob_credito..cr_tramite
           where gp_tramite  = @w_tramite
           and gp_garantia = cu_codigo_externo
           and cu_estado   in ('V','F','P')
           and tr_tramite  = gp_tramite
           and cu_tipo in (select tipo from #tipo_garantia))
begin

   -- Se busca el monto por el cual fue aprobado el credito sin los seguros.
   select @w_op_monto_aprobado = isnull(tr_monto_solicitado ,0)
   from  cob_credito..cr_tramite
   where tr_tramite = @w_tramite

   select @w_monto_seguros_gar = 0

   --REQ 366 Para las operaciones con garantias especiales se consulta si el tremite tiene seguros asociados
   if exists (select 1 from cob_credito..cr_seguros_tramite
           where st_tramite = @w_tramite)
   begin
      --if @w_op_tipo_amortizacion != @w_tflexible
      begin
         -- Calcula el valor total del seguro, incluyendo tipos de seguros antiguos o totalmente nuevos
         select @w_monto_seguros_gar = isnull(sum(isnull(ps_valor_mensual,0) * isnull(datediff(mm,as_fecha_ini_cobertura,as_fecha_fin_cobertura),0)),0)
         from cob_credito..cr_seguros_tramite with (nolock),
              cob_credito..cr_asegurados      with (nolock),
              cob_credito..cr_plan_seguros_vs
         where st_tramite           = @w_tramite
         and   st_secuencial_seguro = as_secuencial_seguro
         and   as_plan              = ps_codigo_plan
         and   st_tipo_seguro       = ps_tipo_seguro
         and   ps_estado            = 'V'
         and   as_tipo_aseg         = (case when ps_tipo_seguro in(2,3,4) then 1 else as_tipo_aseg end)
      end
   end

   select @w_op_monto_aprobado = round((@w_op_monto_aprobado + @w_monto_seguros_gar) * @w_porcentaje_gar/100,0)

   select @w_diff = 0.0
   select @w_diff = @w_valor_respaldo - @w_op_monto_aprobado

   if  @w_diff  > @w_vlr_despreciable
   begin
      print ' Error: Vr Aprobado = ' + convert(varchar, @w_op_monto_aprobado)
         + ', Vr Seguros = ' + convert(varchar, @w_monto_seguros_gar)
         + ', % Gar = ' + convert(varchar, @w_porcentaje_gar)
         + ', diff = ' + convert(varchar, @w_diff)
         + ', Vr Respaldo  = ' + convert(varchar, @w_valor_respaldo)
      select @w_error = 2101114
      goto ERROR
   end
end


SET ARITHABORT OFF

delete tmp_rubros_d where spid = @@spid
delete tmp_gar_especiales where spid = @@spid
--delete tmp_garantias_tramite where spid = @@spid
return 0

SET ARITHABORT OFF
ERROR:
delete tmp_rubros_d where spid = @@spid
if (@i_externo = 'S'  or   @i_crea_ext is null)
begin
    exec cobis..sp_cerror
         @t_debug   = 'N',
         @t_file    = null,
         @t_from    = @w_sp_name,
         @i_num     = @w_error
        return @w_error
end
else begin
    select @o_msg_msv = 'Error en borrado de tablas temporales Rubros' + @w_sp_name
    return @w_error
end
go

