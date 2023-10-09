use cob_pac
go

if object_id('sp_query_bp_views') is not null
begin
  drop procedure sp_query_bp_views
  -- if object_id('sp_query_bp_views') is not null
    -- print 'FAILED DROPPING PROCEDURE sp_query_bp_views'
  -- else
    -- print 'DROPPED PROCEDURE sp_query_bp_views'
end
go

Create Procedure sp_query_bp_views(   
/*********************************************************/
/*   ARCHIVO:         sp_query_bp_views.sp               */
/*   NOMBRE LOGICO:   sp_query_bp_views                  */
/*   PRODUCTO:        Plataforma Comercial               */
/*********************************************************/
/*                     IMPORTANTE                        */
/*   Esta aplicacion es parte de los  paquetes bancarios */
/*   propiedad de MACOSA S.A.                            */
/*   Su uso no autorizado queda  expresamente  prohibido */
/*   asi como cualquier alteracion o agregado hecho  por */
/*   alguno de sus usuarios sin el debido consentimiento */
/*   por escrito de MACOSA.                              */
/*********************************************************/
/*                     PROPOSITO                         */
/*   Contiene las consultas para la construccion del me- */
/*   nu contextual de las operaciones de la Plataforma   */
/*   Comercial.						 */
/*********************************************************/
/*                     MODIFICACIONES                    */
/*   FECHA                 AUTOR             RAZON       */
/*   19/Ene/2010      Cesar Loachamin   Emision Inicial  */
/*********************************************************/
  @s_ssn                int              = null,
  @s_user               login            = null,
  @s_term               varchar(30)      = null,
  @s_date               datetime         = null,
  @s_srv                varchar(30)      = null,
  @s_lsrv               varchar(30)      = null,
  @s_ofi                smallint         = null,
  @s_rol                smallint         = null,
  @s_org_err            char(1)          = null,
  @s_error              int              = null,
  @s_sev                tinyint          = null,
  @s_msg                descripcion      = null,
  @s_org                char(1)          = null,
  @s_cliente            int              = null,
  @s_servicio           smallint         = 1,
  @s_perfil             int              = 0,
  @s_culture		varchar(10)	 = null,
  @i_type_view		varchar(10)
)
as
  declare
     @w_culture        varchar(32),
     @w_inicial_index  int,
     @w_final_index    int
  
  select @w_inicial_index = patindex('%-%',@s_culture) - 1
  if @w_inicial_index != -1
   begin
	 select @w_final_index   = patindex('%-%',@s_culture) + 1        
	 select @w_culture =substring(@s_culture,1,@w_inicial_index) + '_' + substring(@s_culture,@w_final_index,len(@s_culture))
   end
  else
   begin
	 select @w_culture = @s_culture
   end
  
  
  /*Se consulta las vistas autorizadas de acuerdo al rol ingresado*/
  SELECT 'ID'          = vi_id,
	 'PARENT_ID'   = vi_id_parent,
	 'NAME'        = la_label,
	 'DESCRIPCION' = vi_name_description,
	 'ORDER'       = vi_order,
	 'GROUP'       = vi_is_group,
	 'PAGE_ID'     = pvi_page_id
    FROM bpl_view 
    LEFT JOIN bpl_an_page_view     ON pvi_view_id = vi_id
    LEFT JOIN cobis..an_role_page ON pvi_page_id = rp_pa_id
    LEFT JOIN cobis..an_label     ON vi_label_id = la_id
   WHERE vi_type_view = @i_type_view
     AND (rp_rol      = @s_rol  or  vi_is_group = 1)
     AND vi_status    = 'ACTIVE' 
     AND upper(la_cod) = upper(@w_culture)

   /*Se consulta los parametros de las p ginas autorizadas*/
  SELECT 'VIEW_ID' 	= vi_id,
	 'PARAM_ID' 	= par_id,
	 'NAME' 	= par_name,
         'PAGE_VIEW_ID' = pvi_id,
	 'PAGE_ID'	= pvi_page_id,
	 'VALUE' 	= par_value,
	 'DEFAULT' 	= par_default 
     FROM bpl_view 
     JOIN bpl_an_page_view         ON pvi_view_id = vi_id
     JOIN cobis..an_role_page     ON pvi_page_id = rp_pa_id
     JOIN bpl_view_parameter vp   ON vp.par_view_id = vi_id
     JOIN bpl_parameter_value vvp ON (vvp.par_page_view_id = pvi_id 
				      AND par_parameter_id = vp.par_id)
     JOIN cobis..an_label         ON vi_label_id = la_id
    WHERE vi_type_view = @i_type_view 
      AND rp_rol       = @s_rol
      AND vi_status    = 'ACTIVE'
      AND upper(la_cod) = upper(@w_culture)

  set rowcount 0
  return 0    
go
