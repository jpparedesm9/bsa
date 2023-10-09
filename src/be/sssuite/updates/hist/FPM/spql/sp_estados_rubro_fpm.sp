use cob_fpm
go

if exists (select 1 from sysobjects where name = 'sp_estados_rubro_fpm')
   drop proc sp_estados_rubro_fpm
go

CREATE PROCEDURE sp_estados_rubro_fpm (
   @s_date               datetime = null,
   @s_user               varchar(30)   = null,
   @s_term               descripcion = null,
   @s_ofi                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_toperacion         catalogo    = '',
   @i_operacion          char(1),
   @i_concepto           catalogo  = '',
   @i_estado             varchar(15)  = null,
   @i_dias_cont          int          = -99999,
   @i_dias_fin           int          =  99999
)
as
declare
   @w_error              int,
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_estado             tinyint,
   @w_clave1             varchar(255),
   @w_clave2             varchar(255),
   @w_clave3             varchar(255),
   @w_return             int
   
select @w_sp_name = 'sp_estados_rubro_fpm'
/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' begin
    select @w_estado = es_codigo
    from   cob_cartera..ca_estado
    where  es_descripcion = @i_estado
    if exists(select * 
              from cob_cartera..ca_estados_rubro
              where er_toperacion = @i_toperacion 
              and   er_concepto   = @i_concepto 
              and   er_estado     = @w_estado)
       select @w_existe = 1
    else select @w_existe = 0
end
/* Insercion del registro */
if @i_operacion = 'I' begin
    if @w_existe = 1 begin
        select @w_error   = 708151
        goto ERROR
    end
    if  exists (select 1 from cob_cartera..ca_estados_rubro
            where er_toperacion = @i_toperacion
            and   er_concepto   = @i_concepto 
            and (   @i_dias_cont between er_dias_cont and er_dias_fin
                 or @i_dias_fin  between er_dias_cont and er_dias_fin ))
    begin
       select @w_error = 710080
       goto ERROR 
    end
   
    insert into cob_cartera..ca_estados_rubro(
    er_toperacion, er_concepto, er_estado,
    er_dias_cont,  er_dias_fin)
    values (
    @i_toperacion, @i_concepto, @w_estado,
    @i_dias_cont,  @i_dias_fin)
    if @@error <> 0 begin
       /* Error en insercion de registro */
       select @w_error   = 701155
       goto ERROR
    end
    /*select @w_clave1 = convert(varchar(255),@i_toperacion)
    select @w_clave2 = convert(varchar(255),@i_concepto)
    select @w_clave3 = convert(varchar(255),@w_estado)
    exec @w_return = sp_tran_servicio
    @s_user    = @s_user,
    @s_date    = @s_date,
    @s_ofi     = @s_ofi,
    @s_term    = @s_term,
    @i_tabla   = 'ca_estados_rubro',
    @i_clave1  = @w_clave1,
    @i_clave2  = @w_clave2,
    @i_clave3  = @w_clave3
    if @w_return != 0
    begin
       select @w_error = @w_return
       goto ERROR
    end*/
end
/* Actualizacion del registro */
if @i_operacion = 'U' begin
   if @w_existe = 0 begin
      select @w_error   = 701156
      goto ERROR
   end
    if  exists (select 1 from cob_cartera..ca_estados_rubro
            where er_toperacion = @i_toperacion
            and   er_concepto   = @i_concepto   
            and   er_estado     <> @w_estado
            and (   @i_dias_cont between er_dias_cont and er_dias_fin
                 or @i_dias_fin  between er_dias_cont and er_dias_fin ))
    begin
       select @w_error = 710080
       goto ERROR 
    end
   /*select @w_clave1 = convert(varchar(255),@i_toperacion)
   select @w_clave2 = convert(varchar(255),@i_concepto)
   select @w_clave3 = convert(varchar(255),@w_estado)
   exec @w_return = sp_tran_servicio
   @s_user    = @s_user,
   @s_date    = @s_date,
   @s_ofi     = @s_ofi,
   @s_term    = @s_term,
   @i_tabla   = 'ca_estados_rubro',
   @i_clave1  = @w_clave1,
   @i_clave2  = @w_clave2,
   @i_clave3  = @w_clave3
   if @w_return != 0
   begin
      select @w_error = @w_return
      goto ERROR
   end*/             
   update cob_cartera..ca_estados_rubro set 
   er_dias_cont = @i_dias_cont,
   er_dias_fin  = @i_dias_fin
   where er_toperacion = @i_toperacion 
   and   er_concepto   = @i_concepto 
   and   er_estado     = @w_estado
   if @@error <> 0 begin
      select @w_error   = 708152
      goto ERROR
   end
end
/* Consulta opcion QUERY */
if @i_operacion = 'S' begin
   if @i_concepto = '' and @i_toperacion <> '' begin
      /*SI INGRESO UN PARAMETRO DE BUSQUEDA SOLO TRAE LOS REGISTROS DE ESE PA
        PARAMETRO*/
      set rowcount 35 
      select 
       "233406" =  er_toperacion, 
       "233407" =  substring(D.valor,1,20),
       "233408" =  er_concepto,
       "233409" =  substring(co_descripcion,1,20),
       "233410" =  substring(A.es_descripcion,1,15),
       "233411" =  er_dias_cont,
       "233412" =  er_dias_fin
      from  cob_cartera..ca_estados_rubro,cob_cartera..ca_estado A,cob_cartera..ca_concepto,
            cobis..cl_tabla C, cobis..cl_catalogo D
      where er_toperacion = @i_toperacion  
      and   er_estado     = A.es_codigo
      and   co_concepto   = er_concepto
      and   C.tabla       = 'ca_toperacion'
      and   C.codigo      = D.tabla
      and   D.codigo      = er_toperacion
      order by er_toperacion, er_concepto
   
      set rowcount 0
      select 35 
   end 
   else begin 
      /*TODOS LOS REGISTROS O SIGUIENTES*/
      set rowcount 35 
   
      select 
       "233406" =  er_toperacion, 
       "233407" =  substring(D.valor,1,20),
       "233408" =  er_concepto,
       "233409" =  substring(co_descripcion,1,20),
       "233410" =  substring(A.es_descripcion,1,15),
       "233411" =  er_dias_cont,
       "233412" =  er_dias_fin
      from  cob_cartera..ca_estados_rubro,cob_cartera..ca_estado A,cob_cartera..ca_concepto,
            cobis..cl_tabla C, cobis..cl_catalogo D
      where (er_toperacion > @i_toperacion 
             or (er_toperacion = @i_toperacion and er_concepto > @i_concepto ))
      and   er_estado     = A.es_codigo
      and   co_concepto   = er_concepto
      and   C.tabla       = 'ca_toperacion'
      and   C.codigo      = D.tabla
      and   D.codigo      = er_toperacion
      order by er_toperacion, er_concepto
   
      set rowcount 0
      select 35 
   end
end
/* Eliminar opcion DELETE */
if @i_operacion = 'D' begin
   /*select @w_clave1 = convert(varchar(255),@i_toperacion)
   select @w_clave2 = convert(varchar(255),@i_concepto)
   select @w_clave3 = convert(varchar(255),@w_estado)
   exec @w_return = cob_cartera..sp_tran_servicio
   @s_user    = @s_user,
   @s_date    = @s_date,
   @s_ofi     = @s_ofi,
   @s_term    = @s_term,
   @i_tabla   = 'ca_estados_rubro',
   @i_clave1  = @w_clave1,
   @i_clave2  = @w_clave2,
   @i_clave3  = @w_clave3
   if @w_return != 0
   begin
      select @w_error = @w_return
      goto ERROR
   end*/        
   delete cob_cartera..ca_estados_rubro
   where er_toperacion = @i_toperacion 
   and   er_concepto   = @i_concepto      
   and   er_estado     = @w_estado
   if @@error <> 0 begin
      select @w_error   = 710003 
      goto ERROR
   end
end
return 0

ERROR:
exec cobis..sp_cerror
@t_debug = @t_debug,
@t_file  = @t_file,
@t_from  = @w_sp_name,
@i_num   = @w_error
return 1
