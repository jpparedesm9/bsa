use cobis
go

if exists (select * from sysobjects where name = 'sp_qrente')
   drop proc sp_qrente
go

create proc sp_qrente (
/************************************************************************/
/*      Archivo:                    qrente.sp                           */
/*      Stored procedure:       sp_qrente                               */
/*      Base de datos:          cobis                                   */
/*      Producto:                   Clientes                            */
/*      Disenado por:           Mauricio Bayas/Sandra Ortiz             */
/*      Fecha de escritura: 20-Jul-1993                                 */
/************************************************************************/
/*                                          IMPORTANTE                  */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                                            PROPOSITO                 */
/*      Despliega el nombre completo y el rol de un ente.               */
/*                              MODIFICACIONES                          */
/*   FECHA           AUTOR           RAZON                           	*/
/*  20-Jul-1993     S Ortiz         Emision inicial                 	*/
/*  14/May/05   	R Garcia    Incluion de nombre de Cia           */
/*  25/Oct/12   	M Nunez     Operacion H para ATM                */
/*  12/05/12    	D Vera      Operacion C ente duplucado          */
/*  14/MAY/2015     J. BAQUE       Modif. Cambio de estado Manual 'M'   */
/*  19/FEB/2016     J. MATEO  	Se valida si apellido de casada no	*/
/*  			       	esta vacio para caoncatenar		*/
/*  21/Dic/2016     A. Moreno   Se aument el campo en_nomlar en la ope- */
/*                              racion H, Tipo null                     */
/************************************************************************/

        @s_ssn                   int         = null,
        @s_user                  login       = null,
        @s_term                  varchar(32) = null,
        @s_date                  datetime    = null,
        @s_srv                   varchar(30) = null,
        @s_lsrv                  varchar(30) = null,
        @s_rol                   smallint    = NULL,
        @s_ofi                   smallint    = NULL,
        @s_org_err               char(1)     = NULL,
        @s_error                 int         = NULL,
        @s_sev                   tinyint     = NULL,
        @s_msg                   descripcion = NULL,
        @s_org                   char(1)     = NULL,
        @t_debug                 char(1)     = 'N',
        @t_file                  varchar(14) = null,
        @t_from                  varchar(30) = null,
        @t_trn                   smallint    = null,
        @i_ente                  int         = null,  -- Codigo del ente del cual se desea desplegar la informacion
        @i_tipo                  tinyint     = null,  -- Tipo de busqueda
        @i_operacion             char(1)     = 'N',   -- Operacion ATM
        @i_identificacion        numero      =  null,
        @i_tipo_ced              char(4)     = null,
        @t_show_version          bit         = 0
) as

declare @w_sp_name          varchar(30),
        @w_nombre_completo  descripcion,
        @w_subtipo          char(1),
        @w_ced_ruc          numero,
        @w_p_casada         varchar(20),
        @w_retencion        char(1),
        @w_mala_referencia  char(1),
        @w_nombre_largo     varchar(254),
        @w_nombre_corto     descripcion,
        @w_razon_social     descripcion,
        @w_grupo_econ       varchar(75),
        @w_tipo_ced         char(4),
		@w_tipo_jur         varchar(10)
-------------------------------------------
---VERSIONAMIENTO PROGRAMA-----------------
-------------------------------------------
if @t_show_version = 1
begin
    print 'Stored procedure sp_persona_cons, Version 4.0.0.11'
    return 0
end
                
/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_qrente'

if @t_trn = 1190
begin
        if @i_operacion = 'N' 
        begin

                if @i_tipo is null
                begin 
                /*  Chequeo de existencias  */
				
				
                select  @w_nombre_completo = en_nomlar,
                        @w_p_casada        = p_c_apellido,
                        @w_subtipo         = en_subtipo,
                        @w_ced_ruc         = en_ced_ruc,
                        @w_retencion       = en_retencion,
                        @w_mala_referencia = en_mala_referencia,
                        @w_nombre_largo = en_nomlar,
                        @w_nombre_corto =
                        case
                                when p_sexo = 'F' and (select pa_nemonico
                                                        from cl_parametro
                                                        where pa_char = a.p_estado_civil
                                                        and pa_producto = 'CLI' and pa_nemonico = 'CDA') = 'CDA'   and (p_c_apellido is not null  and  p_c_apellido <>'')  then en_nombre  + ' DE ' + p_c_apellido
                                when p_sexo = 'F' and (select pa_nemonico
                                                        from cl_parametro
                                                        where pa_char = a.p_estado_civil
                                                        and pa_producto = 'CLI' and pa_nemonico = 'VDA') = 'VDA'  and (p_c_apellido is not null  and  p_c_apellido <>'')  then en_nombre  + ' VDA. DE ' + p_c_apellido
                                when (select pa_nemonico
                                        from cl_parametro
                                        where pa_char = a.p_estado_civil
                                        and pa_producto = 'CLI' and pa_nemonico = 'MED') = 'MED' then en_nombre + ' ' + p_p_apellido + ' (MENOR) '
                                else case en_subtipo
                                        when 'P' then
                                                en_nombre + ' ' + p_p_apellido
                                        when 'C' then
                                                rtrim(c_razon_social)
                                        end
                        end,
                        @w_razon_social = c_razon_social,
                        @w_grupo_econ   = convert(varchar(10),en_grupo) + ' ' + (select gr_nombre from cl_grupo where gr_grupo = a.en_grupo),
                        @w_tipo_ced     = en_tipo_ced,
						@w_tipo_jur     = c_segmento
                from    cl_ente a
                where   en_ente = @i_ente
                if @@rowcount = 0
                begin

                        /*  No existe cliente  */
                        exec cobis..sp_cerror
                                @t_debug= @t_debug,
                                @t_file = @t_file,
                                @t_from = @w_sp_name,
                                @i_num  = 101146
                        return 1
                end


                select  @w_nombre_completo,
                        @w_p_casada,
                        @w_subtipo,
                        @w_ced_ruc,
                        @w_retencion,
                        @w_mala_referencia,
                        @w_nombre_largo,
                        @w_nombre_corto,
                        @w_razon_social,
                        @w_grupo_econ,      --CVA Jun-07-06 Agregar informacion del grupo economico
                        @w_tipo_ced,
						@w_tipo_jur

        end
        else
		
		     
                begin
                        select  p_p_apellido,
                                p_s_apellido,
                                p_c_apellido,
                                en_nombre,
                                p_s_nombre,
                                en_subtipo,
                                en_ced_ruc, 
                                p_pasaporte,
                                en_mala_referencia,
                                en_tipo_ced,
                                en_retencion,
                                en_nomlar,
                                'Nombre Corto' =
                                case
                                        when p_sexo = 'F' and (select pa_nemonico
                                                        from cl_parametro
                                                        where pa_char = a.p_estado_civil
                                                        and pa_producto = 'CLI' and pa_nemonico = 'CDA') = 'CDA' and (p_c_apellido is not null  and  p_c_apellido <>'') then en_nombre  + ' DE ' + p_c_apellido
                                        when p_sexo = 'F' and (select pa_nemonico
                                                        from cl_parametro
                                                        where pa_char = a.p_estado_civil
                                                        and pa_producto = 'CLI' and pa_nemonico = 'VDA') = 'VDA'  and (p_c_apellido is not null  and  p_c_apellido <>'')  then en_nombre  + ' VDA. DE ' + p_c_apellido
                                        when (select pa_nemonico
                                                from cl_parametro
                                                where pa_char = a.p_estado_civil
                                                and pa_producto = 'CLI' and pa_nemonico = 'MED') = 'MED' then en_nombre + ' ' + p_p_apellido + ' (MENOR) '
                                        else en_nombre +  ' ' + p_p_apellido
                                end,
								c_segmento
                        from    cl_ente a
                        where   en_ente = @i_ente
                        if @@rowcount = 0
                        begin
                                /*  No existe cliente  */
                                exec cobis..sp_cerror
                                        @t_debug= @t_debug,
                                        @t_file = @t_file,
                                        @t_from = @w_sp_name,
                                        @i_num  = 101146
                                return 1
                        end
                end

        return 0
        end
        if @i_operacion = 'H' 
        begin
                if @i_tipo is null
                begin
                        /*  Chequeo de existencias  */
                        select  p_p_apellido + ' ' + p_s_apellido +' '+en_nombre,
                                en_subtipo,
                                en_ced_ruc,
                                en_mala_referencia,
                                en_tipo_ced,
                                en_nomlar
                        from    cl_ente
                        where   en_ente = @i_ente

                        if @@rowcount = 0
                        begin
                                /*  No existe cliente  */
                                exec cobis..sp_cerror
                                        @t_debug= @t_debug,
                                        @t_file = @t_file,
                                        @t_from = @w_sp_name,
                                        @i_num  = 101146
                                return 101146
                        end
                end
                else
                begin
                        select  en_nomlar,
                                p_p_apellido,
                                p_s_apellido,
                                en_nombre,
                                en_subtipo,
                                en_ced_ruc, 
                                p_pasaporte,
                                en_mala_referencia,
                                en_tipo_ced,
                                p_tipo_persona,
                                ea_estado,
                                es_descripcion
                        from    cl_ente, cl_ente_aux, cl_estados_ente
                        where en_ente=ea_ente   
                          and es_estado = ea_estado
                          and en_ente = @i_ente                          
                        
                        if @@rowcount = 0
                        begin
                                /*  No existe cliente  */
                                exec cobis..sp_cerror
                                        @t_debug= @t_debug,
                                        @t_file = @t_file,
                                        @t_from = @w_sp_name,
                                        @i_num  = 101146
                                return 101146
                        end
                end
        return 0
        end
        
        if @i_operacion = 'C' 
        begin
                /* Consulta de ente duplicado*/
            if @i_ente is null
            begin    
                
                if exists (select 1     from cl_ente where en_ced_ruc = @i_identificacion and en_tipo_ced = @i_tipo_ced)
                        select 1 -- Ente con identificacion duplicada
                else
                        select 0 
            end
            else
            begin                        
                if exists (select 1     from cl_ente where en_ced_ruc = @i_identificacion and en_tipo_ced = @i_tipo_ced and en_ente <> @i_ente)
                        select 1 -- Ente con identificacion duplicada
                else
                        select 0 
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
           /*  'No corresponde codigo de transaccion' */
        return 1
end

                    
go
