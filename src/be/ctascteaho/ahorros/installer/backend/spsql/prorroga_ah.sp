/************************************************************************/
/*  Archivo:            prorroga_ah.sp                                  */
/*  Stored procedure:   sp_prorroga_ah                                  */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Jaime Hidalgo                                   */
/*  Fecha de escritura: 11-Dic-2002                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Este programa realiza la prorroga de transacciones de               */
/*  Cuentas de Ahorros.                                                 */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA          AUTOR           RAZON                                */
/*  11/Dic/2002   J. Hidalgo    Emision Inicial                         */
/*  17/Feb/2010   J. Loyo       Manejo de la fecha de efectivizacion    */
/*                              teniendo el sabado como habil           */
/*  02/May/2016   Juan Tagle    Migración a CEN                         */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_prorroga_ah')
        drop proc sp_prorroga_ah
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_prorroga_ah(
        @t_show_version    bit = 0,
        @s_rol             smallint = null,
        @i_filial          tinyint,
        @i_fecha_deposito  datetime,
        @i_agencia         smallint,
        @i_turno           smallint,
        @o_procesadas      int      out
)
as
declare @w_return          int,
        @w_sp_name         varchar(30),
        @w_contador        int,
        @w_ctacte          int,
        @w_cta_banco       cuenta,
        @w_ciudad          int,
        @w_fecha_efe_orig  smalldatetime,
        @w_nueva_fecha_efe smalldatetime,
        @w_dias_ret        tinyint,
        @w_cont            tinyint,
        @w_tot_chq_locales money,
        @w_fecha_depo      datetime,
        @w_12h             money,
        @w_24h             money,
        @w_hora_ejecucion  smalldatetime

/*  Captura nombre de Stored Procedure  */
select @w_sp_name        = 'sp_prorroga_ah'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

select @w_hora_ejecucion = convert(varchar(5),getdate(),108)


/* Inicializacion de variables */
select @w_contador = 0

/*** Este valor se devuelve en el sp_fecha_habil   ***/
--Determinar el codigo de la ciudad de la compensacion
--select @w_ciudad = of_ciudad
--from cobis..cl_oficina
--where of_oficina = @i_agencia

/* Determinar el numero de dias de retencion para la ciudad */
        select @w_dias_ret = rl_dias
          from cob_ahorros..ah_retencion_locales
         where rl_agencia = @i_agencia
    and @w_hora_ejecucion between rl_hora_inicio and rl_hora_fin


       if @@rowcount = 0
       begin    /* Determinar el parametro general */
             select @w_dias_ret = pa_tinyint
               from cobis..cl_parametro
              where pa_producto = 'AHO'
                and pa_nemonico = 'DIRE'
             if @@rowcount = 0
             begin
                  exec cobis..sp_cerror
                      @t_from         = @w_sp_name,
                      @i_num          = 205001
                     return 205001
             end
       end

/* Determinar la fecha de efectivizacion de los registros
   depositados en la fecha indicada */
--  select @w_fecha_efe_orig = dateadd(dd,1,@i_fecha_deposito),
--         @w_cont = 1

--      while @w_cont <= (@w_dias_ret - 1)
--            if exists (select 1
--                         from cobis..cl_dias_feriados
--                        where df_ciudad = @w_ciudad
--                            and df_fecha  = @w_fecha_efe_orig)
--                 select @w_fecha_efe_orig = dateadd(dd,1,@w_fecha_efe_orig)
--            else
--               begin
--          select @w_cont = @w_cont + 1
--      if @w_cont <= @w_dias_ret - 1
--                   select @w_fecha_efe_orig = dateadd(dd,1,@w_fecha_efe_orig)
--         end
/*** La determinacion del siguiente dia laboral  se             ****/
/*** hace mediante el llamado al siguiente sp  - JLOYO          ****/
    exec @w_return = cob_remesas..sp_fecha_habil
            @i_val_dif  = 'N',
            @i_efec_dia = 'S',
            @i_fecha    = @i_fecha_deposito,
            @i_oficina  = @i_agencia,
            @i_dif      = 'N',               /**** Ingreso en  horario normal  ***/
            @w_dias_ret = @w_dias_ret,       /*** Dia siguiente habil          ***/
            @o_ciudad   = @w_ciudad          out,
            @o_fecha_sig= @w_fecha_efe_orig  out

    if @w_return <> 0
        return @w_return

/* Determinar la nueva fecha de efectivizacion de los registros
    que se desean prorrogar */

--  select @w_dias_ret = 1
--  select @w_nueva_fecha_efe = dateadd(dd,1,@w_fecha_efe_orig),
--         @w_cont = 1

--      while @w_cont <= (@w_dias_ret - 1)
--            if exists (select df_fecha
--                         from cobis..cl_dias_feriados
--                        where df_ciudad = @w_ciudad
--                          and df_fecha = @w_nueva_fecha_efe)
--                 select @w_nueva_fecha_efe = dateadd(dd,1,@w_nueva_fecha_efe)
--            else
--               begin
--          select @w_cont = @w_cont + 1
--      if @w_cont <= @w_dias_ret - 1
--                   select @w_nueva_fecha_efe = dateadd(dd,1,@w_nueva_fecha_efe)
--         end

/*** La determinacion del siguiente dia laboral  se             ****/
/*** hace mediante el llamado al siguiente sp  - JLOYO          ****/
    exec @w_return = cob_remesas..sp_fecha_habil
            @i_val_dif  = 'N',
            @i_efec_dia = 'S',
            @i_fecha    = @w_fecha_efe_orig,
            @i_oficina  = @i_agencia,
            @i_dif      = 'N',               /**** Ingreso en  horario normal  ***/
            @w_dias_ret = @w_dias_ret,       /*** Dia siguiente habil          ***/
            @o_ciudad   = @w_ciudad          out,
            @o_fecha_sig= @w_nueva_fecha_efe out

    if @w_return <> 0
        return @w_return

declare ahprorro cursor
for select hm_cta_banco,
           sum(hm_chq_locales)
  from cob_ahorros_his..ah_his_movimiento
 where hm_tipo_tran in (251, 252)
   and hm_turno   = @i_turno
   and hm_oficina = @i_agencia
   and hm_fecha   = @i_fecha_deposito
 group by hm_cta_banco

open ahprorro
fetch ahprorro into
    @w_cta_banco,
    @w_tot_chq_locales

if @@fetch_status = -1
begin
     close ahprorro
     deallocate ahprorro
     exec cobis..sp_cerror
         @i_num       = 201157
     select @o_procesadas = @w_contador
     return 201157
end
else
if @@fetch_status = -2
begin
     close ahprorro
     deallocate ahprorro
     select @o_procesadas = @w_contador
     return 0
end

while @@fetch_status = 0
begin

    begin tran

    select  @w_ctacte   = ah_cuenta,
        @w_12h      = ah_12h
    from cob_ahorros..ah_cuenta
    where ah_cta_banco = @w_cta_banco

    if @w_12h < @w_tot_chq_locales
    begin
        print 'Procesando ...1'

        rollback tran

        insert into cob_remesas..re_error_batch
        values (@w_cta_banco, 'FONDOS YA EFECTIVIZADOS')

        if @@error <> 0
                     begin
                         /* Error en grabacion de archivo de errores */
                         exec cobis..sp_cerror
                              @i_num       = 203056

                        /* Cerrar y liberar cursor */
                        close ahprorro
                        deallocate ahprorro

                        select @o_procesadas = @w_contador
                        return 203056
                     end
        goto LEER
    end


    select * from ah_ciudad_deposito
    where cd_cuenta       = @w_ctacte
    and cd_ciudad         = @w_ciudad
    and cd_fecha_depo     = @i_fecha_deposito
    and cd_fecha_efe      = @w_fecha_efe_orig
        and cd_valor_efe        >= @w_tot_chq_locales
    and (cd_efectivizado  = 'N'
     or   cd_efectivizado is null)

    if @@rowcount <> 1
    begin
        print 'Procesando ...2'

        rollback tran

        insert into cob_remesas..re_error_batch
        values (@w_cta_banco, 'CUENTA NO TIENE MONTO PENDIENTE DE LIBERACION')

        if @@error <> 0
        begin

               /* Error en grabacion de archivo de errores */
               exec cobis..sp_cerror
                    @i_num       = 203056

              /* Cerrar y liberar cursor */
              close ahprorro
              deallocate ahprorro

              select @o_procesadas = @w_contador
              return 203056
        end
        goto LEER
    end
    else
    begin
        update ah_cuenta
            set ah_12h  = ah_12h - @w_tot_chq_locales,
                ah_24h  = ah_24h + @w_tot_chq_locales
        where ah_cuenta = @w_ctacte

        if @@error <> 0
                     begin

                         /* Error en actualizacion ah_cuenta */
                         exec cobis..sp_cerror
                              @i_num       = 255001

                        /* Cerrar y liberar cursor */
                        close ahprorro
                        deallocate ahprorro

                        select @o_procesadas = @w_contador
                        return 255001
                     end
    end /* if @@rowcount <> 1 */


    /* Actualizacion de ah_ciudad_deposito del registro
       actual para restarle el valor prorrogado */

    update ah_ciudad_deposito
      set cd_valor_efe = cd_valor_efe - @w_tot_chq_locales
    where cd_cuenta     = @w_ctacte
    and   cd_ciudad     = @w_ciudad
    and   cd_fecha_depo = @i_fecha_deposito
    and   cd_fecha_efe  = @w_fecha_efe_orig
    and   cd_valor_efe     >= @w_tot_chq_locales
    and   cd_valor      >= @w_tot_chq_locales
    and  (cd_efectivizado   = 'N'
        or cd_efectivizado    is null)

    if @@error <> 0
    begin
        /* Error en actualizacion ah_ciudad_deposito */
        exec cobis..sp_cerror
            @i_num       = 205052

        /* Cerrar y liberar cursor */
        close ahprorro
        deallocate ahprorro

        select @o_procesadas = @w_contador
        return 205052
    end

    /* Actualizacion o insercion de ah_ciudad_deposito
       para la nueva fecha de efectivizaci=n */

    select @w_fecha_depo = cd_fecha_depo
    from ah_ciudad_deposito
    where cd_cuenta     = @w_ctacte
    and   cd_ciudad     = @w_ciudad
    and cd_fecha_efe    = @w_nueva_fecha_efe

    if @@rowcount = 0
    begin
        /* Insercion de registro en ah_ciudad_deposito */
        insert into ah_ciudad_deposito
        (cd_cuenta, cd_ciudad, cd_fecha_depo,
                 cd_fecha_efe, cd_valor,cd_valor_efe, cd_efectivizado)
        values
        (@w_ctacte, @w_ciudad, @i_fecha_deposito,
                 @w_nueva_fecha_efe, @w_tot_chq_locales,@w_tot_chq_locales, 'N')

        if @@error <> 0
        begin
        print 'Procesando ...3'

        rollback tran

        insert into cob_remesas..re_error_batch
        values (@w_cta_banco, 'ERROR AL INSERTAR EN CIUDAD DEPOSITO')

        if @@error <> 0
        begin

                /* Error en grabacion de archivo de errores */
                exec cobis..sp_cerror
                     @i_num       = 203056

               /* Cerrar y liberar cursor */
               close ahprorro
               deallocate ahprorro

               select @o_procesadas = @w_contador
               return 203056
        end
        goto LEER
        end
    end
    else
    begin
        /* Actualizacion de ah_ciudad_deposito */
        update ah_ciudad_deposito
                set   cd_valor_efe   = cd_valor_efe + @w_tot_chq_locales
        where   cd_cuenta   = @w_ctacte
        and cd_ciudad   = @w_ciudad
        and cd_fecha_depo   = @w_fecha_depo
        and cd_fecha_efe    = @w_nueva_fecha_efe

        if @@error <> 0
        begin
        print 'Procesando ...4'

        rollback tran

        insert into cob_remesas..re_error_batch
        values (@w_cta_banco, 'ERROR AL ACTUALIZAR CIUDAD DEPOSITO')

        if @@error <> 0
                     begin

                         /* Error en grabacion de archivo de errores */
                         exec cobis..sp_cerror
                              @i_num       = 203056

                        /* Cerrar y liberar cursor */
                        close ahprorro
                        deallocate ahprorro

                        select @o_procesadas = @w_contador
                        return 203056
                     end
        goto LEER
        end
    end

    commit tran

LEER:

     select @w_contador = @w_contador + 1

     fetch ahprorro into
            @w_cta_banco,
            @w_tot_chq_locales

        if @@fetch_status = -1
        begin
             close ahprorro
             deallocate ahprorro
             exec cobis..sp_cerror
                 @i_num       = 201157
             select @o_procesadas = @w_contador
             return 201157
        end
end

commit tran

close ahprorro
deallocate ahprorro

select @o_procesadas = @w_contador
return 0


go

