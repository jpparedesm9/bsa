/*************************************************************************/
/*   Archivo:            sp_cliente_col_upd.sp                           */
/*   Stored procedure:   sp_cliente_col_upd                              */
/*   Base de datos:      cobis                                           */
/*   Producto:           Clientes                                        */
/*   Disenado por:       Sonia Rojas                                     */
/*   Fecha de escritura: 10/10/2019                                      */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBISCORP', representantes exclusivos para el Ecuador de NCR       */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBISCORP o su representante.              */
/*************************************************************************/
/*                                  PROPOSITO                            */ 
/*   Este programa ejecuta la regla de riesgo individual externo         */
/*************************************************************************/
/*                               OPERACIONES                             */
/*   OPER. OPCION                     DESCRIPCION                        */
/*     C                    Ejecuta la matriz                            */
/*************************************************************************/
/*                                MODIFICACIONES                         */
/*   FECHA        AUTOR                       RAZON                      */
/* 10/10/2019   Sonia Rojas        Versión Inicial                       */
/* 14/10/2019   Paul Ortiz Vera    Modificaciones de relación            */
/* 27/Jun/2023  ACH                #210163 Error en CURP-no debemos generar*/
/*************************************************************************/
use cobis
go

IF OBJECT_ID ('dbo.sp_cliente_col_upd') IS NOT null
	DROP PROCEDURE dbo.sp_cliente_col_upd
GO

create proc sp_cliente_col_upd(
   @s_ssn                int           = null,
   @s_user               login         = null,
   @s_term               varchar(32)   = null,
   @s_date               datetime      = null,
   @s_sesn               int           = null,
   @s_srv                varchar(30)   = null,
   @s_lsrv               varchar(30)   = null,
   @s_ofi                smallint      = null,
   @s_rol                smallint      = null,
   @s_org_err            char(1)       = null,
   @s_error              int           = null,
   @s_sev                tinyint       = null,
   @s_msg                descripcion   = null,
   @s_org                char(1)       = null,
   @s_culture            char(4)       = 'EC',
   @t_debug              char(1)       = 'N',
   @t_file               varchar(10)   = null,
   @t_from               varchar(32)   = null,
   @t_trn                smallint      = null,
   @i_ente               int,
   @i_depa_nac           int,
   @i_pais_emi           int,
   @i_nac_aux            int,
   @i_estado_civil       varchar(2),
   @i_num_cargas         int,
   @i_ciudad             varchar(50),
   @i_referencia         varchar(255),
   @i_p_nombre_conyuge   varchar(30)   = null,
   @i_s_nombre_conyuge   varchar(30)   = null,
   @i_p_apellido_conyuge varchar(30)   = null,
   @i_s_apellido_conyuge varchar(30)   = null,
   @i_fecha_nac_conyuge  datetime      = null,
   @i_ocupacion          varchar(50),
   @i_numero_serie_firma varchar(50)   = null,
   @i_pep                varchar(2),
   @i_persona_pub        varchar(2),
   @i_destino_credito    varchar(4),
   @i_recursos_pago      varchar(4),	  
   @i_ventas             money,
   @i_otros_ingresos     money,	  
   @i_ct_operativos      money,
   @i_ct_ventas          money,
   @i_cod_direccion      int           = null,
   @i_dg_lat_seg         float         = null,
   @i_dg_long_seg        float         = null
)
as
declare
@w_sp_name           varchar(50),
@w_error             int,
@w_msg               varchar(255),
@w_param_casado      varchar(4),
@w_depa_nac          smallint,
@w_pais_emi          smallint,
@w_num_cargas        tinyint,
@w_ventas            money,
@w_ingresos          money,
@w_otros_ingresos    money,
@w_ct_operativos     money,
@w_ct_ventas         money,
@w_nombres_conyuge   varchar(255),
@w_fecha_nac_conyuge datetime,
@w_codigo_negocio    int,
@w_relacion          int,
@w_ente_conyuge      int,
@w_curp_cobis        varchar(255),
@w_curp_cobis_gen    varchar(255),
@w_rfc_cobis         varchar(255),
@w_p_apellido        descripcion,
@w_s_apellido        descripcion,
@w_nombres           varchar(255),
@w_fecha_nac         datetime,
@w_sexo              char(1),
@w_sexo_conyuge      char(1),
@w_curp_cobis_c      varchar(30),
@w_rfc_cobis_c       varchar(30)


select @w_sp_name = 'cobis..sp_cliente_col_upd'

begin tran
select @w_param_casado = pa_char
from  cobis..cl_parametro
where pa_nemonico = 'CDA'
and   pa_producto = 'CLI'

select @w_relacion = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'COU' --relacion conyuge
and pa_producto = 'CRE'

if @@rowcount = 0 begin
   select @w_error =1111
end
--Genero Geolocalizacion
exec @w_error           = cobis..sp_direccion_geo
@i_operacion            = 'I',
@i_ente                 = @i_ente,
@i_direccion            = @i_cod_direccion,
@i_lat_segundos         = @i_dg_lat_seg,
@i_lon_segundos         = @i_dg_long_seg,
@t_trn                  = 1608,
@s_srv 		            = @s_srv,
@s_user 	            = @s_user,
@s_term 	            = @s_term,
@s_ofi 		            = @s_ofi,
@s_rol 		            = @s_rol,
@s_ssn 		            = @s_ssn,
@s_lsrv 	            = @s_lsrv,
@s_date 	            = @s_date,
@s_org 		            = @s_org
if @@error <> 0 begin
   goto ERROR
end 

select 
@w_p_apellido = isnull(p_p_apellido,''),
@w_s_apellido = isnull(p_s_apellido,''),
@w_nombres    = isnull(en_nombre,'') + ' ' + isnull(p_s_nombre, ''),
@w_fecha_nac  = p_fecha_nac,
@w_sexo       = p_sexo,
@w_curp_cobis = en_ced_ruc
from cobis..cl_ente 
where en_ente = @i_ente

exec @w_error            = cobis..sp_generar_curp
@i_primer_apellido       = @w_p_apellido,
@i_segundo_apellido      = @w_s_apellido,
@i_nombres               = @w_nombres,
@i_sexo                  = @w_sexo,
@i_fecha_nacimiento      = @w_fecha_nac,
@i_entidad_nacimiento    = @i_depa_nac,
@i_ente                  = @i_ente,
@o_mensaje               = @w_msg  out,
@o_curp                  = @w_curp_cobis_gen out

if @@error <> 0 begin
   goto ERROR
end

--No debe generar el curp #210163, pero se deja si el dato no viene de las pantallas , parametro ACRXCR = 'N'
if @w_curp_cobis is null or rtrim(ltrim(@w_curp_cobis)) = '' begin
    select @w_curp_cobis = @w_curp_cobis_gen
end

update cobis..cl_ente set 
p_pais_emi             = isnull(@i_pais_emi, p_pais_emi),
en_nac_aux             = isnull(@i_nac_aux, en_nac_aux),
p_depa_nac             = isnull(@i_depa_nac ,p_depa_nac),
p_estado_civil         = isnull(@i_estado_civil, p_estado_civil),
p_num_cargas           = isnull(@i_num_cargas, p_num_cargas),   
p_profesion            = isnull(@i_ocupacion, p_profesion),
en_persona_pep         = isnull(@i_pep, en_persona_pep),
en_persona_pub         = isnull(@i_persona_pub, en_persona_pub),
en_otros_ingresos      = isnull(@i_ventas, en_otros_ingresos),
en_ced_ruc             = @w_curp_cobis,
en_ing_SN              = case when @i_otros_ingresos is not null and @i_otros_ingresos <> '0' then 'S' else null end,
en_otringr             = case when @i_otros_ingresos is not null and @i_otros_ingresos <> '0' then 'OT' else null end
where en_ente          = @i_ente

if @@error <> 0
begin
   select @w_error = 105026
   goto ERROR
end
     
update cobis..cl_registro_identificacion set
ri_identificacion     = @w_curp_cobis
where ri_ente         = @i_ente
and   ri_tipo_iden    = 'CURP'

if @@error <> 0
begin
   select @w_error = 105026
   goto ERROR
end
      
update cobis..cl_ente_aux set 
ea_num_serie_firma     = isnull(@i_numero_serie_firma, ea_num_serie_firma),     
ea_ventas              = isnull(@i_otros_ingresos,ea_ventas),
ea_ct_operativo        = isnull(@i_ct_operativos, ea_ct_operativo),
ea_ct_ventas           = isnull(@i_ct_ventas,ea_ct_ventas)
where ea_ente = @i_ente

if @@error <> 0
begin
   select @w_error = 105026
   goto ERROR
end


--Actualizacion Dirección
update cobis..cl_direccion set
di_poblacion   = @i_ciudad,
di_descripcion = @i_referencia
where di_ente  = @i_ente
and   di_tipo  = 'RE'

if @@error <> 0 begin
   select @w_error = 150001
   goto ERROR
end

if @i_estado_civil = @w_param_casado begin
   
   if @i_p_nombre_conyuge is null or @i_p_apellido_conyuge is null or @i_fecha_nac_conyuge is null begin
      select @w_error = 11111
      goto ERROR
   end
   
   select 
   @w_nombres_conyuge = @i_p_nombre_conyuge + ' ' + isnull(@i_s_apellido_conyuge,''),
   @w_sexo_conyuge    = case when @w_sexo = 'F' then 'M' else 'F' end
   
   exec @w_error            = cobis..sp_generar_curp
   @i_primer_apellido       = @i_p_apellido_conyuge,
   @i_segundo_apellido      = @i_s_apellido_conyuge,
   @i_nombres               = @w_nombres_conyuge,
   @i_sexo                  = @w_sexo_conyuge,
   @i_fecha_nacimiento      = @i_fecha_nac_conyuge,
   @i_entidad_nacimiento    = @i_depa_nac,
   @o_mensaje               = @w_msg  out,
   @o_rfc                   = @w_rfc_cobis_c  out    --RFC CON HOMOCLAVE
   
   if @@error <> 0 begin
      goto ERROR
   end   
   
   if not exists (select 1 from cobis..cl_instancia where in_relacion = @w_relacion and in_lado = 'D' and in_ente_i = @i_ente)
   begin
      if exists (select 1 from cobis..cl_ente where en_nit = @w_rfc_cobis_c)
      begin
         
        select @w_ente_conyuge = en_ente from cobis..cl_ente where en_nit = @w_rfc_cobis_c
         
        exec @w_error  = cobis..sp_instancia
      	@i_relacion    = @w_relacion,
      	@i_derecha 	   = @i_ente,
      	@i_izquierda   = @w_ente_conyuge,
      	@i_lado		   = 'D',
      	@i_operacion   = 'I',
      	@t_trn		   = 1367,
      	@s_srv 		   = @s_srv,
      	@s_user 	   = @s_user,
      	@s_term 	   = @s_term,
      	@s_ofi 		   = @s_ofi,
      	@s_rol 		   = @s_rol,
      	@s_ssn 		   = @s_ssn,
      	@s_lsrv 	   = @s_lsrv,
      	@s_date 	   = @s_date,
      	@s_org 		   = @s_org
      	
         if @w_error <> 0
         begin
            goto ERROR
         end
      end
      else
      begin
         select 
         @w_sexo      = p_sexo   
         from cobis..cl_ente
         where en_ente = @i_ente
   	  
         /*NO SE DEFINE EN REQUERIMIENTO, SE COLOCA PROVISIONALMENTE*/
         if @w_sexo = 'F' begin
            select @w_sexo_conyuge = 'M'
         end else if @w_sexo = 'M' begin
            select @w_sexo_conyuge = 'F'
         end
         
         select @w_ente_conyuge = @i_ente
         exec @w_error      = cob_pac..sp_crear_persona_no_ruc
         @i_filial          = 1,
         @i_oficina         = @s_ofi,
         @i_nombre_c        = @i_p_nombre_conyuge,
         @i_segnombre_c     = @i_s_nombre_conyuge,
         @i_papellido_c     = @i_p_apellido_conyuge,
         @i_sapellido_c     = @i_s_apellido_conyuge,
         @i_tipo_ced_c      = 'CURP',
         @i_sexo_c          = null,
         @i_est_civil_c     = @w_param_casado,
         @i_fecha_nac_c     = @i_fecha_nac_conyuge,
         @i_ciudad_nac_c    = @i_depa_nac,--MISMO DEL CLIENTE PRINCIPAL, NO SE DEFINE EN REQ
         @o_ente            = @w_ente_conyuge out,
         @t_trn             = 73935,
         @i_ea_estado_c     = 'P',
         @i_operacion       = 'C',
         @o_dire            = 000 ,
         @o_ente_c          = 000 ,
         @o_curp            = null ,
         @o_rfc             = @w_rfc_cobis_c,
         @o_curp_c          ='0',
         @o_rfc_c           ='0',
         @s_srv             = @s_srv,
         @s_user            = @s_user,
         @s_term            = @s_term,
         @s_ofi             = @s_ofi,
         @s_rol             = @s_rol,
         @s_ssn             = @s_ssn,
         @s_lsrv            = @s_lsrv,
         @s_date            = @s_date,
         @s_sesn            = @s_sesn,
         @s_org             = @s_org,
         @s_culture         = @s_culture
         
         if @w_error <> 0
         begin
            goto ERROR
         end
      end
   end
end
   
--Datos del Negocio

update cobis..cl_negocio_cliente set 
nc_destino_credito = @i_destino_credito,
nc_recurso         = @i_recursos_pago
where nc_ente      = @i_ente

commit tran
return 0

ERROR:

if @@trancount > 0 begin
   rollback tran
end

exec sp_cerror
@t_debug    = @t_debug,
@t_file     = @t_file,
@t_from     = @w_sp_name,
@i_num      = @w_error
/* 'Error en actualizacion de persona'*/
return @w_error

go


