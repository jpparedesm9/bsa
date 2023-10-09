/* ********************************************************************* */
/*      Archivo:                sp_xml_documentos_lcr_det.sp             */
/*      Stored procedure:       sp_xml_documentos_lcr_det                */
/*      Base de datos:          cob_credito                              */
/*      Producto:               Credito                                  */
/*      Disenado por:           Alexander Inca                           */
/*      Fecha de escritura:     29-Enero-2019                            */
/* ********************************************************************* */
/*                              IMPORTANTE                               */
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      "MACOSA", representantes exclusivos para el Ecuador de la        */
/*      "NCR CORPORATION".                                               */
/*      Su uso no autorizado queda expresamente prohibido asi como       */
/*      cualquier alteracion o agregado hecho por alguno de sus          */
/*      usuarios sin el debido consentimiento por escrito de la          */
/*      Presidencia Ejecutiva de MACOSA o su representante.              */
/*                              PROPOSITO                                */
/*      Generar XML de la terea de documentos digitalizados              */
/* ********************************************************************* */
/*                              MODIFICACIONES                           */
/*      FECHA           AUTOR                RAZON                       */
/*      29/01/2019     AINCA                 Version Inicial             */
/* ********************************************************************* */

USE cob_credito
GO

IF OBJECT_ID ('dbo.sp_xml_documentos_lcr_det') IS NOT NULL
    DROP PROCEDURE dbo.sp_xml_documentos_lcr_det
GO

CREATE proc sp_xml_documentos_lcr_det (
    @i_max_si_sincroniza INT = 1,
    @i_inst_proc         INT = 0,
    @i_inst_actividad    INT = 0,
    @i_tramite           INT = NULL,
    @i_accion            VARCHAR(255) = 'INGRESAR',
    @i_observacion       VARCHAR(255) = 'Ingresar documentos lcr'
)
as
declare
@w_codigo_tmp           varchar(3), 
@w_nombre_doc           varchar (50),
@w_catal_doc            varchar(1),
@w_paso_act             INT,
@w_cliente              INT,
@w_nombre_cl            varchar(64),
@w_pregunta             INT,
@w_secuencial           INT,
@w_return               int,
@w_str                  nVARCHAR(max),
@w_rol                  char(1),
@w_fecha_proceso        datetime,
@w_cod_actividad        INT,
@w_long_complete        INT,
@w_caracter_buscar      char(1),
@w_name_complete        varchar(70),
@w_tipo_cargado         varchar(10),
@w_descargado           int

select  @w_fecha_proceso    = fp_fecha   from cobis..ba_fecha_proceso

-- Obtencion del id cliente desde la instancia de proceso.
select @w_cliente = io_campo_1 
from cob_workflow..wf_inst_proceso 
where io_id_inst_proc = @i_inst_proc

-- se obtiene el paso de la actividad
select @w_paso_act = ia_id_paso
from cob_workflow..wf_inst_actividad
where ia_id_inst_proc = @i_inst_proc

-- se obtiene el codigo de la actividad
select @w_cod_actividad = ia_codigo_act 
from cob_workflow..wf_inst_actividad
where ia_id_inst_act = @i_inst_actividad
and ia_id_inst_proc = @i_inst_proc

-- se obtiene el caracter a buscar
select @w_caracter_buscar = '.'

print 'CLIENTE: ' + convert(varchar(100),@w_cliente)

-- Obtencion del nombre del cliente 
select @w_nombre_cl = (select isnull(en_nombre,'')+' '+ isnull(p_s_nombre,'')+' '+ isnull(p_p_apellido,'')+' '+ isnull(p_s_apellido,'') 
                       from cobis..cl_ente where en_ente = @w_cliente)
                    

select @w_str = '<verificationLcrDocument>'      

select @w_str = @w_str +
            '<customerId>'        + convert(VARCHAR(10), @w_cliente)                 +   '</customerId>'       +
            '<customerName>'      + convert(VARCHAR(250),@w_nombre_cl)               +   '</customerName>'     +
            '<instanceProcess>'   + convert(VARCHAR(10),@i_inst_proc)                +   '</instanceProcess>'  +
            '<instanceActivity>' + convert(VARCHAR(10),@i_inst_actividad)           +   '</instanceActivity>'+
             '<stepActivity>'    + convert(VARCHAR(10),@w_paso_act)                 +   '</stepActivity>'
             

-- Se llena la informacion para cada uno de los docmuentos a subir
select @w_codigo_tmp = 0
WHILE 1=1
BEGIN
   SELECT top 1 @w_codigo_tmp = td_codigo_tipo_doc , @w_nombre_doc = td_nombre_tipo_doc , @w_catal_doc = td_categoria_doc
   FROM cob_workflow..wf_tipo_documento 
   WHERE td_nombre_tipo_doc like '%LCR%'
   and td_codigo_tipo_doc > @w_codigo_tmp
   ORDER BY td_codigo_tipo_doc
                  
   IF @@rowcount = 0
   break
   
   
   -- se verifica si existe o no
   if exists (select 1 from cob_workflow..wf_req_inst where ri_id_inst_proc = @i_inst_proc and ri_codigo_act = @w_cod_actividad and ri_codigo_tipo_doc = @w_codigo_tmp)
   begin 
   
      select @w_name_complete = ri_nombre_doc from cob_workflow..wf_req_inst where ri_id_inst_proc = @i_inst_proc and ri_codigo_act = @w_cod_actividad and ri_codigo_tipo_doc = @w_codigo_tmp
      select @w_long_complete = len(@w_name_complete)
      select @w_tipo_cargado=  substring (@w_name_complete,charindex(@w_caracter_buscar,@w_name_complete)+1,@w_long_complete)
      
      print @w_name_complete
      --print convert(varchar(10),@w_codigo_tmp) + convert(varchar(25),@w_nombre_doc)
      select @w_str = @w_str + '<documentList>'
      select @w_str = @w_str + '<code>' +  convert(VARCHAR(10),@w_codigo_tmp) + '</code>'
      select @w_str = @w_str + '<name>' +  convert(VARCHAR(100),@w_nombre_doc) + '</name>'
      select @w_str = @w_str + '<classDoc>' + @w_catal_doc + '</classDoc>'
      select @w_str = @w_str + '<type>' +       @w_tipo_cargado       + '</type>'
      select @w_str = @w_str + '<download>' +'false'     + '</download>'
      select @w_str = @w_str + '<loaded>' +'true'       + '</loaded>'
      select @w_str = @w_str + '</documentList>'
                             
   end
   else
   begin
   --print convert(varchar(10),@w_codigo_tmp) + convert(varchar(25),@w_nombre_doc)
      select @w_str = @w_str + '<documentList>'
      select @w_str = @w_str + '<code>' +  convert(VARCHAR(10),@w_codigo_tmp) + '</code>'
      select @w_str = @w_str + '<name>' +  convert(VARCHAR(100),@w_nombre_doc) + '</name>'
      select @w_str = @w_str + '<classDoc>' + @w_catal_doc + '</classDoc>'
      select @w_str = @w_str + '<type>' +       ''       + '</type>'
      select @w_str = @w_str + '<download>' +'false'     + '</download>'
      select @w_str = @w_str + '<loaded>' +'false'       + '</loaded>'
      select @w_str = @w_str + '</documentList>'
   end
END
  
select @w_str = @w_str + '</verificationLcrDocument>'    
select @w_descargado = 0     

print 'resp -- > ' + @w_str
        
INSERT INTO cob_sincroniza..si_sincroniza_det
VALUES( @i_max_si_sincroniza, @i_inst_proc, @i_tramite, isnull(@w_cliente,0), @w_str,   @i_accion, @i_observacion,@w_descargado)
if @@error <> 0
    begin
        return 150000 -- ERROR EN INSERCION
    end
RETURN 0
GO
