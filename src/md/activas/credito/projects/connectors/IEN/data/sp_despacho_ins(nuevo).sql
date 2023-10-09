USE [cobis]
GO

/****** Object:  StoredProcedure [dbo].[sp_despacho_ins]    Script Date: 20/11/2017 10:59:54 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

DROP PROCEDURE sp_despacho_ins
GO

/******************************************************************************/
/*      Stored procedure:       ns_despacho_ins.sp                            */
/*      Base de datos:          cobis                                  */
/*      Producto:               Banca en línea                                */
/******************************************************************************/
/*                                 IMPORTANTE                                 */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.   */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier       */
/* alteracion o agregado hecho por alguno de usuarios sin el debido           */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp        */
/* o su representante.                                                        */
/******************************************************************************/
/*                                PROPOSITO                                   */
/*  Registrar los datos de las notificaciones que van a ser procesadas en BVI */
/******************************************************************************/
/*                              MODIFICACIONES                                */
/******************************************************************************/
/*  FECHA       VERSION  AUTOR          RAZON                                 */
/******************************************************************************/
/*  26/May/1999 1.0.0   Juan Arthos     Emision Inicial                       */ 
/*  15/Mar/2002 1.0.1   D Villafuerte   Person Bco Tequendama                 */
/*  2010-11-24  1.0.2   NES             Nuevo esquema de notificacion         */
/******************************************************************************/
Create Procedure [dbo].[sp_despacho_ins]( 
@s_ssn                int               = null,
@s_user               login             = null,
@s_sesn               int               = null,
@s_term               varchar(30)       = null,
@s_date               datetime          = null,
@s_srv                varchar(30)       = null,  
@s_lsrv               varchar(30)       = null,  
@s_ofi                smallint          = null,
@t_trn                int               = null, 
@t_debug              char(1)           = 'N', 
@t_file               varchar(14)       = null, 
@t_from               varchar(30)       = null, 
@i_cliente            int, 
@i_template			  int,
@i_servicio           int, 
@i_estado             char(1)           = 'P', 
@i_tipo               varchar(10), 
@i_tipo_mensaje       char(1), 
@i_prioridad          tinyint, 
@i_var1               varchar(64)       = null, 
@i_var2               varchar(64)       = null, 
@i_var3               varchar(64)       = null, 
@i_var4               varchar(255)      = null, 
@i_var5               varchar(255)      = null, 
@i_var6               varchar(255)      = null,
@i_var7               varchar(255)      = null,
@i_from               varchar(255)      = null,
@i_to                 varchar(255)      = null,
@i_cc                 varchar(255)      = null,
@i_bcc                varchar(255)      = null,
@i_subject            nvarchar(255)     = null,
@i_body               nvarchar(2000)    = null,
@i_content_manager    varchar(255)      = null,
@i_retry              char(1)           = 'N',
@i_fecha_envio        datetime          = null,
@i_hora_ini           datetime          = null,
@i_hora_fin           datetime          = null,
@i_tries              smallint          = 0,
@i_max_tries          smallint          = 0,
@o_siguiente          int               = null out,
@s_rol                INT               = null,
@s_culture            VARCHAR(10)       = null,
@s_org                VARCHAR(10)       = null,
@i_num_dir            VARCHAR(10)       = null,
@i_template_id        INT               = null
)   
 
As   
 
declare   
  @w_sp_name           varchar(64), 
  @w_siguiente         int,
  @w_nd_fecha_auto         datetime,
  @w_ndias             int
 
select @w_sp_name = 'sp_despacho_ins' 
 

begin tran 
exec cobis..sp_cseqnos 
@i_tabla = 'ns_notificaciones_despacho', 
@o_siguiente = @w_siguiente out 

if @w_siguiente = NULL 
begin 
-- No existe tabla en tabla de secuenciales 
  exec cobis..sp_cerror 
  @t_from  = @w_sp_name, 
  @i_num   = 2101007 
  return 1 
end 

-- Determina número de días para fecha para autoborrado
   select @w_ndias = pa_int
   from cobis..cl_parametro
   where pa_nemonico = 'DBM'
     and pa_producto = 'BVI'
   if @@rowcount = 0
      select @w_ndias = 30

-- Determina fecha de autoborrado
   select @w_nd_fecha_auto = dateadd(dd, @w_ndias, getdate())

-- Elimina hora y minutos
   select @w_nd_fecha_auto = convert(varchar, @w_nd_fecha_auto,101)

-- Determina fecha de proceso
   select @s_date = fp_fecha
   from cobis..ba_fecha_proceso
   if @@rowcount = 0
      select @s_date = convert (varchar, getdate(), 101)
   
   select @o_siguiente = @w_siguiente

-- Insertar en ns_notificaciones_despacho 
   insert into ns_notificaciones_despacho 
        (nd_id,               nd_te_id,				   nd_servicio,             
		 nd_ente, 			  nd_tipo,                 nd_tipo_mensaje,         
		 nd_prioridad,        nd_num_dir,              nd_estado,               
		 nd_num_err,          nd_txt_err,              nd_ret_status,           
		 nd_fecha_reg,        nd_fecha_mod,            nd_fecha_auto,           
		 nd_var1,             nd_var2,                 nd_var3,                 
		 nd_var4,             nd_var5,                 nd_var6,                 
		 nd_var7,             nd_from,                 nd_to,                   
		 nd_cc,               nd_bcc,                  nd_subject,              
		 nd_body,             nd_content_manager,      nd_retry,                
		 nd_tries,            nd_max_tries,            nd_fecha_envio,          
		 nd_hora_ini,         nd_hora_fin) 

values 
        (@w_siguiente ,       @i_template,        		@i_servicio,              
		 @i_cliente,          @i_tipo,                  @i_tipo_mensaje,          
		 @i_prioridad,        '',               @i_estado,                
		 0, 				  ' ',                      0,                        
		 @s_date,             getdate(),                @w_nd_fecha_auto,         
		 @i_var1,             @i_var2,             	    @i_var3,                  
		 @i_var4,             @i_var5,                  @i_var6 ,                 
		 @i_var7,             @i_from,                  @i_to,                    
		 @i_cc,				  @i_bcc,                   @i_subject,               
		 @i_body,	          @i_content_manager,       @i_retry,                 
		 @i_tries,            @i_max_tries,             @i_fecha_envio,           
		 @i_hora_ini,		  @i_hora_fin)
         
 /*     
   SELECT       
        @w_siguiente col1 , @i_servicio col2 , @i_cliente col3, 
                @i_tipo col4, @i_tipo_mensaje col5 , @i_prioridad col6, 
                @i_num_dir col7, @i_estado col8 , 0 col9, 
                ' ' col10, 0 col11, @s_date col12, 
                getdate() col13, @w_nd_fecha_auto col14, @i_var1 col15, 
                @i_var2 col16, @i_var3 col17, @i_var4 col18, 
                @i_var5 col19, @i_var6 col20, @i_var7 col21
         INTO osvarios 
  */
if @@error != 0 
begin 
-- Error en la insercion en ns_notificaciones_despacho 
   exec cobis..sp_cerror 
          @t_from  = @w_sp_name, 
          @i_num   = 1850154 
   return 1 
end 
 
commit tran 
return 0 
 

GO


