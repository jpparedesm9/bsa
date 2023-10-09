/* ********************************************************************* */
/*   Archivo:              clinoruc.sp                                   */
/*   Stored procedure:     sp_persona_no_ruc_busin                       */
/*   Base de datos:        cobis                                         */
/*   Producto:             CLIENTES                                      */
/*   Disenado por:         Angela Ramirez                                */
/*   Fecha de escritura:   04/Jul/1996                                   */
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
/*   13/Feb/2017    S.Rojas        Se agrega input secuencial            */
/*   29/Mar/2017    LGU            Aumentar nuevos campos S105462        */
/*   13/May/2017    Luis Ponce     Aumentar campo ea_nro_ciclo_oi        */
/*   28/Jun/2017    P. Ortiz       Aumentar campo Banco Santander        */
/*   10/Oct/2017    Ma. Jose Taco  Aumentar parametros de edad min       */
/*   12/Mar/2018    P. Samueza     Aumentar validacion cuando            */
/*                                 el primer nombres es igual a MA.      */
/*   09/Dic/2019    SRO            Modificaciones Colectivos             */
/*   11/Feb/2019    S. Rojas       129027. Biométricos                   */
/*   24/Dic/2020    S. Rojas       151529 Error Negative File            */
/*   19/Jul/2021    S. Rojas       161141 LCR V2.0                       */
/*   20/Abr/2023    KVI            R.203621-Campos relacionados a        */
/*                                 Tipo Credencial no obligatorios       */
/*   12/Jun/2023    ACH            Cambio por error #193221              */
/*   23/Jun/2023    ACH            Por error #193221 se envia en #209990 */
/*   27/Jun/2023    ACH            #210163 ERR en CURP-no debemos generar*/
/*************************************************************************/
use cob_pac
go

IF OBJECT_ID ('dbo.sp_persona_no_ruc_busin') IS NOT NULL
    DROP PROCEDURE dbo.sp_persona_no_ruc_busin
GO

create proc sp_persona_no_ruc_busin(
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
   @i_nombre                     descripcion   = null,  -- Primer nombre del cliente
   @i_papellido                  descripcion   = null,  -- Primer apellido del cliente
   @i_sapellido                  descripcion   = null,  -- Segundo apellido del cliente
   @i_filial                     tinyint       = null,  -- Codigo de la filial
   @i_oficina                    smallint      = null,  -- Codigo de la oficina
   @i_tipo_ced                   char(4)       = null,  -- Tipo del documento de identificacion
   @i_cedula                     varchar(30)   = null,  -- Numero del documento de identificacion // corrige el error del instalador de la cob_pac
   @i_oficial                    smallint      = 0,     -- Codigo del oficial asignado al cliente
   @i_c_apellido                 varchar(30)   = null,  -- Apellido casada
   @i_segnombre                  varchar(50)   = null,  -- Segundo nombre
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
   @i_modo                       smallint      = 0,
   @o_lista_negra                char(1)       = null out,
   @i_colectivo                  varchar(4)    = null,
   @i_nivel_colectivo            varchar(4)    = null,
   @i_register_year              varchar(4)    = null,
   @i_emission_year              varchar(4)    = null,
   @i_respuesta_renapo           char(1)       = null

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
@w_nemocda             char(3),
@w_nemovda             char(3),
@w_nemomed             char(3),
@w_vu_banco            catalogo,
@w_vu_pais             catalogo,
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
@w_edad_max            smallint,    --MTA edad maxima
@w_edad_min            smallint,    --MTA edad minima
@w_anios_edad          smallint,    --MTA edad del cliente
@w_error               int,
@w_secuencial          int,
@w_resultado_nf        int,
@w_renapo_curp         char(1),
@w_papellido           descripcion   ,
@w_sapellido           descripcion

if @t_show_version = 1
begin
      print 'Stored procedure sp_persona_no_ruc_busin, Version 4.0.0.25'
      return 0
end

--CorreciOn temporal, si esta o no validado debe llegar desde el front end
--if exists (select 1 from cobis..cl_parametro where pa_nemonico = 'ACRXCR' and pa_char = 'S')
--    select @w_renapo_curp = 'S'
--else
--    select @w_renapo_curp = 'N'
select @w_renapo_curp = isnull(@i_respuesta_renapo, 'N')

select   @w_sp_name = 'sp_persona_no_ruc_busin'
select @o_es_pais_resitringido = 'N'
select @w_estado_referencia = @i_estado

select @o_idcheck = @i_ea_val_id_check

--MTA Inicio
select @w_edad_min = pa_tinyint  --Edad minima
  FROM cobis..cl_parametro 
 WHERE pa_nemonico = 'MDE'
   and pa_producto = 'ADM'

SELECT @w_edad_max = pa_tinyint --Edad maxima
  FROM cobis..cl_parametro 
 WHERE pa_nemonico='EMAX'
   and pa_producto = 'ADM'
--MTA Fin

/*  Inicializar nombre del stored procedure  */
select @w_vu_pais = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and pa_nemonico = 'ABPAIS'

select @w_vu_banco = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and pa_nemonico = 'CLIENT'


select   @w_sp_name = 'sp_persona_no_ruc_busin'
/*  PCOELLO Armado del Nombre Largo del Cliente, tomando en cuenta si es Casada, Viuda o Menor de Edad */

select @w_nemocda = pa_char
from cobis..cl_parametro
where pa_nemonico = 'CDA'
  and pa_producto = 'CLI'

select @w_nemovda = pa_char
from cobis..cl_parametro
where pa_nemonico = 'VDA'
  and pa_producto = 'CLI'

select @w_nemomed = pa_char
from cobis..cl_parametro
where pa_nemonico = 'MED'
  and pa_producto = 'CLI'

--(PRMR CLI-0571)
select @w_estado_ref_pais = pa_char
  from cobis..cl_parametro
 where pa_nemonico = 'EVPR'
   and pa_producto = 'CLI'



   -- PJI CC-CTA-220
   -- se verifica si el tipo de cédula no es nulo, si se ha cambiado el mismo, = si el tipo de compañía está vacío
   if @i_tipo_ced is not null
   begin
      -- Tipos de identificacion de personas nacionales
      if @i_tipo_ced in ('CI','CID','CIEE','CPN','ND','RUN')
       begin
      --JMA se agrega parametro para insertar en c_tipo_compania
        select @w_nat_jur_hogar =pa_char
        FROM cobis..cl_parametro
        where pa_nemonico ='NAJUHO'
        AND pa_producto ='CLI'
      end
      -- Tipos de identificacion de personas extranjeras
      else if @i_tipo_ced in ('CIE','DCC','DCD','DCO','DCR','PAS','DE')
      begin
        select @w_nat_jur_hogar =pa_char
        FROM cobis..cl_parametro
        where pa_nemonico ='NAJUHE'
        AND pa_producto ='CLI'
      end
   end
   -- PJI CC-CTA-220

if @i_sexo = 'F'
   begin
      If @i_est_civil = @w_nemocda
         begin
            if @i_c_apellido is null
               begin
                  select @w_nombre_completo = @i_nombre + ' ' + @i_segnombre +  ' ' + @i_papellido + ' ' + @i_sapellido
               end
            else
               begin
                  select @w_nombre_completo = @i_nombre + ' ' + @i_segnombre +  ' ' + @i_papellido + ' ' + @i_sapellido + ' DE ' + @i_c_apellido
               end
         end

      else if @i_est_civil = @w_nemomed
         begin
            select @w_nombre_completo = @i_nombre + ' ' + @i_segnombre + ' ' + @i_papellido + ' ' + @i_sapellido + ' (MENOR) '
         end
      else
         begin
            select @w_nombre_completo = @i_nombre + ' ' + @i_segnombre + ' ' + @i_papellido + ' ' + @i_sapellido
         end
   end
else
   begin
      If @i_est_civil = @w_nemomed
         begin
            select @w_nombre_completo = @i_nombre + ' ' + @i_segnombre + ' ' + @i_papellido + ' ' + @i_sapellido + ' (MENOR) '
         end
      else
         begin
            select @w_nombre_completo = @i_nombre + ' ' + @i_segnombre + ' ' + @i_papellido + ' ' + @i_sapellido
         end
   end

/* ** Consulta ** */
if @i_operacion = 'S'
begin

      select @o_cod_gestor   = en_ente,
             @o_tipo_ced     = en_tipo_ced,
             @o_cedula       = en_ced_ruc,
             @o_nombre       = en_nombre,
             @o_seg_nombre   = p_s_nombre,
             @o_pri_apellido = p_p_apellido,
             @o_seg_apellido = p_s_apellido,
             @o_cas_apellido = p_c_apellido
      from cobis..cl_ente
      where en_ced_ruc = @i_ced_ruc
      if @@rowcount = 0
      begin
         /* Registro de cliente no existe */
		 select @w_error = 357524
	     goto ERROR
      end

      select @o_cod_direccion = di_direccion,
             @o_pais          = di_pais,
             @o_departamento  = di_departamento,
             @o_provincia     = di_provincia,
             @o_ciudad        = di_ciudad,
             @o_barrio        = di_barrio,
             @o_direccion     = di_descripcion,
             @o_tipo          = di_tipo,
             @o_tipo_prop     = di_tipo_prop ,
             @o_rural_urbano  = di_rural_urbano
     from cobis..cl_direccion
     where di_ente = @o_cod_gestor and di_principal = 'S'

     select top 1 @o_cod_telefono  = te_secuencial,
                  @o_tipo_telefono = te_tipo_telefono,
                  @o_cod_area      = te_area,
                  @o_tel_valor     = te_valor
     from cobis..cl_telefono
     where te_ente = @o_cod_gestor and te_direccion = @o_cod_direccion

     select @o_estado_cliente   = ea_estado
      from cobis..cl_ente_aux
      where ea_ente = @o_cod_gestor
      if @@rowcount = 0
      begin
         /* Registro Auxiliar de cliente no existe */
		 select @w_error = 357525
	     goto ERROR
      end

      -- Devuelvo los datos al FE
      select @o_cod_gestor,
             @o_tipo_ced,
             @o_cedula,
             @o_nombre,
             @o_seg_nombre,
             @o_pri_apellido,
             @o_seg_apellido,
             @o_cas_apellido,
             @o_cod_direccion,
             @o_pais,
             @o_departamento,
             @o_provincia,
             @o_ciudad,
             @o_barrio,
             @o_direccion,
             @o_cod_telefono,
             @o_tipo_telefono,
             @o_cod_area,
             @o_tel_valor,
             @o_tipo,
             @o_tipo_prop,
             @o_rural_urbano,
             @o_estado_cliente
end

/* ** Actualizacion ** */
if @i_operacion = 'U'
begin
      select en_ente
      from cobis..cl_ente
      where en_ente = @i_ente
      if @@rowcount = 0
      begin
	     select @w_error = 357524
	     goto ERROR
         /* Registro de cliente no existe */
      end

      begin tran
                  update  cobis..cl_ente set  en_nombre       = @i_nombre,
                  p_p_apellido    = @i_papellido,
                  p_s_apellido    = @i_sapellido,
                  p_c_apellido    = @i_c_apellido,
                  p_s_nombre      = @i_segnombre,
                  c_tipo_compania = isnull(@w_nat_jur_hogar, c_tipo_compania)
            where en_ente = @i_ente
              /* Actualizacion Cliente*/
              if @@error <> 0
              begin
                 select @w_error = 105066
	             goto ERROR
              end
      commit tran
end

/* ** Insercion ** */

if @i_operacion = 'I'
begin

select  @w_ecivil = @i_est_civil,
        @w_mala_referencia = 'N',
        @w_estado_referencia = @i_estado

   if @t_trn <> 1288
   begin
      /* Codigo de transaccion invalido */
	  select @w_error = 101147
	  goto ERROR

   end
   /* verificar que exista relacion con el banco */
   if @i_tipo_vinculacion is not null
   begin
        exec @w_return = cobis..sp_catalogo
         @t_debug        = @t_debug,
         @t_file         = @t_file,
         @t_from         = @w_sp_name,
         @i_operacion    = 'E',
         @i_tabla        = 'cl_relacion_banco',
         @i_codigo       = @i_tipo_vinculacion

         if @w_return <> 0
         begin
		    select @w_error = 101173
	        goto ERROR
         /* 'No existe relacion con el banco'*/
         end
   end

   if exists ( select 1
                from  cobis..cl_refinh
               where in_ced_ruc like @i_cedula)
   begin
      select @w_error = 101168
	  goto ERROR
   end

   if exists ( select 1
                from  cobis..cl_mercado
               where me_ced_ruc like @i_cedula)
   begin
        --si tiene mala ref de mercado se marca el ente
      select @w_mala_referencia = 'S'
   end

  -- Validacion de Paises Restringidos

-- Validacion de Paises Restringidos  (PRMR CLI-0571)
   if exists(select 1
            from cobis..cl_catalogo a, cobis..cl_tabla b
            where b.tabla = 'cl_paises_restringidos'
            and   a.tabla  = b.codigo
            and   a.estado = 'V'
            and   a.codigo = convert(varchar(10),@i_nacionalidad))
   begin
      select  @w_estado_referencia = @w_estado_ref_pais,  -- El estado de cliente sera de M - Mala Referencia
               @o_es_pais_resitringido = 'S'

      if not exists(select 1
            from cobis..cl_catalogo a, cobis..cl_tabla b
            where b.tabla = 'cl_estados_cliente'
            and   a.tabla  = b.codigo
            and   a.estado = 'V'
            and   a.codigo = @w_estado_ref_pais)
      begin
	     select @w_error = 107139
	     goto ERROR
      end
   end


   --if @i_tipo_ced is not null
   --begin
   --   if exists ( select 1
   --     from cobis..cl_ente
   --     where en_subtipo = 'P'
   --         and en_tipo_ced = @i_tipo_ced
   --    and en_ced_ruc = @i_cedula )
   --   begin
   --      exec cobis..sp_cerror
   --         @t_debug = @t_debug,
   --         @t_file  = @t_file,
   --         @t_from  = @w_sp_name,
   --         @i_num   = 101155
   --      return 101155
   --   end
   --end

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

    /* verificar la profesion de la persona */
   if  @i_profesion is not null
   begin
        select @w_catalogo = convert(char(10), @i_profesion)
        exec @w_return = cobis..sp_catalogo
             @t_debug        = @t_debug,
             @t_file         = @t_file,
             @t_from         = @w_sp_name,
             @i_operacion    = 'E',
             @i_tabla        = 'cl_profesion',
             @i_codigo       = @w_catalogo
		  
      if @w_return <> 0 begin
         select @w_error = 101019
	     goto ERROR
         end
   end

   select @w_ciudad_exp = @w_ciudad

/**************************************************/
   /* verificar que exista el sector  */
  if @i_sector is not null and @i_sector <> ''
  begin

     exec @w_return = cobis..sp_catalogo
      @t_debug        = @t_debug,
      @t_file         = @t_file,
      @t_from         = @w_sp_name,
      @i_operacion    = 'E',
      @i_tabla        = 'cl_sectoreco',
      @i_codigo       = @i_sector

      if @w_return <> 0
      begin
	     select @w_error = 101048
	     goto ERROR
          /* 'No existe sector'*/
      end
  end

        --I.CVA May-22-07 Validar actividad economica recibida del frontend
   if @i_actividad<> null
   begin
      if not exists(select ac_codigo from cobis..cl_actividad_ec
               where ac_codigo    = @i_actividad)
      begin
	     select @w_error = 101199
	     goto ERROR
      end
   end

      -- Validacion de Paises Restringidos  (PRMR CLI-0571)
   if exists(select 1
         from cobis..cl_catalogo a, cobis..cl_tabla b
         where b.tabla = 'cl_paises_restringidos'
         and   a.tabla  = b.codigo
         and   a.estado = 'V'
         and   a.codigo = convert(varchar(10), @i_nacionalidad))
   begin
         select  @w_estado_referencia = @w_estado_ref_pais,  -- El estado de cliente sera de M - Mala Referencia
               @o_es_pais_resitringido = 'S'

      if not exists(select 1
            from cobis..cl_catalogo a, cobis..cl_tabla b
            where b.tabla = 'cl_estados_cliente'
            and   a.tabla  = b.codigo
            and   a.estado = 'V'
            and   a.codigo = @w_estado_ref_pais)
      begin
	     select @w_error = 107139
	     goto ERROR   
      end
   end

   -- Validacion de Edad
   
   if @i_cliente_casual <> 'S'
   begin
     select @w_anios_edad = datediff(yy, @i_fecha_nac, fp_fecha) from cobis..ba_fecha_proceso
     if ((@w_anios_edad < @w_edad_min) and (@w_anios_edad > @w_edad_max))
	 begin
	    select @w_error = 101113
	    goto ERROR
        /* 'Falta fecha de nacimiento'*/      
     end
   end
   --si es null se setea el tipo de persona
   if @i_tipo is null
   begin
        select @i_tipo = pa_char from cobis..cl_parametro
        where pa_producto ='CLI'
        and pa_nemonico ='VGTPNA'
   end


/* **************** SE COMENTA PARA FIE - JBA - MAY 28 2015 ****************
   --Valida WorldCheck: se efectua por FrontEnd antes de Creacion pero se coloca esta ejecucion por los procesos batch que crean clientes
   exec @w_return = sp_valida_worldcheck
      @s_ssn           = @s_ssn,
      @s_date          = @s_date,
      @s_user          = @s_user,
      @s_term          = @s_term,
      @s_ofi           = @s_ofi,
      @t_trn           = 1027,
      @t_debug         = @t_debug,
      @t_file          = @t_file,
      @t_from          = @t_from,
      @i_modo          = 'F',
      @i_operacion     = 'V',
      @i_firstname     = @i_nombre,
      @i_lastname      = @i_papellido

   if @w_return <> 0
   begin
      exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num    = @w_return
       return  @w_return
   end
* **************** SE COMENTA PARA FIE - JBA - MAY 28 2015 ****************/
   --begin tran

            exec cobis..sp_cseqnos
               @t_debug    = @t_debug,
               @t_file     = @t_file,
               @t_from     = @w_sp_name,
               @i_tabla    = 'cl_ente',
               @o_siguiente    = @o_ente out

      /* insertar los parametros de entrada */
    select @w_ecivil = ltrim(rtrim(@w_ecivil))
    
    IF(ltrim(rtrim(@i_nombre))='MA.')
    BEGIN
     IF(ltrim(rtrim(@i_segnombre))='' OR ltrim(rtrim(@i_segnombre))=' ' OR @i_segnombre IS NULL )
      BEGIN
        select @o_ente = null    
        select @w_error = 103161
	    	if @i_batch = 'N'
            goto ERROR
        else begin
	    		PRINT ' desde batch ' + @i_batch + '  710566'
	    		return 710566
		end
        
	  ENd
    END
 
    --LGU-ini 2017-06-15 creacion del CURP y RFC
    if @i_modo = 0 begin
	
	select @w_msg = @i_nombre + isnull(' ' + @i_segnombre,'')
	
    exec @w_return = cobis..sp_generar_curp
        @i_primer_apellido       = @i_papellido,
        @i_segundo_apellido      = @i_sapellido,
        @i_nombres               = @w_msg,
        @i_sexo                  = @i_sexo,
        @i_fecha_nacimiento      = @i_fecha_nac,
        @i_entidad_nacimiento    = @i_ciudad_nac,
        @o_mensaje               = @w_msg  out,
        @o_curp                  = @w_curp out,
        @o_rfc                   = @w_rfc  out
	   
    if @w_return <> 0
    BEGIN
    
        select @o_ente = null
		if @i_batch = 'N'
			exec cobis..sp_cerror
			/* Error en actualizacion de persona */
			 @t_debug= @t_debug,
			 @t_file   = @t_file,
			 @t_from   = @w_sp_name,
			 --@i_msg    = @w_msg,
			 @i_num    = @w_return
           ELSE  begin
              print @w_return 
			PRINT ' desde batch ' + @i_batch + '  710566'
			return 710566
		end
    end

	if @i_tipo_ced = 'CURP' and exists(select 1 from cobis..cl_parametro where pa_nemonico = 'ACRXCR' and pa_char = 'N')
    begin	
        --No debe generar el curp #210163, pero se deja si el dato no viene de las pantallas , parametro ACRXCR = 'N'
        select @i_cedula = isnull(@i_cedula, @w_curp)
    end

    select
        @o_curp = @i_cedula,
        @o_rfc  = @w_rfc
    end else if @i_modo = 1 begin
       select @w_rfc = @i_rfc       
    end 
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
                        en_rfc, /* LGU: calculo del RFC y CURP*/ en_banco
               )
               values  (@o_ente,              'P',               @i_nombre,          @i_papellido,     @i_sapellido,
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
        --MTA Inicio Se actualiza la oficina y el oficial del cliente cuando viene por la aplicacion mobil
        SELECT @w_ofi_mobil = pa_int
          FROM cobis..cl_parametro
         WHERE pa_nemonico = 'MOBOFF'
		 
		if(@i_oficina = @w_ofi_mobil) 
	    begin
	       SELECT @i_oficial = oc_oficial,
	              @i_oficina = fu_oficina
            FROM cobis..cc_oficial,
                 cobis..cl_funcionario,
                 cobis..cl_ente
           WHERE c_funcionario = fu_login
             AND fu_funcionario= oc_funcionario
             AND en_ente= @o_ente
			 
		   update cobis..cl_ente
		      set en_oficina = @i_oficina,
			      en_oficial = @i_oficial
		    where en_ente = @o_ente
	    end
		--MTA Fin

        select @w_ea_ced_ruc = replace(@i_cedula,'-','')

        if exists (select 1 from cobis..cl_ente_aux where ea_ced_ruc = @i_cedula ) begin
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
                            ea_nro_ciclo_oi, /*LPO Santander*/ ea_nit, ea_consulto_renapo, ea_colectivo, ea_nivel_colectivo
                           )
                     values(   @o_ente,          @w_estado_referencia,   @i_ea_observacion_aut,  @i_ea_contrato_firmado,     @i_menor,          --5
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
                            @i_ea_nro_ciclo_oi, /*LPO Santander*/ @w_rfc, @w_renapo_curp, @i_colectivo, @i_nivel_colectivo
                           )


   if @@error <> 0
   BEGIN
      select @w_error = 103105
      if @i_batch = 'N'
         goto ERROR
      else
         return @w_error
   end
   
   --SRO. Inicia Biometricos
    if @i_bio_tipo_identificacion is not null and @i_bio_tipo_identificacion  in ('INE', 'IFE') begin
	   /*if @i_bio_tipo_identificacion = 'INE' and @i_bio_cic is null begin
	      select @w_error = 103400
          if @i_batch = 'N'
	         goto ERROR
          else
             return @w_error
	   end
	   else if @i_bio_tipo_identificacion = 'IFE' and (@i_bio_ocr is null or @i_bio_numero_emision is null or @i_bio_clave_lector is null) begin
          select @w_error = 103401
		if @i_batch = 'N'
	         goto ERROR
          else
             return @w_error
           
	   end*/ -- Comentado en R.203621
	   
	   --Secuencial
       exec 
       @w_error     = cobis..sp_cseqnos
       @t_debug     = 'N',
       @t_file      = null,
	         @t_from   = @w_sp_name,
       @i_tabla     = 'cl_ente_bio',
       @o_siguiente = @w_secuencial out
       
       if @w_error <> 0 begin
          goto ERROR
       end
	   
	   
	   insert into cobis..cl_ente_bio
	   (eb_secuencial, eb_ente, eb_tipo_identificacion,     eb_cic,      eb_ocr,      eb_nro_emision,        eb_clave_elector,      eb_sin_huella_dactilar,             eb_fecha_registro,
	   eb_anio_registro, eb_anio_emision)
	   values  
	   (@w_secuencial, @o_ente, @i_bio_tipo_identificacion, @i_bio_cic,  @i_bio_ocr,  @i_bio_numero_emision, @i_bio_clave_lector,  isnull(@i_bio_huella_dactilar,'N'), getdate(),
	   @i_register_year, @i_emission_year)
   
	   if @@error <> 0
       BEGIN
          select @w_error = 103402
          if @i_batch = 'N'
	         goto ERROR
	     else
             return @w_error
       end
	   
	   insert into cobis..cl_ente_bio_his
	   (ebh_ssn,                            ebh_ente,              ebh_tipo_identificacion,     ebh_cic,
       ebh_ocr,                             ebh_nro_emision,       ebh_clave_elector,           ebh_sin_huella_dactilar,             
	   ebh_fecha_registro,                  ebh_fecha_vencimiento, ebh_anio_registro,           ebh_anio_emision,
	   ebh_fecha_modificacion,              ebh_transaccion,       ebh_usuario,                 ebh_terminal,
	   ebh_srv,                             ebh_lsrv)
	   values                               
	   (@s_ssn,                             @o_ente,               @i_bio_tipo_identificacion,  @i_bio_cic, 	         
	   @i_bio_ocr,                          @i_bio_numero_emision, @i_bio_clave_lector, 	      isnull(@i_bio_huella_dactilar,'N'),  
	   getdate(),                           null,                  @i_register_year,            @i_emission_year,
	   getdate(),                           'I',                   @s_user,                     @s_term,
	   @s_srv,                              @s_lsrv)
		
       if @@error <> 0
       BEGIN
         select @w_error = 103402
         if @i_batch = 'N'
            goto ERROR
         else
            return @w_error
       end
	   
   end
    --SRO. Fin Biometricos
	
	
   --SRO. Inicia Actualización Negative FILE
   exec @w_error   = cob_credito..sp_negative_file
   @i_ente         = @o_ente,
   @o_resultado    = @w_resultado_nf output   
   
   if @w_error <> 0 begin
      goto ERROR
   end
   
   select @o_lista_negra = case when @w_resultado_nf = 1 then 'N' else 'S' end
   --SRO. Fin Actualización Negative FILE
   
/* **************** SE COMENTA PARA FIE - JBA - MAY 28 2015 ****************
      --Verifica Coincidencias WorldCheck y las pasa a Tablas definitivas
        exec @w_return = sp_valida_worldcheck
           @s_ssn           = @s_ssn,
           @s_srv           = @s_srv,
           @s_lsrv          = @s_lsrv,
           @s_date          = @s_date,
           @s_user          = @s_user,
           @s_term          = @s_term,
           @s_ofi           = @s_ofi,
           @t_trn           = 1026,
           @t_debug         = @t_debug,
           @t_file          = @t_file,
           @t_from          = @t_from,
           @i_fecha         = @s_date,
           @i_ente          = @o_ente,
           @i_firstname     = @i_nombre,
           @i_lastname      = @i_papellido,
           @i_modo          = 'F',
           @i_operacion     = 'D'

       if @w_return <> 0
       begin
          exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num    = @w_return
           return  @w_return
       end
* **************** SE COMENTA PARA FIE - JBA - MAY 28 2015 ****************/

print 'antes ts_persona_prin'
      /* Envia datos al front-end */
      select en_ente,       en_nombre,      en_ced_ruc,
             en_tipo_ced,   p_p_apellido,   p_s_apellido,
             p_s_nombre
        from  cobis..cl_ente
       where  en_ente = @o_ente

       select @o_ente

    /* transaccion de servicio - nuevo */
    insert into cobis..ts_persona_prin (   secuencia,      tipo_transaccion,      clase,               fecha,               usuario,
                        terminal,                   srv,                   lsrv,                persona,             nombre,
                        p_apellido,                 s_apellido,            sexo,                cedula,              /*pasaporte,*/
                        tipo_ced,                   pais,                  profesion,           estado_civil,        actividad,
                        num_cargas,                 nivel_ing,             nivel_egr,           tipo,                filial,
                        oficina,                    /*casilla_def,*/       /*tipo_dp,*/         fecha_nac,           grupo,
                        oficial,                    /*mala_referencia,*/   comentario,          retencion,           fecha_mod,
                        /*fecha_emision,*/          fecha_expira,          /*asosciada,*/       /*nit_per,*/         ciudad_nac,
                        /*lugar_doc,*/              calif_cliente,         /*doc_validado,*/    /*rep_superban,*/    /*exc_por2,*/
                        /*digito,*/                 s_nombre,              c_apellido,          secuen_alterno,/*        departamento,        num_orden,
                        promotor,                   nacionalidad,          cod_otro_pais,       inss,                licencia,
                        ingre,                      id_tutor,              nombre_tutor,        bloquear,            categoria,
                        referidor_ecu,              carg_pub,              rel_carg_pub,        estado_ea,           observacion_aut,
                        contrato_firmado,           menor_edad,            conocido_como,       cliente_planilla,    cod_risk,
                        sector_eco,                 actividad_ea,          empadronado,         lin_neg,             seg_neg,
                        val_id_check,               ejecutivo_con,         suc_gestion,         constitucion,        remp_legal,
                        apoderado_legal,            act_comp_kyc,          fecha_act_kyc,       no_req_kyc_comp,     act_perfiltran,
                        fecha_act_perfiltran,       con_salario,           fecha_consal,        sin_salario,         fecha_sinsal,
                        actualizacion_cic,          fecha_act_cic,         excepcion_cic,       fuente_ing,          act_prin,
                        detalle,                    act_dol,               cat_aml,             */tipo_vinculacion)

                  values (@s_ssn,                         @t_trn,                'N',                   @s_date,                     @s_user,
                        @s_term,                          @s_srv,                @s_lsrv,               @o_ente,                     @i_nombre,
                        @i_papellido,                     @i_sapellido,          @i_sexo,               @i_cedula,                   /*@i_pasaporte,*/
                        @i_tipo_ced,                      null,                  @i_profesion,          @i_est_civil,                @i_actividad,
                        @i_num_cargas,                    null,                  null,                  @i_tipo,                     @i_filial,
                        @i_oficina,                       /*null,*/              /*null,*/              @i_fecha_nac,                null,
                        @i_oficial,                       /*'N',*/               null,                  null,                        null,
                        /*@i_fecha_emision,*/             @i_fecha_expira,       /*null,*/              /*null,*/                    @i_ciudad_nac,
                        /*@i_lugar_doc,*/                 null,                  /*'N',*/               /*null,*/                    /*null,*/
                        /*@i_digito,*/                    @i_segnombre,          @i_c_apellido,         @i_secuencial,/*       @i_depart_doc,               @i_numord,
                        null,                             @i_nacionalidad,       null,                  null,                        null,
                        @i_ingre,                         null,                  null,                  @i_bloquear,                 @i_categoria,
                        null,                             null,                  null,                  @w_estado_referencia,        @i_ea_observacion_aut,
                        @i_ea_contrato_firmado,           @i_ea_menor_edad,      @i_ea_conocido_como,   @i_ea_cliente_planilla,      @i_ea_cod_risk,
                        @i_ea_sector_eco,                 @i_ea_actividad,       @i_ea_empadronado,     @i_ea_lin_neg,               @i_ea_seg_neg,
 @i_ea_val_id_check,               @i_ea_ejecutivo_con,   @i_ea_suc_gestion,     @i_ea_constitucion,          @i_ea_remp_legal,
                        @i_ea_apoderado_legal,            @i_ea_act_comp_kyc,    @i_ea_fecha_act_kyc,   @i_ea_no_req_kyc_comp,       @i_ea_act_perfiltran,
                        @i_ea_fecha_act_perfiltran,       @i_ea_con_salario,     @i_ea_fecha_consal,    @i_ea_sin_salario,           @i_ea_fecha_sinsal,
                        @i_ea_actualizacion_cic,          @i_ea_fecha_act_cic,   @i_ea_excepcion_cic,   @i_ea_fuente_ing,            @i_ea_act_prin,
                        @i_ea_detalle,                    @i_ea_act_dol,         @i_ea_cat_aml,       */@i_tipo_vinculacion)

   if @@error <> 0
   BEGIN
      select @w_error = 103005
   		if @i_batch = 'N'
	     goto ERROR
      else
         return @w_error
   end

   select @i_secuencial = @i_secuencial + 1

    insert into cobis..ts_persona_sec (secuencia,          tipo_transaccion,      clase,               fecha,                 usuario,
                        terminal,                   srv,                   lsrv,                persona,               nombre,
                        p_apellido,                 s_apellido,            /*sexo,              cedula,                pasaporte,
                        tipo_ced,                   pais,                  profesion,           estado_civil,          actividad,
                        num_cargas,                 nivel_ing,             nivel_egr,           tipo,                  filial,
                        oficina,                    casilla_def,           tipo_dp,             fecha_nac,             grupo,
                        oficial,                    mala_referencia,       comentario,          retencion,             fecha_mod,
                        fecha_emision,              fecha_expira,          asosciada,           nit_per,               ciudad_nac,
                        lugar_doc,                  calif_cliente,         doc_validado,        rep_superban,          exc_por2,
                        digito,                     s_nombre,              c_apellido,          departamento,          num_orden,
                        promotor,                   nacionalidad,          cod_otro_pais,       inss,                  licencia,*/
                        ingre,                      id_tutor,              nombre_tutor,        bloquear,              /*categoria,*/
                        /*referidor_ecu,*/          /*carg_pub,*/          /*rel_carg_pub,*/    /*estado_ea,*/         /*observacion_aut,*/
                        /*contrato_firmado,*/       menor_edad,            conocido_como,       cliente_planilla,      cod_risk,
                        sector_eco,                 actividad_ea,          /*empadronado,*/     lin_neg,               seg_neg,
                        /*val_id_check,*/           /*ejecutivo_con,*/     /*suc_gestion,*/     /*constitucion,*/      remp_legal,
                        apoderado_legal,            /*act_comp_kyc,*/      /*fecha_act_kyc,*/   /*no_req_kyc_comp,*/   /*act_perfiltran,*/
                        /*fecha_act_perfiltran,*/   /*con_salario,*/       /*fecha_consal,*/    /*sin_salario,*/       /*fecha_sinsal,*/
                        /*actualizacion_cic,*/      /*fecha_act_cic,*/     /*excepcion_cic,*/   fuente_ing,            act_prin,
                        detalle,                    /*act_dol,*/           cat_aml,             secuen_alterno2,/*           tipo_vinculacion*/
						colectivo,             		nivel_colectivo)
						
                  values (@s_ssn,                       @t_trn,                    'N',                       @s_date,                     @s_user,
                        @s_term,                          @s_srv,                    @s_lsrv,                   @o_ente,                     @i_nombre,
                        @i_papellido,                     @i_sapellido,              /*@i_sexo,                 @i_cedula,                   @i_pasaporte,
                        @i_tipo_ced,                      null,                      @i_profesion,              @i_est_civil,                @i_actividad,
                        null,                             null,                      null,                      @i_tipo,                     @i_filial,
                        @i_oficina,                       null,                      null,                      @i_fecha_nac,                null,
                        @i_oficial,                       'N',                       null,                      null,                        null,
                        @i_fecha_emision,                 @i_fecha_expira,           null,                      null,                        @i_ciudad_nac,
                        @i_lugar_doc,                     null,                      'N',                       null,                        null,
                        @i_digito,                        @i_segnombre,              @i_c_apellido,             @i_depart_doc,               @i_numord,*
                        null,                             @i_nacionalidad,           null,                      null,                        null,*/
                        @i_ingre,                         null,                      null,                      @i_bloquear,                 /*@i_categoria,*/
                        /*null,*/                         /*null,*/                  /*null,*/                  /*@w_estado_referencia,*/    /*@i_ea_observacion_aut,*/
                        /*@i_ea_contrato_firmado,*/       @i_ea_menor_edad,          @i_ea_conocido_como,       @i_ea_cliente_planilla,      @i_ea_cod_risk,
                        @i_ea_sector_eco,                 @i_ea_actividad,           /*@i_ea_empadronado,*/     @i_ea_lin_neg,               @i_ea_seg_neg,
                        /*@i_ea_val_id_check,*/           /*@i_ea_ejecutivo_con,*/   /*@i_ea_suc_gestion,*/     /*@i_ea_constitucion,*/      @i_ea_remp_legal,
                        @i_ea_apoderado_legal,            /*@i_ea_act_comp_kyc,*/    /*@i_ea_fecha_act_kyc,*/   /*@i_ea_no_req_kyc_comp,*/   /*@i_ea_act_perfiltran,*/
                        /*@i_ea_fecha_act_perfiltran,*/   /*@i_ea_con_salario,*/     /*@i_ea_fecha_consal,*/    /*@i_ea_sin_salario,*/       /*@i_ea_fecha_sinsal,*/
                        /*@i_ea_actualizacion_cic,*/      /*@i_ea_fecha_act_cic,*/   /*@i_ea_excepcion_cic,*/   @i_ea_fuente_ing,            @i_ea_act_prin,
                        @i_ea_detalle,                    /*@i_ea_act_dol,*/         @i_ea_cat_aml,             @i_secuencial, /*          @i_tipo_vinculacion*/			 @i_colectivo, 				@i_nivel_colectivo)


   if @@error <> 0
   BEGIN
      select @w_error = 103005
   		if @i_batch = 'N'
	     goto ERROR
		else
         return @w_error
   end

   --*-----------------------------------------------------------------------------------*--
   --* REALIZA EL REGISTRO DEL HISTORICO DE IDENTIFICACIONES
   --* GDE -- CONTROL DE CAMBIOS CLIENTES
   --*-----------------------------------------------------------------------------------*--
   exec @w_return = cobis..sp_registra_ident
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
      
   --commit tran

return 0
end

ERROR:
exec cobis..sp_cerror
@t_debug    = @t_debug,
@t_file     = @t_file,
@t_from     = @w_sp_name,
@i_num      = @w_error
   
return @w_error


go


