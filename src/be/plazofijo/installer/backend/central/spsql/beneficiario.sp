/************************************************************************/
/*      Archivo:                benefdef.sp                             */
/*      Stored procedure:       sp_beneficiario                         */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
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
/*      Este programa procesa las transacciones de INSERT, UPDATE,      */
/*      DELETE, QUERY y HELP a la tabla de beneficiarios de los         */
/*      Plazos Fijos.                                                   */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR            RAZON                               */
/*      24-Oct-94  Ricardo Valencia Creacion                            */
/*      24-Nov-94  Ricardo Valencia Revision por nuevas especificaciones*/
/*      02-Ago-95  Por terminar                                         */ 
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_beneficiario')
   drop proc sp_beneficiario
go

create proc sp_beneficiario (
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_term                 varchar(30)     = NULL, 
@s_date                 datetime        = NULL,
@s_sesn                 int             = NULL,
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
@i_ente                 int             = NULL,
@i_estado_xren          char(1)         = 'N', 
@i_rol                  catalogo        = 'T',
@i_formato_fecha        int             = 0,
@i_tipo                 char(1)         = 'T',
@i_condicion            char(1)         = 'O',
@i_secuencia            smallint        = NULL--Para ordernar los beneficiarios de acuerdo a lo ingresado en el grid
)
with encryption
as
declare
      @w_operacionpf          int,
      @w_sp_name              varchar(32),
      @w_ente                 int,
      @w_titular              int,
      @w_rol                  catalogo,
      @w_fecha_crea           datetime,
      @w_fecha_mod            datetime,
      @w_num_banco            cuenta,
      @w_condicion            tinyint,
      @w_descripcion          varchar(64),
      @w_direccion            int,
      @w_telefono             varchar(10), 
      @v_operacionpf          int,
      @v_ente                 int,
      @v_rol                  catalogo,
      @v_fecha_crea           datetime,
      @v_fecha_mod            datetime,
      @o_operacionpf          int,
      @o_ente                 int,
      @o_rol                  catalogo,
      @o_fecha_crea           datetime,
      @o_fecha_mod            datetime

select @w_sp_name = 'sp_beneficiario'

/**  VERIFICAR CODIGO DE TRANSACCION  **/
if ( @i_operacion <> 'I' or @t_trn <> 14109) and
   ( @i_operacion <> 'D' or @t_trn <> 14309) and
   ( @i_operacion <> 'U' or @t_trn <> 14209) and
   ( @i_operacion <> 'Q' or @t_trn <> 14409) and
   ( @i_operacion <> 'S' or @t_trn <> 14509) and 
   ( @i_operacion <> 'C' or @t_trn <> 14945) and 
   ( @i_operacion <> 'T' or @t_trn <> 14945) and
   ( @i_operacion <> 'B' or @t_trn <> 14945)
begin
  exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141040
  return 1
end

  
/**  CONVERSION DEL NUMERO DE CUENTA AL NUMERO DE OPERACION  **/
select @w_operacionpf = op_operacion
from   pf_operacion
where  op_num_banco = @i_cuenta

if @@rowcount = 0
begin
  exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141051  /** No existe operacion de pf **/
  return 1
end

if @i_operacion = 'B'
begin
  delete pf_beneficiario 
   where be_operacion = @w_operacionpf
     and be_tipo      = @i_tipo
end

if @i_operacion = 'T'
begin
  select @w_titular = be_ente,
         @w_descripcion = en_nomlar,
         @w_direccion = di_direccion,
         @w_telefono = te_valor
    from pf_beneficiario,
         cobis..cl_ente,
         cobis..cl_direccion,
         cobis..cl_telefono
   where be_operacion = @w_operacionpf
     and be_rol = 'T'
     and be_ente = en_ente
     and en_ente = di_ente
     and di_direccion = 1
     and di_ente = te_ente 
     and di_direccion =te_direccion
     and be_tipo = @i_tipo

  update pf_operacion 
     set op_ente = @w_titular,
         op_descripcion = @w_descripcion,
         op_direccion = @w_direccion,
         op_telefono = @w_telefono
   where op_operacion = @w_operacionpf
end
   
/**  INSERCION Y ACTUALIZACION DE BENEFICIARIOS  **/
If @i_operacion in ('I','U','C')
begin
  /**  VERIFICAR EXISTENCIA DEL ENTE  **/
  if not exists ( select * from  cobis..cl_ente
                  where en_ente = @i_ente )
  begin
    exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 141050
    return 1
  end

  /** CARGADO DE VALORES PARA TRANSACCIONES DE SERVICIO DE ACTUALIZACION  **/
  if @i_operacion = 'U'
  begin
    select @w_rol         = be_rol
      from pf_beneficiario
     where be_operacion   = @w_operacionpf
       and be_ente        = @i_ente
       and be_tipo        = @i_tipo
  
    select @v_rol         = @w_rol,
           @v_fecha_crea  = NULL,
           @v_fecha_mod   = @s_date,
           @w_fecha_crea  = NULL,
           @w_fecha_mod   = @s_date
            
    if @w_rol = @i_rol
      select @w_rol = NULL, @v_rol = NULL
    else
      select @w_rol = @i_rol
  end
  
  /**  INSERCION DEL NUEVO BENEFICIARIO Y SUS TRANSACCIONES DE SERVICIO  **/
  begin tran
    if @i_operacion = 'I'
    begin
      insert pf_beneficiario 
            (be_operacion,   be_ente,        be_tipo,
             be_rol,         be_estado,      be_fecha_crea,
             be_fecha_mod,   be_estado_xren, be_condicion,
             be_secuencia)
      values(@w_operacionpf, @i_ente,        @i_tipo,
             @i_rol,         'I',            @s_date,
             @s_date,        @i_estado_xren, @i_condicion,
             @i_secuencia)
   
      if @@error <> 0
      begin
        exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 143009
        return 1
      end
            
      insert ts_beneficiario 
           (secuencial, tipo_transaccion, clase,
            usuario,    terminal,         srv,
            lsrv,       fecha,            operacion,
            ente,       
            rol,        fecha_crea,       fecha_mod)
      values (@s_ssn,     @t_trn,           'N',
            @s_user,    @s_term,          @s_srv,
            @s_lsrv,    @s_date,          @w_operacionpf,
            @i_ente,    
            @i_rol,     @s_date,          @s_date)
   
      if @@error <> 0
      begin
        exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 143005
        return 1
      end
    end

    if @i_operacion = 'C'
    begin
       insert pf_beneficiario 
             (be_operacion,   be_ente,          be_tipo,
              be_rol,         be_estado,        be_fecha_crea,
              be_fecha_mod,   be_estado_xren,   be_condicion,
              be_secuencia)
      values (@w_operacionpf, @i_ente,          @i_tipo,   
              @i_rol,         'I',              @s_date,
              @s_date,        @i_estado_xren,   @i_condicion,
              @i_secuencia)
   
      if @@error <> 0
      begin
        exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 143009
        return 1
      end
            
      insert ts_beneficiario 
             (secuencial, tipo_transaccion, clase,
              usuario,    terminal,         srv,
              lsrv,       fecha,            operacion,
              ente,       
              rol,        fecha_crea,       fecha_mod)
      values (@s_ssn,     @t_trn,           'N',
              @s_user,    @s_term,          @s_srv,
              @s_lsrv,    @s_date,          @w_operacionpf,
              @i_ente,    
              @i_rol,     @s_date,          @s_date)
      if @@error <> 0
      begin
        exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 143005
        return 1
      end
    end
             
    if @i_operacion = 'U'
    begin
      /**  ACTUALIZAR LOS DATOS DEL BENEFICIARIO  **/
      update pf_beneficiario 
      set be_rol        = @i_rol,
          be_fecha_mod  = @s_date
      where be_operacion  = @w_operacionpf
        and be_ente       = @i_ente
        and be_tipo       = @i_tipo
      if @@error <> 0
      begin
        exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 145009
        return 1
      end
         
      insert ts_beneficiario 
            (secuencial, tipo_transaccion, clase,
             usuario,    terminal,         srv,
             lsrv,       fecha,            operacion,
             ente,       
             rol,        fecha_crea,       fecha_mod)
      values (@s_ssn,     @t_trn,           'P',
              @s_user,    @s_term,          @s_srv,
              @s_lsrv,    @s_date,          @w_operacionpf,
              @i_ente,    
              @v_rol,     @v_fecha_crea,    @v_fecha_mod)
      
      if @@error <> 0
      begin
        exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 143005
        return 1
      end
               
      insert ts_beneficiario 
             (secuencial, tipo_transaccion, clase,
             usuario,    terminal,         srv,
             lsrv,       fecha,            operacion,
             ente,       
             rol,        fecha_crea,       fecha_mod)
      values (@s_ssn,     @t_trn,           'A',
             @s_user,    @s_term,          @s_srv,
             @s_lsrv,    @s_date,          @w_operacionpf,
             @i_ente,    
             @w_rol,     @w_fecha_crea,    @w_fecha_mod)
      
      if @@error <> 0
      begin
        exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 143005
        return 1
      end
    end   

    /**  SI EL BENEFICIARIO ES TITULAR ACTUALIZAR ESE DATO EN TABLA  **/
    /**  DE OPERACIONES                                              **/
    if @i_rol = 'T' and @i_tipo = 'T' and @i_estado_xren = 'N'
    begin
      update pf_operacion
      set op_ente = @i_ente
      where op_operacion = @w_operacionpf
       
      if @@error <> 0
      begin
        exec cobis..sp_cerror
                   @t_debug = @t_debug,
                   @t_file  = @t_file,
                   @t_from  = @w_sp_name,
                   @i_num   = 145009
        return 1
      end
    end
       
    commit tran
    return 0
  end

  /**  ELIMINACION DE BENEFICIARIOS  **/
  If @i_operacion = 'D'
  begin
    select   @w_rol        = be_rol,
             @w_fecha_crea = be_fecha_crea,
             @w_fecha_mod  = be_fecha_mod
    from   pf_beneficiario
    where  be_operacion  = @w_operacionpf
      and  be_ente       = @i_ente
      and  be_tipo       = @i_tipo
    if @@rowcount = 0   
    begin
      exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 141044
      return 1
    end
      
    /**  VERIFICAR SI EL BENEFICIARIO ES TITULAR  **/
    if @w_rol = 'T'
    begin
      /**  ERROR : BENEFICIARIO NO PUEDE ELIMINARSE PORQUE ES TITULAR  **/
      exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 141060
      return 1
    end
      
    begin tran
      delete from pf_beneficiario
       where be_operacion = @w_operacionpf
         and be_ente      = @i_ente
         and be_tipo      = @i_tipo
      if @@error <> 0
      begin
        exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 147013
        return 1
      end
                     
      insert ts_beneficiario 
                (secuencial, tipo_transaccion, clase,
                 usuario,    terminal,         srv,
                 lsrv,       fecha,            operacion,
                 ente,       
                 rol,        fecha_crea,       fecha_mod)
      values (@s_ssn,     @t_trn,           'B',
                 @s_user,    @s_term,          @s_srv,
                 @s_lsrv,    @s_date,          @w_operacionpf,
                 @i_ente,    
                 @w_rol,     @w_fecha_crea,    @w_fecha_mod)
         
      if @@error <> 0
      begin
        exec cobis..sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 143005
        return 1
      end

      set rowcount 0
      commit tran
      return 0
    end                 
           
    /**  CONSULTA (QUERY) DE UN BENEFICIARIO  **/
    If @i_operacion = 'Q'
    begin
      /**  VERIFICAR EXISTENCIA DEL BENEFICIARIO  **/
      select 
             @o_rol         = be_rol,
             @o_fecha_crea  = be_fecha_crea,
             @o_fecha_mod   = be_fecha_mod
      from   pf_beneficiario
      where  be_operacion   = @w_operacionpf
        and  be_ente        = @i_ente
        and  be_tipo        = @i_tipo
      if @@rowcount = 0   
      begin
        exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 141044
        return 1
      end


      select @w_operacionpf,       
             @i_ente,              
             @o_rol,               
             convert(char(10),@o_fecha_crea,@i_formato_fecha),
             convert(char(10),@o_fecha_mod,@i_formato_fecha)
             /* GESCY2K B205 */
      return 0
    end

    /**  BUSQUEDA (SEARCH) DE BENEFICIARIOS. EN ESTE PROGRAMA NO SE CONTROLA  **/
    /**  ACCESOS DE 20 EN 20 PORQUE NO SE ESPERAN MAS DE 20 BENEFICIARIOS     **/
    /**  POR CADA OPERACION DE PLAZO FIJO                                     **/
    If @i_operacion = 'S'
    begin
      select 'Rol'        = be_rol,
             'Ente'       = be_ente,
             'Nombre'     = p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre,
             'Cedula/RUC' = en_ced_ruc,
             'Condicion'  = be_condicion
       from pf_beneficiario, cobis..cl_ente
      where be_operacion  = @w_operacionpf
        and be_ente       = en_ente
        and be_tipo       = @i_tipo
      order by be_rol desc

      if @@rowcount = 0   
      begin
        exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141044
        return 1
      end
      
      return 0   
    end
return 0
go
