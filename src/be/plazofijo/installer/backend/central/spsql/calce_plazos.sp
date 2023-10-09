/************************************************************************/
/*      Archivo:                calpla.sp                               */
/*      Stored procedure:       sp_calce_plazos                         */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               PLAZO FIJO                              */
/*      Disenado por:           Memito Saborio A.                       */
/*      Fecha de escritura:     29/ago/01                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'Banco Cuscatlan', representantes exclusivos                    */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de CUSCATLAN o su representante.          */
/*                              PROPOSITO                               */
/*      Este script ejecuta una serie de procesos que devuelven datos   */
/*      hacerca de montos por diferentes plazos de los depositos.       */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR                   RAZON                   */
/*      29/ago/01       Memito Saborio A        Creacion                */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_calce_plazos')
   drop proc sp_calce_plazos
go

create proc sp_calce_plazos  
@s_ssn                  int = NULL,
@s_user                 login = NULL,
@s_sesn                 int = NULL,
@s_term                 varchar(30) = NULL,
@s_date                 datetime = NULL,
@s_srv                  varchar(30) = NULL,
@s_lsrv                 varchar(30) = NULL,
@s_rol                  smallint = NULL,
@s_ofi                  smallint = NULL,
@s_org_err              char(1) = NULL,
@s_error                int = NULL,
@s_sev                  tinyint = NULL,
@s_msg                  descripcion = NULL,
@s_org                  char(1) =     NULL,
@t_debug                char(1) =     'N',
@t_file                 varchar(14) = NULL,
@t_from                 varchar(32) = NULL,
@t_trn                  smallint    = NULL,
@i_fecha                datetime
with encryption
as
declare
   @w_sp_name     descripcion,
   @w_return      int,
   @w_contador     smallint,
   @w_error       int,
   @w_mo_moneda            smallint,
   @w_mo_descripcion    varchar(25),
   @w_op_moneda            smallint,
   @w_op_monto             money,
   @w_plazo_inicial     smallint,
   @w_plazo_final       smallint,
   @w_factor                  float


if @t_trn <> 14453 begin
   exec cobis..sp_cerror
      @t_debug      = @t_debug,
      @t_file       = @t_file,
      @t_from       = @w_sp_name,
      @i_num        = 141018
   /*  'Error en codigo de transaccion' */
   return 1
end

/** CREACION DE LA TABLA CON LOS DATOS **/
create table #plazo$(
  moneda smallint,
  descripcion  varchar(25) NULL,
  plazo1  money,  -- A la vista
  plazo2 money,  -- 1 a 30
  plazo3 money,  -- 31 a 60
  plazo4 money,  -- 61 a 90
  plazo5 money,  -- 91 a 180
  plazo6 money,  -- 181 a 365
  total     money   -- total final
)

create table #plazo(
  numero smallint,
  plazo1 smallint,
  plazo2 smallint
)

/*** LLENO LA TABLA DE REPORTE CON LAS DIFERENTES MONEDAS ***/
insert #plazo$(
  moneda, descripcion, plazo1, plazo2,
  plazo3, plazo4, plazo5, plazo6, total
)
select mo_moneda, mo_descripcion, 0, 0,
  0, 0, 0, 0, 0
from cobis..cl_moneda
where mo_moneda in (1,2)

/** LLENANDO LA TABLA DE PLAZOS **/
insert #plazo
values(1, 1, 30)
insert #plazo
values(2, 31, 60)
insert #plazo
values(3, 61, 90)
insert #plazo
values(4, 91, 180)
insert #plazo
values(5, 181, 365)
insert #plazo
values(6, 366, 30000)

/** CARGADO DE LOS PARAMETROS DE CARTERA **/
select @w_sp_name = 'sp_calce_plazos'

/** REALIZANDO EL PROCESO DE LLENAR LA TABLA DE PLAZOS **/

select @w_contador = 1
WHILE @w_contador <= 6 begin
  /** SE OBTIENE LOS PLAZOS PARA EL CURSOR CORRESPONDIENTE **/
   select @w_plazo_inicial = plazo1, @w_plazo_final = plazo2
   from #plazo
   where numero = @w_contador
   
  /** CURSOR QUE DEVUELVE POR MONEDA EL MONTO DE CAPITAL DEL DEPOSITO **/
   declare cursor_operacion cursor
   for 
   select op_moneda, isnull(sum(op_monto), 0)
            -- intereses >>>>> sum(op_int_estimado) &op_int_estimado <<<<<
   from pf_operacion
   where op_fecha_ven > @i_fecha
      and op_estado in ('ACT','VEN')
      and datediff(dd,@i_fecha, op_fecha_ven) >= @w_plazo_inicial
      and datediff(dd,@i_fecha, op_fecha_ven) <= @w_plazo_final
   group by op_moneda
   for read only

   open cursor_operacion

   while (1 = 1) begin  
      fetch cursor_operacion into @w_op_moneda, @w_op_monto
   
      if @@fetch_status = -1
         break
        
      if @@fetch_status = -2 begin
         close cursor_operacion
         deallocate cursor_operacion
         raiserror ('200001 - Fallo lectura del cursor ', 16, 1)
         return 0
      end
      
      /**** Se busca el tipo de cambio para la moneda en particular ****/
      exec sp_tipocambio @t_trn = 14439, @i_fecha = @i_fecha, 
                                  @i_moneda = @w_op_moneda, @o_factor = @w_factor output
      
      /**** Se multiplica el monto por el factor de tipo de cambio ***/
      select @w_op_monto = @w_op_monto * @w_factor
      
      /**** Se ingresan los datos a las tablas correspondientes ***/
      if @w_contador = 1 
      update #plazo$
        set plazo1 = @w_op_monto
        where moneda = @w_op_moneda
        
      if @w_contador = 2 
        update #plazo$
        set plazo2 = @w_op_monto
      where moneda = @w_op_moneda

      if @w_contador = 3 
        update #plazo$
        set plazo3 = @w_op_monto
      where moneda = @w_op_moneda

      if @w_contador = 4 
        update #plazo$
        set plazo4 = @w_op_monto
      where moneda = @w_op_moneda

      if @w_contador = 5 
        update #plazo$
        set plazo5 = @w_op_monto
      where moneda = @w_op_moneda

      if @w_contador = 6
        update #plazo$
        set plazo6 = @w_op_monto
      where moneda = @w_op_moneda
   end /* while del cursor */
   
   close cursor_operacion
   deallocate cursor_operacion
   
  select @w_contador = @w_contador + 1
end /*while @wcontador*/

/*** Se hace la suma total por moneda ***/
update #plazo$
set total = plazo1 + plazo2 + plazo3 + plazo4 + plazo5 + plazo6

/*** Se devuelve al front - end los datos solicitados **/
select descripcion, plazo1, plazo2, plazo3, plazo4, plazo5, plazo6, total
from #plazo$

go

