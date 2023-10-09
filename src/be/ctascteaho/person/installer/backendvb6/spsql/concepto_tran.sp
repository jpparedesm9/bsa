/****************************************************************************/
/*  Archivo:            rem_parctocble.sp                                   */
/*  Stored procedure:   sp_concepto_tran                                   */
/*  Base de datos:      cob_remesas                                         */
/*  Producto:           Personalizacion                                     */
/****************************************************************************/
/*                                 IMPORTANTE                               */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                               PROPOSITO                                  */
/*                                                                          */
/****************************************************************************/
/*                          MODIFICACIONES                                  */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go
if exists (select
             1
           from   sysobjects
           where  name = 'sp_concepto_tran')
  drop proc sp_concepto_tran
go


SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_concepto_tran (  
    @s_ssn          int,   
    @s_srv          varchar(30)     = null, 
    @s_lsrv         varchar(30)     = null, 
    @s_user         varchar(30)     = null, 
    @s_sesn         int             = null,
    @s_term         varchar(10), 
    @s_date         datetime, 
    @s_ofi          smallint,       /* Localidad origen transaccion */ 
    @s_rol          smallint        = 1,
    @s_org_err      char(1)         = null, /* Origen de error: [A], [S] */ 
    @s_error        int             = null, 
    @s_sev          tinyint         = null, 
    @s_msg          varchar(240)    = null, 
    @s_org          char(1),        
    @t_debug        char(1)         = 'N', 
    @t_file         varchar(14)     = null, 
    @t_from         varchar(32)     = null,
    @t_rty          char(1)         = 'N', 
    @t_trn          smallint, 
    @i_operacion    char(1),   
    @i_sec          int             = 0,
    @i_causal       varchar(10)     = '0',
    @i_timpuesto    char(1)         = null, 
    @i_concepto     char(4)         = null,
    @i_producto     tinyint         = null,
    @i_base1        varchar(25)     = null,
    @i_base2        varchar(25)     = null,
    @i_contabiliza  varchar(25)     = null,
    @i_conta_antes  varchar(25)     = null,
    @i_tipoimp      char(1)         = null
) 
as declare  
   @w_return           int,
   @w_sp_name          varchar(30)


/*  Captura nombre de Stored Procedure  */ 
select  @w_sp_name = 'sp_concepto_tran'  

if  @t_trn <> 4107
begin   
   /* Error en codigo de transaccion */    
   exec cobis..sp_cerror   
   @t_debug  = @t_debug, 
   @t_file   = @t_file, 
   @t_from   = @w_sp_name, 
   @i_num    = 201048 
   return 201048 
end  


if @i_operacion = 'Q' /*Busqueda de Transacciones con Conceptos Definidos */
begin 
   select @i_sec     = isnull(@i_sec,0)
   select @i_causal  = isnull(@i_causal,'0')
   select @i_tipoimp = isnull(@i_tipoimp, '')

   set rowcount 20
   
   select 
   'Tran'        = ci_tran,
   'Descripcion' = tn_descripcion,
   'Causal'      = ci_causal,
   'Imp.'        = ci_impuesto,
   'Impuesto'    = c.valor,
   'Concepto'    = ci_concepto,
   'Prod.'       = ci_producto,
   'Producto'    = pd_descripcion,
   'Campo'       = ci_contabiliza,
   'BASE 1'      = ci_base1,
   'BASE 2'      = ci_base2
   from cob_remesas..re_concepto_imp,
       cobis..cl_ttransaccion,
       cobis..cl_producto,
       cobis..cl_catalogo c
   where  ci_tran = tn_trn_code
   and    ci_producto = pd_producto
   and  ((ci_tran = @i_sec and ci_causal > @i_causal)
    or   (ci_tran > @i_sec)
    or   (ci_tran = @i_sec and ci_causal = @i_causal and ci_impuesto > @i_tipoimp ))
   and   c.tabla in (select t.codigo from cobis..cl_tabla t
                     where t.tabla = 'cb_tipo_impuesto')     
   and   ci_impuesto = c.codigo 
   order by ci_tran, ci_causal, ci_impuesto
end


if @i_operacion = 'H'/*Busqueda de Transaccion Especifica con Conceptos Definidos */
begin 
   select 
   'Cod Tran'      = ci_tran,
   'Descripcion'   = tn_descripcion,
   'Causal'        = case ci_causal
                        when '0' then ''
                        else ci_causal
                     end,
   'Cod Impuesto'  = ci_impuesto,
   'Concepto'      = ci_concepto,
   'Cod Prod'      = ci_producto,
   'Producto'      = pd_descripcion,
   'Impuesto'      = c.valor,
   'Campo'         = ci_contabiliza,
   'BASE 1'        = ci_base1,
   'BASE 2'        = ci_base2
    from  cob_remesas..re_concepto_imp,
          cobis..cl_ttransaccion,
          cobis..cl_producto,
          cobis..cl_catalogo c,
          cobis..cl_tabla t
    where ci_tran     = @i_sec
    and   ci_tran     = tn_trn_code
    and   ci_producto = pd_producto
    and   t.tabla     = 'cb_tipo_impuesto'
    and   t.codigo    = c.tabla
    and   ci_impuesto = c.codigo 
end


if @i_operacion = 'I'/*Ingreso de Transaccion Especifica con Concepto Definido */
begin 
   if not exists ( select 1
                   from  cobis..cl_ttransaccion
                   where tn_trn_code  = @i_sec)
   begin 
      /* No existe el Banco */ 
      exec cobis..sp_cerror 
      @t_debug = @t_debug, 
      @t_file  = @t_file, 
      @t_from  = @w_sp_name, 
      @i_num   = 201048 ,
      @i_msg   = 'Error.... transaccion no existe'
      return 201048 
   end    
   
   if exists ( select 1
               from   cob_remesas..re_concepto_imp
               where  ci_tran        = @i_sec
               and    ci_causal      = isnull(@i_causal, '0')
               and    ci_impuesto    = @i_timpuesto
               and    ci_contabiliza = isnull(@i_contabiliza,'')  )
    begin 
        /* Ya existe la Transaccion */ 
        exec cobis..sp_cerror 
        @t_debug = @t_debug, 
        @t_file  = @t_file, 
        @t_from  = @w_sp_name, 
        @i_num   = 201048 ,
        @i_msg   = 'Ya existe la Transaccion'
        return 201048 
     end    

    
    insert into cob_remesas..re_concepto_imp (
    ci_tran,     ci_causal,             ci_impuesto,    ci_concepto, 
    ci_producto, ci_base1,              ci_base2,       ci_contabiliza, 
    ci_fecha)
    values  (
    @i_sec,      isnull(@i_causal,'0'), @i_timpuesto,   @i_concepto,
    @i_producto, @i_base1,              @i_base2,       isnull(@i_contabiliza, ''),
    @s_date )

    if @@error <> 0 
    begin 
       /* Error al insertar la Transaccion */ 
       exec cobis..sp_cerror 
       @t_debug  = @t_debug, 
       @t_file   = @t_file, 
       @t_from   = @w_sp_name, 
       @i_num    = 353007,
       @i_msg    = 'Error al insertar la Transaccion'
       return 353007    
    end 


    insert into cob_remesas..re_tran_servicio (
    ts_secuencial,  ts_terminal,  ts_tipo_transaccion, 
    ts_tsfecha,     ts_char1,  ts_login, 
    ts_oficina,     ts_datetime1)
    values ( 
    @s_ssn,         @s_term,      @t_trn, 
    getdate(),      @i_operacion, @s_user, 
    @s_ofi,         getdate()) 
               
    if @@error <> 0
    begin
       /* Error en creacion de registro en transaccion de servicio */
       exec cobis..sp_cerror
       @t_debug   = @t_debug,
       @t_file    = @t_file,
       @t_from    = @w_sp_name,
       @i_num     = 353515
       return 353515
    end
end

/*Ingreso de Transaccion Especifica con Concepto Definido */
if @i_operacion = 'U'
begin 
   if exists ( select 1
               from   cob_remesas..re_concepto_imp
               where  ci_tran         = @i_sec
               and    ci_causal       = isnull(@i_causal, '0')
               and    ci_impuesto     = @i_timpuesto
               and    ci_contabiliza  = isnull(@i_contabiliza,''))
   begin 
  
   
   update cob_remesas..re_concepto_imp set
   ci_concepto    = @i_concepto,
   ci_base1       = @i_base1,
   ci_base2       = @i_base2,
   ci_contabiliza = isnull(@i_contabiliza, ''),
   ci_fecha       = @s_date
   where  ci_tran         = @i_sec
   and    ci_causal       = isnull(@i_causal,'0')
   and    ci_impuesto     = @i_timpuesto 
   and    ci_contabiliza  = isnull(@i_conta_antes,'')

   if @@error <> 0 
   begin 
      /* Error al insertar la Transaccion */ 
      exec cobis..sp_cerror 
      @t_debug = @t_debug, 
      @t_file  = @t_file, 
      @t_from  = @w_sp_name, 
      @i_num   = 353007,
      @i_msg   = 'Error al Actualizar la Transaccion'
      return 353007    
   end 

   insert into cob_remesas..re_tran_servicio (
   ts_secuencial, ts_terminal, ts_tipo_transaccion, 
   ts_tsfecha,    ts_char1,    ts_login, 
   ts_oficina,    ts_datetime1)
   values ( 
   @s_ssn,        @s_term,      @t_trn, 
   getdate(),     @i_operacion, @s_user, 
   @s_ofi,        getdate()) 
               
   if @@error <> 0
   begin
      /* Error en creacion de registro en transaccion de servicio */
      exec cobis..sp_cerror
      @t_debug   = @t_debug,
      @t_file    = @t_file,
      @t_from    = @w_sp_name,
      @i_num     = 353515
      return 353515
   end
end 
end


/* Eliminar de Transaccion Especifica con Concepto Definido */
if @i_operacion = 'D'
begin 
   if not exists ( select 1
                   from cob_remesas..re_concepto_imp
                   where  ci_tran         = @i_sec
                   and    ci_causal       = isnull(@i_causal, '0')
                   and    ci_impuesto     = @i_timpuesto 
                   and    ci_contabiliza  = isnull(@i_contabiliza, ''))
   begin 
      exec cobis..sp_cerror 
      @t_debug = @t_debug, 
      @t_file  = @t_file, 
      @t_from  = @w_sp_name, 
      @i_num   = 201048 ,
      @i_msg   = 'No existe la Transaccion a Eliminar'
      return 201048 
   end    


    
   delete cob_remesas..re_concepto_imp
   where  ci_tran         = @i_sec
   and    ci_causal       = isnull(@i_causal, '0')
   and    ci_impuesto     = @i_timpuesto 
   and    ci_contabiliza  = @i_contabiliza

    if @@error <> 0 
    begin 
       /* Error al insertar la Transaccion */ 
       exec cobis..sp_cerror 
       @t_debug     = @t_debug, 
       @t_file  = @t_file, 
       @t_from  = @w_sp_name, 
       @i_num   = 353007,
       @i_msg   = 'Error al Elimiinar la Transaccion'
       return 353007    
    end 
    
    insert into cob_remesas..re_tran_servicio (
    ts_secuencial, ts_terminal, ts_tipo_transaccion, ts_tsfecha, ts_char1,
    ts_login,    ts_oficina,  ts_datetime1)
    values ( 
    @s_ssn,        @s_term,     @t_trn,              getdate(),  @i_operacion,
    @s_user,       @s_ofi,      getdate()) 
               
    if @@error <> 0
    begin
       /* Error en creacion de registro en transaccion de servicio */
       exec cobis..sp_cerror
       @t_debug   = @t_debug,
       @t_file    = @t_file,
       @t_from    = @w_sp_name,
       @i_num     = 353515
       return 353515
    end
end
return 0


GO


