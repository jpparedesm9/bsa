/* ********************************************************************* */
/*      Archivo:                sp_lcr_consulta_bio.sp                   */
/*      Stored procedure:       sp_lcr_consulta_bio                      */
/*      Base de datos:          cobis                                  */
/*      Producto: Clientes                                               */
/*      Disenado por:           Sonia Rojas                              */
/*      Fecha de escritura:     30-Oct-2020                              */
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
/*      Este programa procesa las transacciones del stored procedure     */
/*      Insercion del miebro del grupo                                   */
/*      Actualizacion del miebro del grupo                               */
/* ********************************************************************* */
/*                              MODIFICACIONES                           */
/*      FECHA           AUTOR                RAZON                       */
/*      30/Oct/2020    Sonia Rojas          Version Inicial              */
/* ********************************************************************* */
use cobis
go


if exists (select * from sysobjects where name = 'sp_lcr_respuesta_bio')
   drop proc sp_lcr_respuesta_bio
go
IF OBJECT_ID ('sp_lcr_respuesta_bio') IS NOT NULL
    DROP PROCEDURE sp_lcr_respuesta_bio
GO

CREATE proc sp_lcr_respuesta_bio (
    @s_ssn                  int             = null,
    @s_sesn                 int             = null,
    @s_culture              varchar(10)     = null,
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
    @i_operacion            char(1),                -- Opcion con que se ejecuta el programa
    @i_modo                 tinyint         = null, -- Modo de busqueda
    @i_tipo                 char(1)         = null, -- Tipo de consulta
    @i_filial               tinyint         = null, -- Codigo de la filial
    @i_oficina              smallint        = null, -- Codigo de la oficina
    @i_ente                 int             = null, -- Codigo del ente que forma parte del grupo
    @i_tramite              int             = NULL
)
as

declare
@w_id_inst_proc             int,
@w_resultado_monto          varchar(255),
@w_fecha_proceso            datetime,
@w_error                    int,
@w_sp_name                  varchar(50)

select @w_sp_name = 'sp_lcr_respuesta_bio'


if @i_operacion = 'Q' begin

   declare @w_credito_revolvente table (
      secuencial               int identity, --0
      id_cliente               int,--1
      nombre_cliente           varchar(255) null,--2
      monto                    money        null,--3
      sin_huella               char(1)      null,--4
      ocr					   varchar(13)  null,--5
      cic					   varchar(10)  null,--6
      nombre				   varchar(64)  null,--7
      apellidoPaterno		   varchar(64)	null,--8
      apellidoMaterno		   varchar(64)  null,--9
      anioRegistro		       varchar(5)	null,--10
      anioEmision			   varchar(5)	null,--11
      numeroCredencial	       varchar(5)	null,--12
      claveElector		       varchar(20)	null,--13
      curp				       varchar(30)	null,--14
      city				       varchar(20)  null,--15
      birthday			       varchar(10)  null,--16
      buc					   varchar(20)	null,--17	  
      estado                   varchar(30),--18
      id_inst_proceso          int--19
   )
   
   select @w_fecha_proceso = fp_fecha 
   from cobis..ba_fecha_proceso
   
   select @w_id_inst_proc = io_id_inst_proc
   from cob_workflow..wf_inst_proceso
   where io_campo_3       = @i_tramite
   
   --EJECUCION DE LA REGLA DE CUPO INICIAL 
   exec @w_error       = cob_cartera..sp_ejecutar_regla
   @s_ssn              = @s_ssn,
   @s_ofi              = @s_ofi,
   @s_user             = @s_user,
   @s_date             = @w_fecha_proceso,
   @s_srv              = @s_srv,
   @s_term             = @s_term,
   @s_rol              = @s_rol,
   @s_lsrv             = @s_lsrv,
   @s_sesn             =  @s_ssn,
   @i_regla            = 'LCRCUPINI',    
   @i_id_inst_proc     = @w_id_inst_proc,
   @i_tipo_ejecucion   = 'WORKFLOW',
   @o_resultado1       = @w_resultado_monto out  
   
   if @w_error <> 0 goto ERROR
   
   
   insert into @w_credito_revolvente
   select  
   tr_cliente,--1
   null,--2
   convert(money, @w_resultado_monto),--3
   null,--4
   null,--5
   null,--6
   null,--7			
   null,--8	
   null,--9	
   null,--10		
   null,--11		
   null,--12	
   null,--13		
   null,--14				
   null,--15				
   null,--16			
   null,--17				
   null,--18
   @w_id_inst_proc--19
   from cob_credito..cr_tramite 
   where tr_tramite = @i_tramite
   
   
   update @w_credito_revolvente set
   nombre_cliente  =   en_nombre + 
                       case when p_s_nombre is null or rtrim(ltrim(p_s_nombre)) = '' then '' else ' '+ p_s_nombre  end +
                       case when p_p_apellido is null or rtrim(ltrim(p_p_apellido)) = '' then '' else ' '+ p_p_apellido end +
                       case when p_s_apellido is null or rtrim(ltrim(p_s_apellido)) = '' then '' else ' '+ p_s_apellido end,
   nombre          =   en_nombre + 
                       case when p_s_nombre is null or rtrim(ltrim(p_s_nombre)) = '' then '' else ' '+ p_s_nombre  end,
   apellidoPaterno =   p_p_apellido,
   apellidoMaterno =   p_s_apellido,
   curp            =   en_ced_ruc,
   city            =   p_depa_nac,
   birthday	       =   convert(varchar(10),p_fecha_nac,103),
   buc             =   en_banco
   from cobis..cl_ente
   where en_ente = id_cliente
   
   update @w_credito_revolvente set
   sin_huella 	    = eb_sin_huella_dactilar,
   ocr				= eb_ocr,
   cic				= eb_cic,
   anioRegistro	    = eb_anio_registro,
   anioEmision		= eb_anio_emision,
   numeroCredencial = eb_nro_emision,
   claveElector	    = eb_clave_elector
   from  cobis..cl_ente_bio
   where eb_ente = id_cliente
   
   
   update @w_credito_revolvente set
   estado =  rb_resultado  
   from cobis..cl_respuesta_bio
   where rb_ente      = id_cliente
   and   rb_inst_proc = id_inst_proceso
   
   select 
   secuencial,    
   id_cliente,    
   nombre_cliente,      
   monto,               
   sin_huella,          
   ocr,					
   cic,					
   nombre,				
   apellidoPaterno,
   apellidoMaterno,		
   anioRegistro,		  
   anioEmision,			
   numeroCredencial,
   claveElector,		  
   curp,				  
   city,				  
   birthday,
   buc,					
   estado       
   from @w_credito_revolvente
   
end

return 0

ERROR:

exec cobis..sp_cerror
@t_debug = @t_debug,
@t_file  = @t_file, 
@t_from  = @w_sp_name,
@i_num   = @w_error

return @w_error
go