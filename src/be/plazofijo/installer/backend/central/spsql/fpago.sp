/************************************************************************/
/*  Archivo               : fpago.sp                                    */
/*  Stored procedure      : sp_fpago                                    */
/*  Base de datos         : cob_pfijo                                   */
/*  Producto              : Plazo_fijo                                  */
/*  Disenado por          : Carolina Alvarado                           */
/*  Fecha de documentacion: 08/Ago/95                                   */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA', representantes exclusivos para el Ecuador de la          */
/*   'NCR CORPORATION'.                                                 */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/*                           PROPOSITO                                  */
/*   Este programa procesa el mantenimiento de la tabla pf_fpago        */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*   FECHA        AUTOR              RAZON                              */
/*   12-Oct-99    M. Cartagena       Se agrega la columna transito      */
/*   13-Jun-2016  N. Silva           Porting DAVIVIENDA                 */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_fpago')
   drop proc sp_fpago
go

create proc sp_fpago (
@s_ssn                  int         = null,
@s_user                 login       = null,
@s_term                 varchar(30) = null,
@s_date                 datetime    = null,
@s_srv                  varchar(30) = null,
@s_lsrv                 varchar(30) = null,
@s_ofi                  smallint    = null,
@s_rol                  smallint    = null,
@t_debug                char(1)     = 'N',
@t_file                 varchar(10) = null,
@t_from                 varchar(32) = null,
@t_trn                  smallint    = null,
@i_operacion            char(1),
@i_tipo                 char(1)     = null,
@i_tipo_fpago           int         = null,
@i_producto             tinyint     = 0,
@i_descripcion          varchar (30)= null,
@i_mnemonico            catalogo    = null,
@i_ttransito            smallint    = null,
@i_automatico           char(1)     = 'N',
@i_modo                 smallint    = 0,
@i_compensa             char(1)     = 'N',
@i_area_contable        int         = null, -- GES 08/28/01 CUZ-027-028 
@i_fp_pago_recep        char(1)     = null, -- GAR 15-feb-2005 GB
@i_valor                char(20)    = null,
@i_empresa              tinyint     = 1,
@i_exonera_gmf          char(1)     = 'N')
with encryption
as
declare
@w_sp_name              varchar(32),
@w_descripcion          varchar(30),
@w_mnemonico            varchar(4),
@w_ttransito            smallint,
@w_return               int,
@w_automatico           char(1),
@w_producto             tinyint,
@w_fecha_crea           datetime,
@w_fecha_mod            datetime,
@w_estado               char(1),
@w_codigo               char(1),
@w_tipo_fpago           int,
@w_compensa             char(1),
@w_area_contable        int,       
@v_descripcion          varchar(30),
@v_producto             tinyint,
@v_mnemonico            varchar(4),
@v_ttransito            smallint,
@v_automatico           char(1),  
@v_fecha_mod            datetime,
@v_compensa             char(1),  
@v_area_contable        int,
@w_error                int,
@w_exonera_gmf          char(1)

select @w_sp_name = 'sp_fpago'

if (@t_trn <> 14132 and @i_operacion  = 'I') or
   (@t_trn <> 14232 and @i_operacion  = 'U') or
   (@t_trn <> 14330 and @i_operacion  = 'D') or
   (@t_trn <> 14532 and @i_operacion  = 'S') or
   (@t_trn <> 14432 and @i_operacion  = 'Q') or
   (@t_trn <> 14632 and @i_operacion  = 'H') 
begin
   select @w_error = 141040
   GOTO ERROR
end

-- Insert --
if @i_operacion = 'I'
begin
    if exists (select fp_tipo_fpago 
               from pf_fpago
               where fp_mnemonico = @i_mnemonico
                 and fp_estado ='A')
    begin
       select @w_error = 141110
       GOTO ERROR
    end

    begin tran
  
    exec @w_return = cobis..sp_cseqnos
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_tabla = 'pf_fpago',
            @o_siguiente = @w_tipo_fpago out
    if @w_return <> 0
        return @w_return

    insert into pf_fpago  
           (fp_tipo_fpago,    fp_descripcion,   fp_mnemonico, fp_ttransito,  fp_automatico,
            fp_fecha_crea,    fp_fecha_modi,    fp_producto,  fp_estado,     fp_compensa,
            fp_area_contable, fp_pago_recep,    fp_exonera_gmf)
    values (@w_tipo_fpago,    @i_descripcion,   @i_mnemonico, @i_ttransito,  @i_automatico,
            @s_date,          @s_date,          @i_producto,  'A',           @i_compensa,
            @i_area_contable, @i_fp_pago_recep, @i_exonera_gmf)

    if @@error <> 0
    begin
       select @w_error = 143018
       GOTO ERROR
    end


    insert into ts_fpago 
           (secuencial,    tipo_transaccion, clase,        fecha,
            usuario,       terminal,         srv,          lsrv,
            tipo_fpago,    descripcion,      mnemonico,    ttransito,
            automatico,    fecha_crea,       fecha_modi,   estado,
            producto,      compensa,         area_contable) 
    values (@s_ssn,        @t_trn,           'N',          @s_date,
            @s_user,       @s_term,          @s_srv,       @s_lsrv,
            @w_tipo_fpago, @i_descripcion,   @i_mnemonico, @i_ttransito,
            @i_automatico, @s_date,          @s_date,      'A',
            @i_producto,   @i_compensa,      @i_area_contable)

   if @@error <> 0
   begin
      select @w_error = 143005
      GOTO ERROR
   end
   commit tran
  
   return 0
end

--- Update ---
if @i_operacion = 'U'
begin
    select @w_descripcion   = fp_descripcion,
           @w_ttransito     = fp_ttransito,
           @w_producto      = fp_producto,
           @w_automatico    = fp_automatico,
           @w_fecha_mod     = fp_fecha_modi,
           @w_compensa      = fp_compensa,
           @w_area_contable = fp_area_contable,
           @w_exonera_gmf   = fp_exonera_gmf
    from pf_fpago
    where fp_tipo_fpago = @i_tipo_fpago 
      and fp_estado     = 'A'
    
    if @@rowcount = 0
    begin
       select @w_error = 141111
       GOTO ERROR   
    end
      
    select @v_descripcion   = @w_descripcion,
           @v_ttransito     = @w_ttransito,
           @v_producto      = @w_producto,
           @v_automatico    = @w_automatico,
           @v_fecha_mod     = @w_fecha_mod,
           @v_compensa      = @w_compensa,
           @v_area_contable = @w_area_contable

    if @w_compensa = @i_compensa
       select @w_compensa = null, @v_compensa = null
    else
       select @w_compensa = @i_compensa

    if @w_descripcion = @i_descripcion
      select @w_producto = null, @v_producto = null
    else
      select @w_producto = @i_producto

    if @w_descripcion = @i_descripcion
       select @w_descripcion = null, @v_descripcion = null
    else
       select @w_descripcion = @i_descripcion
                          
    if @w_ttransito = @i_ttransito
       select @w_ttransito = null, @v_ttransito = null
    else
       select @w_ttransito = @i_ttransito
  
    if @w_automatico = @i_automatico
       select @w_automatico = null, @v_automatico = null
    else
       select @w_automatico = @i_automatico

    if @w_fecha_mod = @s_date
       select @w_fecha_mod = null, @v_fecha_mod = null
    else
       select @w_fecha_mod = @s_date  

    if @w_area_contable = @i_area_contable
       select @w_area_contable = null, @v_area_contable = null
    else
       select @w_area_contable = @i_area_contable   

    begin tran

    update pf_fpago
    set fp_descripcion   = @i_descripcion,
        fp_ttransito     = @i_ttransito,
        fp_automatico    = @i_automatico,
        fp_producto      = @i_producto,
        fp_fecha_modi    = @s_date,
        fp_compensa      = @i_compensa,         
        fp_area_contable = @i_area_contable,  
        fp_pago_recep    = @i_fp_pago_recep,
        fp_exonera_gmf   = @i_exonera_gmf 
    where fp_tipo_fpago  = @i_tipo_fpago 
      and fp_estado      = 'A' 
    
    if @@rowcount <> 1
    begin
       select @w_error = 145018
       GOTO ERROR
    end 
   
    /* transaccion servicio - fpago con los datos anteriores */  
    insert into ts_fpago 
           (secuencial,    tipo_transaccion, clase,        fecha,
            usuario,       terminal,         srv,          lsrv,
            tipo_fpago,    descripcion,      mnemonico,    ttransito,
            automatico,    fecha_crea,       fecha_modi,   estado,
            producto,      compensa,         area_contable) 
    values (@s_ssn,        @t_trn,           'P',          @s_date,
            @s_user,       @s_term,          @s_srv,       @s_lsrv,
            @i_tipo_fpago, @v_descripcion,   null,         @v_ttransito,
            @v_automatico, null,             @v_fecha_mod, null,
            @v_producto,   @v_compensa,      @v_area_contable)

    if @@error <> 0 
    begin
       select @w_error = 143005
       GOTO ERROR 
    end 

    /* transaccion de servicio - fpago con los datos modificados */
    insert into ts_fpago 
           (secuencial,    tipo_transaccion, clase,        fecha,
            usuario,       terminal,         srv,          lsrv,
            tipo_fpago,    descripcion,      mnemonico,    ttransito,
            automatico,    fecha_crea,       fecha_modi,   estado,
            producto,      compensa,         area_contable) 
    values (@s_ssn,        @t_trn,           'A',          @s_date,
            @s_user,       @s_term,          @s_srv,       @s_lsrv,
            @i_tipo_fpago, @w_descripcion,   null,         @w_ttransito,
            @w_automatico, null,             @w_fecha_mod, null,
            @w_producto,   @w_compensa,      @w_area_contable)
    
    if @@error <> 0 
    begin
       select @w_error = 143005
       GOTO ERROR 
    end 

    commit tran
    return 0
  
end 


--- Delete ---
if @i_operacion = 'D'
begin
   select @w_descripcion   = fp_descripcion,
          @w_mnemonico     = fp_mnemonico,
          @w_ttransito     = fp_ttransito,
          @w_producto      = fp_producto,
          @w_fecha_crea    = fp_fecha_crea,
          @w_fecha_mod     = fp_fecha_modi,
          @w_estado        = fp_estado,
          @w_compensa      = fp_compensa,
          @w_area_contable = fp_area_contable,
          @w_exonera_gmf   = fp_exonera_gmf 
   from pf_fpago
   where fp_tipo_fpago = @i_tipo_fpago 
     and fp_estado     = 'A' 

   if @@rowcount = 0
   begin
      select @w_error = 141111
      GOTO ERROR 
   end

   begin tran

   update pf_fpago 
   set fp_estado = 'E'
   where fp_tipo_fpago = @i_tipo_fpago 
    
   if @@rowcount <> 1
   begin
      select @w_error = 147018
      GOTO ERROR   
   end 
   
    insert into ts_fpago 
           (secuencial,    tipo_transaccion, clase,        fecha,
            usuario,       terminal,         srv,          lsrv,
            tipo_fpago,    descripcion,      mnemonico,    ttransito,
            automatico,    fecha_crea,       fecha_modi,   estado,
            producto,      compensa,         area_contable) 
    values (@s_ssn,        @t_trn,           'B',          @s_date,
            @s_user,       @s_term,          @s_srv,       @s_lsrv,
            @i_tipo_fpago, @w_descripcion,   @w_mnemonico, @w_ttransito,
            @w_automatico, @w_fecha_crea,    @w_fecha_mod, @w_estado,
            @w_producto,   @w_compensa,      @w_area_contable)

    if @@error <> 0 
    begin
       select @w_error = 143005
       GOTO ERROR   
   end 
   
   commit tran
   return 0

end 

--- Search ---
if @i_operacion = 'S'
begin 

     set rowcount 20
     select @i_mnemonico = case @i_modo 
                              when 0 then ''
                              else @i_mnemonico
                           end 

     select 'CODIGO'           = fp_mnemonico,
            'DESCRIPCION'      = substring(fp_descripcion,1,30),
            'DIAS TRANSITO'    = fp_ttransito,
            'TIPO'             = fp_automatico,
            'PRODUCTO COBIS'   = fp_producto,
            'SECUENCIAL'       = fp_tipo_fpago,
            'AREA CONTABLE'    = fp_area_contable, 
            'COMPENSA'         = fp_compensa,
            'CATEGORIA'        = fp_pago_recep,
            'EXONERA GMF'      = fp_exonera_gmf
       from pf_fpago
      where fp_estado = 'A'
        and fp_mnemonico > @i_mnemonico
      order by fp_mnemonico

     set rowcount 0 
     return 0   
end 


--- Query ---
if @i_operacion = 'Q'
begin 
     select fp_mnemonico, 
            substring(fp_descripcion,1,30),
            fp_ttransito,
            fp_automatico,
            fp_producto,
            fp_area_contable,        
            fp_compensa,
            fp_pago_recep,
            fp_exonera_gmf
     from  pf_fpago
     where fp_tipo_fpago = @i_tipo_fpago 
       and fp_estado     = 'A'
     
     if @@rowcount <> 1
     begin
        select @w_error = 141111
        GOTO ERROR   
     end

     return 0
end


--- Help ---
if @i_operacion = 'H'
begin

  set rowcount 20

  select @i_tipo_fpago = case @i_modo 
                           when 0 then 0
                           else @i_tipo_fpago
                         end 
  if @i_tipo = 'A'
  begin
     select 'F. PAGO/RECEPCION'= fp_mnemonico,
            'DESCRIPCION'      = substring(fp_descripcion,1,30),
            'T. TRANSITO'      = fp_ttransito,
            'REQ. CTA'         = fp_automatico,
            'PROD. COBIS'      = fp_producto,
            'COD.'             = fp_tipo_fpago,
            'AREA CONTABLE'    = fp_area_contable,  
            'COMPENSA'         = fp_compensa,
            'CONDICION'        = fp_pago_recep,
            'EXONERA GMF'      = fp_exonera_gmf      
       from pf_fpago
      where fp_estado     = 'A'
        and (fp_pago_recep in (isnull(@i_fp_pago_recep,'A'),'A') or @i_fp_pago_recep is null)
        and fp_tipo_fpago > @i_tipo_fpago
      order by fp_tipo_fpago
      return 0
   end
 
   if @i_tipo = 'B'
   begin
      select 'F. PAGO/RECEPCION' = fp_mnemonico,
             'DESCRIPCION'       = substring(fp_descripcion,1,30),
             'T. TRANSITO'       = fp_ttransito,
             'REQ. CTA'          = fp_automatico,
             'PROD. COBIS'       = fp_producto,
             'COD.'              = fp_tipo_fpago,
             'AREA CONTABLE'     = fp_area_contable,  
             'COMPENSA'          = fp_compensa,
             'CONDICION'         = fp_pago_recep,
             'EXONERA GMF'       = fp_exonera_gmf 
        from pf_fpago
       where fp_estado = 'A'
         and fp_tipo_fpago > @i_tipo_fpago
         and fp_descripcion like @i_valor
       order by fp_tipo_fpago
      return 0 
   end

   if @i_tipo = 'V'
   begin
        select substring(fp_descripcion,1,30),
               fp_ttransito,
               fp_automatico,
               fp_producto,
               fp_area_contable,  
               fp_compensa,
               fp_pago_recep,
               fp_exonera_gmf     
          from pf_fpago
         where fp_mnemonico  = @i_mnemonico  
           and fp_estado     = 'A'
           and (fp_pago_recep in (isnull(@i_fp_pago_recep,'A'),'A') or @i_fp_pago_recep is null)
    
        if @@rowcount = 0
        begin
           select @w_error = 141111
           GOTO ERROR
        end
    end


    if @i_tipo = 'R' --areas contables
    begin

       select @i_area_contable = case @i_modo 
                                   when 0 then 0
                                   else @i_area_contable
                                 end  


       select top 20 
              'Area'        = ar_area,
              'Descripción' = ar_descripcion
       from cob_conta..cb_area
       where ar_empresa    = @i_empresa    
         and ar_estado     = 'V'
         and ar_movimiento = 'S'
         and ar_area       > @i_area_contable
       order by ar_area

       if @@rowcount = 0
       begin
          select @w_error = 143005
          GOTO ERROR   
       end
    end

    if @i_tipo = 'P' --productos cobis
    begin

       select @i_producto = case @i_modo 
                              when 0 then 0
                              else @i_producto
                            end  

       select top 20
              'Producto'    = pd_producto,
              'Tipo'        = pd_tipo,
              'Descripción' = pd_descripcion,
              'Abreviatura' = pd_abreviatura
       from cobis..cl_producto
       where pd_estado = 'V'
         and pd_producto > @i_producto
       order by pd_producto, pd_tipo

       if @@rowcount = 0
       begin
          select @w_error = 141111
          GOTO ERROR   
       end
    end

    set rowcount 0 
    return 0   

end

ERROR:
   exec cobis..sp_cerror
        @t_debug      = @t_debug,
        @t_file       = @t_file,
        @t_from       = @w_sp_name,
        @i_num        = @w_error
   return @w_error

go

