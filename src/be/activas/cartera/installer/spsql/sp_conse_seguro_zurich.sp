/************************************************************************/
/*   Archivo:              sp_conse_seguro_zurich.sp                    */
/*   Stored procedure:     sp_conse_seguro_zurich                       */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         Johan Castro                                 */
/*   Fecha de escritura:   Septiembre 21                                */
/************************************************************************/
/*   IMPORTANTE                                                         */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*   PROPOSITO                                                          */
/*   consultas del WebService Seguros Zurich                            */
/*                                                                      */
/*   MODIFICACIONES                                                     */
/*  21/09/2020    Johan castro    version inicial Requerimiento 141620  */
/*  16/04/2021    Sonia Rojas     Error #155179                         */
/*  04/11/2021    ACH             Err#171995 Doc de Seg sin info ID     */
/*  30/11/2021    ACH             #144022-reportado en comentario#67y#69*/
/*  16/06/2022    KVI             Req.185234-Op.R Seg.Individual        */
/************************************************************************/
use cob_cartera
go
 
if exists (select 1 from sysobjects where name = 'sp_conse_seguro_zurich')
   drop proc sp_conse_seguro_zurich
go

create proc sp_conse_seguro_zurich
(  @s_ssn              int          = null,
   @s_sesn             int          = null,
   @s_srv              varchar (30) = null,
   @s_lsrv             varchar (30) = null,
   @s_user             login        = null,
   @s_date             datetime     = null,
   @s_ofi              int          = null,
   @s_rol              tinyint      = null,
   @s_org              char(1)      = null,
   @s_term             varchar (30) = null, 
   @i_cliente   	   varchar(1)   = '1',
   @i_tramite   	   int          = null,
   @i_operacion        char(1)      = 'Q'
)
as
declare @w_tramite      int,
        @w_ente         int,
        @w_nombre       varchar(200),
        @w_rfc          varchar(25),
        @w_fecha_nac    date,
        @w_domicilio    varchar(500),
        @w_colonia      varchar(50),
        @w_codpost      varchar(20),
        @w_mail         varchar(200),
        @w_certificado  varchar(100),
        @w_fecha_ini    varchar(12),
        @w_fecha_fin    varchar(12),
        @w_poliza       varchar(50),
        @w_prima_neta   money,
        @w_derecho_pol  money,
        @w_recargo_pag  money,
        @w_prima_total  money,
        @w_meses        int,
        @w_band_valor_0_seg char(1), -- por caso #171995
        @w_meses_vigencia   int,
        @w_plazo_meses      int,
        @w_toperacion 		varchar(50),
        @w_meses_maximo_seg     int,
        @w_meses_default_seg    int
        
CREATE TABLE #consentimiento_zurich (
	nombre      varchar(200),
	rfc         varchar(25),
	fechanac    date,
	domicilio   varchar(500),
	colonia     varchar(50),
	codigo      varchar(20),
	email       varchar(200),
	certificado varchar(100),
	fechaini    date,
	fechafin    date,
	poliza      varchar(50),
	contratante varchar(100),
	rfccontra   varchar(25),
	cliente     int,
	primaneta   money,
	derechos    money,
	recargo     money,
	primatotal  money,
	razonsocial varchar(500),
	fechaemi    date,
	meses       int
)

--VALIDA VALOR MONTO DEL SEGURO
select @w_band_valor_0_seg = pa_char from cobis..cl_parametro where pa_producto = 'CRE' and pa_nemonico = 'SEVIDV' -- por caso #171995

if @i_operacion = 'Q'
begin
   select @w_tramite     = @i_tramite
   select @w_prima_neta = isnull(pa_money,0) from cobis..cl_parametro where pa_nemonico='MONSEZ' and pa_producto='ADM'
   
   INSERT INTO #consentimiento_zurich 
   select rtrim(ltrim(en_nombre + ' ' + isnull(p_s_nombre,'') + ' ' +isnull(p_p_apellido,'') + ' ' + isnull(p_s_apellido,''))),
          en_ced_ruc,
          p_fecha_nac,
          '',
          '',
          0,
          '',
          tg_prestamo,
          op_fecha_ini,
          dateadd(mm,ceiling((op_plazo) / 4.0),op_fecha_liq),
          tg_prestamo,
          'SANTANDER INCLUSIÓN FINANCIERA S.A. DE C.V., S.O.F.O.M., E.R., G.F.S.M.',
          'SIF170801PYA',
          se_cliente,
          @w_prima_neta * ceiling((op_plazo) / 4.0),
          0,
          0,
          @w_prima_neta * ceiling((op_plazo) / 4.0),
          'RAUL COKA BARRIGA AGENTE DE SEGUROS S.A. DE C.V.',
          getdate(),
          datediff(mm,op_fecha_ini, op_fecha_fin)
   from   cob_cartera..ca_seguro_externo,
          cob_cartera..ca_operacion,
          cob_credito..cr_tramite_grupal,
          cobis..cl_ente 
   where  op_tramite   = @w_tramite
   and    op_tramite   = tg_tramite
   and    op_operacion = se_operacion
   and    se_cliente   = en_ente 
   and    se_cliente   = tg_cliente
   and    tg_monto > 0--caso#144022
   and    tg_participa_ciclo = 'S'--caso#144022
   and    se_tipo_seguro <> 'NINGUNO'
   and    ((@w_band_valor_0_seg = 'N') or (@w_band_valor_0_seg = 'S' and se_monto > 0 )) -- por caso #171995
      
--DIRECCIONES
select di_ente as ente, max(di_direccion) direccion
into   #dir_actuales 
from   cobis..cl_direccion
where  di_tipo='RE'
and    di_ente in (select cliente from #consentimiento_zurich)
group by di_ente

select  di_ente        = di_ente,   
        di_calle       = isnull(ltrim(rtrim(di_calle)),''),
        di_nro          = isnull(ltrim(rtrim(di_nro)),''),
        di_nro_interno = isnull(ltrim(rtrim(di_nro_interno)),0),
        di_colonia     = (select ltrim(rtrim(pq_descripcion)) from cobis..cl_parroquia where pq_parroquia = di_parroquia),
        di_codpostal   = isnull(di_codpostal,'00000')
into    #direcciones
from    cobis..cl_direccion,#dir_actuales
where   di_ente = ente
and     di_direccion = direccion

update #direcciones
set    di_nro_interno = '0'
where  di_nro_interno in ('0' ,'-1')

update #direcciones
set    di_nro = '0'
where  di_nro in ('0' ,'-1') 

update #consentimiento_zurich 
set    domicilio =  di_calle + ',' + di_nro + ',' + di_nro_interno,
       colonia   =  di_colonia,
       codigo    =  di_codpostal
from   #direcciones
where  cliente = di_ente 

--EMAIL 
select di_ente as ente, max(di_direccion) direccion
into   #mail_actuales 
from   cobis..cl_direccion
where  di_tipo='CE'
and    di_ente in (select cliente from #consentimiento_zurich)
group by di_ente		   
		   
select di_ente = di_ente,       
       di_mail = ltrim(rtrim(di_descripcion))
into   #mails
from   cobis..cl_direccion,#mail_actuales
where  di_ente = ente
and    di_direccion = direccion		   

update #consentimiento_zurich set 
       email = di_mail
from   #mails
where  cliente = di_ente 

   select "NOMBRE"                   = nombre,
          "RFC"                      = rfc,
          "FECHA_NACIMIENTO"         = fechanac,
          "DOMICILIO"                = domicilio,
          "COLONIA"                  = colonia,
          "CODIGO_POSTAL"            = codigo,
          "EMAIL"                    = email,
          "CERTIFICADO"              = certificado,
          "FECHA_INICIO"             = fechaini,
          "FECHA_FIN"                = fechafin,
          "POLIZA"                   = poliza,
          "CONTRATANTE"              = contratante,
          "RFC_CONTRATANTE"          = rfccontra,
          "CODIGO_CLIENTE"           = cliente,
          "PRIMA_NETA_UNICA"         = primaneta,
          "DERECHO_POLIZA"           = derechos,
          "RECARGO_PAGO_FRACCIONADO" = recargo,
          "PRIMA_TOTAL"              = primatotal,
		  "RAZON_SOCIAL"             = razonsocial,
		  "FECHA_EMISION"            = fechaemi
          --"MESES"                    = @w_meses
   FROM   #consentimiento_zurich
   
end

-- inicio Req.185234
create table #consentimiento_zurich_individual (
	nombre        varchar(200),
	rfc           varchar(25),
	fechanac      date,
	domicilio     varchar(500),
	colonia       varchar(50),
	codigo        varchar(20),
	email         varchar(200),
	certificado   varchar(100),
	fechaini      date,
	fechafin      date,
	poliza        varchar(50),
	contratante   varchar(100),
	rfccontra     varchar(25),
	cliente       int,
	primaneta     money,
	derechos      money,
	recargo       money,
	primatotal    money,
	razonsocial   varchar(500),
	fechaemi      date,
	meses         int, 
	mesesvigencia int
)

--MESES VIGENCIA ASISTENCIA MEDICA
select @w_meses_vigencia = pa_int from cobis..cl_parametro where pa_nemonico='MVAMSI' and pa_producto='CCA'

if @i_operacion = 'R' -- Reporte Individual
begin
   select @w_tramite     = @i_tramite   
   
   SELECT
   @w_meses_maximo_seg = pa_int
   from cobis..cl_parametro
   where pa_nemonico = 'SEGMAX'
 
   SELECT
   @w_meses_default_seg = pa_int
   from cobis..cl_parametro
   where pa_nemonico = 'SEGDEF'
 
   select
        @w_plazo_meses = case 
		                     when op_tplazo = 'D' then round(convert(float,op_plazo) / 30,0)
                             when op_tplazo = 'W' and op_periodo_cap = 1 then round((convert(float,op_plazo) * 7) / 30,0)
							 when op_tplazo = 'W' and op_periodo_cap = 2 then round((convert(float,op_plazo) * 14) / 30,0)
                             when op_tplazo = 'Q' then round(convert(float,op_plazo) / 2,0)
                             when op_tplazo = 'M' then round(convert(float,op_plazo) , 0)
                             when op_tplazo = 'B' then round(convert(float,op_plazo) * 2,0)
                             when op_tplazo = 'T' then round(convert(float,op_plazo) * 3,0)
                             when op_tplazo = 'S' then round(convert(float,op_plazo) * 6,0)
                         else
                             1
                         end,
        @w_toperacion = op_toperacion
   from cob_cartera..ca_operacion
   where  op_tramite   = @w_tramite
   
   select @w_prima_neta = isnull(se_valor,0) 
   from cob_cartera..ca_param_seguro_externo
   where se_producto = @w_toperacion
   and    se_paquete = 'BASICO'
   and @w_plazo_meses between se_mes_inicial and se_mes_final

   --Lo mínimo a cobrar por el seguro son 4 meses
   SELECT @w_plazo_meses = case
                                when @w_plazo_meses <= @w_meses_maximo_seg then @w_meses_default_seg
                                else @w_plazo_meses
                           end

   insert into #consentimiento_zurich_individual 
   select rtrim(ltrim(en_nombre + ' ' + isnull(p_s_nombre,'') + ' ' +isnull(p_p_apellido,'') + ' ' + isnull(p_s_apellido,''))),
          en_ced_ruc,
          p_fecha_nac,
          '',
          '',
          0,
          '',
          op_banco,
          op_fecha_ini,
          op_fecha_fin,
          op_banco,
          'SANTANDER INCLUSIÓN FINANCIERA S.A. DE C.V., S.O.F.O.M., E.R., G.F.S.M.',
          'SIF170801PYA',
          se_cliente,
          @w_prima_neta * @w_plazo_meses,
          0,
          0,
          @w_prima_neta * @w_plazo_meses,
          'RAUL COKA BARRIGA AGENTE DE SEGUROS S.A. DE C.V.',
          getdate(),
          datediff(mm,op_fecha_ini, op_fecha_fin),
		  ceiling(op_plazo/
                  case
                    when op_tplazo = 'M' then 1.0
                    when op_tplazo = 'W' and op_periodo_cap = 1 then 30.0/7.0
	                when op_tplazo = 'W' and op_periodo_cap = 2 then 30.0/14.0
                    when op_tplazo = 'Q' then 2.0
                    when op_tplazo = 'D' then 30.0
                    else 1.0
                  end)
   from   cob_cartera..ca_seguro_externo,
          cob_cartera..ca_operacion,
          cob_credito..cr_tramite,
          cobis..cl_ente 
   where  op_tramite   = @w_tramite
   and    op_tramite   = tr_tramite
   and    op_operacion = se_operacion
   and    se_cliente   = en_ente 
   and    se_cliente   = tr_cliente
   and    tr_monto > 0
   and    se_tipo_seguro <> 'NINGUNO'
   and    ((@w_band_valor_0_seg = 'N') or (@w_band_valor_0_seg = 'S' and se_monto > 0 )) -- por caso #171995
        
   update #consentimiento_zurich_individual 
   set fechafin = case 
                    when mesesvigencia < @w_meses_vigencia then dateadd(month, @w_meses_vigencia, fechaini)
		            else dateadd(month, mesesvigencia, fechaini)
				  end
   
   --DIRECCIONES
   select di_ente as ente, max(di_direccion) direccion
   into   #dir_actual 
   from   cobis..cl_direccion
   where  di_tipo='RE'
   and    di_ente in (select cliente from #consentimiento_zurich_individual)
   group by di_ente
   
   select  di_ente        = di_ente,   
           di_calle       = isnull(ltrim(rtrim(di_calle)),''),
           di_nro          = isnull(ltrim(rtrim(di_nro)),''),
           di_nro_interno = isnull(ltrim(rtrim(di_nro_interno)),0),
           di_colonia     = (select ltrim(rtrim(pq_descripcion)) from cobis..cl_parroquia where pq_parroquia = di_parroquia),
           di_codpostal   = isnull(di_codpostal,'00000')
   into    #direccion
   from    cobis..cl_direccion,#dir_actual
   where   di_ente = ente
   and     di_direccion = direccion
   
   update #direccion
   set    di_nro_interno = '0'
   where  di_nro_interno in ('0' ,'-1')
   
   update #direccion
   set    di_nro = '0'
   where  di_nro in ('0' ,'-1') 
   
   update #consentimiento_zurich_individual 
   set    domicilio =  di_calle + ',' + di_nro + ',' + di_nro_interno,
          colonia   =  di_colonia,
          codigo    =  di_codpostal
   from   #direccion
   where  cliente = di_ente 
   
   --EMAIL 
   select di_ente as ente, max(di_direccion) direccion
   into   #mail_actual 
   from   cobis..cl_direccion
   where  di_tipo='CE'
   and    di_ente in (select cliente from #consentimiento_zurich_individual)
   group by di_ente		   
   		   
   select di_ente = di_ente,       
          di_mail = ltrim(rtrim(di_descripcion))
   into   #mail
   from   cobis..cl_direccion,#mail_actual
   where  di_ente = ente
   and    di_direccion = direccion		   
   
   update #consentimiento_zurich_individual set 
          email = di_mail
   from   #mail
   where  cliente = di_ente 

   select "NOMBRE"                   = nombre,
          "RFC"                      = rfc,
          "FECHA_NACIMIENTO"         = fechanac,
          "DOMICILIO"                = domicilio,
          "COLONIA"                  = colonia,
          "CODIGO_POSTAL"            = codigo,
          "EMAIL"                    = email,
          "CERTIFICADO"              = certificado,
          "FECHA_INICIO"             = fechaini,
          "FECHA_FIN"                = fechafin,
          "POLIZA"                   = poliza,
          "CONTRATANTE"              = contratante,
          "RFC_CONTRATANTE"          = rfccontra,
          "CODIGO_CLIENTE"           = cliente,
          "PRIMA_NETA_UNICA"         = primaneta,
          "DERECHO_POLIZA"           = derechos,
          "RECARGO_PAGO_FRACCIONADO" = recargo,
          "PRIMA_TOTAL"              = primatotal,
		  "RAZON_SOCIAL"             = razonsocial,
		  "FECHA_EMISION"            = fechaemi
          --"MESES"                    = @w_meses
   from   #consentimiento_zurich_individual
   
end
-- fin Req.185234

return 0

go