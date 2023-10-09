/* ********************************************************************* */
/*   Archivo:              bsa_persona_no_ruc_busin.sp                   */
/*   Stored procedure:     sp_bsa_persona_no_ruc_busin                   */
/*   Base de datos:        cobis                                         */
/*   Producto:             CLIENTES                                      */
/*   Disenado por:         Sonia Rojas                                   */
/*   Fecha de escritura:   20/Agosto/2020                                */
/* ********************************************************************* */
/*            IMPORTANTE                                                 */
/* ********************************************************************* */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   "MACOSA", representantes exclusivos para el Ecuador de la           */
/*   "NCR CORPORATION".                                                  */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante.                 */
/* ********************************************************************* */
/*            PROPOSITO                                                  */
/* ********************************************************************* */
/*   Este stored procedure inserta personas con datos incompletos        */
/*            MODIFICACIONES                                             */
/*   FECHA      AUTOR      RAZON      NEMONICO                           */
/* ********************************************************************* */
/*   21/Agosto/2020    S. Rojas       Créditos de Gobierno            */
/* ********************************************************************* */

use cobis
go

IF OBJECT_ID ('dbo.sp_bsa_persona_no_ruc_busin') IS NOT NULL
    DROP PROCEDURE dbo.sp_bsa_persona_no_ruc_busin
GO


create proc sp_bsa_persona_no_ruc_busin(
   @s_ssn                        int,
   @s_user                       login,
   @s_term                       varchar (32),
   @s_date                       datetime,
   @s_srv                        varchar(30),
   @s_lsrv                       varchar(30)   = null,
   @s_ofi                        smallint      = null,
   @s_rol                        smallint      = NULL,
   @s_org_err                    char(1)       = NULL,
   @s_error                      int           = NULL,
   @s_sev                        tinyint       = NULL,
   @s_msg                        descripcion   = NULL,
   @s_org                        char(1)       = NULL,
   @t_debug                      char(1)       ='N',
   @t_file                       varchar(14)   = null,
   @t_from                       descripcion   = null,
   @t_trn                        int,
   @t_show_version               bit           = 0,     -- Mostrar la version del programa
   @i_operacion                  char (1),              -- Opcion con la que se ejecuta el programa
   @i_nombre                     varchar(30)   = null,  -- Primer nombre del cliente
   @i_papellido                  varchar(30)   = null,  -- Primer apellido del cliente
   @i_sapellido                  varchar(30)   = null,  -- Segundo apellido del cliente
   @i_filial                     tinyint       = null,  -- Codigo de la filial
   @i_oficina                    smallint      = null,  -- Codigo de la oficina
   @i_tipo_ced                   char(4)       = null,  -- Tipo del documento de identificacion
   @i_cedula                     varchar(30)   = null,  -- Numero del documento de identificacion // corrige el error del instalador de la cob_pac
   @i_oficial                    smallint      = 0,     -- Codigo del oficial asignado al cliente
   @i_c_apellido                 varchar(30)   = null,  -- Apellido casada
   @i_segnombre                  varchar(30)   = null,  -- Segundo nombre
   @i_nit                        varchar(10)   = null,  -- NIT del cliente
   @i_depart_doc                 smallint      = null,  -- Codigo del departamento del documento
   @i_numord                     char(4)       = null,  -- Codigo de orden CV
   @i_ciudad_nac                 int           = null,  -- Codigo del municipio de nacimiento
   @i_lugar_doc                  int           = null,  -- Codigo del lugar del documento (Pais o municipio)
   @i_fecha_emision              datetime      = null,  -- Fecha de emision del pasaporte
   @i_fecha_expira               datetime      = null,  -- Fecha de vencimiento del pasaporte
   @i_municipio                  int           = null,  -- Municipio del documento
   @i_fecha_nac                  datetime      = null,  -- Fecha de nacimiento JLI
   @i_cod_otro_pais              char (5)      = null,  -- Codigo de otro pais centroamericano CVI
   @i_pasaporte                  varchar(20)   = null,  -- Numero de pasaporte del ente utilizado con CR , JLI
   @i_sexo                       varchar(10)   = null,  -- codigo del sexo de la persona enviado Dalvarez GAP MI00028
   @i_ingre                      varchar(10)   = null,  -- codigo de Ingreso de la persona Dalvarez GAP MI00028
   @i_digito                     char(2)       = null,  -- contiene el digito verificador
   @i_bloquear                   char(1)       = null,
   @i_tipo                       catalogo      = null,
   @i_tipo_vinculacion           catalogo      = null, -- Codigo del tipo de vinculacion de quien presento al cliente
   @i_situacion_cliente          catalogo      = null, -- Situacion actual del cliente
   @i_comision                   char(1)       = 'S',
   @i_est_civil                  varchar(10)   = null,
   @i_sector                     catalogo      = null, -- No se utiliza
   @i_actividad                  catalogo      = null, -- Codigo de la actividad del ente
   @i_categoria                  catalogo      = null,  -- CVA Abr-24-07
   @i_estado                     catalogo       = null,
   @i_cliente_casual             char(1)       = null, -- GC Cliente Casual
   @i_suc_gestion                smallint      = null,
   @i_menor                      char(1)       = null,
   @i_nacionalidad               int           = null,
   @i_ejecutivo_con              int           = null,
   @i_ea_estado                  catalogo      = null,
   @i_ea_observacion_aut         varchar(255)  = null,
   @i_ea_contrato_firmado        char(1)       = null,
   @i_ea_menor_edad              char(1)       = null,
   @i_ea_conocido_como           varchar(255)  = null,
   @i_ea_cliente_planilla        char(1)       = null,
   @i_ea_cod_risk                varchar(20)   = null,
   @i_ea_sector_eco              catalogo      = null,
   @i_ea_actividad               catalogo      = null,
   @i_ea_empadronado             char(1)       = null,
   @i_ea_lin_neg                 catalogo      = null,
   @i_ea_seg_neg                 catalogo      = null,
   @i_ea_val_id_check            catalogo      = null,
   @i_ea_ejecutivo_con           int           = null,
   @i_ea_suc_gestion             smallint      = null,
   @i_ea_constitucion            smallint      = null,
   @i_ea_remp_legal              int           = null,
   @i_ea_apoderado_legal         int           = null,
   @i_ea_act_comp_kyc            char(1)       = null,
   @i_ea_fecha_act_kyc           datetime      = null,
   @i_ea_no_req_kyc_comp         char(1)       = null,
   @i_ea_act_perfiltran          char(1)       = null,
   @i_ea_fecha_act_perfiltran    datetime      = null,
   @i_ea_con_salario             char(1)       = null,
   @i_ea_fecha_consal            datetime      = null,
   @i_ea_sin_salario             char(1)       = null,
   @i_ea_fecha_sinsal            datetime      = null,
   @i_ea_actualizacion_cic       char(1)       = null,
   @i_ea_fecha_act_cic           datetime      = null,
   @i_ea_excepcion_cic           char(1)       = null,
   @i_ea_fuente_ing              catalogo      = null,
   @i_ea_act_prin                catalogo      = null,
   @i_ea_detalle                 varchar(255)  = null,
   @i_ea_act_dol                 money         = null,
   @i_ea_cat_aml                 catalogo      = null,
   @i_profesion                  catalogo      = null,
   @i_ced_ruc                    varchar(30)   = null,       --Cliente Ocacional
   @i_ente                       int           = null,
   @i_secuencial                 int           = null,
-- LGU-INI 27/mar/2017 nuevos campos
   @i_vinculacion                char(1)       = 'N',
   @i_emproblemado               char(1)       = null, -- manejo de emproblemados
   @i_dinero_transac             money         = null, -- mnt de dinero transacciona mensualmente
   @i_manejo_doc                 varchar(25)   = null, -- manejo de documentos
   @i_pep                        char(1)       = null, -- s/n persona expuesta politicamente
   @i_mnt_activo                 money         = null, -- monto de los activos del cliente
   @i_mnt_pasivo                 money         = null, -- monto de los pasivos del cliente

   @i_ant_nego                   int           = null, -- antiguedad del negicio (meses)
   @i_ventas                     money         = null, -- ventas
   @i_ot_ingresos                money         = null, -- otros ingresos
   @i_ct_ventas                  money         = null, -- costos ventas
   @i_ct_operativos              money         = null, -- costos operativos
-- LGU-FIN 27/mar/2017 nuevos campos
   @i_ea_nro_ciclo_oi            int           = null, -- LPO Santander --numero de ciclos en otras entidades
   @o_ente                       int           = null  out,  -- Codigo secuencial asignado al cliente
   @o_tip_ente                   int           = null  out,  -- Numero secuencial asignado al tipo de documento
   @o_es_pais_resitringido       char(1)       = 'N'   out,  --(PRMR CLI-0571)
   @o_idcheck                    char(1)       = null  out,
   @o_cod_gestor                 int           = null  out,
   @o_tipo_ced                   varchar(10)   = null  out,
   @o_cedula                     numero        = null  out,
   @o_nombre                     varchar(100)  = null  out,
   @o_seg_nombre                 varchar(100)  = null  out,
   @o_pri_apellido               varchar(100)  = null  out,
   @o_seg_apellido               varchar(100)  = null  out,
   @o_cas_apellido               varchar(100)  = null  out,
   @o_departamento               varchar(10)   = null  out,
   @o_provincia                  int           = null  out,
   @o_ciudad                     int           = null  out,
   @o_barrio                     char(40)      = null  out,
   @o_cod_direccion              tinyint       = null  out,
   @o_pais                       tinyint       = null  out,
   @o_direccion                  varchar(250)  = null  out,
   @o_cod_telefono               tinyint       = null  out,
   @o_tipo_telefono              varchar(20)   = null  out,
   @o_cod_area                   varchar(20)   = null  out,
   @o_tel_valor                  varchar(20)   = null  out,
   @o_tipo                       catalogo      = null  out,
   @o_tipo_prop                  char(10)      = null  out,
   @o_rural_urbano               char(1)       = null  out,
   @o_estado_cliente             char(1)       = null  out,
   @o_curp                       varchar(32)   = null  out, -- LGU: calculo de nuevos campos
   @o_rfc                        varchar(32)   = null  out,  -- LGU: calculo de nuevos campos
   @i_batch                      char(1)       = 'N'      , -- LGU: sp que se dispara desde FE o BATCH
   @i_banco                      varchar(20)   = null,
   @i_bio_tipo_identificacion    varchar(10)   = null,
   @i_bio_cic                    varchar(9)    = null,
   @i_bio_ocr                    varchar(13)   = null,
   @i_bio_numero_emision         varchar(2)    = null,
   @i_bio_clave_lector           varchar(18)   = null,
   @i_bio_huella_dactilar        char(1)       = null,
   @i_num_cargas                 int           = null,
   @i_rfc                        numero        = null,
   @i_cuenta                     varchar(45)   = null,
   @i_modo                       smallint      = 0,
   @i_edad_min                   int,
   @i_edad_max                   int,
   @i_nemocda                    char(3),
   @i_nemomed                    char(3)

)
as
declare 
@w_sp_name        descripcion,
@w_return              int,
@w_ente                int,
@w_nombre_completo     varchar (254),
@w_sexo                char(10),
@w_ecivil              varchar(10),
@w_ptipo               char(10),
@w_actividad           char(10),
@w_sectoreco           char(10),
@w_tipo_vivienda       char(10),
@w_ciudad              int,
@w_ciudad_exp          int,
@w_bloquear            char(1),
@w_mala_referencia     char(1),
@w_estado              char(1),
@w_estado_referencia   catalogo,
@w_estado_ref_pais     catalogo,
@w_ea_ced_ruc          varchar(30),
@w_catalogo            catalogo,
@w_nat_jur_hogar       catalogo,
@w_msg                 varchar(100),--LGU calculo del RFC y CURP
@w_curp                varchar(30), --LGU calculo del RFC y CURP
@w_rfc                 varchar(30), --LGU calculo del RFC y CURP
@w_ofi_mobil           int,         --MTA oficina de la mobil 
@w_anios_edad          smallint,    --MTA edad del cliente
@w_error               int,
@w_nivel_riesgo		   varchar(30)

if @t_show_version = 1
begin
      print 'Stored procedure sp_bsa_persona_no_ruc_busin, Version 4.0.0.25'
      return 0
end

select @w_sp_name = 'sp_bsa_persona_no_ruc_busin'
select @o_es_pais_resitringido = 'N'
select @w_estado_referencia = @i_estado
select @o_idcheck = @i_ea_val_id_check

-- PJI CC-CTA-220
-- se verifica si el tipo de cedula no es nulo, si se ha cambiado el mismo, = si el tipo de compañfa está vacfo
if @i_tipo_ced is not null
begin
   -- Tipos de identificacion de personas nacionales
   if @i_tipo_ced in ('CI','CID','CIEE','CPN','ND','RUN') begin
   --JMA se agrega parametro para insertar en c_tipo_compania
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
if @i_sexo = 'F' begin
   If @i_est_civil = @i_nemocda begin
      if @i_c_apellido is null begin
         select @w_nombre_completo = @i_nombre + ' ' + @i_segnombre +  ' ' + @i_papellido + ' ' + @i_sapellido
      end else begin
         select @w_nombre_completo = @i_nombre + ' ' + @i_segnombre +  ' ' + @i_papellido + ' ' + @i_sapellido + ' DE ' + @i_c_apellido
      end
   end
   else if @i_est_civil = @i_nemomed begin
      select @w_nombre_completo = @i_nombre + ' ' + @i_segnombre + ' ' + @i_papellido + ' ' + @i_sapellido + ' (MENOR) '
   end else begin
      select @w_nombre_completo = @i_nombre + ' ' + @i_segnombre + ' ' + @i_papellido + ' ' + @i_sapellido
   end
end else begin
   If @i_est_civil = @i_nemomed begin
      select @w_nombre_completo = @i_nombre + ' ' + @i_segnombre + ' ' + @i_papellido + ' ' + @i_sapellido + ' (MENOR) '
   end else begin
      select @w_nombre_completo = @i_nombre + ' ' + @i_segnombre + ' ' + @i_papellido + ' ' + @i_sapellido
   end
end


/* ** Insercion ** */
if @i_operacion = 'I' begin  
 
   select  
   @w_ecivil = @i_est_civil,
   @w_mala_referencia = 'N',
   @w_estado_referencia = 'P' --Prospecto
   
   if @t_trn <> 1288 begin
      /* Codigo de transaccion invalido */
      select @w_error = 101147
      goto ERROR
   end
   
   /* Verificar que exista el oficial indicado */
   if @i_oficial <> 0
   begin

      select @w_ente = oc_oficial
        from cobis..cc_oficial
        where oc_oficial = @i_oficial
   
      if @@rowcount = 0
      begin
        select @w_error = 101036
        goto ERROR
      end
   end
   
   select @w_ciudad_exp = @w_ciudad
   
   -- Validacion de Edad   
   if @i_cliente_casual <> 'S'
   begin
      select @w_anios_edad = datediff(yy, @i_fecha_nac, fp_fecha) from cobis..ba_fecha_proceso
      if ((@w_anios_edad < @i_edad_min) and (@w_anios_edad > @i_edad_max)) begin
         select @w_error = 101113
         goto ERROR
        /* 'Falta fecha de nacimiento'*/      
      end
   end
   
   exec cobis..sp_cseqnos
   @t_debug    = @t_debug,
   @t_file     = @t_file,
   @t_from     = @w_sp_name,
   @i_tabla    = 'cl_ente',
   @o_siguiente    = @o_ente out
   
   /* insertar los parametros de entrada */
   select 
   @w_ecivil = ltrim(rtrim(@w_ecivil)),
   @w_rfc = @i_rfc       
      
   --LGU-fin 2017-06-15 creacion del CURP y RFC
   if exists (select 1 from cobis..cl_ente where en_ced_ruc = @i_cedula ) begin
      select @w_error = 70011007
      goto ERROR	   
   end

	
   insert into cobis..cl_ente (
   en_ente,              en_subtipo,        en_nombre,          p_p_apellido,     p_s_apellido,
   p_sexo,               en_tipo_ced,       en_ced_ruc,         p_pasaporte,      en_pais,
   p_profesion,          p_estado_civil,    p_num_cargas,       p_nivel_ing,      p_nivel_egr,
   p_tipo_persona,       en_fecha_crea,     en_fecha_mod,       en_filial,        en_oficina,
   en_direccion,         en_referencia,     p_personal,         p_propiedad,      p_trabajo,
   en_casilla,           en_casilla_def,    en_tipo_dp,         p_fecha_nac,      en_balance,
   en_grupo,             en_retencion,      en_mala_referencia, en_comentario,    en_actividad,
   en_oficial,           p_fecha_emision,   p_fecha_expira,     en_asosciada,     en_referido,
   en_sector,            en_nit,            p_depa_nac,         p_lugar_doc,      p_nivel_estudio, /*p_depa_nac entidad nacimiento*/
   p_tipo_vivienda,      p_calif_cliente,   en_doc_validado,    en_rep_superban,  en_nomlar,
   en_situacion_cliente, p_dep_doc,         p_c_apellido,       p_s_nombre,       p_numord,
   en_cod_otro_pais,     en_ingre,          en_estado,          en_digito,        en_concordato,
   en_nacionalidad,      c_funcionario,     en_tipo_vinculacion,c_tipo_compania,
   -- LGU-INI 27/mar/2017 nuevos campos
   en_emproblemado  ,    en_dinero_transac,   en_manejo_doc,
   en_persona_pep   ,    c_activo         ,   c_pasivo,
   en_vinculacion   ,
   -- LGU-FIN 27/mar/2017 nuevos campos
   en_rfc, /* LGU: calculo del RFC y CURP*/ en_banco)
   values  
   (@o_ente,              'P',               @i_nombre,          @i_papellido,     @i_sapellido,
   @i_sexo,              @i_tipo_ced,       @i_cedula,          @i_pasaporte,     null,
   @i_profesion,         @w_ecivil,         @i_num_cargas,              0,                0,
   @i_tipo,              @s_date,           @s_date,           @i_filial,         @i_oficina,
   0,                    0,                 0,                  0,                0,
   0,                    null,              null,               @i_fecha_nac,     0,
   null,                 @i_comision,       @w_mala_referencia, ' ',              @i_actividad,
   @i_oficial,     null,              @i_fecha_expira,    null,             null,
   @i_sector,            @w_rfc,              @i_ciudad_nac,      @i_lugar_doc,     null,
   null,                 null,              'N',                'N',              @w_nombre_completo,
   @i_situacion_cliente, @i_depart_doc,     @i_c_apellido,      @i_segnombre,     @i_numord,
   @i_cod_otro_pais,     @i_ingre,          @i_bloquear,        @i_digito,        @i_categoria,
   @i_nacionalidad,      @s_user,           @i_tipo_vinculacion,@w_nat_jur_hogar,
   -- LGU-INI 27/mar/2017 nuevos campos
   @i_emproblemado   ,  @i_dinero_transac ,  @i_manejo_doc,
   @i_pep            ,  @i_mnt_activo     ,  @i_mnt_pasivo,
   @i_vinculacion    ,
   -- LGU-FIN 27/mar/2017 nuevos campos
   @w_rfc, /*LGU: calculo del RFC y CURP*/  @i_banco
   )
   
   /* si no se pudo insertar, error */
   if @@error <> 0
   BEGIN
   
      select @w_error = 105066
      if @i_batch = 'N'
         goto ERROR
      else
         return @w_error
   end
  
   select @w_ea_ced_ruc = replace(@i_cedula,'-','')

	select @w_nivel_riesgo = pa_char from cl_parametro 
	where pa_nemonico = 'NIRICL' and pa_producto = 'CLI'
	select @w_nivel_riesgo = isnull(@w_nivel_riesgo,'B')

   if exists (select 1 from cobis..cl_ente_aux where ea_ced_ruc = @w_ea_ced_ruc ) begin
      select @w_error = 70011007
      goto ERROR	   
   end
      
   insert into cobis..cl_ente_aux( ea_ente,       ea_estado,              ea_observacion_aut,     ea_contrato_firmado,       ea_menor_edad,      --5
   ea_conocido_como,     ea_cliente_planilla,    ea_cod_risk,            ea_sector_eco,             ea_actividad,       --10
   /*ea_empadronado,*/       ea_lin_neg,             ea_seg_neg,             /*ea_val_id_check,*/           ea_ejecutivo_con,   --15
   ea_suc_gestion,       ea_constitucion,        ea_remp_legal,          ea_apoderado_legal,        /*ea_act_comp_kyc,*/    --20
   /*ea_fecha_act_kyc,     ea_no_req_kyc_comp,     ea_act_perfiltran,      ea_fecha_act_perfiltran,   ea_con_salario,*/     --25
   /*ea_fecha_consal,      ea_sin_salario,         ea_fecha_sinsal,        ea_actualizacion_cic,      ea_fecha_act_cic,*/   --30
   /*ea_excepcion_cic,*/     ea_fuente_ing,          ea_act_prin,            ea_detalle,                ea_act_dol,         --35
   ea_cat_aml,           ea_ced_ruc, --                                                                                    --36
   -- LGU-INI 27/mar/2017 nuevos campos
    ea_ant_nego     ,ea_ventas       ,ea_ot_ingresos  ,
    ea_ct_ventas    ,ea_ct_operativo,
   -- LGU-FIN 27/mar/2017 nuevos campos
    ea_nro_ciclo_oi, /*LPO Santander*/ ea_nit, ea_consulto_renapo, ea_cta_banco, ea_nivel_riesgo_cg )
   values(   
   @o_ente,          @w_estado_referencia,   @i_ea_observacion_aut,  @i_ea_contrato_firmado,     @i_menor,          --5
   @i_ea_conocido_como,  @i_ea_cliente_planilla, @i_ea_cod_risk,         @i_ea_sector_eco,           @i_ea_actividad,   --10
   /*@i_ea_empadronado,*/    @i_ea_lin_neg,          @i_ea_seg_neg,          /*@i_ea_val_id_check,*/         @i_ejecutivo_con,  --15
   @i_suc_gestion,       @i_ea_constitucion,     @i_ea_remp_legal,       @i_ea_apoderado_legal,      /*@i_ea_act_comp_kyc,*/--20
   /*@i_ea_fecha_act_kyc,  @i_ea_no_req_kyc_comp,  @i_ea_act_perfiltran,   @i_ea_fecha_act_perfiltran, @i_ea_con_salario, */--25
   /*@i_ea_fecha_consal,   @i_ea_sin_salario,      @i_ea_fecha_sinsal,     @i_ea_actualizacion_cic,    @i_ea_fecha_act_cic,*/--30
   /*@i_ea_excepcion_cic,*/  @i_ea_fuente_ing,       @i_ea_act_prin,         @i_ea_detalle,              @i_ea_act_dol,      --35
   @i_ea_cat_aml,        @w_ea_ced_ruc,                                                                                  --36
   -- LGU-INI 27/mar/2017 nuevos campos
    @i_ant_nego     ,@i_ventas       ,@i_ot_ingresos  ,
    @i_ct_ventas    ,@i_ct_operativos,
   -- LGU-FIN 27/mar/2017 nuevos campos
    @i_ea_nro_ciclo_oi, /*LPO Santander*/ @w_rfc, 'N', @i_cuenta, @w_nivel_riesgo
   )
   
   if @@error <> 0
   BEGIN
      select @w_error = 103105
      if @i_batch = 'N'
         goto ERROR
      else
         return @w_error
   end
  ----*-----------------------------------------------------------------------------------*--
  ----* REALIZA EL REGISTRO DEL HISTORICO DE IDENTIFICACIONES
  ----* GDE -- CONTROL DE CAMBIOS CLIENTES
  ----*-----------------------------------------------------------------------------------*--
   exec @w_return = cobis..sp_bsa_registra_ident
           @s_user           = @s_user,
           @t_trn            = 1037,
           @i_operacion      = 'I',
           @i_ente           = @o_ente,
           @i_tipo_iden      = @i_tipo_ced,
           @i_identificacion = @i_cedula
   if @w_return <> 0 begin
      select @w_error = @w_return
      goto ERROR 
   end
   
   

return 0
end

ERROR:
   
return @w_error

go
