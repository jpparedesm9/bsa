/************************************************************************/
/*  Archivo:            sp_persona_cons_vcc .sp                         */
/*  Stored procedure:   sp_persona_cons_vcc                             */
/*  Base de datos:      cobis                                           */
/*  Producto: Clientes                                                  */
/*  Disenado por:  Mauricio Bayas/Sandra Ortiz                          */  
/*  Fecha de escritura: 05-Nov-1992                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Este stored procedure procesa:                                      */
/*  Query de datos de persona                                           */
/*  Query de nombre completo de persona                                 */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR                RAZON                              */
/*  06/Sep/2012   IOR                Copia de sp_se_ente para VCC       */
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_persona_cons_vcc')
   drop proc sp_persona_cons_vcc
go

create proc sp_persona_cons_vcc (

        @s_ssn          int             = null,
        @s_user         login           = null,
        @s_term         varchar(30)     = null,
        @s_date         datetime        = null,
        @s_srv          varchar(30)     = null,
        @s_lsrv         varchar(30)     = null,
        @s_ofi          smallint        = null,
        @s_rol          smallint        = NULL,
        @s_org_err      char(1)         = NULL,
        @s_error        int             = NULL,
        @s_sev          tinyint         = NULL,
        @s_msg          descripcion     = NULL,
        @s_org          char(1)         = NULL,
        @t_debug        char(1)         = 'N',
        @t_file         varchar(10)     = null,
        @t_from         varchar(32)     = null,
        @t_trn          int             = null,
        @i_operacion     char(1),                
        @i_persona      int             = null,
        @i_tipo         char(1)         = null, 
        @i_nit          numero          = null, 
        @i_formato_fecha int            = null  
)
as
declare @w_today            datetime,
        @w_sp_name          varchar(32),
        @w_return           int,
        @w_dias_anio_nac    smallint,
        @w_dias_anio_act    smallint,
        @w_inic_anio_nac    datetime,
        @w_inic_anio_act    datetime,
        @w_anio_nac         char(4),
        @w_anio_act         char(4),
        @w_siguiente        int,
        @w_codigo           int,
        @w_nombre           varchar(32),
        @w_p_apellido       varchar(20),
        @w_s_apellido       varchar(20),
        @w_sexo             descripcion,
        @w_tipo_ced         char(2),
        @w_cedula           numero,
        @w_pasaporte        varchar(20),
        @w_pais             smallint,
        @w_des_pais         descripcion,
        @w_profesion        catalogo,
        @w_des_profesion    descripcion,
        @w_estado_civil     catalogo,
        @w_des_estado_civil descripcion,
        @w_num_cargas       tinyint,            
        @w_num_hijos        tinyint,            
        @w_nivel_ing        money,
        @w_nivel_egr        money,
        @w_filial           int,
        @w_oficina          smallint,
        @w_oficina_origen   smallint,
        @w_des_oficina      descripcion,
        @w_tipo             catalogo,
        @w_des_tipo         descripcion,
        @w_nivel_estudio    catalogo,           
        @w_des_niv_est      descripcion,        
        @w_tipo_vivienda    catalogo,           
        @w_des_tipo_vivienda descripcion,       
        @w_calif_cliente    catalogo,           
        @w_des_calif_cliente descripcion,       
        @w_grupo            int,
        @w_des_grupo        descripcion,
        @w_fecha_nac        datetime,
        @w_fechanac         varchar(10),
        @w_fechareg         varchar(10),
        @w_fechamod         varchar(10),
        @w_fechaing         varchar(10),
        @w_cod_sex          sexo,
        @w_fechaexp         varchar(10),
        @w_ciudad_nac       int,                
        @w_lugar_doc        int,                
        @w_doc_validado     char(1),            
        @w_rep_superban     char(1),            
        @w_des_lugar_doc    descripcion,        
        @w_des_ciudad_nac   descripcion,        
        @w_es_mayor_edad    char(1),            /* 'S' o 'N' */
        @w_tipoced          char(4),            --EAN001
        @w_mayoria_edad     smallint,           /* expresada en a$os */
        @w_oficial          smallint,
        @w_des_oficial      descripcion,
        @w_des_referido      descripcion,
        @w_retencion        char(1),
        @w_exc_sipla        char(1),
        @w_exc_por2         char(1),
        @w_asosciada        catalogo,
        @w_tipo_vinculacion         catalogo,
        @w_des_tipo_vinculacion    descripcion,
        @w_mala_referencia  char(1),
        @w_actividad        catalogo,
        @w_des_actividad    descripcion,
        @w_comentario       varchar(254),
        @w_nit              numero,             
        @w_referido         smallint,           
        @w_cod_sector       catalogo,           
        @w_des_sector       descripcion,        
        @w_gran_contribuyente char(1),
        @w_situacion_cliente  catalogo,
        @w_des_situacion_cliente varchar(25),
        @w_patrim_tec       money,
        @w_fecha_patrim_bruto varchar(10),
        @w_total_activos        money, 
        @w_catalogo             catalogo,
        @w_nom_temp             descripcion,
        @w_oficial_sup          smallint,
        @w_des_oficial_sup      descripcion,
        @w_preferen             char(1),        
--      @w_digito               char(1),
        @w_cem                  money,
        @w_direccion            int,
        @w_c_apellido       varchar(20) ,  --Campo apellido casada
        @w_segnombre        varchar(20) ,  --Campo segundo nombre
        @w_depart_doc       smallint    ,  --Codigo del departamento
        @w_numord           char(4)     ,  --Codigo de orden CV
        @w_des_dep_doc      varchar(20) ,
        @w_des_ciudad       varchar(20),
        @w_promotor         varchar(10),
        @w_des_promotor     varchar(20),
        @w_num_pais_nacionalidad  int,     -- Codigo del pais de la nacionalidad del cliente 
        @w_des_nacionalidad descripcion,
        @w_cod_otro_pais    char(10),      -- Codigo del pais centroamericano 
        @w_inss             varchar(20),   -- Numero de seguro 
        @w_licencia         varchar(30),   -- Numero de licencia 
        @w_ingre            varchar(10),   -- Ingresos
        @w_des_ingresos     varchar(60),   
        @w_principal_login    login,       -- login del oficial principal
        @w_suplente_login   login,         -- login del oficial suplente
        @w_en_id_tutor      varchar(20),   -- ID del tutor
        @w_en_nom_tutor     varchar(60),   -- Nombre del Tutor
        @w_bloquear         char(1),        -- Cliente bloqueado
        @w_relacion         catalogo,
        @w_digito           char(2),
        @w_desc_tipo_ced    descripcion, 
        @w_canal_bv         tinyint,
        @w_tipo_medio       varchar(6),
        @w_desc_tipo_medio  varchar(64),
        @w_categoria        catalogo,   --I.CVA Abr-23-07
        @w_desc_categoria   varchar(64), --I.CVA Abr-23-07
        --PSO Sincronización
        @w_referido_ext             int, -- REQ CL00012
        @w_des_referido_ext         descripcion, -- REQ CL00012
        @w_referidor_ecu            int,
        @w_carg_pub                 char(1),         
        @w_rel_carg_pub             char(1),
        @w_vu_pais         catalogo,
        @w_vu_banco        catalogo,
        --PSO FIN Sincronización
        --08/06/2010 Miguel Mendieta Sincronización Bolivariano
        @w_situacion_laboral            varchar(5),  -- ini CL00031 RVI
        @w_des_situacion_laboral        descripcion,
        @w_bienes                       char(1),
        @w_otros_ingresos               money,
        @w_origen_ingresos              descripcion, -- fin CL00031 RVI
        --08/06/2010 Miguel Mendieta
        @w_es_cliente                   char

select @w_today = @s_date
select @w_sp_name = 'sp_persona_cons_vcc'

select @w_mayoria_edad = 18 /* mayoria de edad */



if @i_operacion = 'Q' /* consulta de datos de persona */
begin
  if @t_trn = 73925
  begin        
        select  @w_p_apellido           = p_p_apellido,
                @w_s_apellido           = p_s_apellido,
                @w_nombre               = en_nombre,
                @w_cedula               = en_ced_ruc,
                @w_pasaporte            = p_pasaporte,
                @w_pais                 = en_pais,
                @w_ciudad_nac           = p_ciudad_nac,   
                @w_fechanac             = convert(char(10), p_fecha_nac, @i_formato_fecha),
                @w_fechareg             = convert(char(10), en_fecha_crea,@i_formato_fecha),
                @w_fechamod             = convert(char(10), en_fecha_mod, @i_formato_fecha),
                @w_retencion            = en_retencion,
                @w_mala_referencia      = en_mala_referencia,
                @w_comentario           = en_comentario,
                @w_fechaing             = convert(char(10),p_fecha_emision,@i_formato_fecha),
                @w_fechaexp             = convert(char(10),p_fecha_expira,@i_formato_fecha),
                @w_tipoced              = en_tipo_ced,
                @w_asosciada            = en_asosciada,
                @w_tipo_vinculacion     = en_tipo_vinculacion,
                @w_nit                  = en_nit,       
                @w_referido             = en_referido,  
                @w_cod_sector           = en_sector,    
                @w_cod_sex              = p_sexo,
                @w_profesion            = p_profesion,
                @w_actividad            = en_actividad,
                @w_estado_civil         = p_estado_civil,
                @w_tipo                 = p_tipo_persona,
                @w_nivel_estudio        = p_nivel_estudio,      
                @w_grupo                = en_grupo,
                @w_oficial              = en_oficial,
                @w_lugar_doc            = p_lugar_doc,          
                @w_tipo_vivienda        = p_tipo_vivienda,      
                @w_calif_cliente        = p_calif_cliente,      
                @w_num_hijos            = p_num_hijos,          
                @w_nivel_ing            = p_nivel_ing, 
                @w_nivel_egr            = p_nivel_egr, 
                @w_num_cargas           = p_num_cargas,         
                @w_oficina_origen       = en_oficina ,
                @w_doc_validado         = en_doc_validado ,
                @w_rep_superban         = en_rep_superban ,
                @w_filial               = en_filial,
                @w_gran_contribuyente   = en_gran_contribuyente,
                @w_situacion_cliente    = en_situacion_cliente,
                @w_patrim_tec           = en_patrimonio_tec,
                @w_fecha_patrim_bruto   = convert(char(10),en_fecha_patri_bruto,@i_formato_fecha),
                @w_total_activos        = c_total_activos,
                @w_oficial_sup          = en_oficial_sup,
                @w_preferen             = en_preferen,          
                @w_exc_sipla            = en_exc_sipla,         
                @w_exc_por2             = en_exc_por2,
                @w_digito               = en_digito,
                @w_cem                  = en_cem,
                @w_c_apellido           = p_c_apellido,   
                @w_segnombre            = p_s_nombre,
                @w_depart_doc           = p_dep_doc, 
                @w_numord               = p_numord,
                @w_promotor             = en_promotor,
                @w_num_pais_nacionalidad = en_nacionalidad,
                @w_cod_otro_pais        = en_cod_otro_pais,
                @w_inss                 = en_inss,
                @w_licencia             = en_licencia,   
                @w_ingre                = en_ingre,  
                @w_en_id_tutor          = en_id_tutor,  --ID del tutor
                @w_en_nom_tutor         = en_nom_tutor,  --Nombre del Tutor
                @w_bloquear             = en_estado,
                @w_categoria            = en_concordato,  --I.CVA Abr-23-07 Campo para categoria  
                @w_referido_ext         = en_referidor_ecu, -- E.Corrales REQ CL00012 --PSO Sincronización
                @w_carg_pub             = p_carg_pub,         --PSO Sincronización
                @w_rel_carg_pub         = p_rel_carg_pub, --PSO Sincronización
                @w_situacion_laboral    = p_situacion_laboral,  -- ini CL00031 RVI --08/06/2010 Miguel Mendieta Sincronización Temporal Bolivariano
                @w_bienes               = p_bienes, --08/06/2010 Miguel Mendieta Sincronización Temporal Bolivariano
                @w_otros_ingresos       = en_otros_ingresos, --08/06/2010 Miguel Mendieta Sincronización Temporal Bolivariano
                @w_origen_ingresos      = en_origen_ingresos,    -- fin CL00031 RVI --08/06/2010 Miguel Mendieta Sincronización Temporal Bolivariano
                @w_es_cliente           = (select case when (en_ente in (select cl_cliente from cl_cliente(index cl_cliente_Key))) 
                                           then 'S' else 'N' end from cl_ente where en_ente = @i_persona and en_subtipo = 'P')
        from    cl_ente
        where   en_ente = @i_persona
          and   en_subtipo = 'P'
        if @@rowcount = 0
        begin
                exec sp_cerror  @t_debug    = @t_debug,
                                @t_file     = @t_file,
                                @t_from     = @w_sp_name,
                                @i_num      = 101001 
                                /*  'No existe dato solicitado'*/
                return 1
        end

        select @w_relacion = cg_tipo_relacion
        from cl_cliente_grupo
        where cg_ente = @i_persona
        
        if @w_cod_sex is not NULL
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
                                /*  'No existe dato solicitado'*/
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
                 where cl_catalogo.codigo       = @w_tipo
                   and cl_catalogo.tabla        = cl_tabla.codigo
                   and cl_tabla.tabla           = 'cl_ptipo' 
                if @@rowcount = 0
                begin
                        exec sp_cerror  @t_debug    = @t_debug,
                                        @t_file     = @t_file,
                                        @t_from     = @w_sp_name,
                                        @i_num      = 101021
                        /*  'No existe Tipo de persona'*/
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
                        print 'pase profesion'
                        exec sp_cerror  @t_debug    = @t_debug,
                                        @t_file     = @t_file,
                                        @t_from     = @w_sp_name,
                                        @i_num      = 101019
                        /*  'No existe dato solicitado'*/
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
                                /*  'No existe Tipo de vivienda'*/
                        return 1
                end

        end



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
                                /*  'No existe promotor'*/
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
                                /*  'No existe dato solicitado'*/
                        return 1
                end

        end

        if @w_tipoced ='P' or @w_tipoced = 'E' or @w_tipoced = 'PE' or @w_tipoced = 'N'
        begin
                if @w_ciudad_nac is NULL 
                begin
                        select @w_des_ciudad_nac = NULL
                end
                else
                begin
                        select  @w_des_ciudad_nac = pa_descripcion
                          from  cl_pais
                         where  @w_ciudad_nac     = pa_pais
/*                      if @@rowcount = 0
                        begin
                                --print 'pase ciudad_nac'
                                exec sp_cerror  @t_debug    = @t_debug,
                                                @t_file     = @t_file,
                                                @t_from     = @w_sp_name,
                                                @i_num      = 101001
                                /*  'No existe dato solicitado'*/
                                return 1
                        end*/
                end
                        
        end
        else    
        begin
                select  @w_des_ciudad_nac = ci_descripcion
                  from  cl_ciudad
                 where  ci_ciudad = @w_ciudad_nac
--                 and    ci_provincia = @w_depart_doc 
/*              if @@rowcount = 0
                begin
                        exec sp_cerror  @t_debug    = @t_debug,
                                        @t_file     = @t_file,
                                        @t_from     = @w_sp_name,
                                        @i_num      = 101001
                        /*  'No existe dato solicitado'*/
                        return 1
                end*/
        end

        if @w_tipoced ='P' or @w_tipoced = 'E' --or @w_tipoced = 'PE' or @w_tipoced = 'N'
        begin
                select  @w_des_lugar_doc = pa_descripcion
                  from  cl_pais
                 where  pa_pais          = @w_lugar_doc
/*              if @@rowcount = 0
                begin
                        exec sp_cerror  @t_debug    = @t_debug,
                                        @t_file     = @t_file,
                                        @t_from     = @w_sp_name,
                                        @i_num      = 101001
                        -- 'No existe dato solicitado' --
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
                        /*  'No existe dato solicitado'*/
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
 
/*              if @@rowcount = 0
                begin
                        --print 'pase Grupo'
                        exec sp_cerror  @t_debug    = @t_debug,
                                        @t_file     = @t_file,
                                        @t_from     = @w_sp_name,
                                        @i_num      = 101001
                        /*  'No existe dato solicitado'*/
                        return 1
                end*/
        end

/********** Select sobre la tabla de cl_funcionario *********************/
        if @w_oficial is NULL or @w_oficial = 0
                select  @w_oficial = NULL
        else
        begin /*** MODIFICACION FUNCIONARIOS REC ******/
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
/** FIN MODIFICACION FUNCIONARIOS *******/
                if @@rowcount = 0
                begin
                        --print 'pase Mod. FIn Funcionarios'
                        exec sp_cerror  @t_debug    = @t_debug,
                                        @t_file     = @t_file,
                                        @t_from     = @w_sp_name,
                                        @i_num      = 101036
                        /*  'No existe funcionario'*/
                        return 1
                end
        end
/********** Select sobre la tabla de cl_funcionario *********************/
        if @w_oficial_sup is NULL
                select  @w_oficial_sup = NULL
        else
        begin /*** MODIFICACION FUNCIONARIOS REC ******/
                /*      select @w_nom_temp = fu_nombre
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
                        /*  'No existe Funicionario'*/
                                return 1
                        end                            
                select @w_des_oficial_sup = substring(@w_nom_temp,1,45)
/** FIN MODIFICACION FUNCIONARIOS *******/
                if @@rowcount = 0
                begin
                        --print 'pase Mod. FIn Funcionarios'
                        exec sp_cerror  @t_debug    = @t_debug,
                                        @t_file     = @t_file,
                                        @t_from     = @w_sp_name,
                                        @i_num      = 101036
                                /*  'No existe Funicionario'*/
                        return 1
                end
        end
/********** Select sobre la tabla de cl_funcionario *********************/
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
                               /*  'No existe Funicionario'*/
                        return 1
                end
        end
/********** Select sobre la tabla de cl_pais *********************/
        if @w_pais is NULL 
                select @w_pais = NULL
        else
        begin
                select  @w_des_pais = pa_descripcion 
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

/*Para Nacionalidad*/
/********** Select sobre la tabla de cl_pais *********************/
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
                        /*  'No existe Pais'*/
                        return 1
                end
        end


/********** Select sobre la tabla de cl_oficina *********************/
        select  @w_des_oficina = of_nombre
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
                        /*  'No existe dato solicitado'*/
                return 1
        end
/********************************* actual ****************************/
--SPO Inclusion de la descripcion del departamento

        if @w_depart_doc is not NULL
        begin
                select @w_des_dep_doc  = cl_catalogo.valor
                  from cl_catalogo, cl_tabla
                 where cl_catalogo.codigo       = convert(char(4),@w_depart_doc)
                   and cl_catalogo.tabla        = cl_tabla.codigo
                   and cl_tabla.tabla           = 'cl_provincia' 
/*              if @@rowcount = 0
                begin
                        print 'No existe departamento'
                        exec sp_cerror  @t_debug    = @t_debug,
                                        @t_file     = @t_file,
                                        @t_from     = @w_sp_name,
                                        @i_num      = 101010
                        --  'No existe dato solicitado'  --
                        return 1
                end*/
        end
/**/
/*

        if @w_ciudad_nac is not NULL
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
                        --  'No existe dato solicitado'--
                        return 1
                end
        end
*/
        if @w_tipoced != null
        begin
           select @w_desc_tipo_ced = td_descripcion
           from cl_tipo_documento
           where td_codigo = @w_tipoced    

        if @@rowcount = 0
           begin
           exec sp_cerror
                @t_debug    = @t_debug,
                @t_file     = @t_file,
                @t_from     = @w_sp_name,
                @i_num      = 101203
                /* 'No existe Tipo de Identificacion'*/
            return 1
           end  
        end            

        --I. CVA Mar-23-06 Obtener el tipo de servicio de banca virtual para el cliente
        select  @w_canal_bv = af_canal
        from cobis..bv_afiliados_bv
        where af_ente_mis = @i_persona
        if @@rowcount > 0
                select  @w_tipo_medio           = b.codigo,
                        @w_desc_tipo_medio      = b.valor
                from cobis..cl_tabla a,  cobis..cl_catalogo b
                where a.tabla = 'bv_servicio'
                  and b.tabla = a.codigo
                  and b.codigo = convert(varchar(10),@w_canal_bv)        
        --F. CVA Mar-23-06      

        select  'Fecha de Nacimiento ' = @w_fechanac,                           --1
                'Tipo de Documento   ' = @w_tipoced,                            --2
                'N£mero Documento    ' = @w_cedula,                       --3
                'Fecha Emision Doc.  ' = @w_fechaing, --4
                'Fecha Vencimiento Doc. ' = @w_fechaexp,                     --5
                'Cod. Lugar del Doc.    ' = @w_lugar_doc, --6
                'Lugar del Documento    ' = @w_des_lugar_doc, --7       
                'Nombres                ' = @w_nombre, --8
                'Primer Apellido        ' = @w_p_apellido, --8
                'Segundo Apellido       ' = @w_s_apellido, --9
                'Cod. Ciudad de Nacim.  ' = @w_ciudad_nac,      
                'Ciudad de Nacimiento   ' = @w_des_ciudad_nac,  
                'Sexo                ' = @w_sexo, 
                'Codigo Sexo         ' = @w_cod_sex,
                'Cod. Estado Civil   ' = @w_estado_civil,
                'Estado Civil        ' = @w_des_estado_civil,
                'Codigo Profesion    ' = @w_profesion,
                'Profesion           ' = @w_des_profesion,
                'Codigo Actividad    ' = @w_actividad,
                'Actividad           ' = @w_des_actividad, --20
                'Pasaporte           ' = @w_pasaporte,
                'Codigo Pa¡s         ' = @w_pais,
                'Pa¡s                ' = @w_des_pais,
                'Codigo Sector       ' = @w_cod_sector, 
                'Sector Economico    ' = @w_des_sector,
                'Cod. de Estudio     ' = @w_nivel_estudio,      
                'Nivel de Estudio    ' = @w_des_niv_est,
                'Tipo de Persona     ' = @w_tipo,
                'Desc. Tipo de Persona  ' = @w_des_tipo,
                'Cod. Tipo Vivienda     ' = @w_tipo_vivienda,
                'Tipo Vivienda          ' = @w_des_tipo_vivienda,
                'Personas a Cargo       ' = @w_num_cargas,
                'Comentario             ' = @w_comentario,
                'Presentado por         ' = @w_referido,        
                'N£mero de hijos        ' = @w_num_hijos,
                'Reportado SuperBancaria ' = @w_rep_superban,
                'Documento Validado      ' = @w_doc_validado,   
                'Oficial de Cuenta       ' = @w_oficial,
                'Nombre Oficial de Cta.  ' = @w_des_oficial,
                'Fecha de Registro       ' = @w_fechareg,
                'Fecha de Modificacion   ' = @w_fechamod,
                'Cod. Grupo Economico    ' = @w_grupo,          --42
                'Grupo Economico         ' = @w_des_grupo,      --43
                'Retencion               ' = @w_retencion,
                'Malas Referencias       ' = @w_mala_referencia,
                'Tipo Vinculacion        ' = @w_tipo_vinculacion,--46
                --@w_asosciada,
                'N£mero RUC              ' = @w_nit,            
                'Cod. de Calificacion    ' = @w_calif_cliente,  
                'Calificacion Cliente    ' = @w_des_calif_cliente,
                'Desc. Tipo Vin.         ' = @w_des_tipo_vinculacion,
                'Nivel de Ingresos       ' = @w_nivel_ing,              
                'Cod. Sucursal Origen    ' = @w_oficina_origen,
                'Sucursal Origen         ' = @w_des_oficina,    
                'Nombre de Referido Por  ' = @w_des_referido,
                'Gran Contribuyente      ' = @w_gran_contribuyente,
                'Situacion Cliente       ' = @w_situacion_cliente,
                'Desc.Situacion Cliente  ' = @w_des_situacion_cliente,
                'Patrimonio Bruto        ' = @w_patrim_tec,
                'Fecha Patrim. Bruto     ' = convert(char(10),@w_fecha_patrim_bruto,101),
                'Total Activos           ' = @w_total_activos,
                'Cod. Oficial Suplente   ' = @w_oficial_sup,
                'Oficial Suplente        ' = @w_des_oficial_sup,
                'Cliente Preferencial    ' = @w_preferen,
                'Nivel de Egresos        ' = @w_nivel_egr, 
                'Excepto Sipla           ' = @w_exc_sipla,
                'Excepto Por2            ' = @w_exc_por2,
                'D¡gito                  ' = @w_digito,
                'Cupo Endeudamie. M ximo ' = @w_cem,
                'Segundo nombre          ' = @w_segnombre,
                'Apellido de casada      ' = @w_c_apellido,
                'Provincia               ' = @w_depart_doc,
                'Descripcion de la Prov. ' = @w_des_dep_doc,  
                'N£mero de orden         ' = @w_numord,
                'Descripcion Lugar       ' = @w_des_ciudad,
                'Cod. Promotor Cliente   ' = @w_promotor,
                'Promotor Cliente        ' = @w_des_promotor,
                'Pa¡s de Nacionalidad    ' = @w_num_pais_nacionalidad,--77
                'Nacionalidad            ' = @w_des_nacionalidad,
                'Codigo Pa¡s Centroamericano'= @w_cod_otro_pais, -- 79
                'Codigo de Seguro'           = @w_inss,
                'N£mero de Licencia'         = @w_licencia,
                'Codigo de Ingresos'         = @w_ingre,
                'Ingresos Cliente        '   = @w_des_ingresos,
                'Login oficial de cta.   ' = @w_principal_login,        
                'Login oficial suplente  ' = @w_suplente_login,
                'No. Id Tutor            ' = @w_en_id_tutor,
                'Tutor                   ' = @w_en_nom_tutor,
                'Bloqueado               ' = @w_bloquear,
                'Relacion                ' = @w_relacion,       --      89
                'Descripcion Tipo Id.    ' = @w_desc_tipo_ced,  --      90
                'Tipo de Medio           ' = @w_tipo_medio,
                'Desc. Tipo de Medio     ' = @w_desc_tipo_medio,
                'Categoria               ' = @w_categoria,      --CVA abr-23-07
                'Desc. Categoria         ' = @w_desc_categoria,  --CVA abr-23-07
                'Referido Ext por '                     = @w_referido_ext,    -- REQ CL00012 --95 --PSO Sincronización
                'Nombre de Referido Ext por'            = @w_des_referido_ext, -- REQ CL00012 --96  --PSO Sincronización
                'Posee Cargo Publico'                   = @w_carg_pub,         -- REQ CL00017--97  --PSO Sincronización
                'Relacion con Cargo Publico'            = @w_rel_carg_pub,      -- REQ CL00017--98   --PSO Sincronización
                'Codigo Situacion Laboral'              = @w_situacion_laboral, -- ini RVI CL00031  --99 --08/06/2010 Miguel Mendieta Sincronización Temporal Bolivariano
                'Descripcion Situacion Laboral'         = @w_des_situacion_laboral,    --100 --08/06/2010 Miguel Mendieta Sincronización Temporal Bolivariano
                'Separacion de Bienes'                  = @w_bienes,                   --101 --08/06/2010 Miguel Mendieta Sincronización Temporal Bolivariano
                'Otros Ingresos Mensuales'              = @w_otros_ingresos,           --102 --08/06/2010 Miguel Mendieta Sincronización Temporal Bolivariano
                'Origen de Otros Ingresos'              = @w_origen_ingresos,    -- fin RVI CL00031  --103 --08/06/2010 Miguel Mendieta Sincronización Temporal Bolivariano
                'EsCliente'                             = @w_es_cliente


        /******Verificar si tiene direccion SCA QA***************/
        select @w_direccion = count (*) 
             from cl_direccion where di_ente = @i_persona

        select isnull(@w_direccion,0)


        return 0
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


go
