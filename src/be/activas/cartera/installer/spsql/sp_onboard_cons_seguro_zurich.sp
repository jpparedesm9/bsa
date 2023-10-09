/************************************************************************/
/*   Archivo:              sp_onboard_cons_seguro_zurich.sp             */
/*   Stored procedure:     sp_onboard_cons_seguro_zurich                */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Cartera                                      */
/*   Disenado por:         KVI                                          */
/*   Fecha de escritura:   Marzo 2022                                   */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                         PROPOSITO                                    */
/*   Consulta para reporte AutoOnboarding Seguro Zurich                 */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  15/03/2022    KVI             Emision Inicial Req.168293            */
/*  25/11/2022    KVI             Req.197007-Op.L-C F.B2B Gr.PaperlessF1*/
/************************************************************************/
use cob_cartera
go
 
if exists (select 1 from sysobjects where name = 'sp_onboard_cons_seguro_zurich')
   drop proc sp_onboard_cons_seguro_zurich
go

create proc sp_onboard_cons_seguro_zurich
(  
   @i_cliente   	   int          = null,
   @i_tramite   	   int          = null,
   @i_operacion        char(1)      = null
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
        @w_band_valor_0_seg char(1),
        @w_meses_vigencia   int	
        

--VALIDA VALOR MONTO DEL SEGURO
select @w_band_valor_0_seg = pa_char from cobis..cl_parametro where pa_producto = 'CRE' and pa_nemonico = 'SEVIDV' 

--MESES VIGENCIA ASISTENCIA MEDICA
select @w_meses_vigencia = pa_int from cobis..cl_parametro where pa_nemonico='MEREIN' and pa_producto='CCA'

if @i_operacion = 'R'--Llenado Reporte AutoOnboarding
begin
   delete  from ca_consentimiento_zurich
   where cz_tramite = @i_tramite
   
   select @w_tramite    = @i_tramite
   select @w_prima_neta = isnull(pa_money,0) from cobis..cl_parametro where pa_nemonico='MONSEZ' and pa_producto='ADM'   
   
   insert into ca_consentimiento_zurich (cz_nombre,    cz_rfc,            cz_fechanac,    cz_domicilio,    cz_colonia,    
                                         cz_codigo,    cz_email,          cz_certificado, cz_fechaini,     cz_fechafin,    
										 cz_poliza,    cz_contratante,    cz_rfccontra,   cz_cliente,      cz_primaneta,      
										 cz_derechos,  cz_recargo,        cz_primatotal,  cz_razonsocial,  cz_fechaemi,      
										 cz_meses,     cz_tramite)
   select rtrim(ltrim(en_nombre + ' ' + isnull(p_s_nombre,'') + ' ' +isnull(p_p_apellido,'') + ' ' + isnull(p_s_apellido,''))),--cz_nombre
          en_ced_ruc,--cz_rfc
          p_fecha_nac,--cz_fechanac
          '',--cz_domicilio
          '',--cz_colonia
          0,--cz_codigo
          '',--cz_email
          op_banco,--cz_certificado
          op_fecha_ini,--cz_fechaini
          op_fecha_fin,--cz_fechafin
          op_banco,--cz_poliza
          'SANTANDER INCLUSIÓN FINANCIERA S.A. DE C.V., S.O.F.O.M., E.R., G.F.S.M.',--cz_contratante
          'SIF170801PYA',--cz_rfccontra
          se_cliente,--cz_cliente
          @w_prima_neta * ceiling((op_plazo) / 4.0),--cz_primaneta
          0,--cz_derechos
          0,--cz_recargo
          @w_prima_neta * ceiling((op_plazo) / 4.0),--cz_primatotal
          'RAUL COKA BARRIGA AGENTE DE SEGUROS S.A. DE C.V.',--cz_razonsocial
          getdate(),--cz_fechaemi
          datediff(mm,op_fecha_ini, op_fecha_fin),--cz_meses
		  @w_tramite--cz_tramite
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
   and    ((@w_band_valor_0_seg = 'N') or (@w_band_valor_0_seg = 'S' and se_monto > 0 )) 
   
   select cz_cliente as ente, 
          cz_tramite as tramite,
		  meses = ceiling(op_plazo/
                          case
                            when op_tplazo = 'M' then 1.0
                            when op_tplazo = 'W' and op_periodo_cap = 1 then 4.0
		                    when op_tplazo = 'W' and op_periodo_cap = 2 then 2.0
                            when op_tplazo = 'Q' then 2.0
                            when op_tplazo = 'D' then 30.0
                            else 1.0
                          end)
   into   #meses_seguro
   from   ca_consentimiento_zurich, cob_cartera..ca_operacion
   where  cz_tramite = @w_tramite
   and    cz_tramite = op_tramite
   
   update ca_consentimiento_zurich
   set cz_fechafin = case 
                       when meses < @w_meses_vigencia then dateadd(month, @w_meses_vigencia, dateadd(day, 1, cz_fechaini))
					   else dateadd(day, 1, dateadd(month, meses, cz_fechaini))
					 end
   from #meses_seguro
   
   --DIRECCIONES
   select di_ente as ente, max(di_direccion) direccion
   into   #dir_actual
   from   cobis..cl_direccion
   where  di_tipo='RE'
   and    di_ente in (select cz_cliente from ca_consentimiento_zurich)
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
   
   update ca_consentimiento_zurich 
   set    cz_domicilio =  di_calle + ',' + di_nro + ',' + di_nro_interno,
          cz_colonia   =  di_colonia,
          cz_codigo    =  di_codpostal
   from   #direccion
   where  cz_cliente = di_ente 
   
   --EMAIL 
   select di_ente as ente, max(di_direccion) direccion
   into   #mail_actual 
   from   cobis..cl_direccion
   where  di_tipo='CE'
   and    di_ente in (select cz_cliente from ca_consentimiento_zurich)
   group by di_ente		   
   		   
   select di_ente = di_ente,       
          di_mail = ltrim(rtrim(di_descripcion))
   into   #mail
   from   cobis..cl_direccion,#mail_actual
   where  di_ente = ente
   and    di_direccion = direccion		   
   
   update ca_consentimiento_zurich set 
          cz_email = di_mail
   from   #mail
   where  cz_cliente = di_ente 

   
   
end

if @i_operacion = 'Q'--Consulta Reporte AutoOnboarding
begin
  select  "NOMBRE"                   = cz_nombre,
          "RFC"                      = cz_rfc,
          "FECHA_NACIMIENTO"         = convert(varchar,cz_fechanac,103),
          "DOMICILIO"                = cz_domicilio,
          "COLONIA"                  = cz_colonia,
          "CODIGO_POSTAL"            = cz_codigo,
          "EMAIL"                    = cz_email,
          "CERTIFICADO"              = cz_certificado,
          "FECHA_INICIO"             = convert(varchar,cz_fechaini,103),
          "FECHA_FIN"                = convert(varchar,cz_fechafin,103),
          "POLIZA"                   = cz_poliza,
          "CONTRATANTE"              = cz_contratante,
          "RFC_CONTRATANTE"          = cz_rfccontra,
          "CODIGO_CLIENTE"           = cz_cliente,
          "PRIMA_NETA_UNICA"         = cz_primaneta,
          "DERECHO_POLIZA"           = cz_derechos,
          "RECARGO_PAGO_FRACCIONADO" = cz_recargo,
          "PRIMA_TOTAL"              = cz_primatotal,
		  "RAZON_SOCIAL"             = cz_razonsocial,
		  "FECHA_EMISION"            = convert(varchar,cz_fechaemi,103)
          --"MESES"                    = @w_meses
   from   ca_consentimiento_zurich
   where  cz_tramite = @i_tramite
end


if @i_operacion = 'S'--Beneficiarios
begin
    select  
    'nombre'           = se_beneficiario,
    'parentesco'       = (select isnull(b.valor,'') 
                          from cobis..cl_tabla a, cobis..cl_catalogo b
                          where a.codigo = b.tabla
                          and a.tabla = 'cr_parentesco_micro'
                          and ltrim(rtrim(b.codigo)) = ltrim(rtrim(se_parentesco))),
    'fecha_nacimiento' = '',
    'porcentaje'      = se_porcentaje
    from cob_cartera..ca_onboard_seguro_ext
    where se_tramite = @i_tramite
end


-- Inicio Req.197007
--VALIDA VALOR MONTO DEL SEGURO
if @i_operacion = 'L' -- Llenado Reporte Certificado Consentimiento Grupal por Cliente
begin
    delete  from ca_consentimiento_zurich
    where cz_tramite = @i_tramite
    and   cz_cliente = @i_cliente
   
    select @w_tramite     = @i_tramite
    select @w_prima_neta = isnull(pa_money,0) from cobis..cl_parametro where pa_nemonico='MONSEZ' and pa_producto='ADM'
   
    insert into ca_consentimiento_zurich (cz_nombre,    cz_rfc,            cz_fechanac,    cz_domicilio,    cz_colonia,    
                                          cz_codigo,    cz_email,          cz_certificado, cz_fechaini,     cz_fechafin,    
										  cz_poliza,    cz_contratante,    cz_rfccontra,   cz_cliente,      cz_primaneta,      
										  cz_derechos,  cz_recargo,        cz_primatotal,  cz_razonsocial,  cz_fechaemi,      
										  cz_meses,     cz_tramite)
    select 
	    rtrim(ltrim(en_nombre + ' ' + isnull(p_s_nombre,'') + ' ' +isnull(p_p_apellido,'') + ' ' + isnull(p_s_apellido,''))), -- cz_nombre
        en_ced_ruc,                                                                -- cz_rfc
        p_fecha_nac,                                                               -- cz_fechanac
        '',                                                                        -- cz_domicilio
        '',                                                                        -- cz_colonia
        0,                                                                         -- cz_codigo
        '',                                                                        -- cz_email
        tg_prestamo,                                                               -- cz_certificado
        op_fecha_ini,                                                              -- cz_fechaini
        dateadd(mm,ceiling((op_plazo) / 4.0),op_fecha_liq),                        -- cz_fechafin
        tg_prestamo,                                                               -- cz_poliza
        'SANTANDER INCLUSIÓN FINANCIERA S.A. DE C.V., S.O.F.O.M., E.R., G.F.S.M.', -- cz_contratante
        'SIF170801PYA',                                                            -- cz_rfccontra
        se_cliente,                                                                -- cz_cliente
        @w_prima_neta * ceiling((op_plazo) / 4.0),                                 -- cz_primaneta
        0,                                                                         -- cz_derechos
        0,                                                                         -- cz_recargo
        @w_prima_neta * ceiling((op_plazo) / 4.0),                                 -- cz_primatotal
        'RAUL COKA BARRIGA AGENTE DE SEGUROS S.A. DE C.V.',                        -- cz_razonsocial
        getdate(),                                                                 -- cz_fechaemi
        datediff(mm,op_fecha_ini, op_fecha_fin),                                   -- cz_meses
		@w_tramite                                                                 -- cz_tramite
    from  cob_cartera..ca_seguro_externo,
          cob_cartera..ca_operacion,
          cob_credito..cr_tramite_grupal,
          cobis..cl_ente 
    where  op_tramite   = @w_tramite
    and    op_tramite   = tg_tramite
    and    op_operacion = se_operacion
    and    se_cliente   = en_ente 
    and    se_cliente   = tg_cliente
    and    tg_monto > 0
    and    tg_participa_ciclo = 'S'
    and    se_tipo_seguro <> 'NINGUNO'
    and    ((@w_band_valor_0_seg = 'N') or (@w_band_valor_0_seg = 'S' and se_monto > 0 )) 
    and    en_ente = @i_cliente
      
    --DIRECCIONES
    select di_ente as ente, max(di_direccion) direccion
    into   #ddir_actuales 
    from   cobis..cl_direccion
    where  di_tipo='RE'
    and    di_ente in (select cz_cliente from ca_consentimiento_zurich)
    group by di_ente

    select  
	    di_ente        = di_ente,   
        di_calle       = isnull(ltrim(rtrim(di_calle)),''),
        di_nro          = isnull(ltrim(rtrim(di_nro)),''),
        di_nro_interno = isnull(ltrim(rtrim(di_nro_interno)),0),
        di_colonia     = (select ltrim(rtrim(pq_descripcion)) from cobis..cl_parroquia where pq_parroquia = di_parroquia),
        di_codpostal   = isnull(di_codpostal,'00000')
    into   #ddirecciones
    from   cobis..cl_direccion,#ddir_actuales
    where  di_ente = ente
    and    di_direccion = direccion

    update #ddirecciones
    set    di_nro_interno = '0'
    where  di_nro_interno in ('0' ,'-1')

    update #ddirecciones
    set    di_nro = '0'
    where  di_nro in ('0' ,'-1') 

    update ca_consentimiento_zurich
    set    cz_domicilio =  di_calle + ',' + di_nro + ',' + di_nro_interno,
           cz_colonia   =  di_colonia,
           cz_codigo    =  di_codpostal
    from   #ddirecciones
    where  cz_cliente = di_ente 

    --EMAIL 
    select di_ente as ente, max(di_direccion) direccion
    into   #mmail_actuales 
    from   cobis..cl_direccion
    where  di_tipo='CE'
    and    di_ente in (select cz_cliente from ca_consentimiento_zurich)
    group by di_ente		   
		   
    select 
	    di_ente = di_ente,       
        di_mail = ltrim(rtrim(di_descripcion))
    into   #mmails
    from   cobis..cl_direccion,#mmail_actuales
    where  di_ente = ente
    and    di_direccion = direccion		   

    update ca_consentimiento_zurich set 
           cz_email = di_mail
    from   #mmails
    where  cz_cliente = di_ente 
end

if @i_operacion = 'C' -- Consulta Reporte Certificado Consentimiento Grupal por Cliente
begin
   select  "NOMBRE"                   = cz_nombre,
          "RFC"                      = cz_rfc,
          "FECHA_NACIMIENTO"         = convert(varchar,cz_fechanac,103),
          "DOMICILIO"                = cz_domicilio,
          "COLONIA"                  = cz_colonia,
          "CODIGO_POSTAL"            = cz_codigo,
          "EMAIL"                    = cz_email,
          "CERTIFICADO"              = cz_certificado,
          "FECHA_INICIO"             = convert(varchar,cz_fechaini,103),
          "FECHA_FIN"                = convert(varchar,cz_fechafin,103),
          "POLIZA"                   = cz_poliza,
          "CONTRATANTE"              = cz_contratante,
          "RFC_CONTRATANTE"          = cz_rfccontra,
          "CODIGO_CLIENTE"           = cz_cliente,
          "PRIMA_NETA_UNICA"         = cz_primaneta,
          "DERECHO_POLIZA"           = cz_derechos,
          "RECARGO_PAGO_FRACCIONADO" = cz_recargo,
          "PRIMA_TOTAL"              = cz_primatotal,
		  "RAZON_SOCIAL"             = cz_razonsocial,
		  "FECHA_EMISION"            = convert(varchar,cz_fechaemi,103)
          --"MESES"                    = @w_meses
   from   ca_consentimiento_zurich
   where  cz_tramite = @i_tramite
   and    cz_cliente = @i_cliente
end
-- Fin Req.197007

return 0

go