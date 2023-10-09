/************************************************************************/
/*  Archivo               : monto.sp                                    */
/*  Stored procedure      : sp_monto                                    */
/*  Base de datos         : cob_pfijo                                   */
/*  Producto              : Plazo_fijo                                  */
/*  Disenado por          : Miryam Davila                               */
/*  Fecha de documentacion: 08/Nov/94                                   */
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
/*  Este programa procesa el mantenimiento de la tabla pf_monto         */
/*  Insercion de pf_monto                                               */
/*  Actualizacion de pf_monto                                           */
/*  Eliminacion de pf_monto                                             */
/*  Search de la tabla pf_monto                                         */
/*  Query sobre pf_monto                                                */
/*  Help a la tabla pf_monto                                            */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA           AUTOR              RAZON                            */
/*  08/Nov/94       R. Serrano      Emision Inicial                     */
/*  09/Dic/94       J. Lam          Consistencia                        */
/*  09/Ago/95       C. Alvarado     Insercion (Secuencial)              */
/*  09/Jun/16       N. Silva        Porting DAVIVIENDA                  */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_monto')
   drop proc sp_monto
go

create proc sp_monto (
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
       @i_tipo_monto           int          = null,
       @i_mnemonico            varchar(10)  = null,
       @i_descripcion          varchar(60)  = null,
       @i_monto_min            money        = null,
       @i_monto_max            money        = null,
       @i_modo                 smallint     = 0, 
       @i_valor                char(20)     = null        
)
with encryption
as
declare @w_sp_name              varchar(32),
        @w_codigo               char(1),
        @w_descripcion          varchar(30),
        @w_mnemonico            varchar(5),
        @w_monto_min            money,
        @w_return               int,  
        @w_tipo_monto           int, 
        @w_monto_max            money, 
        @w_fecha_crea           datetime,
        @w_fecha_mod            datetime,
        @v_descripcion          varchar(30),
        @v_monto_min            money,
        @v_monto_max            money,
        @v_fecha_crea           datetime,
        @v_fecha_mod            datetime,
        @w_tipo_deposito        int,
        @w_moneda               tinyint,
        @w_msg                  varchar(120),
        @w_error                int

select @w_sp_name = 'sp_monto'

if @i_operacion  not in  ('I','U','S','Q','H','D')
begin
   select @w_error = 141008
   GOTO ERROR
end


if (@i_operacion = 'I' and @t_trn <> 14112) or
   (@i_operacion = 'U' and @t_trn <> 14212) or
   (@i_operacion = 'D' and @t_trn <> 14312) or
   (@i_operacion = 'Q' and @t_trn <> 14412) or
   (@i_operacion = 'S' and @t_trn <> 14512) or
   (@i_operacion = 'H' and @t_trn <> 14612) 
begin
   select @w_error = 141040
   GOTO ERROR
end 


/** Insert **/
if @i_operacion = 'I'
begin

    if exists (select mo_mnemonico  from pf_monto
               where mo_mnemonico = @i_mnemonico)

    begin
       select @w_error = 141043
       GOTO ERROR  
    end  

    /* Verificar que el rango de montos a insertar no se encuentre dentro de uno queya exista */

    begin tran
  
    exec @w_return = cobis..sp_cseqnos
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_tabla = 'pf_monto',
         @o_siguiente = @w_tipo_monto out

    if @w_return <> 0
        return @w_return

     /* insertar un nuevo tipo de monto */
     insert into pf_monto  
           (mo_tipo_monto,
            mo_mnemonico,
            mo_descripcion,
            mo_monto_min,
            mo_monto_max,
            mo_fecha_crea,
            mo_fecha_mod)
     values(@w_tipo_monto, 
            @i_mnemonico,
            @i_descripcion,
            @i_monto_min,
            @i_monto_max,
            @s_date,
            @s_date)

     if @@error <> 0
     begin
        select @w_error = 143012
        GOTO ERROR  
     end

     /* Transaccion de servicio  */
     insert into ts_monto 
            (secuencial,    tipo_transaccion, clase,          fecha,
             usuario,       terminal,         srv,            lsrv,
             tipo_monto,    mnemonico,        descripcion,    monto_min,
             monto_max,     fecha_crea,       fecha_mod,      ofi)
     values (@s_ssn,        @t_trn,           'N',            @s_date,
             @s_user,       @s_term,          @s_srv,         @s_lsrv,
             @w_tipo_monto, @i_mnemonico,     @i_descripcion, @i_monto_min,
             @i_monto_max,  @s_date,          @s_date,        @s_ofi)

     if @@error <> 0
     begin
        select @w_error = 143005
        GOTO ERROR  
     end

     commit tran
  
     return 0
end


/** Update **/
if @i_operacion = 'U'
begin
    /* Valores para transaccion de Servicios  y verificacion de la existencia */
    /* del monto a modificar  */

    select @w_descripcion = mo_descripcion,
           @w_monto_min   = mo_monto_min, 
           @w_monto_max   = mo_monto_max,
           @w_fecha_mod   = mo_fecha_mod
    from pf_monto
    where mo_tipo_monto = @i_tipo_monto 
    
    
    if @@rowcount = 0
    begin
       select @w_error = 141053
       GOTO ERROR  
    end
      
    select @v_descripcion = @w_descripcion
    select @v_monto_min   = @w_monto_min 
    select @v_monto_max   = @w_monto_max
    select @v_fecha_mod   = @w_fecha_mod

    if @w_descripcion = @i_descripcion
       select @w_descripcion = null, @v_descripcion = null
    else
       select @w_descripcion = @i_descripcion
                          
    if @w_monto_min = @i_monto_min
       select @w_monto_min = null, @v_monto_min = null
    else
       select @w_monto_min = @i_monto_min

    if @w_monto_max = @i_monto_max
       select @w_monto_max = null, @v_monto_max = null
    else
       select @w_monto_max = @i_monto_max

    if @w_fecha_mod = @s_date
       select @w_fecha_mod = null, @v_fecha_mod = null
    else
       select @w_fecha_mod = @s_date 


    --verificar que el rango de monto a modificar no genere inconsistencia con los montos definidos para ningun tipo de deposito--
    select @w_tipo_deposito = 0,
           @w_moneda        = 0

    while 1 = 1
    begin
         
         set rowcount 1
         
         select @w_tipo_deposito = at_tipo_deposito,
                @w_moneda        = at_moneda,
                @w_mnemonico     = td_mnemonico 
         from cob_pfijo..pf_auxiliar_tip,
              cob_pfijo..pf_monto,
              cob_pfijo..pf_tipo_deposito
         where at_tipo          = 'MOT'
           and at_valor         = mo_mnemonico 
           and mo_tipo_monto    = @i_tipo_monto
           and at_tipo_deposito = td_tipo_deposito 
           and at_estado        = 'A'
           and (at_tipo_deposito > @w_tipo_deposito
                 or (at_tipo_deposito = @w_tipo_deposito and at_moneda > @w_moneda))
         order by at_tipo_deposito
    
         if @@rowcount = 0
         begin 
            set rowcount 0
            break
         end
               
         set rowcount 0

         if exists (select 1
                    from cob_pfijo..pf_monto, 
                         cob_pfijo..pf_auxiliar_tip
                    where mo_mnemonico     = at_valor
                      and at_tipo          = 'MOT'
                      and mo_tipo_monto   <> @i_tipo_monto
                      and at_tipo_deposito = @w_tipo_deposito
                      and at_estado        = 'A'
                      and at_moneda        = @w_moneda
                      and (@i_monto_min between mo_monto_min and mo_monto_max or
                           @i_monto_max between mo_monto_min and mo_monto_max))
              select @w_return = 141120,
                     @w_msg    = '['+@w_sp_name+'] ' + 'Rango de monto genera inconsistencia en montos para deposito: ' + @w_mnemonico

    end
          
    if isnull(@w_return,0) <> 0
    begin
       select @w_error = 141053
       GOTO ERROR
    end


    begin tran

    /* modificacion de los datos */
    update pf_monto
    set  mo_descripcion = @i_descripcion,
         mo_monto_min   = @i_monto_min,
         mo_monto_max   = @i_monto_max,
         mo_fecha_mod   = @s_date
    where mo_tipo_monto = @i_tipo_monto  
     
    if @@rowcount <> 1
    begin
       select @w_error = 145012
       GOTO ERROR   
    end 
   
    /* transaccion servicio - monto con los datos anteriores */  

     insert into ts_monto 
            (secuencial,    tipo_transaccion, clase,          fecha,
             usuario,       terminal,         srv,            lsrv,
             tipo_monto,    mnemonico,        descripcion,    monto_min,
             monto_max,     fecha_crea,       fecha_mod,      ofi)
     values (@s_ssn,        @t_trn,           'P',            @s_date,
             @s_user,       @s_term,          @s_srv,         @s_lsrv,
             @i_tipo_monto, null,             @v_descripcion, @v_monto_min,
             @v_monto_max,  null,             @v_fecha_mod,   @s_ofi)

    if @@rowcount <> 1
    begin
       select @w_error = 143005
       GOTO ERROR   
    end 
    
     /* transaccion de servicio - monto con los datos modificados */

     insert into ts_monto 
            (secuencial,    tipo_transaccion, clase,          fecha,
             usuario,       terminal,         srv,            lsrv,
             tipo_monto,    mnemonico,        descripcion,    monto_min,
             monto_max,     fecha_crea,       fecha_mod,      ofi)
     values (@s_ssn,        @t_trn,           'A',            @s_date,
             @s_user,       @s_term,          @s_srv,         @s_lsrv,
             @i_tipo_monto, null,             @w_descripcion, @w_monto_min,
             @w_monto_max,  null,             @w_fecha_mod,   @s_ofi)

    if @@rowcount <> 1
    begin
       select @w_error = 143005
       GOTO ERROR   
    end 

    commit tran
    return 0 
end /* fin de if @i_operacion = U */   


/** Delete **/
if @i_operacion = 'D'
begin

   /* valores para transaccion de servicios */
    select @w_descripcion = mo_descripcion,
           @w_mnemonico   = mo_mnemonico,
           @w_monto_min   = mo_monto_min,
           @w_monto_max   = mo_monto_max,
           @w_fecha_crea  = mo_fecha_crea,
           @w_fecha_mod   = mo_fecha_mod
    from pf_monto
    where mo_tipo_monto = @i_tipo_monto

    if @@rowcount = 0
    begin
       select @w_error = 141053
       GOTO ERROR  
    end       

   /* VERIFICACION DE CONSISTENCIA */
   if exists ( select * 
               from pf_auxiliar_tip 
               where at_tipo = 'MOT'
                 and at_valor = @w_mnemonico)
   begin
      select @w_error = 141106
      GOTO ERROR
   end   
   
   if exists ( select * from pf_tasa,pf_monto
     where ta_tipo_monto = mo_mnemonico and
           mo_tipo_monto = @i_tipo_monto)
   begin
      select @w_error = 141106
      GOTO ERROR
   end 

   begin tran

    /* borrar el monto de la tabla */

    delete from pf_monto
    where mo_tipo_monto = @i_tipo_monto 
    
   if @@rowcount <> 1
   begin
      select @w_error = 147012
      GOTO ERROR
   end 

    /* transaccion de servicios - pf_monto */  

     insert into ts_monto 
            (secuencial,    tipo_transaccion, clase,          fecha,
             usuario,       terminal,         srv,            lsrv,
             tipo_monto,    mnemonico,        descripcion,    monto_min,
             monto_max,     fecha_crea,       fecha_mod,      ofi)
     values (@s_ssn,        @t_trn,           'B',            @s_date,
             @s_user,       @s_term,          @s_srv,         @s_lsrv,
             @i_tipo_monto, @w_mnemonico,     @w_descripcion, @w_monto_min,
             @w_monto_max,  @w_fecha_crea,    @w_fecha_mod,   @s_ofi)

    if @@rowcount <> 1
    begin
       select @w_error = 143005
       GOTO ERROR
    end 
   
    commit tran

    return 0

end /* end de if operacion = D */

/** Search **/
if @i_operacion = 'S'
begin 
 
   /* Busqueda de datos de pf_monto,  se controla de 20 en 20
   pues  se asume que pueden haber mas de 20 tipos de monto */

   select @i_mnemonico = case @i_modo 
                           when 0 then ''
                           when 1 then @i_mnemonico 
                         end
   set rowcount 20

   select 'CODIGO MONTO' = mo_mnemonico, 
          'DESCRIPCION'  = mo_descripcion,
          'MONTO MINIMO' = mo_monto_min,
          'MONTO MAXIMO' = mo_monto_max,
          'SEC. MONTO'   = mo_tipo_monto
   from pf_monto
   where mo_mnemonico > @i_mnemonico
   order by mo_mnemonico

   set rowcount 0 
   return 0   

end /* end del if 'Search' */


/** Query **/
if @i_operacion = 'Q'
begin 
      select mo_mnemonico, 
             mo_descripcion,
             mo_monto_min,
             mo_monto_max
      from pf_monto
      where mo_tipo_monto = @i_tipo_monto
     
      if @@rowcount <> 1
      begin
         select @w_error = 143053
         GOTO ERROR
      end

      return 0
end


/** Help **/

if @i_operacion = 'H'
begin
      /* consulta de montos */   
      if @i_tipo = 'A'
      begin
            select @i_tipo_monto = case @i_modo
                                     when 0 then 0 
                                     when 1 then @i_tipo_monto
                                   end   
            set rowcount 20

            select 'MONTO'        = mo_mnemonico, 
                   'DESCRIPCION'  = substring(mo_descripcion,1,30),
                   'MONTO MINIMO' = mo_monto_min,
                   'MONTO MAXIMO' = mo_monto_max,
                   'SEC. MONTO'   = mo_tipo_monto
            from pf_monto
            where mo_tipo_monto > @i_tipo_monto
            order by mo_tipo_monto

            set rowcount 0 
            return 0   
      end
   
      if @i_tipo = 'B'
      begin

            select @i_tipo_monto = case @i_modo
                                     when 0 then 0 
                                     when 1 then @i_tipo_monto
                                   end   
            set rowcount 20

            select 'MONTO'        = mo_mnemonico, 
                   'DESCRIPCION'  = substring(mo_descripcion,1,30),
                   'MONTO MINIMO' = mo_monto_min,
                   'MONTO MAXIMO' = mo_monto_max,
                   'SEC. MONTO'   = mo_tipo_monto
            from pf_monto
            where mo_tipo_monto > @i_tipo_monto
              and mo_descripcion like @i_valor
            order by mo_descripcion
           
            set rowcount 0 
            
            return 0   
      end

      if @i_tipo = 'V'
      begin
           select substring(mo_descripcion,1,30),
                  mo_monto_min,
                  mo_monto_max
           from pf_monto
           where mo_mnemonico  = ltrim(@i_mnemonico)
   
           if @@rowcount = 0
           begin
              select @w_error = 141053
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
   return @w_error
go

