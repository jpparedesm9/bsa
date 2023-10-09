/*****************************************************************************/
/* Archivo           :  regrepr08.sp                                         */
/* Stored procedure  :  sp_reporte_r08                                       */
/* Base de datos     :  cob_conta_super                                      */
/*****************************************************************************/
/*                            IMPORTANTE                                     */
/* Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCorp */
/* Su uso no autorizado queda  expresamente  prohibido asi como cualquier    */
/* alteracion o agregado hecho  por alguno de sus usuarios sin el debido     */
/* consentimiento por escrito de COBISCorp. Este programa esta protegido por */
/* la ley de derechos de autor y por las convenciones internacionales de     */
/* propiedad intelectual.  Su uso  no  autorizado dara derecho a COBISCORP   */
/* para obtener ordenes  de secuestro o  retencion  y  para  perseguir       */
/* penalmente a  los autores de cualquier infraccion.                        */
/*****************************************************************************/
/*                            PROPOSITO                                      */
/* Programa que genera el reporte regulatorio R08                            */
/*****************************************************************************/
/*                           MODIFICACIONES                                  */
/* FECHA           AUTOR               RAZON                                 */
/* 18/08/2016      Jorge Salazar       Emision Inicial                       */
/*****************************************************************************/
use cob_conta_super
go
if exists (select 1 from sysobjects where name = 'sp_reporte_r08')
   drop proc sp_reporte_r08
go
 
create proc sp_reporte_r08
(  
   @t_show_version   bit = 0,
   @i_param1         datetime,  -- inicio semana
   @i_param2         tinyint    -- Periodicidad
)

as 
declare
   @i_fecha          datetime,
   @i_periodicidad   tinyint,

   @w_return         int,     /* valor que retorna */
   @w_sp_name        varchar(32),
   @w_bancamia       varchar(24),
   @w_clave          varchar(30),
   @w_subreporte     varchar(30),
   @w_fecha_ini      datetime,
   @w_prod_pcame     varchar(10),
   @w_prod_pcaaso    varchar(10),
   @w_prod_pcaasa    varchar(10),
   @w_mayor_edad     tinyint,
   @w_cod_rel        int,
   @w_mes_fecha      tinyint,
   @w_moneda_local   tinyint,
   @w_s_app          varchar(50),
   @w_path           varchar(50),
   @w_destino        varchar(2500),
   @w_msg            varchar(200),
   @w_error          int,
   @w_errores        varchar(1500),
   @w_comando        varchar(2500)

select
   @w_sp_name        = 'sp_reporte_r08',
   @i_fecha          = @i_param1,
   @i_periodicidad   = @i_param2

--Versionamiento del Programa --
if @t_show_version = 1
begin
  print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
  return 0
end

delete sb_errorlog
 where er_fuente = @w_sp_name

--Valida periodicidad trimestral
select @w_mes_fecha = datepart(mm, @i_fecha)
if @w_mes_fecha % @i_periodicidad <> 0 goto FIN

--Clave de Entidad
select @w_clave = pa_char
  from cobis..cl_parametro
 where pa_nemonico = 'CLAVEN'
   and pa_producto = 'REC'
   
if @@rowcount <> 1
begin
   select @w_msg = 'NO EXISTE PARAMETRO CLAVEN'
   goto ERRORFIN
end

--Subreporte
select @w_subreporte = pa_char
  from cobis..cl_parametro
 where pa_nemonico = 'SUBREP'
   and pa_producto = 'REC'
   
if @@rowcount <> 1
begin
   select @w_msg = 'NO EXISTE PARAMETRO SUBREP'
   goto ERRORFIN
end

--Producto Bancario Ahorro Menores
select @w_prod_pcame = convert(varchar,pa_int)
  from cobis..cl_parametro
 where pa_nemonico = 'PCAME'
   and pa_producto = 'AHO'
   
if @@rowcount <> 1
begin
   select @w_msg = 'NO EXISTE PARAMETRO PCAME'
   goto ERRORFIN
end

--Producto Bancario Aporte Social Ordinario
select @w_prod_pcaaso = convert(varchar,pa_int)
  from cobis..cl_parametro
 where pa_nemonico = 'PCAASO'
   and pa_producto = 'AHO'
   
if @@rowcount <> 1
begin
   select @w_msg = 'NO EXISTE PARAMETRO PCAASO'
   goto ERRORFIN
end

--Producto Bancario Aporte Social Adicional
select @w_prod_pcaasa = convert(varchar,pa_int)
  from cobis..cl_parametro
 where pa_nemonico = 'PCAASA'
   and pa_producto = 'AHO'
   
if @@rowcount <> 1
begin
   select @w_msg = 'NO EXISTE PARAMETRO PCAASA'
   goto ERRORFIN
end
   
--Mayoria de Edad
select @w_mayor_edad = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'MDE'
   and pa_producto = 'ADM'
   
if @@rowcount <> 1
begin
   select @w_msg = 'NO EXISTE PARAMETRO MDE'
   goto ERRORFIN
end

--Codigo Relacion Tutor
select
  @w_cod_rel = pa_int
from   cobis..cl_parametro
where  pa_producto = 'MIS'
   and pa_nemonico = 'RELAT'

if @@rowcount <> 1
begin
   select @w_msg = 'NO EXISTE PARAMETRO RELAT'
   goto ERRORFIN
end

--Mayoria de Edad
select @w_moneda_local = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'
   
if @@rowcount <> 1
begin
   select @w_msg = 'NO EXISTE PARAMETRO CMNAC'
   goto ERRORFIN
end

select @w_s_app = pa_char
  from cobis..cl_parametro with (nolock)
 where pa_producto = 'ADM'
   and pa_nemonico = 'S_APP'

if @@rowcount <> 1
begin
   select @w_msg = 'NO EXISTE PARAMETRO S_APP'
   goto ERRORFIN
end

select @w_path = ba_path_destino
from cobis..ba_batch
where ba_batch = 36001

if @@rowcount <> 1
begin
   select @w_msg = 'NO EXISTE RUTA PATH DESTINO'
   goto ERRORFIN
end


--Fecha inicio mes segun periodicidad
select @w_fecha_ini = dateadd(mm,-(@i_periodicidad - 1),@i_fecha)
select @w_fecha_ini = dateadd(dd,-(datepart(day,@w_fecha_ini)) + 1, @w_fecha_ini)

select r08_periodo            = convert(varchar, datepart(yy, dp_fecha)) + right('0'+ convert(varchar,datepart(mm,dp_fecha)),2), --1
       r08_clave_entidad      = convert(numeric(6),@w_clave),                                                                    --2
       r08_subreporte         = convert(numeric(4),@w_subreporte),                                                               --3
       r08_identificacion     = convert(varchar(12),dp_cliente),                                                                 --4
       r08_tipo_socio         = case dc_subtipo                                                                                  --5
                                     when 'C' 
                                     then (select convert(numeric(3),eq_valor_cat)
                                             from cob_conta_super..sb_equivalencias
                                            where eq_catalogo  = 'TIPO_ENTE'
                                              and eq_valor_arch = dc_subtipo)
                                     else (select case when datediff(yy, dc_fecha_nac, @i_fecha) > @w_mayor_edad
                                                       then (select eq_valor_cat
                                                               from cob_conta_super..sb_equivalencias
                                                              where eq_catalogo  = 'TIPO_ENTE'
                                                                and eq_valor_arch = dc_subtipo)
                                                       else (select case when (select count(1)
                                                                                from cobis..cl_instancia
                                                                               where in_relacion = @w_cod_rel
                                                                                 and in_ente_i   = dp_cliente
                                                                                 and in_lado     = 'D') > 0
                                                                         then case when (select count(1)
                                                                                          from cob_conta_super..sb_dato_pasivas
                                                                                         where dp_toperacion = @w_prod_pcaaso
                                                                                           and dp_cliente    = (select in_ente_d
                                                                                                                   from cobis..cl_instancia
                                                                                                                  where in_relacion = @w_cod_rel
                                                                                                                    and in_ente_i   = dp_cliente
                                                                                                                    and in_lado     = 'D')) > 0
                                                                                   then 3
                                                                                   else 4
                                                                              end
                                                                         else 4
                                                                    end)
                                                  end
                                             from cob_conta_super..sb_dato_cliente
                                            where dc_cliente = dp_cliente
                                              and dc_fecha   = (select max(dc_fecha) from cob_conta_super..sb_dato_cliente where dc_cliente = dp_cliente))
                                end,
       r08_nom_raz_social     = upper(ltrim(rtrim(isnull(dc_nombre,'0')))),                                                      --6
       r08_p_apellido         = case dc_subtipo
                                     when 'P' then upper(ltrim(rtrim(isnull(dc_p_apellido,'0'))))                                --7
                                     else '0'
                                end,
       r08_s_apellido         = case dc_subtipo
                                     when 'P' then upper(ltrim(rtrim(isnull(dc_s_apellido,'0'))))                                --8
                                     else '0'
                                end,
       r08_rfc_socio          = upper(ltrim(rtrim(isnull(dc_nit,'0')))),                                                         --9
       r08_curp_socio         = case dc_subtipo                                                                                  --10
                                     when 'P' then (select case dc_tipo_ced
                                                                when 'CC' then isnull(dc_ced_ruc,'0')
                                                                else '0'
                                                           end)
                                     else '0'
                                end,
       r08_genero             = case when dc_sexo in('F','M')                                                                    --11
	                                 then (select convert(numeric(3),eq_valor_cat)
                                             from cob_conta_super..sb_equivalencias
                                            where eq_catalogo  = 'CL_SEXO'
                                              and eq_valor_arch = dc_sexo)
                                     else 3
                                end,
       r08_fecha_nac_cons     = isnull(convert(varchar,dc_fecha_nac,112),'0'),                                                   --12
       r08_postal_domicilio   = (select convert(numeric(21),eq_valor_cat)                                                        --13
                                   from cob_conta_super..sb_equivalencias
                                  where eq_catalogo  = 'CODCIU'
                                    and eq_valor_arch = dd_ciudad),
       r08_local_domicilio    = (select convert(numeric(12),eq_valor_cat)                                                        --14
                                   from cob_conta_super..sb_equivalencias
                                  where eq_catalogo  = 'CODPARRQ'
                                    and eq_valor_arch = dd_parroquia),
       r08_estado_domicilio   = (select convert(numeric(4),eq_valor_cat)                                                         --15
                                   from cob_conta_super..sb_equivalencias
                                  where eq_catalogo  = 'CODPROV'
                                    and eq_valor_arch = dd_provincia),
       r08_pais_domicilio     = (select convert(numeric(4),eq_valor_cat)                                                         --16
                                   from cob_conta_super..sb_equivalencias
                                  where eq_catalogo  = 'CODPAIS'
                                    and eq_valor_arch = (select pv_pais
                                                          from cobis..cl_provincia
                                                         where pv_provincia = dd_provincia)),
       r08_num_certi_apo      = case dc_subtipo                                                                                  --17
                                     when 'P' then (select case when datediff(yy, dc_fecha_nac, @i_fecha) <= @w_mayor_edad
                                                                then 0
                                                                else (select count(1)
                                                                        from cob_conta_super..sb_dato_pasivas
                                                                       where dp_toperacion = @w_prod_pcaaso
                                                                         and dp_cliente    = dc_cliente
                                                                         and dp_estado     not in (2) --Inactivas
                                                                         and dp_fecha      = @i_fecha)
                                                           end
                                                      from cob_conta_super..sb_dato_cliente
                                                     where dc_cliente = dp_cliente
                                                       and dc_fecha   = (select max(dc_fecha) from cob_conta_super..sb_dato_cliente where dc_cliente = dp_cliente))
                                     else (select count(1)
                                             from cob_conta_super..sb_dato_pasivas
                                            where dp_toperacion = @w_prod_pcaaso
                                              and dp_cliente    = dc_cliente
                                              and dp_estado     not in (2) --Inactivas
                                              and dp_fecha      = @i_fecha)
                                end,
       r08_monto_certi_apo    = case dc_subtipo                                                                                  --18
                                     when 'P' then (select case when datediff(yy, dc_fecha_nac, @i_fecha) <= @w_mayor_edad
                                                                then 0
                                                                else (select round(isnull(sum(dp_monto),0),0)
                                                                        from cob_conta_super..sb_dato_pasivas
                                                                       where dp_toperacion = @w_prod_pcaaso
                                                                         and dp_cliente    = dc_cliente
                                                                         and dp_estado     not in (2) --Inactivas
                                                                         and dp_fecha      = @i_fecha)
                                                           end
                                                      from cob_conta_super..sb_dato_cliente
                                                     where dc_cliente = dp_cliente
                                                       and dc_fecha   = (select max(dc_fecha) from cob_conta_super..sb_dato_cliente where dc_cliente = dp_cliente))
                                     else (select count(1)
                                             from cob_conta_super..sb_dato_pasivas
                                            where dp_toperacion = @w_prod_pcaaso
                                              and dp_cliente    = dc_cliente
                                              and dp_estado     not in (2) --Inactivas
                                              and dp_fecha      = @i_fecha)
                                end,
       r08_num_certi_exced    = case dc_subtipo                                                                                  --19
                                     when 'P' then (select case when datediff(yy, dc_fecha_nac, @i_fecha) <= @w_mayor_edad
                                                                then 0
                                                                else (select count(1)
                                                                        from cob_conta_super..sb_dato_pasivas
                                                                       where dp_toperacion = @w_prod_pcaasa
                                                                         and dp_cliente    = dc_cliente
                                                                         and dp_estado     not in (2) --Inactivas
                                                                         and dp_fecha      = @i_fecha)
                                                           end
                                                      from cob_conta_super..sb_dato_cliente
                                                     where dc_cliente = dp_cliente
                                                       and dc_fecha   = (select max(dc_fecha) from cob_conta_super..sb_dato_cliente where dc_cliente = dp_cliente))
                                     else (select count(1)
                                             from cob_conta_super..sb_dato_pasivas
                                            where dp_toperacion = @w_prod_pcaasa
                                              and dp_cliente    = dc_cliente
                                              and dp_estado     not in (2) --Inactivas
                                              and dp_fecha      = @i_fecha)
                                end,
       r08_monto_certi_exced  = case dc_subtipo                                                                                  --20
                                     when 'P' then (select case when datediff(yy, dc_fecha_nac, @i_fecha) <= @w_mayor_edad
                                                                then 0
                                                                else (select round(isnull(sum(dp_monto),0),0)
                                                                        from cob_conta_super..sb_dato_pasivas
                                                                       where dp_toperacion = @w_prod_pcaasa
                                                                         and dp_cliente    = dc_cliente
                                                                         and dp_estado     not in (2) --Inactivas
                                                                         and dp_fecha      = @i_fecha)
                                                           end
                                                      from cob_conta_super..sb_dato_cliente
                                                     where dc_cliente = dp_cliente
                                                       and dc_fecha   = (select max(dc_fecha) from cob_conta_super..sb_dato_cliente where dc_cliente = dp_cliente))
                                     else (select count(1)
                                             from cob_conta_super..sb_dato_pasivas
                                            where dp_toperacion = @w_prod_pcaasa
                                              and dp_cliente    = dc_cliente
                                              and dp_estado     not in (2) --Inactivas
                                              and dp_fecha      = @i_fecha)
                                end,
       r08_num_contrato       = '0',                                                                                             --21
       r08_cta_banco          = dp_banco,                                                                                        --22
       r08_nom_sucursal       = (select of_nombre from cobis..cl_oficina where of_oficina = dp_oficina),                         --23
       r08_fecha_contrato     = isnull(convert(varchar,dp_fecha_apertura,112),'19000101'),                                       --24
       r08_tipo_producto      = case when dp_aplicativo = (select eq_valor_arch                                                  --25
                                                             from sb_equivalencias
                                                            where eq_catalogo   = 'TIPRODUCTO'
                                                              and eq_valor_cat  = 'AHORROS')
                                     then
                                         case when dp_provisiona = 'S'
                                              then case when dp_blqpignoracion = 'S'
                                                        then 4
                                                        else 3
                                                   end
                                              else case when dp_blqpignoracion = 'S'
                                                        then 2
                                                        else 1
                                                   end
                                         end
                                else case when dp_aplicativo = (select eq_valor_arch
                                                                  from sb_equivalencias
                                                                 where eq_catalogo   = 'TIPRODUCTO'
                                                                   and eq_valor_cat  = 'DPF')
                                          then
                                              case when dp_blqpignoracion = 'S'
                                                   then 8
                                                   else 7
                                              end
                                     end
                                end,
       r08_tipo_modalidad     = case when dp_aplicativo = (select eq_valor_arch                                                  --26
                                                             from sb_equivalencias
                                                            where eq_catalogo   = 'TIPRODUCTO'
                                                              and eq_valor_cat  = 'AHORROS')
                                     then
                                         case when dp_toperacion = @w_prod_pcame
                                              then 5
                                         	  else case when dp_condicion_manejo in ('I','O')
                                                        then (select convert(numeric(3),eq_valor_cat)
                                                                from cob_conta_super..sb_equivalencias
                                                               where eq_catalogo   = 'TIPO_MODO'
                                                                 and eq_valor_arch = dp_condicion_manejo)
                                                        else 6
                                                    end
                                         end
                                else case when dp_aplicativo = (select eq_valor_arch
                                                                  from sb_equivalencias
                                                                 where eq_catalogo   = 'TIPRODUCTO'
                                                                   and eq_valor_cat  = 'DPF')
                                          then 6
                                     end
                                end,
       r08_tasa_anual_rend    = convert(varchar, round(isnull(dp_tasa,0),2)),                                                    --27
       r08_moneda             = case when dp_moneda = @w_moneda_local then 14 else 4 end,                                        --28
       r08_plazo              = isnull(dp_plazo_dias,0),                                                                         --29
       r08_fecha_vencimiento  = isnull(convert(varchar,dp_fecha_vencimiento,112),'19000101'),                                    --30
       r08_saldo_periodo_ini  = round(isnull((select top 1 isnull(dp_saldo_disponible,0)                                         --31
                                                         + isnull(dp_saldo_camara12h,0)
                                                         + isnull(dp_saldo_camara24h,0)
                                                         + isnull(dp_saldo_camara48h,0)
                                                from cob_conta_super..sb_dato_pasivas
                                               where dp_fecha   >= @w_fecha_ini
                                                 and dp_cliente  = dc_cliente
                                                 and dp_banco    = dp_banco),0),0),
       r08_monto_deposito     = case when dp_aplicativo = (select eq_valor_arch                                                  --32
                                                             from sb_equivalencias
                                                            where eq_catalogo   = 'TIPRODUCTO'
                                                              and eq_valor_cat  = 'AHORROS')
                                     then
                                         (select round(isnull(sum(dd_monto),0),0)
                                            from cob_conta_super..sb_dato_transaccion,
                                                 cob_conta_super..sb_dato_transaccion_det
                                           where dt_banco      = dd_banco
                                             and dt_fecha      = dd_fecha
                                             and dt_fecha      = dp_fecha                                                            
                                             and dt_banco      = dp_banco
                                             and dt_secuencial = dd_secuencial
                                             and dp_fecha between @w_fecha_ini and @i_fecha
                                             and dt_tipo_trans = 'DEP'
                                             and dd_concepto   in ('CAP'))
                                else case when dp_aplicativo = (select eq_valor_arch
                                                                  from sb_equivalencias
                                                                 where eq_catalogo   = 'TIPRODUCTO'
                                                                   and eq_valor_cat  = 'DPF')
                                          then
                                              (select round(isnull(sum(dd_monto),0),0)
                                                 from cob_conta_super..sb_dato_transaccion,
                                                      cob_conta_super..sb_dato_transaccion_det
                                                where dt_banco      = dd_banco
                                                  and dt_fecha      = dd_fecha
                                                  and dt_fecha      = dp_fecha                                                            
                                                  and dt_banco      = dp_banco
                                                  and dt_secuencial = dd_secuencial
                                                  and dp_fecha between @w_fecha_ini and @i_fecha
                                                  and dt_tipo_trans = 'APE'
                                                  and dd_concepto   in ('CAP'))
                                     end
                                end,
       r08_monto_retiro       = case when dp_aplicativo = (select eq_valor_arch                                                  --33
                                                             from sb_equivalencias
                                                            where eq_catalogo   = 'TIPRODUCTO'
                                                              and eq_valor_cat  = 'AHORROS')
                                     then
                                         (select round(isnull(sum(dd_monto),0),0)
                                            from cob_conta_super..sb_dato_transaccion,
                                                 cob_conta_super..sb_dato_transaccion_det
                                           where dt_banco      = dd_banco
                                             and dt_fecha      = dd_fecha
                                             and dt_fecha      = dp_fecha
                                             and dt_banco      = dp_banco
                                             and dt_secuencial = dd_secuencial
                                             and dp_fecha between @w_fecha_ini and @i_fecha
                                             and dt_tipo_trans = 'RET'
                                             and dd_concepto   in ('CAP'))
                                else case when dp_aplicativo = (select eq_valor_arch
                                                                  from sb_equivalencias
                                                                 where eq_catalogo   = 'TIPRODUCTO'
                                                                   and eq_valor_cat  = 'DPF')
                                          then
                                              (select round(isnull(sum(dd_monto),0),0)
                                                 from cob_conta_super..sb_dato_transaccion,
                                                      cob_conta_super..sb_dato_transaccion_det
                                                where dt_banco      = dd_banco
                                                  and dt_fecha      = dd_fecha
                                                  and dt_fecha      = dp_fecha                                                            
                                                  and dt_banco      = dp_banco
                                                  and dt_secuencial = dd_secuencial
                                                  and dp_fecha between @w_fecha_ini and @i_fecha
                                                  and dt_tipo_trans = 'CAN'
                                                  and dd_concepto   in ('CAP'))
                                     end
                                end,
       r08_interes_devengado  = isnull(dp_saldo_int,0),                                                                          --34
       r08_saldo_periodo_fin  = round(isnull(dp_saldo_disponible,0)                                                              --35
                                    + isnull(dp_saldo_camara12h,0)
                                    + isnull(dp_saldo_camara24h,0)
                                    + isnull(dp_saldo_camara48h,0),0),
       r08_fecha_ult_mov      = isnull(convert(varchar,dp_fecha_radicacion,112),'19000101'),                                     --36
       r08_tipo_apertura_cta  = case when dp_aplicativo = (select eq_valor_arch                                                  --37
                                                             from sb_equivalencias
                                                            where eq_catalogo   = 'TIPRODUCTO'
                                                              and eq_valor_cat  = 'AHORROS')
                                     then
                                         case when dp_origen in ('16','17','21')
                                              then (select convert(numeric(3),eq_valor_cat)
                                                      from cob_conta_super..sb_equivalencias
                                                     where eq_catalogo  = 'AH_TIPOCTA'
                                                       and eq_valor_arch = dp_origen)
                                              else 5
                                         end
                                else case when dp_aplicativo = (select eq_valor_arch
                                                                  from sb_equivalencias
                                                                 where eq_catalogo   = 'TIPRODUCTO'
                                                                   and eq_valor_cat  = 'DPF')
                                          then 1
                                     end
                                end
  into #reporte_r08

  from cob_conta_super..sb_dato_pasivas,
       cob_conta_super..sb_dato_cliente,
       cob_conta_super..sb_dato_direccion
	   
 where dp_cliente    = dc_cliente
   and dd_cliente    = dp_cliente
   and dd_cliente    = dc_cliente
   and dc_fecha      = (select max(dc_fecha) from cob_conta_super..sb_dato_cliente where dc_cliente = dp_cliente)
   and dd_fecha      = (select max(dd_fecha) from cob_conta_super..sb_dato_direccion where dd_cliente = dp_cliente)
   and dp_estado     = 1
   and dd_principal  = 'S'
   and dp_fecha between @w_fecha_ini and @i_fecha
   --and dp_fecha      = @i_fecha
   and dp_aplicativo in (select eq_valor_arch
                           from sb_equivalencias
                          where eq_catalogo   = 'TIPRODUCTO'
                            and eq_valor_cat  in ('AHORROS','DPF'))

if @@error <> 0 begin
   select @w_msg = 'ERROR INSERTANDO DATOS DE AHORROS EN #REPORTE_R08'
   goto ERRORFIN
end

truncate table cob_conta_super..sb_reporte_r08

insert into cob_conta_super..sb_reporte_r08
(
    PERIODO           ,CLAVE_ENTIDAD     ,SUBREPORTE       ,IDENTIFICACION    ,TIPO_SOCIO
   ,NOM_RAZ_SOCIAL    ,APELLIDO_PATERNO  ,APELLIDO_MATERNO ,RFC_SOCIO         ,CURP_SOCIO
   ,GENERO            ,FECHA_NAC_CONS    ,POSTAL_DOMICILIO ,LOCAL_DOMICILIO   ,ESTADO_DOMICILIO
   ,PAIS_DOMICILIO    ,NUM_CERTI_APO     ,MONTO_CERTI_APO  ,NUM_CERTI_EXCED   ,MONTO_CERTI_EXCED
   ,NUMERO_CONTRATO   ,NUMERO_CUENTA     ,NOMBRE_SUCURSAL  ,FECHA_CONTRATO    ,TIPO_PRODUCTO
   ,TIPO_MODALIDAD    ,TASA_ANUAL_REND   ,MONEDA           ,PLAZO             ,FECHA_VENCIMIENTO
   ,SALDO_PERIODO_INI ,MONTO_DEPOSITO    ,MONTO_RETIRO     ,INTERES_DEVENGADO ,SALDO_PERIODO_FIN
   ,FECHA_ULT_MOV     ,TIPO_APERTURA_CTA
)
select
    r08_periodo           ,r08_clave_entidad     ,r08_subreporte       ,r08_identificacion    ,r08_tipo_socio
   ,r08_nom_raz_social    ,r08_p_apellido        ,r08_s_apellido       ,r08_rfc_socio         ,r08_curp_socio
   ,r08_genero            ,r08_fecha_nac_cons    ,r08_postal_domicilio ,r08_local_domicilio   ,r08_estado_domicilio
   ,r08_pais_domicilio    ,r08_num_certi_apo     ,r08_monto_certi_apo  ,r08_num_certi_exced   ,r08_monto_certi_exced
   ,r08_num_contrato      ,r08_cta_banco         ,r08_nom_sucursal     ,r08_fecha_contrato    ,r08_tipo_producto
   ,r08_tipo_modalidad    ,r08_tasa_anual_rend   ,r08_moneda           ,r08_plazo             ,r08_fecha_vencimiento
   ,r08_saldo_periodo_ini ,r08_monto_deposito    ,r08_monto_retiro     ,r08_interes_devengado ,r08_saldo_periodo_fin
   ,r08_fecha_ult_mov     ,r08_tipo_apertura_cta
  from #reporte_r08

if @@error <> 0 begin
   select @w_msg = 'ERROR INSERTANDO DATOS DE AHORROS EN SB_REPORTE_R08'
   goto ERRORFIN
end

--Ejecucion para Generar Archivo Datos
select @w_comando = @w_s_app + 's_app bcp -auto -login cob_conta_super..sb_reporte_r08 out '

select @w_destino  = @w_path + 'reporte_r08_' + convert(varchar, datepart(yy, @i_fecha)) + right('0'+ convert(varchar,datepart(mm,@i_fecha)),2) + '.csv',
       @w_errores  = @w_path + 'reporte_r08_' + convert(varchar, datepart(yy, @i_fecha)) + right('0'+ convert(varchar,datepart(mm,@i_fecha)),2) + '.err'

select @w_comando = @w_comando + @w_destino + ' -b5000 -c -e -T -C' + @w_errores + ' -t";" ' + '-config '+ @w_s_app + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select @w_msg = 'ERROR EN EJECUCION ' + @w_comando
   goto ERRORFIN
end

FIN:
return 0

ERRORFIN: 

   exec cob_conta_super..sp_errorlog
   @i_operacion     = 'I',
   @i_fecha_fin     = @i_fecha,
   @i_fuente        = @w_sp_name,
   @i_origen_error  = '28016',
   @i_descrp_error  = @w_msg
   
   return 1
go

