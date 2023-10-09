/************************************************************************/
/*      Archivo:                beneftmp.sp                             */
/*      Stored procedure:       sp_beneficiario_tmp                     */
/*      Base de datos:          cobis                                   */
/*      Disenado por:           Miryam Davila                           */
/*      Fecha de documentacion: 24/Oct/94                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de INSERT y DELETE      */
/*      a la tabla temporal de beneficiarios 'pf_beneficiario_tmp'.     */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      05-Nov-94  Ricardo Valencia   Creacion                          */
/*      17-Ago-95  Carolina Alvarado  % Participacion                   */
/*                                                                      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_beneficiario_tmp')
   drop proc sp_beneficiario_tmp
go

create proc sp_beneficiario_tmp (
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_sesn                 int             = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  smallint        = NULL,
@i_operacion            char(1),
@i_cuenta               cuenta,
@i_ente                 int,
@i_rol                  catalogo        = 'T',
@i_tipo                 char(1)         = 'T',
@i_condicion            char(1)         = 'O',
@i_secuencia            smallint        = null)
with encryption
as
declare
      @i_operacionpf          int,
      @w_sp_name              varchar(32),
      @w_totporc              float,   
      @w_porcencapi           float,  
      @w_porceninte           float,  
      @w_producto             catalogo,
      @w_cuentap              cuenta,
      @w_direccion            tinyint,
      @w_casilla              tinyint,
      @w_rol                  catalogo,
      @w_fecha_crea           datetime,
      @w_fecha_mod            datetime,
      @w_usuario              login,
      @w_sesion               int

select @w_sp_name = 'sp_beneficiario_tmp'


/**  VERIFICAR CODIGO DE TRANSACCION   **/
if ( @i_operacion <> 'I' or @t_trn <> 14113 ) and
   ( @i_operacion <> 'C' or @t_trn <> 14113 ) and
   ( @i_operacion <> 'D' or @t_trn <> 14313 ) and
   ( @i_operacion <> 'U' or @t_trn <> 14313 ) and 
   ( @i_operacion <> 'Q' or @t_trn <> 14113 ) 
begin
  exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141040
  return 1
end

if @i_operacion = 'I'
begin
  select @i_operacionpf = ot_operacion
  from pf_operacion_tmp
  where ot_usuario =  @s_user 
    and ot_sesion =@s_sesn 
    and ot_num_banco =@i_cuenta 
  if @@rowcount = 0
  begin
    /**  ERROR : NO EXISTE OPERACION DE PLAZO FIJO  **/
    exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 141051
    return 1
  end
end

if @i_operacion = 'C'
begin
  select @i_operacionpf = op_operacion
  from pf_operacion
  where op_num_banco = @i_cuenta 
  if @@rowcount = 0
  begin
    /**  ERROR : NO EXISTE OPERACION DE PLAZO FIJO  **/
    exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 141051
    return 141051
  end
end


/**  CONVERSION DEL NUMERO DE CUENTA AL NUMERO DE OPERACION  **/
if @i_operacion = 'I' or @i_operacion = 'C'
begin        
  /**  INSERCION DE BENEFICIARIOS EN TABLA TEMPORAL  **/
  begin tran
    /**  INSERCION DEL NUEVO BENEFICIARIO EN lAS TABLAS          **/
    /**  TEMPORALES DE BENEFICIARIOS                             **/
    insert pf_beneficiario_tmp 
        (bt_operacion,   bt_usuario,    bt_sesion,    
         bt_ente,        bt_rol,        bt_fecha_crea,
         bt_fecha_mod,   bt_tipo,       bt_condicion,
         bt_secuencia)
    values (
         @i_operacionpf, @s_user,       @s_sesn,      
         @i_ente,        @i_rol,        @s_date,  
	 @s_date,        @i_tipo,       @i_condicion,
         @i_secuencia)                
    /**  VERIFICAR SI SE INSERTO CORRECTAMENTE  **/
    if @@error <> 0
    begin
      /**  ERROR EN INSERCION DE BENEFICIARIO  ***/
      exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 143013
      return 1
    end

    commit tran
    return 0
  end

  /**  ELIMINACION DE BENEFICIARIOS  **/
  If @i_operacion = 'D'
  begin
    begin tran
      /**  ELIMINAR LOS BENEFICIARIOS DE ESA OPERACION  **/
      delete from pf_beneficiario_tmp
      where  bt_usuario   = @s_user
        and  bt_sesion    = @s_sesn
        and  bt_tipo = @i_tipo
    commit tran
    return 0
  end         

  if @i_operacion = 'U' 
  begin     
    /*********************************
    select @i_operacionpf = ot_operacion
    from   pf_operacion_tmp
    where ot_usuario =  @s_user 
      and ot_sesion =@s_sesn 
      and ot_num_banco =@i_cuenta 
    if @@rowcount = 0
    begin
      /**  ERROR : NO EXISTE OPERACION DE PLAZO FIJO  **/
      exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 141051
      return 1
    end
    *********************************/	--endoso 05/22/2000

    --Bloque cambiado para funcionalidad de endosos 05/22/2000 
	  select @i_operacionpf = op_operacion
    from   pf_operacion
    where op_num_banco =@i_cuenta 
    if @@rowcount = 0
    begin
      /**  ERROR : NO EXISTE OPERACION DE PLAZO FIJO  **/
      exec cobis..sp_cerror
             		@t_debug = @t_debug,
             		@t_file  = @t_file,
             		@t_from  = @w_sp_name,
             		@i_num   = 141051
     	return 1
    end
    
    --Bloque cambiado para funcionalidad de endosos 05/22/2000 
  
    /**  INSERCION DE BENEFICIARIOS EN TABLA TEMPORAL  **/
    begin tran
      /**  INSERCION DEL NUEVO BENEFICIARIO EN lAS TABLAS          **/
      /**  TEMPORALES DE BENEFICIARIOS                             **/
      insert pf_beneficiario_tmp 
            (bt_operacion,   bt_usuario,    bt_sesion,    
             bt_ente,        bt_rol,        bt_fecha_crea,
             bt_fecha_mod,   bt_tipo,       bt_condicion,
             bt_secuencia)
      values(
             @i_operacionpf, @s_user,       @s_sesn,      
             @i_ente,        @i_rol,        @s_date,  
	     @s_date,        @i_tipo,       @i_condicion,
             @i_secuencia)                
      
      /**  VERIFICAR SI SE INSERTO CORRECTAMENTE  **/
      if @@error <> 0
      begin
        /**  ERROR EN INSERCION DE BENEFICIARIO  ***/
        exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 143013
        return 1
      end
    commit tran
    
    return 0
  end

   
   if @i_operacion = 'Q'
   begin
      select @i_operacionpf = op_operacion 
      from pf_operacion
      where  op_num_banco = @i_cuenta 

      if @@rowcount = 0
      begin
       -- ERROR : NO EXISTE OPERACION DE PLAZO FIJO  
       exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 141051
       return 1
      end

      select 	
       'CLIENTE'=	be_ente,
       'NOMBRE'=       case when ltrim(rtrim(en_nomlar)) = '' then p_p_apellido +' '+ p_s_apellido + ' '+ en_nombre
                                     else isnull(en_nomlar,en_nombre) end,
       'CONDICION' = be_condicion,
       'IMPRIME'  = 'S',
       'ROL' = be_rol 
       from pf_beneficiario,cobis..cl_ente
        where be_operacion = @i_operacionpf
       and be_ente = en_ente  
       and be_estado = 'I'
       and be_estado_xren = 'N'
       order by be_secuencia             
   end
go



