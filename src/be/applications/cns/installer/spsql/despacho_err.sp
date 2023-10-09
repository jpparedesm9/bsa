/******************************************************************************/
/*      Stored procedure:       ns_despacho_err.sp                            */
/*      Base de datos:          cobis                                  		  */
/*      Producto:               Banca en l�nea                                */
/******************************************************************************/
/*                                 IMPORTANTE                                 */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.   */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier       */
/* alteracion o agregado hecho por alguno de usuarios sin el debido           */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp        */
/* o su representante.                                                        */
/******************************************************************************/
/*                                PROPOSITO                                   */
/*   Modificar los datos de un mensaje por despachar en BVI                   */ 
/*   debido a un error                                                        */ 
/******************************************************************************/
/*                              MODIFICACIONES                                */
/******************************************************************************/
/*  FECHA       VERSION   AUTOR           RAZON                               */
/******************************************************************************/
/*  26/May/1999 1.0.0.0   Juan Arthos     Emision Inicial                     */ 
/*  05/Oct/2001 1.0.0.1   D Villafuerte   Person Bco Tequendama               */
/*  24/Nov/2010 4.0.0.2   NES             Nuevo esquema de notificacion       */
/*  09/Dic/2010 4.0.0.3   NES             Validar contadores                  */
/******************************************************************************/
use cobis
go
if object_id('sp_despacho_err') is not null
                drop proc sp_despacho_err
go

Create Procedure sp_despacho_err( 
@s_ssn                int               = null, 
@s_user               varchar(14)       = null, 
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
@t_show_version       tinyint           = 0,
@i_id                 int, 
@i_estado             char(1)           = 'C', 
@i_mode               char(1)           = 'C',   --Compatibilidad y Nuevo
@i_num_err            int               = 0, 
@i_txt_err            varchar(64)       = '', 
@i_ret_status         int               = 0 
)   
 
As   
 
declare   
  @w_sp_name           varchar(64), 
  @w_siguiente         int,
  @w_fecha_envio       datetime,
  @w_tries             smallint,
  @w_retry             char(1),
  @w_max_tries         smallint,
  @w_hora_ini          datetime,
  @w_hora_fin          datetime,
  @w_estado            char(1) 
 
select @w_sp_name = 'sp_despacho_err' 
--------------------------------------------------------------------------------
--                Mostrar la version del programa
--------------------------------------------------------------------------------
if @t_show_version = 1
begin
  declare @w_message varchar(255)
  select @w_message = 'Stored Procedure: ' + @w_sp_name + ' Version: ' + '4.0.0.3'
  print @w_message
  return 0
end
-- Validacion para texto de error
   select @i_txt_err = isnull(@i_txt_err, '')
 
begin tran 

if @i_mode = 'N'
begin

   select
       @w_tries       = nd_tries,
       @w_retry       = nd_retry,
       @w_max_tries   = nd_max_tries,
       @w_estado      = nd_estado
   from ns_notificaciones_despacho 
   where nd_id = @i_id
   
   if @w_estado != 'P' and @w_estado != 'C'
   begin 
      if @w_retry = 'S'
         select @w_tries = @w_tries + 1
      
      if @w_tries > @w_max_tries
         select @i_estado = 'C',
                @w_retry  = 'N' 
   end
             
   /* Actualiza ns_notificaciones_despacho */ 
    
   update ns_notificaciones_despacho 
   set nd_estado     = @i_estado, 
       nd_num_err    = @i_num_err, 
       nd_txt_err    = @i_txt_err, 
       nd_ret_status = @i_ret_status, 
       nd_fecha_mod  = getdate(),
       nd_retry      = @w_retry,
       nd_tries      = @w_tries 
   where nd_id = @i_id 
    
   if @@error != 0 
   begin 
     /* Error en la actualizacion en mensaje a despachar */ 
     exec cobis..sp_cerror 
     @t_from  = @w_sp_name, 
     @i_num   = 1850155 
     return 1 
   end
    
end
else 
begin
    
   /* insertar en ns_notificaciones_despacho */ 
    
   update ns_notificaciones_despacho 
   set nd_estado     = @i_estado, 
       nd_num_err    = @i_num_err, 
       nd_txt_err    = @i_txt_err, 
       nd_ret_status = @i_ret_status, 
       nd_fecha_mod  = getdate() 
   where nd_id = @i_id 
    
   if @@error != 0 
   begin 
     /* Error en la actualizacion en mensaje a despachar */ 
     exec cobis..sp_cerror 
     @t_from  = @w_sp_name, 
     @i_num   = 1850155 
     return 1 
   end 
end 
commit tran 
return 0 
go
