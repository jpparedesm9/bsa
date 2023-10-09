/************************************************************************/
/*   Archivo:              prcolate.sp                                  */
/*   Stored procedure:     sp_procesa_colateral                         */
/*   Disenado por:         Monica Vidal                                 */
/*   Fecha de escritura:   08/07/07                                     */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                              PROPOSITO                               */
/*   Procesar las custodias o colaterales de manera que se a›adan o     */
/*   se eliminen asociaciones de pagares segun se requiera para         */
/*   mantener el valor de cobertura requerido.                          */
/************************************************************************/

use cob_custodia
go


if exists (select 1 from sysobjects where name = 'sp_procesa_colateral')
   drop proc sp_procesa_colateral
go


create proc sp_procesa_colateral
@i_fecha_proc         datetime     = null,    --FECHA DE PROCESO
@i_simulacion         char(1)      = 'S'      --SIMULACION (S/N)

as
declare
@w_error             int,
@w_rows              int,
@w_fecha_hora        datetime,
@w_sp_name           varchar(30),
@w_msg               varchar(130),
@w_term              varchar(30),
@w_user              login,
@w_ficticio          char(1),
/* DATOS DE LA OPERACION PASIVA*/
@w_ente_pas          int,
@w_codigo_pas        cuenta,
@w_valor_cob         money,
@w_saldo_cob         money,
/* DATOS DE LA OPERACION ACTIVA */
@w_banco_act         cuenta,
@w_toperacion        catalogo,
@w_monto             money,
@w_calificacion      varchar(10),
@w_tasa              float,
@w_fecha_ini         datetime,
@w_fecha_fin         datetime,
@w_cliente           int,
@w_oficina           smallint,
@w_orden             int,
@w_saldo_cap         money,
@w_saldo_int         money,
@w_amor_cap          catalogo,
@w_amor_int          catalogo



select
@w_sp_name        = 'sp_procesa_colateral',
@w_fecha_hora     = getdate()

select @i_fecha_proc = isnull(@i_fecha_proc, fp_fecha)
from   cobis..ba_fecha_proceso

select *
into #universo
from   cu_universo_pagares_col
where  un_estado     = 'D' --DISPONIBLE
and    un_nueva      = 'S'
order by un_ente_pas, un_codigo_pas, un_orden, un_banco
 
create clustered index idx1 on #universo(un_ente_pas, un_codigo_pas, un_banco)
create index idx2 on #universo(un_orden, un_banco)

/* CREO TABLA TEMPORAL PARA ALMACENAR REGISTROS A ELIMINAR */
select
oe_banco         = cdt_banco_act,
oe_toperacion    = cdt_toperacion,
oe_cliente       = cdt_cliente,
oe_oficina       = cdt_oficina,
oe_orden         = cdt_orden,
oe_monto         = cdt_monto,
oe_tasa          = cdt_tasa,
oe_calificacion  = cdt_calificacion,
oe_fecha_ini     = cdt_fecha_ini,
oe_fecha_fin     = cdt_fecha_fin,
oe_saldo_cap     = cdt_saldo_cap,
oe_saldo_int     = cdt_saldo_int,
oe_amor_cap      = cdt_amor_cap,
oe_amor_int      = cdt_amor_int
into   #tmp_elim
from   cu_colateral_det_tmp
where  1 = 2

declare cursor_op_pasivas cursor for select
se_codigo,     se_ente,       se_cobertura,
se_ficticio
from  cu_sal_entidad_ext
where se_fecha = @i_fecha_proc

open  cursor_op_pasivas

fetch cursor_op_pasivas into
@w_codigo_pas,  @w_ente_pas, @w_valor_cob,
@w_ficticio

while @@fetch_status = 0 begin

   if @@fetch_status = -1 begin
      select @w_msg   = 'ERROR EN EL CURSOR'
      goto ERROR
   end   

   print 'ente_pas ' + cast(@w_ente_pas as varchar)

   --SI LA OPERACION NO ES FICTICIA OBTENGO LAS OPERACIONES QUE ENTRAN/SALEN DE LA CUSTODIA
   if @w_ficticio = 'N' begin
      truncate table #tmp_elim

      --INSERTO EN UNA TABLA TEMPORAL LOS DATOS DE LOS PAGARES QUE TENGO ASOCIADOS A LA OP. PASIVA
      insert into #tmp_elim(
      oe_banco,          oe_toperacion,     oe_orden,
      oe_cliente,        oe_oficina,        oe_monto,
      oe_tasa,           oe_calificacion,   oe_fecha_ini,
      oe_fecha_fin,      oe_saldo_cap,      oe_saldo_int,
      oe_amor_cap,       oe_amor_int)
      select
      cdt_banco_act,     cdt_toperacion,    cdt_orden,
      cdt_cliente,       cdt_oficina,       cdt_monto,
      cdt_tasa,          cdt_calificacion,  cdt_fecha_ini,
      cdt_fecha_fin,     cdt_saldo_cap,     cdt_saldo_int,
      cdt_amor_cap,      cdt_amor_int
      from   cu_colateral_det_tmp
      where  cdt_ente_pas         =  @w_ente_pas
      and    cdt_codigo_pas       =  @w_codigo_pas
      and    cdt_accion          <>  'T'

      --BORRO LAS QUE CUMPLAN CON LAS CONDICIONES PARA QUE ME QUEDEN LAS QUE DEBO SACAR
      delete #tmp_elim
      from   cu_universo_pagares_col
      where  un_banco    = oe_banco
      and    un_ente_pas = @w_ente_pas

      if @@error <> 0 begin
         select @w_msg   = 'ERROR AL ELIMINAR REGISTROS DE LA TABLA TEMPORAL'
         goto ERROR_CURSOR
      end

      update cu_colateral_det_tmp set
      cdt_accion = 'S' --SALEN
      from   #tmp_elim
      where  cdt_banco_act   = oe_banco
        and  cdt_ente_pas    = @w_ente_pas
        and  cdt_codigo_pas  = @w_codigo_pas
      
      if @@error <> 0 begin
         select @w_msg   = 'ERROR AL MODIFICAR REGISTROS QUE SALEN DE LA TABLA TEMPORAL'
         goto ERROR_CURSOR
      end

   end

   --OBTENGO EL SALDO DE COBERTURA ACTUALIZADO PARA LA OPERACION PASIVA QUE PROCESO
   select @w_saldo_cob = isnull(sum(isnull(cdt_saldo_cap, 0)),0)
   from   cu_colateral_det_tmp
   where  cdt_ente_pas   = @w_ente_pas
   and    cdt_codigo_pas = @w_codigo_pas
   and    cdt_accion    <> 'S'  --NO SUMO LAS QUE SALEN

   --LE ASIGNO CERO SI ES NULO, ESTO OCURRIRA, POR EJEMPLO PARA LAS EJECUCIONES PARCIALES
   select @w_saldo_cob = isnull(@w_saldo_cob, 0)

   --SI EL VALOR DE COBERTURA ES MAYOR AL SALDO DE COBERTURA LE INCORPORO NUEVAS OPERACIONES ACTIVAS
   if @w_valor_cob >  @w_saldo_cob begin
      select @w_banco_act = ''
      select @w_orden = 0
      

      /* RECORRO EL UNIVERSO DE OPERACIONES QUE CUMPLEN LAS CONDICIONES Y SON NUEVAS */
      while 1 = 1 begin

         set rowcount 1

         select
         @w_banco_act     = un_banco,
         @w_toperacion    = un_toperacion,
         @w_cliente       = un_cliente,
         @w_oficina       = un_oficina,
         @w_orden         = un_orden,
         @w_monto         = un_monto,
         @w_tasa          = un_tasa,
         @w_calificacion  = un_calificacion,
         @w_fecha_ini     = un_fecha_ini,
         @w_fecha_fin     = un_fecha_fin,
         @w_saldo_cap     = un_saldo_cap,
         @w_saldo_int     = un_saldo_int,
         @w_amor_cap      = un_amor_cap,
         @w_amor_int      = un_amor_int
         from   #universo
         where  un_ente_pas   = @w_ente_pas
         and    un_codigo_pas = @w_codigo_pas
         order by un_orden, un_banco

         if @@rowcount = 0 begin --NO HAY MAS ACTIVAS QUE CUMPLAN LAS CONDICIONES
            set rowcount 0
            break
         end
         set rowcount 0

         delete #universo
         where  un_ente_pas   = @w_ente_pas
         and    un_codigo_pas = @w_codigo_pas
         and    un_banco      = @w_banco_act

         update cu_universo_pagares_col set
         un_estado = 'A' --ASOCIADA
         where  un_banco = @w_banco_act

         if @@error <> 0 begin
            select @w_msg   = 'ERROR AL MARCAR COMO ASOCIADO REGISTRO EN EL UNIVERSO'
            goto ERROR_CURSOR
         end

         insert into cu_colateral_det_tmp(
         cdt_ente_pas,       cdt_codigo_pas,     cdt_orden,
         cdt_banco_act,      cdt_toperacion,     cdt_cliente,
         cdt_oficina,        cdt_monto,          cdt_tasa,
         cdt_calificacion,   cdt_fecha_ini,      cdt_fecha_fin,
         cdt_saldo_cap,      cdt_saldo_int,      cdt_amor_cap,
         cdt_amor_int,       cdt_fecha_proc,     cdt_accion)
         values(
         @w_ente_pas,        @w_codigo_pas,      @w_orden,
         @w_banco_act,       @w_toperacion,      @w_cliente,
         @w_oficina,         @w_monto,           @w_tasa,
         @w_calificacion,    @w_fecha_ini,       @w_fecha_fin,
         @w_saldo_cap,       @w_saldo_int,       @w_amor_cap,
         @w_amor_int,        @i_fecha_proc,      'E')--ENTRA

         if @@error <> 0 begin
            select @w_msg   = 'ERROR AL INSERTAR REGISTROS QUE ENTRAN DE LA TABLA TEMPORAL'
            goto ERROR_CURSOR
         end

         select @w_saldo_cob = @w_saldo_cob + @w_saldo_cap

         if @w_valor_cob < @w_saldo_cob   begin
            break
         end

      end -- cursor_op_activas
      select @w_banco_act = ''

   end else begin
      --SI EL VALOR DE COBERTURA ES MENOR AL SALDO DE COBERTURA MARCO OPERACIONES PARA QUE SALGAN HASTA COMPLETAR EL VALOR
      while @w_valor_cob < @w_saldo_cob begin
         set rowcount 1

         select
         @w_banco_act = cdt_banco_act,
         @w_saldo_cap     = cdt_saldo_cap
         from   cu_colateral_det_tmp
         where  cdt_ente_pas      = @w_ente_pas
         and    cdt_codigo_pas    = @w_codigo_pas
         and    cdt_accion        = 'M' --MANTIENE

         set rowcount 0

         --SI AL SUMAR EL SALDO DE LA OPERACION LLEGO AL SALDO DE COBERTURA SALGO
         if @w_valor_cob > @w_saldo_cob - @w_saldo_cap begin
            break
         end

         update cu_colateral_det_tmp set
         cdt_accion = 'S' --SALE
         where  cdt_ente_pas      = @w_ente_pas
         and    cdt_codigo_pas    = @w_codigo_pas
         and    cdt_banco_act     = @w_banco_act
         and    cdt_accion        = 'M' --MANTIENE

         if @@error <> 0 begin
            select @w_msg   = 'ERROR AL MODIFICAR REGISTROS QUE SALEN DE LA TABLA TEMPORAL (2)'
            goto ERROR_CURSOR
         end

         select @w_saldo_cob = @w_saldo_cob - @w_saldo_cap
      end

   end

   --SI NO ES SIMULACION INGRESO LOS REGISTROS EN LA TABLA DEFINITIVA (LOS QUE NO SALEN) Y
   if @i_simulacion = 'N' begin

      insert into cu_colateral_det(
      cd_ente_pas,        cd_codigo_pas,
      cd_banco_act,       cd_toperacion,      cd_cliente,
      cd_oficina,         cd_monto,           cd_tasa,
      cd_calificacion,    cd_fecha_ini,       cd_fecha_fin,
      cd_saldo_cap,       cd_saldo_int,       cd_amor_cap,
      cd_amor_int,        cd_fecha_proc)
      select
      cdt_ente_pas,       cdt_codigo_pas,
      cdt_banco_act,      cdt_toperacion,     cdt_cliente,
      cdt_oficina,        cdt_monto,          cdt_tasa,
      cdt_calificacion,   cdt_fecha_ini,      cdt_fecha_fin,
      cdt_saldo_cap,      cdt_saldo_int,      cdt_amor_cap,
      cdt_amor_int,       cdt_fecha_proc
      from  cu_colateral_det_tmp
      where cdt_accion in ('E', 'M') --LAS QUE ENTRAN Y LAS QUE SE MANTIENEN
      and   cdt_ente_pas   = @w_ente_pas
      and   cdt_codigo_pas = @w_codigo_pas

      if @@error <> 0 begin
         select @w_msg   = 'ERROR AL INSERTAR REGISTROS DE DETALLES DE COLATERAL'
         goto ERROR_CURSOR
      end

   end

   --INGRESO CON UNA ACCION T-TODAS LOS PAGARES QUE ENTRAN Y SE MANTIENEN PARA SU IMPRESION
   insert into cu_colateral_det_tmp(
   cdt_ente_pas,       cdt_codigo_pas,
   cdt_banco_act,      cdt_toperacion,     cdt_cliente,
   cdt_oficina,        cdt_monto,          cdt_tasa,
   cdt_calificacion,   cdt_fecha_ini,      cdt_fecha_fin,
   cdt_saldo_cap,      cdt_saldo_int,      cdt_amor_cap,
   cdt_amor_int,       cdt_fecha_proc,     cdt_orden,
   cdt_accion)
   select
   cdt_ente_pas,       cdt_codigo_pas,
   cdt_banco_act,      cdt_toperacion,     cdt_cliente,
   cdt_oficina,        cdt_monto,          cdt_tasa,
   cdt_calificacion,   cdt_fecha_ini,      cdt_fecha_fin,
   cdt_saldo_cap,      cdt_saldo_int,      cdt_amor_cap,
   cdt_amor_int,       cdt_fecha_proc,     cdt_orden,
   'T'
   from  cu_colateral_det_tmp
   where cdt_accion in ('E', 'M')
   and   cdt_ente_pas   = @w_ente_pas
   and   cdt_codigo_pas = @w_codigo_pas

   if @@error <> 0 begin
      select @w_msg   = 'ERROR AL INSERTAR REGISTROS DE DETALLES DE COLATERAL'
      goto ERROR_CURSOR
   end

   /* LLAMO AL SP QUE LLENA LAS TABLAS PARA HACER EL BCP */
   exec @w_error = sp_carga_bcps_pagares
   @i_fecha    = @i_fecha_proc,
   @i_cliente  = @w_ente_pas,
   @i_codigo   = @w_codigo_pas,
   @o_msg      = @w_msg      out

   if @w_error <> 0 goto ERROR_CURSOR

   goto SIGUIENTE

   ERROR_CURSOR:
   close cursor_op_pasivas
   deallocate cursor_op_pasivas
   goto ERROR

   SIGUIENTE:
   fetch cursor_op_pasivas into
   @w_codigo_pas,  @w_ente_pas, @w_valor_cob,
   @w_ficticio
end -- CURSOR_OP_PASIVAS

close cursor_op_pasivas
deallocate cursor_op_pasivas



return 0
ERROR:
   print @w_msg
   select @w_banco_act = isnull(@w_banco_act, 'ERROR GENERAL')

   exec sp_errorlog
   @i_fecha_proc    = @w_fecha_hora,
   @i_tran          = 19057,
   @i_garantia      = @w_banco_act,
   @i_descripcion   = @w_msg

   return 0

go






