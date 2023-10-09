/* ********************************************************************* */
/*      Archivo:                sp_validar_grupo.sp                      */
/*      Stored procedure:       sp_validar_grupo                         */
/*      Base de datos:          cobis                                    */
/*      Producto:               Clientes                                 */
/*      Disenado por:           Patricio Samueza                         */
/*      Fecha de escritura:     01-Noviembre-2017                        */
/* ********************************************************************* */
/*                              IMPORTANTE                               */
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      "MACOSA", representantes exclusivos para el Ecuador de la        */
/*      "NCR CORPORATION".                                               */
/*      Su uso no autorizado queda expresamente prohibido asi como       */
/*      cualquier alteracion o agregado hecho por alguno de sus          */
/*      usuarios sin el debido consentimiento por escrito de la          */
/*      Presidencia Ejecutiva de MACOSA o su representante.              */
/* ********************************************************************* */
/*                              PROPOSITO                                */
/*      Validaciones de los clientes de un grupo                         */
/* ********************************************************************* */
/*                              MODifICACIONES                           */
/*      FECHA           AUTOR                RAZON                       */
/*      01/11/2017     PXSG                   Version inicial            */
/*                                                                       */
/*                                                                       */
/* ********************************************************************* */
USE cobis
go
if OBJECT_ID ('dbo.sp_validar_condiciones_grupo') IS NOT NULL
	DROP PROCEDURE dbo.sp_validar_condiciones_grupo
GO

create proc sp_validar_condiciones_grupo(
    @s_ssn                  int             = null,
    @s_user                 login           = null,
    @s_term                 varchar(30)     = null,
    @s_date                 datetime        = null,
    @s_srv                  varchar(30)     = null,
    @s_lsrv                 varchar(30)     = null,
    @s_ofi                  smallint        = null,
    @s_rol                  smallint        = NULL,
    @s_org_err              char(1)         = NULL,
    @s_error                int             = NULL,
    @s_sev                  tinyint         = NULL,
    @s_msg                  descripcion     = NULL,
    @s_org                  char(1)         = NULL,
    @t_show_version         bit             = 0,    -- Mostrar la version del programa
    @t_debug                char(1)         = 'N',
    @t_file                 varchar(10)     = null,
    @t_from                 varchar(32)     = null,
    @t_trn                  smallint        = null,
    @i_grupo                int             = null, -- Codigo del grupo
	@i_toperacion           varchar(20)     = 'NOR' -- Tipo de Solicitud Grupal: NOR: GRUPAL, REN: RENOVACION 
 
)
as
declare @w_return           int,
@w_sp_name                  varchar(32),
@numintegrantesGrupo        int,
@w_sum_parentesco           int,
@w_porcentaje               int,
@w_param_max_inte           int,
@w_param_min_inte           int,
@w_param_porc_parentesco    FLOAT,
@w_param_rel_cony		    int ,
@w_param_porc_mujeres 	    FLOAT,
@w_porc_mujeres 	        FLOAT,
@w_cliente_gr               int,
@w_num_sexo_feme            int,
@w_param_porc_emp           FLOAT,
@w_sum_enprender            int,
@w_error                    int,
@w_est_vigente              int
  

-------------------------------- VERSIONAMIENTO DE SP --------------------------------
if @t_show_version = 1
begin
    print 'Stored procedure sp_grupo_busin, Version 1.0.0.0'
    return 0
end
--------------------------------------------------------------------------------------
select 
@w_sp_name   = 'sp_validar_condiciones_grupo'

   
/*if @t_trn != 800 --SMO Pendiente definir trn
begin
    exec cobis..sp_cerror
         @t_debug      = @t_debug,
         @t_file       = @t_file,
         @t_from       = @w_sp_name,
         @i_num        = 151051 -- TRANSACCION NO PERMITIDA
    return 1
end*/

exec @w_error     = cob_cartera..sp_estados_cca
@o_est_vigente    = @w_est_vigente   out

if @w_error <> 0 return @w_error

if not exists (select 1 from cobis..cl_grupo where gr_grupo = @i_grupo)
   return 151029  --NO EXISTE GRUPO
 		
   
--NUMERO DE intEGRANTES
select @numintegrantesGrupo = count(cg_ente) 
from cobis..cl_cliente_grupo 
where cg_grupo  =@i_grupo 
and   cg_estado = 'V'

if(@numintegrantesGrupo>0) begin
   select @w_param_max_inte = pa_int from cobis..cl_parametro where pa_nemonico='MAXIGR' and pa_producto = 'CLI'
   select @w_param_min_inte = pa_int from cobis..cl_parametro where pa_nemonico='MinIGR' and pa_producto = 'CLI'
	
   if @numintegrantesGrupo  > @w_param_max_inte or  @numintegrantesGrupo < @w_param_min_inte
      return 208916  --Error en Mínimo y máximo de integrantes      
  
   --PORCENTAJE PARENTESCO
   select @w_param_porc_parentesco=pa_float from cobis..cl_parametro where pa_nemonico='PPGRU'  and pa_producto = 'CRE'
   select @w_sum_parentesco=count(DISTinCT in_ente_i) from cobis..cl_instancia
   where  in_relacion in (select B.codigo from cobis..cl_tabla A, cobis..cl_catalogo B 
            where A.tabla in ('cl_parentesco_1er','cl_parentesco_2er') and A.codigo= B.tabla)
   and in_ente_i in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @i_grupo and cg_estado = 'V')
   and in_ente_d in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @i_grupo and cg_estado = 'V')
   
   select @w_porcentaje = ((@w_sum_parentesco * 100)/@numintegrantesGrupo)
   
   if @w_porcentaje > @w_param_porc_parentesco 	
   	return 208917  --Error en Porcentaje de Parentesco
   
   
   /*select @w_reunion = gr_dir_reunion from cobis..cl_grupo where gr_grupo = @i_grupo
   
   if ((@w_reunion IS NULL) or (@w_reunion = ' '))    -- Lugar de reunion
   begin
   --PRint'VALIDAR Lugar de Reunion.'+CONVERT(VARCHAR(30),@w_porcentaje)
     select @w_error = 208932  --POR FAVOR inGRESE EL LUGAR DE REUNION
     goto ERROR
   END*/
     
    --CONYUGUE--
   select @w_param_rel_cony = pa_int from cobis..cl_parametro where pa_nemonico='RCONY'  and pa_producto = 'CRE' 
   
   select @w_cliente_gr= 0

   while 1 = 1  begin
   
      select top 1 
      @w_cliente_gr   = cg_ente
      from cobis..cl_cliente_grupo
      where cg_grupo  = @i_grupo
      and cg_estado   = 'V'
      and cg_ente     > @w_cliente_gr 
      order by cg_ente asc
	  
	  if @@rowcount = 0 break 
	  
      if exists (select 1
              from cobis..cl_instancia
              where in_ente_i = @w_cliente_gr
              and in_relacion = @w_param_rel_cony -- parametro 'RCONY'
              and in_ente_d in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo =@i_grupo and cg_estado = 'V'))
   	
         return 208919  --Validación conyuge--
 
   end--Fin While--
    
   --validaciones de mujeres--
   select @w_param_porc_mujeres=pa_float from cobis..cl_parametro where pa_nemonico='PMGRU'  and pa_producto = 'CRE'
   
   select @w_num_sexo_feme = count(1) 
   from cobis..cl_cliente_grupo, cobis..cl_ente
   where en_ente = cg_ente
   and p_sexo    = 'F'    --genero femenino
   and cg_grupo  = @i_grupo
   and cg_estado = 'V'
   
   select @w_porc_mujeres = ((@w_num_sexo_feme * 100)/@numintegrantesGrupo)
   
   if @w_porc_mujeres < @w_param_porc_mujeres -- parametro de porcentaje de mujeres en grupos
      return 208920  --validación porcentaje mujeres
 
   --Validacion Emprendedores--
   select @w_param_porc_emp = pa_float 
   from cobis..cl_parametro 
   where pa_nemonico='MAXEMP'  
   and pa_producto = 'CRE' 
  
   select @w_sum_enprender = count(nc_emprendedor) 
   from cobis..cl_cliente_grupo, cobis..cl_negocio_cliente 
   where nc_ente = cg_ente 
   and cg_grupo =@i_grupo
   and cg_estado = 'V' 
   and nc_emprendedor ='S'
   and nc_estado_reg='V'
    
   select @w_porcentaje = ((@w_sum_enprender * 100)/@numintegrantesGrupo)
   
   if @w_porcentaje > @w_param_porc_emp -- parametro de emprendedores en grupos	
      return 208923  --validación emprendedores
  
   --validaciones Presidente--
   if NOT EXISTS (select 1 from cobis..cl_cliente_grupo 
                 where cg_rol = (select B.codigo from cobis..cl_tabla A, cobis..cl_catalogo B
                               where A.tabla = 'cl_rol_grupo'
                               and A.codigo = B.tabla
                               and B.valor = 'PRESIDENTE')
                               and cg_grupo = @i_grupo and cg_estado='V')
	
      return 208921  --Validación Presidente

   if NOT EXISTS (select 1 from cobis..cl_cliente_grupo 
                  where cg_rol = (select B.codigo from cobis..cl_tabla A, cobis..cl_catalogo B
                                where A.tabla = 'cl_rol_grupo'
                                and A.codigo = B.tabla
                                and B.valor = 'SECRETARIO')
                                and cg_grupo = @i_grupo and cg_estado='V')
   
   
      return 208926  --Validación SECRETARIO
  
   ---Validación Tesorero
   if NOT EXISTS (select 1 from cobis..cl_cliente_grupo 
                  where cg_rol = (select B.codigo from cobis..cl_tabla A, cobis..cl_catalogo B
                                  where A.tabla = 'cl_rol_grupo'
                                  and A.codigo = B.tabla
                                  and B.valor = 'TESORERO')
                                  and cg_grupo =@i_grupo and cg_estado='V')

  		
      return 208916 --Validación Tesorero
  			
  
end --@numintegrantesGrupo>0
else return 208916--no cumple máximo y mínimo de integrantes

if @i_toperacion = 'REN' and not 
exists (select 1 from cob_credito..cr_tramite_grupal tg, cob_cartera..ca_operacion op
        where  tg_operacion = op_operacion
        and    tg_grupo     = @i_grupo
        and    op_estado    = @w_est_vigente) begin
   return 2108080
												
end
	

return 0

go

