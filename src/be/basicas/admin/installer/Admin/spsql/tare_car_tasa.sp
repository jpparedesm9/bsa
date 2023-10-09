/******************************************************************/
/*  Archivo         : ta_carta.sp                                 */
/*  Stored procedure: sp_tare_car_tasa                            */
/*  Base de datos   : cobis                                       */
/*  Producto        : Administrador                               */
/*  Disenado por    : Juan Carlos Gómez                           */
/*  Fecha           : 22-Dic-98                                   */
/******************************************************************/
/*                         IMPORTANTE                             */
/*  Esta Aplicacion es parte de los paquetes bancarios propiedad  */
/*  de MACOSA, representantes exclusivos para  el Ecuador de  la  */
/*  NCR CORPORATION.  Su uso  no  autorizado queda  expresamente  */
/*  prohibido asi como cualquier alteracion o agregado hecho por  */
/*  alguno  de sus  usuarios  sin el debido  consentimiento  por  */
/*  escrito  de  la   Presidencia  Ejecutiva   de  MACOSA  o  su  */
/*  representante                                                 */
/******************************************************************/
/*                          PROPOSITO                             */
/*  Este programa mantiene y busca las caracteristicas de tasas   */
/******************************************************************/
/*                          MODIFICACIONES                        */
/*  FECHA          AUTOR           RAZON                          */
/*  02-Dic-98   Juan C. Gomez   Emision Inicial                   */
/*  25.ago.99   M. del Pozo     i_rango, i_nrotasas               */
/*  16-May-00   R. Minga V.     Adaptacion tasas para Admin       */
/*  04-Abr-17   N. Silva        Optimizacion identacion           */
/******************************************************************/
use cobis
go

SET NOCOUNT ON
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
go

if exists (select * from sysobjects where name = 'sp_tare_car_tasa')
   drop proc sp_tare_car_tasa
go

create proc sp_tare_car_tasa (
       @s_ssn              int         = null,
       @s_srv              varchar(30) = null,
       @s_lsrv             varchar(30) = null,
       @s_user             varchar(30) = null,
       @s_sesn             int         = null,
       @s_term             varchar(32) = null,
       @s_date             datetime    = null,
       @s_ofi              smallint    = 1,
       @s_rol              smallint    = 1, 
       @s_error            int         = null,
       @s_sev              tinyint     = null,
       @s_msg              mensaje     = null,
       @t_debug            char(1)     = 'N',
       @t_file             varchar(14) = null,
       @t_from             descripcion = null,
       @t_trn              smallint,
       @i_operacion        char(1),
       @i_modo             tinyint     = null,
       @i_tasa             catalogo    = null,
       @i_tasa_sig         catalogo    = null,
       @i_descripcion      descripcion = null,
       @i_descripcion_sig  descripcion = null,
       @i_periodo          tinyint     = null,
       @i_modalidad        char(1)     = null,
       @i_rango            char(1)     = null,
       @i_nro_tasas        smallint    = null,
       @i_num_periodo      smallint    = null,
       @i_estado           char(1)     = null,
       @i_criterio         char(1)     = null,
       @i_tipo             char(1)     = null,
       @i_destino          char(1)     = 'F',
       @o_tasa             catalogo    = null out,
       @o_periodo          tinyint     = null out,
       @o_modalidad        char(1)     = null out,
       @o_descripcion      descripcion = null out,
       @o_estado           char(1)     = null out,
       @o_rango            char(1)     = null out,
       @o_nro_tasas        smallint    = null out,
       @o_nro_peridos      smallint    = null out
        
)
as
declare
      @w_sp_name      varchar(30),
      @w_return       int,
      @w_rango        char(1),
      @w_nro_tasas    smallint,
      @w_estado       char(1),
      @w_tabla        int,
      @w_error        int


select @w_sp_name = 'sp_tare_car_tasa'
    

-- Evaluar si la transaccion no corresponde a la operacion
if (@t_trn <> 15191 and @i_operacion = 'I') or
   (@t_trn <> 15192 and @i_operacion = 'U') or
   (@t_trn <> 15193 and @i_operacion in ('S','Q','H'))
begin
   -- Si no corresponde la transaccion, error y salir
   select @w_error = 151051
   goto ERROR
end

-- Obtener codigo de tasas referenciales de mercado
select @w_tabla = codigo
  from cobis..cl_tabla 
 where tabla = 'te_tasa_referencia'

-- Si la operacion es insercion de tasa           
if @i_operacion = 'I'
begin                              
   --Verificar que no exista la caracteristica de tasa que se desea ingresar
   if exists (select *
                from te_caracteristicas_tasa
               where ca_tasa      = @i_tasa
                 and ca_periodo   = @i_periodo
                 and ca_modalidad = @i_modalidad)
   begin
      -- Si existe la caracteristica de tasa desplegar error y salir
      select @w_error = 151101
      goto ERROR
   end

   begin tran
      --Insertar el registro
      insert into te_caracteristicas_tasa 
                  (ca_tasa , ca_periodo  , ca_modalidad, ca_estado,
                   ca_rango, ca_nro_tasas, ca_num_periodo)
           values (@i_tasa , @i_periodo  , @i_modalidad, @i_estado, 
                   @i_rango, @i_nro_tasas, @i_num_periodo)
      
      if @@error != 0
      begin
         -- Si hay error al ingresar el registro desplegar error y salir
         select @w_error = 153045
         goto ERROR
      end

      -- Ingresar transaccion de servicio
      insert into ts_caracteristicas_tasa 
                  (secuencia, tipo_transaccion, clase     , fecha,
                   oficina_s, usuario         , terminal_s, srv, 
                   lsrv     , tasa            , periodo   , modalidad, 
                   estado   , rango           , nro_tasas)
           values (@s_ssn   , 15191           , 'N'       , @s_date,
                   @s_ofi   , @s_user         , @s_term   , @s_srv, 
                   @s_lsrv  , @i_tasa         , @i_periodo, @i_modalidad,
                   @i_estado, @i_rango        , @i_nro_tasas)
      
      -- Si no se puede insertar la transaccion de servicio error y salir
      if @@error != 0
      begin
         rollback tran
         select @w_error = 153023
         goto ERROR
      end
   commit tran
end

-- Si la operacion es modificacion de tasa           
if @i_operacion = 'U'
begin                              

   --Verificar que exista la caracteristica de tasa que se desea modificar
   if not exists (select *
                from te_caracteristicas_tasa
               where ca_tasa = @i_tasa
                 and ca_periodo = @i_periodo
                 and ca_modalidad = @i_modalidad)
   begin
      -- Si no existe la caracteristica de tasa desplegar error y salir
      select @w_error = 151102
      goto ERROR
   end
    
   -- Capturar la informaci¢n a modificar para transaccion de servicio
   select @w_estado    = ca_estado,
          @w_rango     = ca_rango,
          @w_nro_tasas = ca_nro_tasas
     from te_caracteristicas_tasa
    where ca_tasa      = @i_tasa
      and ca_periodo   = @i_periodo
      and ca_modalidad = @i_modalidad

   begin  tran
      -- Modificar el registro
      update te_caracteristicas_tasa
         set ca_estado      = @i_estado,
             ca_rango       = @i_rango,
             ca_nro_tasas   = @i_nro_tasas,
             ca_num_periodo = @i_num_periodo
       where ca_tasa      = @i_tasa
         and ca_periodo   = @i_periodo
         and ca_modalidad = @i_modalidad 
      
      -- Si hay error al modificar reportarlo y salir
      if @@error != 0
      begin
         select @w_error = 155047
         goto ERROR
      end
      
      -- Insertar transacciones de servicio
      -- Si existe error al insertar las transacciones de servicio error y salir
      insert into ts_caracteristicas_tasa 
                  (secuencia, tipo_transaccion, clase     , fecha,
                   oficina_s, usuario         , terminal_s, srv, 
                   lsrv     , tasa            , periodo   , modalidad, 
                   estado   , rango           , nro_tasas)
           values (@s_ssn   , 15192           , 'P'       , @s_date,
                   @s_ofi   , @s_user         , @s_term   , @s_srv,
                   @s_lsrv  , @i_tasa         , @i_periodo, @i_modalidad, 
                   @w_estado, @w_rango        , @w_nro_tasas )
      
       -- Si no se puede insertar la transaccion de servicio error y salir
       if @@error != 0
       begin
          rollback tran
          select @w_error = 153023
          goto ERROR
       end
      
      -- Ingresar transaccion de servicio
      insert into ts_caracteristicas_tasa 
                  (secuencia, tipo_transaccion, clase     , fecha,
                   oficina_s, usuario         , terminal_s, srv, 
                   lsrv     , tasa            , periodo   , modalidad, 
                   estado   , rango           , nro_tasas)
           values (@s_ssn   , 15192           , 'A'       , @s_date,
                   @s_ofi   , @s_user         , @s_term   , @s_srv,
                   @s_lsrv  , @i_tasa         , @i_periodo, @i_modalidad,
                   @i_estado, @i_rango        , @i_nro_tasas )
      
      
       -- Si no se puede insertar la transaccion de servicio error y salir
       if @@error != 0
       begin
          rollback tran
          select @w_error = 153023
          goto ERROR
       end
   commit tran 
end

-- Si la operacion es busqueda de todas las tasas
if @i_operacion = 'S'
begin     
   set rowcount 20                         
   select 'TASA'          = ca_tasa,
          'PERIODO'       = ca_periodo,
          'MODALIDAD'     = ca_modalidad,
          'ESTADO'        = ca_estado,
          'DESCRIPCION'   = valor,
          'T. RANGO'      = ca_rango,
          'NRO. TASAS PM' = ca_nro_tasas,
          'NRO. PERIODOS' = ca_num_periodo  
     from te_caracteristicas_tasa,
          cobis..cl_catalogo
    where ca_tasa  = codigo
      and tabla    = @w_tabla
      and (@i_modo <> 1 or (ca_tasa      > @i_tasa
                        or (ca_tasa      = @i_tasa
                        and ca_periodo   > @i_periodo)
                        or (ca_tasa      = @i_tasa
                        and ca_periodo   = @i_periodo
                        and ca_modalidad > @i_modalidad)))
    order by ca_tasa, ca_periodo, ca_modalidad 
   set rowcount 0
end

-- Si la operaci¢n es Consulta de una tasa espec¡fica
if @i_operacion = 'Q'
begin
     select @o_tasa        = ca_tasa,
            @o_periodo     = ca_periodo,
            @o_modalidad   = ca_modalidad,
            @o_descripcion = valor,
            @o_estado      = ca_estado,
            @o_rango       = ca_rango,
            @o_nro_tasas   = ca_nro_tasas,
            @o_nro_peridos = ca_num_periodo 
       from te_caracteristicas_tasa,
            cobis..cl_catalogo
      where ca_tasa        = codigo
        and tabla          = @w_tabla
        and ca_tasa        = @i_tasa
        and ((ca_periodo   = @i_periodo   and @i_modo = 1) or (@i_periodo is null   and @i_modo = 0))
        and ((ca_modalidad = @i_modalidad and @i_modo = 1) or (@i_modalidad is null and @i_modo = 0))

   if @i_destino = 'F' 
      select @o_tasa        ,
             @o_periodo     ,
             @o_modalidad   ,
             @o_descripcion ,
             @o_estado      ,
             @o_rango       ,
             @o_nro_tasas   ,
             @o_nro_peridos  
       
end

-- Si la operacion es CONSULTA GENERAL para ayuda
if @i_operacion = 'H'
begin

  set rowcount 20
  -- Si el criterio es por codigo de tasa
  if @i_criterio = 'C'

     -- Seleccionar los registros de 20 en 20 ordenados por codigo
     select 'TASA'         = ca_tasa,
            'PERIODO'      = ca_periodo,
            'MODALIDAD'    = ca_modalidad,
            'DESCRIPCION'  = valor,
            'ESTADO'       = ca_estado,
            'RANGO'        = ca_rango,
            'NRO TASAS PM' = ca_nro_tasas,
            'NRO PERIODOS' = ca_num_periodo 
       from te_caracteristicas_tasa,
            cobis..cl_catalogo
      where ca_tasa      like @i_tasa
        and (@i_modo     <>   1        or (ca_tasa      > @i_tasa_sig)
                                       or (ca_tasa      = @i_tasa_sig
                                       and ca_periodo   > @i_periodo)
                                       or (ca_tasa      = @i_tasa_sig
                                       and ca_periodo   = @i_periodo
                                       and ca_modalidad > @i_modalidad)
            )
        and (@i_tipo <> 'V' or ca_estado = 'V')
        and ca_tasa  = codigo
        and tabla    = @w_tabla
      order by ca_tasa
       
  -- Si el criterio es por descripcion de tasa
  if @i_criterio = 'D'

     -- Seleccionar los registros de 20 en 20 ordenados por descripcion
     select 'TASA'         = ca_tasa,
            'PERIODO'      = ca_periodo,
            'MODALIDAD'    = ca_modalidad,
            'DESCRIPCION'  = valor,
            'ESTADO'       = ca_estado,
            'RANGO'        = ca_rango,
            'NRO TASAS PM' = ca_nro_tasas,
            'NRO PERIODOS' = ca_num_periodo
       from te_caracteristicas_tasa,
            cobis..cl_catalogo
      where valor    like @i_descripcion
        and (@i_modo <> 1 or (valor            > @i_descripcion_sig)
                          or (valor            = @i_descripcion_sig
                              and ca_periodo   > @i_periodo)
                          or (valor            = @i_descripcion_sig
                              and ca_periodo   = @i_periodo
                              and ca_modalidad > @i_modalidad)
            )
        and (@i_tipo <> 'V' or ca_estado = 'V')
        and ca_tasa  = codigo
        and tabla    = @w_tabla
      order by valor    

  set rowcount 0   
end
return 0

ERROR: 
   exec sp_cerror 
        @t_debug= @t_debug,
        @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num  = @w_error
   return @w_error

go
