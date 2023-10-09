/************************************************************************/
/*  Archivo               : plazo.sp                                    */
/*  Stored procedure      : sp_plazo                                    */
/*  Base de datos         : cob_pfijo                                   */
/*  Producto              : Plazo_fijo                                  */
/*  Disenado por          : Miryam Davila                               */
/*  Fecha de documentacion: 31/Oct/94                                   */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                          PROPOSITO                                   */
/*  Este programa procesa el mantenimiento de la tabla pf_plazo         */
/*  Insercion de pf_plazo                                               */
/*  Actualizacion de pf_plazo                                           */
/*  Eliminacion de pf_plazo                                             */
/*  Search de la tabla pf_plazo                                         */
/*  Query sobre pf_plazo                                                */
/*  Help a la tabla pf_plazo                                            */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA           AUTOR              RAZON                            */
/*  31/Oct/1994     R. Serrano         Emision Inicial                  */
/*  09/Nov/1994     J. Lam             Consistencia                     */
/*  01/May/2010     N. Silva           Cambios PROMERICA                */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_plazo')
   drop proc sp_plazo
go

create proc sp_plazo (
       @s_ssn                  int          = null,
       @s_user                 login        = null,
       @s_term                 varchar(30)  = null,
       @s_date                 datetime     = null,
       @s_srv                  varchar(30)  = null,
       @s_lsrv                 varchar(30)  = null,
       @s_ofi                  smallint     = null,
       @s_rol                  smallint     = null,
       @t_debug                char(1)      = 'N',
       @t_file                 varchar(10)  = null,
       @t_from                 varchar(32)  = null,
       @t_trn                  smallint     = null,
       @i_operacion            char(1),
       @i_tipo                 char(1)      = null,
       @i_tipo_plazo           int          = null,
       @i_mnemonico            catalogo     = null,
       @i_plazo_contable       catalogo     = null,
       @i_descripcion          varchar(30)  = null,
       @i_plazo_min            smallint     = null,
       @i_plazo_max            smallint     = null,
       @i_modo                 smallint     = 0,
       @i_valor                char(20)     = null
)
with encryption
as
declare @w_sp_name              varchar(32),
        @w_descripcion          varchar(30),
        @w_mnemonico            catalogo,
        @w_plazo_contable       catalogo,
        @w_return                int,
        @w_plazo_min            smallint,
        @w_plazo_max            smallint, 
        @w_fecha_crea           datetime,
        @w_fecha_mod            datetime,
        @w_codigo                char(1),
        @w_tipo_plazo           int,
        @v_descripcion          varchar(30),
        @v_plazo_contable       catalogo,
        @v_plazo_min            smallint,
        @v_plazo_max            smallint,
        @v_fecha_mod            datetime,
        @w_tipo_deposito        int,
        @w_moneda               tinyint,
        @w_msg                  varchar(120),
        @w_error                int

select @w_sp_name = 'sp_plazo'


if @i_operacion  not in  ('I','U','S','Q','H','D')
begin
   select @w_error = 141008
   GOTO ERROR
end

if (@i_operacion = 'I' and @t_trn <> 14114) or
   (@i_operacion = 'U' and @t_trn <> 14214) or
   (@i_operacion = 'D' and @t_trn <> 14314) or
   (@i_operacion = 'Q' and @t_trn <> 14414) or
   (@i_operacion = 'S' and @t_trn <> 14514) or
   (@i_operacion = 'H' and @t_trn <> 14614) 
begin
   select @w_error = 141040
   GOTO ERROR 
end 

--Insert--
if @i_operacion = 'I'
begin


    if exists (select pl_mnemonico from pf_plazo
               where pl_mnemonico = @i_mnemonico)
    begin
       select @w_error = 141041
       GOTO ERROR 
    end

    /* Verificar que el rango de plazos a insertar no se encuentre dentro de uno que ya exista */

    /*select @w_codigo = null  from pf_plazo
      where ((@i_plazo_min >= pl_plazo_min and @i_plazo_min <= pl_plazo_max) or
             (@i_plazo_max <= pl_plazo_max and @i_plazo_max >= pl_plazo_min))

      if @@rowcount <> 0
      begin
         exec cobis..sp_cerror
              @t_debug      = @t_debug,
              @t_file       = @t_file,
              @t_from       = @w_sp_name,
              @i_num        = 141073
         return 1
      end
     */ 

    begin tran
  
    exec @w_return = cobis..sp_cseqnos
         @t_debug  = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_tabla  = 'pf_plazo',
         @o_siguiente = @w_tipo_plazo out

    if @w_return <> 0
        return @w_return

    insert into pf_plazo  
          (pl_tipo_plazo,
           pl_mnemonico,
           pl_plazo_contable,
           pl_descripcion,
           pl_plazo_min,
           pl_plazo_max,
           pl_fecha_crea,
           pl_fecha_mod)
    values(@w_tipo_plazo,
           @i_mnemonico,
           @i_plazo_contable,
           @i_descripcion,
           @i_plazo_min,
           @i_plazo_max,
           @s_date,
           @s_date)

   if @@error <> 0
   begin
      select @w_error = 143014
      GOTO ERROR 
   end

   insert into ts_plazo 
         (secuencial,    tipo_transaccion, clase, fecha,
          usuario,       terminal,         srv,   lsrv,
          tipo_plazo,    mnemonico,        plazo_contable,
          descripcion,   plazo_min,        ofi, 
          plazo_max,     fecha_crea,       fecha_mod)
   values(@s_ssn,        @t_trn,           'N',    @s_date,
          @s_user,       @s_term,          @s_srv, @s_lsrv,
          @w_tipo_plazo, @i_mnemonico,     @i_plazo_contable,
          @i_descripcion,@i_plazo_min,     @s_ofi,
          @i_plazo_max,  @s_date,          @s_date)

   if @@error <> 0
   begin
      select @w_error = 143005
      GOTO ERROR 
   end
   commit tran
  
   return 0
end


--Update--
if @i_operacion = 'U'
begin
  
    /* Valores para transaccion de Servicios  y verificacion de la existencia */
    /* del plazo a modificar  */

    select @w_descripcion    = pl_descripcion,
           @w_plazo_min      = pl_plazo_min, 
           @w_plazo_contable = pl_plazo_contable, 
           @w_plazo_max      = pl_plazo_max,
           @w_fecha_mod      = pl_fecha_mod
    from pf_plazo
    where  pl_tipo_plazo = @i_tipo_plazo 
       
    if @@rowcount = 0
    begin
       select @w_error = 141054
       GOTO ERROR  
    end
      
    select @v_descripcion         = @w_descripcion,
           @v_plazo_min           = @w_plazo_min, 
           @v_plazo_contable      = @w_plazo_contable, 
           @v_plazo_max           = @w_plazo_max,
           @v_fecha_mod           = @w_fecha_mod

    if @w_plazo_contable = @i_plazo_contable
       select @w_plazo_contable = null, @v_plazo_contable = null
    else
       select @w_plazo_contable = @i_plazo_contable

    if @w_descripcion = @i_descripcion
       select @w_descripcion = null, @v_descripcion = null
    else
       select @w_descripcion = @i_descripcion
                          
    if @w_plazo_min = @i_plazo_min
       select @w_plazo_min = null, @v_plazo_min = null
    else
       select @w_plazo_min = @i_plazo_min

    if @w_plazo_max = @i_plazo_max
       select @w_plazo_max = null, @v_plazo_max = null
    else
       select @w_plazo_max = @i_plazo_max

    if @w_fecha_mod = @s_date
       select @w_fecha_mod = null, @v_fecha_mod = null
    else
       select @w_fecha_mod = @s_date 
   

    --verificar que el rango de plazo a modificar no genere inconsistencia con los plazos definidos para ningun tipo de deposito--
    select @w_tipo_deposito = 0,
           @w_moneda        = 0
 
    while 1 = 1
    begin
        
         set rowcount 1
         
         select @w_tipo_deposito = at_tipo_deposito,
                @w_moneda        = at_moneda,
                @w_mnemonico     = td_mnemonico 
         from cob_pfijo..pf_auxiliar_tip,
              cob_pfijo..pf_plazo,
              cob_pfijo..pf_tipo_deposito
         where at_tipo  = 'PLA'
           and at_valor = pl_mnemonico 
           and pl_tipo_plazo    = @i_tipo_plazo
           and at_tipo_deposito = td_tipo_deposito 
           and at_estado = 'A'
           and (at_tipo_deposito > @w_tipo_deposito
                 or (at_tipo_deposito = @w_tipo_deposito and at_moneda > @w_moneda))
         order by at_tipo_deposito
    
         if @@rowcount = 0
         begin 
            set rowcount 0
            break
         end
               
         set rowcount 0
         if exists ( select 1 
                     from cob_pfijo..pf_plazo, 
                          cob_pfijo..pf_auxiliar_tip
                     where pl_mnemonico     = at_valor
                       and pl_tipo_plazo   <> @i_tipo_plazo
                       and at_tipo             = 'PLA'
                       and at_tipo_deposito = @w_tipo_deposito
                       and at_estado         = 'A'
                       and at_moneda        = @w_moneda
                       and (@i_plazo_min between pl_plazo_min and pl_plazo_max or
                            @i_plazo_max between pl_plazo_min and pl_plazo_max))
              select @w_return = 141012,
                     @w_msg    = '['+@w_sp_name+'] ' + 'Rango de plazo genera inconsistencia en plazos para deposito: ' + @w_mnemonico
    end
         
    if isnull(@w_return,0) <> 0
    begin
          exec cobis..sp_cerror
               @t_debug  = @t_debug,
               @t_file   = @t_file,
               @t_from   = @w_sp_name,
               @i_num    = @w_return,
               @i_msg    = @w_msg
          return 1  
    end
    
    begin tran

    update pf_plazo
    set pl_descripcion    = @i_descripcion,
        pl_plazo_contable = @i_plazo_contable,
        pl_plazo_min      = @i_plazo_min,
        pl_plazo_max      = @i_plazo_max,
        pl_fecha_mod      = @s_date
    where pl_tipo_plazo = @i_tipo_plazo  
     
    if @@rowcount <> 1
    begin
       select @w_error = 145014
       GOTO ERROR
    end 
   
    insert into ts_plazo 
          (secuencial,        tipo_transaccion, clase,      fecha,
           usuario,           terminal,         srv,        lsrv,  
           plazo_contable,    tipo_plazo,       mnemonico,  descripcion,
           plazo_min,         plazo_max,        fecha_crea, fecha_mod,
           ofi)
    values(@s_ssn,            @t_trn,           'P',        @s_date,
           @s_user,           @s_term,          @s_srv,     @s_lsrv,
           @w_plazo_contable, @i_tipo_plazo,    null,       @v_descripcion, 
           @v_plazo_min,      @v_plazo_max,     null,       @v_fecha_mod,
           @s_ofi)

    if @@rowcount <> 1
    begin
       select @w_error = 143005
       GOTO ERROR  
    end 
     
    insert into ts_plazo 
          (secuencial,        tipo_transaccion, clase,      fecha,
           usuario,           terminal,         srv,        lsrv,
           plazo_contable,    tipo_plazo,       mnemonico,  descripcion,
           plazo_min,         plazo_max,        fecha_crea, fecha_mod, 
           ofi)
    values(@s_ssn,            @t_trn,           'A',        @s_date,
           @s_user,           @s_term,          @s_srv,     @s_lsrv,
           @w_plazo_contable, @i_tipo_plazo,    null,       @w_descripcion,
           @w_plazo_min,      @w_plazo_max,     null,       @w_fecha_mod,
           @s_ofi)

    if @@rowcount <> 1
    begin
       select @w_error = 143005
       GOTO ERROR    
    end 
  
    commit tran

    return 0 
end --fin de if @i_operacion = U--


--Delete--
if @i_operacion = 'D'
begin

   /* valores para transaccion de servicios */
   select @w_descripcion   = pl_descripcion,
          @w_mnemonico     = pl_mnemonico,
          @w_plazo_min     = pl_plazo_min,
          @w_plazo_contable= pl_plazo_contable,
          @w_plazo_max     = pl_plazo_max,
          @w_fecha_crea    = pl_fecha_crea,
          @w_fecha_mod     = pl_fecha_mod
    from pf_plazo
    where pl_tipo_plazo = @i_tipo_plazo

    if @@rowcount = 0
    begin
       select @w_error = 141054
       GOTO ERROR 
    end   
     
    /* Chequeamos que no este siendo utilizado */
    if exists ( select * from pf_auxiliar_tip where at_tipo = 'PLA' 
                and at_valor  = @w_mnemonico
                and at_estado = 'A')
    begin
       select @w_error = 141105
       GOTO ERROR   
    end  

    if exists ( select * from pf_tasa,pf_plazo
                where ta_tipo_plazo = pl_mnemonico 
                  and pl_tipo_plazo = @i_tipo_plazo)
    begin
       select @w_error = 141105
       GOTO ERROR   
    end   

    begin tran


     delete from pf_plazo
     where pl_tipo_plazo = @i_tipo_plazo 
    
     if @@rowcount <> 1
     begin
        select @w_error = 147014
        GOTO ERROR    
     end 
   
    insert into ts_plazo 
          (secuencial,        tipo_transaccion, clase,        fecha,
           usuario,           terminal,         srv,          lsrv, 
           plazo_contable,    tipo_plazo,       mnemonico,    descripcion,
           plazo_min,         plazo_max,          fecha_crea,   fecha_mod,
           ofi)
    values(@s_ssn,            @t_trn,           'B',          @s_date,
           @s_user,           @s_term,          @s_srv,       @s_lsrv,
           @w_plazo_contable, @i_tipo_plazo,    @w_mnemonico, @w_descripcion,
           @w_plazo_min,      @w_plazo_max,     @w_fecha_crea,@w_fecha_mod,
           @s_ofi)

    if @@rowcount ! = 1 
    begin
        select @w_error = 143005
        GOTO ERROR 
    end 
   
    commit tran
    return 0

end --end de if operacion = D--



--Search--
if @i_operacion = 'S'
begin 
     select @i_mnemonico = case @i_modo 
                             when 0 then ''
                             when 1 then @i_mnemonico
                           end  
     set rowcount 20

     select 'COD. PLAZO'   = pl_mnemonico,
            'DESCRIPCION'  = pl_descripcion,
            'PLAZO MINIMO' = pl_plazo_min,
            'PLAZO MAXIMO' = pl_plazo_max,
            'PLAZO CONTA'  = pl_plazo_contable,
            'SEC'          = pl_tipo_plazo
     from pf_plazo
     where pl_mnemonico > @i_mnemonico
     order by pl_mnemonico 
   
     set rowcount 0 
     return 0   
end 

--Query--
if @i_operacion = 'Q'
begin 
     select pl_mnemonico,
            pl_descripcion,
            pl_plazo_min,
            pl_plazo_max
            pl_plazo_contable
     from  pf_plazo
     where pl_tipo_plazo = @i_tipo_plazo
     
     if @@rowcount <> 1
     begin
        select @w_error = 141054
        GOTO ERROR 
     end

     return 0
end


--Help--
if @i_operacion = 'H'
begin
 
  if @i_tipo = 'A'
  begin

     select @i_tipo_plazo = case @i_modo
                              when 0 then 0 
                              else @i_tipo_plazo
                            end
     set rowcount 20

     select 'PLAZO'       = pl_mnemonico,
            'DESCRIPCION' = pl_descripcion,
            'PLAZO MINIMO'= pl_plazo_min,
            'PLAZO MAXIMO'= pl_plazo_max,
            'PLAZO CONTA' = pl_plazo_contable,
            'COD. PLAZO'  = pl_tipo_plazo
     from pf_plazo 
     where pl_tipo_plazo > @i_tipo_plazo
     order by pl_tipo_plazo
 
     set rowcount 0 
     return 0   
  end
   
 
  if @i_tipo = 'B'
  begin
     set rowcount 20
     if @i_modo = 0
     begin
          select 'PLAZO'       = pl_mnemonico,
                 'DESCRIPCION' = pl_descripcion,
                 'PLAZO MINIMO'= pl_plazo_min,
                 'PLAZO MAXIMO'= pl_plazo_max,
                 'PLAZO CONTA' = pl_plazo_contable,
                 'COD. PLAZO'  = pl_tipo_plazo
          from pf_plazo 
          where pl_descripcion like @i_valor
          order by pl_descripcion
     end
 
     set rowcount 0 
     return 0   
  end


 if @i_tipo = 'V'
 begin
    --select  pl_mnemonico,
    select pl_descripcion,
           pl_mnemonico,
           pl_plazo_min,
           pl_plazo_max
           pl_plazo_contable
    from pf_plazo
    where pl_mnemonico  = @i_mnemonico

    if @@rowcount = 0
    begin
       select @w_error = 141054
       GOTO ERROR 
    end
    return 0
  end
end

ERROR:
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_error 
   return 1
go

