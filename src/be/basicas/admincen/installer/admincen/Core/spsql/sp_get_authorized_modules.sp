use cobis
go

if exists (select * from sysobjects where name = 'sp_get_authorized_modules')
   drop proc sp_get_authorized_modules
go

/***************************************************************/
/* ARCHIVO:        sp_getauthorizedmodules.sp                  */ 
/* NOMBRE LOGICO:  sp_get_authorized_modules                   */
/* PRODUCTO:       COBISExplorerNet                            */
/***************************************************************/
/*                       IMPORTANTE                            */
/* Esta Aplicaci=n es parte de los paquetes bancarios pro-     */
/* piedad de COBISCORP.                                        */
/* Su uso no autorizado queda expresamente prohibido asf como  */
/* cualquier alteraci=n o agregado hecho por alguno de sus     */
/* usuarios sin el debido consentimiento por escrito de COBIS  */
/* CORP.                                                       */
/* Este Programa esta protegido por la Ley de derechos sde autor*/
/* y por las convenciones internacionales de propiedad inte-   */
/* lectual. Su uso no autorizado dara derecho a COBISCORP para */
/* obtener ordenes de secuestro o retencion y para perseguir   */
/* penalmente a los autores de cualquier infraccion.           */
/***************************************************************/
/*                         PROPOSITO                           */
/* Recuperar los m=dulos autorizados para un rol determinado   */
/*                                                             */
/***************************************************************/
/*                        MODIFICACINES                        */
/* FECHA         AUTOR                  RAZON                  */
/* 04-SEP-2009   Omar Dfaz      Emision inicial                */
/* 02-Jun-2010   S. Paredes     Cambiar @i_rol y @i_culture    */
/* 22-Jul-2010   S. Calderón    Se agregó una nueva consulta   */
/*                              de tipo 'CD' para obtener las  */
/*                              dependencias de un módulo      */
/* 04/Nov/2013   M. Cabay       Ingreso @w_servername para     */
/*                              Distribución por branch        */
/***************************************************************/

CREATE PROCEDURE sp_get_authorized_modules
@s_srv          varchar(30)     = NULL,
@s_rol          smallint = null,
@s_culture      varchar(10)= null,
@i_parent_id    int = null, 
@i_last_id      int = null, 
@i_operacion    varchar(3) = null, 
@i_module_id    int = null, 
@i_module_file_name varchar(255) = null,
@s_ofi    smallint = null,
@o_num_reg   int = NULL OUTPUT

AS
DECLARE 
  @w_str VARCHAR(500),
  @module_id INT,
  @server_name varchar(50)  

select @o_num_reg = 0

--Se recuepra el nombre del servidor en base a la oficina
exec sp_get_server_name @i_server  = @s_srv, @i_ofi  =@s_ofi, @o_servername = @server_name output

IF @i_operacion = 'CI' or @i_operacion = 'CFN'
BEGIN
    if @i_operacion = 'CI'
    begin 
        select @module_id = @i_module_id
    end
    else
    begin
        SELECT @module_id = M.mo_id
        FROM an_module M, an_role_module RM
        WHERE RM.rm_rol = @s_rol AND M.mo_id = RM.rm_mo_id AND M.mo_filename = @i_module_file_name
        if @@rowcount =  0
        begin
            exec cobis..sp_cerror
            @t_from = 'sp_get_authorized_modules',
            @i_num  = 157169,
            @i_sev  = 0,
            @i_msg  = 'No existen datos solicitados'

            return 1
        end
   
    end
    
    SELECT M.mo_id,M.mo_id_parent,0 has_childs
    INTO  #authorized1
    FROM an_module M, an_role_module RM
    WHERE RM.rm_rol = @s_rol AND M.mo_id = RM.rm_mo_id AND M.mo_id = @module_id
    SELECT
        M.mo_id,
        M.mo_id_parent,
        M.mo_name,
        la_label=isnull(L.la_label, 'No existe Label'),
        M.mo_filename,
        M.mo_key_token,
        MG.mg_name,
        convert (varchar(255), isnull(replace (MG.mg_location,'[servername]', isnull(@server_name,'')),'')) mg_location,
        A.has_childs,
        MG.mg_version,                                                                                                                                                                                                                                            
        MG.mg_store_name
    INTO #tmp_resultados1
    FROM #authorized1 A, an_module M LEFT OUTER JOIN an_label L ON M.mo_la_id = L.la_id AND UPPER(L.la_cod) = UPPER(@s_culture), an_module_group MG
    WHERE A.mo_id = M.mo_id AND
        M.mo_mg_id = MG.mg_id AND
        M.mo_id = @module_id
    ORDER BY M.mo_id
   
   
    --Adaptive Server has expanded all '*' elements in the following statement
    SELECT #tmp_resultados1.mo_id, #tmp_resultados1.mo_id_parent, #tmp_resultados1.mo_name, #tmp_resultados1.la_label, #tmp_resultados1.mo_filename,
    #tmp_resultados1.mo_key_token, #tmp_resultados1.mg_name, #tmp_resultados1.mg_location, #tmp_resultados1.has_childs, #tmp_resultados1.mg_version, #tmp_resultados1.mg_store_name
    FROM #tmp_resultados1  
END

IF @i_operacion = 'CM' OR @i_operacion IS NULL
BEGIN
    SELECT
        M.mo_id,
        M.mo_id_parent,
        0 has_childs
    INTO  #author
    FROM an_module M, an_role_module RM
    WHERE
        RM.rm_rol = @s_rol AND
        M.mo_id = RM.rm_mo_id AND
        M.mo_id_parent = @i_parent_id
    
    INSERT
    INTO  #author
    SELECT
        M.mo_id,
        M.mo_id_parent,
        0 has_childs
    FROM #author A, an_module M
    WHERE
        A.mo_id = M.mo_id_parent AND
        M.mo_id NOT IN (SELECT mo_id FROM #author)
    
    UPDATE  #author
    SET  has_childs = 1
    WHERE  mo_id IN (SELECT mo_id_parent FROM #author)
    
    SELECT
        M.mo_id,
        M.mo_id_parent,
        M.mo_name,
        la_label=isnull(L.la_label, 'No existe Label'),
        M.mo_filename,
        M.mo_key_token,
        MG.mg_name,
        convert (varchar(255), isnull(replace (MG.mg_location,'[servername]',isnull(@server_name,'')),'')) mg_location,
        A.has_childs,
        MG.mg_version,                                                                                                                                                                                                                                            
        MG.mg_store_name
    INTO #tmp_res
    FROM #author A, an_module M LEFT OUTER JOIN an_label L ON M.mo_la_id = L.la_id AND UPPER(L.la_cod) = UPPER(@s_culture), an_module_group MG
    WHERE A.mo_id = M.mo_id AND
        M.mo_mg_id = MG.mg_id
    ORDER BY M.mo_id
    
    
    IF @i_last_id = -1
        --Adaptive Server has expanded all '*' elements in the following statement
        SELECT #tmp_res.mo_id, #tmp_res.mo_id_parent, #tmp_res.mo_name, #tmp_res.la_label, #tmp_res.mo_filename, #tmp_res.mo_key_token, #tmp_res.mg_name, #tmp_res.
        mg_location, #tmp_res.has_childs, #tmp_res.mg_version, #tmp_res.mg_store_name
        FROM #tmp_res
    ELSE
    BEGIN
        EXECUTE('alter table #tmp_res add idn numeric(18,0) identity')
        SELECT @w_str = 'set rowcount 20 select * from #tmp_res where idn > ' + CONVERT(VARCHAR(20),isnull(@i_last_id,- 1)) + ' order by idn'
        EXECUTE (@w_str)
    END
END

IF @i_operacion = 'CD' --SCA: Se consulta las dependencias de un módulo
BEGIN
    SELECT M.md_mo_id,M.md_dependency_id,0 has_childs
    INTO  #auth2
    FROM an_module_dependency M, an_role_module RM
    WHERE RM.rm_rol = @s_rol AND M.md_dependency_id = RM.rm_mo_id AND M.md_mo_id = @i_module_id
    
    SELECT
        M.mo_id,
        'mo_id_parent' = 0,--Se mantiene por motivos de compatibilidad
        M.mo_name,
        la_label=isnull(L.la_label, 'No existe Label'),
        M.mo_filename,
        M.mo_key_token,
        MG.mg_name,
        convert (varchar(255), isnull(replace (MG.mg_location,'[servername]',isnull(@server_name,'')),'')) mg_location,
        A.has_childs,
        MG.mg_version,                                                                                                                                                                                                                                            
        MG.mg_store_name
    INTO #tmp_res2
    FROM #auth2 A, an_module M LEFT OUTER JOIN an_label L ON M.mo_la_id = L.la_id AND UPPER(L.la_cod) = UPPER(@s_culture), an_module_group MG
    WHERE A.md_dependency_id = M.mo_id AND
        M.mo_mg_id = MG.mg_id
    ORDER BY M.mo_id
    
    IF @i_last_id = -1
        --Adaptive Server has expanded all '*' elements in the following statement
        SELECT mo_id, mo_id_parent, mo_name, la_label, mo_filename,
        mo_key_token, mg_name, mg_location, has_childs, mg_version, mg_store_name
        FROM #tmp_res2
    ELSE
    BEGIN
        EXECUTE('alter table #tmp_res2 add idn numeric(18,0) identity')
        SELECT @w_str = 'set rowcount 20 select * from #tmp_res2 where idn > ' + CONVERT(VARCHAR(20),isnull(@i_last_id,- 1)) + ' order by idn'
        EXECUTE (@w_str)
    END  
    select @o_num_reg = @@rowcount
END

RETURN 0
go
