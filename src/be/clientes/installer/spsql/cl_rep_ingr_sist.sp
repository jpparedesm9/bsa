/***************************************************************************/
/*   Archivo:                 cl_rep_ingr_sist.sp                          */ 
/*   Stored procedure:        sp_rep_ingresos_sistema                      */
/*   Base de Datos:           cobis                                        */
/*   Producto:                Clientes                                     */
/*   Disenado por:            Maria Jose Taco                              */
/*   Fecha de Documentacion:  02/04/2020                                   */
/***************************************************************************/
/*                            IMPORTANTE                                   */
/*   Este programa es parte de los paquetes bancario s propiedad de        */
/*   'COBIS'.                                                              */
/*   Su uso no autorizado queda expresamente prohibido asi como            */
/*   cualquier autorizacion o agregado hecho por alguno de sus             */
/*   usuario sin el debido consentimiento por escrito de la                */
/*   Presidencia Ejecutiva de COBIS o su representante                     */
/***************************************************************************/
/*                         PROPOSITO                                       */
/*                     Reporte de Cobranza                                 */
/*	 Reporte de los ingresos al sistema de los asesores                    */
/***************************************************************************/
/*                     MODIFICACIONES                                      */
/* FECHA                AUTOR                DETALLE                       */
/*17-02-2020			ALD					corregir Requerimiento #135235 */
/***************************************************************************/

use cobis
go 

if exists(select 1 from sysobjects where name = 'sp_rep_ingresos_sistema')
    drop proc sp_rep_ingresos_sistema
go

create proc sp_rep_ingresos_sistema  
(
    @i_param1           datetime   =   null ,
	@i_param2           datetime   =   null 
)as

DECLARE
  @w_sp_name        varchar(20),
  @w_s_app          varchar(50),
  @w_path           varchar(255),  
  @w_msg            varchar(200),  
  @w_return         int,
  @w_dia            varchar(2),
  @w_mes            varchar(2),
  @w_anio           varchar(4),
  @w_fecha_r        varchar(10),
  @w_file_rpt       varchar(40),
  @w_file_rpt_1     varchar(200),
  @w_file_rpt_1_out varchar(140),
  @w_bcp            varchar(2000),
  @w_error          int,
  @w_msg_error      varchar(255),
  @t_show_version   int,
  @w_fecha_desde    datetime,
  @w_fecha_hasta    datetime,
  @w_cmd            varchar(1000),
  @w_destino        varchar(1000),
  @w_comando        varchar(1000),
  @w_errores        varchar(1000),
  @w_ciudad_nacional       int
  
select @w_sp_name = 'sp_rep_ingresos_sistema'

--Versionamiento del Programa
if @t_show_version = 1
begin
  print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.1.0.0'
  return 0
end

truncate table cl_ingresos_sistema

-- -------------------------------------------------------------------------------
-- DIRECCION DEL ARCHIVO A GENERAR
-- -------------------------------------------------------------------------------
select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

if (@i_param1 = @i_param2)
begin  
    select @w_fecha_desde = dateadd(dd,-1,@i_param1),
        @w_fecha_hasta = @i_param2        
		while exists(select 1 from cobis..cl_dias_feriados where df_ciudad=@w_ciudad_nacional and df_fecha=@w_fecha_desde)
	begin
		select @w_fecha_desde = dateadd(dd,-1,@w_fecha_desde)
	end      
	
	select @w_fecha_hasta = dateadd(dd,1,@w_fecha_desde)     
end
else
begin
	select @w_fecha_desde = @i_param1,
		@w_fecha_hasta = @i_param2
	select @w_fecha_hasta = dateadd(dd,1,@w_fecha_hasta)     
end

print 'desde'+convert(varchar(10),@w_fecha_desde,103)
print 'hasta'+convert(varchar(10),@w_fecha_hasta,103)
end             

--DETERMINAR UNIVERSO DE REGISTROS A REPORTAR 

insert into cl_ingresos_sistema(
is_usuario,      is_nombre,          is_medio,
is_fecha,        is_hora)
select 
'USUARIO',       'NOMBRE',           'MEDIO',
'FECHA',         'HORA'


if @@error != 0 begin
   select 
   @w_error = 141080,
   @w_msg_error = 'No se pudo insertar cabecera'
   goto ERROR_PROCESO
end

insert into cl_ingresos_sistema(
is_usuario,      is_nombre,          is_medio,
is_fecha,        is_hora)													   
SELECT lo_login,
       fu_nombre,
       lo_terminal,
       convert(varchar(10),lo_fecha_in,103),
       convert(VARCHAR,substring(convert(varchar,lo_fecha_in), 12,8))
FROM in_login,
     cl_funcionario
WHERE lo_login = fu_login     
and lo_fecha_in BETWEEN @w_fecha_desde AND @w_fecha_hasta


if @@error != 0 begin
   select 
   @w_error = 17050,
   @w_msg_error = 'ERROR AL INSERTAR REGISTRO EN TABLA CR_BURO_DIARIO'
   goto ERROR_PROCESO
end
--

--GENERACION DEL REPORTE 
--FORMATO DE HORAS 
select 
@w_mes   = substring(convert(varchar,@w_fecha_hasta, 101),1,2),
@w_dia   = substring(convert(varchar,@w_fecha_hasta, 101),4,2),
@w_anio  = substring(convert(varchar,@w_fecha_hasta, 101),9,2)


--DATOS DEL ARCHIVO
select 
@w_file_rpt =  ba_arch_resultado,
@w_path     =  ba_path_destino,
@w_fecha_r  =  @w_dia + @w_mes + @w_anio 
from cobis..ba_batch 
where ba_batch = 2044

--ARMADA DEL NOMBRE DEL REPORTE 
select 
@w_file_rpt       = isnull(@w_file_rpt, 'INGRESOS_AL_SISTEMA_'),
@w_file_rpt_1     = @w_path + @w_file_rpt + @w_fecha_r + '_' +'.txt',
@w_file_rpt_1_out = @w_path + @w_file_rpt + @w_fecha_r + '_' +'.err'


select @w_cmd     = @w_s_app + 's_app bcp -auto -login cobis..cl_ingresos_sistema out '

select @w_comando = @w_cmd  +  @w_file_rpt_1  + ' -b5000 -c -T -e ' + @w_file_rpt_1_out+ ' -t"\t" ' + '-config ' + @w_s_app + 's_app.ini'


exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
  select 
  @w_return = 70146,
  @w_msg    = 'ERROR: GENERAR LISTADO'
  goto ERROR_PROCESO
end


--ERROR GENERAL DEL PROCESO 
return 0

ERROR_PROCESO:
     select @w_msg = isnull(@w_msg, 'ERROR GENERAL DEL PROCESO')
	 
     exec cob_cartera..sp_errorlog
	 @i_error         = @w_error,
	 @i_usuario       = 'usrbatch',
	 @i_tran          = 26004,
	 @i_tran_name     = null,
	 @i_rollback      = 'S'

     return @w_error

GO

