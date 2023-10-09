/************************************************************************/
/*  Archivo           :  ca_extinfbu.sp                                 */
/*  Stored procedure  :  sp_extrae_inf_buro                             */
/*  Base de datos     :  cob_cartera                                    */
/*  Producto          :  CARTERA                                        */
/*  Disenado por      :  Pedro Romero/Walther Toledo                    */
/*  Fecha de escritura:  31-Jul-2017                                    */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.   Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Consulta de informacion del cliente, direccion, empleo y creditos   */
/*  para generacion del reporte de Buro de Credito                      */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA        AUTOR           RAZON                                   */
/*  02/Ago/2017  W. Toledo       Emision Inicial                         */
/************************************************************************/
USE cob_conta_super
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_extrae_inf_buro')
           drop proc sp_extrae_inf_buro
go

create proc sp_extrae_inf_buro
as

DECLARE 
@w_cadena       VARCHAR (150), 
@w_seg_nom_cli  VARCHAR (375), 
@w_seg_dir_cli  VARCHAR (307), 
@w_seg_emp_cli  VARCHAR (307), 
@w_pre_cero    VARCHAR (2), 
@w_edades       VARCHAR (40),
-- -------------------------
@w_cliente      INT, 
@w_seg_intf     VARCHAR (10), 
@w_seg_pn       VARCHAR (10), 
@w_seg_pa       VARCHAR (10), 
@w_seg_pe       VARCHAR (10), 
@w_seg_tl       VARCHAR (10), 
@w_seg_tr       VARCHAR (10), 
-- -------------------------
@w_version      VARCHAR (10), 
@w_member_code  VARCHAR(20), 
@w_nombre_banco VARCHAR(20),
@w_tipo_telef   VARCHAR (10),
@w_etiq_no_pro  VARCHAR (10),
-- -------------------------
@i_fecha_proceso   DATETIME 

SELECT @i_fecha_proceso = '06/30/2017' 
SELECT @w_cliente = 2597 

SELECT 
@w_seg_intf = 'INTF', 
@w_seg_pn   = 'PN', 
@w_seg_pa   = 'PA', 
@w_seg_pe   = 'PE', 
@w_seg_tl   = 'TL', 
@w_seg_tr   = 'TR', 
@w_version  = '14', 
@w_member_code   = 'ZZ99990001', 
@w_nombre_banco  = 'BCO COBIS       '

select
@w_pre_cero = '00'

select @w_tipo_telef = pa_char 
  from cobis..cl_parametro 
 where pa_nemonico='TTBC'

select @w_etiq_no_pro = pa_char
  from cobis..cl_parametro
 where pa_producto = 'CRE'
   and pa_nemonico = 'ESCNP'

------- segmento: INTF - encabezado 
SELECT @w_cadena =  @w_seg_intf + 
                    @w_version + 
                    @w_member_code + 
                    @w_nombre_banco + 
                    '  ' + -- reservado 2 caracteres en blanco 
                    replace(convert(VARCHAR, @i_fecha_proceso, 104), '.','') + -- ddmmyyyy 
                    replicate('0',10) + -- 10 ceros 
                    replicate(' ',98)  -- 98 espacios 
select @w_cadena
-- ------------------------------------------------------------------------------------
------- segmento: PN - nombre del cliente
-- ------------------------------------------------------------------------------------
delete from sb_buro_cliente

insert into sb_buro_cliente(
bc_en_ente	    , bc_p_apellido	 , bc_s_apellido	 , bc_ad_apellido	 , bc_en_nombre	 , bc_s_nombre	    ,
bc_fecha_nac	 , bc_en_rfc    	 , bc_pref_pers	 , bc_suf_pers	    , bc_nacionalidad , bc_tresidencia	 ,
bc_lic_conducir , bc_ecivil	    , bc_sexo	       , bc_seg_social	 , bc_reg_electoral, bc_iden_unica	 ,
bc_clave_pais	 , bc_num_depend	 , bc_edades_dep	 , bc_fec_defuncion, bc_ind_defuncion
)
SELECT --@w_seg_nom_cli =
         -- PN - APELLIDO PATERNO
         en_ente,
         'PN' + dbo.fn_formatea_texto(26, dbo.fn_formatea_ascii_ext(p_p_apellido,'A'), null,'N','N'),
         -- 00 - APELLIDO MATERNO
         '00' + case p_s_apellido 
                  when null then '16NO PROPORCIONADO' 
                  else dbo.fn_formatea_texto(26, dbo.fn_formatea_ascii_ext(p_s_apellido,'A'), null,'N','N')
                end,
         -- 01 - APELLIDO ADICIONAL(o) - Pend
         '01' + dbo.fn_formatea_texto(26, dbo.fn_formatea_ascii_ext('APELLIDO ADICIONAL','A'), null,'N','N'),
         -- 02 - PRIMER NOMBRE
         '02' + dbo.fn_formatea_texto(26, dbo.fn_formatea_ascii_ext(en_nombre,'A'), null,'N','N'),
         -- 03 - SEGUNDO NOMBRE
         --'03' + dbo.fn_formatea_texto(26, p_s_nombre, null,'N','N'),
         '03' + case p_s_nombre
                  when null then '00' 
                  else dbo.fn_formatea_texto(26, dbo.fn_formatea_ascii_ext(p_s_nombre,'A'), null,'N','N')
                end,
         -- 04 - FECHA DE NACIMIENTO (o)
         '04' + dbo.fn_formatea_texto(8, (replace(convert(varchar, p_fecha_nac, 103), '/', '')), null,'N','S'),
         -- 05 - RFC
         '05' + dbo.fn_formatea_texto(13, en_rfc, null,'N','N'),
         -- 06 - PREFIJO PERSONAL O PROFESIONAL(o) - Pend
         '06' + dbo.fn_formatea_texto(4, dbo.fn_formatea_ascii_ext('ING','A'), null,'N','N'),
         -- 07 - SUFIJO PERSONAL DEL CLIENTE (o) - Pend
         '07' + dbo.fn_formatea_texto(4, dbo.fn_formatea_ascii_ext('JR','A'), null,'N','N'),
         -- 08 - NACIONALIDAD DEL ACREDITADO
         '08' + dbo.fn_formatea_texto(2, 
                               isnull((select upper(eq_descripcion)
                                  from cob_conta_super..sb_equivalencias 
                                 where eq_catalogo='CL_PAIS_A6' 
                                   and eq_valor_cat = en_nacionalidad),'MX'), 
                               null,
                               'N',
                               'S'),
         -- 09 - TIPO DE RESIDENCIA
         '09' + dbo.fn_formatea_texto(1, 
                               (select upper(eq_valor_arch )
                                  from cob_conta_super..sb_equivalencias 
                                 where eq_catalogo='CL_TVIVIEN' 
                                   and eq_valor_cat = p_tipo_vivienda), 
                               null,
                               'N',
                               'N'),
         -- 10 - NUMERO DE LICENCIA DE CONDUCIR
         '10' + dbo.fn_formatea_texto(20, dbo.fn_formatea_ascii_ext(en_licencia,'AN'), null,'N','N'),
         -- 11 - ESTADO CIVIL
         '11' + dbo.fn_formatea_texto(1, 
                               (select upper(eq_valor_arch )
                                  from cob_conta_super..sb_equivalencias 
                                 where eq_catalogo='CL_ECIVIL' 
                                   and eq_valor_cat = p_estado_civil),
                                null,
                                'N',
                                'S'),
         -- 12 - SEXO
         '12' + dbo.fn_formatea_texto(1, p_sexo, null,'N','S'),
         -- 13 - NUMERO DE SEGURIDAD SOCIAL (o) - Pend
         '13' + dbo.fn_formatea_texto(20, dbo.fn_formatea_ascii_ext('1234567890','AN'), null,'N','N'),
         -- 14 - NUMERO DE REGISTRO ELECTORAL (IFE, INE)(o) - Pend
         '10' + dbo.fn_formatea_texto(20, dbo.fn_formatea_ascii_ext('0987654321','AN'), null,'N','N'),
         -- 15 - CLAVE DE IDENTIFICACION UNICA (CURP EN MEXICO)
         '15' + dbo.fn_formatea_texto(20, dbo.fn_formatea_ascii_ext('1357908642','AN'), null,'N','N'),
         -- 16 - CLAVE DE PAIS
         '16' + dbo.fn_formatea_texto(2, 
                               (select upper(eq_descripcion)
                                  from cob_conta_super..sb_equivalencias 
                                 where eq_catalogo='CL_PAIS_A6' 
                                   and eq_valor_cat = en_nacionalidad), 
                               null,
                               'N',
                               'S'),
         -- 17 - NUMERO DE DEPENDIENTES
         '17' + dbo.fn_formatea_texto(2, null, case when p_num_cargas > 15 then 15 else p_num_cargas end,'N','S'),
         -- 18 - EDADES DE LOS DEPENDIENTES
         '18' + dbo.fn_formatea_texto(30, (replicate('01',case when p_num_cargas > 15 then 15 else p_num_cargas end)), null,'N','N'),
         -- 20 - FECHA DE DEFUNCION(o) - Pend
         '20' + dbo.fn_formatea_texto(8, (replace(convert(varchar, p_fecha_nac, 103), '/', '')), null,'N','S'),
         -- 21 - INDICADOR DE DEFUNCION(o) - Pend
         '21'+ dbo.fn_formatea_texto(1, ' ', null,'N','S')
from cobis..cl_ente
--where en_ente = @w_cliente --PARA PRUEBAS EN DESA
where en_ente in (
         select top 1000 ea_ente 
           from cobis..cl_ente_aux 
          where ea_estado='P')
         --select distinct op_cliente 
         --  from cob_cartera..ca_operacion 
         -- where op_estado = 1
         --   and op_toperacion = 'INDIVIDUAL')

-- select @w_seg_nom_cli

-- ------------------------------------------------------------------------------------
-- Segmento de Dirección del Cliente - PA
-- ------------------------------------------------------------------------------------
delete from sb_buro_direccion

insert into sb_buro_direccion(
bd_di_ente    , bd_pri_linea  , bd_seg_linea  , bd_colonia    , bd_delegacion , bd_ciudad     ,
bd_estado     , bd_cod_postal , bd_fec_reside , bd_num_telf   , bd_ext_telf   , bd_num_fax    ,
bd_tdomicilio , bd_ind_esp_dom, bd_org_dom
)
select  di_ente,-- @w_seg_dir_cli = 
        -- PA - PRIMER LINEA DE DIRECCION
        @w_seg_pa + dbo.fn_formatea_texto(40, 
                                    (  dbo.fn_formatea_ascii_ext(
                                          case 
                                             when len(rtrim(ltrim(di_descripcion + isnull(convert(varchar,di_nro),' SN')))) <= 40 then 
                                                di_descripcion + ' ' + isnull(convert(varchar,di_nro),' SN')
                                             else
                                                substring(rtrim(ltrim(di_descripcion + isnull(convert(varchar,di_nro),' SN'))),1,40)
                                             
                                          end,
                                          'AN'
                                       )
                                    ),
                                    null, 'N', 'N'),
        -- 00 - SEGUNDA LINEA DE DIRECCION
        '00' + dbo.fn_formatea_texto(40, 
                                    (  dbo.fn_formatea_ascii_ext(
                                          case 
                                             when len(rtrim(ltrim(di_descripcion + isnull(convert(varchar,di_nro),' SN')))) > 40 then 
                                                substring(rtrim(ltrim(di_descripcion + isnull(convert(varchar,di_nro),' SN'))),41,80)
                                          end,
                                          'AN'
                                       )
                                    ), 
                                    null, 'N', 'N'),
        -- 01 - COLONIA O POBLACION
        '01' + dbo.fn_formatea_texto(40, 
                                    dbo.fn_formatea_ascii_ext(
                                       (select pq_descripcion 
                                          from cobis..cl_parroquia 
                                         where pq_parroquia = di_parroquia),
                                       'AN'
                                    ),
                                    null, 'N', 'N'),
        -- 02 - DELEGACION O MUNICIPIO
        '02' + dbo.fn_formatea_texto(40,
                                    dbo.fn_formatea_ascii_ext(
                                       (select ci_descripcion 
                                           from cobis..cl_ciudad 
                                          where ci_ciudad = di_ciudad),
                                       'AN'
                                    ), 
                                    null,'N', 'N'),
        -- 03 - CIUDAD
        '03' + dbo.fn_formatea_texto(40,
                                    dbo.fn_formatea_ascii_ext(
                                       (select ci_descripcion 
                                           from cobis..cl_ciudad 
                                          where ci_ciudad = di_ciudad),
                                       'AN'
                                    ),
                                    null,'N','N'),
        -- 04 - ESTADO
        '04' + dbo.fn_formatea_texto(4,                                       
                                    (select upper(eq_valor_arch)
                                       from cob_conta_super..sb_equivalencias 
                                      where eq_catalogo='ESTADOS_A7' 
                                        and eq_valor_cat = di_provincia
                                    ),
                                    null, 'N', 'N'),
        -- 05 - CODIGO POSTAL
        '05' + dbo.fn_formatea_texto(5, 
                                    (select case 
                                              when eq_descripcion != 'MX' and di_codpostal is null then '00000'
                                              else eq_descripcion
                                            end
                                       from cob_conta_super..sb_equivalencias 
                                      where eq_catalogo='CL_PAIS_A6' 
                                        and eq_valor_cat = di_pais), 
                                    null,'N','S'),
        -- 06 - FECHA DE RESIDENCIA - Pend
        '06' + dbo.fn_formatea_texto(8, (replace(convert(varchar, (select fp_fecha from cobis..ba_fecha_proceso), 103), '/', '')), null,'N','S'),
        -- 07 - NUMERO DE TELEFONO
        '07' + dbo.fn_formatea_texto(11,
                                     (select te_valor from cobis..cl_telefono 
                                       where te_tipo_telefono = @w_tipo_telef 
                                         and te_ente = di_ente and te_direccion = di_direccion), 
                                     null, 'N', 'N'),
        -- 08 - EXTENSION TELEFONICA - Pend
        '08' + dbo.fn_formatea_texto(8,
                                     (select te_valor from cobis..cl_telefono 
                                       where te_tipo_telefono = @w_tipo_telef 
                                         and te_ente = di_ente and te_direccion = di_direccion), 
                                     null, 'N', 'N'),
        -- 09 - NUMERO DE FAX EN ESTA DIRECCION - Pend
        '09' + dbo.fn_formatea_texto(8,
                                     (select te_valor from cobis..cl_telefono 
                                       where te_tipo_telefono = @w_tipo_telef 
                                         and te_ente = di_ente and te_direccion = di_direccion), 
                                     null, 'N', 'N'),
        -- 10 - TIPO DE DOMICILIO - Pend
        '10' + dbo.fn_formatea_texto(1, dbo.fn_formatea_ascii_ext('C','A'), null,'N','S'),
        -- 11 - INDICADOR ESPECIAL DE DOMICILIO - Pend
        '11' + dbo.fn_formatea_texto(1, dbo.fn_formatea_ascii_ext('R','A'), null,'N','S'),
        -- 12 - ORIGEN DEL DOMICILIO (PAÍS)
        '12' + dbo.fn_formatea_texto(2, 
                                     (select eq_descripcion from cob_conta_super..sb_equivalencias 
                                       where eq_catalogo='CL_PAIS_A6' and eq_valor_cat = di_pais),
                                     null,
                                     'N',
                                     'S')
from cobis..cl_direccion
where di_ente = @w_cliente
and di_principal = 'S'

-- Segmento de Empleo del Cliente - PA
-- select @w_seg_emp_cli = 


   return 0

go

