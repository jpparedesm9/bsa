/*************************************************************************/
/*   Archivo:            persona_upd.sp                                  */
/*   Stored procedure:   sp_persona_upd                                  */
/*   Base de datos:      cobis                                           */
/*   Producto:           Creación de Prospectos                          */
/*   Disenado por:       Milton Custode                                  */
/*   Fecha de escritura: 11/04/2017                                      */
/*************************************************************************/
/*                                  PROPOSITO                            */
/*   Este programa da mantenimiento a la tabla cl_ente y cl_enteaux      */
/*************************************************************************/
/*                               OPERACIONES                             */
/*   OPER. OPCION                     DESCRIPCION                        */
/*     I            Actualiza la información de un cliente               */
/*************************************************************************/
/*                                MODIFICACIONES                         */
/*   FECHA          AUTOR                RAZON                           */
/*  21-06-2017     Paúl Ortiz         Agregado Cuenta Individual         */
/*  28-06-2017     Paúl Ortiz         Agregado Banco Santander           */
/*  06-07-2017     Nelson Trujillo    Interfaz Buro Santander            */
/*  27-07-2017     Paúl Ortiz         Agregando validaciones CA          */
/*  02/08/2017     Ma. Jose Taco      opcion para actualizar desde       */
/*                                    la aplicacion movil                */
/*  10-08-2017     Paúl Ortiz         Correccion Servicio Mobile         */
/*  17-08-2017     Paúl Ortiz         Actualización a Clientes           */
/*  15-11-2017     Paúl Ortiz         Actualización vinculado            */
/*  16-10-2018     Esteban Báez       Validación nro documento           */
/*  23-11-2018     M. Taco            Validacion CURP y RFC              */
/*  14-08-2018     ACHP               Temp'Control para CURP'            */
/*  29-11-2019     A. Ortiz           Valida correo electronico          */
/*  07-12-2019     A. Ortiz           Actualiza el campo ingresos        */
/*  11/Feb/2019    S. Rojas           129027. Biométricos                */
/*  24/Dic/2020    AIN                Req.#150205                        */
/*  24/Dic/2020    S. Rojas           151529 Error Negative File         */
/*  28/Ene/2021    ACH                Req.#152815                        */
/*  23/Jul/2021    B. Guanochanga     Req #161141                        */
/*  13/Ago/2021    KVI                Req #162647                        */
/*  25/Oct/2021    ACH                ERR#169145-por pruebas del caso    */
/*  19/Nov/2021    ACH                ERR#169145-añade validac por#151529*/
/*  26/Ene/2022    KVI                Sop.#175052 - Eliminacion conyuge  */
/*  21/Oct/2022    KVI                Err.#191745 - Cambio cuenta        */
/*  23/Jun/2023    ACH                Por pruebas en 209990 nombre en null*/
/*  27/Jun/2023    ACH                #210163 Error en CURP-no debemos generar*/
/*************************************************************************/

use cobis
go

if exists (select 1 from sysobjects where name = 'sp_persona_upd')
   drop proc sp_persona_upd
go

IF OBJECT_ID ('dbo.sp_persona_upd') IS NOT NULL
	DROP PROCEDURE dbo.sp_persona_upd
GO

create proc sp_persona_upd(
      @s_ssn                          int           = null,
      @s_user                         login         = null,
      @s_term                         varchar(32)   = null,
      @s_date                         datetime      = null,
      @s_srv                          varchar(30)   = null,
      @s_lsrv                         varchar(30)   = null,
      @s_ofi                          smallint      = null,
      @s_rol                          smallint      = null,
      @s_org_err                      char(1)       = null,
      @s_error                        int           = null,
      @s_sev                          tinyint       = null,
      @s_msg                          descripcion   = null,
      @s_org                          char(1)       = null,
      @t_debug                        char(1)       = 'N',
      @t_file                         varchar(10)   = null,
      @t_from                         varchar(32)   = null,
      @t_trn                          smallint      = null,
      @i_verificado                   char(1)       = 'N',
      @i_operacion                    char(1),              -- Opcion con la que se ejecuta el programa
      @i_persona                      int           = null, -- Codigo del ente
      @i_nombre                       varchar(50)   = null, -- Primer nombre del ente
      @i_p_apellido                   varchar(30)   = null, -- Primer apellido del ente
      @i_s_apellido                   varchar(30)   = null, -- Segundo apellido del ente
      @i_sexo                         char(1)       = null, -- Codigo del sexo del ente
      @i_fecha_nac                    datetime      = null, -- Fecha de nacimiento del ente
      @i_tipo_ced                     char(4)       = null, -- Tipo de identificacion del ente 
      @i_cedula                       numero        = null, -- Numero de identificacion del ente
      @i_pasaporte                    varchar(20)   = null, -- Numero de pasaporte del ente
      @i_pais                         smallint      = null, -- Codigo del pais
      @i_ciudad_nac                   int           = null, -- Codigo del municipio o pais de nacimiento
      @i_lugar_doc                    int           = null, -- Codigo del municipio o pais de documento
      @i_nivel_estudio                catalogo      = null, -- Nivel de estudio de la persona
      @i_tipo_vivienda                catalogo      = null, -- Tipo de vivienda de la persona
      @i_calif_cliente                catalogo      = null, -- No se utiliza
      @i_profesion                    catalogo      = null, -- Codigo de la profesion de la persona
      @i_otro_prof                    varchar(30)   = null, -- Detalle de la profesion de la persona cuando es de Tipo OTRO
      @i_act_profesional              varchar(10)   = null, -- Actividad Profesional
      @i_usa_crypto                   varchar(1)    = null, -- Usa crypto
      @i_estado_civil                 catalogo      = null, -- Codigo  del estado civil de la persona
      @i_num_cargas                   tinyint       = null, -- Numero de hijos
      @i_nivel_ing                    money         = null, -- No se utiliza
      @i_nivel_egr                    money         = null, -- No se utiliza
      @i_filial                       tinyint       = null, -- Codigo de la filial
      @i_oficina                      smallint      = null, -- Codigo de la oficina
      @i_tipo                         catalogo      = null, -- Codigo de la SIB
      @i_grupo                        int           = null, -- Codigo del grupo
      @i_oficial                      smallint      = null, -- Codigo del oficial del ente
      @i_oficial_sup                  smallint      = null, -- Codigo del oficial suplente del ente
      @i_retencion                    char(1)       = null, -- Indicador si el ente es sujeto a impuestos
      @i_exc_sipla                    char(1)       = null, -- No se utiliza 
      @i_exc_por2                     char(1)       = null, -- No se utiliza
      @i_asosciada                    catalogo      = null, -- No se utiliza
      @i_tipo_vinculacion             catalogo      = null, -- Codigo del tipo de vinculacion de quien presento al cliente
      @i_actividad                    catalogo      = null, -- Codigo de la actividad del ente
      @i_comentario                   varchar(254)  = null, -- Comentario u observacion adicional del ente
      @i_fecha_emision                datetime      = null, -- No se utiliza
      @i_fecha_expira                 datetime      = null, -- Fecha de expiracion del pasaporte del ente
      @i_sector                       catalogo      = null, -- No se utiliza
      @i_referido                     smallint      = null, -- Codigo de la persona que presento al cliente
      @i_gran_contribuyente           char(1)       = null, -- No se utiliza
      @i_situacion_cliente            catalogo      = null, -- Situacion actual del cliente
      @i_patrim_tec                   money         = null, -- Patrimonio bruto
      @i_fecha_patrim_bruto           datetime      = null, -- Fecha del patrimonio bruto
      @i_total_activos                money         = null, -- Total de activos         
      @i_rep_superban                 char(1)       = null,  -- Indicador si es reportado por la SIB
      @i_preferen                     char(1)       = null,  -- Indicador si es cliente preferencial
      @i_cem                          money         = null,  -- Cupo de endeudamiento maximo
      @i_c_apellido                   varchar(30)   = null,  -- Apellido casada del ente
      @i_segnombre                    varchar(50)   = null,  -- Segundo nombre del ente
      @i_nit                          varchar(30)   = null,  -- NIT del ente
      @i_depart_doc                   smallint      = null,  -- Codigo del departamento
      @i_numord                       char(4)       = null,  -- Codigo de orden CV
      @i_promotor                     varchar(10)   = null,  -- Codigo del promotor del cliente
      @i_doc_validado                 char(1)       = null,    -- Indicador si la informacion del cliente esta verificada    
      @i_nacionalidad                 int           = null,  -- Codigo del pais de la nacionalidad del cliente 
      @i_codigo                       char(10)      = null,  -- Codigo pais centroamericano 
      @i_inss                         varchar(15)   = null,  -- Numero de seguro 
      @i_licencia                     varchar(30)   = null,  -- Numero de licencia 
      @i_ingre                        varchar(10)   = null,  -- Codigo de ingresos 
      @i_en_id_tutor                  varchar(20)   = null,  --ID del Tutor
      @i_en_nom_tutor                 varchar(60)   = null,  --Tutor
      @o_dif_oficial                  tinyint       = null out, -- Codigo del Oficial
      @i_digito                       char(2)       = null,
      @i_valprov                      char(1)       = null,
      @i_categoria                    catalogo      = null, --CVA Abr-23-07
      @i_referidor_ecu                int           = null, --Campo referidor CL00005 OPA                
      @i_carg_pub                     varchar(200)   = null,
      @i_rel_carg_pub                 varchar(10)   = null,
      @i_situacion_laboral            varchar(5)    = null,  -- ini CL00031 RVI
      @i_bienes                       char(1)       = null,
      @i_otros_ingresos               money         = null,
      @i_origen_ingresos              descripcion   = null,   -- fin CL00031 RVI                
      @i_ejecutar                     char(1)       = 'N',  --MALDAZ 06/25/2012 HSBC CLI-0565
      @i_ea_estado                    catalogo      = null,
      @i_ea_observacion_aut           varchar(255)  = null,
      @i_ea_contrato_firmado          char(1)       = null,
      @i_ea_menor_edad                char(1)       = null, 
      @i_ea_conocido_como             varchar(255)  = null,
      @i_ea_cliente_planilla          char(1)       = null,
      @i_ea_cod_risk                  varchar(20)   = null, 
      @i_ea_sector_eco                catalogo      = null,
      @i_ea_actividad                 catalogo      = null,
      @i_ea_empadronado               char(1)       = null,
      @i_ea_lin_neg                   catalogo      = null,
      @i_ea_seg_neg                   catalogo      = null,
      @i_ea_val_id_check              catalogo      = null,
      @i_ea_ejecutivo_con             int           = null,
      @i_ea_suc_gestion               smallint      = null,
      @i_ea_constitucion              smallint      = null,
      @i_ea_remp_legal                int           = null,
      @i_ea_apoderado_legal           int           = null,
      @i_ea_act_comp_kyc              char(1)       = null, 
      @i_ea_fecha_act_kyc             datetime      = null,
      @i_ea_no_req_kyc_comp           char(1)       = null,
      @i_ea_act_perfiltran            char(1)       = null, 
      @i_ea_fecha_act_perfiltran      datetime      = null,
      @i_ea_con_salario               char(1)       = null, 
      @i_ea_fecha_consal              datetime      = null,
      @i_ea_sin_salario               char(1)       = null,
      @i_ea_fecha_sinsal              datetime      = null, 
      @i_ea_actualizacion_cic         char(1)       = null, 
      @i_ea_fecha_act_cic             datetime      = null,
      @i_ea_fuente_ing                catalogo      = null, 
      @i_ea_act_prin                  catalogo      = null, 
      @i_ea_detalle                   varchar(255)  = null,
      @i_ea_act_dol                   money         = null, 
      @i_ea_cat_aml                   catalogo      = null,
      @i_fecha_verifi                 datetime      = null,
      @t_show_version                 bit           = 0,       --CSA06222012 - MOSTRAR LA VERSION DEL PROGRAMA 
      @i_ea_discapacidad              char(1)       = null,    --PRESENCIA DE DISCAPACIDAD
      @i_ea_tipo_discapacidad         catalogo      = null,    --TIPO DE DISCAPACIDAD
      @i_ea_ced_discapacidad          varchar(30)   = null,    --CEDULA DE DISCAPACIDAD
      @i_egresos                      catalogo      = null,
      @i_ifi                          char(1)       = null,
      @i_asfi                         char(1)       = null,
      @i_path_foto                    varchar(50)   = null,
      @i_nit_id                       numero        = null,
      @i_nit_venc                     datetime      = null,
      @i_emproblemado                 char(1)       = null,--santander
      @i_dinero_transac               money         = null,
      -- @i_manejo_doc                   varchar(25)   = null,  --@i_cedula
      @i_pep                          char(1)       = null,
      -- @i_mnt_activo                   money         = null, --@i_total_activos
      @i_mnt_pasivo                   money         = null,
      @i_vinculacion                  char(1)       = null,
      @i_ant_nego                     int           = null,
      @i_ventas                       money         = null,
      --@i_ot_ingresos    money = null,   @i_otros_ingresos  
      @i_ct_ventas                    money         = null,
      @i_ct_operativos                money         = null,
      @i_ea_indefinido                char(1)       = null,  --MTA nuevo campo no mapeado
      @i_persona_pub                  varchar(1)    = null,  --Función que desempeña o ha desempeñado
      @i_ing_SN                       char(1)       = null,  --Tiene otros Ingresos?
      @i_otringr                      varchar(10)   = null,   --Otras fuentes de Ingresos
      @i_depa_nac                     smallint      = null,    --Provincia de nacimiento
      @i_nac_aux                      int           = null,    --Nacionalidad que se muestra en front-end
      @i_pais_emi                     smallint      = null ,    --Pais de nacimiento 
      @i_ea_nro_ciclo_oi              int           = null,
      @i_ea_cta_banco                 varchar(45)   = null,
      @i_banco        varchar(20)   = null,
      @i_estado_std                   varchar(10)   = null,
      @i_calificacion                 varchar(10)   = null,
      @i_calificacion_ind             varchar(10)   = null,
      @i_partner                      char(1)       = null,
      @i_lista_negra                  char(1)       = null,
      @i_telefono_recados             varchar(10)   = null,
      @i_numero_ife                   varchar(13)   = null,
      @i_numero_serie_firma           varchar(20)   = null,
      @i_persona_recados              varchar(60)   = null,
      @i_antecedentes_buro            varchar(2)    = null, 
      @i_colectivo                    varchar(64)   = null,
      @i_nivel_colectivo              varchar(64)   = null,	  
      @i_email		                  varchar(254)  = null,	
      @o_estado                       catalogo      = null output,
      @o_vinculado                    catalogo      = null output,
      @i_ing_negocio                  money         = null,
      @i_bio_tipo_identificacion      varchar(10)   = null,
      @i_bio_cic                      varchar(9)    = null,
      @i_bio_ocr                      varchar(13)   = null,
      @i_bio_numero_emision           varchar(2)    = null,
      @i_bio_clave_lector             varchar(18)   = null,
      @i_bio_huella_dactilar          char(1)       = null,
      @i_respuesta_renapo             char(1)       = null,
      @i_modo                         int           = NULL,
      @i_register_year                varchar(5)    = null,
      @i_emission_year                varchar(5)    = null,
      @o_curp                         numero        = null output,
      @o_rfc                          numero        = null output,
      @o_lista_negra                  char(1)       = null output
)
as
declare @w_today                 datetime,
@w_sp_name                  varchar(32),
@w_referidor_ecu            int, --08/06/2010 Miguel Mendieta Sincronizacion Branch Bolivariano
@w_return                   int,
@w_dias_anio_nac            smallint,
@w_dias_anio_act            smallint,
@w_inic_anio_nac            datetime,
@w_inic_anio_act            datetime,
@w_anio_nac                 char(4),
@w_anio_act                 char(4),
@w_siguiente                int,
@w_codigo                   int,
@w_nombre                   varchar(50),
@w_p_apellido               varchar(30),
@w_s_apellido               varchar(30),
@w_s_apellido_t             varchar(30),
@w_nombre_completo          varchar(254), --* Se cambia la logitud del campo
@w_sexo                     char(1),
@w_paso                     char(1),
@w_tipo_ced                 char(4),
@w_cedula                   numero,
@w_pasaporte                varchar(20),
@w_pais                     smallint,
@w_profesion                catalogo,
@w_otro_profesion           varchar(30),
@w_estado_civil             catalogo,
@w_num_cargas               tinyint,   
@w_nivel_ing                money,
@w_nivel_egr                money,
@w_filial                   int,
@w_oficina                  smallint,
@v_oficina                  smallint,
@w_tipo                     catalogo,
@w_grupo                    int,
@w_fecha_nac                datetime,
@w_es_mayor_edad            char(1),     /* 'S' o 'N' */
@w_mayoria_edad             smallint,   /* expresada en a$os */
@w_oficial                  smallint,
@w_oficial_sup              smallint,
@w_retencion                char(1),
@w_exc_sipla                char(1),
@w_exc_por2                 char(1),
@w_asosciada                catalogo,
@w_tipo_vinculacion         catalogo,
@w_vinculacion              char(1),    
@w_mala_referencia          char(1),
@w_actividad                catalogo,
@w_comentario               varchar(254),
@w_fecha_emision            datetime,   
@w_fecha_expira             datetime,   
@w_nivel_estudio            catalogo,   
@w_doc_validado             char(1),   
@w_tipo_vivienda            catalogo,   
@w_calif_cliente            catalogo,   
@w_total_activos            money,
@w_rep_superban             char(1),
@w_preferen                 char(1),   
@w_cem           money,
@w_nit_id                   numero,
@w_nit_venc                 datetime,     
@v_cem                      money,
@v_preferen                 char(1),   
@v_total_activos            money,
@v_tipo_vivienda            catalogo,   
@v_calif_cliente            catalogo,   
@v_nivel_estudio            catalogo,   
@v_doc_validado             char(1),   
@v_nombre                   varchar(50),   
@v_p_apellido               varchar(30),
@v_s_apellido               varchar(30),
@v_sexo                     char(1),
@v_tipo_ced                 char(4),
@v_cedula                   numero,
@v_pasaporte                varchar(20),
@v_pais                     smallint,
@v_profesion                catalogo,
@v_otro_profesion           varchar(20),
@v_estado_civil             catalogo,
@v_num_cargas               tinyint,   
@v_nivel_ing                money,
@v_nivel_egr                money,
@v_tipo                     catalogo,
@v_fecha_nac                datetime,
@v_grupo                    int,
@v_oficial                  smallint,
@v_oficial_ant              smallint,
@v_oficial_sup              smallint,
@v_oficial_sup_ant          smallint,
@v_retencion                char(1),
@v_exc_sipla                char(1),
@v_exc_por2                 char(1),
@v_asosciada                catalogo,
@v_tipo_vinculacion         catalogo,
@v_vinculacion              char(1),
@v_actividad                catalogo,
@v_comentario               varchar(254),
@v_fecha_emision            datetime,   
@v_fecha_expira             datetime,   
@v_rep_superban             char(1),
@w_catalogo                 catalogo,
@w_sector                   catalogo,   
@w_nit                      numero,   
@w_referido                 smallint,
@v_referido                 smallint,
@v_nit                      numero,   
@v_sector                   catalogo,
@w_ciudad_nac               int,    
@v_ciudad_nac               int,    
@w_lugar_doc                int,    
@v_lugar_doc                int,    
@w_gran_contribuyente       char(1) ,
@w_situacion_cliente        catalogo,
@v_situacion_cliente        catalogo,
@w_patrim_tec               money,
@w_fecha_patrim_bruto       datetime ,
@w_nomlar                   varchar(254), --* Se cambia longitud del campo
@w_c_apellido               varchar(30),  -- Campo apellido casada
@w_s_nombre                 varchar(50),  -- Campo segundo nombre
@w_s_nombre_t               varchar(50),
@w_depart_doc               smallint,  -- Codigo del departamento
@w_numord                   char(4),  -- Codigo de orden CV
@w_promotor                 varchar(10),
@w_num_pais_nacionalidad    int,    -- Codigo del pais de la nacionalidad del cliente
@w_cod_otro_pais            char(10), -- Codigo de pais centroamericano
@w_inss                     varchar(15), -- Numero de seguro
@w_licencia                 varchar(30), -- Numero de licencia
@w_ingre                    varchar(10), -- Codigo de Ingresos 
@w_en_id_tutor              varchar(20),  --ID del Tutor
@w_en_nom_tutor             varchar(60),   --Tutor
@v_c_apellido               varchar(30),  -- Campo apellido casada
@v_s_nombre                 varchar(50),  -- Campo segundo nombre
@v_depart_doc               smallint,  -- Codigo del departamento
@v_numord                   char(4),  -- Codigo de orden CV
@v_promotor                 varchar(10),
@v_nomlar                   varchar(64),
@v_num_pais_nacionalidad    int,
@v_cod_otro_pais            char(10),
@v_inss                     varchar(15), -- Numero de seguro 
@v_licencia                 varchar(30),  -- Numero de licencia
@v_ingre                    varchar(10), -- Codigo de Ingresos
@v_en_id_tutor              varchar(20),  --ID del Tutor
@v_en_nom_tutor             varchar(60),   --Tutor
@w_digito                   char(2),
@v_digito                   char(2),
@w_nemocda                  char(3),
@w_nemovda                  char(3),
@w_nemomed     char(3),
@v_categoria                catalogo, --CVA Abr-23-07
@w_categoria                catalogo,  --CVA Abr-23-07
@w_carg_pub                 varchar(10),         
@w_rel_carg_pub             varchar(10),
@w_situacion_laboral        varchar(5),  -- ini CL00031 RVI
@w_bienes                   char(1),
@w_otros_ingresos           money,
@w_origen_ingresos          descripcion,  
@v_situacion_laboral        varchar(5),  
@v_bienes                   char(1),
@v_otros_ingresos           money,
@v_origen_ingresos          descripcion,   -- fin CL00031 RVI     
@w_vu_pais                  catalogo,
@w_vu_banco                 catalogo,
@w_td_digito                char(2),        -- CLI0517 - Determina si el tipo de documento es mandatorio o no.
@w_ea_estado                catalogo,
@w_ea_observacion_aut       varchar(255 ),
@w_ea_contrato_firmado      char(1),
@w_ea_menor_edad            char(1), 
@w_ea_conocido_como         varchar(255 ),
@w_ea_cliente_planilla      char(1),
@w_ea_cod_risk              varchar(20), 
@w_ea_sector_eco            catalogo,
@w_ea_actividad             catalogo,
@w_ea_empadronado           char(1),
@w_ea_lin_neg               catalogo,
@w_ea_seg_neg               catalogo,
@w_ea_val_id_check          catalogo,
@w_ea_ejecutivo_con         int,
@w_ea_suc_gestion           smallint,
@w_ea_constitucion          smallint,
@w_ea_remp_legal            int,
@w_ea_apoderado_legal       int,
@w_ea_act_comp_kyc          char(1), 
@w_ea_fecha_act_kyc         datetime,
@w_ea_no_req_kyc_comp       char(1),
@w_ea_act_perfiltran        char(1), 
@w_ea_fecha_act_perfiltran  datetime,
@w_ea_con_salario           char(1), 
@w_ea_fecha_consal          datetime,
@w_ea_sin_salario           char(1),
@w_ea_fecha_sinsal          datetime, 
@w_ea_actualizacion_cic     char(1), 
@w_ea_fecha_act_cic         datetime,
@w_ea_fuente_ing            catalogo, 
@w_ea_act_prin              catalogo, 
@w_ea_detalle               varchar(255),
@w_ea_act_dol               money, 
@w_ea_cat_aml               catalogo,
@w_ea_observacion_vincula   varchar(255),
@w_ea_fecha_vincula         datetime,
@v_ea_estado                catalogo,
@v_ea_observacion_aut       varchar(255 ),
@v_ea_contrato_firmado      char(1),
@v_ea_menor_edad            char(1), 
@v_ea_conocido_como         varchar(255 ),
@v_ea_cliente_planilla      char(1),
@v_ea_cod_risk              varchar(20), 
@v_ea_sector_eco            catalogo,
@v_ea_actividad             catalogo,
@v_ea_empadronado           char(1),
@v_ea_lin_neg               catalogo,
@v_ea_seg_neg               catalogo,
@v_ea_val_id_check          catalogo,
@v_ea_ejecutivo_con         int,
@v_ea_suc_gestion           smallint,
@v_ea_constitucion          smallint,
@v_ea_remp_legal            int,
@v_ea_apoderado_legal       int,
@v_ea_act_comp_kyc          char(1), 
@v_ea_fecha_act_kyc         datetime,
@v_ea_no_req_kyc_comp       char(1),
@v_ea_act_perfiltran        char(1), 
@v_ea_fecha_act_perfiltran  datetime,
@v_ea_con_salario           char(1), 
@v_ea_fecha_consal          datetime,
@v_ea_sin_salario           char(1),
@v_ea_fecha_sinsal          datetime, 
@v_ea_actualizacion_cic     char(1), 
@v_ea_fecha_act_cic         datetime,
@v_ea_fuente_ing            catalogo, 
@v_ea_act_prin              catalogo, 
@v_ea_detalle               varchar(255),
@v_ea_act_dol               money, 
@v_ea_cat_aml               catalogo,
@v_ea_observacion_vincula   varchar(255),
@v_ea_fecha_vincula         datetime,
@w_estado_ente              char(1),
@w_doble_aut                char(1), --Miguel Aldaz  06/22/2012 Doble autorizacion CLI-0565 HSBC
@w_autorizacion             int,     --Miguel Aldaz  06/22/2012 Doble autorizacion CLI-0565 HSBC
@w_estado_campo             char(1), --Miguel Aldaz  06/24/2012 Doble autorizacion CLI-0565 HSBC
@w_nomb_user                varchar(64),
@w_ea_ced_ruc               varchar(30),
@v_ea_discapacidad          char(1),    
@v_ea_tipo_discapacidad     catalogo,   
@v_ea_ced_discapacidad      varchar(30),     
@w_ea_discapacidad          char(1),    
@w_ea_tipo_discapacidad     catalogo,   
@w_ea_ced_discapacidad      varchar(30),
@w_asfi                     char(1),
@v_asfi                     char(1),
@w_egresos                  catalogo,
@v_egresos                  catalogo,
@w_ifi                      char(1),      
@v_ifi                      char(1),
@w_path_foto                varchar(50),
@v_path_foto                varchar(50),
@v_nit_id                   numero,
@v_nit_venc                 datetime,
@w_nat_jur_hogar            catalogo,
@w_tipo_compania            catalogo,
@w_estados                  varchar(15),--inc 69991
@w_ea_indefinido            char(1),
@v_ea_indefinido            char(1),
@v_banco                    varchar(20),
@w_banco                    varchar(20),
@w_estado_std               varchar(10),
@w_calificacion             varchar(10),
@w_relacion_ca              int = 209,
@w_partner                  char(1),
@w_lista_negra              char(1),
@w_in_ente_d                int,
@w_tamanio                  int,
@w_curp_tam                 int,
@w_telefono_recados         varchar(10),
@w_numero_ife               varchar(13),
@w_numero_serie_firma_elect varchar(20),
@w_persona_recados          varchar(60),
@w_antecedentes_buro        varchar(2) ,
@w_act_profesional          varchar(10) ,
@w_usa_crypto               varchar(1) ,
@v_telefono_recados         varchar(10),
@v_numero_ife               varchar(13),
@v_numero_serie_firma_elect varchar(20),
@v_persona_recados          varchar(60),
@v_antecedentes_buro        varchar(2),
@v_act_profesional          varchar(10),
@v_usa_crypto               varchar(1),
@w_login_oficia             login,
@w_rol                      smallint,
@w_depa_nac                 smallint,
@v_depa_nac                 smallint,
@v_filial                   tinyint,
@w_segnombre                varchar(50),
@v_segnombre                varchar(50),
@w_dir_mail					int,
@w_iemail					int,
@w_secuencial               int,
@w_error                    int,
@w_p_fecha_expira           datetime,
@w_param_renapo             varchar(30), 
@w_nombres                  varchar(255),
@w_nom_user                 VARCHAR(255),
@w_fecha                    datetime,
@w_fecha_hoy                DATETIME,
@w_msg                      VARCHAR(255),
@w_param_modifica			int,
@w_rfc_c					numero,
@w_curp_c					numero,
@w_nom_aux					varchar(64),
@w_ente_err                 int,
@w_cta_banco                varchar(45),
@w_resultado_nf             int,
@w_consulto_renapo          char(2),
@w_ea_colectivo             catalogo,
@v_ea_colectivo             catalogo,
@w_ea_nivel_colectivo       catalogo,
@v_ea_nivel_colectivo       catalogo,
@w_exist_tram               char(1)= 0,
@w_resultado_ln             int,--caso#169145
@w_est_civil                catalogo --Soporte#175052
 
select @w_sp_name = 'sp_persona_upd'
/*--VERSIONAMIENTO--*/
if @t_show_version = 1
   begin
      print 'Stored procedure ' + @w_sp_name + ' Version 4.0.0.35'
      return 0
   end
/*--FIN DE VERSIONAMIENTO--*/

select @i_otro_prof = isnull(@i_otro_prof,'')

select @w_vu_pais = pa_char
  from cobis..cl_parametro
 where pa_producto = 'ADM'
   and pa_nemonico = 'ABPAIS'

select @w_vu_banco = pa_char
  from cobis..cl_parametro
 where pa_producto = 'ADM'
   and pa_nemonico = 'CLIENT'

select @w_today =  @s_date   

select @w_sp_name = 'sp_persona_upd'
select @w_estado_campo = 'P'

select @w_mayoria_edad = pa_tinyint /* mayoria de edad */
  from cobis..cl_parametro
 where pa_nemonico = 'MDE'

select @w_param_renapo = pa_char
from cl_parametro
where pa_nemonico = 'RENAPO'

select @w_param_modifica = pa_int
from cl_parametro
where pa_nemonico = 'RMCRF'

select @w_param_renapo = isnull(@w_param_renapo, 'N')

--Por el caso #152815 Inicio, si ya consulto a renapo los datos no se actulizan
select @w_consulto_renapo = ea_consulto_renapo
  from cobis..cl_ente_aux 
 where ea_ente = @i_persona

if (@i_respuesta_renapo = 'S' and @w_consulto_renapo <> 'S')
begin
    
    select @i_fecha_nac  = isnull(@i_fecha_nac, p_fecha_nac),
           @i_depa_nac   = isnull(@i_depa_nac, p_depa_nac),
           @i_sexo       = isnull(@i_sexo, p_sexo), 
           @i_nombre     = isnull(@i_nombre, en_nombre),
           --@i_segnombre  = isnull(@i_segnombre, p_s_nombre),
           @i_segnombre  = @i_segnombre,
           @i_p_apellido = isnull(@i_p_apellido, p_p_apellido), 
           --@i_s_apellido = isnull(@i_s_apellido, p_s_apellido)
           @i_s_apellido = @i_s_apellido
    from cobis..cl_ente
    where en_ente = @i_persona
    and en_subtipo = 'P'
	
    select @w_nombres = @i_nombre + ' ' + isnull(@i_segnombre,'')
    exec @w_return = cobis..sp_generar_curp
    @i_primer_apellido       = @i_p_apellido,
    @i_segundo_apellido      = @i_s_apellido,
    @i_nombres               = @w_nombres,
    @i_sexo                  = @i_sexo,
    @i_fecha_nacimiento      = @i_fecha_nac,
    @i_entidad_nacimiento    = @i_depa_nac,
    @i_ente                  = @i_persona,
    @o_mensaje               = @w_msg  out,
    @o_rfc                   = @o_rfc  out
    
    if @w_return <> 0 begin
	  if not exists ( select 1 from cobis..cl_ente where en_ente = @i_persona and en_rfc = @o_rfc) begin
		 exec sp_cerror
    				@t_debug = @t_debug,
    				@t_file  = @t_file,
    				@t_from  = @w_sp_name,
    				@i_num   = @w_return
    	 return @w_return
		 end
    end

    --SELECCIONAR EL RFC ANTERIOR
    select @w_nit    = a.en_rfc
      from cl_ente a,cl_ente_aux b
     where a.en_ente = b.ea_ente
       and a.en_ente = @i_persona
       and a.en_subtipo = 'P'

    if @@rowcount = 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101043
        --NO EXISTE PERSONA
      return 1
    end

    print 'Se genero el rfc ' + convert(varchar(30), @o_rfc) + ' el cliente: ' + convert(varchar(30), @i_persona)
	select @i_nit = @o_rfc, 
	       @i_nit_id = @o_rfc
		   
	 /*Control para RFC*/
    if(@w_nit <> @i_nit)
	begin
	    insert into cl_modificacion_curp_rfc (mcr_ente,     mcr_ssn_user,  mcr_ssn_oficina,
		                                        mcr_fecha,    mcr_oficial ,  mcr_oficina    ,
												mcr_curp_ant, mcr_rfc_ant ,  mcr_curp       ,
												mcr_rfc,      mcr_operacion, mcr_sp)
                                        values (@i_persona,   @s_user     ,  @s_ofi         ,
										        getdate(),    @w_oficial  ,  @w_oficina     ,
												null,         @w_nit      ,  null,
												@i_nit,       @i_operacion,  @w_sp_name)		 
	   
        select @v_nit    = @w_nit

        insert into ts_persona_prin (secuencia, tipo_transaccion, clase,          fecha,      usuario, 
                                    terminal,  srv,              lsrv,           persona,    cedula,
                                    fecha_mod, nit,              secuen_alterno, hora)       
                            values (@s_ssn,    @t_trn,           'P',            @s_date,    @s_user, 
                                    @s_term,   @s_srv,           @s_lsrv,        @i_persona, null,
                                    getdate(), @v_nit,           1,              getdate())
        if @@error <> 0
           begin
              exec sp_cerror
                 @t_debug    = @t_debug,
                 @t_file     = @t_file,
                 @t_from     = @w_sp_name,
                 @i_num      = 103005
              --ERROR EN CREACION DE TRANSACCION DE SERVICIO
              return 1
           end
        
        --TRANSACCION DE SERVICIO - DATOS ACTUALES AL CAMBIO
        insert into ts_persona_prin (secuencia, tipo_transaccion, clase,          fecha,      usuario, 
                                    terminal,  srv,              lsrv,           persona,    cedula,
                                    fecha_mod, nit,              secuen_alterno, hora)       
                            values (@s_ssn,    @t_trn,           'A',            @s_date,    @s_user, 
                                    @s_term,   @s_srv,           @s_lsrv,        @i_persona, null,
                                    getdate(), @i_nit,           1,              getdate())
        if @@error <> 0
        begin
           exec sp_cerror
              @t_debug    = @t_debug,
              @t_file     = @t_file,
              @t_from     = @w_sp_name,
              @i_num      = 103005
           --ERROR EN CREACION DE TRANSACCION DE SERVICIO
           return 1
        end
	 
        update cl_ente
        set en_nit     = isnull(@i_nit, en_nit),
	        en_rfc     = isnull(@i_nit, en_rfc)
        where en_ente = @i_persona
        and en_subtipo = 'P'
	    
        if @@error <> 0
        begin
        
           exec sp_cerror  @t_debug    = @t_debug,
                 @t_file     = @t_file,
                 @t_from     = @w_sp_name,
                 @i_num      = 105026
           /* 'Error en actualizacion de persona'*/
           return 1
        end  
		
        update cl_ente_aux
        set ea_nit     = isnull(@i_nit_id, ea_nit)	       
        where ea_ente = @i_persona
        
        if @@error <> 0
        begin
           exec sp_cerror  
               @t_debug    = @t_debug,
                 @t_file     = @t_file,
                 @t_from     = @w_sp_name,
                 @i_num      = 105026
           /* 'Error en actualizacion de persona'*/
           return 1
        end
    end
end

if ( @w_consulto_renapo = 'S' and @w_param_renapo = 'S' and @i_operacion <> 'R')
begin
    print 'Se toma los datos anteriores para el cliente: ' + convert(varchar(30), @i_persona)
    select @i_fecha_nac  = p_fecha_nac,
           @i_depa_nac   = p_depa_nac,
           @i_sexo       = p_sexo,
           @i_nombre     = en_nombre,
           @i_segnombre  = p_s_nombre,
           @i_p_apellido = p_p_apellido,
           @i_s_apellido = p_s_apellido,
		   @i_nit        = en_rfc,
		   @i_cedula     = en_ced_ruc
    from cobis..cl_ente
    where en_ente = @i_persona
end
--Por el caso #152815 Fin, si ya consulto a renapo los datos no se actulizan

 --en sql cts convierte en null las cadenas vacías, por esta razón se envía un * que se debe reemplazar por cadena vacía
if @i_s_apellido = '*'
begin
	update cl_ente set p_s_apellido=null where en_ente=@i_persona
	set @i_s_apellido=null
end
if @i_segnombre = '*'
begin
	update cl_ente set p_s_nombre=null where en_ente=@i_persona
	set @i_segnombre=null
end
	
--update de campos del ente
if @i_operacion = 'R' -- actualiza solamente información que se envia desde la pantalla de actualizacion de curp y rfc
begin
if @t_trn = 104
  begin

   if ((ltrim(rtrim(@i_banco))) = '' and (ltrim(rtrim(@i_ea_cta_banco))) = '' or
       @i_banco is null and @i_ea_cta_banco is null)
   begin
        select @w_curp_c = en_ced_ruc,
               @w_rfc_c = en_rfc
        from   cobis..cl_ente 
        where  en_ente = @i_persona
		
        if ((ltrim(rtrim(@w_curp_c))) = '' and (ltrim(rtrim(@w_rfc_c))) = '' or 
            @w_curp_c is null and @w_rfc_c is null)
		begin
            select @i_banco = @w_curp_c,
			       @i_ea_cta_banco = @w_rfc_c
		end
   end
   else 
   begin
       --resultado 1 = true, 0 = false
       if ( isnumeric(@i_banco) = 0 or isnumeric(@i_ea_cta_banco) = 0 )
       begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 109008,
            @i_msg   = @w_msg
            --Ingresar solo números para la Cuenta y el Código Santander
          return 109007
       end
   end
  --EBA inicio validacion NRO DOCUMENTO
    if exists (select 1 from cobis..cl_ente where en_ente <> @i_persona and en_ced_ruc = @i_cedula  )
    OR exists (select 1 from cobis..cl_ente where en_ente <> @i_persona and en_rfc = @i_nit) --MTA
    begin
    
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 103190
        --NRO DE DOCUMENTO YA EXISTE
      return 103190
    end
    --EBA FIN validacion NRO DOCUMENTO
	
   --AIN incio validacion de codigo santader
   if exists (select 1 from cobis..cl_ente where en_ente <> @i_persona and en_banco = @i_banco)
   begin
      select @w_ente_err = en_ente from cl_ente where en_ente <> @i_persona and en_banco = @i_banco 
      select @w_msg = 'El Código Santander ya se encuentra registrado para el cliente ' + convert(varchar(255),@w_ente_err)
      
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 109006,
        @i_msg   = @w_msg
        --NRO DE BUC YA ESTA REGISTRADO
      return 109006
   end
   --AIN fin validacion de codigo santader
   
   --AIN incio validacion de cuenta individual
   if exists (select 1 from cobis..cl_ente_aux where ea_ente <> @i_persona and ea_cta_banco = @i_ea_cta_banco)
   begin
      select @w_ente_err = ea_ente from cobis..cl_ente_aux where ea_ente <> @i_persona and ea_cta_banco = @i_ea_cta_banco 
      select @w_msg = 'La cuenta ya se encuentra registrado para el cliente ' + convert(varchar(255),@w_ente_err)
      
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 109007,
        @i_msg   = @w_msg
        --NRO DE CUENTA YA ESTA REGISTRADA
      return 109007
   end
   --AIN fin validacion de de cuenta individual

  --SMO  Inicio  Validacion de CURP
    select @w_curp_tam = pa_int
      from cobis..cl_parametro 
     where pa_nemonico = 'LCURP' 
       and pa_producto = 'CLI'

    select @w_tamanio = len(@i_cedula)--NIT(en_rfc) o CURP(@i_cedula)

    if @w_tamanio <> @w_curp_tam
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 103189 --Error longitud diferente de 18
    end
	
	--SMO  Fin  Validacion de CURP
	
    --SELECCIONAR LOS DATOS ANTERIORES DE LA PERSONA
    select @w_cedula = a.en_ced_ruc,
           @w_nit    = a.en_nit,
		   @w_oficial = a.en_oficial,
		   @w_oficina = a.en_oficina,
		   @w_banco   = a.en_banco,
		   @w_cta_banco = b.ea_cta_banco
      from cl_ente a,cl_ente_aux b
     where a.en_ente = b.ea_ente
       and a.en_ente = @i_persona
       and a.en_subtipo = 'P'
		
    if @@rowcount = 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101043
        --NO EXISTE PERSONA
      return 1
    end
    --SMO  Inicio Transaccion de servicios
	
	--PRO VALIDA LOS CAMBIOS EN EL CURP Y RFC
	exec @w_return  = sp_valida_curp_rfc
		@i_curp		= 	@i_cedula,
		@i_rfc		=	@i_nit,
		@i_ente		=	@i_persona
	
	if @w_return <> 0
    begin
		return 1
	end

	 /*Control para CURP*/
	 if((@w_cedula <> @i_cedula) or (@w_nit <> @i_nit))
	 begin		 
	     insert into cl_modificacion_curp_rfc (mcr_ente,     mcr_ssn_user,  mcr_ssn_oficina,
		                                        mcr_fecha,    mcr_oficial ,  mcr_oficina    ,
												mcr_curp_ant, mcr_rfc_ant ,  mcr_curp       ,
												mcr_rfc,      mcr_operacion, mcr_sp)
                                        values (@i_persona,   @s_user     ,  @s_ofi         ,
										        getdate(),    @w_oficial  ,  @w_oficina     ,
												@w_cedula,    @w_nit      ,  @i_cedula,
												@i_nit,       @i_operacion,  @w_sp_name)

	     if(len(@i_cedula) < 18)
		 select @i_cedula = @w_cedula		 
	 end  
	 /*Fin Control para CURP*/	
	 
    select @v_cedula = @w_cedula,
           @v_nit    = @w_nit

    if @w_cedula = @i_cedula        
       select @w_cedula = null, @v_cedula = null
    else                
       select @w_cedula = @i_cedula

    if @w_nit = @i_nit        
       select @w_nit = null, @v_nit = null
    else                
       select @w_nit = @i_nit
	    if @w_banco = @i_banco       
       select @w_banco = null
    else                
       select @w_banco = @i_banco
       
    if @w_cta_banco = @i_ea_cta_banco       
       select @w_cta_banco = null
    else                
       select @w_cta_banco = @i_ea_cta_banco							 

	if @w_nit is null and @w_cedula is null and @w_banco is null and @w_cta_banco is null
       return 0
  
    update cl_ente
    set en_nit     = isnull(@i_nit, en_nit),
	    en_rfc     = isnull(@i_nit, en_rfc),
		en_ced_ruc = isnull(@i_cedula,en_ced_ruc),
		en_banco   = isnull(@i_banco,en_banco)
    where en_ente = @i_persona
    and en_subtipo = 'P'

      if @@error <> 0
      begin
      
         exec sp_cerror  @t_debug    = @t_debug,
               @t_file     = @t_file,
               @t_from     = @w_sp_name,
               @i_num      = 105026
         /* 'Error en actualizacion de persona'*/
         return 1
      end   

    update cl_ente_aux
    set ea_nit     = isnull(@i_nit_id, ea_nit),
		ea_ced_ruc = isnull(@i_cedula, ea_ced_ruc)       
    where ea_ente = @i_persona

      if @@error <> 0
      begin
         exec sp_cerror  
		       @t_debug    = @t_debug,
               @t_file     = @t_file,
               @t_from     = @w_sp_name,
               @i_num      = 105026
         /* 'Error en actualizacion de persona'*/
         return 1
      end

    --ACTUALIZACION DE LA CUENTA DEL CLIENTE
    EXEC @w_return   = update_cuenta_sant
    @i_cliente       = @i_persona,
	@i_cuenta        = @i_ea_cta_banco,
	@i_operacion     = 'U'
    
	if @w_return <> 0
    begin
		return 1
      end  	  

    --TRANSACCION DE SERVICIO - DATOS PREVIOS AL CAMBIO
    insert into ts_persona_prin (secuencia, tipo_transaccion, clase,          fecha,      usuario, 
                                 terminal,  srv,              lsrv,           persona,    cedula,
                                 fecha_mod, nit,              secuen_alterno, hora)       
                         values (@s_ssn,    @t_trn,           'P',            @s_date,    @s_user, 
                                 @s_term,   @s_srv,           @s_lsrv,        @i_persona, @v_cedula,
                               getdate(), @v_nit,           1,              getdate())
     if @@error <> 0
        begin
           exec sp_cerror
              @t_debug    = @t_debug,
              @t_file     = @t_file,
              @t_from     = @w_sp_name,
              @i_num      = 103005
           --ERROR EN CREACION DE TRANSACCION DE SERVICIO
           return 1
        end

     --TRANSACCION DE SERVICIO - DATOS ACTUALES AL CAMBIO
    insert into ts_persona_prin (secuencia, tipo_transaccion, clase,          fecha,      usuario, 
                                 terminal,  srv,              lsrv,           persona,    cedula,
                                 fecha_mod, nit,              secuen_alterno, hora)       
                         values (@s_ssn,    @t_trn,           'A',            @s_date,    @s_user, 
                                 @s_term,   @s_srv,           @s_lsrv,        @i_persona, @w_cedula,
                                 getdate(), @w_nit,           1,              getdate())
     if @@error <> 0
     begin
        exec sp_cerror
           @t_debug    = @t_debug,
           @t_file     = @t_file,
           @t_from     = @w_sp_name,
           @i_num      = 103005
        --ERROR EN CREACION DE TRANSACCION DE SERVICIO
        return 1
     end
    --SMO  Fin Transaccion de servicios
  end
END	

--update de campos del ente
if @i_operacion = 'C' -- Datos Complementarios
begin

if @t_trn = 104
  begin
  
    
    select
         @w_telefono_recados            = b.ea_telef_recados   ,
         @w_numero_ife                  = b.ea_numero_ife      ,
         @w_numero_serie_firma_elect    = b.ea_num_serie_firma ,
         @w_persona_recados             = b.ea_persona_recados ,
         @w_antecedentes_buro           = b.ea_antecedente_buro,
         @w_act_profesional             = b.ea_act_profesional,
		 @w_usa_crypto                  = b.ea_usa_crypto,
         @w_pasaporte                   = a.p_pasaporte       
    from cobis..cl_ente a, cobis..cl_ente_aux b
    where en_ente = @i_persona
    and   en_ente = ea_ente
    
    select @v_telefono_recados         = @w_telefono_recados,
           @v_numero_ife               = @w_numero_ife,
           @v_numero_serie_firma_elect = @w_numero_serie_firma_elect,
           @v_persona_recados          = @w_persona_recados,
           @v_antecedentes_buro        = @w_antecedentes_buro,
           @v_act_profesional          = @w_act_profesional,
           @v_usa_crypto               = @w_usa_crypto,
           @v_pasaporte                = @w_pasaporte
               
    if @w_telefono_recados = @i_telefono_recados
       select @w_telefono_recados = null, @v_telefono_recados = null
    else
       select @w_telefono_recados = @i_telefono_recados
 
    if @w_numero_ife = @i_numero_ife
       select @w_numero_ife = null, @v_numero_ife = null
    else
       select @w_numero_ife = @i_numero_ife
    
    if @w_numero_serie_firma_elect = @i_numero_serie_firma
       select @w_numero_serie_firma_elect = null, @v_numero_serie_firma_elect = null
    else
       select @w_numero_serie_firma_elect = @i_numero_serie_firma
    
    if @w_persona_recados = @i_persona_recados
       select @w_persona_recados = null, @v_persona_recados = null
    else
       select @w_persona_recados = @i_persona_recados
             
    if @w_antecedentes_buro = @i_antecedentes_buro
       select @w_antecedentes_buro = null, @v_antecedentes_buro = null
    else
       select @w_antecedentes_buro = @i_antecedentes_buro
    
    if @w_pasaporte = @i_pasaporte
       select @w_pasaporte = null, @v_pasaporte = null
    else
       select @w_pasaporte = @i_pasaporte
	
	if @w_act_profesional = @i_act_profesional
       select @w_act_profesional = null, @v_act_profesional = null
    else
       select @w_act_profesional = @i_act_profesional
    
    if @w_usa_crypto = @i_usa_crypto
       select @w_usa_crypto = null, @v_usa_crypto = null
    else
       select @w_usa_crypto = @i_usa_crypto
	   
	update cobis..cl_ente_aux
    set ea_telef_recados    = @i_telefono_recados,
	    ea_numero_ife       = @i_numero_ife,
	    ea_num_serie_firma  = @i_numero_serie_firma,
	    ea_persona_recados  = @i_persona_recados,
	    ea_antecedente_buro = @i_antecedentes_buro,
		ea_act_profesional  = @i_act_profesional,
		ea_usa_crypto       = @i_usa_crypto
    where ea_ente           = @i_persona
    
    if @@error <> 0
    begin
         exec sp_cerror  @t_debug    = @t_debug,
               @t_file     = @t_file,
			   @t_from     = @w_sp_name,
               @i_num      = 105026
         /* 'Error en actualizacion de persona'*/
         return 1
    end   
    
    update cobis..cl_ente
    set p_pasaporte         = @i_pasaporte
    where en_ente           = @i_persona
    
    if @@error <> 0
    begin
         exec sp_cerror  @t_debug    = @t_debug,
               @t_file     = @t_file,
               @t_from     = @w_sp_name,
               @i_num      = 105026
         /* 'Error en actualizacion de persona'*/
         return 1
    end   
    
    
    
    if @w_telefono_recados <> @v_telefono_recados
    begin
          insert into cl_actualiza (ac_ente           , ac_fecha           , ac_tabla      ,
                                    ac_campo          , ac_valor_ant       , ac_valor_nue  ,
                                    ac_transaccion    , ac_secuencial1     , ac_secuencial2, 
                                    ac_hora)
                     values        (@i_persona        , @s_date            ,'cl_ente_aux',
                                    'ea_telef_recados', @v_telefono_recados, @w_telefono_recados,
                                    'U'               , null               , null, 
                                    getdate())
          if @@error <> 0
          begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
          end
    end
    
    if @w_numero_ife <> @v_numero_ife
    begin
          insert into cl_actualiza (ac_ente           , ac_fecha           , ac_tabla      ,
                                    ac_campo          , ac_valor_ant       , ac_valor_nue  ,
                                    ac_transaccion    , ac_secuencial1     , ac_secuencial2, 
                                    ac_hora)
                     values        (@i_persona        , @s_date            ,'cl_ente_aux'  ,
                                    'ea_numero_ife'   , @v_numero_ife      , @w_numero_ife ,
                                    'U'               , null               , null, 
                                    getdate())
          if @@error <> 0
          begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
          end
    end
    
    
    if @w_numero_serie_firma_elect <> @v_numero_serie_firma_elect
    begin
          insert into cl_actualiza (ac_ente             , ac_fecha           , ac_tabla      ,
                                    ac_campo            , ac_valor_ant       , ac_valor_nue  ,
                                    ac_transaccion      , ac_secuencial1     , ac_secuencial2, 
                                    ac_hora)
                     values        (@i_persona          , @s_date                    ,'cl_ente_aux'               ,
                                    'ea_num_serie_firma', @v_numero_serie_firma_elect, @w_numero_serie_firma_elect,
                                    'U'                 , null                       , null, 
                                    getdate())
          if @@error <> 0
          begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
          end
    end  
    
    if @w_persona_recados <> @v_persona_recados
    begin
          insert into cl_actualiza (ac_ente             , ac_fecha           , ac_tabla      ,
                        ac_campo            , ac_valor_ant       , ac_valor_nue  ,
                                    ac_transaccion      , ac_secuencial1     , ac_secuencial2, 
                                    ac_hora)
                     values        (@i_persona          , @s_date            ,'cl_ente_aux'               ,
                                    'ea_persona_recados', @v_persona_recados , @w_persona_recados,
                                    'U'                 , null               , null, 
                                    getdate())
          if @@error <> 0
          begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
          end
    end
    
    if @w_antecedentes_buro <> @v_antecedentes_buro
    begin
          insert into cl_actualiza (ac_ente              , ac_fecha            , ac_tabla      ,
                                    ac_campo             , ac_valor_ant        , ac_valor_nue  ,
                                    ac_transaccion       , ac_secuencial1      , ac_secuencial2, 
                                    ac_hora)                                    
                     values        (@i_persona           , @s_date             ,'cl_ente_aux'               ,
                                    'ea_antecedente_buro', @v_antecedentes_buro, @w_antecedentes_buro,
                                    'U'                  , null                , null, 
                                    getdate())
          if @@error <> 0
          begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
          end
    end 
    
    if @w_pasaporte <> @v_pasaporte
    begin
          insert into cl_actualiza (ac_ente          , ac_fecha            , ac_tabla      ,
                                    ac_campo         , ac_valor_ant        , ac_valor_nue  ,
                                    ac_transaccion   , ac_secuencial1      , ac_secuencial2, 
                                    ac_hora)                                    
                     values        (@i_persona       , @s_date             ,'cl_ente' ,
                                    'p_pasaporte'    , @v_pasaporte        , @w_pasaporte,
                                    'U'              , null                , null, 
                                    getdate())
          if @@error <> 0
          begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
          end
    end 
      
  end
  
   --SRO. Inicia Actualización Negative FILE
   exec @w_error   = cob_credito..sp_negative_file
   @i_ente         = @i_persona,
   @o_resultado    = @w_resultado_nf output    
   
   if @w_error <> 0 begin
      exec sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = @w_error
      /* 'Error en actualizacion de persona'*/
      return @w_error
   end

   --Inicia Actualización ListaNegra caso#169145
   exec @w_error   = cob_credito..sp_li_negra_cliente
   @i_ente         = @i_persona,
   @o_resultado    = @w_resultado_ln output
   
   if @w_error <> 0 begin
      exec sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = @w_error
      /* 'Error en actualizacion de persona'*/
      return @w_error
   end
   
   --select @o_lista_negra = case when @w_resultado_ln = 1 then 'N' else 'S' end--****
   select @o_lista_negra = case when @w_resultado_nf = 1 and @w_resultado_ln = 1 then 'N' else 'S' end -- Caso169145, se deja así por el caso 151529
								
	 
  if (select en_nombre from cobis..cl_ente where en_ente = @i_persona) is not null
  begin
     exec cobis..sp_seccion_validar
		      @i_ente			= @i_persona,
		      @i_operacion   	= 'V',
		      @i_seccion 		= '1', --1 es Informacion General
		      @i_completado 	= 'S'
		     
  end		     
end	

--update de campos del ente
if @i_operacion = 'B' -- actualiza solamente información que envia el buró de crédito
begin
	if @t_trn = 104
	begin
		update cl_ente set 
		en_calificacion = isnull(@i_calificacion, en_calificacion),
		p_calif_cliente = isnull(@i_calificacion_ind,p_calif_cliente),
		en_banco        = isnull(@i_banco, en_banco)              
		where en_ente = @i_persona
		and en_subtipo = 'P'
		
		if @@error <> 0
		begin
			exec sp_cerror  @t_debug    = @t_debug,
			      @t_file     = @t_file,
			 @t_from     = @w_sp_name,
			      @i_num      = 105026
			/* 'Error en actualizacion de persona'*/
			return 1
		end
		
		update cl_ente_aux set 
		ea_cta_banco  = isnull(@i_ea_cta_banco,ea_cta_banco),
		ea_estado_std = isnull(@i_estado_std,ea_estado_std)
		where ea_ente = @i_persona
				
		if @@error <> 0
		begin
			exec sp_cerror
			   @t_debug    = @t_debug,
			   @t_file     = @t_file,
			   @t_from     = @w_sp_name,
			   @i_num      = 105093
			   /* 'Error en actualizacion de compania'*/
			return 1
		end
	end
end

--update de campos del ente
if @i_operacion = 'A' -- actualiza solamente información de la cuenta altair
begin
	if @t_trn = 104
	begin
	    select valor as valor, codigo as codigo
		into #catBtnConsultaCuenta
		from cobis..cl_catalogo 
		where tabla = (select codigo from cobis..cl_tabla where tabla = 'cl_hab_func_consulta_cuenta')
		
		--Valida existencia de rol
        if exists (select 1 from #catBtnConsultaCuenta
                   where codigo = @s_rol)
        begin
		    select @w_rol = codigo from #catBtnConsultaCuenta
            where codigo = @s_rol
        end
		
		--select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES'
		if (@s_rol = @w_rol)
		begin
			update cl_ente_aux 
			set ea_cta_banco  = isnull(@i_ea_cta_banco,ea_cta_banco)
			where ea_ente = @i_persona
			
			update cob_cartera..ca_desembolso -- Err.191745
            set   dm_cuenta    = @i_ea_cta_banco
            from cob_cartera..ca_operacion
            where op_cliente   = @i_persona
            and   op_estado    = 1
            and   dm_operacion = op_operacion
            
            update cob_cartera..ca_santander_orden_deposito_fallido -- Err.191745
            set   odf_cuenta = @i_ea_cta_banco
		    from cob_cartera..ca_operacion
            where op_cliente = @i_persona
            and   op_estado  = 1
            and   odf_banco  = op_banco
		    and   odf_accion = 1
		    			    
			if @@error <> 0
			begin
				exec sp_cerror
				   @t_debug    = @t_debug,
				   @t_file     = @t_file,
				   @t_from     = @w_sp_name,
				   @i_num      = 605014
				   /* 'Error en actualizacion de Cuenta'*/
				return 1
			end
		end
		else
		begin
			exec sp_cerror  @t_debug    = @t_debug,
               @t_file     = @t_file,
               @t_from     = @w_sp_name,
               @i_num      = 105507
         /* 'Este rol no esta autorizado para realizar la operación'*/
         return 105507
		end
	end
end

if @i_operacion = 'E' --update de información económica del cliente enviada por el mobile, PROYECTO SANTANDER 
begin
if @t_trn = 104
  begin
    update cl_ente
    set 
    en_otros_ingresos = isnull(@i_otros_ingresos, en_otros_ingresos)         
    where en_ente = @i_persona
    and en_subtipo = 'P'

      if @@error <> 0
      begin
         exec sp_cerror  @t_debug    = @t_debug,
               @t_file     = @t_file,
               @t_from     = @w_sp_name,
               @i_num      = 105026
         /* 'Error en actualizacion de persona'*/
         return 1
      end

    update cl_ente_aux
    set ea_ct_ventas  = isnull(@i_ct_ventas,ea_ct_ventas),
        ea_ct_operativo = isnull(@i_ct_operativos,ea_ct_operativo),
        ea_ventas  = isnull(@i_ventas,ea_ventas),
        ea_ingreso_negocio  = isnull(@i_ing_negocio,ea_ingreso_negocio)
    where ea_ente = @i_persona
          
     if @@error <> 0
     begin
          exec sp_cerror
               @t_debug    = @t_debug,
               @t_file     = @t_file,
               @t_from     = @w_sp_name,
               @i_num      = 105093
               /* 'Error en actualizacion de compania'*/
          return 1
     end
   end
end

if @i_operacion = 'M' --update de información del cliente enviada por el mobile, PROYECTO SANTANDER 
begin
if @t_trn = 104
   begin
		select 
		@i_oficial 			= oc_oficial,
		@w_login_oficia 	= fu_login,
		@i_oficina 			= fu_oficina,
		@w_oficial          = en_oficial,
		@w_oficina          = en_oficina,
		@w_cedula           = en_ced_ruc,
		@w_nit              = en_nit	
		from cobis..cc_oficial,
		     cobis..cl_funcionario,
		     cobis..cl_ente
		where en_oficial = oc_oficial
		and fu_funcionario= oc_funcionario
		and en_ente= @i_persona

	  /*Control para CURP*/
	  if((@w_cedula <> @i_cedula) or (@w_nit <> @i_nit))
	  begin
	      insert into cl_modificacion_curp_rfc (mcr_ente,     mcr_ssn_user,  mcr_ssn_oficina,
		                                        mcr_fecha,    mcr_oficial ,  mcr_oficina    ,
												mcr_curp_ant, mcr_rfc_ant ,  mcr_curp       ,
												mcr_rfc,      mcr_operacion, mcr_sp)
                                        values (@i_persona,   @s_user     ,  @s_ofi         ,
										        getdate(),    @w_oficial  ,  @w_oficina     ,
												@w_cedula,    @w_nit      ,  @i_cedula,
												@i_nit,       @i_operacion,  @w_sp_name)
		 if(len(@i_cedula) < 18)
		 select @i_cedula = @w_cedula
	  end
	  /*Fin Control para CURP*/

	  /*Datos Actuales*/
	  select @w_nombre     = en_nombre,
             @w_p_apellido = p_p_apellido,
             @w_segnombre  = p_s_nombre,
             @w_s_apellido = p_s_apellido,
             @w_cedula     = en_ced_ruc,             
             @w_nit        = en_nit
	   from  cl_ente
       where en_ente = @i_persona
         and en_subtipo = 'P'
	  
	  select @w_ea_colectivo       = ea_colectivo,
	         @w_ea_nivel_colectivo = ea_nivel_colectivo
	  from cl_ente_aux
	  where ea_ente = @i_persona
	  
	  ----------Se respalda la informacion
	  select @v_nombre     = @w_nombre    ,
             @v_p_apellido = @w_p_apellido,
             @v_segnombre  = @w_segnombre ,
             @v_s_apellido = @w_s_apellido,
             @v_cedula     = @w_cedula,
             @v_nit        = @w_nit,
			 @v_ea_colectivo = @w_ea_colectivo,
			 @v_ea_nivel_colectivo = @w_ea_nivel_colectivo
			 
      ----------Comparacion
      if @w_nombre = @i_nombre        
          select @w_nombre = null, @v_nombre = null
	  else
	      select @w_nombre = @i_nombre

      if @w_p_apellido = @i_p_apellido        
          select @w_p_apellido = null, @v_p_apellido = null
	  else
	      select @w_p_apellido = @i_p_apellido		  

      if @w_segnombre = @i_segnombre      
          select @w_segnombre = null, @v_segnombre = null
	  else
	      select @w_segnombre = @i_segnombre

      if @w_s_apellido = @i_s_apellido        
          select @w_s_apellido = null, @v_s_apellido = null
	  else
	      select @w_s_apellido = @i_s_apellido	

      if @w_cedula = @i_cedula        
          select @w_cedula = null, @v_cedula = null
	  else
	      select @w_cedula = @i_cedula	

      if @w_nit = @i_nit
          select @w_nit = null, @v_nit = null
	  else
	      select @w_nit = @i_nit
		  
	-- =========================================================================
	select @w_exist_tram = 1 from cob_workflow..wf_inst_proceso
	where io_estado = 'EJE' and io_campo_4 = 'REVOLVENTE' 
	and io_campo_7 != 'S' AND io_campo_1 = @i_persona

   --COLECTIVO/TIPO DE MERCADO
    if @w_ea_colectivo = @i_colectivo
       select @w_ea_colectivo = null, @v_ea_colectivo  = null
    else
    begin
      if @w_exist_tram = 1
	  begin
		exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'NO PUEDE MODIFICAR EL TIPO DE MERCADO YA QUE TIENE UNA SOLICITUD EN EJECUCION',
            @i_num     = 103413
        -- NO PUEDE MODIFICAR EL TIPO DE MERCADO YA QUE TIENE UNA SOLICITUD EN EJECUCION
			return 103413
	  end
	  else
		select @w_ea_colectivo = @i_colectivo
    end

    --NIVEL COLECTIVO/NIVEL DE CLIENTE
    if @w_ea_nivel_colectivo = @i_nivel_colectivo
       select @w_ea_nivel_colectivo = null, @v_ea_nivel_colectivo  = null
    else
    begin
	    if @w_exist_tram = 1
	    begin
	 	    exec sp_cerror
             @t_debug   = @t_debug,
             @t_file    = @t_file,
             @t_from    = @w_sp_name,
             @i_msg     = 'NO PUEDE MODIFICAR EL NIVEL DE CLIENTE YA QUE TIENE UNA SOLICITUD EN EJECUCION',
             @i_num     = 103414
         -- NO PUEDE MODIFICAR EL NIVEL DE CLIENTE YA QUE TIENE UNA SOLICITUD EN EJECUCION
            return 103414
	    end
	    else
	 	    select @w_ea_nivel_colectivo = @i_nivel_colectivo
    end
	-- =========================================================================

		  
     /* Se convierte a null para no modificar el valor de la base */
		if @i_nac_aux = 0
		   select @i_nac_aux = null
		
     --TRANSACCION DE SERVICIO - DATOS PREVIOS-PRMERA PARTE		 
      insert into ts_persona_prin (secuencia,                 tipo_transaccion,         clase,                       fecha,                 usuario, 
                                   terminal,                  srv,                      lsrv,                        persona,               nombre, 
								   s_nombre,                  p_apellido,               s_apellido,                  cedula,                nit,                       
								   hora                      )
								   
                           values (@s_ssn,                    @t_trn,                   'P',                         @s_date,                     @s_user, 
                                   @s_term,                   @s_srv,                   @s_lsrv,                     @i_persona,                  @v_nombre, 
								   @v_segnombre,              @v_p_apellido,            @v_s_apellido,               @v_cedula,                   @v_nit,                    
								   getdate()                 )

      if @@error <> 0
      begin
         exec sp_cerror
              @t_debug    = @t_debug,
              @t_file     = @t_file,
              @t_from     = @w_sp_name,
              @i_num      = 103005
           --ERROR EN CREACION DE TRANSACCION DE SERVICIO
              return 1
      end
	  
     --TRANSACCION DE SERVICIO - DATOS PREVIOS-SEGUNDA PARTE
      insert into ts_persona_sec ( secuencia,          tipo_transaccion,          clase,              fecha,             usuario, 
                                   terminal,           srv,                       lsrv,               persona,           nombre, 
                                   p_apellido,         s_apellido,                nit,                hora,              colectivo,
								   nivel_colectivo)                                   
                                                                                                      
                           values (@s_ssn,             @t_trn,                    'P',                @s_date,           @s_user, 
                                   @s_term,            @s_srv,                    @s_lsrv,            @i_persona,        @v_nombre, 
                                   @v_p_apellido,      @v_s_apellido,             @v_nit,             getdate(),         @v_ea_colectivo,
								   @v_ea_nivel_colectivo)
      if @@error <> 0
      begin
          exec sp_cerror
               @t_debug    = @t_debug,
               @t_file     = @t_file,
               @t_from     = @w_sp_name,
               @i_num      = 103005
               /*'Error en creacion de transaccion de servicio'*/
      return 1
      end

     --TRANSACCION DE SERVICIO - DATOS PREVIOS-PRMERA PARTE		 
      insert into ts_persona_prin (secuencia,                 tipo_transaccion,         clase,                       fecha,                 usuario, 
                                   terminal,                  srv,                      lsrv,                        persona,               nombre, 
								   s_nombre,                  p_apellido,               s_apellido,                  cedula,                nit,                       
								   hora                      )
								   
                           values (@s_ssn,                    @t_trn,                   'A',                         @s_date,                     @s_user, 
                                   @s_term,                   @s_srv,                   @s_lsrv,                     @i_persona,                  @w_nombre, 
								   @w_segnombre,              @w_p_apellido,            @w_s_apellido,               @w_cedula,                   @w_nit,                    
								   getdate()                 )

      if @@error <> 0
      begin
         exec sp_cerror
              @t_debug    = @t_debug,
              @t_file     = @t_file,
              @t_from     = @w_sp_name,
              @i_num      = 103005
           --ERROR EN CREACION DE TRANSACCION DE SERVICIO
              return 1
      end
	  
     --TRANSACCION DE SERVICIO - DATOS PREVIOS-SEGUNDA PARTE
      insert into ts_persona_sec ( secuencia,          tipo_transaccion,          clase,              fecha,             usuario, 
                                   terminal,           srv,                       lsrv,               persona,           nombre, 
                                   p_apellido,         s_apellido,                nit,                hora,              colectivo,
								   nivel_colectivo)                                   
                                                                                                      
                           values (@s_ssn,             @t_trn,                    'A',                @s_date,           @s_user, 
                                   @s_term,            @s_srv,                    @s_lsrv,            @i_persona,        @w_nombre, 
                                   @w_p_apellido,      @w_s_apellido,             @w_nit,             getdate(),         @w_ea_colectivo,
								   @w_ea_nivel_colectivo)
      if @@error <> 0
      begin
          exec sp_cerror
               @t_debug    = @t_debug,
               @t_file     = @t_file,
               @t_from     = @w_sp_name,
               @i_num      = 103005
               /*'Error en creacion de transaccion de servicio'*/
      return 1
      end	  
	  ------------------	 
      update cl_ente
      set    en_nombre         = isnull(@i_nombre,en_nombre), 
             p_p_apellido      = isnull(@i_p_apellido,p_p_apellido), 
             p_s_nombre        = isnull(@i_segnombre,p_s_nombre), 
             p_s_apellido      = isnull(@i_s_apellido,p_s_apellido), 
             en_ced_ruc        = isnull(@i_cedula,en_ced_ruc), 
             en_tipo_ced       = isnull(@i_tipo_ced,en_tipo_ced),
             p_sexo            = isnull(@i_sexo,p_sexo), 
             p_depa_nac        = isnull(@i_depa_nac,p_depa_nac),
             p_estado_civil    = isnull(@i_estado_civil,p_estado_civil),
             p_fecha_nac       = isnull(@i_fecha_nac,p_fecha_nac),
             en_filial         = isnull(@i_filial, en_filial),
             en_oficina        = isnull(@i_oficina,en_oficina), 
             --en_oficial        = isnull(@i_oficial,en_oficial),
             --c_funcionario     = isnull(@w_login_oficia,c_funcionario),
             p_pais_emi        = isnull(@i_pais_emi,p_pais_emi),
             en_nac_aux        = isnull(@i_nac_aux,en_nac_aux), 
             p_nivel_estudio   = isnull(@i_nivel_estudio,p_nivel_estudio),
             p_profesion       = isnull(@i_profesion,p_profesion),
			 p_otro_profesion  = isnull(@i_otro_prof,p_otro_profesion),
			 p_num_cargas      = isnull(@i_num_cargas,p_num_cargas),
             en_nit            = isnull(@i_nit,en_nit),
			    en_rfc            = isnull(@i_nit,en_rfc),
             en_ing_SN         = isnull(@i_ing_SN, en_ing_SN),
             en_persona_pub    = isnull(@i_emproblemado,en_persona_pub), --Se camia de emproblemado a en_persona_pep
             p_rel_carg_pub    = isnull(@i_rel_carg_pub, p_rel_carg_pub),
             en_otringr        = isnull(@i_otringr,en_otringr),
             en_otros_ingresos = isnull(@i_otros_ingresos, en_otros_ingresos),
			    --en_persona_pub    = isnull(@i_persona_pub, en_persona_pub),
             en_nomlar         = (isnull(@i_nombre,en_nombre) + ' ' + isnull(@i_segnombre,isnull(p_s_nombre,'')) + ' ' + isnull(@i_p_apellido,p_p_apellido) + ' ' + isnull(@i_s_apellido,isnull(p_s_apellido,'')))
       where en_ente = @i_persona
         and en_subtipo = 'P'
      
      if @@error <> 0
      begin
         exec sp_cerror  
              @t_debug    = @t_debug,
              @t_file     = @t_file,
              @t_from     = @w_sp_name,
              @i_num      = 105026
         /* 'Error en actualizacion de persona'*/
         return 1
      end
      
      update cl_ente_aux
      set ea_nro_ciclo_oi    = isnull(@i_ea_nro_ciclo_oi,ea_nro_ciclo_oi),
          ea_ventas          = isnull(@i_ventas,ea_ventas),
          ea_ct_ventas       = isnull(@i_ct_ventas,ea_ct_ventas),
          ea_ct_operativo    = isnull(@i_ct_operativos, ea_ct_operativo),
          ea_nit             = isnull(@i_nit,ea_nit),
          ea_ced_ruc         = isnull(@i_cedula,ea_ced_ruc),
          ea_ingreso_negocio = isnull(@i_ing_negocio,ea_ingreso_negocio),
		  ea_colectivo       = isnull(@i_colectivo, ea_colectivo),
          ea_nivel_colectivo = isnull(@i_nivel_colectivo, ea_nivel_colectivo),
	      ea_consulto_renapo = isnull(@i_respuesta_renapo, ea_consulto_renapo)
      where ea_ente = @i_persona
      
      if @@error <> 0
      begin
         exec sp_cerror
             @t_debug    = @t_debug,
             @t_file     = @t_file,
             @t_from     = @w_sp_name,
             @i_num      = 105026
             /* 'Error en actualizacion de persona'*/
         return 1
      end
      
      if exists(select 1 from cobis..cl_ente_bio where eb_ente = @i_persona)
      begin
         
         update cobis..cl_ente_bio
         set eb_tipo_identificacion    = isnull(@i_bio_tipo_identificacion,eb_tipo_identificacion),
             eb_cic                    = isnull(@i_bio_cic,eb_cic),
             eb_ocr                    = isnull(@i_bio_ocr,eb_ocr),
             eb_nro_emision            = isnull(@i_bio_numero_emision,eb_nro_emision),
             eb_clave_elector          = isnull(@i_bio_clave_lector,eb_clave_elector),
             eb_sin_huella_dactilar    = isnull(@i_bio_huella_dactilar,isnull(eb_sin_huella_dactilar,'N')),
             eb_anio_registro          = isnull(@i_register_year,isnull(eb_anio_registro,'0')),
             eb_anio_emision           = isnull(@i_emission_year,isnull(eb_anio_emision,'0'))
         where eb_ente = @i_persona
         
         if @@error <> 0
         begin
            exec sp_cerror
                @t_debug    = @t_debug,
                @t_file     = @t_file,
                @t_from     = @w_sp_name,
                @i_num      = 105026
                /* 'Error en actualizacion de persona'*/
            return 105026
         end
		 
		 insert into cobis..cl_ente_bio_his
	     (ebh_ssn,                            ebh_ente,              ebh_tipo_identificacion,     ebh_cic,
         ebh_ocr,                             ebh_nro_emision,       ebh_clave_elector,           ebh_sin_huella_dactilar,             
		 ebh_fecha_registro,                  ebh_fecha_vencimiento, ebh_anio_registro,           ebh_anio_emision,
		 ebh_fecha_modificacion,              ebh_transaccion,       ebh_usuario,                 ebh_terminal,
		 ebh_srv,                             ebh_lsrv)
	     values                               
	     (@s_ssn,                             @i_persona,            @i_bio_tipo_identificacion,  @i_bio_cic, 	         
		 @i_bio_ocr,                          @i_bio_numero_emision, @i_bio_clave_lector, 	      isnull(@i_bio_huella_dactilar,'N'),  
		 getdate(),                           null,                  @i_register_year,            @i_emission_year,
		 getdate(),                           'U',                   @s_user,                     @s_term,
		 @s_srv,                              @s_lsrv)
		  
         if @@error <> 0
         BEGIN
           exec sp_cerror
                @t_debug    = @t_debug,
                @t_file     = @t_file,
                @t_from     = @w_sp_name,
                @i_num      = 105026
                /* 'Error en actualizacion de persona'*/
           return 105026
         end
      end
      else
      begin
         --Secuencial
         exec 
         @w_error     = cobis..sp_cseqnos
         @t_debug     = 'N',
         @t_file      = null,
         @t_from      = @w_sp_name,
         @i_tabla     = 'cl_ente_bio',
         @o_siguiente = @w_secuencial out
         
         if @w_error <> 0 begin
            exec sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = @w_error
			return @w_error
         end
		 
         insert into cobis..cl_ente_bio
   	     (eb_secuencial, eb_ente,      eb_tipo_identificacion,    eb_cic,     eb_ocr,     eb_nro_emision,         eb_clave_elector,    eb_sin_huella_dactilar, eb_fecha_registro,
   	     eb_anio_registro, eb_anio_emision)
   	     values  
   	     (@w_secuencial, @i_persona,   @i_bio_tipo_identificacion,@i_bio_cic, @i_bio_ocr, @i_bio_numero_emision,  @i_bio_clave_lector, isnull(@i_bio_huella_dactilar,'N'), getdate(),
   	     @i_register_year, @i_emission_year)
           
         if @@error <> 0
         begin
            exec sp_cerror
                @t_debug    = @t_debug,
                @t_file     = @t_file,
                @t_from     = @w_sp_name,
                @i_num      = 105026
                /* 'Error en actualizacion de persona'*/
            return 105026
         end
		 			 
		 insert into cobis..cl_ente_bio_his
	     (ebh_ssn,                            ebh_ente,              ebh_tipo_identificacion,     ebh_cic,
         ebh_ocr,                             ebh_nro_emision,       ebh_clave_elector,           ebh_sin_huella_dactilar,             
		 ebh_fecha_registro,                  ebh_fecha_vencimiento, ebh_anio_registro,           ebh_anio_emision,
		 ebh_fecha_modificacion,              ebh_transaccion,       ebh_usuario,                 ebh_terminal,
		 ebh_srv,                             ebh_lsrv)
	     values                               
	     (@s_ssn,                             @i_persona,            @i_bio_tipo_identificacion,  @i_bio_cic, 	         
		 @i_bio_ocr,                          @i_bio_numero_emision, @i_bio_clave_lector, 	      isnull(@i_bio_huella_dactilar,'N'),  
		 getdate(),                           null,                  @i_register_year,            @i_emission_year,
		 getdate(),                           'I',                   @s_user,                     @s_term,
		 @s_srv,                              @s_lsrv)
		  		  
         if @@error <> 0
         BEGIN
           exec sp_cerror
                @t_debug    = @t_debug,
                @t_file     = @t_file,
                @t_from     = @w_sp_name,
                @i_num      = 105026
                /* 'Error en actualizacion de persona'*/
           return 105026
         end
      end
      
	 --SRO. Inicia Actualización Negative FILE
     exec @w_error   = cob_credito..sp_negative_file
     @i_ente         = @i_persona,
     @o_resultado    = @w_resultado_nf output    
     
     if @w_error <> 0 begin
        exec sp_cerror
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num      = @w_error
        /* 'Error en actualizacion de persona'*/
        return @w_error
     end
     --SRO. Fin Actualización Negative FILE
	 
    --Inicia Actualización ListaNegra caso#169145
    exec @w_error   = cob_credito..sp_li_negra_cliente
    @i_ente         = @i_persona,
    @o_resultado    = @w_resultado_ln output
    
    if @w_error <> 0 begin
       exec sp_cerror
       @t_debug    = @t_debug,
       @t_file     = @t_file,
       @t_from     = @w_sp_name,
       @i_num      = @w_error
       /* 'Error en actualizacion de persona'*/
       return @w_error
    end
   
	--select @o_lista_negra = case when @w_resultado_ln = 1 then 'N' else 'S' end
	select @o_lista_negra = case when @w_resultado_nf = 1 and @w_resultado_ln = 1 then 'N' else 'S' end -- Caso169145, se deja así por el caso 151529
	
     if ((@i_estado_civil <> 'UN') and (@i_estado_civil <> 'CA') and (@i_estado_civil<>null)) begin
        SELECT @w_in_ente_d=in_ente_d FROM cobis..cl_instancia WHERE in_ente_i=@i_persona
        UPDATE cobis..cl_ente SET p_estado_civil='SO' WHERE en_ente=@w_in_ente_d
         delete cobis..cl_instancia
        WHERE (in_ente_i   = @i_persona or in_ente_d = @i_persona)
        AND   in_relacion = @w_relacion_ca
     end

	   -- Actualizacion Automatica de Prospecto a Cliente    
      if (select b.ea_antecedente_buro from cobis..cl_ente_aux b where ea_ente = @i_persona) is not null 
	   begin  
	     exec cobis..sp_seccion_validar
		      @i_ente			= @i_persona,
		      @i_operacion 	= 'V',
		      @i_seccion 		= '1', --1 es Informacion General
		      @i_completado 	= 'S'
      end
	  
	  -- Soporte #175052
      -- Eliminacion de conyuge en caso de que el cliente hay cambiado su estado civil a DI, SO, y VI (Divorciado, Soltero y Viudo)
      select @w_est_civil = (select p_estado_civil from cobis..cl_ente where en_ente = @i_persona)   
      if @w_est_civil in ('DI', 'SO', 'VI')
      begin  
        delete from cobis..cl_conyuge
        where co_ente = @i_persona
      end  
   end   
end


if @i_operacion = 'U' -- actua,iza la informacion desde el FE
begin
  --No debe generar el curp #210163, pero se deja si el dato no viene de las pantallas , parametro ACRXCR = 'N'---
  select @o_curp = @i_cedula

  if @t_trn = 104
  begin
    select @w_nemocda = pa_char
    from cobis..cl_parametro
    where pa_nemonico = 'CDA' and pa_producto = 'CLI'

    select @w_nemovda = pa_char
    from cobis..cl_parametro
    where pa_nemonico = 'VDA' and pa_producto = 'CLI'

    select @w_estados = pa_char--inc 69991
    from cobis..cl_parametro
    where pa_nemonico = 'ECAC' and pa_producto = 'CLI'
    
    select @w_nemomed = pa_char
    from cobis..cl_parametro
    where pa_nemonico = 'MED' and pa_producto = 'CLI'
	
	
	--REQ 119691 SE PERMITE LA MODIFICACION DE NOMBRES SIN QUE AFECTE EL CURP O RFC CON ROL MESA DE OPERACIONES
	if @s_rol = @w_param_modifica
	begin
		select @w_nombres = @i_nombre + ' ' + isnull(@i_segnombre,'')
		exec @w_return = cobis..sp_generar_curp
		@i_primer_apellido       = @i_p_apellido,
		@i_segundo_apellido      = @i_s_apellido,
		@i_nombres               = @w_nombres,
		@i_sexo                  = @i_sexo,
		@i_fecha_nacimiento      = @i_fecha_nac,
		@i_entidad_nacimiento    = @i_depa_nac,
		@i_ente                  = @i_persona,
		@o_mensaje               = @w_msg  out,
		--@o_curp                  = @o_curp out,
		@o_rfc                   = @o_rfc  out		
		
		select 	@w_rfc_c = en_rfc,
				@w_curp_c = en_ced_ruc,
				@w_nom_aux		=	en_nombre,
				@w_p_apellido = p_p_apellido,
				@w_s_apellido = p_s_apellido,				
				@w_s_nombre   = p_s_nombre
		from cl_ente
		where en_ente = @i_persona
		
		if(@i_p_apellido <> @w_p_apellido OR @i_s_apellido <> @w_s_apellido OR @w_nom_aux <> @i_nombre OR @i_segnombre <> @w_s_nombre)
		begin
		
			if SUBSTRING(@w_rfc_c,0,11) <> SUBSTRING(@o_rfc,0,11)
			begin		
				exec sp_cerror
							@t_debug = @t_debug,
							@t_file  = @t_file,
							@t_from  = @w_sp_name,
							@i_num   = 101043,
							@i_msg	 = 'Cambio no procede por estructura de RFC'
				 return 101043			
			end	

			if SUBSTRING(@w_curp_c,0,17) <> SUBSTRING(@o_curp,0,17)
			begin		
				exec sp_cerror
							@t_debug = @t_debug,
							@t_file  = @t_file,
							@t_from  = @w_sp_name,
							@i_num   = 101043,
							@i_msg	 = 'Cambio no procede por estructura de CURP'
				 return 101043			
			end	
		end
		select @i_nit = @o_rfc
		select @i_cedula = @o_curp
	end
    else
	begin
		if not exists (select 1 from cobis..cl_ente 
		where en_ente    = @i_persona 
		and isnull(en_nombre,'')    = isnull(@i_nombre,'')
		and isnull(p_s_nombre,'')   = isnull(@i_segnombre,'')
		and isnull(p_p_apellido,'') = isnull(@i_p_apellido,'')
		and isnull(p_s_apellido,'') = isnull(@i_s_apellido,'')
		and p_sexo       = @i_sexo
		and p_depa_nac   = @i_depa_nac) begin	 
		
		   select @w_nombres = @i_nombre + ' ' + isnull(@i_segnombre,'')
		   exec @w_return = cobis..sp_generar_curp
		   @i_primer_apellido       = @i_p_apellido,
		   @i_segundo_apellido      = @i_s_apellido,
		   @i_nombres               = @w_nombres,
		   @i_sexo                  = @i_sexo,
		   @i_fecha_nacimiento      = @i_fecha_nac,
		   @i_entidad_nacimiento    = @i_depa_nac,
		   @i_ente                  = @i_persona,
		   @o_mensaje               = @w_msg  out,
		   --@o_curp                  = @o_curp out,
		   @o_rfc                   = @o_rfc  out
			
		   if @w_return <> 0 begin
			  if not exists ( select 1 from cobis..cl_ente where en_ente = @i_persona and en_ced_ruc = @o_curp) begin
				 exec sp_cerror
							@t_debug = @t_debug,
							@t_file  = @t_file,
							@t_from  = @w_sp_name,
							@i_num   = @w_return
				 return @w_return
			end
		   end
		end
		else
		begin
			select @o_curp = en_ced_ruc,
					@o_rfc = en_rfc
			from cl_ente
			where en_ente    = @i_persona 
		end
	end
	
	/* Se reasigna oficial y oficina para que no se actualice */
	select 
	@i_oficial 			= oc_oficial,
	@w_login_oficia 	= fu_login,
	@i_oficina 			= fu_oficina
	from cobis..cc_oficial,
	    cobis..cl_funcionario,
	    cobis..cl_ente
	where en_oficial = oc_oficial
	and fu_funcionario= oc_funcionario
	and en_ente= @i_persona
	
   if @i_ea_tipo_discapacidad <>null
      begin
         --VALIDANDO QUE EL CODIGO DE CATALOGO DE DISCAPACIDAD SEA EL CORRECTO
         if not exists(select 1 
            from cl_tabla t,cl_catalogo c
            where t.tabla='cl_discapacidad'
            and c.tabla=t.codigo
            and c.codigo=@i_ea_tipo_discapacidad)
            begin
               exec sp_cerror
                  @t_debug   = @t_debug,
              @t_file      = @t_file,
                  @t_from      = @w_sp_name,
                  @i_num      = 101239                        
                  --CODIGO DE DISCAPACIDAD INCORRECTO
               return 1
            end
      end
	if @i_colectivo is not null
	begin
		--VALIDANDO QUE EL CODIGO DE CATALOGO DE COLECTIVO/TIPO DE MERCADO SEA EL CORRECTO
		if not exists(select 1 
			from cl_tabla t,cl_catalogo c
			where t.tabla='cl_tipo_mercado'
			and c.tabla=t.codigo
			and c.codigo=@i_colectivo)
		begin
			exec sp_cerror
				@t_debug   = @t_debug,
				@t_file      = @t_file,
				@t_from      = @w_sp_name,
				@i_num      = 103411                        
				--CODIGO DE TIPO DE MERCADO INCORRECTO
			return 1
		end
	end
	else
		select @i_colectivo = pa_char from cl_parametro 
		where pa_nemonico = 'CDDFCL' and pa_producto = 'CLI'
	
	if @i_nivel_colectivo is not null
	begin
		--VALIDANDO QUE EL CODIGO DE CATALOGO DE NIVEL CLIENTE/NIVEL COLECTIVO SEA EL CORRECTO
		if not exists(select 1 
			from cl_tabla t,cl_catalogo c
			where t.tabla='cl_nivel_cliente_colectivo'
			and c.tabla=t.codigo
			and c.codigo=@i_nivel_colectivo)
		begin
			exec sp_cerror
				@t_debug   = @t_debug,
				@t_file      = @t_file,
				@t_from      = @w_sp_name,
				@i_num      = 103412                        
				--CODIGO DE NIVEL DE CLIENTE INCORRECTO
			return 1
		end
	end
	else
		select @i_nivel_colectivo = pa_char from cl_parametro 
		where pa_nemonico = 'CDDFNC' and pa_producto = 'CLI'

    /* VERIFICAR QUE LA FECHA DEL PATRIMONIO BRUTO NO SEA MENOR QUE LA
       FECHA DE NACIMIENTO DEL CLIENTE.  M. SILVA.  01/12/1997.
       BCO. DEL ESTADO.  */     

    --SELECCIONAR LOS DATOS ANTERIORES DE LA PERSONA
    select  @w_nombre          = a.en_nombre,
      @w_p_apellido            = a.p_p_apellido,
      @w_s_apellido            = a.p_s_apellido,
      @w_sexo                  = a.p_sexo,
      @w_cedula                = a.en_ced_ruc,
      @w_tipo_ced              = a.en_tipo_ced,
      @w_pasaporte             = a.p_pasaporte,
      @w_pais                  = a.en_pais,
      @w_profesion             = a.p_profesion,
      @w_otro_profesion        = a.p_otro_profesion,
      @w_estado_civil          = a.p_estado_civil,
      @w_num_cargas            = a.p_num_cargas,
      @w_nivel_ing             = a.p_nivel_ing,
      @w_nivel_egr             = a.p_nivel_egr,
      @w_tipo                  = a.p_tipo_persona,
      @w_filial                = a.en_filial,
      @w_oficina               = a.en_oficina,
      @w_fecha_nac             = a.p_fecha_nac,
      @w_grupo                 = a.en_grupo,
      @w_oficial               = a.en_oficial,
      @w_oficial_sup           = a.en_oficial_sup,
      @w_retencion             = a.en_retencion,
      @w_actividad             = a.en_actividad,
      @w_comentario            = a.en_comentario,
      @w_fecha_emision         = a.p_fecha_emision,   
      @w_fecha_expira          = a.p_fecha_expira,   
      @w_asosciada             = a.en_asosciada,
      @w_tipo_vinculacion      = a.en_tipo_vinculacion,
      @w_vinculacion           = a.en_vinculacion,
      @w_sector                = a.en_sector,      
      @w_referido              = a.en_referido,      
      @w_nit                   = a.en_nit,      
      @w_ciudad_nac            = a.p_ciudad_nac,    
      @w_nivel_estudio         = a.p_nivel_estudio, 
      @w_tipo_vivienda         = a.p_tipo_vivienda, 
      @w_doc_validado          = a.en_doc_validado, 
      @w_calif_cliente         = a.p_calif_cliente, 
      @w_lugar_doc             = a.p_lugar_doc ,
      @w_gran_contribuyente    = a.en_gran_contribuyente,
      @w_situacion_cliente     = a.en_situacion_cliente,
      @w_patrim_tec            = a.en_patrimonio_tec,
      @w_fecha_patrim_bruto    = a.en_fecha_patri_bruto,
      @w_total_activos         = a.c_total_activos,
      @w_rep_superban          = a.en_rep_superban,
      @w_preferen              = a.en_preferen,   
      @w_exc_sipla             = a.en_exc_sipla,
      @w_exc_por2      = a.en_exc_por2,
      @w_digito                = a.en_digito,
      @w_nomlar                = a.en_nomlar,
      @w_cem                   = a.en_cem,
      @w_c_apellido            = a.p_c_apellido,
      @w_s_nombre              = a.p_s_nombre,    
      @w_depart_doc            = a.p_dep_doc,   
      @w_numord                = a.p_numord,        
      @w_promotor              = a.en_promotor,
      @w_num_pais_nacionalidad = a.en_nacionalidad,
      @w_cod_otro_pais         = a.en_cod_otro_pais, 
      @w_inss                  = a.en_inss,          
      @w_licencia              = a.en_licencia,      
      @w_ingre                 = a.en_ingre,        
      @w_en_id_tutor           = a.en_id_tutor,
      @w_en_nom_tutor          = a.en_nom_tutor,
      @w_categoria             = a.en_concordato, --CVA Abr-23-07
      @w_referidor_ecu         = a.en_referidor_ecu,
      @w_carg_pub              = a.p_carg_pub,
      @w_rel_carg_pub          = a.p_rel_carg_pub,
      @w_situacion_laboral     = a.p_situacion_laboral,  -- ini CL00031 RVI
      @w_bienes                = a.p_bienes,
      @w_otros_ingresos        = a.en_otros_ingresos,
      @w_origen_ingresos       = a.en_origen_ingresos ,     -- fin CL00031 RVI}
      @w_tipo_compania         = a.c_tipo_compania, -- PJI CC-CTA-220
      @w_banco                 = a.en_banco,
      @w_calificacion          = a.en_calificacion
    from cl_ente a
    where a.en_ente = @i_persona
      and a.en_subtipo = 'P'

    if @@rowcount = 0
    begin
      exec sp_cerror
        @t_debug      = @t_debug,
    @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_num       = 101043
        --NO EXISTE PERSONA
      return 1
    end

	  /*Control para CURP*/
	  if((@w_cedula <> @i_cedula) or (@w_nit <> @i_nit))
	  begin
	      insert into cl_modificacion_curp_rfc (mcr_ente,     mcr_ssn_user,  mcr_ssn_oficina,
		                                        mcr_fecha,    mcr_oficial ,  mcr_oficina    ,
												mcr_curp_ant, mcr_rfc_ant ,  mcr_curp       ,
												mcr_rfc,      mcr_operacion, mcr_sp)
                                        values (@i_persona,   @s_user     ,  @s_ofi         ,
										        getdate(),    @w_oficial  ,  @w_oficina     ,
												@w_cedula,    @w_nit      ,  @i_cedula,
												@i_nit,       @i_operacion,  @w_sp_name)
  	     if(len(@i_cedula) < 18)
		 select @i_cedula = @w_cedula
	  end
  /*Fin Control para CURP*/
  
    select
         @w_ea_estado                     = b.ea_estado,
         --@w_ea_observacion_aut        = b.ea_observacion_aut,
         @w_ea_contrato_firmado         = b.ea_contrato_firmado,
         @w_ea_menor_edad               = b.ea_menor_edad, 
         @w_ea_conocido_como            = b.ea_conocido_como,
         @w_ea_cliente_planilla         = b.ea_cliente_planilla,
         @w_ea_cod_risk                 = b.ea_cod_risk,
         @w_ea_sector_eco               = b.ea_sector_eco,
         @w_ea_actividad                = b.ea_actividad,
         @w_ea_empadronado              = 'N',--b.ea_empadronado,
         @w_ea_lin_neg                  = b.ea_lin_neg,
         @w_ea_seg_neg                  = b.ea_seg_neg,
         @w_ea_val_id_check             = 'N',--b.ea_val_id_check,
         @w_ea_ejecutivo_con            = b.ea_ejecutivo_con,
         @w_ea_suc_gestion              = b.ea_suc_gestion,
         @w_ea_constitucion             = b.ea_constitucion,
         @w_ea_remp_legal               = b.ea_remp_legal,
         @w_ea_apoderado_legal          = b.ea_apoderado_legal,
         @w_ea_act_comp_kyc             = 'N',--b.ea_act_comp_kyc,
         @w_ea_fecha_act_kyc            = @w_today,--b.ea_fecha_act_kyc,
         @w_ea_no_req_kyc_comp          = 'N',--b.ea_no_req_kyc_comp,
         @w_ea_act_perfiltran           = 'N',--b.ea_act_perfiltran,
         @w_ea_fecha_act_perfiltran     = @w_today,--b.ea_fecha_act_perfiltran,
         @w_ea_con_salario              = 'N',--b.ea_con_salario,
         @w_ea_fecha_consal             = @w_today,--b.ea_fecha_consal,
         @w_ea_sin_salario              = 'N',--b.ea_sin_salario,
         @w_ea_fecha_sinsal             = @w_today,--b.ea_fecha_sinsal,
         @w_ea_actualizacion_cic        = 'N',--b.ea_actualizacion_cic,
         @w_ea_fecha_act_cic            = @w_today,--b.ea_fecha_act_cic,
         @w_ea_fuente_ing               = b.ea_fuente_ing,
         @w_ea_act_prin                 = b.ea_act_prin,
         @w_ea_detalle                  = b.ea_detalle,
         @w_ea_act_dol                  = b.ea_act_dol,
         @w_ea_cat_aml                  = b.ea_cat_aml,
         @w_ea_observacion_vincula      = b.ea_observacion_vincula,
         @w_ea_fecha_vincula            = b.ea_fecha_vincula,
         @w_ea_discapacidad             = b.ea_discapacidad,
         @w_ea_tipo_discapacidad    = b.ea_tipo_discapacidad,
         @w_ea_ced_discapacidad         = b.ea_ced_discapacidad,
         @w_asfi                        = b.ea_asfi,
         @w_egresos                     = b.ea_nivel_egresos,
         @w_ifi                         = b.ea_ifi,
         @w_path_foto                   = b.ea_path_foto,
         @w_nit_id                      = b.ea_nit,
         @w_nit_venc                    = b.ea_nit_venc,
         @w_ea_indefinido               = b.ea_indefinido,
         @w_estado_std                  = b.ea_estado_std,
         @w_ea_colectivo                = b.ea_colectivo,
         @w_ea_nivel_colectivo          = b.ea_nivel_colectivo		 
    from cobis..cl_ente_aux b
    where b.ea_ente = @i_persona   
    	   
    if @@rowcount = 0
    begin
      --SI NO EXISTE EN CL_ENTE_AUX, CREO EL REGISTRO VACIO PARA EVITAR INCONSISTENCIAS
    insert into cobis..cl_ente_aux (ea_ente, ea_estado) values (@i_persona, @w_estado_ente)
  
      if @@error <> 0
      begin
        exec sp_cerror
             @t_debug    = @t_debug,
             @t_file     = @t_file,
             @t_from     = @w_sp_name,
             @i_num      = 151030
             --NO EXISTE COMPANIA
        return 1
      end
    end   
	
	if exists(select 1 from cobis..cl_direccion where di_ente = @i_persona and di_tipo <> 'CE' and di_referencia is null )
			begin
				exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file  = @t_file,
					@t_from  = @w_sp_name,
				 @i_num   = 70075
            /* El campo de referencia es obligatorio */
            return 0	
			end
			
			if not exists (select 1 from cobis..cl_direccion where di_ente = @i_persona and di_tipo = 'RE'  ) 
			begin
				exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file  = @t_file,
					@t_from  = @w_sp_name,
				 @i_num   = 103173
            /* la direccion de domicilio ES obligatorio */
            return 0	
			end
			
			if not exists (select 1 from cobis..cl_direccion where di_ente = @i_persona and di_tipo = 'AE'  ) 
			begin
				exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file  = @t_file,
					@t_from  = @w_sp_name,
				 @i_num   = 103174
            /* la direccion de NEGOCIO ES obligatorio */
            return 0	
			end

     
    if @i_ejecutar = 'N'
    begin
      if (@i_fecha_nac is null) or (@i_fecha_nac = '') or (@i_fecha_nac = '1/1/1900')
      begin   
        select @w_paso = 'S'
        exec cobis..sp_cerror
             @t_debug    = @t_debug,
             @t_file     = @t_file,
             @t_from     = @w_sp_name,
             @i_num      = 101113,
             @i_msg      = 'Verificar fecha de nacimiento'             
             --FALTA FECHA DE NACIMIENTO
        return 1   
      end

     if datediff(yy,@i_fecha_nac,@s_date) < @w_mayoria_edad 
        select @w_es_mayor_edad = 'N'
      else
        if datediff(yy,@i_fecha_nac,@s_date) > @w_mayoria_edad 
          select @w_es_mayor_edad = 'S'
     else
      begin       --CASO EN QUE EN EL ANIO PRESENTE CUMPLIRIA LA MAYORIA DE EDAD
         select  @w_anio_nac=convert(char(4),datepart(yy,@i_fecha_nac)),
            @w_anio_act=convert(char(4),datepart(yy,@s_date))

         select  @w_inic_anio_nac=convert(datetime,'01/01/'+@w_anio_nac,101),
            @w_inic_anio_act=convert(datetime,'01/01/'+@w_anio_act,101)

         select  @w_dias_anio_nac=datediff(dd,@w_inic_anio_nac,@i_fecha_nac),
            @w_dias_anio_act=datediff(dd,@w_inic_anio_act,@s_date)

         if @w_dias_anio_act >= @w_dias_anio_nac --YA CUMPLIO LA MAYORIA DE EDAD
            select @w_es_mayor_edad='S'
         else 
            select @w_es_mayor_edad='N'
      end

  if @w_paso = 'S'   --CAMBIO TRANSITORIO
     select @i_fecha_nac = null   --CAMBIO TRANSITORIO

 if (@i_pasaporte is null and @i_cedula is null) and @w_es_mayor_edad = 'S'
   begin   
      exec cobis..sp_cerror
           @t_debug    = @t_debug,
           @t_file     = @t_file,
           @t_from     = @w_sp_name,
           @i_num      = 101114
           --FALTA CEDULA DE IDENTIDAD
      return 1
   end
   
   --VERIFICAR QUE EL SEXO DE LA PERSONA
   --if NOT (@I_SEXO = 'F' OR @I_SEXO = 'M')
   select @w_codigo = null
     from cl_catalogo
    where codigo like @i_sexo
      and tabla = (select codigo
                     from cl_tabla
                    where tabla = 'cl_sexo')
   if @@rowcount = 0
      begin
         exec sp_cerror  @t_debug    = @t_debug,
              @t_file     = @t_file,
              @t_from     = @w_sp_name,
              @i_num      = 101022
              --NO EXISTE SEXO
         return 1
      end

   --VERIFICAR LA PROFESION DE LA PERSONA
   if @i_profesion is not null
   begin
      select @w_codigo = null
        from cl_catalogo
       where codigo = convert(char(10),@i_profesion)
         and tabla  = (select codigo
                         from cl_tabla
                        where tabla = 'cl_profesion')
     if @@rowcount = 0
        begin
         exec sp_cerror
              @t_debug    = @t_debug,
              @t_file     = @t_file,
              @t_from     = @w_sp_name,
              @i_num      = 101019
     --NO EXISTE PROFESION
         return 1
       end
   end

   --VERIFICAR SI EXISTE EL PAIS
   if @i_pais is not null
   begin
      select @w_codigo = null
        from cl_pais
       where pa_pais = @i_pais
      if @@rowcount = 0
      begin
         exec sp_cerror
              @t_debug    = @t_debug,
              @t_file     = @t_file,
              @t_from     = @w_sp_name,
              @i_num      = 101018
              /* 'No existe pais'*/
         return 1
       end
   end

    --VERIFICAR QUE EXISTA EL ESTADO CIVIL
   if @i_estado_civil is not null
   begin   
      select @w_codigo = null
        from cl_catalogo
       where codigo like @i_estado_civil
         and tabla  = (select codigo
             from cl_tabla
                     where tabla = 'cl_ecivil')
if @@rowcount = 0
       begin
         exec sp_cerror
              @t_debug    = @t_debug,
              @t_file     = @t_file,
              @t_from     = @w_sp_name,
              @i_num      = 101020
              --NO EXISTE ESTADO CIVIL
         return 1
        end
   end
    --VERIFICAR EL TIPO DE PERSONA
   if @i_tipo is not null
   begin
       select @w_codigo = null
         from cl_catalogo
        where codigo = @i_tipo
          and tabla  = (select codigo
                  from   cl_tabla
               where  tabla = 'cl_ptipo')
       if @@rowcount = 0
       begin
         exec sp_cerror
              @t_debug    = @t_debug,
              @t_file     = @t_file,
              @t_from     = @w_sp_name,
           @i_num      = 101021
              --NO EXISTE TIPO DE PERSONA
         return 1
       end
   end

   if @i_actividad is not null
   begin
   --VERIFICAR QUE EXISTA EL TIPO DE ACTIVIDAD

   select @w_codigo = null
     from cl_actividad_ec
    where ac_codigo = @i_actividad

   if @@rowcount = 0 
   begin
   exec sp_cerror
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num      = 101027
        --NO EXISTE TIPO DE ACTIVIDAD
   return 1
   end
end

   --VERIFICAR QUE EXISTA EL SECTOR ECONOMICO
   if @i_sector is not null
   begin
      select @w_codigo = null
        from cl_catalogo
       where codigo = @i_sector
         and tabla  = (select codigo 
                       from cl_tabla 
                       where tabla = 'cl_sectoreco')

      if @@rowcount = 0 
      begin
         exec sp_cerror
              @t_debug    = @t_debug,
              @t_file     = @t_file,
              @t_from     = @w_sp_name,
              @i_num      = 101048
              --NO EXISTE SECTOR ECONOMICO
         return 1
      end
   end

   --VERIFICAR QUE EXISTA EL PROMOTOR
   if @i_promotor is not null
   begin
      select @w_codigo = null
        from cl_catalogo
       where codigo = @i_promotor
         and tabla  = (select codigo 
                           from cl_tabla 
                              where tabla = 'cl_promotor')

      if @@rowcount = 0 
      begin
         exec sp_cerror
              @t_debug    = @t_debug,
              @t_file     = @t_file,
              @t_from     = @w_sp_name,
              @i_num      = 107108
              --NO EXISTE PROMOTOR
         return 1
      end
   end

   --VERIFICAR QUE EXISTA INGRESOS
   if @i_ingre is not null
   begin
      select @w_codigo = null
        from cl_catalogo
       where codigo = @i_ingre
         and tabla  = (select codigo
                           from cl_tabla 
                              where tabla = 'cl_ingresos')

      if @@rowcount = 0 
      begin
         exec sp_cerror
              @t_debug    = @t_debug,
              @t_file     = @t_file,
              @t_from     = @w_sp_name,
              @i_num      = 107108
              --NO EXISTE INGRESOS
          return 1
      end
   end
   --VERIFICAR SI EXISTE LA CIUDAD DE NACIMIENTO
   if @i_ciudad_nac <> null  and @i_valprov ='N'
   begin
      if not exists ( select 1
                        from cl_pais
                       where pa_pais = @i_ciudad_nac)
      begin
         exec sp_cerror
              @t_debug    = @t_debug,
              @t_file     = @t_file,
              @t_from     = @w_sp_name,
              @i_num      = 101018
              --NO EXISTE PAIS'
         return 1
      end
   end

   if @i_ciudad_nac <> null  and @i_valprov ='S'
   begin
      if not exists ( select 1
                        from cl_ciudad
                       where ci_ciudad = @i_ciudad_nac)
      begin
         exec sp_cerror   
              @t_debug   = @t_debug,
              @t_file    = @t_file,
              @t_from    = @w_sp_name,
              @i_num     = 101024
              --NO EXISTE CIUDAD
         return 1
      end
   end   
   
   if @i_nivel_estudio is not null
   begin
      select @w_codigo = null
        from cl_catalogo
       where codigo = convert(char(10), @i_nivel_estudio)
        and tabla  = (select codigo
                        from cl_tabla
                       where tabla = 'cl_nivel_estudio')
       if @@rowcount = 0
       begin
          exec sp_cerror
               @t_debug    = @t_debug,
               @t_file     = @t_file,
               @t_from     = @w_sp_name,
               @i_num      = 101170
               --NO EXISTE NIVEL DE ESTUDIO
          return 1
       end
   end
   if @i_tipo_vivienda is not null
   begin
      select @w_codigo = null
        from cl_catalogo
       where codigo = convert(char(10), @i_tipo_vivienda)
         and tabla  = (select codigo
                         from cl_tabla
                        where tabla = 'cl_tipo_vivienda')
       if @@rowcount = 0
       begin
          exec sp_cerror
               @t_debug    = @t_debug,
               @t_file     = @t_file,
               @t_from     = @w_sp_name,
               @i_num      = 101171
               --NO EXISTE TIPO DE VIVENDA
          return 1
       end
   end

   if @i_tipo_vinculacion is not null
   begin
      select @w_codigo = null
        from cl_catalogo
       where codigo = convert(char(10), @i_tipo_vinculacion)
         and tabla  = (select codigo
                         from cl_tabla
                        where tabla = 'cl_relacion_banco')
       if @@rowcount = 0
       begin
          exec sp_cerror
               @t_debug    = @t_debug,
               @t_file     = @t_file,
               @t_from     = @w_sp_name,
               @i_num      = 101173
               --NO EXISTE ESA RELACION CON EL BANCO
          return 1
       end
   end

  --VERIFICAR QUE EXISTA EL OFICIAL INDICADO
  select @w_codigo = null
    from cc_oficial
   where oc_oficial = @i_oficial

  if @@rowcount = 0 and @i_oficial is not null
  begin
     exec sp_cerror
          @t_debug    = @t_debug,
          @t_file     = @t_file,
          @t_from     = @w_sp_name,
          @i_num      = 101036
          --NO EXISTE OFICIAL
     return 1
  end

  --VERIFICAR QUE EXISTA EL OFICIAL SUPLENTE INDICADO
  select @w_codigo = null
    from cc_oficial
   where oc_oficial = @i_oficial_sup

  if @@rowcount = 0 and @i_oficial_sup is not null
  begin
     exec sp_cerror
          @t_debug    = @t_debug,
          @t_file     = @t_file,
          @t_from     = @w_sp_name,
          @i_num      = 101036
          --NO EXISTE OFICIAL
     return 1
  end

   --SI EXISTE CODIGO DE GRUPO, ASEGURARSE DE QUE EXISTA

  if @i_grupo is not null
  begin
     if not exists ( select 1
                       from cl_grupo
                      where gr_grupo = @i_grupo )
     begin
        exec sp_cerror  
               @t_debug    = @t_debug,
             @t_file     = @t_file,
             @t_from     = @w_sp_name,
             @i_num      = 151029
             /*'No existe grupo'*/
         return 1
     end
             
     --VERIFICAR QUE EL OFICIAL SEA EL MISMO DEL GRUPO
     select @w_codigo = null
       from cl_grupo
      where gr_grupo = @i_grupo
        and gr_oficial = @i_oficial

   end

  if @i_retencion not in ('N', 'S')
  begin
    -- print 'Linea 1037'
     exec sp_cerror  
           @t_debug    = @t_debug,
          @t_file     = @t_file,
           @t_from     = @w_sp_name,
           @i_num      = 101114
           --PARAMETRO INVALIDO
     return 1
  end

  /*if @i_exc_sipla not in ('N', 'S')
  begin     
     exec sp_cerror  
          @t_debug    = @t_debug,
          @t_file     = @t_file,
          @t_from     = @w_sp_name,
          @i_num      = 101114
          --PARAMETRO INVALIDO
      return 1
  end*/ 

   --CONTROL DE DATOS EN CATALOGOS
   if @i_depart_doc is not null
   begin
      select @w_codigo = null
        from cl_catalogo
       where codigo = convert(char(10),@i_depart_doc)
         and tabla  = (select codigo
                         from cl_tabla
                        where tabla = 'cl_provincia')

      if @@rowcount = 0 
      begin
         exec sp_cerror
              @t_debug    = @t_debug,
              @t_file     = @t_file,
              @t_from     = @w_sp_name,
              @i_num      = 101000
              --NO EXISTE DATO EN CATALOGO
         return 1
      end
   end
   end
      --ARMADO DEL NOMBRE LARGO DEL CLIENTE, TOMANDO EN CUENTA SI ES CASADA, VIUDA O MENOR DE EDAD
select @i_sexo = isnull(@i_sexo, p_sexo), 
        @i_estado_civil = isnull(@i_estado_civil, p_estado_civil) 
  from cl_ente where en_ente = @i_persona and en_subtipo = 'P'


      if @i_segnombre <> null
         select @w_s_nombre_t = ' '+ @i_segnombre
      
      if @i_s_apellido <> null
         select @w_s_apellido_t = ' '+ @i_s_apellido
if @i_sexo = 'F'
   begin
      If @w_estados like '%'+@i_estado_civil+'%' and @i_estado_civil <>@w_nemovda--inc 69991 si estado civil es casada o divorciada y diferente de viuda
         begin              
             --select @w_nombre_completo = isnull(@i_nombre, en_nombre) + ' ' + isnull(p_s_nombre, @i_segnombre) + ' ' + isnull(@i_p_apellido, p_p_apellido) + ' ' + isnull(@i_s_apellido, p_s_apellido) + ' de ' + isnull(@i_c_apellido, p_c_apellido) from cl_ente whe
            if  @i_c_apellido is null
                  select @w_nombre_completo = isnull(@i_nombre, en_nombre) + @w_s_nombre_t + ' ' + isnull(@i_p_apellido, p_p_apellido) + @w_s_apellido_t  from cl_ente where en_ente = @i_persona and en_subtipo = 'P'
            else 
                  select @w_nombre_completo = isnull(@i_nombre, en_nombre) + @w_s_nombre_t + ' ' + isnull(@i_p_apellido, p_p_apellido) + @w_s_apellido_t + ' DE ' + @i_c_apellido from cl_ente where en_ente = @i_persona and en_subtipo = 'P'

         end 
      else if @i_estado_civil = @w_nemovda --68572
         begin
            if @i_c_apellido is null
                select @w_nombre_completo = isnull(@i_nombre, en_nombre) + ' ' + isnull(p_s_nombre, @i_segnombre) + ' ' + isnull(@i_p_apellido, p_p_apellido) + ' ' + isnull(@i_s_apellido, p_s_apellido) from cl_ente where en_ente = @i_persona and en_subtipo = 'P'
            else
                select @w_nombre_completo = isnull(@i_nombre, en_nombre) + ' ' + isnull(p_s_nombre, @i_segnombre) + ' ' + isnull(@i_p_apellido, p_p_apellido) + ' ' + isnull(@i_s_apellido, p_s_apellido) + ' VDA. DE ' + isnull(@i_c_apellido, p_c_apellido) from cl_ente 
         end
      else If @i_estado_civil = @w_nemomed
         begin
            --select @w_nombre_completo = isnull(@i_nombre, en_nombre) + ' ' + isnull(p_s_nombre, @i_segnombre) + ' ' + isnull(@i_p_apellido, p_p_apellido) + ' ' + isnull(@i_s_apellido, p_s_apellido)+ ' (MENOR) ' from cl_ente where en_ente = @i_persona an
            select @w_nombre_completo = isnull(@i_nombre, en_nombre) + @w_s_nombre_t + ' ' + isnull(@i_p_apellido, p_p_apellido) + @w_s_apellido_t + ' (MENOR) ' from cl_ente where en_ente = @i_persona and en_subtipo = 'P'
         end
      else
         begin
            --select @w_nombre_completo = isnull(@i_nombre, en_nombre) + ' ' + isnull(p_s_nombre, @i_segnombre) + ' ' + isnull(@i_p_apellido, p_p_apellido) + ' ' + isnull(@i_s_apellido, p_s_apellido) from cl_ente where en_ente = @i_persona and en_subtipo 
            select @w_nombre_completo = isnull(@i_nombre, en_nombre) + @w_s_nombre_t + ' ' + isnull(@i_p_apellido, p_p_apellido) + @w_s_apellido_t from cl_ente where en_ente = @i_persona and en_subtipo = 'P'
         end
   end 
else
   begin
     If @i_estado_civil = @w_nemomed
        begin
           --select @w_nombre_completo = isnull(@i_nombre, en_nombre) + ' ' + isnull(p_s_nombre, @i_segnombre) + ' ' + isnull(@i_p_apellido, p_p_apellido) + ' ' + isnull(@i_s_apellido, p_s_apellido) + ' (MENOR) ' from cl_ente where en_ente = @i_persona an
           select @w_nombre_completo = isnull(@i_nombre, en_nombre) + @w_s_nombre_t + ' ' + isnull(@i_p_apellido, p_p_apellido) + @w_s_apellido_t + ' (MENOR) ' from cl_ente where en_ente = @i_persona and en_subtipo = 'P'
        end
     else
        begin
           --select @w_nombre_completo = isnull(@i_nombre, en_nombre) + ' ' + isnull(p_s_nombre, @i_segnombre) + ' ' + isnull(@i_p_apellido, p_p_apellido) + ' ' + isnull(@i_s_apellido, p_s_apellido) from cl_ente where en_ente = @i_persona and en_subtipo =
           select @w_nombre_completo = isnull(@i_nombre, en_nombre) + @w_s_nombre_t + ' ' + isnull(@i_p_apellido, p_p_apellido) + @w_s_apellido_t from cl_ente where en_ente = @i_persona and en_subtipo = 'P'
        end
   end
 --if @I_EJECUTAR = 'N'
   --CAPTURAR LOS DATOS QUE HAN CAMBIADO
    select 
           @v_nombre                   = @w_nombre,
           @v_p_apellido               = @w_p_apellido,
           @v_s_apellido               = @w_s_apellido,
           @v_sexo                     = @w_sexo,
           @v_cedula                   = @w_cedula,
           @v_pasaporte                = @w_pasaporte,
           @v_pais                     = @w_pais,
           @v_profesion                = @w_profesion,
           @v_otro_profesion           = @w_otro_profesion,
           @v_estado_civil             = @w_estado_civil,
           @v_num_cargas               = @w_num_cargas,   
           @v_nivel_ing                = @w_nivel_ing,
           @v_nivel_egr                = @w_nivel_egr,
           @v_tipo                     = @w_tipo,
           @v_fecha_nac                = @w_fecha_nac,
           @v_grupo                    = @w_grupo,
           @v_oficial                  = @w_oficial,
           @v_oficial_ant              = @w_oficial,
           @v_oficial_sup              = @w_oficial_sup,
           @v_oficial_sup_ant          = @w_oficial_sup,
           @v_retencion                = @w_retencion,
           @v_exc_sipla                = @w_exc_sipla,
           @v_exc_por2                 = @w_exc_por2,
           @v_actividad                = @w_actividad,
           @v_comentario               = @w_comentario,
           @v_fecha_emision            = @w_fecha_emision,   
           @v_fecha_expira             = @w_fecha_expira,   
           @v_tipo_ced                 = @w_tipo_ced,
           @v_asosciada                = @w_asosciada,
           @v_tipo_vinculacion         = @w_tipo_vinculacion,
           @v_referido                 = @w_referido,      
           @v_nit                      = @w_nit,      
           @v_sector                   = @w_sector,      
           @v_ciudad_nac               = @w_ciudad_nac,   
           @v_nivel_estudio            = @w_nivel_estudio,   
           @v_tipo_vivienda            = @w_tipo_vivienda,   
           @v_doc_validado             = @w_doc_validado,   
           @v_calif_cliente            = @w_calif_cliente,   
           @v_lugar_doc                = @w_lugar_doc,      
           @v_total_activos            = @w_total_activos,
           @v_rep_superban             = @w_rep_superban,
           @v_preferen                 = @w_preferen,
           @v_digito                   = @w_digito,
           @v_nomlar                   = @w_nomlar,
           @v_cem                      = @w_cem,
           @v_situacion_cliente        = @w_situacion_cliente  ,
           @v_c_apellido               = @w_c_apellido,  
           @v_s_nombre                 = @w_s_nombre,
           @v_depart_doc               = @w_depart_doc, 
           @v_numord                   = @w_numord,
           @v_promotor                 = @w_promotor,
           @v_num_pais_nacionalidad    = @w_num_pais_nacionalidad, 
           @v_cod_otro_pais            = @w_cod_otro_pais,
           @v_inss                     = @w_inss,
           @v_licencia                 = @w_licencia,  
           @v_ingre                    = @w_ingre,  
           @v_en_id_tutor              = @w_en_id_tutor,   
           @v_en_nom_tutor             = @w_en_nom_tutor,
           @v_categoria                = @w_categoria,   --CVA Abr-23-07
           @v_situacion_laboral        = @w_situacion_laboral,   -- ini CL00031 RVI
           @v_bienes                   = @w_bienes,
           @v_otros_ingresos           = @w_otros_ingresos,
           @v_origen_ingresos          = @w_origen_ingresos,     -- fin CL00031 RVI
           @v_ea_indefinido            = @w_ea_indefinido,
        @v_banco                    = @w_banco

--CAPTURAR LOS DATOS GRABADOS ANTERIORMENTE
   select 
           @v_ea_estado                 =    @w_ea_estado,
           --@v_ea_observacion_aut           =    @w_ea_observacion_aut,
           @v_ea_contrato_firmado       =    @w_ea_contrato_firmado,
           @v_ea_menor_edad             =    @w_ea_menor_edad,
           @v_ea_conocido_como          =    @w_ea_conocido_como,
           @v_ea_cliente_planilla       =    @w_ea_cliente_planilla,
           @v_ea_cod_risk               =    @w_ea_cod_risk,
           @v_ea_sector_eco             =    @w_ea_sector_eco,
           @v_ea_actividad              =    @w_ea_actividad,
           @v_ea_empadronado            =    @w_ea_empadronado,
           @v_ea_lin_neg                =    @w_ea_lin_neg,
           @v_ea_seg_neg                =    @w_ea_seg_neg,
           @v_ea_val_id_check           =    @w_ea_val_id_check,
           @v_ea_ejecutivo_con          =    @w_ea_ejecutivo_con,
           @v_ea_suc_gestion            =    @w_ea_suc_gestion,
           @v_ea_constitucion           =    @w_ea_constitucion,
           @v_ea_remp_legal             =    @w_ea_remp_legal,
           @v_ea_apoderado_legal        =    @w_ea_apoderado_legal,
           @v_ea_act_comp_kyc           =    @w_ea_act_comp_kyc,
           @v_ea_fecha_act_kyc          =    @w_ea_fecha_act_kyc,
           @v_ea_no_req_kyc_comp        =    @w_ea_no_req_kyc_comp,
           @v_ea_act_perfiltran         =    @w_ea_act_perfiltran,
           @v_ea_fecha_act_perfiltran   =    @w_ea_fecha_act_perfiltran,
           @v_ea_con_salario            =    @w_ea_con_salario,
           @v_ea_fecha_consal           =    @w_ea_fecha_consal,
           @v_ea_sin_salario            =    @w_ea_sin_salario,
           @v_ea_fecha_sinsal           =    @w_ea_fecha_sinsal,
           @v_ea_actualizacion_cic      =    @w_ea_actualizacion_cic,
           @v_ea_fecha_act_cic          =    @w_ea_fecha_act_cic,
           @v_ea_fuente_ing             =    @w_ea_fuente_ing,
           @v_ea_act_prin               =    @w_ea_act_prin,
           @v_ea_detalle                =    @w_ea_detalle,
           @v_ea_act_dol                =    @w_ea_act_dol,
           @v_ea_cat_aml                =    @w_ea_cat_aml,
           @v_ea_observacion_vincula    =    @w_ea_observacion_vincula,
           @v_ea_fecha_vincula          =    @w_ea_fecha_vincula,
           @v_oficina                   =    @w_oficina,
           @v_ea_discapacidad           =    @w_ea_discapacidad,
           @v_ea_tipo_discapacidad      =    @w_ea_tipo_discapacidad,
           @v_ea_ced_discapacidad       =    @w_ea_ced_discapacidad,
           @v_asfi                      =    @w_asfi,
           @v_egresos                   =    @w_egresos,
           @v_ifi                       =    @w_ifi,
           @v_path_foto                 =    @w_path_foto,
           @v_nit_id                    =    @w_nit_id,
           @v_nit_venc                  =    @w_nit_venc,
           @v_ea_indefinido             =    @w_ea_indefinido,
           @v_ea_colectivo              =    @w_ea_colectivo,
           @v_ea_nivel_colectivo        =    @w_ea_nivel_colectivo          
             
 if @w_nombre = @i_nombre       
   select @w_nombre = null, @v_nombre = null
 else                
     select @w_nombre = @i_nombre

 if @w_p_apellido = @i_p_apellido     
   select @w_p_apellido = null, @v_p_apellido = null
 else                
   select @w_p_apellido = @i_p_apellido

 if @w_s_apellido = @i_s_apellido     
   select @w_s_apellido = null, @v_s_apellido = null 
 else               
   select @w_s_apellido = @i_s_apellido

 if @w_nomlar = @w_nombre_completo
   select @w_nomlar = null, @v_nomlar = null
 else
   select @w_nomlar = @w_nombre_completo
 
 if @w_sexo = @i_sexo   
   select @w_sexo = null, @v_sexo = null
 else             
   select @w_sexo = @i_sexo

 if @w_tipo_ced = @i_tipo_ced
   select @w_tipo_ced = null, @v_tipo_ced = null
 else
   select @w_tipo_ced = @i_tipo_ced
 
 if @w_ea_indefinido = @i_ea_indefinido
   select @w_ea_indefinido = null, @v_ea_indefinido = null
 else
   select @w_ea_indefinido = @i_ea_indefinido
   
 -- PJI CC-CTA-220   
 -- se verifica si el tipo de cTdula no es nulo, si se ha cambiado el mismo, = si el tipo de compañía está vacío
 if @i_tipo_ced is not null and (isnull(@w_tipo_ced, '') <> isnull(@v_tipo_ced,'') or isnull(@w_tipo_compania,'') = '')
 begin   
    -- Tipos de identificacion de personas nacionales
    if @i_tipo_ced in ('CI','CID','CIEE','CPN','ND','RUN')
     begin        
      select @w_nat_jur_hogar =pa_char 
      from cobis..cl_parametro 
      where pa_nemonico ='NAJUHO' 
      and pa_producto ='CLI'  
    end       
    -- Tipos de identificacion de personas extranjeras    
    else if @i_tipo_ced in ('CIE','DCC','DCD','DCO','DCR','PAS','DE')
    begin    
      select @w_nat_jur_hogar =pa_char 
      from cobis..cl_parametro 
      where pa_nemonico ='NAJUHE' 
      and pa_producto ='CLI'  
    end
 end
 -- PJI CC-CTA-220
 
 if @w_cedula = @i_cedula      
   select @w_cedula = null, @v_cedula = null
 else             
   if @i_cedula <> null
   begin
     if @i_tipo_ced='CI'
     begin
     --VERIFICAR QUE NO ESTE PREVIAMENTE INSERTADA UNA PERSONA
       if exists (select  en_ente
          from  cl_ente where  en_ced_ruc =  @i_cedula and 
                 en_tipo_ced=@i_tipo_ced
                 and en_ente <> @i_persona        --Vivi, para que no valide contra la misma persona
        --         and p_lugar_doc =@i_lugar_doc
                 and en_subtipo = 'P'        
      )  and @i_cedula is not null and @i_cedula <> '          '
       
       begin
          exec sp_cerror  @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 101061
          --DATO YA EXISTE
          return 1
       end 
      end  --tipo=CI
      else
      begin
       if exists (select  en_ente
          from  cl_ente where  en_ced_ruc =  @i_cedula and 
                 en_tipo_ced=@i_tipo_ced
                 and en_ente <> @i_persona        --Vivi, para que no valide contra la misma persona
                 and en_subtipo = 'P'
      )  and @i_cedula is not null and @i_cedula <> '          '
       begin
          exec sp_cerror  @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 101061
          --DATO YA EXISTE
          return 1
       end 
      end
     select @w_cedula = @i_cedula        
     end --else

 if @w_pasaporte = @i_pasaporte  
   select @w_pasaporte = null, @v_pasaporte = null
 else   
   begin
       select @w_pasaporte = @i_pasaporte
       if exists ( select p_pasaporte  from cl_ente
               where en_subtipo  = 'P'
                 and en_pais     = @i_pais    
                       and p_pasaporte = @i_pasaporte )
       and @i_pasaporte <> null and @i_pasaporte <> '                    '
        begin
        exec sp_cerror  @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = 101155
      --YA EXISTE PERSONA CON ESE PASAPORTE
        return 1
        end
  end

 if @w_pais = @i_pais   
   select @w_pais = null, @v_pais = null
 else 
   select @w_pais = @i_pais
   
 if @w_profesion = @i_profesion      
   select @w_profesion = null, @v_profesion = null
 else   
   select @w_profesion = @i_profesion  
 
 if @w_otro_profesion = @i_otro_prof      
   select @w_otro_profesion = null, @v_otro_profesion = null
 else   
   select @w_otro_profesion = @i_otro_prof

 if @w_estado_civil = @i_estado_civil 
   select @w_estado_civil = null, @v_estado_civil = null
 else   
   select @w_estado_civil = @i_estado_civil
   
 if @w_tipo = @i_tipo         
   select @w_tipo = null, @v_tipo = null
 else
   select @w_tipo = @i_tipo
   
 if @w_fecha_nac = @i_fecha_nac 
   select @w_fecha_nac = null, @v_fecha_nac = null
 else                  
   select @w_fecha_nac = @i_fecha_nac
   
 if @w_grupo = @i_grupo 
   select    @w_grupo = null, @v_grupo = null
 else 
   select    @w_grupo = @i_grupo
   
 if @w_retencion = @i_retencion
    select    @w_retencion = null, @v_retencion = null
 else 
    select    @w_retencion = @i_retencion

 if @w_exc_sipla  = @i_exc_sipla 
    select    @w_exc_sipla = null, @v_exc_sipla = null
 else
    select    @w_exc_sipla = @i_exc_sipla      

 if @w_exc_por2  = @i_exc_por2
    select    @w_exc_por2 = null, @v_exc_por2 = null
 else
    select    @w_exc_por2 = @i_exc_por2

 if @w_nivel_ing  = @i_nivel_ing
    select    @w_nivel_ing = null, @v_nivel_ing = null
 else
    select    @w_nivel_ing = @i_nivel_ing 

 if @w_nivel_egr  = @i_nivel_egr
    select    @w_nivel_egr = null, @v_nivel_egr = null
 else
   select    @w_nivel_egr = @i_nivel_egr  

 if @w_actividad = @i_actividad
    select @w_actividad = null, @v_actividad = null
 else                
    select @w_actividad = @i_actividad
 
 if @w_situacion_cliente = @i_situacion_cliente
    select @w_situacion_cliente = null, @v_situacion_cliente = null
 else
    select @w_situacion_cliente = @i_situacion_cliente
 
 if @w_sector = @i_sector
    select @w_sector = null, @v_sector = null
 else                
    select @w_sector = @i_sector
 
 if @w_referido = @i_referido
    select @w_referido = null, @v_referido = null
 else                
    select @w_referido = @i_referido
 
 if @w_nit = @i_nit
    select @w_nit = null, @v_nit = null
 else                
    select @w_nit = @i_nit
 
 if @w_ciudad_nac = @i_ciudad_nac
    select @w_ciudad_nac = null, @v_ciudad_nac = null
 else                
    select @w_ciudad_nac = @i_ciudad_nac
 
 if @w_lugar_doc = @i_lugar_doc
    select @w_lugar_doc = null, @v_lugar_doc = null
 else                
    select @w_lugar_doc = @i_lugar_doc
 
 if @w_nivel_estudio = @i_nivel_estudio
    select @w_nivel_estudio = null, @v_nivel_estudio = null
 else                
    select @w_nivel_estudio = @i_nivel_estudio

 if @w_tipo_vivienda = @i_tipo_vivienda
    select @w_tipo_vivienda = null, @v_tipo_vivienda = null
 else                
    select @w_tipo_vivienda = @i_tipo_vivienda
 
 if @w_calif_cliente = @i_calif_cliente
    select @w_calif_cliente = null, @v_calif_cliente = null
 else                
    select @w_calif_cliente = @i_calif_cliente
 
 if @w_doc_validado = @i_doc_validado
    select @w_doc_validado = null, @v_doc_validado = null
 else                
    select @w_doc_validado = @i_doc_validado
 
 if @w_comentario = @i_comentario
    select @w_comentario = null, @v_comentario = null
 else                
    select @w_comentario = @i_comentario
 
 if @w_oficial = @i_oficial
    select @w_oficial = null, @v_oficial = null
 else                
    select @w_oficial = @i_oficial

 if @w_oficial_sup = @i_oficial_sup
    select @w_oficial_sup = null, @v_oficial_sup = null
 else                
    select @w_oficial_sup = @i_oficial_sup

 if @w_fecha_emision = @i_fecha_emision
    select @w_fecha_emision = null, @v_fecha_emision = null
 else
    select @w_fecha_emision = @i_fecha_emision
 
 if @w_fecha_expira = @i_fecha_expira
    select @w_fecha_expira = null, @v_fecha_expira  = null
 else
    select @w_fecha_expira = @i_fecha_expira
 
 if @w_num_cargas = @i_num_cargas
    select @w_num_cargas = null, @v_num_cargas  = null
 else
    select @w_num_cargas = @i_num_cargas
 
 if @w_asosciada = @i_asosciada
    select @w_asosciada = null, @v_asosciada  = null
 else
    select @w_asosciada = @i_asosciada

 if @w_tipo_vinculacion = @i_tipo_vinculacion
    select @w_tipo_vinculacion = null, @v_tipo_vinculacion  = null
 else
    select @w_tipo_vinculacion = @i_tipo_vinculacion

 if @w_vinculacion = @v_vinculacion
    select @v_vinculacion = null  
     
 if @w_rep_superban = @i_rep_superban
    select @w_rep_superban = null, @v_rep_superban  = null
 else
        select @w_rep_superban = @i_rep_superban  

 if @w_preferen = @i_preferen
        select @w_preferen = null, @v_preferen  = null
 else
        select @w_preferen = @i_preferen  

 if @w_digito = @i_digito
        select @w_digito = null, @v_digito = null
 else
        select @w_digito =  @i_digito 

 if @w_cem = @i_cem
        select @w_cem = null, @v_cem = null
 else
        select @w_cem =  @i_cem 

if @w_s_nombre = @i_segnombre        
   select @w_s_nombre = null, @v_s_nombre = null
 else                
     select @w_s_nombre = @i_segnombre

if @w_c_apellido = @i_c_apellido         
   select @w_c_apellido = null, @v_c_apellido = null
 else                
     select @w_c_apellido = @i_c_apellido 

if @w_depart_doc = @i_depart_doc         
   select @w_depart_doc = null, @v_depart_doc = null
 else                
     select @w_depart_doc = @i_depart_doc 

if @w_numord = @i_numord         
   select @w_numord = null, @v_numord = null
 else                
     select @w_numord = @i_numord 

if @w_promotor = @i_promotor 
   select @w_promotor = null, @v_promotor = null
 else                
     select @w_promotor = @i_promotor

if @w_num_pais_nacionalidad = @i_nacionalidad        
   select @w_num_pais_nacionalidad = null, @v_num_pais_nacionalidad = null
 else                
     select @w_num_pais_nacionalidad = @i_nacionalidad

if @w_cod_otro_pais = @i_codigo        
   select @w_cod_otro_pais = null, @v_cod_otro_pais = null
 else                
     select @w_cod_otro_pais = @i_codigo

if @w_inss= @i_inss        
   select @w_inss = null, @v_inss = null
 else                
     select @w_inss = @i_inss

if @w_licencia= @i_licencia        
   select @w_licencia = null, @v_licencia = null
 else          
     select @w_licencia = @i_licencia

if @w_ingre= @i_ingre        
   select @w_ingre = null, @v_ingre = null
 else                
     select @w_ingre = @i_ingre

if @w_en_id_tutor = @i_en_id_tutor        
   select @w_en_id_tutor = null, @v_en_id_tutor = null
 else                
     select @w_en_id_tutor = @i_en_id_tutor

if @w_en_nom_tutor = @i_en_nom_tutor        
   select @w_en_nom_tutor = null, @v_en_nom_tutor = null
 else                
     select @w_en_nom_tutor = @i_en_nom_tutor

  if @w_categoria = @i_categoria
     select @w_categoria = null, @v_categoria  = null
  else
     select @w_categoria = @i_categoria
  
  if @w_situacion_laboral = @i_situacion_laboral
     select @w_situacion_laboral = null, @v_situacion_laboral  = null
  else
     select @w_situacion_laboral = @i_situacion_laboral   
   
  if @w_bienes = @i_bienes
     select @w_bienes = null, @v_bienes  = null
  else
     select @w_bienes = @i_bienes
   
  if @w_otros_ingresos = @i_otros_ingresos
     select @w_otros_ingresos = null, @v_otros_ingresos  = null
  else
     select @w_otros_ingresos = @i_otros_ingresos
   
  if @w_origen_ingresos = @i_origen_ingresos
     select @w_origen_ingresos = null, @v_origen_ingresos  = null
  else
     select @w_origen_ingresos = @i_origen_ingresos   
  
   -- INICIO VALIDANDO CAMPOS CL_ENTE_AUX
   if @w_ea_estado = @i_ea_estado
      select @w_ea_estado = null, @v_ea_estado  = null
   else
      select @w_ea_estado = @i_ea_estado
       
   --if @w_ea_observacion_aut = @i_ea_observacion_aut
      --select @w_ea_observacion_aut = null, @v_ea_observacion_aut  = null
   --else
      --select @w_ea_observacion_aut = @i_ea_observacion_aut   

   if @w_ea_contrato_firmado = @i_ea_contrato_firmado
      select @w_ea_contrato_firmado = null, @v_ea_contrato_firmado  = null
   else
      select @w_ea_contrato_firmado = @i_ea_contrato_firmado

   if @w_ea_menor_edad = @i_ea_menor_edad
      select @w_ea_menor_edad = null, @v_ea_menor_edad  = null
   else
      select @w_ea_menor_edad = @i_ea_menor_edad

   if @w_ea_conocido_como = @i_ea_conocido_como
      select @w_ea_conocido_como = null, @v_ea_conocido_como  = null
   else
      select @w_ea_conocido_como = @i_ea_conocido_como

   if @w_ea_cliente_planilla = @i_ea_cliente_planilla
  select @w_ea_cliente_planilla = null, @v_ea_cliente_planilla  = null
   else
      select @w_ea_cliente_planilla = @i_ea_cliente_planilla

   if @w_ea_cod_risk = @i_ea_cod_risk
      select @w_ea_cod_risk = null, @v_ea_cod_risk  = null
   else
      select @w_ea_cod_risk = @i_ea_cod_risk

   if @w_ea_sector_eco = @i_ea_sector_eco
      select @w_ea_sector_eco = null, @v_ea_sector_eco  = null
   else
      select @w_ea_sector_eco = @i_ea_sector_eco

   if @w_ea_actividad = @i_ea_actividad
      select @w_ea_actividad = null, @v_ea_actividad  = null
   else
      select @w_ea_actividad = @i_ea_actividad

   if @w_ea_empadronado = @i_ea_empadronado
      select @w_ea_empadronado = null, @v_ea_empadronado  = null
   else
      select @w_ea_empadronado = @i_ea_empadronado

   if @w_ea_lin_neg = @i_ea_lin_neg
      select @w_ea_lin_neg = null, @v_ea_lin_neg  = null
   else
      select @w_ea_lin_neg = @i_ea_lin_neg
       
   if @w_ea_seg_neg = @i_ea_seg_neg
      select @w_ea_seg_neg = null, @v_ea_seg_neg  = null
   else
      select @w_ea_seg_neg = @i_ea_seg_neg
   

   if @w_ea_val_id_check = @i_ea_val_id_check
      select @w_ea_val_id_check = null, @v_ea_val_id_check  = null
   else
      select @w_ea_val_id_check = @i_ea_val_id_check
  
   if @w_ea_ejecutivo_con = @i_ea_ejecutivo_con
      select @w_ea_ejecutivo_con = null, @v_ea_ejecutivo_con  = null
   else
      select @w_ea_ejecutivo_con = @i_ea_ejecutivo_con
       
   if @w_ea_suc_gestion = @i_ea_suc_gestion
      select @w_ea_suc_gestion = null, @v_ea_suc_gestion  = null
   else
      select @w_ea_suc_gestion = @i_ea_suc_gestion

   if @w_ea_constitucion = @i_ea_constitucion
      select @w_ea_constitucion = null, @v_ea_constitucion  = null
   else
      select @w_ea_constitucion = @i_ea_constitucion
       
   if @w_ea_remp_legal = @i_ea_remp_legal
      select @w_ea_remp_legal = null, @v_ea_remp_legal  = null
   else
      select @w_ea_remp_legal = @i_ea_remp_legal    

   if @w_ea_apoderado_legal = @i_ea_apoderado_legal
      select @w_ea_apoderado_legal = null, @v_ea_apoderado_legal = null
   else
      select @w_ea_apoderado_legal = @i_ea_apoderado_legal
       
   if @w_ea_act_comp_kyc = @i_ea_act_comp_kyc
      select @w_ea_act_comp_kyc = null, @v_ea_act_comp_kyc  = null
   else
      select @w_ea_act_comp_kyc = @i_ea_act_comp_kyc
       
   if @w_ea_fecha_act_kyc = @i_ea_fecha_act_kyc
      select @w_ea_fecha_act_kyc = null, @v_ea_fecha_act_kyc  = null
   else
      select @w_ea_fecha_act_kyc = @i_ea_fecha_act_kyc
       
   if @w_ea_no_req_kyc_comp = @i_ea_no_req_kyc_comp
      select @w_ea_no_req_kyc_comp = null, @v_ea_no_req_kyc_comp  = null
   else
      select @w_ea_no_req_kyc_comp = @i_ea_no_req_kyc_comp

   if @w_ea_act_perfiltran = @i_ea_act_perfiltran
      select @w_ea_act_perfiltran = null, @v_ea_act_perfiltran  = null
   else
      select @w_ea_act_perfiltran = @i_ea_act_perfiltran

   if @w_ea_fecha_act_perfiltran = @i_ea_fecha_act_perfiltran
      select @w_ea_fecha_act_perfiltran = null, @v_ea_fecha_act_perfiltran  = null
   else
      select @w_ea_fecha_act_perfiltran = @i_ea_fecha_act_perfiltran

   if @w_ea_con_salario = @i_ea_con_salario
      select @w_ea_con_salario = null, @v_ea_con_salario  = null
   else
      select @w_ea_con_salario = @i_ea_con_salario
       
   if @w_ea_fecha_consal = @i_ea_fecha_consal
      select @w_ea_fecha_consal = null, @v_ea_fecha_consal  = null
   else
      select @w_ea_fecha_consal = @i_ea_fecha_consal  

   if @w_ea_sin_salario = @i_ea_sin_salario
      select @w_ea_sin_salario = null, @v_ea_sin_salario  = null
   else
      select @w_ea_sin_salario = @i_ea_sin_salario  
       
   if @w_ea_fecha_sinsal = @i_ea_fecha_sinsal
      select @w_ea_fecha_sinsal = null, @v_ea_fecha_sinsal  = null
   else
      select @w_ea_fecha_sinsal = @i_ea_fecha_sinsal  

   if @w_ea_actualizacion_cic = @i_ea_actualizacion_cic
      select @w_ea_actualizacion_cic = null, @v_ea_actualizacion_cic  = null
   else
      select @w_ea_actualizacion_cic = @i_ea_actualizacion_cic  

   if @w_ea_fecha_act_cic = @i_ea_fecha_act_cic
      select @w_ea_fecha_act_cic = null, @v_ea_fecha_act_cic  = null
   else
      select @w_ea_fecha_act_cic = @i_ea_fecha_act_cic 

   if @w_ea_fuente_ing = @i_ea_fuente_ing
      select @w_ea_fuente_ing = null, @v_ea_fuente_ing  = null
   else
      select @w_ea_fuente_ing = @i_ea_fuente_ing 

   if @w_ea_act_prin = @i_ea_act_prin
      select @w_ea_act_prin = null, @v_ea_act_prin  = null
   else
      select @w_ea_act_prin = @i_ea_act_prin 

   if @w_ea_detalle = @i_ea_detalle
      select @w_ea_detalle = null, @v_ea_detalle  = null
   else
      select @w_ea_detalle = @i_ea_detalle 
       
   if @w_ea_act_dol = @i_ea_act_dol
      select @w_ea_act_dol = null, @v_ea_act_dol  = null
   else
      select @w_ea_act_dol = @i_ea_act_dol 

   if @w_ea_cat_aml = @i_ea_cat_aml
      select @w_ea_cat_aml = null, @v_ea_cat_aml  = null
   else
      select @w_ea_cat_aml = @i_ea_cat_aml 
      
   if @w_oficina = @i_oficina
      select @w_oficina = null, @v_oficina  = null
   else
      select @w_oficina = @i_oficina
    
   --CHEQUEO DE VALORES DE DISCAPACIDAD
   --DISCAPACIDAD
   if @w_ea_discapacidad = @i_ea_discapacidad
      select @w_ea_discapacidad = null, @v_ea_discapacidad  = null
   else
      select @w_ea_discapacidad = @i_ea_discapacidad

   --TIPO DE DISCAPACIDAD
   if @w_ea_tipo_discapacidad = @i_ea_tipo_discapacidad
      select @w_ea_tipo_discapacidad = null, @v_ea_tipo_discapacidad  = null
   else
      select @w_ea_tipo_discapacidad = @i_ea_tipo_discapacidad

   --CEDULA DE DISCAPACIDAD
   if @w_ea_ced_discapacidad = @i_ea_tipo_discapacidad
      select @w_ea_ced_discapacidad = null, @v_ea_tipo_discapacidad  = null
   else
      select @w_ea_ced_discapacidad = @i_ea_tipo_discapacidad

    select @w_exist_tram = 1 from cob_workflow..wf_inst_proceso
	where io_estado = 'EJE' and io_campo_4 = 'REVOLVENTE' 
	and io_campo_7 != 'S' AND io_campo_1 = @i_persona

   --COLECTIVO/TIPO DE MERCADO
   if @w_ea_colectivo = @i_colectivo
      select @w_ea_colectivo = null, @v_ea_colectivo  = null
   else
   begin
      if @w_exist_tram = 1
	  begin
		exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'NO PUEDE MODIFICAR EL TIPO DE MERCADO YA QUE TIENE UNA SOLICITUD EN EJECUCION',
            @i_num     = 103413
        -- NO PUEDE MODIFICAR EL TIPO DE MERCADO YA QUE TIENE UNA SOLICITUD EN EJECUCION
			return 103413
	  end
	  else
		select @w_ea_colectivo = @i_colectivo
   end

   --NIVEL COLECTIVO/NIVEL DE CLIENTE
   if @w_ea_nivel_colectivo = @i_nivel_colectivo
      select @w_ea_nivel_colectivo = null, @v_ea_nivel_colectivo  = null
   else
   begin
	  if @w_exist_tram = 1
	  begin
		exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'NO PUEDE MODIFICAR EL NIVEL DE CLIENTE YA QUE TIENE UNA SOLICITUD EN EJECUCION',
            @i_num     = 103414
        -- NO PUEDE MODIFICAR EL NIVEL DE CLIENTE YA QUE TIENE UNA SOLICITUD EN EJECUCION
        return 103414
	  end
	  else
		select @w_ea_nivel_colectivo = @i_nivel_colectivo
   end

   --ASFI
   if @w_asfi = @i_asfi
      select @w_asfi = null, @v_asfi  = null
   else
      select @w_asfi = @i_asfi

   --EGRESOS
   if @w_egresos = @i_egresos
      select @w_egresos = null, @v_egresos  = null
   else
      select @w_egresos = @i_egresos

   --IFI
   if @w_ifi = @i_ifi
      select @w_ifi = null, @v_ifi  = null
   else
      select @w_ifi = @i_ifi

   --PATH DE LA FOTO
   if @w_path_foto = @i_path_foto
      select @w_path_foto = null, @v_path_foto  = null
   else
      select @w_path_foto = @i_path_foto

   --DATOS NIT 
   if @w_nit_id = @i_nit_id
      select @w_nit_id = null, @v_nit_id  = null
   else
      select @w_nit_id = @i_nit_id   
   if @w_nit_venc = @i_nit_venc
      select @w_nit_venc = null, @v_nit_venc  = null
   else
      select @w_nit_venc = @i_nit_venc        

   -- FIN VALIDANDO CAMPOS CL_ENTE_AUX

begin tran

--DOBLE AUTORIAZACION

   select @w_doble_aut = isnull(pa_char, 'N') 
     from cobis..cl_parametro   --Miguel Aldaz  06/24/2012 Doble autorizacion CLI-0565 HSBC
    where pa_producto = 'CLI' and pa_nemonico='DOBAUT'
     
   if @@rowcount = 0
      select @w_doble_aut = 'N'

   if @w_doble_aut = 'S'   and  @i_ejecutar='N'        --MALDAZ 06/20/2012 HSBC CLI-0565
   begin
     if exists(select 1 from cl_autorizaciones_pend where ap_ente     = @i_persona
                         and ap_estado= 'P' and ap_estructura = 'cl_ente') 
      begin
          exec sp_cerror
    @t_debug  = @t_debug,
          @t_file   = @t_file,
          @t_from   = @w_sp_name,
          @i_num    = 149110  --NUEVO ERROR EXISTE UNA ACTUALIZACION POR AUTORIZAR.
          --ERROR EN ACTUALIZACION DE DIRECCION
          return 149110 
      end        
     else   
     begin     
     
     --CABECERA
        select @w_autorizacion =isnull(max(ap_autorizacion), 0)+1 from cl_autorizaciones_pend  
     
        insert into cl_autorizaciones_pend (ap_autorizacion,ap_ente,ap_secuenciad,ap_secuencial,
           ap_estructura,ap_stored_proc,ap_estado , ap_fecha_registro,ap_fecha_aut_rechazo, 
           ap_funcionario_solicita, ap_hora_solicita,ap_funcionario_modifica ,ap_hora_aprueba)
        values (@w_autorizacion,@i_persona, null,null ,'cl_ente','sp_persona_upd' ,'P',@s_date,
           null ,@s_user ,@s_date ,null  , null)                 
        
       if @@error <> 0
       begin
         exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_num     = 103106
          --ERROR EN CREACION DE DIRECCION
        return 103106
       end       
       
       if @w_nombre <> null
       begin
          insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,
             da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','txtFirstName', 
            'en_nombre','@i_nombre','C',@w_nombre,@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
   @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Nombre>',
            @i_num     = 103106
          --ERROR EN CREACION DE DIRECCION
          return 103106
          end    
       end 

          if @w_p_apellido <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,
              da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
           values (@w_autorizacion,'NaturalCustomer','txtLastName', 'p_p_apellido',
              '@i_p_apellido','C',@w_p_apellido,@w_estado_campo )
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Primer Apellido>',
            @i_num     = 103106
          --ERROR EN CREACION DE DIRECCION
          return 103106
          end    
       end 
          

      if @w_s_apellido <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','txtAdditionalLastName', 'p_s_apellido','@i_s_apellido','C',@w_s_apellido,@w_estado_campo )
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Segundo Apellido>',
            @i_num     = 103106
          --ERROR EN CREACION DE DIRECCION
          return 103106
          end    
       end 

          if @w_sexo <> null
       begin
          insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','catSex', 'p_sexo','@i_sexo','C', @w_sexo, @w_estado_campo)
 if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Sexo>',
            @i_num     = 103106
          --ERROR EN CREACION DE DIRECCION
          return 103106
          end    
       end 


      if @w_tipo_ced <> null
     begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','qsIdentificationType', 'en_tipo_ced','@i_tipo_ced','C', @w_tipo_ced, @w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Tipo identificacion>',
            @i_num     = 103106
          --ERROR EN CREACION DE DIRECCION
          return 103106
          end    
       end 

      if @w_cedula <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','mbIdentificationNumber', 'en_ced_ruc','@i_cedula','C', @w_cedula, @w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Num. Identificacion>',
            @i_num     = 103106
          --ERROR EN CREACION DE DIRECCION
          return 103106
          end    
       end 

      if @w_pasaporte <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer',null, 'p_pasaporte','@i_pasaporte','C',@w_pasaporte,@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Pasaporte>',
            @i_num     = 103106
          --ERROR EN CREACION DE DIRECCION
    return 103106
          end    
       end 

      if @w_profesion <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','catProfession', 'p_profesion','@i_profesion','C', @w_profesion,@w_estado_campo )
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Profesion>',
            @i_num     = 103106
          --ERROR EN CREACION DE DIRECCION
          return 103106
          end    
       end 
       
       if @w_preferen <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','rbtnPreferential', 'en_preferen','@i_preferen','C', @w_preferen, @w_estado_campo )
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Cliente Preferencial>',
            @i_num     = 103106
          --ERROR EN CREACION DE DIRECCION
          return 103106
          end    
       end

      if @w_estado_civil <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','catMaritalStatus', 'p_estado_civil','@i_estado_civil','C', @w_estado_civil,@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Estado Civil>',
            @i_num     = 103106
          --ERROR EN CREACION DE DIRECCION
          return 103106
          end    
       end 

     if @w_num_cargas <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','mbDependents', 'p_num_cargas','@i_num_cargas','T', convert(varchar(10),@w_num_cargas),@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Num. Cargas>',
            @i_num     = 103106
  --ERROR EN CREACION DE DIRECCION
   return 103106
          end    
       end 

          if @w_nivel_ing <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer',null, 'p_nivel_ing','@i_nivel_ing','M',convert(varchar(10),@w_nivel_ing),@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Nivel Ingresos>',
            @i_num     = 103106
        --ERROR EN CREACION DE DIRECCION
          return 103106
          end    
       end 


      if @w_nivel_egr <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer',null, 'p_nivel_egr','@i_nivel_egr','M',convert(varchar(10),@w_nivel_egr),@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Nivel Egresos>',
            @i_num     = 103106
          --ERROR EN CREACION DE DIRECCION
          return 103106
          end    
       end 

     if @w_tipo <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
   values (@w_autorizacion,'NaturalCustomer','catCustomerType', 'p_tipo_persona','@i_tipo','C',@w_tipo,@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Tipo Persona>',
            @i_num     = 103106
          --ERROR EN CREACION DE DIRECCION
          return 103106
          end    
       end 

      if  @w_fecha_nac <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','mbBirthDate', 'p_fecha_nac','@i_fecha_nac','D', convert(varchar(10),@w_fecha_nac,101),@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
    @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Fecha nacimiento>',
            @i_num     = 103106
          --ERROR EN CREACION DE DIRECCION
          return 103106
          end    
       end 

      if  @w_grupo <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer',null, 'en_grupo','@i_grupo','I', convert(varchar(10),@w_grupo),@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
          @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Grupo>',
            @i_num     = 103106
  --ERROR EN CREACION DE DIRECCION
          return 103106
          end    
       end 

      if  @w_oficial <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','catCountExecutive', 'en_oficial','@i_oficial','S', convert(varchar(10),@w_oficial),@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Oficial>',
            @i_num     = 103106
          --ERROR EN CREACION DE DIRECCION
          return 103106
          end    
       end 

         if  @w_oficial_sup <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','catSubstitute', 'en_oficial_sup','@i_oficial_sup','S',convert(varchar(10),@w_oficial_sup),@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Oficial Sup.>',
         @i_num     = 103106
          --ERROR EN CREACION DE DIRECCION
          return 103106
          end    
       end 

          if @w_retencion <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','rbtnCommitte', 'en_retencion','@','C',@w_retencion,@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Retencion>',
            @i_num     = 103106
          --ERROR EN CREACION DE DIRECCION
          return 103106
          end    
       end 

          if @w_actividad <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','catEconomicActivity', 'en_actividad','@i_actividad','C',@w_actividad ,@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Actividad Economica>',
            @i_num     = 103106
          --ERROR EN CREACION DE DIRECCION
          return 103106
          end    
       end 

      if @w_comentario <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
     values (@w_autorizacion,'NaturalCustomer','txtComment', 'en_comentario','@i_comentario','C',@w_comentario,@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Comentario>',
            @i_num     = 103106
          --ERROR EN CREACION DE DIRECCION
          return 103106
          end    
       end

      if @w_fecha_emision <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer',null, 'p_fecha_emision','@i_fecha_emision','D',convert(varchar(10),@w_fecha_emision, 101),@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercin de campo <Fecha Emisin>',
            @i_num     = 103106
          --ERROR EN CREACION DE DIRECCION
          return 103106
          end    
       end 

          if @w_fecha_expira <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','mbExpirationDate', 'p_fecha_expira','@i_fecha_expira','D',convert(varchar(10),@w_fecha_expira, 101),@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Fecha Expira>',
            @i_num     = 103106
          --ERROR EN CREACION DE DIRECCION
          return 103106
          end    
       end

         if @w_asosciada <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer',null, 'en_asosciada','@i_asosciada','C',@w_asosciada,@w_estado_campo)
          if @@error <> 0
         begin
        exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Tipo Vinculacion>',
            @i_num     = 103106
          --ERROR EN CREACION DE DIRECCION
          return 103106
          end    
       end 

      if @w_tipo_vinculacion <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','catBankRelation', 'en_tipo_vinculacion','@i_tipo_vinculacion','C', @w_tipo_vinculacion,@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Relacion con el Banco>',
            @i_num     = 103106
          --ERROR EN CREACION DE DIRECCION
          return 103106
          end    
       end 
       
       if @w_nit <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer',null, 'en_nit','@i_nit','C', @w_nit,@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Nit>',
            @i_num     = 103106
          --ERROR EN CREACION DE DIRECCION
          return 103106
          end    
       end  
       
        if @w_referido <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','catReferedBy', 'en_referido','@i_referido','S', convert(varchar(10),@w_referido),@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Referido>',
            @i_num     = 103106
         --ERROR EN CREACION DE DIRECCION
          return 103106
          end    
       end  
       
       if @w_sector <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','catIndustry', 'en_sector','@i_sector','C', @w_sector,@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Industria>',
            @i_num     = 103106
          --ERROR EN CREACION DE DIRECCION
          return 103106
          end    
       end          
     
      if @w_ciudad_nac <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','qrBirthPlace02', 'p_ciudad_nac','@i_ciudad_nac','I',convert(varchar(10), @w_ciudad_nac),@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Ciudad Nacimiento>',
            @i_num     = 103106
          --ERROR EN CREACION DE DIRECCION
          return 103106
          end    
       end                    
       
       if @w_nivel_estudio<> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','catAcademicLevel', 'p_nivel_estudio','@i_nivel_estudio','C', @w_nivel_estudio,@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Nivel Estudio>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
          return 103106
          end    
       end     
       
       if @w_tipo_vivienda<> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','catHousingType', 'p_tipo_vivienda','@i_tipo_vivienda','C', @w_tipo_vivienda,@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Tipo de Vivienda>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
          return 103106
          end    
       end            
          
      if @w_doc_validado<> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','txtDocument', 'en_doc_validado','@i_doc_validado','C', @w_doc_validado,@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Doc. Validado>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
          return 103106
          end    
       end                    
  
      if @w_calif_cliente<> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer',null, 'p_calif_cliente','@i_calif_cliente','C', @w_calif_cliente,@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
       @i_msg     = 'Error en insercion de campo <Calif. Cliente>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
          return 103106
          end    
       end                    
                    
          
                    
      if @w_lugar_doc<> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','qrEmitionDocument', 'p_lugar_doc','@i_lugar_doc','I', convert(varchar(10),@w_lugar_doc),@w_estado_campo)
          if @@error <> 0
        begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Lugar Emision>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
          return 103106
          end    
       end                    
          
      if @w_gran_contribuyente<> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer',null, 'en_gran_contribuyente','@i_gran_contribuyente','C', @w_gran_contribuyente,@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
 @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Gran Contribuyente>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
          return 103106
          end    
       end                    

      if @w_situacion_cliente <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','catStatus', 'en_situacion_cliente','@i_situacion_cliente','C', @w_situacion_cliente,@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Situacion del Cliente>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
            return 103106
          end    
       end                    
       
       if @w_patrim_tec <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer',null, 'en_patrimonio_tec','@i_patrim_tec','M', convert(varchar(15),@w_patrim_tec),@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Patrimonio tec.>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
            return 103106
          end    
       end 

       if @w_fecha_patrim_bruto <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer',null, 'en_fecha_patri_bruto','@i_fecha_patrim_bruto','D', convert(varchar(10),@w_fecha_patrim_bruto, 101),@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Fecha Patrimonio Bruto>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
            return 103106
          end    
  end            

       if @w_total_activos <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer',null, 'c_total_activos','@i_total_activos','M', convert(varchar(15),@w_total_activos),@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Total Activos>',
     @i_num     = 103106
          /* 'Error en creacion de direccion'*/
            return 103106
          end    
       end            

      if @w_rep_superban <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','mbReport', 'en_rep_superban','@i_rep_superban','C', @w_rep_superban,@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Reporte Sup. Bancos>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
            return 103106
          end    
       end          

      if @w_exc_por2 <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer', 'catShareholders', 'en_exc_por2','@i_exc_por2','C', @w_exc_por2,@w_estado_campo)
          if @@error <> 0
          begin
         exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Tipo de Ente>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
            return 103106
          end    
       end            

      if @w_digito<> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','txtDV', 'en_digito', '@i_digito','C', @w_digito,@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <D.V.>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
            return 103106
          end    
       end               

    if @w_cem<> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer',null, 'en_cem','@i_cem','M', convert(varchar(15),@w_cem) ,@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Cem>',
 @i_num     = 103106
          /* 'Error en creacion de direccion'*/
            return 103106
          end    
       end     
       
       if @w_depart_doc<> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer',null, 'p_dep_doc','@i_depart_doc','I', convert(varchar(10),@w_depart_doc),@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Dep. Doc>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
            return 103106
          end    
       end     

       if @w_c_apellido<> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','txtMarriedName', 'p_c_apellido','@i_c_apellido','C', @w_c_apellido,@w_estado_campo)
          if @@error <> 0
          begin
        exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Apellido Casada>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
            return 103106
          end    
       end            
   
       if @w_s_nombre<> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','txtMiddleName', 'p_s_nombre', '@i_segnombre','C', @w_s_nombre,@w_estado_campo)
    if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
         @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Segundo Nombre>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
            return 103106
          end    
       end          

       if @w_numord<> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer',null, 'p_numord','@i_numord','C', @w_numord,@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Nom. Ord>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
            return 103106
          end    
       end       
   
       if @w_promotor<> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer', 'catDeveloper', 'en_promotor','@i_promotor','C', @w_promotor,@w_estado_campo)
 if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Promotor>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
            return 103106
          end    
       end
       
       if @w_num_pais_nacionalidad <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','qrNacionality', 'en_nacionalidad','@i_nacionalidad','I', convert(varchar(10),@w_num_pais_nacionalidad),@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Nacionalidad>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
            return 103106
          end    
       end  
                     
       
       if @w_codigo <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer',null, 'en_cod_otro_pais','@i_codigo','C',@w_cod_otro_pais,@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Codigo>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
            return 103106
          end    
       end  
      
       if @w_inss <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','txtSocialSecurityId', 'en_inss','@i_inss','C', @w_inss,@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Seguro Social>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
            return 103106
          end    
       end  
       
       if @w_licencia <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','txtDrivingLicense', 'en_licencia','@i_licencia','C', @w_licencia,@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Licencia>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
            return 103106
          end    
       end  
 
  
       if @w_ingre <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','catMonthly', 'en_ingre','@i_ingre','C', @w_ingre,@w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Ingresos Mensuales>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
            return 103106
  end    
       end   

       if @w_en_id_tutor <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','txtIdRepresentative', 'en_id_tutor','@i_en_id_tutor','C', @w_en_id_tutor, @w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <No. Id (Tutor)>',
            @i_num     = 103106
     /* 'Error en creacion de direccion'*/
            return 103106
          end   
       end       
                    
       if @w_en_nom_tutor <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','txtRepresentative', 'en_nom_tutor','@i_en_nom_tutor','C', @w_en_nom_tutor, @w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Tutor>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
            return 103106
          end 
       end                              
            
       if @w_categoria <> null
       begin
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer','catCategory', 'en_concordato','@i_categoria','C', @w_categoria, @w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Categoroa>',
         @i_num     = 103106
          /* 'Error en creacion de direccion'*/
            return 103106
          end    
       end
   
                    if @w_ea_estado <> null
                    begin
                  insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
                  values(@w_autorizacion,'NaturalCustomer',null , 'ea_estado','@i_ea_estado'  , 'C' ,@w_ea_estado , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name, @i_msg     = 'Error en insercion de campo <Estado>', @i_num     = 103106
                       return 103106
   end    
                    end
              
                    if @w_ea_contrato_firmado <> null
                    begin
          insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
                  values(@w_autorizacion,'NaturalCustomer', 'rbtnContractUnique' , 'ea_contrato_firmado','@i_ea_contrato_firmado'  , 'C' ,@w_ea_contrato_firmado , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name, @i_msg     = 'Error en insercion de campo <Contrato Firmado>', @i_num     = 103106
                       return 103106
                    end    
                    end
                    
                    if @w_ea_menor_edad <> null
                    begin
                  insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
                  values(@w_autorizacion,'NaturalCustomer', 'rbtnLowerAge' , 'ea_menor_edad','@i_ea_menor_edad'  , 'C' ,@w_ea_menor_edad , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name, @i_msg     = 'Error en insercion de campo <Menor de Edad>',@i_num     = 103106
                       return 103106
                    end    
                    end

                    if @w_ea_conocido_como <> null
                    begin
                  insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
                  values(@w_autorizacion,'NaturalCustomer', 'txtKnownAs' , 'ea_conocido_como','@i_ea_conocido_como'  , 'C' ,@w_ea_conocido_como , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name, @i_msg     = 'Error en insercion de campo <Conocido como>',@i_num     = 103106
   return 103106
                    end    
                    end                 
                    
                    if @w_ea_cliente_planilla <> null
  begin
                  insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
                  values(@w_autorizacion,'NaturalCustomer', 'rbtnCustomerInvoice' , 'ea_cliente_planilla','@i_ea_cliente_planilla'  , 'C' ,@w_ea_cliente_planilla , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name,@i_msg     = 'Error en insercion de campo <Cliente planilla>', @i_num     = 103106
                       return 103106
                    end    
                    end       

                    if @w_ea_cod_risk <> null
         begin
                  insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
                  values(@w_autorizacion,'NaturalCustomer', 'txtCodRisk' , 'ea_cod_risk','@i_ea_cod_risk'  , 'C' ,@w_ea_cod_risk , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name, @i_msg     = 'Error en insercion de campo <Cod. Risk>',@i_num     = 103106
                       return 103106
                    end    
                    end                 

                if @w_ea_sector_eco <> null
                    begin
               insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
                  values(@w_autorizacion,'NaturalCustomer', 'catSectorEcon' , 'ea_sector_eco','@i_ea_sector_eco'  , 'C' ,@w_ea_sector_eco , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name, @i_msg     = 'Error en insercion de campo <Sector Economico>',@i_num     = 103106
                       return 103106
                    end    
                    end                 
                    
                    if @w_ea_actividad <> null
                    begin
                  insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
                  values(@w_autorizacion,'NaturalCustomer', 'catActividad' , 'ea_actividad','@i_ea_actividad'  , 'C' ,@w_ea_actividad , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name, @i_msg     = 'Error en insercion de campo <Actividad>',@i_num     = 103106
                       return 103106
                    end    
                    end  

                    if @w_ea_empadronado <> null
                    begin
insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
                  values(@w_autorizacion,'NaturalCustomer', 'rbtnRegister' , 'ea_empadronado','@i_ea_empadronado'  , 'C' ,@w_ea_empadronado , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name, @i_msg     = 'Error en insercion de campo <Empadronado>',@i_num     = 103106
                       return 103106
                    end    
                    end  

                    if @w_ea_lin_neg <> null
                    begin
                  insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado  )
                  values(@w_autorizacion,'NaturalCustomer','catBusinessLine' , 'ea_lin_neg','@i_ea_lin_neg'  , 'C' ,@w_ea_lin_neg , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name, @i_msg     = 'Error en insercion de campo <Linea Negocio>',@i_num     = 103106
                       return 103106
                    end    
                    end  
               
                    if @w_ea_seg_neg <> null
                    begin
                  insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
                  values(@w_autorizacion,'NaturalCustomer', 'catBusinessSegment' , 'ea_seg_neg','@i_ea_seg_neg'  , 'C' ,@w_ea_seg_neg , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name,@i_msg     = 'Error en insercion de campo <Segmento Negocio>', @i_num     = 103106
                       return 103106
                    end    
                    end  
               
                    if @w_ea_val_id_check <> null 
                    begin
                  insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
                  values(@w_autorizacion,'NaturalCustomer', 'catIdCheck' , 'ea_val_id_check','@i_ea_val_id_check'  , 'C' ,@w_ea_val_id_check , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name, @i_msg     = 'Error en insercion de campo <Validacion Id Check>',@i_num     = 103106
                       return 103106
                    end    
                    end  

                    if @w_ea_ejecutivo_con <> null
                    begin
                  insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
                  values(@w_autorizacion,'NaturalCustomer',null , 'ea_ejecutivo_con','@i_ea_ejecutivo_con'  , 'I' , convert(varchar(10), @w_ea_ejecutivo_con) , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name, @i_msg     = 'Error en insercion de campo <Ejecutivo con>',@i_num     = 103106
                       return 103106
                    end    
                    end  

                    if @w_ea_suc_gestion <> null
                    begin
                  insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
             values(@w_autorizacion,'NaturalCustomer','catOffice' , 'ea_suc_gestion','@i_ea_suc_gestion'  , 'S' , convert(varchar(10), @w_ea_suc_gestion) , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name, @i_msg     = 'Error en insercion de campo <Suc Gestion>',@i_num     = 103106
                       return 103106
                    end    
                    end  

                    if @w_ea_act_comp_kyc <> null
                    begin
                  insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
                  values(@w_autorizacion,'NaturalCustomer','rbtnUpdKycComplet' , 'ea_act_comp_kyc','@i_ea_act_comp_kyc'  , 'C' ,@w_ea_act_comp_kyc , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name, @i_msg     = 'Error en insercion de campo <Act. Comp. KYC:>',@i_num     = 103106
                       return 103106
                    end    
                    end  

                    if @w_ea_fecha_act_kyc <> null
                    begin
                  insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
                  values(@w_autorizacion,'NaturalCustomer', 'mbUpdKycCDate' , 'ea_fecha_act_kyc','@i_ea_fecha_act_kyc'  , 'D' , convert(varchar(10), @w_ea_fecha_act_kyc, 101) , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name, @i_msg     = 'Error en insercion de campo <Fecha Act. KYC>',@i_num     = 103106
                       return 103106
                    end    
                    end  

                 if @w_ea_no_req_kyc_comp <> null
                    begin
                  insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
                  values(@w_autorizacion,'NaturalCustomer', 'rbtnNotUpdKycComplet' , 'ea_no_req_kyc_comp','@i_ea_no_req_kyc_comp'  , 'C' ,@w_ea_no_req_kyc_comp , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name, @i_msg     = 'Error en insercion de campo <Requiere KYC>',@i_num     = 103106
                       return 103106
                    end    
                    end  

                 if @w_ea_act_perfiltran <> null
                    begin
                  insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
                  values(@w_autorizacion,'NaturalCustomer', 'rbtnUpdPerfTrans' , 'ea_act_perfiltran','@i_ea_act_perfiltran'  , 'C' ,@w_ea_act_perfiltran , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name, @i_msg     = 'Error en insercion de campo <Act. Perfil Transaccional>',@i_num     = 103106
                       return 103106
                    end    
                    end                      

                 if @w_ea_fecha_act_perfiltran <> null
                    begin
                  insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
                  values(@w_autorizacion,'NaturalCustomer', 'mbPerfTransDate' , 'ea_fecha_act_perfiltran','@i_ea_fecha_act_perfiltran'  , 'D' , convert(varchar(10),@w_ea_fecha_act_perfiltran, 101) , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name, @i_msg     = 'Error en insercion de campo <Fecha Act. Perfil Trans.>',@i_num     = 103106
                       return 103106
                    end    
                    end       
                    
                 if @w_ea_con_salario <> null
                    begin
                  insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
        values(@w_autorizacion,'NaturalCustomer', 'rbtnYesSalary' , 'ea_con_salario','@i_ea_con_salario'  , 'C' ,@w_ea_con_salario , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name, @i_msg     = 'Error en insercion de campo <Con Salario>',@i_num     = 103106
                       return 103106
                    end    
                    end
                    
                 if @w_ea_fecha_consal <> null
                    begin
                  insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
         values(@w_autorizacion,'NaturalCustomer', 'mbYSalaryDate' , 'ea_fecha_consal','@i_ea_fecha_consal'  , 'D' , convert(varchar(10),@w_ea_fecha_consal, 101) , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name, @i_msg     = 'Error en insercion de campo <Fecha Con Salario>',@i_num     = 103106
                       return 103106
                    end    
                    end
                    
                 if @w_ea_sin_salario <> null
                    begin
                  insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
                  values(@w_autorizacion,'NaturalCustomer', 'rbtnNotSalary' , 'ea_sin_salario','@i_ea_sin_salario'  , 'C' ,@w_ea_sin_salario , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name, @i_msg     = 'Error en insercion de campo <Sin Salario>',@i_num     = 103106
                       return 103106
                    end    
                    end
                    
                 if @w_ea_fecha_sinsal <> null
                    begin
                  insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
                  values(@w_autorizacion,'NaturalCustomer', 'mbNSalaryDate' , 'ea_fecha_sinsal','@i_ea_fecha_sinsal'  , 'D' , convert(varchar(10),@w_ea_fecha_sinsal, 101) , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name, @i_msg     = 'Error en insercion de campo <Fecha Sin Salario>',@i_num     = 103106
                       return 103106
                    end    
                    end
               
                 if @w_ea_actualizacion_cic <> null
                    begin
        insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
                  values(@w_autorizacion,'NaturalCustomer','catCIC', 'ea_actualizacion_cic','@i_ea_actualizacion_cic'  , 'C' ,@w_ea_actualizacion_cic , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name, @i_msg     = 'Error en insercion de campo <Actualizacion CIC>',@i_num     = 103106
                       return 103106
                    end    
                    end
               
                 if @w_ea_fecha_act_cic <> null
                    begin
                  insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
                  values(@w_autorizacion,'NaturalCustomer',null , 'ea_actualizacion_cic','@i_ea_fecha_act_cic'  , 'D' , convert(varchar(10),@w_ea_fecha_act_cic, 101) , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name, @i_msg     = 'Error en insercion de campo <Fecha Act. CIC>',@i_num     = 103106
                       return 103106
                    end    
                    end
                    
                 if @w_ea_fuente_ing <> null
                    begin
                  insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
       values(@w_autorizacion,'NaturalCustomer', 'catSourceIncome' , 'ea_fuente_ing','@i_ea_fuente_ing'  , 'C' ,@w_ea_fuente_ing , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name, @i_msg     = 'Error en insercion de campo <Fuente de Ingreso>',@i_num     = 103106
                       return 103106
                    end    
                    end
               
                 if @w_ea_act_prin <> null
                    begin
                  insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
               values(@w_autorizacion,'NaturalCustomer', 'catActivityMain' , 'ea_act_prin','@i_ea_act_prin'  , 'C' ,@w_ea_act_prin , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name, @i_msg     = 'Error en insercion de campo <Actividad Principal >',@i_num     = 103106
                       return 103106
                    end    
                    end

                 if @w_ea_detalle <> null
                    begin
                  insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
                  values(@w_autorizacion,'NaturalCustomer', 'txtDetail' , 'ea_detalle','@i_ea_detalle'  , 'C' ,@i_ea_detalle , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name, @i_msg     = 'Error en insercion de campo <Detalle>',@i_num     = 103106
                       return 103106
                    end    
                    end
                    
                 if @w_ea_act_dol <> null
                    begin
                  insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
                  values(@w_autorizacion,'NaturalCustomer', 'curActivityDolar' , 'ea_act_dol','@i_ea_act_dol'  , 'M' , convert(varchar(20), @w_ea_act_dol) , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name, @i_msg     = 'Error en insercion de campo <Actividad Dolarizada>',@i_num     = 103106
                       return 103106
                    end    
                    end
                    
                 if @w_ea_cat_aml <> null
                    begin
                  insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
                  values(@w_autorizacion,'NaturalCustomer','catCategoryAML' , 'ea_cat_aml','@i_ea_cat_aml'  , 'C' ,@w_ea_cat_aml , @w_estado_campo )
                      if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name,@i_msg     = 'Error en insercion de campo <Categoria AML>', @i_num     = 103106
                       return 103106
                    end    
                    end
                    
                if @w_oficina <> null
                    begin
                  insert into cl_datos_autorizacion  (da_autorizacion,da_screen        , da_objecto        , da_campo         ,da_sp_param,da_valor_tipo,da_valor     , da_estado      )
                  values(@w_autorizacion,'NaturalCustomer','catOffice' , 'en_oficina','@i_oficina'  , 'I' ,convert(char(15),@w_oficina) , @w_estado_campo )
           if @@error <> 0
                     begin
                      exec sp_cerror  @t_debug   = @t_debug,  @t_file    = @t_file, @t_from    = @w_sp_name,@i_msg     = 'Error en insercion de campo <Oficina>', @i_num     = 103106
                       return 103106
                    end    
                    end

                    
          /****************************************************/
           insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer',null, null,'@s_date','D',convert(varchar(10),@s_date,101), @w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Fecha>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
             return 103106     
          end
          
          insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer',null, null,'@s_user','C',@s_user, @w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Usuario>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
             return 103106     
          end
          
          insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer',null, null,'@s_srv','C',@s_srv, @w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
       @i_msg     = 'Error en insercion de campo <Srv>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
             return 103106     
          end
          
          insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer',null, null,'@s_lsrv','C',@s_lsrv, @w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <LSrv>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
             return 103106     
          end
          
          insert into cl_datos_autorizacion(da_autorizacion,da_screen,da_objecto,da_campo,da_sp_param,da_valor_tipo,da_valor ,da_estado)
          values (@w_autorizacion,'NaturalCustomer',null, null,'@s_term','C',@s_term, @w_estado_campo)
          if @@error <> 0
          begin
            exec sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
   @t_from    = @w_sp_name,
            @i_msg     = 'Error en insercion de campo <Terminal>',
            @i_num     = 103106
          /* 'Error en creacion de direccion'*/
             return 103106     
          end
           
                if not exists (select 1 
                                 from cobis..cl_datos_autorizacion 
                                    where da_autorizacion = @w_autorizacion 
                                      and da_campo is not null)
             begin
         delete cobis..cl_datos_autorizacion where da_autorizacion = @w_autorizacion
                    delete cobis..cl_autorizaciones_pend where ap_autorizacion = @w_autorizacion
                         exec sp_cerror
                          @t_debug   = @t_debug,
                              @t_file    = @t_file,
                              @t_from    = @w_sp_name,
                              @i_num     = 107247
                         /* 'No existen cambios'*/
                         return 107247 
                end

           commit tran 
          return 0                                                                
        end    
    end        

     
/* ********************************************************* */
/* ***    Ajuste de Tarifas -- Actualizacion CIC      ****** */
/* ********************************************************* */
   
    if @w_ea_seg_neg <> @v_ea_seg_neg and @w_ea_seg_neg<>null
    begin
        
         insert into cobis..cl_mod_segmento
         values (@i_persona, @s_date, @v_ea_seg_neg, @i_ea_seg_neg, 
                 @s_user, @i_oficina, 'segmento') 
         if @@error <> 0
         begin
            exec sp_cerror
                  @t_debug      = @t_debug,
                     @s_msg        = 'Error al actualizar registro de Informacion de CIC - Segmento',
                  @t_file       = @t_file,
                  @t_from       = @w_sp_name,
                  @i_num        = 107205
                  /* 'Error al actualizar registro de Informacion de CIC'*/
             return 1
          end                  
    end
   
  --Linea de Negocio
    if @w_ea_lin_neg <> @v_ea_lin_neg and @w_ea_lin_neg <> null
    begin
        
         insert into cobis..cl_mod_segmento
         values (@i_persona, @s_date, @v_ea_lin_neg, @i_ea_lin_neg, 
                 @s_user, @i_oficina, 'linea')  
         if @@error <> 0
         begin
            exec sp_cerror
                  @t_debug      = @t_debug,
                     @s_msg        = 'Error al actualizar registro de Informacion de CIC - Linea',
                  @t_file       = @t_file,
                  @t_from       = @w_sp_name,
                  @i_num        = 107205
                  /* 'Error al actualizar registro de Informacion de CIC'*/
             return 1
          end                  
    end

  --Planilla
  
    if @w_ea_cliente_planilla <> @v_ea_cliente_planilla and @w_ea_cliente_planilla <> null
    begin
        
         insert into cobis..cl_mod_segmento
         values (@i_persona, @s_date, @v_ea_cliente_planilla, @i_ea_cliente_planilla, 
                 @s_user, @i_oficina, 'planilla')   
           if @@error <> 0
         begin
            exec sp_cerror
                  @t_debug      = @t_debug,
                     @s_msg        = 'Error al actualizar registro de Informacion de CIC - Planilla',
                  @t_file       = @t_file,
                  @t_from       = @w_sp_name,
                  @i_num        = 107205
                  /* 'Error al actualizar registro de Informacion de CIC'*/
             return 1
          end
    end

 --Tipo Vinculacion
   
    if @w_tipo_vinculacion <> @v_tipo_vinculacion and @w_tipo_vinculacion <> null
    begin
        
         insert into cobis..cl_mod_segmento
         values (@i_persona, @s_date, @v_tipo_vinculacion, @i_tipo_vinculacion, 
                 @s_user, @i_oficina, 'relacionado')  
         if @@error <> 0
         begin
       exec sp_cerror
                  @t_debug      = @t_debug,
                     @s_msg        = 'Error al actualizar registro de Informacion de CIC - Relacionado',
                  @t_file       = @t_file,
                  @t_from       = @w_sp_name,
                  @i_num        = 107205
                  /* 'Error al actualizar registro de Informacion de CIC'*/
             return 1
          end             
    end
--Fuente de Ingresos
  if not exists(select 1 from cl_actividad_principal
                              where ap_activ_comer = @i_ea_fuente_ing) and @i_ea_fuente_ing is not null
  begin
       select @i_ea_act_prin = 'NA'
  end
  
  if exists (select 1 from cobis..cl_funcionario where fu_cedruc =  @i_nit)
  begin
  	
  	select @i_vinculacion = 'S'
  	
  end
  else
  begin
  	
  	select @i_vinculacion = 'N'
  	
  end
  
/* ********************************************************* */
/* ***    Ajuste de Tarifas -- Actualizacion CIC      ****** */
/* ********************************************************* */

   update cobis..cl_ente
      set en_nombre             = isnull(@i_nombre, en_nombre),
          p_p_apellido          = isnull(@i_p_apellido, p_p_apellido),
          p_s_apellido          = @i_s_apellido,--isnull(@i_s_apellido, p_s_apellido),
          p_sexo                = isnull(@i_sexo, p_sexo),
          en_tipo_ced           = isnull(@i_tipo_ced, en_tipo_ced),
          en_ced_ruc            = isnull(@i_cedula, en_ced_ruc),
          p_pasaporte           = isnull(@i_pasaporte, p_pasaporte),
          en_pais               = isnull(@i_pais, en_pais),
          p_profesion           = isnull(@i_profesion, p_profesion),
          p_otro_profesion      = isnull(@i_otro_prof, p_otro_profesion),
          p_estado_civil        = isnull(@i_estado_civil, p_estado_civil),
          p_num_cargas          = isnull(@i_num_cargas, p_num_cargas),
          p_nivel_ing           = isnull(@i_nivel_ing, p_nivel_ing),
          p_nivel_egr           = isnull(@i_nivel_egr, p_nivel_egr),
          p_tipo_persona        = isnull(@i_tipo, p_tipo_persona),
          en_fecha_mod          = isnull(@w_today, en_fecha_mod),
          p_fecha_nac           = isnull(@i_fecha_nac, p_fecha_nac),
          en_grupo              = isnull(@i_grupo, en_grupo),
          --en_oficial            = isnull(@i_oficial, en_oficial),
          en_oficial_sup        = isnull(@i_oficial_sup, en_oficial_sup),
          --c_funcionario         = isnull(@w_login_oficia,c_funcionario), --Actualuza el login
          en_retencion          = isnull(@i_retencion, en_retencion),
          en_preferen           = isnull(@i_preferen, en_preferen),
          en_actividad          = isnull(@i_actividad, en_actividad),
          en_comentario         = @i_comentario,
          p_fecha_emision       = isnull(@i_fecha_emision, p_fecha_emision),
          p_fecha_expira        = @i_fecha_expira, --isnull(@i_fecha_expira, p_fecha_expira),
          en_asosciada          = isnull(@i_asosciada, en_asosciada),
          en_tipo_vinculacion   = isnull(@i_tipo_vinculacion, en_tipo_vinculacion),
          en_vinculacion        = isnull(@i_vinculacion, en_vinculacion),
          en_nit                = isnull(@i_nit, en_nit),
          en_rfc                = isnull(@i_nit, en_rfc),
          en_referido           = isnull(@i_referido, en_referido),
          en_sector             = isnull(@i_sector, en_sector),
          p_ciudad_nac          = isnull(@i_ciudad_nac, p_ciudad_nac),
          p_nivel_estudio       = @i_nivel_estudio,
          p_tipo_vivienda       = @i_tipo_vivienda,
          en_doc_validado       = isnull(@i_doc_validado, en_doc_validado),
          p_calif_cliente       = isnull(@i_calif_cliente, p_calif_cliente),
          en_nomlar             = isnull(@w_nombre_completo, en_nomlar),
          p_lugar_doc           = isnull(@i_lugar_doc, p_lugar_doc),
          en_gran_contribuyente = isnull(@i_gran_contribuyente, en_gran_contribuyente),
          en_situacion_cliente  = isnull(@i_situacion_cliente, en_situacion_cliente),
          en_patrimonio_tec     = isnull(@i_patrim_tec, en_patrimonio_tec),
          en_fecha_patri_bruto  = isnull(@i_fecha_patrim_bruto, en_fecha_patri_bruto),
          c_total_activos       = isnull(@i_total_activos, c_total_activos),
       en_rep_superban       = isnull(@i_rep_superban, en_rep_superban),
  en_exc_sipla          = isnull(@i_exc_sipla, en_exc_sipla),
          en_exc_por2           = isnull(@i_exc_por2, en_exc_por2),
          en_digito             = isnull(@i_digito, en_digito),
          en_cem                = isnull(@i_cem, en_cem),
          p_dep_doc             = isnull(@i_depart_doc, p_dep_doc),
          p_c_apellido          = @i_c_apellido,
          p_s_nombre            = @i_segnombre,--isnull(@i_segnombre, p_s_nombre),
          p_numord              = isnull(@i_numord, p_numord),
          en_promotor           = isnull(@i_promotor, en_promotor),
          c_codsuper            = isnull(@i_tipo, c_codsuper),
          en_nacionalidad       = isnull(@i_nacionalidad, en_nacionalidad),
          en_cod_otro_pais      = isnull(@i_codigo, en_cod_otro_pais),
          en_inss        = isnull(@i_inss, en_inss),
   en_licencia           = isnull(@i_licencia, en_licencia),
          en_ingre              = isnull(@i_ingre, en_ingre),
          en_id_tutor           = @i_en_id_tutor,
          en_nom_tutor          = @i_en_nom_tutor,
          en_concordato         = isnull(@i_categoria, en_concordato),
          en_referidor_ecu      = isnull(@i_referidor_ecu, en_referidor_ecu),
          p_rel_carg_pub        = @i_rel_carg_pub,
          p_carg_pub            = @i_carg_pub,
          p_situacion_laboral   = isnull(@i_situacion_laboral, p_situacion_laboral),
          p_bienes              = isnull(@i_bienes, p_bienes),
          en_otros_ingresos     = isnull(@i_otros_ingresos, en_otros_ingresos),
          en_origen_ingresos    = isnull(@i_origen_ingresos, en_origen_ingresos),
          c_verificado          = isnull(@i_verificado, 'N'),
          en_oficina              = isnull(@i_oficina, en_oficina),
          c_tipo_compania        = isnull(@w_nat_jur_hogar,c_tipo_compania),
          --c_fecha_verif         = @i_fecha_verifi
          c_fecha_verif         = @s_date, --* Debe guardar la fecha de proceso          
          en_emproblemado       = @i_emproblemado, 
          en_dinero_transac     = isnull(@i_dinero_transac,en_dinero_transac),
          en_persona_pep        = @i_pep, 
          c_pasivo              = isnull(@i_mnt_pasivo,c_pasivo),
          en_persona_pub        = isnull(@i_persona_pub, en_persona_pub),
          en_ing_SN             = isnull(@i_ing_SN, en_ing_SN),
          en_otringr            = isnull(@i_otringr,en_otringr),
          p_depa_nac            = isnull(@i_depa_nac,p_depa_nac),
          en_nac_aux            = isnull(@i_nac_aux,en_nac_aux), 
          p_pais_emi            = isnull(@i_pais_emi,p_pais_emi),
          en_banco              = isnull(@i_banco, en_banco) 
          where en_ente = @i_persona
          and en_subtipo = 'P'

     if @@error <> 0
      begin
         exec sp_cerror  @t_debug    = @t_debug,
               @t_file     = @t_file,
               @t_from     = @w_sp_name,
               @i_num      = 105026
         /* 'Error en actualizacion de persona'*/
         return 1
      end
      
    select @w_ea_ced_ruc= replace(isnull(@i_cedula, en_ced_ruc),'-','')
    from cl_ente
    where en_ente = @i_persona     
      and en_subtipo = 'P'
	  
     update cobis..cl_ente_aux
        set
           ea_estado                  = isnull(@i_ea_estado, ea_estado),
           --ea_observacion_aut       = isnull(@i_ea_observacion_aut, ea_observacion_aut),
           ea_contrato_firmado        = isnull(@i_ea_contrato_firmado, ea_contrato_firmado),
           ea_menor_edad              = isnull(@i_ea_menor_edad, ea_menor_edad),
           ea_conocido_como           = @i_ea_conocido_como,
           ea_cliente_planilla        = isnull(@i_ea_cliente_planilla, ea_cliente_planilla),
           ea_cod_risk                = isnull(@i_ea_cod_risk, ea_cod_risk),
           ea_sector_eco              = isnull(@i_ea_sector_eco, ea_sector_eco),
           ea_actividad               = isnull(@i_ea_actividad, ea_actividad),
           --ea_empadronado             = isnull(@i_ea_empadronado, ea_empadronado),
           ea_lin_neg                 = isnull(@i_ea_lin_neg, ea_lin_neg),
           ea_seg_neg                 = isnull(@i_ea_seg_neg, ea_seg_neg),
           --ea_val_id_check            = isnull(@i_ea_val_id_check, ea_val_id_check),
           ea_ejecutivo_con           = isnull(@i_ea_ejecutivo_con, ea_ejecutivo_con),
           ea_suc_gestion             = isnull(@i_ea_suc_gestion, ea_suc_gestion),
           ea_constitucion            = isnull(@i_ea_constitucion, ea_constitucion),
           ea_remp_legal              = isnull(@i_ea_remp_legal, ea_remp_legal),
           ea_apoderado_legal         = isnull(@i_ea_apoderado_legal, ea_apoderado_legal),
           --ea_act_comp_kyc        = isnull(@i_ea_act_comp_kyc, ea_act_comp_kyc),
           --ea_fecha_act_kyc           = isnull(@i_ea_fecha_act_kyc, ea_fecha_act_kyc),
           --ea_no_req_kyc_comp         = isnull(@i_ea_no_req_kyc_comp, ea_no_req_kyc_comp),
           --ea_act_perfiltran          = isnull(@i_ea_act_perfiltran, ea_act_perfiltran),
           --ea_fecha_act_perfiltran    = isnull(@i_ea_fecha_act_perfiltran, ea_fecha_act_perfiltran),
           --ea_con_salario             = isnull(@i_ea_con_salario, ea_con_salario),
           --ea_fecha_consal            = isnull(@i_ea_fecha_consal, ea_fecha_consal),
           --ea_sin_salario             = isnull(@i_ea_sin_salario, ea_sin_salario),
           --ea_fecha_sinsal            = isnull(@i_ea_fecha_sinsal, ea_fecha_sinsal),
           --ea_actualizacion_cic       = isnull(@i_ea_actualizacion_cic, ea_actualizacion_cic),
           --ea_fecha_act_cic           = isnull(@i_ea_fecha_act_cic, ea_fecha_act_cic),
           ea_fuente_ing              = isnull(@i_ea_fuente_ing, ea_fuente_ing),
           ea_act_prin                = isnull(@i_ea_act_prin, ea_act_prin),
           ea_detalle                 = isnull(@i_ea_detalle, ea_detalle),
           ea_act_dol                 = isnull(@i_ea_act_dol, ea_act_dol),
          ea_cat_aml                 = isnull(@i_ea_cat_aml, ea_cat_aml),
           ea_ced_ruc                 = @w_ea_ced_ruc,
           ea_discapacidad            = @i_ea_discapacidad,
           ea_tipo_discapacidad       = @i_ea_tipo_discapacidad,
           ea_ced_discapacidad        = @i_ea_ced_discapacidad,
           ea_nivel_egresos           = @i_egresos,
           ea_ifi                     = @i_ifi,
           ea_asfi                    = @i_asfi,
           ea_path_foto               = isnull(@i_path_foto,ea_path_foto),
           ea_nit                     = @i_nit_id, 
           ea_nit_venc                = @i_nit_venc,
           ea_ant_nego                = @i_ant_nego,
           ea_ventas                  = isnull(@i_ventas,ea_ventas),
           ea_ct_ventas               = isnull(@i_ct_ventas,ea_ct_ventas),
           ea_ct_operativo            = @i_ct_operativos,
           ea_indefinido              = @i_ea_indefinido,
           ea_nro_ciclo_oi            = @i_ea_nro_ciclo_oi, -- LPO Santander --numero de ciclos en otras entidades 
           ea_partner                 = @i_partner,
           ea_lista_negra             = @i_lista_negra,
           ea_fiel                    ='No Aplica',
           ea_ingreso_negocio         = isnull(@i_ing_negocio,ea_ingreso_negocio),
	       ea_consulto_renapo         = isnull(@i_respuesta_renapo, ea_consulto_renapo),
		   ea_colectivo               = isnull(@i_colectivo, ea_colectivo),
		   ea_nivel_colectivo         = isnull(@i_nivel_colectivo, ea_nivel_colectivo)
           where ea_ente = @i_persona
     
     if @@error <> 0
     begin
          exec sp_cerror
               @t_debug    = @t_debug,
               @t_file     = @t_file,
               @t_from     = @w_sp_name,
               @i_num      = 105093
               /* 'Error en actualizacion de compania'*/
          return 1
     end
	 
	 
	 --Biometrico
	 if exists(select 1 from cobis..cl_ente_bio where eb_ente = @i_persona)
      begin
         
         update cobis..cl_ente_bio
         set eb_tipo_identificacion    = @i_bio_tipo_identificacion,
             eb_cic                    = @i_bio_cic,
             eb_ocr                    = @i_bio_ocr,
             eb_nro_emision            = @i_bio_numero_emision,
             eb_clave_elector          = @i_bio_clave_lector,
             eb_sin_huella_dactilar    = isnull(@i_bio_huella_dactilar,'N')
         where eb_ente = @i_persona
         
         if @@error <> 0
         begin
            exec sp_cerror
                @t_debug    = @t_debug,
                @t_file     = @t_file,
                @t_from     = @w_sp_name,
                @i_num      = 105026
                /* 'Error en actualizacion de persona'*/
            return 1
         end
		 
		 insert into cobis..cl_ente_bio_his
	     (ebh_ssn,                            ebh_ente,              ebh_tipo_identificacion,     ebh_cic,
         ebh_ocr,                             ebh_nro_emision,       ebh_clave_elector,           ebh_sin_huella_dactilar,             
		 ebh_fecha_registro,                  ebh_fecha_vencimiento, ebh_anio_registro,           ebh_anio_emision,
		 ebh_fecha_modificacion,              ebh_transaccion,       ebh_usuario,                 ebh_terminal,
		 ebh_srv,                             ebh_lsrv)
	     values                               
	     (@s_ssn,                             @i_persona,            @i_bio_tipo_identificacion,  @i_bio_cic, 	         
		 @i_bio_ocr,                          @i_bio_numero_emision, @i_bio_clave_lector, 	      isnull(@i_bio_huella_dactilar,'N'),  
		 getdate(),                           null,                  null,                        null,
		 getdate(),                           'U',                   @s_user,                     @s_term,
		 @s_srv,                              @s_lsrv)
		  		  
		  
         if @@error <> 0
         BEGIN
           exec sp_cerror
                @t_debug    = @t_debug,
                @t_file     = @t_file,
                @t_from     = @w_sp_name,
                @i_num      = 105026
                /* 'Error en actualizacion de persona'*/
           return 105026
         end
      end
      else begin     
       
         --Secuencial
         exec 
         @w_error     = cobis..sp_cseqnos
         @t_debug     = 'N',
         @t_file      = null,
         @t_from      = @w_sp_name,
         @i_tabla     = 'cl_ente_bio',
         @o_siguiente = @w_secuencial out
         
         if @w_error <> 0 begin
            exec sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = @w_error
			return @w_error
         end
		 
         insert into cobis..cl_ente_bio
   	     (eb_secuencial, eb_ente,      eb_tipo_identificacion,    eb_cic,     eb_ocr,     eb_nro_emision,         eb_clave_elector,    eb_sin_huella_dactilar, eb_fecha_registro)
   	     values  
   	     (@w_secuencial, @i_persona,   @i_bio_tipo_identificacion,@i_bio_cic, @i_bio_ocr, @i_bio_numero_emision,  @i_bio_clave_lector, isnull(@i_bio_huella_dactilar,'N'), getdate())
           
         if @@error <> 0
         begin
            exec sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 105026
            /* 'Error en actualizacion de persona'*/
            return 105026
         end
		 
		 
		 insert into cobis..cl_ente_bio_his
	     (ebh_ssn,                            ebh_ente,              ebh_tipo_identificacion,     ebh_cic,
         ebh_ocr,                             ebh_nro_emision,       ebh_clave_elector,           ebh_sin_huella_dactilar,             
		 ebh_fecha_registro,                  ebh_fecha_vencimiento, ebh_anio_registro,           ebh_anio_emision,
		 ebh_fecha_modificacion,              ebh_transaccion,       ebh_usuario,                 ebh_terminal,
		 ebh_srv,                             ebh_lsrv)
	     values                               
	     (@s_ssn,                             @i_persona,            @i_bio_tipo_identificacion,  @i_bio_cic, 	         
		 @i_bio_ocr,                          @i_bio_numero_emision, @i_bio_clave_lector, 	      isnull(@i_bio_huella_dactilar,'N'),  
		 getdate(),                           null,                  null,                        null,
		 getdate(),                           'I',                   @s_user,                     @s_term,
		 @s_srv,                              @s_lsrv)
		  		  
		  
         if @@error <> 0
         BEGIN
           exec sp_cerror
                @t_debug    = @t_debug,
                @t_file     = @t_file,
               @t_from     = @w_sp_name,
                @i_num      = 105026
                /* 'Error en actualizacion de persona'*/
           return 105026
         end
      end
     
     -- Actualizacion Automatica de Prospecto a Cliente
	exec cobis..sp_seccion_validar
		@i_ente			= @i_persona,
		@i_operacion 	= 'V',
		@i_seccion 		= '1', --1 es Informacion General
		@i_completado 	= 'S'
     
     --Extraer estado para actualizar al guarda
     select @o_estado = ea_estado 
     from cl_ente_aux where ea_ente = @i_persona
     
     
     --Extraer vinculado para actualizar al guarda
     select @o_vinculado = en_vinculacion
     from cl_ente where en_ente = @i_persona
     
     
     --
     if @v_estado_civil = 'CA'
     begin
       delete cl_hijos where hi_ente= @i_persona
     END
     
          
     if ((@i_estado_civil <> 'UN') and (@i_estado_civil <> 'CA') and (@i_estado_civil<>null))
      begin
      
        SELECT @w_in_ente_d=in_ente_d FROM cobis..cl_instancia WHERE in_ente_i=@i_persona  
        UPDATE cobis..cl_ente SET p_estado_civil='SO' WHERE en_ente=@w_in_ente_d
         delete cobis..cl_instancia
        WHERE (in_ente_i   = @i_persona or in_ente_d = @i_persona)
        AND   in_relacion = @w_relacion_ca
     end

     -- EAN -- HISTORICO DE CAMBIOS DE SALARIO NETO DEL CLIENTE
     select @w_nomb_user = fu_nombre from cl_funcionario
     where fu_login = @s_user

     /*insert cl_hist_salario_neto(
            hs_trabajo, hs_ente,      hs_fecha_verif, hs_user,  hs_nombre_user, hs_hora,  hs_operacion, hs_sueldo,       hs_verificado, hs_origen)
     values(0,          @i_persona,   @s_date,        @s_user,  @w_nomb_user,  getdate(),     'U',     @i_ea_act_dol,   'N',  'persona')

     if @@error <> 0
     begin
          -- 'Error al insertar historico de cambios' --
          exec sp_cerror
               @t_debug    = @t_debug,
               @t_file     = @t_file,
               @t_from     = @w_sp_name,
               @i_num      = 103091          
          return 103091
     end*/
/* **************** SE COMENTA PARA FIE - JBA - MAY 28 2015 ****************
    -- INI VERIFICACION DE DATOS - AUTORIZACIONES
     if @i_verificado = 'S'
     begin
      exec @w_return = sp_autorizaciones
          @i_operacion    = 'V',
          @t_trn          = 1024,
          @i_cliente      = @i_persona,
          @i_tabla        = 'cl_ente'
     if @w_return <> 0
      begin
          exec sp_cerror
               @t_debug    = @t_debug,
               @t_file     = @t_file,
               @t_from     = @w_sp_name,
               @i_num      = 105093
               -- 'Error en actualizacion de compania'--
          return 1
      end
    end
    -- FIN VERIFICACION DE DATOS - AUTORIZACIONES
* ***************** SE COMENTA PARA FIE - JBA - MAY 28 2015 ***************/     
   /* Si cambia de oficial o se le asigna oficial */
     if @w_oficial <> null and @i_oficial <> null
      begin
         /* Si ya tenia oficial */
         if @v_oficial_ant <> null
         begin
         insert into cl_his_ejecutivo(ej_ente,
                       ej_funcionario,
                       ej_toficial,
                       ej_fecha_asig,
                       ej_fecha_registro)
                     select ej_ente,
                       ej_funcionario,
                       ej_toficial,
                       ej_fecha_asig,
                 @s_date

                  from cl_ejecutivo
                      where ej_ente = @i_persona
                   and ej_funcionario = @v_oficial_ant
           if @@error <> 0
            begin
               exec sp_cerror  @t_debug = @t_debug,
                     @t_file  = @t_file,
                     @t_from  = @w_sp_name,
                     @i_num   = 101117
               /* 'Error en insercion a historico'*/
               /* 'de ejecutivo'*/
               return 1
            end
           delete cl_ejecutivo
            where ej_ente = @i_persona
              and ej_funcionario = @v_oficial_ant
           if @@error <> 0 
            begin
               exec sp_cerror  @t_debug = @t_debug,
                     @t_file  = @t_file,
                     @t_from  = @w_sp_name,
                     @i_num   = 101118
               /* 'Error al eliminar ejecutivo'*/
               return 1
            end
           end
           insert into cl_ejecutivo(ej_ente,
                     ej_funcionario,
                     ej_toficial,
                     ej_fecha_asig)
                 values(@i_persona,
                   @i_oficial,
                   'G',
                   @s_date )

           if @@error <> 0
            begin
               exec sp_cerror
                  @t_debug    = @t_debug,
                  @t_file     = @t_file,
                  @t_from     = @w_sp_name,
                  @i_num      = 101116
                  /* 'Error en insercion de ejecutivo del ente'*/
               return 1

            end
      end

     --TRANSACCION DE SERVICIO - DATOS PREVIOS-PRMERA PARTE
      insert into ts_persona_prin (secuencia,     tipo_transaccion,    clase,               fecha,                 usuario, 
                              terminal,           srv,                 lsrv,                persona,               nombre, 
                              p_apellido,         s_apellido,          sexo,                cedula,                /*pasaporte,*/
                     tipo_ced,           pais,                profesion,           estado_civil,          actividad,
                              num_cargas,         nivel_ing,           nivel_egr,           tipo,                  filial, 
      oficina,            /*casilla_def,*/     /*tipo_dp,*/         fecha_nac,             grupo,
          oficial,            comentario,          retencion,           fecha_mod,             /*fecha_emision,*/
                              fecha_expira,       /*asosciada,*/       /*referido,*/        sector,                /*nit_per,*/ 
                          ciudad_nac,         /*lugar_doc,*/       nivel_estudio,       tipo_vivienda,         calif_cliente, 
                              /*doc_validado,*/   /*rep_superban,*/    /*vinculacion,*/     tipo_vinculacion,      /*exc_sipla,*/ 
                              /*exc_por2,*/       /*digito,*/          s_nombre,            c_apellido , secuen_alterno/*,          departamento,
                              num_orden,          promotor,            nacionalidad,        cod_otro_pais,         inss,
                              licencia,           ingre,               id_tutor,            nombre_tutor,          categoria,
            referidor_ecu,      carg_pub,            rel_carg_pub,        situacion_laboral,     bienes, 
                              otros_ingresos,     origen_ingresos,     estado_ea,           observacion_aut,       contrato_firmado, 
                              menor_edad,         conocido_como,       cliente_planilla,    cod_risk,              sector_eco,    
                              actividad_ea,       empadronado,         lin_neg,             seg_neg,               val_id_check,
                              ejecutivo_con,      suc_gestion,         constitucion,        remp_legal,            apoderado_legal,
                              act_comp_kyc,       fecha_act_kyc,       no_req_kyc_comp,     act_perfiltran,        fecha_act_perfiltran,
                              con_salario,        fecha_consal,        sin_salario,         fecha_sinsal,          actualizacion_cic,
                              fecha_act_cic,      fuente_ing,          act_prin,            detalle,               act_dol,
                              cat_aml,            discapacidad,        tipo_discapacidad,   ced_discapacidad,      nivel_egresos,
                 ifi,                asfi,                path_foto,           nit,                   nit_vencimiento*/,hora,
				              otro_profesion)

                      values (@s_ssn,                    @t_trn,                    'P',                         @s_date,                     @s_user, 
                              @s_term,                   @s_srv,                    @s_lsrv,                     @i_persona,                  @v_nombre, 
                              @v_p_apellido,             @v_s_apellido,             @v_sexo,                     @v_cedula,                   /*@v_pasaporte,*/
                              @v_tipo_ced,               @v_pais,                   @v_profesion,                @v_estado_civil,             @v_actividad,
                              @v_num_cargas,             @v_nivel_ing,              @v_nivel_egr,                @v_tipo,                     @w_filial,
                              @s_ofi,                /*null,*/                  /* null,*/                   @v_fecha_nac,                @v_grupo,
                              @v_oficial,                @v_comentario,             @v_retencion,                getdate(),                   /*@v_fecha_emision,*/ 
                              @v_fecha_expira,           /*@v_asosciada,*/          /*@v_referido,*/             @v_sector,                   /*@v_nit,*/ 
                              @v_ciudad_nac,             /*@v_lugar_doc,*/          @v_nivel_estudio,            @v_tipo_vivienda,            @v_calif_cliente, 
          /*@v_doc_validado,*/       /*@v_rep_superban,*/       /*@v_vinculacion,*/          @v_tipo_vinculacion,         /*@v_exc_sipla,*/ 
                              /*@v_exc_por2,*/           /*@v_digito,*/             @v_s_nombre,                 @v_c_apellido,                     1/*,             @v_depart_doc, 
                              @v_numord,                 @v_promotor,               @v_num_pais_nacionalidad,    @v_cod_otro_pais,            @v_inss, 
                              @v_licencia,               @v_ingre,                  @v_en_id_tutor,              @v_en_nom_tutor,             @v_categoria, 
                   @i_referidor_ecu,          @i_carg_pub,               @i_rel_carg_pub,             @v_situacion_laboral,        @v_bienes, 
                              @v_otros_ingresos,         @v_origen_ingresos,        @v_ea_estado,                @v_ea_observacion_aut,       @v_ea_contrato_firmado, 
                              @v_ea_menor_edad,          @v_ea_conocido_como,       @v_ea_cliente_planilla,      @v_ea_cod_risk,              @v_ea_sector_eco, 
                              @v_ea_actividad,           @v_ea_empadronado,         @v_ea_lin_neg,               @v_ea_seg_neg,               @v_ea_val_id_check, 
                              @v_ea_ejecutivo_con,       @v_ea_suc_gestion,         @v_ea_constitucion,          @v_ea_remp_legal,            @v_ea_apoderado_legal,        
                              @v_ea_act_comp_kyc,        @v_ea_fecha_act_kyc,       @v_ea_no_req_kyc_comp,       @v_ea_act_perfiltran,        @v_ea_fecha_act_perfiltran,   
                              @v_ea_con_salario,         @v_ea_fecha_consal,        @v_ea_sin_salario,           @v_ea_fecha_sinsal,          @v_ea_actualizacion_cic,      
                              @v_ea_fecha_act_cic,       @v_ea_fuente_ing,          @v_ea_act_prin,              @v_ea_detalle,               @v_ea_act_dol,
                              @v_ea_cat_aml,             @v_ea_discapacidad,        @v_ea_tipo_discapacidad,     @v_ea_ced_discapacidad,      @v_egresos,                   
                              @v_ifi,                    @v_asfi,                   @v_path_foto,                @v_nit_id,                   @v_nit_venc*/, getdate(),
							  @v_otro_profesion)

     if @@error <> 0
        begin
           exec sp_cerror
              @t_debug    = @t_debug,
              @t_file     = @t_file,
              @t_from     = @w_sp_name,
              @i_num      = 103005
           --ERROR EN CREACION DE TRANSACCION DE SERVICIO
 return 1
        end

      --TRANSACCION DE SERVICIO - DATOS PREVIOS-SEGUNDA PARTE
      insert into ts_persona_sec (secuencia,      tipo_transaccion,    clase,               fecha,                 usuario, 
                              terminal,           srv,                 lsrv,                persona,               nombre, 
                              p_apellido,         s_apellido,          /*sexo,              cedula,                pasaporte,
                              tipo_ced,           pais,                profesion,           estado_civil,          actividad,
                              num_cargas,         nivel_ing,           nivel_egr,           tipo,                  filial, 
                              oficina,            casilla_def,         tipo_dp,             fecha_nac,             grupo,
                              oficial,            comentario,          retencion,           fecha_mod,             fecha_emision,
                              fecha_expira,       asosciada,           referido,            sector,                nit_per, 
                              ciudad_nac,         lugar_doc,           nivel_estudio,       tipo_vivienda,         calif_cliente, 
                              doc_validado,       rep_superban,        vinculacion,         tipo_vinculacion,      exc_sipla, 
                              exc_por2,           digito,              s_nombre,            c_apellido,            departamento, 
                              num_orden,          promotor,            nacionalidad,        cod_otro_pais,         inss,
                              licencia,*/         ingre,             id_tutor,            nombre_tutor,          /*categoria,*/ 
                   /*referidor_ecu,    carg_pub,            rel_carg_pub,        situacion_laboral,*/   bienes, 
                              /*otros_ingresos,   origen_ingresos,*/   estado_ea,           /*observacion_aut,*/   /*contrato_firmado,*/ 
                              menor_edad,         conocido_como,       cliente_planilla,    cod_risk,              sector_eco,    
                              actividad_ea,       /*empadronado,*/     lin_neg,             seg_neg,               /*val_id_check,*/
                              /*ejecutivo_con,    suc_gestion,         constitucion,*/      remp_legal,            apoderado_legal,
                              /*act_comp_kyc,     fecha_act_kyc,       no_req_kyc_comp,     act_perfiltran,        fecha_act_perfiltran,*/
                              /*con_salario,      fecha_consal,        sin_salario,         fecha_sinsal,          actualizacion_cic,
                              fecha_act_cic,*/    fuente_ing,          act_prin,            detalle,               /*act_dol,*/
                              cat_aml,            discapacidad,        tipo_discapacidad,   ced_discapacidad,      nivel_egresos,
        ifi,                asfi,                /*path_foto,*/       nit,                   nit_vencimiento, secuen_alterno2, oficina, hora, 
							  colectivo,          nivel_colectivo)

                      values (@s_ssn,                  @t_trn,                    'P',                         @s_date,                     @s_user, 
                              @s_term,                   @s_srv,                    @s_lsrv,                     @i_persona,                  @v_nombre, 
                              @v_p_apellido,             @v_s_apellido,             /*@v_sexo,                   @v_cedula,                   @v_pasaporte,
                              @v_tipo_ced,               @v_pais,                   @v_profesion,                @v_estado_civil,             @v_actividad,
                              @v_num_cargas,             @v_nivel_ing,              @v_nivel_egr,                @v_tipo,                     @w_filial,
                              @s_ofi,                null,                      null,                        @v_fecha_nac,                @v_grupo,
                              @v_oficial,                @v_comentario,             @v_retencion,                getdate(),                   @v_fecha_emision, 
                              @v_fecha_expira,           @v_asosciada,              @v_referido,                 @v_sector,                   @v_nit, 
                              @v_ciudad_nac,             @v_lugar_doc,              @v_nivel_estudio,            @v_tipo_vivienda,            @v_calif_cliente, 
                              @v_doc_validado,           @v_rep_superban,           @v_vinculacion,              @v_tipo_vinculacion,         @v_exc_sipla, 
                              @v_exc_por2,               @v_digito,                 @v_s_nombre,                 @v_c_apellido,               @v_depart_doc, 
                              @v_numord,                 @v_promotor,               @v_num_pais_nacionalidad,    @v_cod_otro_pais,            @v_inss, 
                              @v_licencia,*/             @v_ingre,                  @v_en_id_tutor,              @v_en_nom_tutor,             /*@v_categoria,*/ 
                              /*@i_referidor_ecu,*/      /*@i_carg_pub,*/           /*@i_rel_carg_pub,*/         /*@v_situacion_laboral,*/    @v_bienes, 
                              /*@v_otros_ingresos,*/     /*@v_origen_ingresos,*/    @v_ea_estado,                /*@v_ea_observacion_aut,*/   /*@v_ea_contrato_firmado,*/ 
  @v_ea_menor_edad,          @v_ea_conocido_como,       @v_ea_cliente_planilla,      @v_ea_cod_risk,              @v_ea_sector_eco, 
                              @v_ea_actividad,           /*@v_ea_empadronado,*/     @v_ea_lin_neg,               @v_ea_seg_neg,               /*@v_ea_val_id_check,*/ 
                              /*@v_ea_ejecutivo_con,*/   /*@v_ea_suc_gestion,*/     /*@v_ea_constitucion,*/      @v_ea_remp_legal,            @v_ea_apoderado_legal,        
                              /*@v_ea_act_comp_kyc,*/    /*@v_ea_fecha_act_kyc,*/   /*@v_ea_no_req_kyc_comp,*/   /*@v_ea_act_perfiltran,*/    /*@v_ea_fecha_act_perfiltran,*/   
            /*@v_ea_con_salario,*/     /*@v_ea_fecha_consal,*/    /*@v_ea_sin_salario,*/       /*@v_ea_fecha_sinsal,*/      /*@v_ea_actualizacion_cic,*/      
                              /*@v_ea_fecha_act_cic,*/   @v_ea_fuente_ing,          @v_ea_act_prin,              @v_ea_detalle,               /*@v_ea_act_dol,*/
                              @v_ea_cat_aml,             @v_ea_discapacidad,        @v_ea_tipo_discapacidad,     @v_ea_ced_discapacidad,      @v_egresos,                   
                              @v_ifi,                    @v_asfi,                   /*@v_path_foto,*/            @v_nit_id,                   @v_nit_venc,2, @s_ofi, getdate(), 
							  @v_ea_colectivo,           @v_ea_nivel_colectivo)


     if @@error <> 0
     begin
   exec sp_cerror
     @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = 103005
         /*'Error en creacion de transaccion de servicio'*/
   return 1
     end

      --TRANSACCION DE SERVICIO - DATOS ACTUALES-PRIMERA PARTE
      insert into ts_persona_prin (secuencia,      tipo_transaccion,   clase,               fecha,                 usuario, 
                              terminal,           srv,                 lsrv,                persona,               nombre, 
                              p_apellido,         s_apellido,          sexo,                cedula,                /*pasaporte,*/
                              tipo_ced,           pais,                profesion,           estado_civil,          actividad,
                              num_cargas,         nivel_ing,           nivel_egr,           tipo,                  filial, 
                              oficina,            /*casilla_def,*/     /*tipo_dp,*/         fecha_nac,             grupo,
                              oficial,            comentario,          retencion,           fecha_mod,             /*fecha_emision,*/
                              fecha_expira,       /*asosciada,*/       /*referido,*/        sector,                /*nit_per,*/ 
                              ciudad_nac,         /*lugar_doc,*/       nivel_estudio,       tipo_vivienda,         calif_cliente, 
                              /*doc_validado,*/   /*rep_superban,*/    /*vinculacion,*/     tipo_vinculacion,      /*exc_sipla,*/ 
                              /*exc_por2,*/       /*digito,*/          s_nombre,            c_apellido,             secuen_alterno/*,          departamento,
                              num_orden,          promotor,            nacionalidad,        cod_otro_pais,         inss,
                              licencia,           ingre,               id_tutor,            nombre_tutor,          categoria, 
                              referidor_ecu,      carg_pub,            rel_carg_pub,        situacion_laboral,     bienes, 
                              otros_ingresos,     origen_ingresos,     estado_ea,           observacion_aut,       contrato_firmado, 
                              menor_edad,         conocido_como,       cliente_planilla,    cod_risk,              sector_eco,    
                              actividad_ea,       empadronado,         lin_neg,             seg_neg,               val_id_check,
                              ejecutivo_con,      suc_gestion,         constitucion,        remp_legal,            apoderado_legal,
                              act_comp_kyc,       fecha_act_kyc,       no_req_kyc_comp,     act_perfiltran,        fecha_act_perfiltran,
                              con_salario,        fecha_consal,        sin_salario,         fecha_sinsal,          actualizacion_cic,
                              fecha_act_cic,      fuente_ing,          act_prin,            detalle,               act_dol,
                              cat_aml,            discapacidad,        tipo_discapacidad,   ced_discapacidad,      nivel_egresos,
                              ifi,                asfi,                path_foto,           nit,                   nit_vencimiento*/, hora,
							  otro_profesion)

                      values (@s_ssn,                    @t_trn,                    'A',                         @s_date,                      @s_user, 
                              @s_term,                   @s_srv,                    @s_lsrv,                     @i_persona,                   @w_nombre, 
                              @w_p_apellido,             @w_s_apellido,             @w_sexo,                     @w_cedula,                    /*@w_pasaporte,*/
                              @w_tipo_ced,               @w_pais,                   @w_profesion,                @w_estado_civil,              @w_actividad,
                              @w_num_cargas,             @w_nivel_ing,              @w_nivel_egr,                @w_tipo,                      @w_filial,
                          @s_ofi,                /*null,*/                  /*null,*/                    @w_fecha_nac,                 @w_grupo,
                              @w_oficial,                @w_comentario,             @w_retencion,                getdate(),                    /*@w_fecha_emision,*/ 
                              @w_fecha_expira,           /*@w_asosciada,*/          /*@w_referido,*/             @w_sector,                    /*@w_nit,*/ 
                              @w_ciudad_nac,             /*@w_lugar_doc,*/          @w_nivel_estudio,            @w_tipo_vivienda,             @w_calif_cliente, 
                              /*@w_doc_validado,*/       /*@w_rep_superban,*/       /*@w_vinculacion,*/          @w_tipo_vinculacion,          /*@w_exc_sipla,*/ 
                              /*@w_exc_por2,*/           /*@w_digito,*/             @w_s_nombre,                 @w_c_apellido,                 1 /*,              @w_depart_doc, 
                @w_numord,                 @w_promotor,               @w_num_pais_nacionalidad,    @w_cod_otro_pais,             @w_inss, 
                              @w_licencia,               @w_ingre,                  @w_en_id_tutor,              @w_en_nom_tutor,              @w_categoria,
                              @i_referidor_ecu,          @i_carg_pub,               @i_rel_carg_pub,             @w_situacion_laboral,         @w_bienes, 
                              @w_otros_ingresos,         @w_origen_ingresos,        @w_ea_estado,                @w_ea_observacion_aut,        @w_ea_contrato_firmado, 
                              @w_ea_menor_edad,          @w_ea_conocido_como,       @w_ea_cliente_planilla,      @w_ea_cod_risk,               @w_ea_sector_eco, 
                              @w_ea_actividad,           @w_ea_empadronado,         @w_ea_lin_neg,               @w_ea_seg_neg,                @w_ea_val_id_check,
                              @w_ea_ejecutivo_con,       @w_ea_suc_gestion,         @w_ea_constitucion,          @w_ea_remp_legal,             @w_ea_apoderado_legal,
                              @w_ea_act_comp_kyc,        @w_ea_fecha_act_kyc,       @w_ea_no_req_kyc_comp,       @w_ea_act_perfiltran,         @w_ea_fecha_act_perfiltran,
                              @w_ea_con_salario,         @w_ea_fecha_consal,        @w_ea_sin_salario,           @w_ea_fecha_sinsal,           @w_ea_actualizacion_cic,
                              @w_ea_fecha_act_cic,       @w_ea_fuente_ing,          @w_ea_act_prin,              @w_ea_detalle,                @w_ea_act_dol,
                              @w_ea_cat_aml,             @w_ea_discapacidad,        @w_ea_tipo_discapacidad,     @w_ea_ced_discapacidad,       @w_egresos,
                              @w_ifi,             @w_asfi,                   @w_path_foto,                @w_nit_id,                    @w_nit_venc*/, getdate(),
	                          @w_otro_profesion) 

     if @@error <> 0
     begin
   exec sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
   @t_from     = @w_sp_name,
      @i_num      = 103005
         /*'Error en creacion de transaccion de servicio'*/
   return 1
     end

      
     --TRANSACCION DE SERVICIO - DATOS ACTUALES-SEGUNDA PARTE
     insert into ts_persona_sec (secuencia,      tipo_transaccion,    clase,               fecha,                 usuario, 
                              terminal,           srv,                 lsrv,                persona,               nombre, 
                              p_apellido,         s_apellido,          /*sexo,              cedula,                pasaporte,
                              tipo_ced,           pais,                profesion,           estado_civil,          actividad,
                              num_cargas,         nivel_ing,           nivel_egr,           tipo,                  filial, 
                              oficina,            casilla_def,         tipo_dp,             fecha_nac,             grupo,
                              oficina,            casilla_def,         tipo_dp,             fecha_nac,             grupo,
                              oficial,            comentario,          retencion,           fecha_mod,             fecha_emision,
                              fecha_expira,       asosciada,           referido,            sector,                nit_per,
                              ciudad_nac,         lugar_doc,           nivel_estudio,       tipo_vivienda,         calif_cliente, 
                              doc_validado,       rep_superban,        vinculacion,         tipo_vinculacion,      exc_sipla, 
                              exc_por2,           digito,              s_nombre,            c_apellido,            departamento,
                              num_orden,          promotor,            nacionalidad,        cod_otro_pais,         inss,
                              licencia,*/         ingre,               id_tutor,            nombre_tutor,   /*categoria, */
                              /*referidor_ecu,    carg_pub,            rel_carg_pub,        situacion_laboral,*/   bienes, 
                              /*otros_ingresos,   origen_ingresos,*/   estado_ea,           /*observacion_aut,*/   /*contrato_firmado,*/ 
                              menor_edad,         conocido_como,       cliente_planilla,    cod_risk,              sector_eco,    
                              actividad_ea,       /*empadronado,*/     lin_neg,             seg_neg,               /*val_id_check,*/
                              /*ejecutivo_con,    suc_gestion,         constitucion,*/      remp_legal,            apoderado_legal,
                              /*act_comp_kyc,     fecha_act_kyc,       no_req_kyc_comp,     act_perfiltran,        fecha_act_perfiltran,*/
                              /*con_salario,      fecha_consal,        sin_salario,         fecha_sinsal,          actualizacion_cic,
                              fecha_act_cic,*/    fuente_ing,          act_prin,            detalle,               /*act_dol,*/
                              cat_aml,            discapacidad,        tipo_discapacidad,   ced_discapacidad,      nivel_egresos,
                              ifi,                asfi,                /*path_foto,*/       nit,                   nit_vencimiento, secuen_alterno2, oficina, hora, 
							  colectivo,          nivel_colectivo)

                      values (@s_ssn,                    @t_trn,                    'A',                         @s_date,                      @s_user, 
                              @s_term,                   @s_srv,                    @s_lsrv,                     @i_persona,                   @w_nombre, 
                              @w_p_apellido,             @w_s_apellido,             /*@w_sexo,                   @w_cedula,                    @w_pasaporte,
                              @w_tipo_ced,               @w_pais,                   @w_profesion,                @w_estado_civil,              @w_actividad,
                              @w_num_cargas,             @w_nivel_ing,              @w_nivel_egr,                @w_tipo,                      @w_filial,
                              @s_ofi,                    null,                      null,                        @w_fecha_nac,                 @w_grupo,
                              @w_oficial,                @w_comentario,             @w_retencion,                getdate(),                    @w_fecha_emision, 
                              @w_fecha_expira,           @w_asosciada,              @w_referido,                 @w_sector,                    @w_nit, 
                              @w_ciudad_nac,             @w_lugar_doc,              @w_nivel_estudio,            @w_tipo_vivienda,             @w_calif_cliente, 
                              @w_doc_validado,           @w_rep_superban,           @w_vinculacion,              @w_tipo_vinculacion,          @w_exc_sipla, 
                              @w_exc_por2,               @w_digito,                 @w_s_nombre,                 @w_c_apellido,                @w_depart_doc, 
                              @w_numord,                 @w_promotor,               @w_num_pais_nacionalidad,    @w_cod_otro_pais,             @w_inss, 
                              @w_licencia,*/             @w_ingre,                  @w_en_id_tutor,              @w_en_nom_tutor,              /*@w_categoria,*/
                             /*@i_referidor_ecu,*/      /*@i_carg_pub,*/           /*@i_rel_carg_pub,*/         /*@w_situacion_laboral,*/     @w_bienes, 
                              /*@w_otros_ingresos,*/     /*@w_origen_ingresos,*/    @w_ea_estado,                /*@w_ea_observacion_aut,*/    /*@w_ea_contrato_firmado,*/ 
                              @w_ea_menor_edad,          @w_ea_conocido_como,       @w_ea_cliente_planilla,      @w_ea_cod_risk,               @w_ea_sector_eco, 
                              @w_ea_actividad,           /*@w_ea_empadronado,*/     @w_ea_lin_neg,               @w_ea_seg_neg,                /*@w_ea_val_id_check,*/
                              /*@w_ea_ejecutivo_con,*/   /*@w_ea_suc_gestion,*/     /*@w_ea_constitucion,*/      @w_ea_remp_legal,             @w_ea_apoderado_legal,
                              /*@w_ea_act_comp_kyc,*/    /*@w_ea_fecha_act_kyc,*/   /*@w_ea_no_req_kyc_comp,*/   /*@w_ea_act_perfiltran,*/     /*@w_ea_fecha_act_perfiltran,*/
                              /*@w_ea_con_salario,*/     /*@w_ea_fecha_consal,*/    /*@w_ea_sin_salario,*/       /*@w_ea_fecha_sinsal,*/       /*@w_ea_actualizacion_cic,*/
                              /*@w_ea_fecha_act_cic,*/   @w_ea_fuente_ing,          @w_ea_act_prin,              @w_ea_detalle,                /*@w_ea_act_dol,*/
                              @w_ea_cat_aml,             @w_ea_discapacidad,        @w_ea_tipo_discapacidad,     @w_ea_ced_discapacidad,       @w_egresos,
                              @w_ifi,                    @w_asfi,                   /*@w_path_foto,*/            @w_nit_id,                    @w_nit_venc, 2, @s_ofi, getdate(),
							  @w_ea_colectivo,           @w_ea_nivel_colectivo) 

     if @@error <> 0
      begin
         exec sp_cerror  @t_debug    = @t_debug,
               @t_file     = @t_file,
               @t_from     = @w_sp_name,
               @i_num      = 103005
         /* 'Error en creacion de transaccion de servicio'*/
         return 1
           end

     if @v_nombre <> @w_nombre
          begin
             insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
             values
                   (@i_persona, @s_date,'cl_ente',
                             'en_nombre', @v_nombre, @w_nombre,
                             'U', null, null, getdate())
             if @@error <> 0
             begin
               exec sp_cerror
            @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 103001
          return 1 /*'Error en creacion de cliente'*/
             end
          end     
   
     if @v_p_apellido <> @w_p_apellido
     begin
        insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
   ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
        values
                             (@i_persona, @s_date,'cl_ente',
                             'p_p_apellido', @v_p_apellido, @w_p_apellido,
                             'U', null, null, getdate())
        if @@error <> 0
        begin
               exec sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 103001
                    return 1 /*'Error en creacion de cliente'*/
        end
     end
     if @v_s_apellido <> @w_s_apellido
     begin
             insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
             values
    (@i_persona, @s_date,'cl_ente',
                             'p_s_apellido', @v_s_apellido, @w_s_apellido,
                             'U', null, null, getdate())
             if @@error <> 0
             begin
               exec sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 103001
                    return 1 /*'Error en creacion de cliente'*/
             end 
     end
     if @v_nomlar <> @w_nomlar
     begin
             insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
             values
                             (@i_persona, @s_date,'cl_ente',
                             'en_nomlar', @v_nomlar, @w_nomlar,
                             'U', null, null, getdate())
             if @@error <> 0
             begin
               exec sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 103001
                    return 1 /*'Error en creacion de cliente'*/
             end
     end
     if @v_tipo_ced <> @w_tipo_ced
     begin
        insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
             values
                             (@i_persona, @s_date,'cl_ente',
                             'en_tipo_ced', @v_tipo_ced, @w_tipo_ced,
                             'U', null, null, getdate())
             if @@error <> 0
             begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                     return 1 /*'Error en creacion de cliente'*/
             end        
     end
       
     if @v_cedula <> @w_cedula
     begin
             insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
   ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
             values
                             (@i_persona, @s_date,'cl_ente',
              'en_ced_ruc', @v_cedula, @w_cedula,
                             'U', null, null, getdate())
             if @@error <> 0
             begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
               return 1 /*'Error en creacion de cliente'*/
             end
             update cl_cliente
             set cl_ced_ruc = isnull(@w_cedula,cl_ced_ruc)
        where cl_cliente = @i_persona
             if @@error <> 0
  begin
                exec sp_cerror
        @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 105026
                    /* 'Error en actualizacion de persona'*/
                     return 1
        end 
          end
     if @v_retencion <> @w_retencion 
     begin
             insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
             values
                             (@i_persona, @s_date,'cl_ente',
                             'en_retencion', @v_retencion, @w_retencion,
                             'U', null, null, getdate())
   if @@error <> 0
             begin
                exec sp_cerror
            @t_debug    = @t_debug,
                 @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                     return 1 /*'Error en creacion de cliente'*/
             end
     end
     if @v_actividad <> @w_actividad
     begin
             insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
             values
                             (@i_persona, @s_date,'cl_ente',
    'en_actividad', @v_actividad, @w_actividad,
                             'U', null, null, getdate())
             if @@error <> 0
             begin
               exec sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 103001
               return 1 /*'Error en creacion de cliente'*/
             end
     end
     if @v_situacion_cliente <> @w_situacion_cliente
     begin
             insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
             values
                             (@i_persona, @s_date,'cl_ente',
                             'en_situacion_cliente', @v_situacion_cliente, @w_situacion_cliente,
                             'U', null, null, getdate())
             if @@error <> 0
             begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
             end
     end

      if @v_s_nombre <> @w_s_nombre
          begin
             insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
             values
         (@i_persona, @s_date,'cl_ente',
                             'p_s_nombre', @v_s_nombre, @w_s_nombre,
                             'U', null, null, getdate())
             if @@error <> 0
             begin
               exec sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 103001
               return 1 /*'Error en creacion de cliente'*/
             end
          end   

     if @v_c_apellido <> @w_c_apellido
          begin
             insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
     ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
             values
                             (@i_persona, @s_date,'cl_ente',
                  'p_c_apellido', @v_c_apellido, @w_c_apellido,
                             'U', null, null, getdate())
             if @@error <> 0
             begin
               exec sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 103001
               return 1 /*'Error en creacion de cliente'*/
             end
          end   

     if @v_depart_doc <> @w_depart_doc
          begin
             insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
             values
                             (@i_persona, @s_date,'cl_ente',
                      'p_dep_doc', convert(varchar(3),@v_depart_doc), convert(varchar(3),@w_depart_doc),
                             'U', null, null, getdate())
             if @@error <> 0
             begin
               exec sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 103001
               return 1 /*'Error en creacion de cliente'*/
             end
          end   

       if @v_numord <> @w_numord
          begin
             insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                  ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
             values
                             (@i_persona, @s_date,'cl_ente',
                             'p_dep_doc', @v_numord, @w_numord,
                             'U', null, null, getdate())
             if @@error <> 0
             begin
               exec sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 103001
               return 1 /*'Error en creacion de cliente'*/
             end
          end   

        if @v_promotor <> @w_promotor
          begin
             insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
             values
                             (@i_persona, @s_date,'cl_ente',
                             'en_promotor', @v_promotor, @w_promotor,
                             'U', null, null, getdate())
             if @@error <> 0
             begin
               exec sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 103001
               return 1 /*'Error en creacion de cliente'*/
             end
          end   

        if @v_ingre <> @w_ingre
    begin
             insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
             values
                            (@i_persona, @s_date,'cl_ente',
             'en_ingre', '@v_ingre', '@w_ingre',
                             'U', null, null, getdate())
             if @@error <> 0
          begin
               exec sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 103001
               return 1 /*'Error en creacion de cliente'*/
             end
          end   

     if @v_num_pais_nacionalidad <> @w_num_pais_nacionalidad
          begin
             insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                 ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
             values
                             (@i_persona, @s_date,'cl_ente',
                              'en_nacionalidad', '@v_num_pais_nacionalidad','@w_num_pais_nacionalidad',
                             'U', null, null, getdate())
             if @@error <> 0
             begin
               exec sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 103001
               return 1 /*'Error en creacion de cliente'*/
             end
          end  
   
   if @v_cod_otro_pais <> @w_cod_otro_pais
          begin
             insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
             values
                             (@i_persona, @s_date,'cl_ente',
                              'en_cod_otro_pais', '@v_cod_otro_pais','@w_cod_otro_pais',
                             'U', null, null, getdate())
             if @@error <> 0
             begin
               exec sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
  @t_from     = @w_sp_name,
                    @i_num      = 103001
               return 1 /*'Error en creacion de cliente'*/
             end
          end  

        if @v_inss <> @w_inss
          begin
             insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
             values
                             (@i_persona, @s_date,'cl_ente',
                              'en_inss', '@v_inss','@w_inss',
                             'U', null, null, getdate())
             if @@error <> 0
             begin
               exec sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 103001
               return 1 /*'Error en creacion de cliente'*/
             end
          end      

   if @v_licencia <> @w_licencia
          begin
             insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
             values
                             (@i_persona, @s_date,'cl_ente',
                              'en_licencia', '@v_licencia','@w_licencia',
                             'U', null, null, getdate())
             if @@error <> 0
             begin
               exec sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 103001
               return 1 /*'Error en creacion de cliente'*/
             end
          end      

       if @v_ea_estado <> @w_ea_estado
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                        (@i_persona, @s_date,'cl_ente_aux',
                             'ea_estado', @v_ea_estado, @w_ea_estado,
                             'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
            @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end

      if @v_ea_contrato_firmado <> @w_ea_contrato_firmado
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
                             'ea_contrato_firmado', @v_ea_contrato_firmado, @w_ea_contrato_firmado,
                             'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
      @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end

      if @v_ea_menor_edad <> @w_ea_menor_edad
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
         'ea_menor_edad', @v_ea_menor_edad, @w_ea_menor_edad,
                             'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end

      if @v_ea_conocido_como <> @w_ea_conocido_como
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
                             'ea_conocido_como', @v_ea_conocido_como, @w_ea_conocido_como,
                             'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end
       
      if @v_ea_cliente_planilla <> @w_ea_cliente_planilla
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
      ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
                             'ea_cliente_planilla', @v_ea_cliente_planilla, @w_ea_cliente_planilla,
                             'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
          @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
   end
      end
       
      if @v_ea_cod_risk <> @w_ea_cod_risk
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
           ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
                             'ea_cod_risk', @v_ea_cod_risk, @w_ea_cod_risk,
                             'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
          @t_file     = @t_file,
  @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end

      if @v_ea_sector_eco <> @w_ea_sector_eco
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
                             'ea_sector_eco', @v_ea_sector_eco, @w_ea_sector_eco,
                             'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
              @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end

      if @v_ea_actividad <> @w_ea_actividad
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
                             'ea_actividad', @v_ea_actividad, @w_ea_actividad,
                             'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end

      if @v_ea_empadronado <> @w_ea_empadronado
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
                             'ea_empadronado', @v_ea_empadronado, @w_ea_empadronado,
                             'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end

      if @v_ea_lin_neg <> @w_ea_lin_neg
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
                             'ea_lin_neg', @v_ea_lin_neg, @w_ea_lin_neg,
                             'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                   @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
           @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end

      if @v_ea_seg_neg <> @w_ea_seg_neg
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
                             'ea_seg_neg', @v_ea_seg_neg, @w_ea_seg_neg,
      'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end
       
      if @v_ea_val_id_check <> @w_ea_val_id_check
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
                             'ea_val_id_check', @v_ea_val_id_check, @w_ea_val_id_check,
                             'U', null, null, getdate())
              if @@error <> 0
            begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end

      if @v_ea_ejecutivo_con <> @w_ea_ejecutivo_con
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
                             'ea_ejecutivo_con', convert(varchar, @v_ea_ejecutivo_con), convert(varchar, @w_ea_ejecutivo_con),
                             'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end

      if @v_ea_suc_gestion <> @w_ea_suc_gestion
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
   (@i_persona, @s_date,'cl_ente_aux',
                             'ea_suc_gestion', convert(varchar, @v_ea_suc_gestion), convert(varchar, @w_ea_suc_gestion),
                             'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end

      if @v_ea_constitucion <> @w_ea_constitucion
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                        (@i_persona, @s_date,'cl_ente_aux',
                             'ea_constitucion', convert(varchar, @v_ea_constitucion), convert(varchar, @w_ea_constitucion),
                             'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
             @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end

      if @v_ea_remp_legal <> @w_ea_remp_legal
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                        (@i_persona, @s_date,'cl_ente_aux',
                             'ea_remp_legal', convert(varchar, @v_ea_remp_legal), convert(varchar, @w_ea_remp_legal),
                             'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end
       
      if @v_ea_apoderado_legal <> @w_ea_apoderado_legal
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
        ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
                             'ea_apoderado_legal', convert(varchar, @v_ea_apoderado_legal), convert(varchar, @w_ea_apoderado_legal),
                             'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end

      if @v_ea_act_comp_kyc <> @w_ea_act_comp_kyc
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
                             'ea_act_comp_kyc', @v_ea_act_comp_kyc, @w_ea_act_comp_kyc,
                             'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end

      if @v_ea_fecha_act_kyc <> @w_ea_fecha_act_kyc
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
                             'ea_fecha_act_kyc', @v_ea_fecha_act_kyc, @w_ea_fecha_act_kyc,
                             'U', null, null, getdate())
  if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end
       
      if @v_ea_no_req_kyc_comp <> @w_ea_no_req_kyc_comp
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
                             'ea_no_req_kyc_comp', @v_ea_no_req_kyc_comp, @w_ea_no_req_kyc_comp,
                             'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end

      if @v_ea_act_perfiltran <> @w_ea_act_perfiltran
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
                             'ea_act_perfiltran', @v_ea_act_perfiltran, @w_ea_act_perfiltran,
  'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end
     
      if @v_ea_fecha_act_perfiltran <> @w_ea_fecha_act_perfiltran
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
                             'ea_fecha_act_perfiltran', @v_ea_fecha_act_perfiltran, @w_ea_fecha_act_perfiltran,
                             'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end
     
      if @v_ea_con_salario <> @w_ea_con_salario
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
                             'ea_con_salario', @v_ea_con_salario, @w_ea_con_salario,
                             'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end

      if @v_ea_fecha_consal <> @w_ea_fecha_consal
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
       ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
                             'ea_fecha_consal', @v_ea_fecha_consal, @w_ea_fecha_consal,
                             'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end
       
      if @v_ea_sin_salario <> @w_ea_sin_salario
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
                             'ea_sin_salario', @v_ea_sin_salario, @w_ea_sin_salario,
                             'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end
       
      if @v_ea_fecha_sinsal <> @w_ea_fecha_sinsal
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
          values
                             (@i_persona, @s_date,'cl_ente_aux',
                             'ea_fecha_sinsal', @v_ea_fecha_sinsal, @w_ea_fecha_sinsal,
                             'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end
       
      if @v_ea_actualizacion_cic <> @w_ea_actualizacion_cic
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
                             'ea_actualizacion_cic', @v_ea_actualizacion_cic, @w_ea_actualizacion_cic,
                             'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end

      if @v_ea_fecha_act_cic <> @w_ea_fecha_act_cic
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
                             'ea_fecha_act_cic', @v_ea_fecha_act_cic, @w_ea_fecha_act_cic,
                             'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
    @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
                     @i_num      = 103001
           return 1 /*'Error en creacion de cliente'*/
              end
      end

      if @v_ea_fuente_ing <> @w_ea_fuente_ing
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
                             'ea_fuente_ing', @v_ea_fuente_ing, @w_ea_fuente_ing,
                             'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
      @t_debug    = @t_debug,
                     @t_file     = @t_file,
      @t_from     = @w_sp_name,
               @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end
       
      if @v_ea_act_prin <> @w_ea_act_prin
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
                             'ea_act_prin', @v_ea_act_prin, @w_ea_act_prin,
                    'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end

      if @v_ea_detalle <> @w_ea_detalle
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
                             'ea_detalle', @v_ea_detalle, @w_ea_detalle,
                             'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end
       
      if @v_ea_act_dol <> @w_ea_act_dol
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
                             'ea_act_dol', @v_ea_act_dol, @w_ea_act_dol,
                             'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end

      if @v_ea_cat_aml <> @w_ea_cat_aml
      begin
              insert into cl_actualiza (ac_ente, ac_fecha, ac_tabla,
                             ac_campo, ac_valor_ant, ac_valor_nue,
                             ac_transaccion, ac_secuencial1, ac_secuencial2, ac_hora)
              values
                             (@i_persona, @s_date,'cl_ente_aux',
                         'ea_cat_aml', @v_ea_cat_aml, @w_ea_cat_aml,
        'U', null, null, getdate())
              if @@error <> 0
              begin
                exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103001
                return 1 /*'Error en creacion de cliente'*/
              end
      end
       
         --*-----------------------------------------------------------------------------------*--
         --* REALIZA EL REGISTRO DEL HISTORICO DE IDENTIFICACIONES  
         --* GDE -- CONTROL DE CAMBIOS CLIENTES
         --*-----------------------------------------------------------------------------------*--
          if (@v_tipo_ced is not null  and @w_tipo_ced is not null ) or (@v_cedula is not null and @w_cedula is not null) 
          begin
         select @w_tipo_ced = isnull(@i_tipo_ced, @v_tipo_ced)
         select @w_cedula = isnull(@i_cedula, @v_cedula)
       if (((@v_cedula <> @w_cedula) or (@v_tipo_ced <> @w_tipo_ced)) and (@w_cedula is not null and @w_tipo_ced is not null)  )  
         begin
             exec @w_return = cobis..sp_registra_ident              
                   @s_user           = @s_user,
                   @t_trn            = 1037,
                   @i_operacion      = 'I',
                   @i_ente           = @i_persona,   
                   @i_tipo_iden      = @w_tipo_ced,
                   @i_identificacion = @w_cedula
             if @w_return <> 0
                begin     
                   return 1
                 
                end      
                
         end 		
        end
		
	exec @w_return = cobis..sp_ente_upd                  
        @s_user           = @s_user,
          @i_operacion      = 'U',
          @i_ente           = @i_persona
    if @w_return <> 0
    begin     
       return 1                 
    end
    commit tran
	
   -- Soporte #175052
   -- Eliminacion de conyuge en caso de que el cliente hay cambiado su estado civil a DI, SO, y VI (Divorciado, Soltero y Viudo)
   select @w_est_civil = (select p_estado_civil from cobis..cl_ente where en_ente = @i_persona)   
   if @w_est_civil in ('DI', 'SO', 'VI')
   begin  
     delete from cobis..cl_conyuge
     where co_ente = @i_persona
   end  
   
   return 0
  end
end
-----------------------------------------------------------
-----  ACTUALIZACION CAMPOS RELACIONADOS A RENAPO ---------
-----------------------------------------------------------
if @i_operacion = 'Z' begin  
--No debe generar el curp #210163, pero se deja si el dato no viene de las pantallas , parametro ACRXCR = 'N'
  select @o_curp = @i_cedula
  
      if @i_modo = 0 begin
	     
		 select 
         @o_curp            = a.en_ced_ruc,
         @o_rfc             = a.en_nit
         from cl_ente a
         where a.en_ente    = @i_persona
		 
	     if not exists (select 1 from cobis..cl_ente 
		 where en_ente    = @i_persona 
		 and en_nombre    = @i_nombre
		 and p_s_nombre   = @i_segnombre
		 and p_p_apellido = @i_p_apellido
		 and p_s_apellido = @i_s_apellido
		 and p_sexo       = @i_sexo
		 and p_depa_nac   = @i_depa_nac) begin
		 
		 select @w_nombres = @i_nombre + ' ' + isnull(@i_segnombre,'')
		    
	        
            exec @w_return = cobis..sp_generar_curp
            @i_primer_apellido       = @i_p_apellido,
            @i_segundo_apellido      = @i_s_apellido,
            @i_nombres               = @w_nombres,
            @i_sexo                  = @i_sexo,
            @i_fecha_nacimiento      = @i_fecha_nac,
            @i_entidad_nacimiento    = @i_depa_nac,
            @i_ente                  = @i_persona,
            @o_mensaje               = @w_msg  out,
            --@o_curp                  = @o_curp out,
            @o_rfc                   = @o_rfc  out
		    
		    if @w_return <> 0 begin
		      if not exists ( select 1 from cobis..cl_ente where en_ente = @i_persona and en_ced_ruc = @o_curp) begin
		         exec sp_cerror
                          @t_debug = @t_debug,
                          @t_file  = @t_file,
                          @t_from  = @w_sp_name,
                          @i_num   = @w_return
		         return @w_return
			   end
		    end

            
            --SELECCIONAR LOS DATOS ANTERIORES DE LA PERSONA
            select 
	        @w_nombre          = a.en_nombre,
	        @w_segnombre       = a.p_s_nombre,
	        @w_p_apellido      = a.p_p_apellido,
	        @w_s_apellido      = a.p_s_apellido,
	        @w_sexo            = a.p_sexo,
	        @w_fecha_nac       = a.p_fecha_nac,
	        @w_depa_nac        = a.p_depa_nac,
	        @w_p_fecha_expira  = a.p_fecha_expira,
            @w_cedula          = a.en_ced_ruc,
            @w_nit             = a.en_nit,
            @w_oficial         = a.en_oficial,
            @w_oficina         = a.en_oficina
            from cl_ente a
            where a.en_ente    = @i_persona
            and a.en_subtipo   = 'P'
		    
            if @@rowcount = 0
            begin
              exec sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 101043
                --NO EXISTE PERSONA
              return 101043
            end
		
		    select @v_cedula = @w_cedula,
                   @v_nit   = @w_nit
                  
            select 
			@w_cedula = @o_curp,
			@w_nit    = @o_rfc
            
            if @w_nit is null and @w_cedula is null
               return 0
		    
		    update cl_ente set 
            en_nit         = isnull(@o_rfc, en_nit),
            en_rfc         = isnull(@o_rfc, en_rfc),
            en_ced_ruc     = isnull(@o_curp,en_ced_ruc),
            en_nombre      = isnull(@i_nombre, en_nombre),
		    p_s_nombre     = isnull(@i_segnombre,p_s_nombre),
		    p_p_apellido   = isnull(@i_p_apellido,p_p_apellido),
		    p_s_apellido   = isnull(@i_s_apellido,p_s_apellido),
		    p_sexo         = isnull(@i_sexo,p_sexo),
		    p_fecha_nac    = isnull(@i_fecha_nac,p_fecha_nac),
		    p_depa_nac     = isnull(@i_depa_nac,p_depa_nac),
            p_fecha_expira = isnull(@i_fecha_expira,p_fecha_expira)			
            where en_ente = @i_persona
              
            if @@error <> 0 begin
            
               exec sp_cerror  
		            @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 105026
               /* 'Error en actualizacion de persona'*/
               return 105026
            end   
              
            update cl_ente_aux set 
            ea_nit             = isnull(@o_rfc, ea_nit),
            ea_ced_ruc         = isnull(@o_curp, ea_ced_ruc),
            ea_consulto_renapo = isnull(@i_respuesta_renapo, isnull(ea_consulto_renapo, 'N')),
            ea_colectivo       = isnull(@i_colectivo, ea_colectivo),
            ea_nivel_colectivo = isnull(@i_nivel_colectivo, ea_nivel_colectivo)
            where ea_ente = @i_persona
            
            if @@error <> 0 begin
               exec sp_cerror  
		  	 @t_debug    = @t_debug,
               @t_file     = @t_file,
               @t_from     = @w_sp_name,
               @i_num      = 105026
               /* 'Error en actualizacion de persona'*/
               return 105026
            end  	 
		    
		    
            select @w_fecha = getdate()
		    select @w_fecha_hoy =  fp_fecha from cobis..ba_fecha_proceso
		    
		    select @w_nom_user = fu_nombre 
            from cl_funcionario
            where fu_login = @s_user
		    
		    if @@rowcount = 0 begin
		       exec cobis..sp_cerror
               @t_debug='N',         
		  	   @t_file = null,
               @t_from =@w_sp_name,  
		  	   @i_num = 101036 --No existe funcionario--
 
               return 101036
            end
		    
		    update cl_registro_identificacion set 
            ri_identificacion  = @o_curp,
            ri_fecha_act       = @w_fecha_hoy,
            ri_hora_act        = @w_fecha,
            ri_usuario         = @s_user,
            ri_nom_usuario	   = @w_nom_user
            where ri_ente      = @i_persona		 
		    
		    --TRANSACCION DE SERVICIO - DATOS PREVIOS AL CAMBIO
            insert into ts_persona_prin (secuencia,    tipo_transaccion, clase,          fecha,          usuario, 
                                         terminal,     srv,              lsrv,           persona,        cedula,
	         						      nombre,       s_nombre,         p_apellido,     s_apellido,     sexo,
                                         fecha_nac,    fecha_mod,        nit,            secuen_alterno, hora)       
                                 values (@s_ssn,       @t_trn,           'P',            @s_date,        @s_user, 						           
                                         @s_term,      @s_srv,           @s_lsrv,        @i_persona,     @v_cedula,
	         						      @w_nombre,    @w_segnombre,     @w_p_apellido,  @w_s_apellido,  @w_sexo,
	         						      @w_fecha_nac, getdate(),        @v_nit,         1,              getdate())
            if @@error <> 0
            begin
               exec sp_cerror
                  @t_debug    = @t_debug,
                  @t_file     = @t_file,
                  @t_from     = @w_sp_name,
                  @i_num      = 103005
               --ERROR EN CREACION DE TRANSACCION DE SERVICIO
               return 103005
            end
            
            --TRANSACCION DE SERVICIO - DATOS ACTUALES AL CAMBIO
            insert into ts_persona_prin (secuencia,    tipo_transaccion, clase,          fecha,      usuario, 
                                         terminal,     srv,              lsrv,           persona,    cedula,
                                         nombre,       s_nombre,         p_apellido,     s_apellido,     sexo,
                                         fecha_nac,    fecha_mod,        nit,            secuen_alterno, hora)      
                                 values (@s_ssn,       @t_trn,           'A',            @s_date,    @s_user, 
                                         @s_term,      @s_srv,           @s_lsrv,        @i_persona, @w_cedula,
                                         @i_nombre,    @i_segnombre,     @i_p_apellido,  @i_s_apellido, @i_sexo,
	         						      @i_fecha_nac, getdate(),        @v_nit,         1,              getdate())
             if @@error <> 0
             begin
                exec sp_cerror
                   @t_debug    = @t_debug,
                   @t_file     = @t_file,
                   @t_from     = @w_sp_name,
                   @i_num      = 103005
                --ERROR EN CREACION DE TRANSACCION DE SERVICIO
                return 103005
             end
            
          end
          if exists(select 1 from cobis..cl_ente_bio where eb_ente = @i_persona) begin
       
            update cobis..cl_ente_bio
            set eb_tipo_identificacion    = @i_bio_tipo_identificacion,
                eb_cic                    = @i_bio_cic,
                eb_ocr                    = @i_bio_ocr,
                eb_nro_emision            = @i_bio_numero_emision,
                eb_clave_elector          = @i_bio_clave_lector,
                eb_sin_huella_dactilar    = isnull(@i_bio_huella_dactilar,'N')
            where eb_ente = @i_persona
            
            if @@error <> 0
            begin
               exec sp_cerror
                   @t_debug    = @t_debug,
                   @t_file     = @t_file,
                   @t_from     = @w_sp_name,
                   @i_num      = 105026
                   /* 'Error en actualizacion de persona'*/
               return 105026
            end
      
            insert into cobis..cl_ente_bio_his
            (ebh_ssn,                            ebh_ente,              ebh_tipo_identificacion,     ebh_cic,
            ebh_ocr,                             ebh_nro_emision,       ebh_clave_elector,           ebh_sin_huella_dactilar,             
            ebh_fecha_registro,                  ebh_fecha_vencimiento, ebh_anio_registro,           ebh_anio_emision,
            ebh_fecha_modificacion,              ebh_transaccion,       ebh_usuario,                 ebh_terminal,
            ebh_srv,                             ebh_lsrv)
               values                               
               (@s_ssn,                             @i_persona,            @i_bio_tipo_identificacion,  @i_bio_cic, 	         
            @i_bio_ocr,                          @i_bio_numero_emision, @i_bio_clave_lector, 	      isnull(@i_bio_huella_dactilar,'N'),  
            getdate(),                           null,                  null,                        null,
            getdate(),                           'U',                   @s_user,                     @s_term,
            @s_srv,                              @s_lsrv)
       
            if @@error <> 0
            BEGIN
              exec sp_cerror
                   @t_debug    = @t_debug,
                   @t_file     = @t_file,
                   @t_from     = @w_sp_name,
                   @i_num      = 105026
                   /* 'Error en actualizacion de persona'*/
              return 105026
            end
            end else begin
               --Secuencial
               exec 
               @w_error     = cobis..sp_cseqnos
               @t_debug     = 'N',
               @t_file      = null,
               @t_from      = @w_sp_name,
               @i_tabla     = 'cl_ente_bio',
               @o_siguiente = @w_secuencial out
               
               if @w_error <> 0 begin
                  exec sp_cerror
                  @t_debug    = @t_debug,
                  @t_file     = @t_file,
                  @t_from     = @w_sp_name,
                  @i_num      = @w_error
               return @w_error
            end
      
            insert into cobis..cl_ente_bio
            (eb_secuencial, eb_ente,      eb_tipo_identificacion,    eb_cic,     eb_ocr,     eb_nro_emision,         eb_clave_elector,    eb_sin_huella_dactilar, eb_fecha_registro)
            values  
            (@w_secuencial, @i_persona,   @i_bio_tipo_identificacion,@i_bio_cic, @i_bio_ocr, @i_bio_numero_emision,  @i_bio_clave_lector, isnull(@i_bio_huella_dactilar,'N'), getdate())
              
            if @@error <> 0
            begin
               exec sp_cerror
                   @t_debug    = @t_debug,
                   @t_file     = @t_file,
                   @t_from     = @w_sp_name,
                   @i_num      = 105026
                   /* 'Error en actualizacion de persona'*/
               return 105026
            end
      			 
            insert into cobis..cl_ente_bio_his
               (ebh_ssn,                            ebh_ente,              ebh_tipo_identificacion,     ebh_cic,
                  ebh_ocr,                             ebh_nro_emision,       ebh_clave_elector,           ebh_sin_huella_dactilar,             
            ebh_fecha_registro,                  ebh_fecha_vencimiento, ebh_anio_registro,           ebh_anio_emision,
            ebh_fecha_modificacion,              ebh_transaccion,       ebh_usuario,                 ebh_terminal,
            ebh_srv,                             ebh_lsrv)
               values                               
               (@s_ssn,                             @i_persona,            @i_bio_tipo_identificacion,  @i_bio_cic, 	         
            @i_bio_ocr,                          @i_bio_numero_emision, @i_bio_clave_lector, 	      isnull(@i_bio_huella_dactilar,'N'),  
            getdate(),                           null,                  null,                        null,
            getdate(),                           'I',                   @s_user,                     @s_term,
            @s_srv,                              @s_lsrv)
       		  
            if @@error <> 0
            BEGIN
              exec sp_cerror
                   @t_debug    = @t_debug,
                   @t_file     = @t_file,
                   @t_from     = @w_sp_name,
                   @i_num      = 105026
                   /* 'Error en actualizacion de persona'*/
              return 105026
            end
         end
		    
		    
		 
	  end
      if @i_modo = 1 begin-- ACTUALIZAR ESTADO RENAPO
	        if exists (select 1 from cobis..cl_ente where en_ente = @i_persona and en_ced_ruc <> @i_cedula  ) begin
			   if exists (select 1 from cobis..cl_ente where en_ente <> @i_persona and en_ced_ruc = @i_cedula  ) begin
					
                  exec sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 103190
                    --NRO DE DOCUMENTO YA EXISTE
                  return 103190
               end            
            
               --SELECCIONAR LOS DATOS ANTERIORES DE LA PERSONA
               select 
	           @w_nombre          = a.en_nombre,
	           @w_segnombre       = a.p_s_nombre,
	           @w_p_apellido      = a.p_p_apellido,
	           @w_s_apellido      = a.p_s_apellido,
	           @w_sexo            = a.p_sexo,
	           @w_fecha_nac       = a.p_fecha_nac,
	           @w_depa_nac        = a.p_depa_nac,
	           @w_p_fecha_expira  = a.p_fecha_expira,
               @w_cedula          = a.en_ced_ruc,
               @w_nit             = a.en_nit,
               @w_oficial         = a.en_oficial,
               @w_oficina         = a.en_oficina
               from cl_ente a
               where a.en_ente    = @i_persona
			   
               if @@rowcount = 0
               begin
                 exec sp_cerror
                   @t_debug = @t_debug,
                   @t_file  = @t_file,
                   @t_from  = @w_sp_name,
                   @i_num   = 101043
                   --NO EXISTE PERSONA
                 return 1
               end
               --SMO  Inicio Transaccion de servicios
			   
               /*Control para CURP*/
               if((@w_cedula <> @i_cedula) or (@w_nit <> @i_nit))
               begin		 
                  insert into cl_modificacion_curp_rfc (mcr_ente,     mcr_ssn_user,  mcr_ssn_oficina,
               	                                        mcr_fecha,    mcr_oficial ,  mcr_oficina    ,
               											mcr_curp_ant, mcr_rfc_ant ,  mcr_curp       ,
               											mcr_rfc,      mcr_operacion, mcr_sp)
                  values (@i_persona,   @s_user     ,  @s_ofi         ,
               									        getdate(),    @w_oficial  ,  @w_oficina     ,
               											@w_cedula,    @w_nit      ,  @i_cedula,
               											@i_nit,       @i_operacion,  @w_sp_name)
               
                  if(len(@i_cedula) < 18) select @i_cedula = @w_cedula		 
               end  /*Fin Control para CURP*/	
               
               select @v_cedula = @w_cedula,
                       @v_nit   = @w_nit
               
               if @w_cedula <> @i_cedula begin              
                  select 
				  @w_cedula = @i_cedula,
				  @o_curp   = @i_cedula
			   end
               
               select @o_rfc = @w_nit
               
               if @w_nit is null and @w_cedula is null
                  return 0
               
               update cl_ente set 
               en_nit         = isnull(@i_nit, en_nit),
               en_rfc         = isnull(@i_nit, en_rfc),
               en_ced_ruc     = isnull(@i_cedula,en_ced_ruc),
               en_nombre      = isnull(@i_nombre, en_nombre),
			   p_s_nombre     = isnull(@i_segnombre,p_s_nombre),
			   p_p_apellido   = isnull(@i_p_apellido,p_p_apellido),
			   p_s_apellido   = isnull(@i_s_apellido,p_s_apellido),
			   p_sexo         = isnull(@i_sexo,p_sexo),
			   p_fecha_nac    = isnull(@i_fecha_nac,p_fecha_nac),
			   p_depa_nac     = isnull(@i_depa_nac,p_depa_nac),
               p_fecha_expira = isnull(@i_fecha_expira,p_fecha_expira)			
               where en_ente = @i_persona
               
               if @@error <> 0
               begin
                 exec sp_cerror  
			     @t_debug    = @t_debug,
                 @t_file     = @t_file,
                 @t_from     = @w_sp_name,
                 @i_num      = 105026
                  /* 'Error en actualizacion de persona'*/
                  return 105026
               end   
               
               update cl_ente_aux set 
               ea_nit             = isnull(@i_nit_id, ea_nit),
               ea_ced_ruc         = isnull(@i_cedula, ea_ced_ruc),
	           ea_consulto_renapo = isnull(@i_respuesta_renapo, ea_consulto_renapo)
               where ea_ente = @i_persona
               
               if @@error <> 0
               begin
                  exec sp_cerror  @t_debug    = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @w_sp_name,
                        @i_num      = 105026
                  /* 'Error en actualizacion de persona'*/
                  return 105026
               end  	  
               
			   select @w_fecha = getdate()
		       select @w_fecha_hoy =  fp_fecha from cobis..ba_fecha_proceso
		       
		       select @w_nom_user = fu_nombre 
               from cl_funcionario
               where fu_login = @s_user
		       
		       if @@rowcount = 0 begin
		          exec cobis..sp_cerror
                  @t_debug ='N',         
		  	      @t_file  = null,
                  @t_from  = @w_sp_name,  
		  	      @i_num   = 101036 --No existe funcionario--
                  return 101036
               end
		       
               update cl_registro_identificacion set 
               ri_identificacion  = @w_cedula,
               ri_fecha_act       = @w_fecha_hoy,
               ri_hora_act        = @w_fecha,
               ri_usuario         = @s_user,
               ri_nom_usuario	    = @w_nom_user
               where ri_ente      = @i_persona
			   
               --TRANSACCION DE SERVICIO - DATOS PREVIOS AL CAMBIO
               insert into ts_persona_prin (secuencia,    tipo_transaccion, clase,          fecha,          usuario, 
                                            terminal,     srv,              lsrv,           persona,        cedula,
	      	    						     nombre,       s_nombre,         p_apellido,     s_apellido,     sexo,
                                            fecha_nac,    fecha_mod,        nit,            secuen_alterno, hora)       
                                    values (@s_ssn,       @t_trn,           'P',            @s_date,        @s_user, 						           
                                            @s_term,      @s_srv,           @s_lsrv,        @i_persona,     @v_cedula,
	      	    						     @w_nombre,    @w_segnombre,     @w_p_apellido,  @w_s_apellido,  @w_sexo,
	      	    						     @w_fecha_nac, getdate(),        @v_nit,         1,              getdate())
               if @@error <> 0
               begin
                  exec sp_cerror
                     @t_debug    = @t_debug,
                     @t_file     = @t_file,
                     @t_from     = @w_sp_name,
                     @i_num      = 103005
                  --ERROR EN CREACION DE TRANSACCION DE SERVICIO
                  return 103005
               end
               
                --TRANSACCION DE SERVICIO - DATOS ACTUALES AL CAMBIO
               insert into ts_persona_prin (secuencia,    tipo_transaccion, clase,          fecha,      usuario, 
                                            terminal,     srv,              lsrv,           persona,    cedula,
                                            nombre,       s_nombre,         p_apellido,     s_apellido,     sexo,
                                            fecha_nac,    fecha_mod,        nit,            secuen_alterno, hora)      
                                    values (@s_ssn,       @t_trn,           'A',            @s_date,    @s_user, 
                                            @s_term,      @s_srv,           @s_lsrv,        @i_persona, @w_cedula,
                                            @i_nombre,    @i_segnombre,     @i_p_apellido,  @i_s_apellido, @i_sexo,
	      	    						     @i_fecha_nac, getdate(),        @v_nit,         1,              getdate())
                if @@error <> 0
                begin
                   exec sp_cerror
                      @t_debug    = @t_debug,
                      @t_file     = @t_file,
                      @t_from     = @w_sp_name,
                      @i_num      = 103005
                   --ERROR EN CREACION DE TRANSACCION DE SERVICIO
                   return 103005
                end
		  end else begin
		    select 
            @o_curp            = a.en_ced_ruc,
            @o_rfc             = a.en_nit
            from cl_ente a
            where a.en_ente    = @i_persona			
			
		    update cl_ente_aux set 
	        ea_consulto_renapo = isnull(@i_respuesta_renapo, ea_consulto_renapo)
            where ea_ente = @i_persona
		 end
      end

end
return 0

GO



