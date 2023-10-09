/**************************************************************************/
/*   Archivo:                     ta_tasas.sp                             */
/*   Stored Procedure:            sp_tasas                                */
/*   Base de datos:               cobis                                   */
/*   Producto:                    Administrador                           */
/*   Disenado por:                Roberth Minga Vallejo                   */ 
/*   Fecha de escritura:          16 de Mayo del 2000                     */
/**************************************************************************/
/*                             IMPORTANTE                                 */
/*   Este programa es parte de los paquetes bancarios propiedad de        */
/*   "MACOSA", representantes exclusivos para el Ecuador de la            */
/*   "NCR CORPORATION".                                                   */
/*   Su uso no autorizado queda expresamente prohibido asi como cualquier */
/*   alteracion o agregado hecho por alguno de sus usuarios sin el debido */
/*   consentimiento por escrito de la preseidencia ejecutiva de MACOSA    */
/*   o su representante.                                                  */
/**************************************************************************/
/*                             PROPOSITO                                  */
/*   Permite dar mantenimiento y consultar las tasas referenciales        */
/**************************************************************************/
/*                            MODIFICACIONES                              */
/*   FECHA               AUTOR           RAZON                            */
/*   16/May/00           R. Minga        RMI16May00: Emision Inicial      */
/**************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_tare_tasas')
  drop proc sp_tare_tasas








go
create proc sp_tare_tasas (
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
        @t_debug	char(1) ='N',
        @t_file		varchar(14) = null,
        @t_from		descripcion = null,
        @t_trn          smallint,
        @i_operacion    char(1),
        @i_criterio     char(1) = null,
        @i_modo         tinyint = null,
        @i_tipo         char(1) = null,
        @i_tasa         catalogo = null,
        @i_descripcion  descripcion = null,
        @i_tasa_sig     catalogo = null,
        @i_descripcion_sig  descripcion = null,
        @i_estado       char(1) = null,
        @i_destino      char(1) = "F",
        @o_tasa         catalogo = null out,
        @o_descripcion  descripcion = null out,
        @o_estado       char(1) = null out
)
as

/*  declaracion de las variables de trabajo  */

declare
        @w_sp_name      varchar(30),
	@w_return	int,
        @w_descripcion  descripcion,
        @w_estado       char(1)

select @w_sp_name = 'sp_tare_tasas'

-- Evaluar si la transaccion no corresponde a la operacion
/* PES */
if (@t_trn <> 15221 and @i_operacion = "I") or 
   (@t_trn <> 15189 and @i_operacion = "U") or
   (@t_trn <> 15190 and @i_operacion in ("Q","S","H"))
begin
   -- Si no corresponde la transaccion, error y salir
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151051
	return 1
end

-- Si la operacion es INSERT
if @i_operacion = "I"
begin

  -- Evaluar si la tasa ya existe
  if exists (select * 
               from te_tasas_referenciales
              where tr_tasa = @i_tasa)
  begin
     -- Si existe, error y salir
     exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151103
	return 1
  end

  begin tran
    -- Insertar la tasa en la tabla
    insert into te_tasas_referenciales (tr_tasa, tr_descripcion,tr_estado)
           values (@i_tasa, @i_descripcion, @i_estado)

    -- Si no se puede insertar error y salir
    if @@error != 0
    begin
       exec sp_cerror
	     @t_debug	 = @t_debug,
	     @t_file	 = @t_file,
	     @t_from	 = @w_sp_name,
    	     @i_num	 = 153044
      	  return 1
    end

    -- Ingresar transaccion de servicio
    insert into ts_tasas_referenciales (
           secuencia, tipo_transaccion, clase, fecha,
	   oficina_s, usuario, terminal_s, srv, lsrv,
	 tasa, descripcion, estado)
    values (@s_ssn, 15221, 'N', @s_date,
	    @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
	    @i_tasa, @i_descripcion, @i_estado)

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

-- Si la operacion es MODIFICAR
if @i_operacion = "U"
begin
  -- Verificar si existe la tasa a modificar
  if not exists (select * 
               from te_tasas_referenciales
              where tr_tasa = @i_tasa)
  begin
     -- Si no existe error
    exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151100
	return 1
  end

  -- Guardar valores anteriores para transaccion de servicio
  select @w_descripcion = tr_descripcion,
         @w_estado = tr_estado
    from te_tasas_referenciales
   where tr_tasa = @i_tasa

  begin tran
    -- Modificar la tasa
    update te_tasas_referenciales
       set tr_descripcion = @i_descripcion,
           tr_estado = @i_estado
     where tr_tasa = @i_tasa

    -- Si existe error al modificar: salir
    if @@error != 0 
    begin
      exec sp_cerror
	     @t_debug	 = @t_debug,
	     @t_file	 = @t_file,
	     @t_from	 = @w_sp_name,
	     @i_num	 = 155046
	  return 1
    end

    -- Insertar transacciones de servicio
    -- Si existe error al insertar las transacciones de servicio error y salir
    insert into ts_tasas_referenciales (
           secuencia, tipo_transaccion, clase, fecha,
	   oficina_s, usuario, terminal_s, srv, lsrv,
	 tasa, descripcion, estado)
    values (@s_ssn, 15189, 'P', @s_date,
	    @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
	    @i_tasa, @w_descripcion, @w_estado)

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
    insert into ts_tasas_referenciales (
           secuencia, tipo_transaccion, clase, fecha,
	   oficina_s, usuario, terminal_s, srv, lsrv,
	 tasa, descripcion, estado)
    values (@s_ssn, 15189, 'A', @s_date,
	    @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
	    @i_tasa, @i_descripcion, @i_estado)

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

-- Si la operacion es CONSULTA GENERAL
if @i_operacion = "S"
begin

  set rowcount 20
  -- Si el criterio es por codigo de tasa
  if @i_criterio = "C"

     -- Seleccionar los registros de 20 en 20 ordenados por codigo
     select "TASA" = tr_tasa,
            "DESCRIPCION" = tr_descripcion,
            "ESTADO" = tr_estado,
            "DESC ESTADO" = b.valor
       from te_tasas_referenciales, cl_tabla a, cl_catalogo b
      where tr_tasa like @i_tasa
        and (@i_modo <> 1 or tr_tasa > @i_tasa_sig)
        and (@i_tipo <> "V" or tr_estado = "V")
        and tr_estado = b.codigo
        and b.tabla = a.codigo
        and a.tabla = "cl_estado_ser"
      order by tr_tasa, tr_estado
       
  -- Si el criterio es por descripcion de tasa
  if @i_criterio = "D"

     -- Seleccionar los registros de 20 en 20 ordenados por descripcion
     select "TASA" = tr_tasa,
            "DESCRIPCION" = tr_descripcion,
            "ESTADO" = tr_estado,
            "DESC ESTADO" = b.valor
       from te_tasas_referenciales, cl_tabla a, cl_catalogo b
      where tr_descripcion like @i_descripcion
        and (@i_modo <> 1 or tr_descripcion > @i_descripcion_sig)
        and (@i_tipo <> "V" or tr_estado = "V")
        and tr_estado = b.codigo
        and b.tabla = a.codigo
        and a.tabla = "cl_estado_ser"
      order by tr_descripcion, tr_estado

  set rowcount 0   
  return 0
end

-- Si la consulta es especifica acerca de todos los datos de una tasa
if @i_operacion = "Q"
begin
  if @i_destino = "F"
  begin
     select "TASA" = tr_tasa,
            "DESCRIPCION" = tr_descripcion,
            "ESTADO" = tr_estado
       from te_tasas_referenciales
      where tr_tasa = @i_tasa
        and tr_estado = "V"
  end
  else
  begin
     select @o_tasa = tr_tasa,
            @o_descripcion = tr_descripcion,
            @o_estado = tr_estado
       from te_tasas_referenciales
      where tr_tasa = @i_tasa
        and tr_estado = "V"
  end

  if @@rowcount = 0
  begin
	  exec sp_cerror 
		@t_debug= @t_debug,
		@t_file = @t_file,
		@t_from = @w_sp_name,
		@i_num  = 151100
	  return 1
   end
end   

-- Si la consulta es especifica de la descripcion
if @i_operacion = "H"
begin
     select "DESCRIPCION" = tr_descripcion
       from te_tasas_referenciales
      where tr_tasa = @i_tasa
        and tr_estado = "V"

     if @@rowcount = 0
     begin
	  exec sp_cerror 
		@t_debug= @t_debug,
		@t_file = @t_file,
		@t_from = @w_sp_name,
		@i_num  = 151100
	  return 1
     end
end   

go

