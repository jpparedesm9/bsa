/************************************************************************/
/*      Archivo:                        TrasladaEnte.sql                */
/*      Stored procedure:               sp_traslada_cl_ente             */
/*      Base de Datos:                  cob_externos                    */
/*      Producto:                       Clientes                        */
/************************************************************************/
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
/************************************************************************/
/*                      PROPOSITO                                       */
/* Realiza el paso de la tabla cl_ente de cob_externos a cobis          */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      25/08/2016      Ignacio Yupa            Emision Inicial         */  
/************************************************************************/
use cob_externos
go

if exists(select * from sysobjects where name = 'sp_traslada_cl_ente')
   drop proc sp_traslada_cl_ente
go

create proc sp_traslada_cl_ente
as
declare
  @w_conteo             int,
  @w_contador           int,
  @w_sp_name            varchar(60),
  @w_ente               int,
  @w_tabla              varchar(60),
  @w_perfil_transaccional money,
  @w_riesgo               char(1),
  @w_comited            int,
  @w_ced_ruc            varchar(30),
  @w_subtipo            char(1),
  @w_ente_nuevo         int,
  @w_return             int,
  @w_mensaje            varchar(255),
  @w_fecha              datetime
  

select @w_sp_name = 'sp_traslada_cl_ente'

select @w_conteo = count(*)
from    cob_externos..cl_ente_mig
where   en_estado_mig = 'VE'

if @w_conteo = 0
   return 0

select @w_contador = 0,
       @w_comited  = 0

begin tran
while not @w_contador = @w_conteo
begin
    if @w_comited = 1000
    begin
      select @w_comited = 0
      commit tran
      begin tran
    end
    
    select top 1 @w_ente = en_ente,
                 @w_ced_ruc = en_ced_ruc,
                 @w_riesgo = en_riesgo,
                 @w_perfil_transaccional = en_perfil_transaccional,
                 @w_subtipo = en_subtipo
    from cob_externos..cl_ente_mig
    where en_estado_mig = 'VE'

    exec @w_return = cobis..sp_cseqnos 
            @t_from      = @w_sp_name,
            @i_tabla     = 'cl_ente',
            @o_siguiente = @w_ente_nuevo out

    if @w_return <> 0
    begin
        select @w_tabla = 'cobis..sp_cseqnos',
               @w_mensaje = 'NO HAY SECUENCIAL DE TABLA CL_ENTE',
               @w_fecha = getdate()
        goto ERROR
    end        
    
    if exists (select 1 from cobis..cl_ente 
                where en_ced_ruc = @w_ced_ruc 
                and en_subtipo = @w_subtipo)
    begin
        update cl_ente_mig 
        set en_estado_mig = 'ER'
        where en_ente = @w_ente
        
        update cl_ref_personal_mig 
        set rp_estado_mig = 'ER'
        where rp_persona = @w_ente
        
        update cl_telefono_mig 
        set te_estado_mig = 'ER'
        where te_ente = @w_ente
        
        update cl_trabajo_mig 
        set tr_estado_mig = 'ER'
        where tr_persona = @w_ente
        
        update cl_direccion_mig 
        set di_estado_mig = 'ER'
        where di_ente = @w_ente
        
        update cl_refinh_mig 
        set in_estado_mig = 'ER'
        where in_entid = @w_ente        
    end  
    else
    begin
        -- ------------------------------------------------------------------
        -- - Cargo tabla definitiva
        -- ------------------------------------------------------------------
        insert into cobis..cl_ente(en_ente,         en_nombre,            en_subtipo,            en_filial,        en_oficina,        en_ced_ruc, 
                           en_fecha_crea,           en_fecha_mod,         en_direccion,          en_referencia,    en_casilla,        en_casilla_def, 
                           en_tipo_dp,              en_balance,           en_grupo,              en_pais,          en_oficial,        en_actividad, 
                           en_retencion,            en_mala_referencia,   en_comentario,         en_cont_malas,    s_tipo_soc_hecho,  en_tipo_ced,
                           en_digito,               en_sector,            en_referido,           en_nit,           en_doc_validado,   en_rep_superban, 
                           p_p_apellido,            p_s_apellido,         p_sexo,                p_fecha_nac,      p_ciudad_nac,      p_lugar_doc, 
                           p_profesion,             p_pasaporte,          p_estado_civil,        p_num_cargas,     p_num_hijos,       p_nivel_ing, 
                           p_nivel_egr,             p_nivel_estudio,      p_tipo_persona,        p_tipo_vivienda,  p_personal, 
                           p_propiedad,             p_trabajo,            p_soc_hecho,           p_fecha_emision,  p_fecha_expira, 
                           en_asosciada,            c_posicion,           c_tipo_compania,       c_rep_legal,
                           c_es_grupo,              c_capital_social,     c_fecha_const,         en_nomlar,             c_plazo, 
                           c_direccion_domicilio,   c_fecha_inscrp,       c_fecha_aum_capital,   c_cap_pagado,      
                           c_total_activos,         c_num_empleados,      c_sigla,               c_escritura,      
                           c_fecha_exp,             c_fecha_vcto,         c_registro,            c_fecha_registro, 
                           c_fecha_modif,           c_fecha_verif,        c_vigencia,            c_verificado,     c_funcionario,     en_situacion_cliente, 
                           en_patrimonio_tec,       en_fecha_patri_bruto, 
                           en_vinculacion,       en_tipo_vinculacion,   en_oficial_sup,   en_cliente)
        select @w_ente_nuevo,         en_nombre,           en_subtipo,          en_filial,        en_oficina,        en_ced_ruc, 
               @w_fecha,              @w_fecha,            en_direccion,        en_referencia,    en_casilla,        en_casilla_def, 
               en_tipo_dp,            en_balance,          en_grupo,            en_pais,          en_oficial,        en_actividad, 
               en_retencion,          en_mala_referencia,  en_comentario,       en_cont_malas,    s_tipo_soc_hecho,  en_tipo_ced,
               en_digito,             en_sector,           en_referido,         en_nit,           en_doc_validado,   en_rep_superban, 
               p_p_apellido,          p_s_apellido,        p_sexo,              p_fecha_nac,      p_ciudad_nac,      p_lugar_doc, 
               p_profesion,           p_pasaporte,         p_estado_civil,      p_num_cargas,     p_num_hijos,       p_nivel_ing, 
               p_nivel_egr,           p_nivel_estudio,     p_tipo_persona,      p_tipo_vivienda,   p_personal, 
               p_propiedad,           p_trabajo,           p_soc_hecho,         p_fecha_emision,  p_fecha_expira, 
               en_asosciada,          c_posicion,          c_tipo_compania,     c_rep_legal,
               c_es_grupo,            c_capital_social,    c_fecha_const,       en_nomlar,         c_plazo, 
               c_direccion_domicilio, c_fecha_inscrp,      c_fecha_aum_capital, c_cap_pagado,     
               c_total_activos,       c_num_empleados,     c_sigla,             c_escritura,      
               c_fecha_exp,           c_fecha_vcto,        c_registro,          c_fecha_registro, 
               c_fecha_modif,         c_fecha_verif,       c_vigencia,          c_verificado,     c_funcionario,     en_situacion_cliente, 
               en_patrimonio_tec,     en_fecha_patri_bruto, 
               en_vinculacion,       en_tipo_vinculacion,   en_oficial_sup,   en_cliente       
        from cob_externos..cl_ente_mig
        where en_ente = @w_ente
        if @@error <> 0
        begin
            select @w_tabla = 'cl_ente'
            
            insert into cl_log_mig
            select convert (varchar, en_ente),
                @w_tabla,
                @w_sp_name,
                NULL,
                'Error al momento de transferir dato a la cl_ente',
                160,
                en_ente
            from cl_ente_mig
            where en_ente = @w_ente
            
            update cl_ente_mig 
            set en_estado_mig = 'ER'
            where en_ente = @w_ente
        
            update cl_ref_personal_mig 
            set rp_estado_mig = 'ER'
            where rp_persona = @w_ente
        
            update cl_telefono_mig 
            set te_estado_mig = 'ER'
            where te_ente = @w_ente
        
            update cl_trabajo_mig 
            set tr_estado_mig = 'ER'
            where tr_persona = @w_ente
        
            update cl_direccion_mig 
            set di_estado_mig = 'ER'
            where di_ente = @w_ente
        
            update cl_refinh_mig 
            set in_estado_mig = 'ER'
            where in_entid = @w_ente        
        end
        else
        begin
            insert into cobis..cl_ente_adicional 
            (ea_ente, ea_columna, ea_char, ea_tinyint, ea_smallint, ea_int, ea_money, ea_datetime, ea_float)
            values 
            (@w_ente_nuevo,'en_perfil_transaccional',NULL,NULL,NULL,NULL,@w_perfil_transaccional,NULL,NULL)
    
            insert into cobis..cl_ente_adicional 
            (ea_ente, ea_columna, ea_char, ea_tinyint, ea_smallint, ea_int, ea_money, ea_datetime, ea_float)
            values 
            (@w_ente_nuevo,'en_riesgo',@w_riesgo,NULL,NULL,NULL,NULL,NULL,NULL)
        
            insert into cobis..cl_ente_adicional 
            (ea_ente, ea_columna, ea_char, ea_tinyint, ea_smallint, ea_int, ea_money, ea_datetime, ea_float)
            values 
            (@w_ente_nuevo,'en_ente_cli',NULL,NULL,NULL,@w_ente,NULL,NULL,NULL)
            
            update cob_externos..cl_ente_mig 
            set en_estado_mig = 'TR', 
            en_ente_mig = @w_ente_nuevo
            where en_ente = @w_ente
            
            update cl_ref_personal_mig 
            set rp_ente_mig = @w_ente_nuevo
            where rp_persona = @w_ente
            
            update cl_telefono_mig 
            set te_ente_mig = @w_ente_nuevo
            where te_ente = @w_ente
        
            update cl_trabajo_mig 
            set tr_ente_mig = @w_ente_nuevo
            where tr_persona = @w_ente
        
            update cl_direccion_mig 
            set di_ente_mig = @w_ente_nuevo
            where di_ente = @w_ente                         
        end           
    end
    
    select @w_contador = @w_contador + 1 
    select @w_comited = @w_comited + 1 
    
end
commit tran
return  0

ERROR:
exec cobis..sp_errorlog
   @i_fecha       = @w_fecha,
   @i_error       = @w_return,
   @i_usuario     = 'admuser',     
   @i_descripcion = @w_mensaje,
   @i_rollback    = 'N',
   @i_tran        = 0,
   @i_tran_name   = 'sp_traslada_cl_ente'
  return 1

go
