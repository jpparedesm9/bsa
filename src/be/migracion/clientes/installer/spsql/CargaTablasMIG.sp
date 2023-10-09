/***********************************************************************/
/*      Archivo:                        CargaTablasMIG.sql             */
/*      Stored procedure:               sp_carga_tabla_mig             */
/*      Base de Datos:                  cob_externos                   */
/*      Producto:                       Clientes                       */
/***********************************************************************/
/*                      IMPORTANTE                                      */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/***********************************************************************/
/*                      PROPOSITO                                      */
/* Realiza la carga desde las tablas _EXT hacias las tablas _MIG       */
/* para la migracion.                                                  */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      25/08/2016      Ignacio Yupa            Emision Inicial         */  
/***********************************************************************/

use cob_externos
go

--Borrado de las tablas _MIG


if exists(select * from sysobjects where name = 'sp_carga_tabla_mig')
   drop proc sp_carga_tabla_mig
go

create proc sp_carga_tabla_mig
as
declare
   @w_sp_name         varchar(30),
   @w_tabla           varchar(30),
   @w_cont            int,
   -- @w_nomcolumna         varchar(30),
   @w_conteo             int,
   @w_contador           int,
   @w_comited            int,
   @w_ente               int,
   @w_err_ente           int,
   @w_rows_to_comit      int,
   @w_relacion           smallint,
   @w_ente_i             int,
   @w_ente_d             int
    
set nocount on
select @w_sp_name        = 'sp_carga_tabla_mig',
       @w_rows_to_comit  = 1000


--------------------------------
-- BORRADO DE LAS TABLAS MIG
--------------------------------
exec borrado_tablas_mig

-- ----------------------------------------------------------------------
-- CL_ENTE_MIG
-- ----------------------------------------------------------------------
    select @w_contador = 0, @w_comited  = 0       
    select @w_conteo   = count(1) from cl_ente_ext
    if @w_conteo = 0   return 0
   
    begin tran
    while not @w_contador = @w_conteo
    begin
        if @w_comited = @w_rows_to_comit
        begin
            select @w_comited = 0
            commit tran
            select @@TRANCOUNT
            begin tran
        end
        -- ------------------------------------------------------------------
        -- - Cargo tabla MIG
        -- ------------------------------------------------------------------
        select @w_ente = en_ente from cl_ente_ext e
         where e.en_ente not in (select m.en_ente from cl_ente_mig m)
        
        insert into cl_ente_mig(
        en_ente  ,    en_nombre ,   en_subtipo ,          en_filial   ,        en_oficina  ,     en_ced_ruc  ,      en_fecha_crea,     en_fecha_mod ,
        en_direccion ,en_referencia,en_casilla   ,        en_casilla_def,      en_tipo_dp    ,   en_balance   ,     en_grupo    ,      en_pais     ,
        en_oficial  , en_actividad, en_retencion,         en_mala_referencia , en_comentario  ,  en_cont_malas   ,  s_tipo_soc_hecho , en_tipo_ced,
        en_digito ,   en_sector ,   en_referido ,         en_nit ,             en_doc_validado , en_rep_superban ,  p_p_apellido  ,    p_s_apellido  ,
        p_sexo      , p_fecha_nac , p_ciudad_nac  ,       p_lugar_doc   ,      p_profesion   ,   p_pasaporte   ,    p_estado_civil,    p_num_cargas  ,
        p_num_hijos  ,p_nivel_ing  ,p_nivel_egr   ,       p_nivel_estudio,     p_tipo_persona ,  p_tipo_vivienda,   p_personal     ,   p_propiedad   ,
        p_trabajo  ,  p_soc_hecho  ,p_fecha_emision,      p_fecha_expira ,     en_asosciada   ,  c_posicion     ,   c_tipo_compania,   c_rep_legal,
        c_es_grupo  , c_capital_social,c_fecha_const  ,   c_plazo   ,       c_direccion_domicilio,c_fecha_inscrp ,c_fecha_aum_capital,
        c_cap_pagado, c_total_activos,c_num_empleados,    c_sigla          ,   c_escritura  ,    c_fecha_exp    ,   c_fecha_vcto   ,   c_registro  , 
        c_fecha_registro,c_fecha_modif,c_fecha_verif    , c_vigencia    ,      c_verificado  ,   c_funcionario ,    en_situacion_cliente,en_patrimonio_tec,
        en_fecha_patri_bruto,en_vinculacion ,en_tipo_vinculacion,en_oficial_sup,en_cliente     , en_perfil_transaccional,en_riesgo,    en_estado_mig,
		en_nomlar)
        select
        en_ente  ,    en_nombre ,   en_subtipo ,          en_filial   ,        en_oficina  ,     isnull(en_ced_ruc,en_nit),en_fecha_crea,en_fecha_mod ,
        en_direccion ,en_referencia,en_casilla   ,        en_casilla_def,      en_tipo_dp    ,   en_balance   ,     en_grupo    ,      en_pais     ,
        en_oficial  , en_actividad, en_retencion,         en_mala_referencia , en_comentario  ,  en_cont_malas   ,  s_tipo_soc_hecho , en_tipo_ced,
        en_digito ,   en_sector ,   en_referido ,         en_nit ,             en_doc_validado , en_rep_superban ,  p_p_apellido  ,    p_s_apellido  ,
        p_sexo      , p_fecha_nac , p_ciudad_nac  ,       p_lugar_doc   ,      p_profesion   ,   p_pasaporte   ,    p_estado_civil,    p_num_cargas  ,
        p_num_hijos  ,p_nivel_ing  ,p_nivel_egr   ,       p_nivel_estudio,     p_tipo_persona ,  p_tipo_vivienda,   p_personal     ,   p_propiedad   ,
        p_trabajo  ,  p_soc_hecho  ,p_fecha_emision,      p_fecha_expira ,     en_asosciada   ,  c_posicion     ,   c_tipo_compania,   c_rep_legal,
        c_es_grupo  , c_capital_social,c_fecha_const ,    c_plazo   ,       c_direccion_domicilio,c_fecha_inscrp ,c_fecha_aum_capital,
        c_cap_pagado, c_total_activos,c_num_empleados,    c_sigla          ,   c_escritura  ,    c_fecha_exp    ,   c_fecha_vcto   ,   c_registro  , 
        c_fecha_registro,c_fecha_modif,c_fecha_verif    , c_vigencia    ,      c_verificado  ,   c_funcionario ,    en_situacion_cliente,en_patrimonio_tec,
        en_fecha_patri_bruto,en_vinculacion ,en_tipo_vinculacion,en_oficial_sup,en_cliente     , en_perfil_transaccional,en_riesgo,    null,
		(isnull(en_nombre,'')+' '+isnull(p_p_apellido,'')+' '+isnull(p_s_apellido,''))
        from cl_ente_ext
        where en_ente = @w_ente
        if @@error <> 0
        begin
            select @w_tabla = 'cl_ente_mig'
            insert into cl_log_mig
                select convert (varchar, @w_ente),
                @w_tabla,
                @w_sp_name,
                NULL,
                'Error al momento de transferir dato a la '+@w_tabla,
                160,
                @w_ente            
        end       
        delete from cl_ente_ext where en_ente = @w_ente
        select @w_contador = @w_contador + 1
        select @w_comited = @w_comited + 1 
    end
    commit tran

-- ----------------------------------------------------------------------
-- CL_DIRECCION_MIG
-- ----------------------------------------------------------------------
    select @w_contador = 0, @w_comited  = 0       
    select @w_conteo   = count(1) from cl_direccion_ext
    if @w_conteo = 0  return 0
   
    begin tran
    while not @w_contador = @w_conteo
    begin 
        if @w_comited = @w_rows_to_comit
        begin
            select @w_comited = 0
            commit tran
            select @@TRANCOUNT
            begin tran
        end
        -- ------------------------------------------------------------------
        -- - Cargo tabla MIG
        -- ------------------------------------------------------------------
        select @w_ente = di_ente from cl_direccion_ext e
         where e.di_ente not in (select m.di_ente from cl_direccion_mig m)
        
        insert into cl_direccion_mig(
        di_ente ,	 di_direccion ,	di_descripcion ,  di_parroquia,   di_ciudad ,	        di_tipo   ,
        di_telefono, di_sector ,	di_zona ,   	  di_oficina ,    di_fecha_registro ,	di_fecha_modificacion ,
        di_vigencia ,di_verificado ,di_funcionario ,  di_fecha_ver ,  di_principal ,   	    di_barrio ,
	    di_provincia,di_estado_mig
        )
        select
        di_ente ,	di_direccion ,	di_descripcion ,  di_parroquia,   di_ciudad ,	        di_tipo   ,
        di_telefono,di_sector ,	    di_zona ,   	  di_oficina ,    di_fecha_registro ,	di_fecha_modificacion ,
        di_vigencia ,di_verificado ,di_funcionario ,  di_fecha_ver ,  di_principal ,   	    di_barrio ,
	    di_provincia, null
        from cl_direccion_ext
        where di_ente = @w_ente
        if @@error <> 0
        begin
            select @w_tabla = 'cl_direccion_mig'
            insert into cl_log_mig
                select convert (varchar, @w_ente),
                @w_tabla,
                @w_sp_name,
                NULL,
                'Error al momento de transferir dato a la '+@w_tabla,
                160,
                @w_ente                
        end       
        delete from cl_direccion_ext where di_ente = @w_ente
        select @w_contador = @w_contador + 1
        select @w_comited = @w_comited + 1 
    end
    commit tran
-- ----------------------------------------------------------------------
-- CL_REFINH_MIG
-- ----------------------------------------------------------------------
    select @w_contador = 0, @w_comited  = 0       
    select @w_conteo = count(1) from cl_refinh_ext
    if @w_conteo = 0  return 0
   
    begin tran
    while not @w_contador = @w_conteo
    begin
        if @w_comited = @w_rows_to_comit
        begin
            select @w_comited = 0
            commit tran
            select @@TRANCOUNT
            begin tran
        end
        
        -- ------------------------------------------------------------------
        -- - Cargo tabla MIG
        -- ------------------------------------------------------------------
        select @w_ente = in_codigo from cl_refinh_ext e
         where e.in_codigo not in (select m.in_codigo from cl_refinh_mig m)
        
        insert into cl_refinh_mig(
        in_codigo      ,in_ced_ruc     ,in_nombre      ,in_fecha_ref   ,in_origen      ,in_observacion ,
        in_fecha_mod   ,in_subtipo     ,in_p_p_apellido,in_p_s_apellido,in_tipo_ced    ,in_nomlar      ,in_estado      ,
        in_sexo        ,in_entid       ,in_estado_mig  )
        select
        in_codigo      ,in_ced_ruc     ,in_nombre      ,in_fecha_ref   ,in_origen      ,in_observacion ,
        in_fecha_mod   ,in_subtipo     ,in_p_p_apellido,in_p_s_apellido,in_tipo_ced    ,in_nomlar      ,in_estado      ,
        in_sexo        ,in_entid       , null
         from cl_refinh_ext
        where in_codigo = @w_ente
        if @@error <> 0
        begin
            select @w_tabla = 'cl_refinh_mig'
            insert into cl_log_mig
                select convert (varchar, @w_ente),
                @w_tabla,
                @w_sp_name,
                NULL,
                'Error al momento de transferir dato a la '+@w_tabla,
                160,
                @w_ente            
        end       
        delete from cl_refinh_ext where in_codigo = @w_ente
        select @w_contador = @w_contador + 1
        select @w_comited = @w_comited + 1 
    end
    commit tran
-- ----------------------------------------------------------------------
-- CL_TELEFONO_MIG
-- ----------------------------------------------------------------------
    select @w_contador = 0, @w_comited  = 0
    select @w_conteo   = count(1) from cl_telefono_ext
    if @w_conteo = 0   return 0
   
    begin tran
    while not @w_contador = @w_conteo
    begin  
        if @w_comited = @w_rows_to_comit
        begin
            select @w_comited = 0
            commit tran
            select @@TRANCOUNT
            begin tran
        end
        -- ------------------------------------------------------------------
        -- - Cargo tabla MIG
        -- ------------------------------------------------------------------
        select @w_ente = te_ente from cl_telefono_ext e
         where e.te_ente not in (select m.te_ente from cl_telefono_mig m)
        
        insert into cl_telefono_mig(te_ente, te_direccion, te_secuencial, te_valor, te_tipo_telefono, te_estado_mig)
        select te_ente , te_direccion  , te_secuencial , te_valor , te_tipo_telefono , null
          from cl_telefono_ext
        where te_ente = @w_ente
        if @@error <> 0
        begin
            select @w_tabla = 'cl_telefono_mig'
            insert into cl_log_mig
                select convert (varchar, @w_ente),
                @w_tabla,
                @w_sp_name,
                NULL,
                'Error al momento de transferir dato a la '+@w_tabla,
                160,
                @w_ente            
        end       
        delete from cl_telefono_ext where te_ente = @w_ente
        select @w_contador = @w_contador + 1
        select @w_comited = @w_comited + 1 
    end
    commit tran

-- ----------------------------------------------------------------------
-- CL_REF_PERSONAL_MIG
-- ----------------------------------------------------------------------
    select @w_contador = 0, @w_comited  = 0
    select @w_conteo   = count(1) from cl_ref_personal_ext
    if @w_conteo = 0   return 0
   
    begin tran
    while not @w_contador = @w_conteo
    begin
        if @w_comited = @w_rows_to_comit
        begin
            select @w_comited = 0
            commit tran
            select @@TRANCOUNT
            begin tran
        end
        
        -- ------------------------------------------------------------------
        -- - Cargo tabla MIG
        -- ------------------------------------------------------------------
        select @w_ente = rp_persona from cl_ref_personal_ext e
         where e.rp_persona not in (select m.rp_persona from cl_ref_personal_mig m)
        
        insert into cl_ref_personal_mig(
        rp_persona    ,rp_referencia        ,rp_nombre            ,rp_p_apellido        ,rp_s_apellido        ,rp_direccion         ,
        rp_telefono_d ,rp_telefono_e        ,rp_telefono_o        ,rp_parentesco        ,rp_fecha_registro    ,rp_fecha_modificacion,
        rp_vigencia   ,rp_verificacion      ,rp_funcionario       ,rp_descripcion       ,rp_fecha_ver         ,rp_estado_mig        )
        select
        rp_persona    ,rp_referencia        ,rp_nombre            ,rp_p_apellido        ,rp_s_apellido        ,rp_direccion         ,
        rp_telefono_d ,rp_telefono_e        ,rp_telefono_o        ,rp_parentesco        ,rp_fecha_registro    ,rp_fecha_modificacion,
        rp_vigencia   ,rp_verificacion      ,rp_funcionario       ,rp_descripcion       ,rp_fecha_ver         ,  null
        from cl_ref_personal_ext
        where rp_persona = @w_ente
        if @@error <> 0
        begin
            select @w_tabla = 'cl_ref_personal_mig'
            insert into cl_log_mig
                select convert (varchar, @w_ente),
                @w_tabla,
                @w_sp_name,
                NULL,
                'Error al momento de transferir dato a la '+@w_tabla,
                160,
                @w_ente
        end       
        delete from cl_ref_personal_ext where rp_persona = @w_ente
        select @w_contador = @w_contador + 1
        select @w_comited = @w_comited + 1 
    end
    commit tran

-- ----------------------------------------------------------------------
-- CL_TRABAJO_MIG
-- ----------------------------------------------------------------------
    select @w_contador = 0, @w_comited  = 0
    select @w_conteo   = count(1) from cl_trabajo_ext
    if @w_conteo = 0   return 0
   
    begin tran
    while not @w_contador = @w_conteo
    begin  
        if @w_comited = @w_rows_to_comit
        begin
            select @w_comited = 0
            commit tran
            select @@TRANCOUNT
            begin tran
        end
        
        -- ------------------------------------------------------------------
        -- - Cargo tabla MIG
        -- ------------------------------------------------------------------
        select @w_ente = tr_persona from cl_trabajo_ext e
         where e.tr_persona not in (select m.tr_persona from cl_trabajo_mig m)
        
        insert into cl_trabajo_mig(
        
        tr_persona,     tr_trabajo,          tr_empresa,             tr_cargo,       tr_sueldo,         tr_moneda,
        tr_tipo,        tr_fecha_registro,   tr_fecha_modificacion,  tr_vigencia,    tr_fecha_ingreso,  tr_fecha_salida,
        tr_verificado,  tr_funcionario,      tr_fecha_verificacion,  tr_estado_mig )
        select
        tr_persona,     tr_trabajo,          tr_empresa,             tr_cargo,       tr_sueldo,         tr_moneda,
        tr_tipo,        tr_fecha_registro,   tr_fecha_modificacion,  tr_vigencia,    tr_fecha_ingreso,  tr_fecha_salida,
        tr_verificado,  tr_funcionario,      tr_fecha_verificacion,  null
        from cl_trabajo_ext
        where tr_persona = @w_ente
        if @@error <> 0
        begin
            select @w_tabla = 'cl_trabajo_mig'
            insert into cl_log_mig
            select convert (varchar, @w_ente),
                    @w_tabla,
                    @w_sp_name,
                    NULL,
                    'Error al momento de transferir dato a la '+@w_tabla,
                    160,
                    @w_ente
        end       
        delete from cl_trabajo_ext where tr_persona = @w_ente
        select @w_contador = @w_contador + 1
        select @w_comited = @w_comited + 1 
    end
    commit tran

-- ----------------------------------------------------------------------
-- CL_INSTANCIA_MIG
-- ----------------------------------------------------------------------
    select @w_contador = 0, @w_comited  = 0
    select @w_conteo   = count(1) from cl_instancia_ext
    if @w_conteo = 0   return 0
   
    begin tran
    while not @w_contador = @w_conteo
    begin  
        if @w_comited = @w_rows_to_comit
        begin
            select @w_comited = 0
            commit tran
            select @@TRANCOUNT
            begin tran
        end

        -- ------------------------------------------------------------------
        -- - Cargo tabla MIG --> in_lado = I
        -- ------------------------------------------------------------------
        select @w_relacion = e.in_relacion,
               @w_ente_i   = e.in_ente_i, 
               @w_ente_d   = e.in_ente_d 
          from cl_instancia_ext e 
         -- where e.in_estado_mig is null

        insert into cl_instancia_mig( in_relacion,  in_ente_i,  in_ente_d,  in_lado ,  in_fecha,  in_estado_mig)
        select in_relacion,  in_ente_i,  in_ente_d, 'I',in_fecha , null
          from cl_instancia_ext m
         where m.in_ente_i   = @w_ente_i
           and m.in_ente_d   = @w_ente_d
           and m.in_relacion = @w_relacion
        if @@error <> 0
        begin
            select @w_tabla = 'cl_instancia_mig'
            insert into cl_log_mig
            select convert (varchar, @w_relacion),
                    @w_tabla,
                    @w_sp_name,
                    'in_lado = I',
                    @w_ente_i,
                    172,
                    @w_ente_d
        end

        -- ------------------------------------------------------------------
        -- - Cargo tabla MIG --> in_lado = D
        -- ------------------------------------------------------------------
        insert into cl_instancia_mig( in_relacion,  in_ente_d, in_ente_i,  in_lado ,  in_fecha,  in_estado_mig)
        select in_relacion,  in_ente_i,  in_ente_d, 'D',in_fecha , null
          from cl_instancia_mig m
         where m.in_ente_i   = @w_ente_i
           and m.in_ente_d   = @w_ente_d
           and m.in_relacion = @w_relacion
        if @@error <> 0
        begin
            select @w_tabla = 'cl_instancia_mig'
            insert into cl_log_mig
            select convert (varchar, @w_relacion),
                    @w_tabla,
                    @w_sp_name,
                    'in_lado = D',
                    @w_ente_i,
                    172,
                    @w_ente_d
        end

        delete from cl_instancia_ext where in_ente_i=@w_ente_i and in_ente_d=@w_ente_d and in_relacion=@w_relacion
        select @w_contador = @w_contador + 1
        select @w_comited = @w_comited + 1
    end
    commit tran
return 0

go