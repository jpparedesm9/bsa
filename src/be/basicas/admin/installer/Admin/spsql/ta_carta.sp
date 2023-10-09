/******************************************************************/
/*  Archivo:              ta_carta.sp                             */
/*  Stored procedure:     sp_tare_car_tasa                        */
/*  Base de datos:        cobis                                   */
/*  Producto:             Administrador                           */
/*  Disenado por:         Juan Carlos Gómez                       */
/*  Fecha:                22-Dic-98                               */
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
/*                       MODIFICACIONES                           */
/*  FECHA          AUTOR           RAZON                          */
/*	22-Dic-98	Juan C. Gomez	Emision Inicial		      */
/*      25.ago.99       M. del Pozo     Incluir i_rango,          */
/*                                      i_nrotasas                */
/*      16-May-00       R. Minga V.     RMI16May00: Adaptacion    */
/*                                      de tasas referenciales a  */
/*                                      admin                     */
/******************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_tare_car_tasa')
   drop proc sp_tare_car_tasa








go
create proc sp_tare_car_tasa (
	@s_ssn		int = null,
	@s_srv		varchar(30) = null,
	@s_lsrv         varchar(30) = null,
	@s_user		varchar(30) = null,
	@s_sesn         int = null,
	@s_term		varchar(10) = null,
	@s_date		datetime = null,
	@s_ofi		tinyint = 1,
	@s_rol		smallint = 1, 
        @s_error        int = null,
        @s_sev		tinyint = null,
	@s_msg		mensaje = null,
        @t_debug        char(1) ="N",
        @t_file         varchar(14) = null,
        @t_from		descripcion = null,
        @t_trn          smallint,
        @i_operacion    char(1),
        @i_modo         tinyint = null,
        @i_tasa         catalogo = null,
        @i_tasa_sig     catalogo = null,
        @i_descripcion  descripcion = null,
        @i_descripcion_sig descripcion = null,
        @i_periodo      tinyint = null,
        @i_modalidad    char(1) = null,
        @i_rango        char(1) = null,
        @i_nro_tasas    smallint = null,
        @i_estado       char(1) = null,
        @i_criterio     char(1) = null,
        @i_tipo         char(1) = null,
        @i_destino      char(1) = "F",
        @o_tasa         catalogo = null out,
        @o_periodo      tinyint = null out,
        @o_modalidad    char(1) = null out,
        @o_descripcion  descripcion = null out,
        @o_estado       char(1) = null out,
        @o_rango        char(1) = null out,
        @o_nro_tasas    smallint = null out
        
)
as
declare
      @w_sp_name      varchar(30),
      @w_return       int,
      @w_rango        char(1),
      @w_nro_tasas    smallint,
      @w_estado       char(1)


select @w_sp_name = "sp_tare_car_tasa"
	

-- Evaluar si la transaccion no corresponde a la operacion
if (@t_trn <> 15191 and @i_operacion = "I") or
   (@t_trn <> 15192 and @i_operacion = "U") or
   (@t_trn <> 15193 and @i_operacion in ("S","Q","H"))
begin
   -- Si no corresponde la transaccion, error y salir
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151051
	return 1
end

-- Si la operacion es insercion de tasa           
if @i_operacion = "I"
begin 	                           
   --Verificar que no exista la caracteristica de tasa que se desea ingresar
   if exists (select *
                from te_caracteristicas_tasa
               where ca_tasa = @i_tasa
                 and ca_periodo = @i_periodo
                 and ca_modalidad = @i_modalidad)
   begin
      -- Si existe la caracteristica de tasa desplegar error y salir
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151101
	return 1
   end

   begin tran
   --Insertar el registro
   insert into te_caracteristicas_tasa (ca_tasa,ca_periodo,
          ca_modalidad, ca_estado,  ca_rango, ca_nro_tasas)
   values (@i_tasa, @i_periodo, 
           @i_modalidad, @i_estado, @i_rango, @i_nro_tasas)

   if @@error != 0
   begin
      -- Si hay error al ingresar el registro desplegar error y salir
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153045
	return 1
   end

    -- Ingresar transaccion de servicio
    insert into ts_caracteristicas_tasa (
           secuencia, tipo_transaccion, clase, fecha,
	   oficina_s, usuario, terminal_s, srv, lsrv,
	   tasa, periodo, modalidad, estado,
           rango, nro_tasas)
    values (@s_ssn, 15191, 'N', @s_date,
	    @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
	    @i_tasa, @i_periodo, @i_modalidad, @i_estado, 
            @i_rango, @i_nro_tasas)

     -- Si no se puede insertar la transaccion de servicio error y salir
     if @@error != 0
     begin
	  exec sp_cerror 
		@t_debug= @t_debug,
		@t_file = @t_file,
		@t_from = @w_sp_name,
		@i_num  = 153023
	  return 1
     end

     /*********************************************************************************/
     /* CNA 30/10/2001 : Este cambio debe ser descomentado para la interfaz con Cartera
     --LuisG-tref
     declare  
     @w_descripcion descripcion


     select @w_descripcion = tr_descripcion
     from te_tasas_referenciales 
     where tr_tasa = @i_tasa

     exec @w_return = cob_cartera..sp_valor_referencial 
     @s_date          = @s_date,
     @s_ofi           = @s_ofi,
     @s_term          = @s_term,
     @s_user          = @s_user,
     @i_operacion     = 'I',
     @i_modo          = 0 ,

     @i_tipo          = @i_tasa , 
     @i_descripcion   = @w_descripcion ,
     @i_modalidad     = @i_modalidad ,
     @i_periodicidad  = @i_periodo ,
     @i_estado        = @i_estado , 
     @i_rango_unico   = @i_rango

     if @w_return != 0
     begin
	  exec sp_cerror 
		@t_debug= @t_debug,
		@t_file = @t_file,
		@t_from = @w_sp_name,
		@i_num  = 153023
	  return 1
     end

     --LuisG-fin
     *********************************************************************************/

   commit tran
   return 0
end

-- Si la operacion es modificacion de tasa           
if @i_operacion = "U"
begin 	                           

   --Verificar que exista la caracteristica de tasa que se desea modificar
   if not exists (select *
                from te_caracteristicas_tasa
               where ca_tasa = @i_tasa
                 and ca_periodo = @i_periodo
                 and ca_modalidad = @i_modalidad)
   begin
      -- Si no existe la caracteristica de tasa desplegar error y salir
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151102
	return 1
   end
	
   -- Capturar la informaci¢n a modificar para transaccion de servicio
   select @w_estado = ca_estado,
          @w_rango = ca_rango,
          @w_nro_tasas = ca_nro_tasas
     from te_caracteristicas_tasa
    where ca_tasa = @i_tasa
      and ca_periodo = @i_periodo
      and ca_modalidad = @i_modalidad

   begin  tran
   -- Modificar el registro
   update te_caracteristicas_tasa
      set ca_estado = @i_estado,
          ca_rango = @i_rango,
          ca_nro_tasas = @i_nro_tasas
    where ca_tasa = @i_tasa
      and ca_periodo = @i_periodo
      and ca_modalidad = @i_modalidad 

   -- Si hay error al modificar reportarlo y salir
   if @@error != 0
     begin
	  exec sp_cerror 
		@t_debug= @t_debug,
		@t_file = @t_file,
		@t_from = @w_sp_name,
		@i_num  = 155047
	  return 1
     end

     /*********************************************************************************/
     /* CNA 30/10/2001 : Este cambio debe ser descomentado para la interfaz con Cartera
     --LuisG-tref

     select @w_descripcion = tr_descripcion
     from te_tasas_referenciales 
     where tr_tasa = @i_tasa

     exec @w_return = cob_cartera..sp_valor_referencial 
     @s_date          = @s_date,
     @s_ofi           = @s_ofi,
     @s_term          = @s_term,
     @s_user          = @s_user,
     @i_operacion     = 'I',
     @i_modo          = 0 ,
     @i_tipo          = @i_tasa , 
     @i_descripcion   = @w_descripcion ,
     @i_modalidad     = @i_modalidad ,
     @i_periodicidad  = @i_periodo ,
     @i_estado        = @i_estado , 
     @i_rango_unico   = @i_rango

     if @w_return != 0
     begin
	  exec sp_cerror 
		@t_debug= @t_debug,
		@t_file = @t_file,
		@t_from = @w_sp_name,
		@i_num  = 153023
	  return 1
     end

     --LuisG-fin
     *********************************************************************************/


   
    -- Insertar transacciones de servicio
    -- Si existe error al insertar las transacciones de servicio error y salir
    insert into ts_caracteristicas_tasa (
           secuencia, tipo_transaccion, clase, fecha,
	   oficina_s, usuario, terminal_s, srv, lsrv,
	   tasa, periodo, modalidad, estado,
           rango, nro_tasas)
    values (@s_ssn, 15192, 'P', @s_date,
	    @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
	    @i_tasa, @i_periodo, @i_modalidad, @w_estado,
            @w_rango, @w_nro_tasas )

     -- Si no se puede insertar la transaccion de servicio error y salir
     if @@error != 0
     begin
	  exec sp_cerror 
		@t_debug= @t_debug,
		@t_file = @t_file,
		@t_from = @w_sp_name,
		@i_num  = 153023
	  return 1
     end

    -- Ingresar transaccion de servicio
    insert into ts_caracteristicas_tasa (
           secuencia, tipo_transaccion, clase, fecha,
	   oficina_s, usuario, terminal_s, srv, lsrv,
	   tasa, periodo, modalidad, estado,
           rango, nro_tasas)
    values (@s_ssn, 15192, 'A', @s_date,
	    @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
	    @i_tasa, @i_periodo, @i_modalidad, @i_estado,
            @i_rango, @i_nro_tasas )


     -- Si no se puede insertar la transaccion de servicio error y salir
     if @@error != 0
     begin
	  exec sp_cerror 
		@t_debug= @t_debug,
		@t_file = @t_file,
		@t_from = @w_sp_name,
		@i_num  = 153023
	  return 1
     end



   commit tran 
   return 0
end

-- Si la operacion es busqueda de todas las tasas
if @i_operacion = "S"
begin 	  
set rowcount 20                         
   select "TASA" = ca_tasa,
          "PERIODO" = ca_periodo,
          "MODALIDAD" = ca_modalidad,
          "ESTADO" = ca_estado,
          "DESCRIPCION" = tr_descripcion,
          "T. RANGO" = ca_rango,
          "NRO TASAS PM" = ca_nro_tasas
     from te_tasas_referenciales, te_caracteristicas_tasa
    where tr_tasa = ca_tasa
      and (@i_modo <> 1 
           or (ca_tasa > @i_tasa
               or (ca_tasa = @i_tasa
                   and ca_periodo > @i_periodo)
               or (ca_tasa = @i_tasa
                   and ca_periodo = @i_periodo
                   and ca_modalidad > @i_modalidad)
              )
          )
    order by ca_tasa, ca_periodo, ca_modalidad 
set rowcount 0
return 0
end

-- Si la operaci¢n es Consulta de una tasa espec¡fica
if @i_operacion = "Q"
begin
  if @i_destino = "F"
  begin
   if @i_modo = 0
   begin
     print "en select"
     select "TASA" = ca_tasa,
            "PERIODO" = ca_periodo,
            "MODALIDAD" = ca_modalidad,
            "DESCRIPCION" = tr_descripcion,
            "ESTADO" = ca_estado,
            "RANGO" = ca_rango,
            "NRO TASAS PM" = ca_nro_tasas
       from te_tasas_referenciales, te_caracteristicas_tasa
      where ca_tasa = tr_tasa
        and ca_tasa = @i_tasa
   end
   if @i_modo = 1
     select "TASA" = ca_tasa,
            "PERIODO" = ca_periodo,
            "MODALIDAD" = ca_modalidad,
            "DESCRIPCION" = tr_descripcion,
            "ESTADO" = ca_estado,
            "RANGO" = ca_rango,
            "NRO TASAS PM" = ca_nro_tasas
       from te_tasas_referenciales, te_caracteristicas_tasa
      where ca_tasa = tr_tasa
        and ca_tasa = @i_tasa
        and ca_periodo = @i_periodo
        and ca_modalidad = @i_modalidad
  end
  else
  begin
   if @i_modo = 0
     select @o_tasa = ca_tasa,
            @o_periodo = ca_periodo,
            @o_modalidad = ca_modalidad,
            @o_descripcion = tr_descripcion,
            @o_estado = ca_estado,
            @o_rango = ca_rango,
            @o_nro_tasas = ca_nro_tasas
       from te_tasas_referenciales, te_caracteristicas_tasa
      where ca_tasa = tr_tasa
        and ca_tasa = @i_tasa
   if @i_modo = 1
     select @o_tasa = ca_tasa,
            @o_periodo = ca_periodo,
            @o_modalidad = ca_modalidad,
            @o_descripcion = tr_descripcion,
            @o_estado = ca_estado,
            @o_rango = ca_rango,
            @o_nro_tasas = ca_nro_tasas
       from te_tasas_referenciales, te_caracteristicas_tasa
      where ca_tasa = tr_tasa
        and ca_tasa = @i_tasa
        and ca_periodo = @i_periodo
        and ca_modalidad = @i_modalidad
   end
  return 0
end

-- Si la operacion es CONSULTA GENERAL para ayuda
if @i_operacion = "H"
begin

  set rowcount 20
  -- Si el criterio es por codigo de tasa
  if @i_criterio = "C"

     -- Seleccionar los registros de 20 en 20 ordenados por codigo
     select "TASA" = ca_tasa,
            "PERIODO" = ca_periodo,
            "MODALIDAD" = ca_modalidad,
            "DESCRIPCION" = tr_descripcion,
            "ESTADO" = ca_estado,
            "RANGO" = ca_rango,
            "NRO TASAS PM" = ca_nro_tasas
       from te_tasas_referenciales, te_caracteristicas_tasa
      where ca_tasa like @i_tasa
        and (@i_modo <> 1 or (ca_tasa > @i_tasa_sig)
                          or (ca_tasa = @i_tasa_sig
                              and ca_periodo > @i_periodo)
                          or (ca_tasa = @i_tasa_sig
                              and ca_periodo = @i_periodo
                              and ca_modalidad > @i_modalidad)
            )
        and (@i_tipo <> "V" or ca_estado = "V")
        and ca_tasa = tr_tasa
      order by ca_tasa
       
  -- Si el criterio es por descripcion de tasa
  if @i_criterio = "D"

     -- Seleccionar los registros de 20 en 20 ordenados por descripcion
     select "TASA" = ca_tasa,
            "PERIODO" = ca_periodo,
            "MODALIDAD" = ca_modalidad,
            "DESCRIPCION" = tr_descripcion,
            "ESTADO" = ca_estado,
            "RANGO" = ca_rango,
            "NRO TASAS PM" = ca_nro_tasas
       from te_tasas_referenciales, te_caracteristicas_tasa
      where tr_descripcion like @i_descripcion
        and (@i_modo <> 1 or (tr_descripcion > @i_descripcion_sig)
                          or (tr_descripcion = @i_descripcion_sig
                              and ca_periodo > @i_periodo)
                          or (tr_descripcion = @i_descripcion_sig
                              and ca_periodo = @i_periodo
                              and ca_modalidad > @i_modalidad)
            )
        and (@i_tipo <> "V" or ca_estado = "V")
        and ca_tasa = tr_tasa
      order by tr_descripcion

  set rowcount 0   
  return 0
end

go
