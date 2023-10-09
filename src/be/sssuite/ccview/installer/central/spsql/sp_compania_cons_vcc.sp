/************************************************************************/
/*  Archivo:            sp_compania_cons_vcc.sp                         */
/*  Stored procedure:   sp_compania_cons_vcc                            */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de documentacion: 10/Nov/1993                                 */
/************************************************************************/
/*                IMPORTANTE                                      */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                PROPOSITO                                       */
/*  Este stored procedure procesa:                                      */
/*  Query de datos de compania                                          */
/*  Query de nombre completo de compania                                */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*  FECHA       AUTOR       RAZON                                       */
/*  06/09/2012  IOR         Copia para Vista Consolidada                */
/************************************************************************/
use cobis
go
if exists (select 1 from sysobjects where name = 'sp_compania_cons_vcc')
   drop proc sp_compania_cons_vcc
go
CREATE PROCEDURE dbo.sp_compania_cons_vcc (
        @s_ssn                  int          = null,
        @s_user                 login        = null,
        @s_term                 varchar(30)  = null,
        @s_date                 datetime     = null,
        @s_srv                  varchar(30)  = null,
        @s_lsrv                 varchar(30)  = null,
        @s_ofi                  smallint     = null,
        @s_rol                  smallint     = NULL,
        @s_org_err              char(1)      = NULL,
        @s_error                int          = NULL,
        @s_sev                  tinyint      = NULL,
        @s_msg                  descripcion  = NULL,
        @s_org                  char(1)      = NULL,
        @t_debug                char(1)      = 'N',
        @t_file                 varchar(10)  = null,
        @t_from                 varchar(32)  = null,
        @t_trn                  int          = null,
        @i_operacion            char(1),               -- Opcion con la que se ejecuta el programa
        @i_compania             int          = NULL,   -- Codigo secuencial de la compania que se va a consulta
        @i_nombre               descripcion  = null,   -- Nombre de la compania
        @i_posicion             catalogo     = null,   -- Posicion economica de la compania
        @i_ruc                  numero       = null,   -- Número de RUC de la companía
        @i_grupo                int          = null,   -- Codigo del grupo economico de la compania
        @i_rep_legal            int          = null,   -- Codigo secuencial del Rrpresentante legal de la compañia
        @i_activo               money        = null,   -- Cantidad del total de activos de la compania
        @i_pasivo               money        = null,   -- Cantidad del total de pasivos de la compania
        @i_pais                 smallint     = null,   -- Codigo del pais de la compania
        @i_filial               tinyint      = null,   -- Codigo de la filial donde se apertura la compania
        @i_oficina              smallint     = null,   -- Codigo de la oficina donde se consulta el cliente
        @i_tipo                 catalogo     = null,   -- Tipo de compania
        @i_oficial              smallint     = null,   -- Codigo del oficial
        @i_es_grupo             char(1)      = 'N',    -- Indicador si la compania es un grupo economico
        @i_retencion            char(1)      = null,   -- Indicador si es sujeto de retencion
        --SPO Agromercantil
        @i_codsuper             char(10)     = null,    -- Codigo de la SIB
        @i_tipspub              char(10)     = null,    -- Codigo del tipo sector publico
        @i_subspub              char(10)     = null,    -- Codigo del subsector publico
        @i_actividad            char(10)     = null,    -- Codigo de la actividad de la empresa
        @i_sectoreco            char(10)     = null,    -- Codigo del nicho de la empresa
        @i_segmento             char(10)     = null,    -- Codigo del segmento de la empresa

        @i_subemp1              char(10)     = null,    -- Subempresa nivel 1 CVI Personalizacion BDF
        @i_subemp2              char(10)     = null,    -- Subempresa nivel 2 CVI Personalizacion BDF
        @i_actneg               char(10)     = null,    -- Subempresa
        @i_cobertura            varchar(30)  = null,    -- Cobertura
        @i_suplidores           descripcion  = null,    -- Suplidores

        @i_razon_social   varchar(64)  = null,    -- Razon social de la empresa
        @i_tipo_op              char(1)      = null,    -- Subopcion para verificar existencia
        @i_nit                  numero       = null,    -- NIT de la empresa
        @o_siguiente            int          = null out, -- Codigo secuencial asignado a la compania
        @o_dif_oficial          tinyint      = null out, -- Codigo del oficial
        @i_formato_fecha int                 = null,  --CVA Dic-26-03
        @i_numtrib     char(20)     = null,    --Numero Tributario
        @i_categoria            catalogo     = null    --CVA Abr-23-07
)
as
declare @w_today                datetime,
    @w_sp_name              varchar(32),
    @w_return               int,
    @w_direccion            int,
    @o_principal_login      login, -- login del oficial principal
    @o_suplente_login       login, -- login del oficial suplente
    @o_es_grupo             char(1),
    @o_nombre               varchar(64), --50
    @o_posicion             catalogo,
    @o_tcompania            catalogo,
    @o_ruc                  numero,
    @o_ced_ruc              numero,
    @o_grupo                int,
    @o_rep_legal            int,
    @o_pais                 smallint,
    @o_comentario           varchar(254),
    @o_oficial              smallint,
    @o_retencion            char(1),
    @o_asosciada            catalogo,
    @o_tipo_vinculacion     catalogo,
    @o_desc_tipo_vinculacion   descripcion,
    @o_mala_ref             char(1),
    @o_desc_act             descripcion,
    @o_desc_posi            descripcion,
    @o_desc_grupo           descripcion,
    @o_desc_func            descripcion,
    @o_desc_rep             descripcion,
    @o_desc_tcomp           descripcion,
    @o_nacionalidad         descripcion,
    @o_desc_lugar     descripcion,
    @o_fecha_crea     char(10),
    @o_cod_sector     catalogo,
    @o_sector      descripcion,
    @o_cod_tip_soc    catalogo,
    @o_tip_soc     descripcion,
    @o_tipo_nit    char(2),
    @o_cod_referido      smallint,
    @o_desc_referido  descripcion,
    @o_fecha_mod      char(10),
    @o_fecha_emision  char(10),
    @o_lugar_doc      int,
    @o_total_activos  money,
    @o_num_empleados  smallint,
    @o_sigla    varchar(64),
    @o_rep_superban      char(1),
    @o_doc_validado      char(1),
    @o_gran_contribuyente   char(1),
    @o_situacion_cliente     catalogo,
    @o_patrim_tec         money,
    @o_fecha_patrimbruto    char(10),
    @o_desc_situacion_clie  varchar(25),
    @o_oficial_sup    smallint,
    @o_desc_func_sup  descripcion,
    @o_preferen    char(1),
    @o_exc_sipla            char(1),
    @o_exc_por2             char(1),
    @o_nivel_ing      money,
    @o_nivel_egr      money,
    @o_cem         money,

    @o_codsuper             varchar(10),
    @o_tipspub              varchar(10),
    @o_subspub              varchar(10),
    @o_subemp               varchar(10),
    @o_sectoreco            varchar(10),
    @o_segmento             varchar(10),
    @o_subemp1              char(10)   ,
    @o_subemp2              char(10)   ,
    @o_actneg               char(10)   ,
    @o_cobertura            varchar(30),
    @o_suplidores           descripcion,

    @o_desc_codsuper        varchar(64),
    @o_desc_tipspub         varchar(64),
    @o_desc_subspub         varchar(64),
    @o_desc_actividad       varchar(64),
    @o_desc_sectoreco       varchar(64),
    @o_desc_segmento        varchar(64),
    @o_razon_social   varchar(64),

    @w_desc_sector          varchar(64),
    @o_promotor             varchar(10),
    @o_desc_promotor        varchar(20),
    @o_desc_subemp1         varchar(60),
    @o_desc_subemp2         varchar(30),
    @o_desc_actneg          descripcion,
    @o_desc_cobertura       varchar(30),
    @o_bloquear    char(1),
    @o_tipo_nit_desc        descripcion,
    @o_digito      char(2),
    @o_relacion    catalogo,
    @o_desc_relacion  descripcion,
    @o_numtrib     char(20),
    @o_oficina     smallint,
    @o_desc_oficina      descripcion,
    @w_filial      int,
    @o_pasaporte            varchar(20),
    @w_canal_bv          tinyint,
    @w_tipo_medio        varchar(6),
    @w_desc_tipo_medio   varchar(64),
    @w_mascara         varchar(30),
    @w_contador_nid    int,
    @w_contador_msk    int,
    @w_caractermask    char(1),
    @w_newcadenaid     varchar(30),
    @w_lentipoid       int,
    @w_caracterid      char(1),
    @o_categoria            catalogo,          --I.CVA Abr-23-07
    @o_desc_categoria       varchar(64),  --I.CVA Abr-23-07
    @w_referido_ext         int,          -- Dario Cumbal Sincronizacion Bolivariano
    @w_des_referido_ext     descripcion,  -- Dario Cumbal Sincronizacion Bolivariano
    @w_nacionalidad         int,          -- Dario Cumbal Sincronizacion Bolivariano
    @w_des_nacionalidad     descripcion,  -- Dario Cumbal Sincronizacion Bolivariano
    @w_vu_pais              catalogo,          -- Dario Cumbal Sincronizacion Bolivariano
    @w_vu_banco             catalogo,   -- Dario Cumbal Sincronizacion Bolivariano
    @w_otros_ingresos       money, -- CL00031 RVI  02-Feb-2010 --PSO Sincronizaci¾n BOLIVARIANO
    @w_origen_ingresos      descripcion, -- CL00031 RVI  02-Feb-2010 --PSO Sincronizaci¾n BOLIVARIANO
    @w_es_cliente           char

select @w_today=@s_date/*getdate()*/
select @w_sp_name = 'sp_compania_cons_vcc'

--PSO Sincronizaci¾n BOLIVARIANO
select @w_vu_pais = pa_char
  from cobis..cl_parametro
 where pa_producto = 'ADM'
   and pa_nemonico = 'ABPAIS'

if @@rowcount <> 1
begin
   exec cobis..sp_cerror
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_num       = 201196
   return 1
end
select @w_vu_banco = pa_char
  from cobis..cl_parametro
 where pa_producto = 'ADM'
   and pa_nemonico = 'CLIENT'

if @@rowcount <> 1
begin
   exec cobis..sp_cerror
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_num       = 201196
   return 1
end
--PSO FIN Sincronizaci¾n BOLIVARIANO


if @t_debug = 'S'
begin
   exec cobis..sp_begin_debug @t_file = @t_file
   select '/** Stored Procedure **/ '  = @w_sp_name,
      s_ssn              = @s_ssn,
      s_user             = @s_user,
      s_term             = @s_term,
      s_date             = @s_date,
      s_srv              = @s_srv,
      s_lsrv             = @s_lsrv,
      s_ofi              = @s_ofi,
      s_rol              = @s_rol,
      s_org_err          = @s_org_err,
      s_error            = @s_error,
      s_sev              = @s_sev,
      s_msg              = @s_msg,
      s_org              = @s_org,
      t_trn              = @t_trn,
      t_file             = @t_file,
      t_from             = @t_from,
      i_operacion        = @i_operacion,
      i_compania         = @i_compania,
      i_nombre           = @i_nombre,
      i_posicion         = @i_posicion,
      i_ruc              = @i_ruc,
      i_grupo            = @i_grupo,
      i_rep_legal        = @i_rep_legal,
      i_activo           = @i_activo,
      i_pasivo           = @i_pasivo,
      i_pais             = @i_pais,
      i_filial           = @i_filial,
      i_oficina          = @i_oficina,
      i_tipo             = @i_tipo,
      i_es_grupo         = @i_es_grupo,
--    i_comentario       = @i_comentario,
      i_oficial          = @i_oficial,
      --SPO Agromercantil
      i_codsuper     = @i_codsuper,
                i_tipspub      = @i_tipspub,
                i_subspub      = @i_subspub,
                i_actividad    = @i_actividad,
                i_sectoreco    = @i_sectoreco,
                i_segmento     = @i_segmento,
      i_razon_social = @i_razon_social,
      i_subemp1      = @i_subemp1,
                i_subemp2      = @i_subemp2,
                i_actneg       = @i_actneg,
                i_cobertura    = @i_cobertura,
                i_suplidores   = @i_suplidores


   exec cobis..sp_end_debug
end


/*  consulta de todos los datos de una compania */
/* Query */
if @i_operacion = 'Q'
/* datos completos de compania */
begin

if @t_trn = 73924
begin
  
       select   @o_nombre   =  en_nombre,
            @o_posicion =  c_posicion,
            @o_ruc      =  en_ced_ruc,
            @o_es_grupo =  c_es_grupo,
            @o_grupo =  en_grupo,
            @o_oficial  =  en_oficial,
            @o_tcompania   =  c_tipo_compania,
            @o_pais     =  en_pais,
            @o_retencion   =  en_retencion,
            @o_mala_ref =  en_mala_referencia,
            @o_comentario  =  en_comentario,
            @o_fecha_crea  =  convert(char(10),en_fecha_crea,@i_formato_fecha),
            @o_fecha_mod   =  convert(char(10),en_fecha_mod,@i_formato_fecha),
            @o_asosciada   =  en_asosciada,
            @o_tipo_vinculacion  =  en_tipo_vinculacion,
        --    @o_cod_sector   =       c_nicho,   -- Dario Cumbal Sincronizacion Version
            @o_cod_referido   =  en_referido,
            @o_tipo_nit =  en_tipo_ced,
            @o_cod_tip_soc =  c_tipo_soc,
            @o_fecha_emision =   convert(char(10), p_fecha_emision, @i_formato_fecha),
            @o_lugar_doc   =  p_lugar_doc,
            @o_total_activos= c_total_activos,
            @o_num_empleados= c_num_empleados,
            @o_sigla =  c_sigla,
            @o_rep_superban   =  en_rep_superban,
            @o_doc_validado   =  en_doc_validado,
            @o_gran_contribuyente = en_gran_contribuyente,
            @o_situacion_cliente   = en_situacion_cliente,
            @o_patrim_tec       = en_patrimonio_tec,
            @o_fecha_patrimbruto  = convert(char(10),en_fecha_patri_bruto,@i_formato_fecha),
            @o_oficial_sup  = en_oficial_sup,
            @o_preferen = en_preferen,
            @o_exc_sipla    =       en_exc_sipla,
            @o_nivel_ing   =       p_nivel_ing,
            @o_nivel_egr   =  p_nivel_egr,
            @o_exc_por2     =       en_exc_por2,
          --  @o_cem      =  en_cem,
            --AGROMERCANTIL
           -- @o_codsuper     = c_codsuper,
          --  @o_tipspub      = c_tipspub,
          --  @o_subspub      = c_subspub,
           -- @o_actneg       = c_activ_mark, -- Dario Cumbal Sincronizacion Version
           -- @o_sectoreco    = c_nicho,      -- Dario Cumbal Sincronizacion Version
          --  @o_segmento     = c_segmento,
           -- @o_razon_social = c_razon_social,
            --@o_promotor     = en_promotor,
           -- @o_subemp1      = c_subemp1,
            --@o_subemp2      = c_subemp2,
           -- @o_subemp       = c_subemp,
           -- @o_cobertura    = en_cobertura,
       --    @o_suplidores   = en_suplidores,
         --   @o_bloquear =     en_estado,
           @o_digito   = en_digito,
           @o_numtrib  = en_nit,
            @o_oficina  = en_oficina,
            @w_filial   = en_filial,
            @o_pasaporte    = p_pasaporte,
            @o_categoria    = en_concordato, --CVA Abr-23-07 reutilizado para categoria
           -- @w_referido_ext =         en_referidor_ecu,  -- Dario Cumbal Sincronizacion Bolivariano
          --  @w_nacionalidad =         en_nacionalidad,   -- Dario Cumbal Sincronizacion Bolivariano
          -- _- @w_otros_ingresos       = en_otros_ingresos,    -- CL00031 RVI  02-Feb-2010   --PSO Sincronizaci¾n BOLIVARIANO
           -- @w_origen_ingresos      = en_origen_ingresos,    -- CL00031 RVI  02-Feb-2010  --PSO Sincronizaci¾n BOLIVARIANO
            @w_es_cliente           = (select case when (en_ente in (select cl_cliente 
                                       from cl_cliente WITH(index (cl_cliente_Key)))) then 'S' else 'N' end from cl_ente where en_ente = @i_compania and en_subtipo = 'C')
        from  cl_ente
        where en_ente = @i_compania
        and   en_subtipo = 'C'
       
       
   /* si no se traen datos, error */
   if @@rowcount = 0
   begin
    exec sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = 101001
      /* 'No existe dato solicitado'*/
    return 1
   end

-- Agregado por ROLANDO LINARES 09232006
if @o_tipo_nit is not null
    begin
      /****PEDRO COELLO RELLENAR CON _ CUANDO LA MASCARA CAMBIO DE TAMAÑO ****/

       /*select @w_mascara = td_mascara
         from cobis..cl_tipo_documento
        where td_codigo = @o_tipo_nit*/

       select @w_lentipoid = datalength(@w_mascara),
             @w_newcadenaid = @o_ruc,
             @w_contador_msk = 0,
             @w_contador_nid = 1

      while @w_contador_nid <= @w_lentipoid
         begin
           select @w_contador_msk = @w_contador_msk + 1
           select @w_caracterid = substring(@o_ruc, @w_contador_nid, 1)

           Lee_Nuevo_car_Mascara:
           select @w_caractermask = substring(@w_mascara, @w_contador_msk, 1)

           if @w_caractermask = '\'
              select @w_contador_msk = @w_contador_msk + 1,@w_caractermask = substring(@w_mascara, @w_contador_msk, 1)

           if (@w_caractermask = '#' Or @w_caractermask = 'a') And (@w_caracterid = '-' Or @w_caracterid is null)
              begin
                  select @w_newcadenaid = substring(@w_newcadenaid, 1, @w_contador_msk - 1) + '_' +
                         substring(@w_newcadenaid, @w_contador_msk, datalength(@w_newcadenaid)),@w_contador_msk = @w_contador_msk + 1

                  if @w_contador_msk <= @w_lentipoid
                     GoTo Lee_Nuevo_car_Mascara
                  else
                     break
              end

            select @w_contador_nid = @w_contador_nid + 1
          end --   while @w_contador_nid <= @w_lentipoid

       select @o_ruc = @w_newcadenaid
    end -- if @o_tipo_nit is not null

/****PEDRO COELLO RELLENAR CON _ CUANDO LA MASCARA CAMBIO DE TAMAÑO ****/



/**************** si sector es not null ***********/
if @o_cod_sector is not null
begin
   select   @o_sector = valor
   from  cl_catalogo, cl_tabla
   where cl_tabla.tabla = 'cl_sectoreco'
      and   cl_catalogo.tabla  = cl_tabla.codigo
        and cl_catalogo.codigo = @o_cod_sector

   if @@rowcount = 0
   begin
    exec sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = 101048
      /* 'No existe sector'*/
    return 1
   end
end

/**************** si es_grupo es not null ***********/
if @o_grupo is not null
begin
   select   @o_desc_grupo = gr_nombre
   from  cl_grupo
   where gr_grupo = @o_grupo

   if @@rowcount = 0
   begin
    exec sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,

      @t_from     = @w_sp_name,
      @i_num      = 151029
      /* 'No existe grupo'*/
    return 1
   end
end

/**************** si lugar del documento de DI es not null ***********/
if @o_lugar_doc is not null
begin
   select   @o_desc_lugar = ci_descripcion
   from  cl_ciudad
   where ci_ciudad = @o_lugar_doc

   if @@rowcount = 0
   begin
    exec sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,

      @t_from     = @w_sp_name,
      @i_num      = 101195
      /* 'No existe lugar del doc de DI'*/
    return 1
   end
end

/**************** si relacion con banco es not null ***********/
if @o_tipo_vinculacion is not null
begin
   select   @o_desc_tipo_vinculacion = valor
   from  cl_catalogo, cl_tabla
   where cl_tabla.tabla = 'cl_relacion_banco'
   and   cl_catalogo.tabla  = cl_tabla.codigo
   and   cl_catalogo.codigo = @o_tipo_vinculacion

   if @@rowcount = 0
   begin
    exec sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = 101194
      /* 'No existe Tipo de vinculacion'*/
    return 1
   end
end

/**************** si funcionario es not null ***********/
if @o_oficial is not null or @o_oficial != 0
begin
   select   @o_desc_func = fu_nombre,
      @o_principal_login = fu_login

   from  cl_funcionario,cc_oficial
   where oc_oficial = @o_oficial
         and   oc_funcionario = fu_funcionario
   if @@rowcount = 0
   begin
    exec sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = 101036
      /* 'No existe funcionario'*/
    return 1
   end
end


/**************** si oficial suplente es not null ***********/
if @o_oficial_sup is not null
begin
   select   @o_desc_func_sup = fu_nombre,
      @o_suplente_login = fu_login
   from  cl_funcionario,cc_oficial
   where oc_oficial = @o_oficial_sup
          and   oc_funcionario = fu_funcionario

   if @@rowcount = 0
   begin
    exec sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = 101196
      /* 'No existe oficial suplente'*/
    return 1
   end
end


/**************** si referido es not null ***********/
if @o_cod_referido is not null
begin
   select   @o_desc_referido = fu_nombre
   from  cl_funcionario
   where fu_funcionario = @o_cod_referido

   if @@rowcount = 0
   begin
    exec sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = 101197
      /* 'No hay Referido'*/
    return 1
   end
end


 /********** Select sobre la tabla de cl_referidor_externo *************/ -- Dario Cumbal Sincronizacion Bolivariano
 if @w_vu_pais='PA' and @w_vu_banco= 'BBP'
 begin
         if @w_referido_ext  is NULL
         begin
              select @w_referido_ext = NULL
              select @w_des_referido_ext = NULL
         end
         else
         begin
             select @w_des_referido_ext = rtrim(re_nombre)
             from cobis..cl_referidor_externo
             where re_codigo = @w_referido_ext
              if @@rowcount = 0
             begin
                exec sp_cerror @t_debug = @t_debug,
                           @t_file  = @t_file,
                           @t_from  = @w_sp_name,
                           @i_num   = 101036
            /* 'No existe Funicionario'*/
                return 1
             end
      end
end

/*Para Nacionalidad*/
/********** Select sobre la tabla de cl_pais *********************/ -- Dario Cumbal Sincronizacion Bolivariano
if @w_vu_pais='PA' and @w_vu_banco= 'BBP'
begin
      if @w_nacionalidad is NULL
           select @w_nacionalidad = NULL
      else
      begin
           select @w_des_nacionalidad = pa_nacionalidad
           from cl_pais
           where @w_nacionalidad = pa_pais
           if @@rowcount = 0
           begin
            exec sp_cerror @t_debug = @t_debug,
                         @t_file = @t_file,
                         @t_from = @w_sp_name,
                         @i_num = 101018
       /* ÆNo existe PaisÆ*/
             return 1
           end
      end
end


-- CVI Personalizacion BDF

/************ Select sobre tabla catalogo de datos no nulos ******/
    if @o_tcompania!=null
    begin
   select   @o_desc_tcomp  = d.valor
     from  cl_tabla c, cl_catalogo d
    where   c.tabla = 'cl_tipn_jur'
      and c.codigo = d.tabla
      and d.codigo   = @o_tcompania
   if @@rowcount = 0
   begin
       exec sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = 101015
      /* 'No existe dato en catalogo'*/
    return 1
   end
    end




       if @o_situacion_cliente != null --REC
       begin
   select   @o_desc_situacion_clie = n1.valor
     from   cl_catalogo n1,
      cl_tabla t4
    where   n1.codigo   = @o_situacion_cliente
      and   n1.tabla    = t4.codigo
      and   t4.tabla    = 'cl_situacion_cliente'

   if @@rowcount = 0
   begin
    exec sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = 101193
      /* 'No existe situacion del Cliente'*/
    return 1
   end
       end --Fin REC



       If @o_codsuper != null
       begin
   select   @o_desc_codsuper = n1.valor
     from   cl_catalogo n1,
      cl_tabla t4
    where   n1.codigo   = @o_codsuper
      and   n1.tabla    = t4.codigo
      and   t4.tabla    = 'cl_cod_super'

   if @@rowcount = 0
   begin
    exec sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = 101198
      /* 'No existe Cod. Super'*/
    return 1
   end
       end



      If @o_actneg != null
       begin
   select   @o_desc_actneg = ac_descripcion
     from   cobis..cl_actividad_ec
    where   ac_codigo   = @o_actneg

   if @@rowcount = 0
   begin
    exec sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = 101199
      /* 'No existe Actividad del Negocio'*/
    return 1
   end
       end


      If @o_cobertura != null
       begin
   select   @o_desc_cobertura = n1.valor
     from   cl_catalogo n1,
      cl_tabla t4
    where   n1.codigo   = @o_cobertura
      and   n1.tabla    = t4.codigo
      and   t4.tabla    = 'cl_cobertura'

   if @@rowcount = 0
   begin
    exec sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = 107120
      /* 'No existe cobertura'*/
    return 1
   end
       end



     If @o_subemp!= null
       begin
     select @o_desc_actividad = sb_desc_cod_ter
     from   cl_tip_subemp
     where sb_cod_ter = @o_subemp


   if @@rowcount = 0
   begin
      exec sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = 107116
      /* 'No existe Subempresas'*/
    return 1
   end
     end

       select  @o_desc_sectoreco = @o_sector

       If @o_segmento!= null
       begin
   select   @o_desc_segmento = n1.valor
     from   cl_catalogo n1,
      cl_tabla t4
    where   n1.codigo   = @o_segmento
      and   n1.tabla    = t4.codigo
      and   t4.tabla    = 'cl_tip_resd'

   if @@rowcount = 0
   begin
--        print 'Error 9'
    exec sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = 101202
      /* 'No existe Tipo de Residente'*/
    return 1
   end
       end


      If @o_subemp1!= null
        begin
      select @o_desc_subemp1 = sb_n1_desc_cod_cua
      from  cl_sub_emp_niv1
      where sb_n1_cod_cua = @o_subemp1

   if @@rowcount = 0
   begin
      exec sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = 107118
      /* 'No existe Subempresa Nivel 1'*/
      return 1
   end
      end


      If @o_subemp2!= null
        begin
      select @o_desc_subemp2 = sb_n2_desc_cod_quin
      from  cl_sub_emp_niv2
      where sb_n2_cod_quin = @o_subemp2

   if @@rowcount = 0
   begin
      exec sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = 107119
      /* 'No existe Subempresa Nivel 2'*/
      return 1
   end
      end


       if @o_subspub!=null
       begin

         select @o_desc_subspub=tp_des_ssec
         from cl_tipsec_pub
         where tp_cod_sec = @o_tipspub
         and tp_cod_ssec  = @o_subspub

       end


       if @o_promotor != null
       begin
   select   @o_desc_promotor = n1.valor
     from   cl_catalogo n1,
      cl_tabla t4
    where   n1.codigo   = @o_promotor
      and   n1.tabla    = t4.codigo
      and   t4.tabla    = 'cl_promotor'

   if @@rowcount = 0
   begin
        print 'Error 10'
    exec sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = 107108
      /* 'No existe Promotor'*/
    return 1
   end
       end

   /*if @o_tipo_nit != null
   begin
      select @o_tipo_nit_desc = td_descripcion
      from cl_tipo_documento
      where td_codigo = @o_tipo_nit

   if @@rowcount = 0
      begin
      exec sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = 101203
      --'No existe Tipo de Identificacion'
       return 1
      end
   END*/

   /*if @o_grupo is not null
        select @o_relacion = cg_tipo_relacion
   from cl_cliente_grupo
   where cg_ente = @i_compania
   and   cg_grupo = @o_grupo*/

   select @o_desc_relacion = c.valor
   from cl_tabla b, cl_catalogo c
   where c.codigo = @o_relacion
     and b.codigo = c.tabla
     and b.tabla = 'cl_tipo_rel'

/****************Oficina************************************/

   select   @o_desc_oficina = of_nombre
     from cl_oficina
    where @o_oficina = of_oficina
      and @w_filial  = of_filial
   if @@rowcount = 0
   begin
      --print 'pase des_oficina'
      exec sp_cerror  @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 101016
         /*  'No existe dato solicitado'*/
      return 1
   end

   --I. CVA Mar-23-06 Obtener el tipo de servicio de banca virtual para el cliente
   select  @w_canal_bv = af_canal
   from cobis..bv_afiliados_bv
   where af_ente_mis = @i_compania
   if @@rowcount > 0
      select   @w_tipo_medio     = b.codigo,
         @w_desc_tipo_medio   = b.valor
      from cobis..cl_tabla a,  cobis..cl_catalogo b
      where a.tabla = 'bv_servicio'
        and b.tabla = a.codigo
        and b.codigo = convert(varchar(10),@w_canal_bv)
   --F. CVA Mar-23-06


        --I.CVA Abr-23-07 Obtener la categoria
   if @o_categoria is not null
        begin
      select @o_desc_categoria = c.valor
      from cl_tabla b, cl_catalogo c
      where c.codigo = @o_categoria
      and b.codigo = c.tabla
      and b.tabla = 'cl_categoria'
   end
        --I.CVA Abr-23-07 Obtener la categoria


       /***********************  Select ultimo *******************************/
        select    'Fecha Creación       ' = @o_fecha_crea,           --1
        'Tipo de Documento    ' = @o_tipo_nit,             --2
        'No. Id.              ' = @o_ruc,                  --3
        'Nombre Comercial     ' = @o_nombre,               --4
        'Razon Social         ' = @o_razon_social,            --5
        'Cod. Tipo Compañía   ' = @o_tcompania,               --6
        'Tipo de Compañía     ' = @o_desc_tcomp,           --7
        'Cod. Rel. con la Corp. ' = @o_tipo_vinculacion,         --8
        'Relación con la Corp.  ' = @o_desc_tipo_vinculacion,       --9
        'Cod. Presentado por    ' = @o_cod_referido,          --10
        'Nombre Presentado      ' = @o_desc_referido,            --11
        'Total Activos          ' = @o_total_activos,            --12
        'Numero de Empleados    ' = @o_num_empleados,            --13
        'Retención              ' = @o_retencion,          --14
        'Comentarios            ' = @o_comentario,            --15
        'Reportado SuperBan.    ' = @o_rep_superban,          --16
        'Documento Validado     ' = @o_doc_validado,          --17
        'Cod. del Oficial de Cta.  ' = @o_oficial,            --18
        'Nombre del Oficial de Cta.' = @o_desc_func,             --19
        'Fecha Modificación     ' = @o_fecha_mod,          --20
        'Cod. Calificación      ' = @o_posicion,           --21
        'Calificación           ' = @o_desc_posi,          --22
        'Es Grupo               ' = @o_es_grupo,           --23
        'Cod. Grupo             ' = @o_grupo,              --24
        'Nombre Grupo           ' = @o_desc_grupo,            --25
        'Cod. País              ' = @o_pais ,           --26
        'Mala Referencia        ' = @o_mala_ref,           --27
        'Situación Cliente      ' = @o_situacion_cliente,        --28
        'Desc. Situac. Cliente  ' = @o_desc_situacion_clie,         --29
        'Patrimonio Bruto       ' = @o_patrim_tec,            --30
        'Fecha Patrim-Bruto     ' = @o_fecha_patrimbruto,        --31
        'Cod. Oficial de Cta Sup    ' = @o_oficial_sup,       --32
        'Nombre Oficial de Cta Sup  ' = @o_desc_func_sup,        --33
        'Cliente Preferencial       ' = @o_preferen,          --34
        'Excento FOPA               ' = @o_exc_sipla,           --35
        'Ingresos                   ' = @o_nivel_ing,            --36
        'Egresos                    ' = @o_nivel_egr,            --37
        'Cupo Endeudamiento Maximo     ' = @o_cem,            --38

        --Agromercantil
        'Código de la Super            ' = @o_codsuper,           --39
        'Descripción de código Super   ' = @o_desc_codsuper,       --40
        'Tipo de sector Publico        ' = @o_tipspub,                      --41
        'Descripción del Sector        ' = @o_desc_tipspub,              --42
        'Tipo de subsector             ' = @o_subspub,          --43
        'Descripción del subsector     ' = @o_desc_subspub,           --44
        'Código de Actividad           ' = @o_subemp,           --45
        'Descripción de Actividad      ' = @o_desc_actividad,            --46
        'Código de Nicho               ' = @o_sectoreco,        --47
        'Descripción del Nicho         ' = @o_desc_sectoreco,         --48
        'Código de Segmento            ' = @o_segmento,                  --49
        'Descripción del Segmento      ' = @o_desc_segmento,             --50
        'Cod. Lugar Doc.               ' = @o_lugar_doc,         --51
        'Lugar Documento            ' = @o_desc_lugar,        --52
        'Cod. Promotor                 '  = @o_promotor,                        --53
        'Promotor del Cliente          '  = @o_desc_promotor,                   --54
        'SubEmpresa1'                     = @o_subemp1,         --55
        'Descripción SubEmpresa1'         = @o_desc_subemp1,       --56
        'SubEmpresa2'                     = @o_subemp2,           --57
        'Descripción SubEmpresa2'         = @o_desc_subemp2,       --58
        'Actividad del negocio'           = @o_actneg,             --59
        'Descripción de Act.Negocio   '   = @o_desc_actneg,        --60
        'Cobertura                     '  = @o_cobertura,       --61
        'Descripción Cobertura         '  = @o_desc_cobertura,        --62
        'Principales Suplidores        '  = @o_suplidores,         --63
        'Login del oficial de cta.     ' = @o_principal_login,         --64
        'Login del oficial suplente    ' = @o_suplente_login,       --65
        'Bloqueado               ' = @o_bloquear,          --66
        'Descripción Tipo Doc.   ' = @o_tipo_nit_desc,           --67
        'Cod. Sector Eco.     ' = @o_cod_sector,           --68
        'Sector Económico  ' = @o_sector,               --69
        'Dígito Verificador   ' = @o_digito,               --70
        'Relación Grupo Eco.  ' = @o_desc_relacion,           --71
        'Número Tributario    ' = @o_numtrib,           --72
        'Sucursal Origen   ' = @o_oficina,           --73
        'Desc. Sucursal Origen   ' = @o_desc_oficina,            --74
        'Cod. Rel. Grupo Eco.   ' = @o_relacion,           --75
        'Fecha Autorización Cliente' = @o_fecha_emision,         --76
        'Oficial Autorizante     ' = @o_pasaporte,                              --77
        'Tipo de Medio     ' = @w_tipo_medio,                             --78
        'Desc. Tipo de Medio     ' = @w_desc_tipo_medio,                        --79
        'Categoria               ' = @o_categoria,                              --80
        'Desc. Categoria         ' = @o_desc_categoria,                          --81
        'Referido Ext por '           = @w_referido_ext,    --                 --82   Dario Cumbal sincronizacion Bolivariano
        'Nombre de Referido Ext por'  = @w_des_referido_ext,--                 --83   Dario Cumbal sincronizacion Bolivariano
        'Cod. Nacionalidad'           = @w_nacionalidad,    --                 --84   Dario Cumbal sincronizacion Bolivariano
        'Nacionalidad'                = @w_des_nacionalidad, --                 --85   Dario Cumbal sincronizacion Bolivariano            
        'Otros Ingresos Mensuales'    = @w_otros_ingresos,  -- CL00031 RVI  02-Feb-2010  --86  --PSO Sincronizaci¾n BOLIVARIANO
        'Origen de Otros Ingresos'    = @w_origen_ingresos,  -- CL00031 RVI  02-Feb-2010  --87  --PSO Sincronizaci¾n BOLIVARIANO
        'EsCliente'                   = @w_es_cliente

   /******Verificar si tiene direccion SCA QA***************/
        select @w_direccion = count (di_ente)
             from cl_direccion where di_ente = @i_compania

        select isnull(@w_direccion,0)


end
else
begin
   exec sp_cerror
      @t_debug      = @t_debug,
      @t_file       = @t_file,
      @t_from       = @w_sp_name,
      @i_num        = 151051
      /*  'No corresponde codigo de transaccion' */
   return 1
end

end

return 0
go
