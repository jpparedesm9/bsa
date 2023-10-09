/************************************************************************/
/*  Archivo:                sp_rep_cob_cobis_mc.sp                       */
/*  Stored procedure:       sp_rep_cob_cobis_mc                          */
/*  Base de Datos:          cob_conta_super                             */
/*  Producto:               cob_conta_super                             */
/*  Disenado por:           PXSG                                        */
/*  Fecha de Documentacion: 01/17/2019                                  */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/* Devuelve la fecha para Eliminar las carpetas del FTP de Interfactura */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR                   RAZON                           */
/*01/07/2019    PXSG                  Emision Inicial                   */
/* **********************************************************************/

use cob_conta_super
go

if exists(select 1 from sysobjects where name ='sp_rep_cob_cobis_mc')
	drop proc sp_rep_cob_cobis_mc
go


create proc sp_rep_cob_cobis_mc (
	@t_show_version   bit         = 0
	
) 
AS

Declare
@w_sp_name               varchar(32),
@w_fecha_proceso         datetime, 
@w_num_meses             int,
@w_fin_aux               datetime,
@w_fecha_eli_aux         datetime,
@w_fecha_eli             varchar (10),
@w_estado                char (1),--estado para ejecutar la eliminacion solo en el finde mes habil
@w_mes_aux               int      ,
@w_anio_aux              int      , 
@w_reporte               varchar(10),
@w_fecha_eli_fin         varchar (8),
@w_msg                   varchar(200),
@w_msg_error             varchar(255),
@w_error                 int,
@w_file_rpt              varchar(40),
@w_path                  varchar(255),
@w_fecha_reporte         datetime,
@w_dia                   varchar(2),
@w_mes                   varchar(2),
@w_anio                  varchar(4),
@w_horas                varchar(10),
@w_fecha_r              varchar(10),
@w_file_rpt_1           varchar(200),
@w_file_rpt_1_out       varchar(140),
@w_cmd                  varchar(6000),
@w_comando              varchar(6000),
@w_s_app                varchar(50),
@w_query                varchar(2559)

if @t_show_version = 1
begin
    print 'Stored procedure sp_eli_carpetas_mc, Version 1.0.0'
    return 0
end
--------------------------------------------------------------------------------------

select @w_fecha_proceso=fp_fecha from cobis..ba_fecha_proceso

-- -------------------------------------------------------------------------------
-- DIRECCION DEL ARCHIVO A GENERAR
-- -------------------------------------------------------------------------------
select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'


TRUNCATE TABLE cob_conta_super..sb_rep_cob_mc_cobis

    
DBCC CHECKIDENT ('sb_rep_cob_mc_cobis', RESEED, 1)


/*  Cabecera  */


insert into cob_conta_super..sb_rep_cob_mc_cobis(
mc_contrato,        		  	mc_id_cliente,					mc_neg_telefono,		 		mc_neg_direccion,mc_neg_estado,
mc_neg_municipio,   		  	mc_neg_localidad,				mc_neg_cp,		       		mc_nvas_coord_neg,
mc_foto1_neg,		  		  	mc_foto2_neg,					mc_entre_calle_1_neg, 		mc_entre_calle_2_neg,
mc_entre_calle_3_neg,  	  	mc_entre_calle_4_neg,		mc_nvo_telefono_dom,    	mc_nva_direccion_dom,
mc_nvo_estado_dom, 		  	mc_nvo_municipio_dom,		mc_nva_localidad_dom,		mc_nvo_cp_dom,            
mc_nvas_coodenadas_dom,	  	mc_foto1_dom,					mc_entre_calle_1_dom,		mc_entre_calle_2_dom,
mc_entre_calle_3_dom,	  	mc_entre_calle_4_dom,		mc_foto_domicilio_alt,		mc_entre_calle_1_dom_alt,
mc_entre_calle_2_dom_alt,	mc_entre_calle_3_dom_alt,	mc_entre_calle_4_dom_alt 
)
select   
'CONTRATO'                  ,
'ID_CLIENTE'                ,
'NEG_TELEFONO'              ,
'NEG_DIRECCION'             ,
'NEG_ESTADO'                ,
'NEG_MUNICIPIO'             ,
'NEG_LOCALIDAD'             ,
'NEG_CP'                    ,
'NVAS COORDENADAS NEG'      ,
'FOTO1_NEG'                 ,
'FOTO2_ NEG'                ,
'ENTRE CALLE 1 NEG'         ,
'ENTRE CALLE 2 NEG'         ,
'ENTRE CALLE 3 NEG'         ,
'ENTRE CALLE 4 NEG'         ,
'NVO_TELEFONO'              ,
'NVA_DIRECCION_DOMICILIO'   ,
'NVO_ESTADO DOM'            ,
'NVO_MUNICIPIO DOM'         ,
'NVO_LOCALIDAD DOM'         ,
'NVO_C_P DOM'               ,
'NVAS_COORDENADAS DOM'      ,
'FOTO1_DOM'                 ,
'ENTRE CALLE 1 DOM'         ,
'ENTRE CALLE 2 DOM'         ,
'ENTRE CALLE 3 DOM'         ,
'ENTRE CALLE 4 DOM'         ,
'FOTO DEL DOMICILIO ALTERNO',
'ENTRE CALLE 1 DOM ALTERNO' ,
'ENTRE CALLE 2 DOM ALTERNO' ,
'ENTRE CALLE 3 DOM ALTERNO' ,
'ENTRE CALLE 4 DOM ALTERNO' 

if @@error != 0 begin
   select 
   @w_error = 9999,
   @w_msg_error = 'ERROR AL INSERTAR CABECERA'
   goto ERROR_PROCESO
end

/*  Data  */

insert into cob_conta_super..sb_rep_cob_mc_cobis(
mc_contrato,        		  	mc_id_cliente,					mc_neg_telefono,		 		mc_neg_direccion,mc_neg_estado,
mc_neg_municipio,   		  	mc_neg_localidad,				mc_neg_cp,		       		mc_nvas_coord_neg,
mc_foto1_neg,		  		  	mc_foto2_neg,					mc_entre_calle_1_neg, 		mc_entre_calle_2_neg,
mc_entre_calle_3_neg,  	  	mc_entre_calle_4_neg,		mc_nvo_telefono_dom,    	mc_nva_direccion_dom,
mc_nvo_estado_dom, 		  	mc_nvo_municipio_dom,		mc_nva_localidad_dom,		mc_nvo_cp_dom,            
mc_nvas_coodenadas_dom,	  	mc_foto1_dom,					mc_entre_calle_1_dom,		mc_entre_calle_2_dom,
mc_entre_calle_3_dom,	  	mc_entre_calle_4_dom,		mc_foto_domicilio_alt,		mc_entre_calle_1_dom_alt,
mc_entre_calle_2_dom_alt,	mc_entre_calle_3_dom_alt,	mc_entre_calle_4_dom_alt 
)
select   
'CONTRATO'                  =isnull(case when producto_prestamos = 'GRUPAL' then  nro_operacion_grupal
                                  when producto_prestamos = 'REVOLVENTE' then  contrato
                              end,' '),
'ID_CLIENTE'                =isnull(cliente_cobis,' '),
'NEG_TELEFONO'              =isnull(neg_telefono,' '),
'NEG_DIRECCION'             =isnull(neg_direccion,' '),
'NEG_ESTADO'                =isnull(neg_estado,' '),
'NEG_MUNICIPIO'             =isnull(neg_municipio,' '),
'NEG_LOCALIDAD'             =isnull(neg_localidad,' '),
'NEG_CP'                    =isnull(neg_cp,' '),
'NVAS COORDENADAS NEG'      =isnull(coordenadas_negocio,' '),
'FOTO1_NEG'                 =isnull(foto_negocio,' '),
'FOTO2_ NEG'                =isnull(foto_negocio_2,' '),
'ENTRE CALLE 1 NEG'         =isnull(entre_calle_1_neg,' '),
'ENTRE CALLE 2 NEG'         =isnull(entre_calle_2_neg,' '),
'ENTRE CALLE 3 NEG'         =isnull(entre_calle_3_neg,' '),
'ENTRE CALLE 4 NEG'         =isnull(entre_calle_4_neg,' '),
'NVO_TELEFONO'              =isnull(dom_telefono,' '),
'NVA_DIRECCION_DOMICILIO'   =isnull(nvo_dom_direccion,' '),
'NVO_ESTADO DOM'            =isnull(nvo_estado,' '),
'NVO_MUNICIPIO DOM'         =isnull(nvo_municipio,' '),
'NVO_LOCALIDAD DOM'         =isnull(nvo_localidad,' '),
'NVO_C_P DOM'               =isnull(nvo_c_p,' '),
'NVAS_COORDENADAS DOM'      =isnull(nvas_coordenadas_dom,' '),
'FOTO1_DOM'                 =isnull(foto_domicilio,' '),
'ENTRE CALLE 1 DOM'         =isnull(entre_calle_1_dom,' '),
'ENTRE CALLE 2 DOM'         =isnull(entre_calle_2_dom,' '),
'ENTRE CALLE 3 DOM'         =isnull(entre_calle_3_dom,' '),
'ENTRE CALLE 4 DOM'         =isnull(entre_calle_4_dom,' '),
'FOTO DEL DOMICILIO ALTERNO'=isnull(foto_domicilio_alterno,' '),
'ENTRE CALLE 1 DOM ALTERNO' =isnull(entre_calle_1_dom_alterno,' '),
'ENTRE CALLE 2 DOM ALTERNO' =isnull(entre_calle_2_dom_alterno,' '),
'ENTRE CALLE 3 DOM ALTERNO' =isnull(entre_calle_3_dom_alterno,' '),
'ENTRE CALLE 4 DOM ALTERNO' =isnull(entre_calle_4_dom_alterno,' ') from 
cob_conta_super..sb_rep_ini_cobis_collect
where  producto_prestamos in ('GRUPAL','REVOLVENTE')
and    estado_reporte='N'

if @@error != 0 begin
   select 
   @w_error = 9999,
   @w_msg_error = 'ERROR AL INSERTAR CABECERA'
   goto ERROR_PROCESO
end
--Inicio del reporte


select @w_fecha_reporte =  getdate()

select 
@w_mes   = substring(convert(varchar,@w_fecha_reporte, 101),1,2),
@w_dia   = substring(convert(varchar,@w_fecha_reporte, 101),4,2),
@w_anio  = substring(convert(varchar,@w_fecha_reporte, 101),9,2),
@w_horas = substring(replace(convert(varchar, getdate(),  108), ':', '') ,1,2)

select 
@w_file_rpt =  ba_arch_resultado,
@w_path     =  ba_path_destino,
@w_fecha_r  =  @w_dia + @w_mes + @w_anio +'_'+@w_horas
from cobis..ba_batch 
where ba_batch = 287933

--ARMADA DEL NOMBRE DEL REPORTE 
select 
@w_file_rpt       = isnull(@w_file_rpt, 'MC_COBRANZACOBIS_'),
@w_file_rpt_1     = @w_path + @w_file_rpt + @w_fecha_r + '_' +'N'+'.txt',
@w_file_rpt_1_out = @w_path + @w_file_rpt + @w_fecha_r + '_' +'N'+'.err'

select @w_query = 'select mc_contrato,mc_id_cliente,mc_neg_telefono,mc_neg_direccion,mc_neg_estado,'
select @w_query = @w_query + 'mc_neg_municipio,mc_neg_localidad,mc_neg_cp,mc_nvas_coord_neg,'
select @w_query = @w_query + 'mc_foto1_neg,mc_foto2_neg,mc_entre_calle_1_neg,mc_entre_calle_2_neg,'
select @w_query = @w_query + 'mc_entre_calle_3_neg,mc_entre_calle_4_neg,mc_nvo_telefono_dom,mc_nva_direccion_dom,'
select @w_query = @w_query + 'mc_nvo_estado_dom,mc_nvo_municipio_dom,mc_nva_localidad_dom,mc_nvo_cp_dom,'            
select @w_query = @w_query + 'mc_nvas_coodenadas_dom,mc_foto1_dom,mc_entre_calle_1_dom,mc_entre_calle_2_dom,'
select @w_query = @w_query + 'mc_entre_calle_3_dom,mc_entre_calle_4_dom,mc_foto_domicilio_alt,mc_entre_calle_1_dom_alt,'
select @w_query = @w_query + 'mc_entre_calle_2_dom_alt,mc_entre_calle_3_dom_alt,	mc_entre_calle_4_dom_alt'
select @w_query = @w_query + ' from cob_conta_super..sb_rep_cob_mc_cobis order by mc_secuencial ASC'


select @w_comando = 'bcp "' + @w_query + '" queryout "'	   
select @w_comando = @w_comando + @w_file_rpt_1 + '" -b5000 -c -C RAW -T -e ' + @w_s_app + 's_app.ini -T -e"' + @w_file_rpt_1_out + '"'
print '@w_comando'+ convert(varchar(6000),@w_comando)

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
  select 
  @w_error = 70146,
  @w_msg    = 'Fallo el BCP'
  goto ERROR_PROCESO
end

/*Actualizacion del estado del reporte y fecha en que se genero el reporte mediante el job en la tabla sb_rep_ini_cobis_collect */

Update cob_conta_super..sb_rep_ini_cobis_collect
set estado_reporte='S',
fecha_gen_rep_cob=getdate()
where  producto_prestamos in ('GRUPAL','REVOLVENTE')
and    estado_reporte='N'

return 0

ERROR_PROCESO:
     select @w_msg = isnull(@w_msg, 'ERROR GENRAL DEL PROCESO')
     exec cob_conta_super..sp_errorlog
     @i_fecha_fin     = @w_fecha_proceso,
     @i_fuente        = @w_sp_name,
     @i_origen_error  = @w_error,
     @i_descrp_error  = @w_msg

     return @w_error
go

