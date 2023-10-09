/************************************************************************/
/*  Archivo:                sp_var_geolocalizacion.sp                   */
/*  Stored procedure:       sp_var_geolocalizacion                      */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           P. Ortiz                                    */
/*  Fecha de Documentacion: 26/Ago/2019                                 */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "COBOSCORP",representantes exclusivos para el Ecuador de la         */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de COBISCORP o su representante               */
/************************************************************************/
/*          PROPOSITO                                                   */
/*  Permite determinar si los integrantes de un grupo promo tienen      */
/*  experiencia crediticia o es un emprededor                           */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA         AUTOR                   RAZON                         */
/* 26/Ago/2019    P. Ortiz    Emision Inicial                           */
/* 17/Sep/2021    ACH         ERR#168924,se toma el parametro de ingreso*/
/* **********************************************************************/

use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_var_geolocalizacion')
	drop proc sp_var_geolocalizacion
GO


CREATE PROC sp_var_geolocalizacion
		(@s_ssn        int         = null,
	    @s_ofi        smallint    = null,
	    @s_user       login       = null,
       @s_date       datetime    = null,
	    @s_srv		   varchar(30) = null,
	    @s_term	      descripcion = null,
	    @s_rol		   smallint    = null,
	    @s_lsrv	      varchar(30) = null,
	    @s_sesn	      int 	      = null,
	    @s_org		   char(1)     = NULL,
		 @s_org_err    int 	      = null,
       @s_error      int 	      = null,
       @s_sev        tinyint     = null,
       @s_msg        descripcion = null,
       @t_rty        char(1)     = null,
       @t_trn        int         = null,
       @t_debug      char(1)     = 'N',
       @t_file       varchar(14) = null,
       @t_from       varchar(30) = null,
       --variables
		 @i_id_inst_proc int,    --codigo de instancia del proceso
		 @i_id_inst_act  int,    
		 @i_id_asig_act  int,
		 @i_id_empresa   int, 
		 @i_id_variable  smallint 
		 )
AS
DECLARE  @w_sp_name       	   varchar(32),
         @w_tramite       	   int,
         @w_return        	   INT,
         @w_valor_ant      	varchar(255),
         @w_valor_nuevo    	varchar(255),
         @w_grupo			      int,
         @w_ente              int,
         @w_ttramite          varchar(255),
         @w_asig_act          int,
         @w_numero            int,
         @w_proceso	         varchar(5),
         @w_usuario	         varchar(64),
         @w_comentario        varchar(1000),
         @w_division          int,
         @w_particiones       varchar(250),
         @w_dom_clientes      varchar(400),
         @w_neg_clientes      varchar(400),
         @w_id_observacion    smallint,
         @w_filial            int,
         @w_geo_min           float,
         @w_geo_max           int,
         @w_oficina           int,
         @w_dom_lat_cliente   float,
         @w_dom_long_cliente  float,
         @w_neg_lat_cliente   float,
         @w_neg_long_cliente  float,
         @w_lat_oficina       float,
         @w_long_oficina      float,
         @w_result_dom        float,
         @w_result_neg        float,
         @w_error_dom         char(1),
         @w_error_neg         char(1)

select @w_sp_name='sp_var_geolocalizacion'

select   @w_grupo    = convert(int,io_campo_1),
	     @w_tramite  = convert(int,io_campo_3),
	     @w_ttramite = io_campo_4,
         @w_asig_act = convert(int, @i_id_asig_act) -- antes: io_campo_2
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

select @w_tramite = isnull(@w_tramite,0)
if @w_tramite = 0 return 0

/* Extracción de parámetros */
select @w_proceso = pa_int from cobis..cl_parametro where pa_nemonico = 'OAA'
select @w_filial = pa_int from cobis..cl_parametro where pa_nemonico = 'FILSAN'
select @w_geo_min = pa_int from cobis..cl_parametro where pa_nemonico = 'DISGEO'
select @w_geo_max = pa_int from cobis..cl_parametro where pa_nemonico = 'RADGEO'

select @w_geo_min = @w_geo_min / 1000 --Transformar de metros a kilometro

select @w_comentario = 'Los siguientes clientes deben actualizar geolocalización:'
select @w_dom_clientes = ''
select @w_neg_clientes = ''

if @w_ttramite = 'GRUPAL'
begin
	
	select @w_ente = 0
	while 1 = 1
	begin
		select @w_error_dom = 'N',
	   @w_error_neg = 'N'
		
		select top 1 @w_ente = tg_cliente
		from cob_credito..cr_tramite_grupal
		where tg_grupo = @w_grupo
		and tg_tramite = @w_tramite
		and tg_participa_ciclo = 'S'
		and tg_cliente > @w_ente
		order by tg_cliente asc
		
		if @@rowcount = 0
		   break
	   
	   /* Se extrae oficina del cliente */
	   select @w_oficina = en_oficina 
	   from cobis..cl_ente 
	   where en_ente = @w_ente
	   
	   /* Geolocalizacion de domicilio */
	   select top 1
	   @w_dom_lat_cliente = dg_lat_seg,
	   @w_dom_long_cliente = dg_long_seg
	   from cobis..cl_direccion, cobis..cl_direccion_geo
	   where di_direccion = dg_direccion
	   and di_ente = dg_ente
	   and dg_ente = @w_ente
	   and di_tipo = 'RE'
	   order by di_direccion desc
	   
	   /* Geolocalizacion de negocio */
	   select top 1
	   @w_neg_lat_cliente = dg_lat_seg,
	   @w_neg_long_cliente = dg_long_seg
	   from cobis..cl_direccion, cobis..cl_direccion_geo
	   where di_direccion = dg_direccion
	   and di_ente = dg_ente
	   and dg_ente = @w_ente
	   and di_tipo = 'AE'
	   order by di_direccion desc
	   
	   /* Geolocalización de la oficina */
	   select 
         @w_lat_oficina = isnull(case
                           when of_lat_coord = 'S' then (convert(decimal(26,6),of_lat_grad) + (convert(decimal(26,6),of_lat_min)/60) + (convert(decimal(26,6),of_lat_seg)/3600)) * -1 
                           else (convert(decimal(26,6),of_lat_grad) + (convert(decimal(26,6),of_lat_min)/60) + (convert(decimal(26,6),of_lat_seg)/3600))
                          end, 0),
         @w_long_oficina = isnull(case
                           when of_long_coord = 'O' then (convert(decimal(26,6),of_long_grad) + (convert(decimal(26,6),of_long_min)/60) + (convert(decimal(26,6),of_long_seg)/3600)) * -1
                           else (convert(decimal(26,6),of_long_grad) + (convert(decimal(26,6),of_long_min)/60) + (convert(decimal(26,6),of_long_seg)/3600))
                          end, 0)
      from cobis..cl_oficina, cobis..cl_filial
      where of_oficina = @w_oficina
      and of_filial  = @w_filial
      and of_filial  = fi_filial
	   
      exec @w_result_dom = fn_CalculaDistancia
         @latitud1   = @w_dom_lat_cliente,
         @longitud1  = @w_dom_long_cliente,
         @latitud2   = @w_lat_oficina,
         @longitud2  = @w_long_oficina
      
      if @w_result_dom >= @w_geo_min and @w_result_dom <= @w_geo_max
         select @w_error_dom = 'N'
      else
         select @w_error_dom = 'S'
      
      if @w_error_dom = 'S'
      begin
         select @w_valor_nuevo = 'NO'
         select @w_dom_clientes = @w_dom_clientes + convert(varchar,@w_ente) + ', '
      end
	   
	   exec @w_result_neg = fn_CalculaDistancia
         @latitud1   = @w_neg_lat_cliente,
         @longitud1  = @w_neg_long_cliente,
         @latitud2   = @w_lat_oficina,
         @longitud2  = @w_long_oficina
      
      if @w_result_neg >= @w_geo_min and @w_result_neg <= @w_geo_max
         select @w_error_neg = 'N'
      else
         select @w_error_neg = 'S'
	   
	   if @w_error_neg = 'S'
      begin
         select @w_valor_nuevo = 'NO'
         select @w_neg_clientes = @w_neg_clientes + convert(varchar,@w_ente) + ', '
      end
	end
	
	if @w_valor_nuevo = 'NO'
	begin
	   
		select @w_comentario = @w_comentario + '- Domicilio: ' + substring(@w_dom_clientes,0,len(@w_dom_clientes)) + '- Negocio: ' + substring(@w_neg_clientes,0,len(@w_neg_clientes))
		
		select @w_id_observacion = ol_observacion from  cob_workflow..wf_ob_lineas 
		where ol_id_asig_act = @w_asig_act 
		and ol_texto like 'Los siguientes clientes deben actualizar geolocalizaci%'
		
		delete cob_workflow..wf_observaciones 
		where ob_id_asig_act = @w_asig_act
		and ob_numero = @w_id_observacion
		
		delete cob_workflow..wf_ob_lineas 
		where ol_id_asig_act = @w_asig_act 
		and ol_observacion = @w_id_observacion
		
		
		select top 1 @w_numero = ob_numero from cob_workflow..wf_observaciones 
		where ob_id_asig_act = @w_asig_act
		order by ob_numero desc
		
		if (@w_numero is not null)
			select @w_numero = @w_numero + 1 --aumento en uno el maximo
		else
			select @w_numero = 1
		
		select @w_usuario = fu_nombre from cobis..cl_funcionario where fu_login = @s_user
		
		if(len(@w_comentario) < 250)
		begin
			insert into cob_workflow..wf_observaciones (ob_id_asig_act, ob_numero, ob_fecha, ob_categoria, ob_lineas, ob_oficial, ob_ejecutivo)
			values (@w_asig_act, @w_numero, getdate(), @w_proceso, 1, 'a', @w_usuario)
			
			insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
			values (@w_asig_act, @w_numero, 1, @w_comentario)
		end
		else
		begin
			insert into cob_workflow..wf_observaciones (ob_id_asig_act, ob_numero, ob_fecha, ob_categoria, ob_lineas, ob_oficial, ob_ejecutivo)
			values (@w_asig_act, @w_numero, getdate(), @w_proceso, 4, 'a', @w_usuario)
			
			select @w_division = (len(@w_comentario)/4)
			
			select @w_particiones = substring(@w_comentario,0,@w_division + 1)
			
			insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
			values (@w_asig_act, @w_numero, 1, @w_particiones)
			
			select @w_particiones = substring(@w_comentario,@w_division + 1,@w_division)
			
			insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
			values (@w_asig_act, @w_numero, 2, @w_particiones)
			
			select @w_particiones =  substring(@w_comentario,(@w_division *2),@w_division)
			
			insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
			values (@w_asig_act, @w_numero, 3, @w_particiones)
			
			select @w_particiones =  substring(@w_comentario,(@w_division *3),len(@w_comentario))
			
			insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
			values (@w_asig_act, @w_numero, 4, @w_particiones)
		end
	end
	else
	begin
	   select @w_id_observacion = ol_observacion from  cob_workflow..wf_ob_lineas 
		where ol_id_asig_act = @w_asig_act 
		and ol_texto like 'Los siguientes clientes deben actualizar geolocalizaci%'
		
		delete cob_workflow..wf_observaciones 
		where ob_id_asig_act = @w_asig_act
		and ob_numero = @w_id_observacion
		
		delete cob_workflow..wf_ob_lineas 
		where ol_id_asig_act = @w_asig_act 
		and ol_observacion = @w_id_observacion
	   
		select @w_valor_nuevo = 'SI'
	end
	
end

-- valor anterior de variable tipo en la tabla cob_workflow..wf_variable
select @w_valor_ant    = isnull(va_valor_actual, '')
  from cob_workflow..wf_variable_actual
 where va_id_inst_proc = @i_id_inst_proc
   and va_codigo_var   = @i_id_variable

if @@rowcount > 0  --ya existe
begin
  --print '@i_id_inst_proc %1! @i_id_asig_act %2! @w_valor_ant %3!',@i_id_inst_proc, @i_id_asig_act, @w_valor_ant
  update cob_workflow..wf_variable_actual
     set va_valor_actual = @w_valor_nuevo 
   where va_id_inst_proc = @i_id_inst_proc
     and va_codigo_var   = @i_id_variable    
end
else
begin
  insert into cob_workflow..wf_variable_actual
         (va_id_inst_proc, va_codigo_var, va_valor_actual)
  values (@i_id_inst_proc, @i_id_variable, @w_valor_nuevo )

end
--print '@i_id_inst_proc %1! @i_id_asig_act %2! @w_valor_ant %3!',@i_id_inst_proc, @i_id_asig_act, @w_valor_ant
if not exists(select 1 from cob_workflow..wf_mod_variable
              where mv_id_inst_proc = @i_id_inst_proc and
                    mv_codigo_var= @i_id_variable and
                    mv_id_asig_act = @i_id_asig_act)
BEGIN
    insert into cob_workflow..wf_mod_variable
           (mv_id_inst_proc, mv_codigo_var, mv_id_asig_act,
            mv_valor_anterior, mv_valor_nuevo, mv_fecha_mod)
    values (@i_id_inst_proc, @i_id_variable, @i_id_asig_act,
            @w_valor_ant, @w_valor_nuevo , getdate())
			
	if @@error > 0
	begin
            --registro ya existe
			
          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file = @t_file, 
          @t_from = @t_from,
          @i_num = 2101002
    return 1
	end 
end

return 0
go