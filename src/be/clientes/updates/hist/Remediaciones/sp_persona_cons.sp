use cobis
go
if not object_id('sp_persona_cons') is null
   drop proc sp_persona_cons
go
create procedure sp_persona_cons (
   @s_ssn                  int             = null,
   @s_user                 login           = null,
   @s_term                 varchar(32)     = null,
   @s_date                 datetime        = null,
   @s_srv                  varchar(30)     = null,
   @s_lsrv                 varchar(30)     = null,
   @s_ofi                  smallint        = null,
   @s_rol                  smallint        = null,
   @s_org_err              char(1)         = null,
   @s_error                int             = null,
   @s_sev                  tinyint         = null,
   @s_msg                  descripcion     = null,
   @s_org                  char(1)         = null,
   @t_debug                char(1)         = 'N',
   @t_file                 varchar(10)     = null,
   @t_from                 varchar(32)     = null,
   @t_trn                  smallint        = null,
   @i_operacion            char(1),
   @i_persona              int             = null,
   @i_tipo                 char(1)         = null,
   @i_nit                  numero          = null,
   @i_formato_fecha        int             = null,
   @t_show_version         bit             = 0,
   @o_nit                  varchar(20)     = null out,
   @o_retencion            char(1)         = null out,
   @o_sub_tipo             char(1)         = null out,
   @o_pjuridica            char(10)        = null out,
   @o_ced_ruc              char(25)        = null out,
   @i_modo                 int             = null
)
as
declare 
   @w_today                        datetime,
   @w_sp_name                      varchar(32),
   @w_return                       int,
   @w_dias_anio_nac                smallint,
   @w_dias_anio_act                smallint,
   @w_inic_anio_nac                datetime,
   @w_inic_anio_act                datetime,
   @w_anio_nac                     char(4),
   @w_anio_act                     char(4),
   @w_siguiente                    int,
   @w_codigo                       int,
   @w_nombre                       varchar(64),
   @w_p_apellido                   varchar(30),
   @w_s_apellido                   varchar(30),
   @w_sexo                         descripcion,
   @w_tipo_ced                     char(4),
   @w_cedula                       numero,
   @w_pasaporte                    varchar(20),
   @w_pais                         smallint,
   @w_des_pais                     descripcion,
   @w_profesion                    catalogo,
   @w_des_profesion                descripcion,
   @w_estado_civil                 catalogo,
   @w_des_estado_civil             descripcion,
   @w_num_cargas                   tinyint,
   @w_num_hijos                    tinyint,
   @w_nivel_ing                    money,
   @w_nivel_egr                    money,
   @w_filial                       int,
   @w_oficina                      smallint,
   @w_oficina_origen               smallint,
   @w_des_oficina                  descripcion,
   @w_tipo                         catalogo,
   @w_des_tipo                     descripcion,
   @w_nivel_estudio                catalogo,
   @w_des_niv_est                  descripcion,
   @w_tipo_vivienda                catalogo,
   @w_des_tipo_vivienda            descripcion,
   @w_calif_cliente                catalogo,
   @w_des_calif_cliente            descripcion,
   @w_grupo                        int,
   @w_des_grupo                    descripcion,
   @w_fecha_nac                    datetime,
   @w_fechanac                     varchar(10),
   @w_fechareg                     varchar(10),
   @w_fechamod                     varchar(10),
   @w_fechaing                     varchar(10),
   @w_cod_sex                      sexo,
   @w_fechaexp                     varchar(10),
   @w_ciudad_nac                   int,
   @w_lugar_doc                    int,
   @w_doc_validado                 char(1),
   @w_rep_superban                 char(1),
   @w_des_lugar_doc                descripcion,
   @w_des_ciudad_nac               descripcion,
   @w_es_mayor_edad                char(1),            /* 'S' o 'N' */
   @w_tipoced                      char(4),
   @w_mayoria_edad                 smallint,           /* expresada en a$os */
   @w_oficial                      smallint,
   @w_des_oficial                  descripcion,
   @w_des_referido                 descripcion,
   @w_retencion                    char(1),
   @w_exc_sipla                    char(1),
   @w_exc_por2                     char(1),
   @w_asosciada                    catalogo,
   @w_tipo_vinculacion             catalogo,
   @w_des_tipo_vinculacion         descripcion,
   @w_mala_referencia              char(1),
   @w_actividad                    catalogo,
   @w_des_actividad                descripcion,
   @w_comentario                   varchar(254),
   @w_nit                          numero,
   @w_referido                     smallint,
   @w_cod_sector                   catalogo,
   @w_des_sector                   descripcion,
   @w_gran_contribuyente           char(1),
   @w_situacion_cliente            catalogo,
   @w_des_situacion_cliente        varchar(25),
   @w_patrim_tec                   money,
   @w_fecha_patrim_bruto           varchar(10),
   @w_total_activos                money,
   @w_catalogo                     catalogo,
   @w_nom_temp                     descripcion,
   @w_oficial_sup                  smallint,
   @w_des_oficial_sup              descripcion,
   @w_preferen                     char(1),
   @w_cem                          money,
   @w_direccion                    int,
   @w_c_apellido                   varchar(30) ,  --Campo apellido casada
   @w_segnombre                    varchar(50) ,  --Campo segundo nombre
   @w_depart_doc                   smallint    ,  --Codigo del departamento
   @w_numord                       char(4)     ,  --Codigo de orden CV
   @w_des_dep_doc                  varchar(20) ,
   @w_des_ciudad                   varchar(20),
   @w_promotor                     varchar(10),
   @w_des_promotor                 varchar(64),
   @w_num_pais_nacionalidad        int,     -- Codigo del pais de la nacionalidad del cliente
   @w_des_nacionalidad             descripcion,
   @w_cod_otro_pais                char(10),      -- Codigo del pais centroamericano
   @w_inss                         varchar(20),   -- Numero de seguro
   @w_licencia                     varchar(30),   -- Numero de licencia
   @w_ingre                        varchar(10),   -- Ingresos
   @w_des_ingresos                 varchar(60),
   @w_principal_login              login,       -- login del oficial principal
   @w_suplente_login               login,         -- login del oficial suplente
   @w_en_id_tutor                  varchar(20),   -- ID del tutor
   @w_en_nom_tutor                 varchar(60),   -- Nombre del Tutor
   @w_bloquear                     char(1),        -- Cliente bloqueado
   @w_relacion                     catalogo,
   @w_digito                       char(2),
   @w_desc_tipo_ced                descripcion,
   @w_canal_bv                     tinyint,
   @w_tipo_medio                   varchar(6),
   @w_desc_tipo_medio              varchar(64),
   @w_categoria                    catalogo,   --I.CVA Abr-23-07
   @w_categoria_cli                varchar(255),
   @w_descripcion_cobis            varchar(64),      
   @w_desc_categoria               varchar(64), --I.CVA Abr-23-07
   @w_es_cliente                   char, --AVI vista consolidada
   @w_referido_ext                 int,             -- REQ CL00012
   @w_des_referido_ext             descripcion,     -- REQ CL00012
   @w_referidor_ecu                int,
   @w_carg_pub                     varchar(10),
   @w_rel_carg_pub                 varchar(10),
   @w_vu_pais                      catalogo,
   @w_vu_banco                     catalogo,
   @w_situacion_laboral            varchar(5),      -- ini CL00031 RVI
   @w_des_situacion_laboral        descripcion,
   @w_bienes                       char(1),
   @w_otros_ingresos               money,
   @w_origen_ingresos              descripcion,     -- fin CL00031 RVI
   @o_ea_estado                    catalogo,
   @w_ea_estado_desc               descripcion,
   @o_ea_observacion_aut           varchar(255 ),
   @o_ea_contrato_firmado          char(1),
   @o_ea_menor_edad                char(1),
   @o_ea_conocido_como             varchar(255 ),
   @o_ea_cliente_planilla          char(1),
   @o_ea_cod_risk                  varchar(20),
   @o_ea_sector_eco                catalogo,
   @o_ea_actividad                 catalogo,
   @o_ea_empadronado               char(1),
   @o_ea_lin_neg                   catalogo,
   @o_ea_seg_neg                   catalogo,
   @o_ea_val_id_check              catalogo,
   @o_ea_ejecutivo_con             int,
   @o_ea_suc_gestion               smallint,
   @o_ea_constitucion              smallint,
   @o_ea_emp_planilla              char(1),
   @o_ea_remp_legal                int,
   @o_ea_apoderado_legal           int,
   @o_ea_act_comp_kyc              char(1),
   @o_ea_fecha_act_kyc             varchar(10),
   @o_ea_no_req_kyc_comp           char(1),
   @o_ea_act_perfiltran            char(1),
   @o_ea_fecha_act_perfiltran      varchar(10),
   @o_ea_con_salario               char(1),
   @o_ea_fecha_consal              varchar(10),
   @o_ea_sin_salario               char(1),
   @o_ea_fecha_sinsal              varchar(10),
   @o_ea_actualizacion_cic         char(1),
   @o_ea_fecha_act_cic             varchar(10),
   @o_ea_excepcion_cic             char(1),
   @o_ea_excepcion_pad             char(1),
   @o_ea_fuente_ing                catalogo,
   @o_ea_act_prin                  catalogo,
   @o_ea_detalle                   varchar(255),
   @o_ea_act_dol                   money,
   @o_ea_cat_aml                   catalogo,
   @w_ea_desc_aml                  descripcion,
   @o_ea_observacion_vincula       varchar(255),
   @o_ea_fecha_vincula             varchar(10),
   @o_arma_categoria               varchar(255),
   @o_c_funcionario                varchar(50),
   @o_c_verificado                 char(1),
   @w_moneda_dolar                 tinyint,
   @w_cotizacion                   float,
   @w_sueldo1                      money,
   @w_sueldo2                      money,
   @w_sueldo_dolar                 money,
   @o_fuente_ing                   varchar(255),
   @o_actividad_princ              varchar(255),
   @w_ultima_fecha                 datetime,
   @o_fecha_veri                   varchar(10),
   @o_act_cic                      char(1),
   @o_excep_cic                    char(1),
   @w_discapacidad                 char(1),
   @w_tipo_discapacidad            catalogo,
   @w_desc_discapacidad            descripcion,
   @w_ced_discapacidad             varchar(30),
   @w_asfi                         char(1),
   @w_egresos                      catalogo,
   @w_desc_egresos                 descripcion,
   @w_ifi                          char(1),
   @w_nacio_tipo_ced               varchar(15),
   @w_path_foto                    varchar(50),
   @w_nit_id                       numero,
   @w_nit_venc                     varchar(10),
   @w_calif_cli                    catalogo,
   @w_descalif_cli                 descripcion,
   @w_conyuge                      varchar(64),
   @w_emproblemado             char(1),
   @w_dinero_transac             money,
   @w_pep                           char(1),
   @w_mnt_pasivo                 money,
   @w_vinculacion                  char(1),
   @w_ant_nego                     int,
   @w_ventas                        money,
   @w_ot_ingresos                  money,
   @w_ct_ventas                    money,
   @w_ct_operativos               money,
   @w_ea_nro_ciclo_oi             money, --LPO Santander
   @w_persona_pub			 	   varchar(1),
   @w_ing_SN                  	   char(1),
   @w_otringr				       VARCHAR(10),
   @w_depa_nac				       SMALLINT,
   @w_nac_aux            	       INT,
   @w_pais_emi					   SMALLINT,
   @w_num_ciclos					INT,
   @w_ea_cta_banco					VARCHAR(45),
      --MTA
   @w_cod_relacion                 int,   
   @w_cod_conyugue                 int
   

-------------------------------------------
---VERSIONAMIENTO PROGRAMA-----------------
-------------------------------------------
if @t_show_version = 1
begin
    print 'Stored procedure sp_persona_cons, Version 4.0.0.19'
    return 0
end

select @w_today = @s_date
select @w_sp_name = 'sp_persona_cons'
select @w_mayoria_edad = 18 --MAYORIA DE EDAD

if @i_operacion = 'Q' --CONSULTA DE DATOS DE PERSONA
   begin
      if @t_trn = 132
         begin
            --CURSOR PARA ACTUALIZAR EL CAMPO DE CLIENTE EN LA CL_ENTE
            declare categoria cursor for

            select distinct b.valor, pd_descripcion   
            from cl_cliente,
               cl_det_producto,
               cl_producto,
               cl_homologar_cat, cl_tabla a, cl_catalogo b
            where cl_det_producto = dp_det_producto
            and cl_cliente       = @i_persona
            and dp_estado_ser    = 'V'
            and cl_rol           = hc_cat_cobis
            and hc_producto      = dp_producto
            and a.tabla = 'cl_cat_homologa_banco'
            and a.codigo = b.tabla
            and b.codigo = hc_cat_banco   
            and dp_producto = pd_producto 

            open categoria
            fetch next from categoria into 
               @w_categoria_cli,
               @w_descripcion_cobis

            while @@FETCH_STATUS = 0--@@sqlstatus = 0
               begin
                  select @o_arma_categoria = @o_arma_categoria  + @w_categoria_cli +  ' - '  + @w_descripcion_cobis + ' | '
                  fetch next from categoria into 
                     @w_categoria_cli,
                     @w_descripcion_cobis
               end

            close categoria
            deallocate categoria

            -- ULTIMA OBSERVACION DEL AUTORIZADOR (CAMBIO DE ESTADO)
            select @w_ultima_fecha = max(me_fecha)
            from cl_mod_estados
            where me_ente  = @i_persona

            select @o_ea_observacion_aut = me_observacion
            from cl_mod_estados
            where me_ente  = @i_persona
            and me_fecha = @w_ultima_fecha

            select  
               @w_p_apellido                 = a.p_p_apellido,
               @w_s_apellido                 = a.p_s_apellido,
               @w_nombre                     = a.en_nombre,
               @w_cedula                     = a.en_ced_ruc,
               @w_pasaporte                  = a.p_pasaporte,
               @w_pais                       = a.en_pais,
               @w_ciudad_nac                 = a.p_ciudad_nac,
			   @w_fecha_nac                  = a.p_fecha_nac,
               @w_fechanac                   = convert(char(10), a.p_fecha_nac, @i_formato_fecha),
               @w_fechareg                   = convert(char(10), a.en_fecha_crea, @i_formato_fecha),
               @w_fechamod                   = convert(char(10), a.en_fecha_mod, @i_formato_fecha),
               @w_retencion                  = a.en_retencion,
               @w_mala_referencia            = a.en_mala_referencia,
               @w_comentario                 = a.en_comentario,
               @w_fechaing                   = convert(char(10), a.p_fecha_emision, @i_formato_fecha),
               @w_fechaexp                   = convert(char(10), a.p_fecha_expira, @i_formato_fecha),
               @w_tipoced                    = a.en_tipo_ced,
               @w_asosciada                  = a.en_asosciada,
               @w_tipo_vinculacion           = a.en_tipo_vinculacion,
               @w_nit                        = a.en_nit,
               @w_referido                   = a.en_referido,
               @w_cod_sector                 = a.en_sector,
               @w_cod_sex                    = a.p_sexo,
               @w_profesion                  = a.p_profesion,
               @w_actividad                  = a.en_actividad,
               @w_estado_civil               = a.p_estado_civil,
               @w_tipo                       = a.p_tipo_persona,
               @w_nivel_estudio              = a.p_nivel_estudio,
               @w_grupo                      = a.en_grupo,
               @w_oficial                    = a.en_oficial,
               @w_lugar_doc                  = a.p_lugar_doc,
               @w_tipo_vivienda              = a.p_tipo_vivienda,
               @w_calif_cliente              = a.p_calif_cliente,
               @w_num_hijos                  = a.p_num_hijos,
               @w_nivel_ing                  = a.p_nivel_ing,
               @w_nivel_egr                  = a.p_nivel_egr,
               @w_num_cargas                 = a.p_num_cargas,
               @w_oficina_origen             = a.en_oficina ,
               @w_doc_validado               = a.en_doc_validado ,
               @w_rep_superban               = a.en_rep_superban ,
               @w_filial                     = a.en_filial,
               @w_gran_contribuyente         = a.en_gran_contribuyente,
               @w_situacion_cliente          = a.en_situacion_cliente,
               @w_patrim_tec                 = a.en_patrimonio_tec,
               @w_fecha_patrim_bruto         = convert(char(10), a.en_fecha_patri_bruto, @i_formato_fecha),
               @w_total_activos              = a.c_total_activos,
               @w_oficial_sup                = a.en_oficial_sup,
               @w_preferen                   = a.en_preferen,
               @w_exc_sipla                  = a.en_exc_sipla,
               @w_exc_por2                   = a.en_exc_por2,
               @w_digito                     = a.en_digito,
               @w_cem                        = a.en_cem,
               @w_c_apellido                 = a.p_c_apellido,
               @w_segnombre                  = a.p_s_nombre,
               @w_depart_doc                 = a.p_dep_doc,
               @w_numord                     = a.p_numord,
               @w_promotor                   = a.en_promotor,
               @w_num_pais_nacionalidad      = a.en_nacionalidad,
               @w_cod_otro_pais              = a.en_cod_otro_pais,
               @w_inss                       = a.en_inss,
               @w_licencia                   = a.en_licencia,
               @w_ingre                      = a.en_ingre,
               @w_en_id_tutor                = a.en_id_tutor,  --ID del tutor
               @w_en_nom_tutor               = a.en_nom_tutor,        --Nombre del Tutor
               @w_bloquear                   = a.en_estado,
               @w_categoria                  = a.en_concordato,  --I.CVA Abr-23-07 Campo para categoria
               --@w_es_cliente                 = (select case when (en_ente in (select cl_cliente from cl_cliente(index cl_cliente_Key))) then 'S' else 'N' end from cl_ente where en_ente = @i_persona and en_subtipo = 'P'),
               @w_es_cliente                 = (select case when (en_ente in (select cl_cliente from cl_cliente with (index (cl_cliente_Key)))) then 'S' else 'N' end from cl_ente where en_ente = @i_persona and en_subtipo = 'P'),
               @w_referido_ext               = a.en_referidor_ecu,
               @w_carg_pub                   = a.p_carg_pub,
               @w_rel_carg_pub               = a.p_rel_carg_pub,
               @w_situacion_laboral          = a.p_situacion_laboral,
               @w_bienes                     = a.p_bienes,
               @w_otros_ingresos             = a.en_otros_ingresos,
               @w_origen_ingresos            = a.en_origen_ingresos,
               @o_ea_estado                  = b.ea_estado,
               --@o_ea_observacion_aut         = b.ea_observacion_aut,
               @o_ea_contrato_firmado        = b.ea_contrato_firmado,
               @o_ea_menor_edad              = b.ea_menor_edad,
               @o_ea_conocido_como           = b.ea_conocido_como,
               @o_ea_cliente_planilla        = b.ea_cliente_planilla,
               @o_ea_cod_risk                = b.ea_cod_risk,
               @o_ea_empadronado             = 'N',--b.ea_empadronado,
               @o_c_funcionario              = a.c_funcionario,
               @o_ea_sector_eco              = b.ea_sector_eco,
               @o_ea_actividad               = b.ea_actividad,
               @o_ea_lin_neg                 = b.ea_lin_neg,
               @o_ea_seg_neg                 = b.ea_seg_neg,
               @o_ea_val_id_check            = 'N',--b.ea_val_id_check,
               @o_ea_ejecutivo_con           = b.ea_ejecutivo_con,
               @o_ea_suc_gestion             = b.ea_suc_gestion,
               @o_ea_constitucion            = b.ea_constitucion,
               @o_ea_emp_planilla            = b.ea_cliente_planilla,
               @o_ea_remp_legal              = b.ea_remp_legal,
               @o_ea_apoderado_legal         = b.ea_apoderado_legal,
               @o_ea_act_comp_kyc            = 'N',--b.ea_act_comp_kyc,
               @o_ea_fecha_act_kyc           = convert(char(10), getdate(), @i_formato_fecha),--convert(char(10), b.ea_fecha_act_kyc, @i_formato_fecha),
               @o_ea_no_req_kyc_comp         = 'N',--b.ea_no_req_kyc_comp,
               @o_ea_act_perfiltran          = 'N',--b.ea_act_perfiltran,
               @o_ea_fecha_act_perfiltran    = convert(char(10),getdate(), @i_formato_fecha),--convert(char(10),b.ea_fecha_act_perfiltran, @i_formato_fecha),
               @o_ea_con_salario             = 'N',--b.ea_con_salario,
               @o_ea_fecha_consal            = convert(char(10),getdate(), @i_formato_fecha),--convert(char(10),b.ea_fecha_consal, @i_formato_fecha),
               @o_ea_sin_salario             = 'N',--b.ea_sin_salario,
               @o_ea_fecha_sinsal            = convert(char(10), getdate(), @i_formato_fecha),--convert(char(10), b.ea_fecha_sinsal, @i_formato_fecha),
               @o_ea_actualizacion_cic       = 'N',--b.ea_actualizacion_cic,
               @o_ea_fecha_act_cic           = convert(char(10), getdate(), @i_formato_fecha),--convert(char(10), b.ea_fecha_act_cic, @i_formato_fecha),
               @o_ea_excepcion_cic           = 'N',--b.ea_excepcion_cic,
               @o_ea_excepcion_pad           = 'N',--b.ea_excepcion_pad,
               @o_ea_fuente_ing              = b.ea_fuente_ing,
               @o_ea_act_prin                = b.ea_act_prin,
               @o_ea_detalle                 = b.ea_detalle,
               @o_ea_act_dol                 = isnull(b.ea_act_dol, 0),
               @o_ea_cat_aml                 = b.ea_cat_aml,
               @o_ea_observacion_vincula     = b.ea_observacion_vincula,
               @o_ea_fecha_vincula           = convert(char(10), b.ea_fecha_vincula, @i_formato_fecha),
               @o_c_verificado               = a.c_verificado,
               @o_fecha_veri                 = convert(char(10), a.c_fecha_verif, @i_formato_fecha),
               @o_act_cic                    = 'N',--b.ea_actualizacion_cic,
               @o_excep_cic                  = 'N',--b.ea_excepcion_cic,
               @w_discapacidad               = b.ea_discapacidad,
               @w_tipo_discapacidad          = b.ea_tipo_discapacidad,
               @w_ced_discapacidad           = b.ea_ced_discapacidad,
               @w_asfi                       = b.ea_asfi,
               @w_egresos                    = b.ea_nivel_egresos,
               @w_ifi                        = b.ea_ifi,
               @w_path_foto                  = b.ea_path_foto,
               @w_nit_id                     = b.ea_nit,
               @w_nit_venc                   = convert(char(10), b.ea_nit_venc, @i_formato_fecha),
               @w_calif_cli                  = a.en_calif_cartera,               
               @w_emproblemado         = a.en_emproblemado,
               @w_dinero_transac         = a.en_dinero_transac,
               @w_pep                       = a.en_persona_pep,
               -- @i_mnt_activo              money         = null, --@i_total_activos
               @w_mnt_pasivo             = a.c_pasivo,
               @w_vinculacion              = a.en_vinculacion,                              
               @w_ant_nego                = b.ea_ant_nego,
               @w_ventas                   = b.ea_ventas,
               --@i_ot_ingresos    money = null,   @i_otros_ingresos  
               @w_ct_ventas                = ea_ct_ventas,
               @w_ct_operativos           = ea_ct_operativo,
               @w_ea_nro_ciclo_oi         = ea_nro_ciclo_oi,  --LPO Santander
               @w_persona_pub			 	 = en_persona_pub,
   			   @w_ing_SN                  	 = en_ing_SN,
   			   @w_otringr				     = en_otringr ,
   			   @w_depa_nac				     = p_depa_nac,
   			   @w_nac_aux            	     = en_nac_aux,
   			   @w_pais_emi					 = p_pais_emi,
   			   @w_ea_cta_banco              =b.ea_cta_banco 
            from  cl_ente as a
            inner join cl_ente_aux b on (a.en_ente = b.ea_ente)
            where a.en_subtipo = 'P'
            and a.en_ente    = @i_persona

            --print 'Promotor: %1!',@w_promotor

            if @@rowcount = 0
               begin
                  exec sp_cerror  @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 101001
                     --NO EXISTE DATO SOLICITADO
                  return 1
               end

            select @w_relacion = cg_tipo_relacion
            from cl_cliente_grupo
            where cg_ente = @i_persona

            if @w_cod_sex is not null
               begin
                  select @w_sexo = cl_catalogo.valor
                  from cl_catalogo, cl_tabla
                  where cl_catalogo.codigo = @w_cod_sex
                  and cl_catalogo.tabla  = cl_tabla.codigo
                  and cl_tabla.tabla     = 'cl_sexo'

                  if @@rowcount = 0
                     begin
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101022
                        return 1
                     end
            end

            --I.CVA Abr-23-07 Categoria
            if @w_categoria is not null
               begin
                  select @w_desc_categoria = cl_catalogo.valor
                  from cl_catalogo, cl_tabla
                  where cl_catalogo.codigo       = @w_categoria
                  and cl_catalogo.tabla        = cl_tabla.codigo
                  and cl_tabla.tabla           = 'cl_categoria'

                  if @@rowcount = 0
                     begin
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_msg      = 'No existe descripcion para categoria asociada al cliente',
                           @i_num      = 101170
                        return 1
                     end
            end
            if @w_actividad is not NULL
               begin
                  select  @w_des_actividad= ac_descripcion
                  from cl_actividad_ec
                  where ac_codigo = @w_actividad

                  if @@rowcount = 0
                     begin
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101027
                        return 1
                     end
               end

            if @w_cod_sector is not NULL
               begin
                  select  @w_des_sector= cl_catalogo.valor
                  from cl_catalogo, cl_tabla
                  where cl_catalogo.codigo       = @w_cod_sector
                  and cl_catalogo.tabla        = cl_tabla.codigo
                  and cl_tabla.tabla           = 'cl_sectoreco'

                  if @@rowcount = 0
                     begin
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101048
                        return 1
                     end
            end

            if @w_situacion_cliente is not NULL
               begin
                  select  @w_des_situacion_cliente = cl_catalogo.valor
                  from cl_catalogo, cl_tabla
                  where cl_catalogo.codigo       = @w_situacion_cliente
                  and cl_catalogo.tabla        = cl_tabla.codigo
                  and cl_tabla.tabla           = 'cl_situacion_cliente'

                  if @@rowcount = 0
                     begin
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101193
                        return 1
                     end
            end

            if (@w_estado_civil is not NULL and @w_estado_civil <> '')
               begin
                  select @w_des_estado_civil = cl_catalogo.valor
                  from cl_catalogo, cl_tabla
                  where cl_catalogo.codigo       = @w_estado_civil
                  and cl_catalogo.tabla        = cl_tabla.codigo
                  and cl_tabla.tabla           = 'cl_ecivil'

                  if @@rowcount = 0
                     begin
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101020
                           --NO EXISTE DATO SOLICITADO
                        return 1
                     end
            end

            if @w_nivel_estudio is not NULL
               begin
                  select @w_des_niv_est = cl_catalogo.valor
                  from cl_catalogo, cl_tabla
                  where cl_catalogo.codigo       = @w_nivel_estudio
                  and cl_catalogo.tabla        = cl_tabla.codigo
                  and cl_tabla.tabla           = 'cl_nivel_estudio'

                  if @@rowcount = 0 -- JLi
                  begin
                     exec sp_cerror  @t_debug    = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @w_sp_name,
                        @i_num      = 101170
                     return 1
                  end
            end

            if @w_tipo_vinculacion is not NULL
               begin
                  select @w_des_tipo_vinculacion = cl_catalogo.valor
                  from cl_catalogo, cl_tabla
                  where cl_catalogo.codigo       = @w_tipo_vinculacion
                  and cl_catalogo.tabla        = cl_tabla.codigo
                  and cl_tabla.tabla           = 'cl_relacion_banco'

                  if @@rowcount = 0 -- JLI
                     begin
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101194
                        return 1
                     end
            end

            if @w_tipo is not NULL
               begin
                  select @w_des_tipo = cl_catalogo.valor
                  from cl_catalogo, cl_tabla
                  where cl_catalogo.codigo   = @w_tipo
                  and cl_catalogo.tabla   = cl_tabla.codigo
                  and cl_tabla.tabla      = 'cl_ptipo'
                  
                  if @@rowcount = 0
                     begin
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101021
                        return 1
                        --NO EXISTE TIPO DE PERSONA
                     end
            end

            if @w_profesion is not NULL
               begin
                  select @w_des_profesion = cl_catalogo.valor
                  from cl_catalogo, cl_tabla
                  where cl_catalogo.codigo       = @w_profesion
                  and cl_catalogo.tabla        = cl_tabla.codigo
                  and cl_tabla.tabla           = 'cl_profesion'
                  
                  if @@rowcount = 0
                     begin
                        /*print 'pase profesion'*/
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101019
                        --NO EXISTE DATO SOLICITADO
                        return 1
                     end
            end

            if (@w_tipo_vivienda is not NULL and @w_tipo_vivienda <> '')
               begin
                  select @w_des_tipo_vivienda = cl_catalogo.valor
                  from cl_catalogo, cl_tabla
                  where cl_catalogo.codigo       = @w_tipo_vivienda
                  and cl_catalogo.tabla        = cl_tabla.codigo
                  and cl_tabla.tabla           = 'cl_tipo_vivienda'

                  if @@rowcount = 0
                     begin
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101171
                           --NO EXISTE TIPO DE VIVIENDA
                        return 1
                     end
            end

            --print 'Promotor: %1!',@w_promotor
            if @w_promotor is not NULL
               begin
                  select @w_des_promotor = cl_catalogo.valor
                  from cl_catalogo, cl_tabla
                  where cl_catalogo.codigo       = @w_promotor
                  and cl_catalogo.tabla        = cl_tabla.codigo
                  and cl_tabla.tabla           = 'cl_promotor'

                  if @@rowcount = 0 -- JLi
                     begin
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 107108
                           --NO EXISTE PROMOTOR
                        return 1
                     end
            end

            -- ingresos JLi
            if @w_ingre is not NULL
               begin
                  select @w_des_ingresos = cl_catalogo.valor
                  from cl_catalogo, cl_tabla
                  where cl_catalogo.codigo       = @w_ingre
                  and cl_catalogo.tabla        = cl_tabla.codigo
                  and cl_tabla.tabla           = 'cl_ingresos'

                  if @@rowcount = 0
                     begin
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 107123
                        --NO EXISTE DATO SOLICITADO
                        return 1
                     end
            end

            --VALIDANDO EL LUGAR DE NACIMIENTO
            /*if @w_ciudad_nac is NULL
               begin
                  select @w_des_ciudad_nac = NULL
               end
            else
               begin
                  select  @w_des_ciudad_nac = pa_descripcion
                  from  cl_pais
                  where  @w_ciudad_nac = pa_pais

                  if @@rowcount = 0
                     begin                   
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101001
                        --NO EXISTE DATO SOLICITADO
                        return 1
                     end
            end*/

            --if @w_tipoced = 'PA'
            if @w_tipoced ='P' or @w_tipoced = 'E' --or @w_tipoced = 'PE' or @w_tipoced = 'N'
               begin
                  select  @w_des_lugar_doc = pa_descripcion
                  --@w_des_lugar_doc = pa_nacionalidad
                  from  cl_pais
                  where  pa_pais          = @w_lugar_doc

                  /* if @@rowcount = 0
                     begin
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101001
                           --NO EXISTE DATO SOLICITADO
                        return 1
                     end*/
               end
            else
               begin
                  select  @w_des_lugar_doc = ci_descripcion
                  from  cl_ciudad
                  where  ci_ciudad        = @w_lugar_doc
                  --and    ci_provincia = @w_depart_doc

                  /*if @@rowcount = 0
                     begin
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101001
                           --NO EXISTE DATO SOLICITADO
                        return 1
                     end*/
            end

            if @w_grupo is NULL
               select @w_grupo = NULL
            else
               begin
                  select  @w_des_grupo = gr_nombre
                  from  cl_grupo
                  where  @w_grupo     = gr_grupo

                  /*if @@rowcount = 0
                     begin
                        --print 'pase Grupo'
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101001
                           --NO EXISTE DATO SOLICITADO
                        return 1
                     end*/
            end

            --SELECT SOBRE LA TABLA DE CL_FUNCIONARIO
            if @w_oficial is NULL or @w_oficial = 0
               select  @w_oficial = NULL
            else
               begin --MODIFICACION FUNCIONARIOS REC
                  select @w_nom_temp = fu_nombre,
                     @w_principal_login = fu_login
                  from cc_oficial,cl_funcionario
                  where oc_oficial = @w_oficial
                  and oc_funcionario = fu_funcionario

                  if @@rowcount = 0
                     begin
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101036
                        return 1
                     end

                  select @w_des_oficial = substring(@w_nom_temp,1,45)
                  --FIN MODIFICACION FUNCIONARIOS
                  if @@rowcount = 0
                     begin
                        --print 'pase Mod. FIn Funcionarios'
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101036
                           --NO EXISTE FUNCIONARIO
                        return 1
                     end
            end

            --SELECT SOBRE LA TABLA DE CL_FUNCIONARIO
            if @w_oficial_sup is NULL
               select  @w_oficial_sup = NULL
            else
               begin --MODIFICACION FUNCIONARIOS REC
                  /*select @w_nom_temp = fu_nombre
                     from cl_funcionario
                     where fu_funcionario = @w_oficial_sup*/

                  select @w_nom_temp = fu_nombre,
                     @w_suplente_login = fu_login
                  from cc_oficial,cl_funcionario
                  where oc_oficial = @w_oficial_sup
                  and oc_funcionario = fu_funcionario

                  if @@rowcount = 0
                     begin
                        --print 'pase Mod. Funcionarios'
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101036
                           --NO EXISTE FUNICIONARIO
                        return 1
                     end

                  select @w_des_oficial_sup = substring(@w_nom_temp,1,45)
                  --FIN MODIFICACION FUNCIONARIOS
                  if @@rowcount = 0
                     begin
                        --print 'pase Mod. FIn Funcionarios'
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101036
                           --NO EXISTE FUNICIONARIO
                        return 1
                     end
            end

            --SELECT SOBRE LA TABLA DE CL_FUNCIONARIO
            if @w_referido is NULL
               select  @w_referido = NULL
            else
               begin
                  select  @w_des_referido = substring(fu_nombre,1,45)
                  from  cl_funcionario
                  where  @w_referido     = fu_funcionario

                  if @@rowcount = 0
                     begin
                        --print 'pase referido'
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101036
                           --NO EXISTE FUNICIONARIO
                        return 1
                     end
            end

            --SELECT SOBRE LA TABLA DE CL_PAIS
            if @w_pais is NULL
               select @w_pais = NULL
            else
               begin
                  select      @w_des_pais = pa_descripcion
                  from cl_pais
                  where pa_pais   = @w_pais

                  if @@rowcount = 0
                     begin
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101018
                        return 1
                     end
            end

            --PARA NACIONALIDAD
            --SELECT SOBRE LA TABLA DE CL_PAIS
            if @w_num_pais_nacionalidad is NULL
               select @w_num_pais_nacionalidad = NULL
            else
               begin
                  select  @w_des_nacionalidad = pa_nacionalidad
                  from cl_pais
                  where @w_num_pais_nacionalidad = pa_pais

                  if @@rowcount = 0
                     begin
                        --print 'Error en Pais'
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101018
                        --NO EXISTE PAIS
                        return 1
                     end
               end

            --SELECT SOBRE LA TABLA DE CL_OFICINA
            /*select  @w_des_oficina = of_nombre
            from cl_oficina
            where @w_oficina_origen= of_oficina
            and @w_filial        = of_filial

            if @@rowcount = 0
               begin
                  --print 'pase des_oficina'
                  exec sp_cerror  @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 101016
                     --NO EXISTE DATO SOLICITADO
                  return 1
            end*/

            --ACTUAL
            --SPO Inclusion de la descripcion del departamento

            if @w_depart_doc is not NULL
               begin
                  select @w_des_dep_doc  = cl_catalogo.valor
                  from cl_catalogo, cl_tabla
                  where cl_catalogo.codigo       = convert(char(4),@w_depart_doc)
                  and cl_catalogo.tabla        = cl_tabla.codigo
                  and cl_tabla.tabla           = 'cl_provincia'

                  /*if @@rowcount = 0
                     begin
                        print 'No existe departamento'
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101010
                           --NO EXISTE DATO SOLICITADO
                        return 1
                     end*/
            end

            /*if @w_ciudad_nac is not NULL
               begin
                  select @w_des_ciudad  = cl_catalogo.valor
                  from cl_catalogo, cl_tabla
                  where cl_catalogo.codigo       = convert(char(4),@w_ciudad_nac)
                  and cl_catalogo.tabla        = cl_tabla.codigo
                  and cl_tabla.tabla           = 'cl_ciudad'

                  if @@rowcount = 0
                     begin
                        print 'No existe ciudad'
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101001
                           --NO EXISTE DATO SOLICITADO
                        return 1
                     end
               end*/

            if @w_tipoced <> null
               begin
                  select @w_desc_tipo_ced  = td_descripcion,
                     @w_nacio_tipo_ced = td_nacionalidad
                  from cl_tipo_documento
                  where td_codigo = @w_tipoced

                  if @@rowcount = 0
                     begin
                        exec sp_cerror
                           @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101203
                           --NO EXISTE TIPO DE IDENTIFICACION
                        return 1
                     end
            end

            --I. CVA MAR-23-06 OBTENER EL TIPO DE SERVICIO DE BANCA VIRTUAL PARA EL CLIENTE
            /*select  @w_canal_bv = af_canal
            from cobis..bv_afiliados_bv
            where af_ente_mis = @i_persona

            if @@rowcount > 0
               select  @w_tipo_medio           = b.codigo,
                  @w_desc_tipo_medio      = b.valor
               from cobis..cl_tabla a,  cobis..cl_catalogo b
               where a.tabla = 'bv_servicio'
               and b.tabla = a.codigo
               and b.codigo = convert(varchar(10),@w_canal_bv)*/
               --F. CVA Mar-23-06

            -- Ini EAN - HSBC - 14/AGO/2012
            select @o_actividad_princ = ap_descripcion
            from  cl_ente a,
               cl_ente_aux b,
               cl_actividad_principal
            where a.en_ente    = @i_persona
            and a.en_ente    = b.ea_ente
            and a.en_subtipo = 'P'
            and ap_codigo    = b.ea_act_prin

            select @o_fuente_ing = cat.valor
            from  cl_ente a,
               cl_ente_aux b,
               cl_catalogo cat, cl_tabla tbl
            where a.en_ente    = @i_persona
            and a.en_ente    = b.ea_ente
            and a.en_subtipo = 'P'
            and tbl.tabla    = 'cl_fuente_ingreso'
            and cat.tabla    = tbl.codigo
            and cat.codigo   = b.ea_fuente_ing
            -- Fin EAN - HSBC - 14/AGO/2012

            --DESCRIPCION DE DISCAPACIDAD
            if @w_tipo_discapacidad is not NULL
               begin
                  select @w_desc_discapacidad = cl_catalogo.valor
                  from    cl_catalogo, cl_tabla
                  where   cl_catalogo.codigo   = @w_tipo_discapacidad
                  and     cl_catalogo.tabla    = cl_tabla.codigo
                  and     cl_tabla.tabla       = 'cl_discapacidad'

                  if @@rowcount = 0
                     begin
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101239
                           --CODIGO DE DISCAPACIDAD INCORRECTO
                        return 1
                     end
            end

            --DESCRIPCION DE NIVEL DE EGRESOS
             if @w_egresos is not NULL
               begin
                  select @w_desc_egresos = cl_catalogo.valor
                  from    cl_catalogo, cl_tabla
                  where   cl_catalogo.codigo   = @w_egresos
                  and     cl_catalogo.tabla    = cl_tabla.codigo
                  and     cl_tabla.tabla       = 'cl_nivel_egresos'

                  if @@rowcount = 0
                     begin
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101244
                           --NO EXISTE CODIGO DE NIVEL DE EGRESOS
                        return 1
                     end
               end

            --DESCRIPCION DE LA CALIFICACION DEL CLIENTE
            if @w_calif_cli is not NULL
               begin
                  select @w_des_calif_cliente = cl_catalogo.valor
                  from    cl_catalogo, cl_tabla
                  where   cl_catalogo.codigo   = @w_calif_cli
                  and     cl_catalogo.tabla    = cl_tabla.codigo
                  and     cl_tabla.tabla       = 'ca_calif_cliente'

                  select @w_descalif_cli = @w_des_calif_cliente

                  if @@rowcount = 0
                     begin
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101141
                           --NO EXISTE TIPO DE CALIFICACION
                        return 1
                     end
               end

            --DESCRIPCION DE CATEGORIA AML
            if @o_ea_cat_aml is not NULL
               begin
                  select @w_ea_desc_aml = cl_catalogo.valor
                  from    cl_catalogo, cl_tabla
                  where   cl_catalogo.codigo   = @o_ea_cat_aml
                  and     cl_catalogo.tabla    = cl_tabla.codigo
                  and     cl_tabla.tabla       = 'cl_categoria_AML'

                  if @@rowcount = 0
                     begin
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101245
                           --NO EXISTE CODIGO DE CATEGORIA AML
                        return 1
                     end
               end
			   
			   --DESCRIPCION DE ESTADO DEL CLIENTE
               if @o_ea_estado is not NULL
                begin
                   select @w_ea_estado_desc = cl_catalogo.valor
                   from    cl_catalogo, cl_tabla
                   where   cl_catalogo.codigo   = @o_ea_estado
                   and     cl_catalogo.tabla    = cl_tabla.codigo
                   and     cl_tabla.tabla       = 'cl_estados_ente'
               
                   if @@rowcount = 0
                      begin
                         exec sp_cerror  @t_debug    = @t_debug,
                            @t_file     = @t_file,
                            @t_from     = @w_sp_name,
                            @i_num      = 101229 
                            --NO EXISTE ESTADO
                         return 1
                      end
                end
				
				--CONYUGE
                --MTA Inicio 
                --select @w_lado_relacion = 'I' 
                select @w_cod_relacion = pa_tinyint --relación cónyuge 
                  from cobis..cl_parametro 
                 where pa_nemonico = 'COU' 
                   and pa_producto = 'CRE'
                select @w_cod_conyugue = in_ente_d
                  from cobis..cl_instancia
                 where in_relacion = @w_cod_relacion
                   and in_ente_i= @i_persona

                select @w_conyuge = en_nombre+' '+ isnull(p_s_nombre, '')+' '+ p_p_apellido +' '+ isnull(p_s_apellido, '')
                  from cobis..cl_ente 
                 where en_ente = @w_cod_conyugue

                --Se comenta para tomar la información de relaciones entre clientes de la cl_instancia
                /*select @w_conyuge = hi_nombre +" "+ hi_s_nombre +" "+ hi_papellido +" "+ hi_sapellido  
                  from cl_hijos 
                 where hi_ente=@i_persona 
                   and hi_tipo='C'
                */
                --MTA Fin
				   
            if isnull(@i_tipo,'Z') <> 'O'--Consulta Normal Func Clientes
               begin
                  if  @i_modo = 0
                     --PRIMERA PARTE
                     begin
                        --print 'Promotor: %1!',@w_promotor
						
                        --INICIO FOR 2016-02-05 se agrega una bandera en la consulta que indica si se trata de un cliente menor de edad o mayor de edad
                        declare @w_anios_edad int, @w_menor_edad varchar(2)  -- Valores SI o NO
                        
                        select @w_anios_edad = datediff(yy, @w_fecha_nac, fp_fecha) from cobis..ba_fecha_proceso
                        select @w_mayoria_edad = isnull(pa_tinyint,18) from cl_parametro where pa_nemonico='VGAGE' and pa_producto = 'CLI'

                        if @w_anios_edad<@w_mayoria_edad  
                           select @w_menor_edad = 'SI'
                        else
                           select @w_menor_edad = 'NO'
                           
                        SELECT @w_num_ciclos=ea_nro_ciclo_oi FROM cobis..cl_ente_aux WHERE ea_ente=@i_persona

                        -- FIN FOR
   
                        select
                           @w_fechanac,                                           -- 1
                           @w_tipoced,                                            -- 2
                           @w_cedula,                                             -- 3
                           @w_fechaing,                                           -- 4
                           @w_fechaexp,                                           -- 5
                           @w_lugar_doc,                                          -- 6
                           @w_des_lugar_doc,                                      -- 7
                           @w_nombre,                                             -- 8
                           @w_p_apellido,                                         -- 9
                           @w_s_apellido,                                         -- 10
                           @w_ciudad_nac,                                         -- 11
                           @w_des_ciudad_nac,                                     -- 12
                           @w_sexo,                                               -- 13
                           @w_cod_sex,                                            -- 14
                           @w_estado_civil,                                       -- 15
                           @w_des_estado_civil,                                   -- 16
                           @w_profesion,                                          -- 17
                           @w_des_profesion,                                      -- 18
                           @w_actividad,                                          -- 19
                           @w_des_actividad,                                      -- 20
                           @w_pasaporte,                                          -- 21
                           @w_pais,                                               -- 22
                           @w_des_pais,                                           -- 23
                           @w_cod_sector,                                         -- 24
                           @w_des_sector,                                         -- 25
                           @w_nivel_estudio,                                      -- 26
                           @w_des_niv_est,                                        -- 27
                           @w_tipo,                                               -- 28
                           @w_des_tipo,                                           -- 29
                           @w_tipo_vivienda,                                      -- 30
                           isnull(@w_des_tipo_vivienda,''),                       -- 31
                           @w_num_cargas,                                         -- 32
                           @w_comentario,                                         -- 33
                           @w_referido,                                           -- 34
                           @w_num_hijos,                                          -- 35
                           @w_rep_superban,                                       -- 36
                           @w_doc_validado,                                       -- 37
                           @w_oficial,                                            -- 38
                           @w_des_oficial,                                        -- 39
                           @w_fechareg,                                           -- 40
                           @w_fechamod,                                           -- 41
                           @w_grupo,                                              -- 42
                           @w_des_grupo,                                          -- 43
                           @w_retencion,                                          -- 44
                           @w_mala_referencia,                                    -- 45
                           @w_tipo_vinculacion,                                   -- 46
                           @w_nit,                                                -- 47
                           @w_calif_cli,                                          -- 48
                           @w_des_calif_cliente,                                  -- 49
                           @w_des_tipo_vinculacion,                               -- 50
                           @w_nivel_ing,                                          -- 51
                           @w_oficina_origen,                                     -- 52
                           @w_des_oficina,                                        -- 53
                           @w_des_referido,                                       -- 54
                           @w_gran_contribuyente,                                 -- 55
                           @w_situacion_cliente,                                  -- 56
                           @w_des_situacion_cliente,                              -- 57
                           @w_patrim_tec,                                         -- 58
                           convert(char(10),@w_fecha_patrim_bruto,101),           -- 59
                           @w_total_activos,                                      -- 60
                           @w_oficial_sup,                                        -- 61
                           @w_des_oficial_sup,                                    -- 62
                           @w_preferen,                                           -- 63
                           @w_nivel_egr,                                          -- 64
                           @w_exc_sipla,                                          -- 65
                           @w_exc_por2,                                           -- 66
                           @w_digito,                                             -- 67
                           @w_cem,                                                -- 68
                           @w_segnombre,                                          -- 69
                           @w_c_apellido,                                         -- 70
                           @w_depart_doc,                                         -- 71
                           @w_des_dep_doc,                                        -- 72
                           @w_numord,                                             -- 73
                           @w_des_ciudad,                                         -- 74
                           @w_promotor,                                           -- 75
                           @w_des_promotor,                                       -- 76
                           @w_num_pais_nacionalidad,                              -- 77
                           @w_des_nacionalidad,                                   -- 78
                           @w_cod_otro_pais,                                      -- 79
                           @w_inss,                                               -- 80
						   @w_menor_edad,                                         -- 81
                           @w_conyuge,                                            -- 82
                           @w_persona_pub,			 	 						  -- 83
   			   			   @w_ing_SN,			 	 						      -- 84
   			   			   @w_otringr, 			 	 						      -- 85
   			   			   @w_depa_nac,			 	 						      -- 86
   			   			   @w_nac_aux, 			 	 						      -- 87
   			   			   @w_pais_emi, 			 	 					      -- 88
                           @w_carg_pub,                                           -- 89
                           @w_rel_carg_pub,                                       -- 90
                           @w_ea_cta_banco,                                       -- 91 
                           @w_num_ciclos                                           --92
					 end
                  else if @i_modo = 1
                     --SEGUNDA PARTE
                     begin
                        select
                           @w_licencia,                                           -- 1
                           @w_ingre,                                              -- 2
                           @w_des_ingresos,                                       -- 3
                           @w_principal_login,                                    -- 4
                           @w_suplente_login,                                     -- 5
                           @w_en_id_tutor,                                        -- 6
                           @w_en_nom_tutor,                                       -- 7
                           @w_bloquear,                                           -- 8
                           @w_relacion,                                           -- 9
                           @w_desc_tipo_ced,                                      -- 10
                           @w_tipo_medio,                                         -- 11
                           @w_desc_tipo_medio,                                    -- 12
                           @w_categoria,                                          -- 13
                           @w_desc_categoria,                                     -- 14
                           @w_es_cliente,                                         -- 15
                           @w_referido_ext,                                       -- 16
                           @w_des_referido_ext,                                   -- 17
                           @w_carg_pub,                                           -- 18
                           @w_rel_carg_pub,                                       -- 19
                           @w_situacion_laboral,                                  -- 20
                           @w_des_situacion_laboral,                              -- 21
                           @w_bienes,                                             -- 22
                           @w_otros_ingresos,                                     -- 23
                           @w_origen_ingresos,                                    -- 24
                           @o_ea_estado,                                          -- 25
                           @o_ea_observacion_aut,                                 -- 26
                           @o_ea_contrato_firmado,                                -- 27
                           @o_ea_menor_edad,                                      -- 28
                           @o_ea_conocido_como,                                   -- 29
                           @o_ea_cliente_planilla,                                -- 30
                           @o_ea_cod_risk,                                        -- 31
                           @o_ea_empadronado,                                     -- 32
                           @o_ea_sector_eco,                                      -- 33
                           @o_ea_actividad,                                       -- 34
                           @o_c_funcionario,                                      -- 35
                           @o_arma_categoria,                                     -- 36
                           isnull(@o_ea_act_comp_kyc, 'N'),                       -- 37
                           isnull(@o_ea_fecha_act_kyc, '01/01/1900'),             -- 38
                           isnull(@o_ea_no_req_kyc_comp, 'N'),                    -- 39
                           isnull(@o_ea_act_perfiltran, 'N'),                     -- 40
                           isnull(@o_ea_fecha_act_perfiltran, '01/01/1900'),      -- 41
                           isnull(@o_ea_con_salario, 'N'),                        -- 42
                           isnull(@o_ea_fecha_consal, '01/01/1900'),              -- 43
                           isnull(@o_ea_sin_salario, 'N'),                        -- 44
                           isnull(@o_ea_fecha_sinsal, '01/01/1900'),              -- 45
                           @o_ea_lin_neg,                                         -- 46
                           @o_ea_seg_neg,                                         -- 47
                           @o_ea_val_id_check,                                    -- 48
                           @o_ea_ejecutivo_con,                                   -- 49
                           @o_ea_suc_gestion,                                     -- 50
                           @o_ea_constitucion,                                    -- 51
                           @o_ea_emp_planilla,                                    -- 52
                           @o_ea_remp_legal,                                      -- 53
                           @o_ea_apoderado_legal,                                 -- 54
                           @o_ea_actualizacion_cic,                               -- 55
                           @o_ea_fecha_act_cic,                                   -- 56
                           @o_ea_excepcion_cic,                                   -- 57
                           @o_ea_fuente_ing,                                      -- 58
                           @o_ea_act_prin,                                        -- 59
                           @o_ea_detalle,                                         -- 60
                           isnull(@o_ea_act_dol, 0),                              -- 61
                           @o_ea_cat_aml,                                         -- 62
                           @o_ea_observacion_vincula,                             -- 63
                           @o_ea_fecha_vincula,                                   -- 64
                           isnull(@o_c_verificado, 'N'),                          -- 65
                           @o_actividad_princ,                                    -- 66
                           @o_fuente_ing,                                         -- 67
                           @o_fecha_veri,                                         -- 68
                           @o_act_cic,                                            -- 69
                           @o_excep_cic,                                          -- 70
                           @o_ea_excepcion_pad,                                   -- 71
                           @w_discapacidad,                                       -- 72
                           @w_tipo_discapacidad,                                  -- 73
                           @w_desc_discapacidad,                                  -- 74
                           @w_ced_discapacidad,                                   -- 75
                           @w_asfi,                                               -- 76
                           @w_egresos,                                            -- 77
                           @w_desc_egresos,                                       -- 78
                           @w_ifi,                                                -- 79
                           @w_ea_desc_aml,                                        -- 80
                           @w_nacio_tipo_ced,                                     -- 81
                           @w_path_foto,                                          -- 82
                           @w_nit_id ,                                            -- 83
                           @w_nit_venc,                                           -- 84
                           @w_calif_cli,                                          -- 85
                           @w_descalif_cli,                                       -- 86
						   @w_ea_estado_desc,                               -- 87
                           @w_emproblemado,                                 -- 88
                           @w_dinero_transac,                                 -- 89
                           @w_pep,                                               -- 90
                           @w_mnt_pasivo,                                     -- 91
                           @w_vinculacion,                                      -- 92
                           @w_ant_nego,                                       -- 93
                           @w_ventas,                                           -- 94
                           @w_ct_ventas,                                       -- 95
                           @w_ct_operativos,                                  -- 96
                           @w_total_activos,                                   -- 97
                           @w_ea_nro_ciclo_oi                                 -- 98   --LPO Santander               
                     end
                  /*
                  select
                     @w_fechanac,                                           -- 1
                     @w_tipoced,                                            -- 2
                     @w_cedula,                                             -- 3
                     @w_fechaing,                                           -- 4
                     @w_fechaexp,                                           -- 5
                     @w_lugar_doc,                                          -- 6
                     @w_des_lugar_doc,                                      -- 7
                     @w_nombre,                                             -- 8
                     @w_p_apellido,                                         -- 9
                     @w_s_apellido,                                         -- 10
                     @w_ciudad_nac,                                         -- 11
                     @w_des_ciudad_nac,                                     -- 12
                     @w_sexo,                                               -- 13
                     @w_cod_sex,                                            -- 14
                     @w_estado_civil,                                       -- 15
                     @w_des_estado_civil,                                   -- 16
                     @w_profesion,                                          -- 17
                     @w_des_profesion,                                      -- 18
                     @w_actividad,                                          -- 19
                     @w_des_actividad,                                      -- 20
                     @w_pasaporte,                                          -- 21
                     @w_pais,                                               -- 22
                     @w_des_pais,                                           -- 23
                     @w_cod_sector,                                         -- 24
                     @w_des_sector,                                         -- 25
                     @w_nivel_estudio,                                      -- 26
                     @w_des_niv_est,                                        -- 27
                     @w_tipo,                                               -- 28
                     @w_des_tipo,                                           -- 29
                     @w_tipo_vivienda,                                      -- 30
                     isnull(@w_des_tipo_vivienda,''),                       -- 31
                     @w_num_cargas,                                         -- 32
                     @w_comentario,                                         -- 33
                     @w_referido,                                           -- 34
                     @w_num_hijos,                                          -- 35
                     @w_rep_superban,                                       -- 36
                     @w_doc_validado,                                       -- 37
                     @w_oficial,                                            -- 38
                     @w_des_oficial,                                        -- 39
                     @w_fechareg,                                           -- 40
                     @w_fechamod,                                           -- 41
                     @w_grupo,                                              -- 42
                     @w_des_grupo,                                          -- 43
                     @w_retencion,                                          -- 44
                     @w_mala_referencia,                                    -- 45
                     @w_tipo_vinculacion,                                   -- 46
                     @w_nit,                                                -- 47
                     @w_calif_cli,                                          -- 48
                     @w_des_calif_cliente,                                  -- 49
                     @w_des_tipo_vinculacion,                               -- 50
                     @w_nivel_ing,                                          -- 51
                     @w_oficina_origen,                                     -- 52
                     @w_des_oficina,                                        -- 53
                     @w_des_referido,                                       -- 54
                     @w_gran_contribuyente,                                 -- 55
                     @w_situacion_cliente,                                  -- 56
                     @w_des_situacion_cliente,                              -- 57
                     @w_patrim_tec,                                         -- 58
                     convert(char(10),@w_fecha_patrim_bruto,101),           -- 59
                     @w_total_activos,                                      -- 60
                     @w_oficial_sup,                                        -- 61
                     @w_des_oficial_sup,                                    -- 62
                     @w_preferen,                                           -- 63
                     @w_nivel_egr,                                          -- 64
                     @w_exc_sipla,                                          -- 65
                     @w_exc_por2,                                           -- 66
                     @w_num_hijos,                                          -- 35
                     @w_rep_superban,                                       -- 36
                     @w_doc_validado,                                       -- 37
                     @w_oficial,                                            -- 38
                     @w_des_oficial,                                        -- 39
                     @w_fechareg,                                           -- 40
                     @w_fechamod,                                           -- 41
                     @w_grupo,                                              -- 42
                     @w_des_grupo,                                          -- 43
                     @w_retencion,                                          -- 44
                     @w_mala_referencia,                                    -- 45
                     @w_tipo_vinculacion,                                   -- 46
                     @w_nit,                                                -- 47
                     @w_calif_cli,                                          -- 48
                     @w_des_calif_cliente,                                  -- 49
                     @w_des_tipo_vinculacion,                               -- 50
                     @w_nivel_ing,                                          -- 51
                     @w_oficina_origen,                                     -- 52
                     @w_des_oficina,                                        -- 53
                     @w_des_referido,                                       -- 54
                     @w_gran_contribuyente,                                 -- 55
                     @w_situacion_cliente,                                  -- 56
                     @w_des_situacion_cliente,                              -- 57
                     @w_patrim_tec,                                         -- 58
                     convert(char(10),@w_fecha_patrim_bruto,101),           -- 59
                     @w_total_activos,                                      -- 60
                     @w_oficial_sup,                                        -- 61
                     @w_des_oficial_sup,                                    -- 62
                     @w_preferen,                                           -- 63
                     @w_nivel_egr,                                          -- 64
                     @w_exc_sipla,                                          -- 65
                     @w_exc_por2,                                           -- 66
                     @w_digito,                                             -- 67
                     @w_cem,                                                -- 68
                     @w_segnombre,                                          -- 69
                     @w_c_apellido,                                         -- 70
                     @w_depart_doc,                                         -- 71
                     @w_des_dep_doc,                                        -- 72
                     @w_numord,                                             -- 73
                     @w_des_ciudad,                                         -- 74
                     @w_promotor,                                           -- 75
                     @w_des_promotor,                                       -- 76
                     @w_num_pais_nacionalidad,                              -- 77
                     @w_des_nacionalidad,                                   -- 78
                     @w_cod_otro_pais,                                      -- 78
                     @w_inss,                                               -- 80
                     @w_licencia,                                           -- 81
                     @w_ingre,                                              -- 82
                     @w_des_ingresos,                                       -- 83
                     @w_principal_login,                                    -- 84
                     @w_suplente_login,                                     -- 85
                     @w_en_id_tutor,                                        -- 86
                     @w_en_nom_tutor,                                       -- 87
                     @w_bloquear,                                           -- 88
                     @w_relacion,                                           -- 89
                     @w_desc_tipo_ced,                                      -- 90
                     @w_tipo_medio,                                         -- 91
                     @w_desc_tipo_medio,                                    -- 92
                     @w_categoria,                                          -- 93
                     @w_desc_categoria,                                     -- 94
                     @w_es_cliente,                                         -- 95
                     @w_referido_ext,                                       -- 96
                     @w_des_referido_ext,                                   -- 97
                     @w_carg_pub,                                           -- 98
                     @w_rel_carg_pub,                                       -- 99
                     @w_situacion_laboral,                                  -- 100
                     @w_des_situacion_laboral,                              -- 101
                     @w_bienes,                                             -- 102
                     @w_otros_ingresos,                                     -- 103
                     @w_origen_ingresos,                                    -- 104
                     @o_ea_estado,                                          -- 105
                     @o_ea_observacion_aut,                                 -- 106
                     @o_ea_contrato_firmado,                                -- 107
                     @o_ea_menor_edad,                                      -- 108
                     @o_ea_conocido_como,                                   -- 109
                     @o_ea_cliente_planilla,                                -- 110
                     @o_ea_cod_risk,                                        -- 111
                     @o_ea_empadronado,                                     -- 112
                     @o_ea_sector_eco,                                      -- 113
                     @o_ea_actividad,                                       -- 114
                     @o_c_funcionario,                                      -- 115
                     @o_arma_categoria,                                     -- 116
                     isnull(@o_ea_act_comp_kyc, 'N'),                       -- 117
                     isnull(@o_ea_fecha_act_kyc, '01/01/1900'),             -- 118
                     isnull(@o_ea_no_req_kyc_comp, 'N'),                    -- 119
                     isnull(@o_ea_act_perfiltran, 'N'),                     -- 120
                     isnull(@o_ea_fecha_act_perfiltran, '01/01/1900'),      -- 121
                     isnull(@o_ea_con_salario, 'N'),                        -- 122
                     isnull(@o_ea_fecha_consal, '01/01/1900'),              -- 123
                     isnull(@o_ea_sin_salario, 'N'),                        -- 124
                     isnull(@o_ea_fecha_sinsal, '01/01/1900'),              -- 125
                     @o_ea_lin_neg,                                         -- 126
                     @o_ea_seg_neg,                                         -- 127
                     @o_ea_val_id_check,                                    -- 128
                     @o_ea_ejecutivo_con,                                   -- 129
                     @o_ea_suc_gestion,                                     -- 130
                     @o_ea_constitucion,                                    -- 131
                     @o_ea_emp_planilla,                                    -- 132
                     @o_ea_remp_legal,                                      -- 133
                     @o_ea_apoderado_legal,                                 -- 134
                     @o_ea_actualizacion_cic,                               -- 135
                     @o_ea_fecha_act_cic,                                   -- 136
                     @o_ea_excepcion_cic,                                   -- 137
                     @o_ea_fuente_ing,                                      -- 138
                     @o_ea_act_prin,                                        -- 139
                     @o_ea_detalle,                                         -- 140
                     isnull(@o_ea_act_dol, 0),                              -- 141
                     @o_ea_cat_aml,                                         -- 142
                     @o_ea_observacion_vincula,                             -- 143
                     @o_ea_fecha_vincula,                                   -- 144
                     isnull(@o_c_verificado, 'N'),                          -- 145
                     @o_actividad_princ,                                    -- 146
                     @o_fuente_ing,                                         -- 147
                     @o_fecha_veri,                                         -- 148
                     @o_act_cic,                                            -- 149
                     @o_excep_cic,                                          -- 150
                     @o_ea_excepcion_pad,                                   -- 151
                     @w_discapacidad,                                       -- 152
                     @w_tipo_discapacidad,                                  -- 153
                     @w_desc_discapacidad,                                  -- 154
                     @w_ced_discapacidad,                                   -- 155
                     @w_asfi,                                               -- 156
                     @w_egresos,                                            -- 157
                     @w_desc_egresos,                                       -- 158
                     @w_ifi,                                                -- 159
                     @w_ea_desc_aml,                                        -- 160
                     @w_nacio_tipo_ced,                                     -- 161
                     @w_path_foto,                                          -- 162
                     @w_nit_id ,                                            -- 163
                     @w_nit_venc,                                           -- 164
                     @w_calif_cli,                                          -- 165
                     @w_descalif_cli                                        -- 166
                  */
               end
            else if @i_tipo = 'O'--Consulta de un Cliente desde Otros Productos
               begin --NO ELIMINAR CABECERAS, YA QUE SON REQUERIDAS POR ATMADMIN
                  -- ESTA OPCION NO ES UTILIZADA POR FUNCIONALIDADES DE CLIENTES.
                  select
                     'Número Documento'                = @w_cedula,                                             -- 2
                     'Nombres'                         = @w_nombre,                                             -- 7
                     'Primer Apellido'                 = @w_p_apellido,                                         -- 8
                     'Segundo Apellido'                = @w_s_apellido,                                         -- 9
                     'Sexo'                            = @w_sexo,                                               -- 12
                     'Código Sexo'                     = @w_cod_sex,                                            -- 13
                     'Pasaporte'                       = @w_pasaporte,                                          -- 20
                     'Código País'                     = @w_pais,                                               -- 21
                     'País'                            = @w_des_pais,                                           -- 22
                     'Código Sector'                   = @w_cod_sector,                                         -- 23
                     'Sector Económico'                = @w_des_sector,                                         -- 24
                     'Tipo de Persona'                 = @w_tipo,                                               -- 27
                     'Desc. Tipo de Persona'           = @w_des_tipo,                                           -- 28
                     'Oficial de Cuenta'               = @w_oficial,                                            -- 37
                     'Nombre Oficial de Cta.'          = @w_des_oficial,                                        -- 38
                     'Cod. Grupo Económico'            = @w_grupo,                                              -- 41
                     'Grupo Económico'                 = @w_des_grupo,                                          -- 42
                     'Malas Referencias'               = @w_mala_referencia,                                    -- 44
                     'Número RUC'                      = @w_nit,                                                -- 46
                     'Categoria'                       = @w_categoria,                                          -- 92
                     'Desc. Categoria'                 = @w_desc_categoria,                                     -- 93
                     'Cliente Planilla'                = @o_ea_cliente_planilla,                                -- 109
                     'Arma Categoria'                  = @o_arma_categoria                                      -- 115
                  return 0
               end

            --VERIFICAR SI TIENE DIRECCION SCA QA
            select @w_direccion = count (*)
            from cl_direccion where di_ente = @i_persona

            select isnull(@w_direccion,0)
         end
      else
         begin
            exec sp_cerror
               @t_debug      = @t_debug,
               @t_file       = @t_file,
               @t_from       = @w_sp_name,
               @i_num        = 151051
               --NO CORRESPONDE CODIGO DE TRANSACCION
            return 1
         end
   end 

if @i_operacion='V'
   begin
      if @t_trn = 132
         begin
            if @i_tipo='N'
               begin
                  if exists (select en_ente
                           from cl_ente
                           where en_nit=@i_nit and en_subtipo='P')  and @i_nit is not null
                     begin
                        exec sp_cerror  @t_debug    = @t_debug,
                           @t_file     = @t_file,
                           @t_from     = @w_sp_name,
                           @i_num      = 101061
                        return 1
                     end
               end
         end
      else
         begin
            exec sp_cerror
               @t_debug      = @t_debug,
               @t_file       = @t_file,
               @t_from       = @w_sp_name,
               @i_num        = 151051
               --NO CORRESPONDE CODIGO DE TRANSACCION
            return 1
         end
   end

--HELP
if @i_operacion = 'H'
   --CONSULTA UNICAMENTE DEL NOMBRE COMPLETO DE UNA PERSONA
   begin
      if @t_trn = 133
         begin
            select  en_nomlar,
               en_tipo_ced,
               en_ced_ruc ,
               en_retencion,
               en_mala_referencia
            from    cl_ente
            where   en_ente = @i_persona
            and      en_subtipo = 'P'

            if @@rowcount = 0
               begin
                  exec sp_cerror  @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 101001
                  --NO EXISTE DATO SOLICITADO
                  return 1
               end
         end
      else
         begin
            exec sp_cerror
               @t_debug      = @t_debug,
               @t_file       = @t_file,
               @t_from       = @w_sp_name,
               @i_num        = 151051
               --NO CORRESPONDE CODIGO DE TRANSACCION
            return 1
         end
   end

if @i_operacion = 'Y'
   begin
      if @t_trn=133
         begin
		    select @o_retencion = (case a.en_retencion when 'N' then 'S' else 'N' end),
                   --@o_nit       = b.ea_nit,--JAN Inc63931
				   @o_nit       = case a.en_subtipo when 'C' then (case a.en_tipo_ced when 'NIT' then a.en_ced_ruc else null end) else b.ea_nit end,
                   @o_sub_tipo  = a.en_subtipo,
                   @o_pjuridica = a.c_segmento,
                   @o_ced_ruc   = a.en_ced_ruc 
            from cl_ente a
            inner join cl_ente_aux b on (a.en_ente = b.ea_ente)
            where a.en_ente    = @i_persona

            if @@rowcount = 0
               begin
                  exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 101001
                     --NO EXISTE DATO SOLICITADO
                  return 1
               end
         end
   end

return 0

GO
--sp_procxmode 'dbo.sp_persona_cons', 'Unchained'
go

