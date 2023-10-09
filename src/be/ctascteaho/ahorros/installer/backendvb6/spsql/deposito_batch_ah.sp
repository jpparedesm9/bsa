/************************************************************************/
/*  Archivo:            deposito_batch_ah.sp                            */
/*  Stored procedure:   sp_deposito_batch_ah                            */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de ahorros                              */
/*  Disenado por:       P. Coello                                       */
/*  Fecha de escritura: 05-Mar-1992                                     */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno  de sus            */
/*  usuarios sin el debido consentimiento por escrito de COBISCorp.     */
/*  Este programa esta protegido por la ley de derechos de autor        */
/*  y por las convenciones  internacionales de propiedad inte-          */
/*  lectual. Su uso no  autorizado dara  derecho a COBISCorp para       */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier infraccion.                   */
/************************************************************************/
/*                           PROPOSITO                                  */
/*  Este programa procesa las transacciones de depositos des el batch   */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA            AUTOR         RAZON                                */
/*  05/Mar/2004      P. Coello     Emision inicial                      */
/*  04/Feb/2010      J.Loyo        Validacion de Saldo Maximo           */
/*                                 para la cuenta                       */
/*  17/Feb/2010      J.Loyo        Manejo de la fecha de efectivizacion */
/*                                 teniendo el sabado como habil        */
/*  03/May/2016      J. Salazar    Migracion COBIS CLOUD MEXICO         */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_deposito_batch_ah')
   drop proc sp_deposito_batch_ah
go

/****** Object:  StoredProcedure [dbo].[sp_deposito_batch_ah]    Script Date: 03/05/2016 9:52:01 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

create proc sp_deposito_batch_ah
(
   @s_srv            varchar(16),
   @s_ssn            int,
   @s_ssn_branch     int,
   @s_user           login,
   @s_term           varchar(20),
   @t_trn            int,
   @t_debug          char(1)     = 'N',
   @t_file           varchar(14) = null,
   @t_show_version   bit         = 0,
   @i_ofi            smallint,
   @i_cta            cuenta,
   @i_efe            money,
   @i_prop           money,
   @i_loc            money,
   @i_plaz           money,
   @i_mon            tinyint,
   @i_factor         smallint    = 1,
   @i_fecha          smalldatetime,
   @i_tipo           catalogo,
   @i_canal          tinyint     = null
)
as
declare 
@w_return               int,
@w_sp_name              varchar(30),
@w_estado               char(1),
@w_tipo_bloqueo         varchar(3),
@w_alicuota             float,
@w_tot_alic             money,
@w_tot                  money,
@w_dis_alic             money,
@w_disponible           money,
@w_saldo_para_girar     money,
@w_saldo_contable       money,
@w_promedio1            money,
@w_promedio2            money,
@w_promedio3            money,
@w_promedio4            money,
@w_promedio5            money,
@w_promedio6            money,
@w_prom_disp            money,
@w_12h                  money,
@w_24h                  money,
@w_48h                  money,
@w_remesas              money,
@w_rem_hoy              money,
@w_valor                money,
@w_acum                 money,
@w_sec                  int,
@w_clave                int,
@w_suspensos            smallint,
@w_numdeci              tinyint,
@w_contador             smallint,
@w_mensaje              mensaje,
@w_tipo_prom            char(1),
@w_contador_trx         int,
@w_usadeci              char(1),
@w_debmes               money,
@w_debhoy               money,
@w_credhoy              money,
@w_fapert               datetime,
@w_fultmv               datetime,
@w_dep_ini              tinyint,
@w_causa                varchar(4),
@w_ciudad               int,
@w_dias_ret             tinyint,
@w_cont                 tinyint,
@w_fecha_efe            smalldatetime,
@w_fecha_efec           datetime,
@w_oficial              smallint,
@w_oficina              smallint,
@w_cred_rem             varchar(3),
@w_bloqueos             int,
@w_num_blqmonto         int,
@w_producto             tinyint,
@w_saldo_ayer           money,
@w_cta_funcionario      char(1),
@w_ced_ruc              char(1),
@w_dias_consumo         tinyint,
@w_cliente              int,
@w_moneda_local         tinyint,
@w_cuenta               int,
@w_prod_banc            int,
@w_categoria            char(1),
@w_nemo2                char(6),
@w_ncontrol             smallint,
@w_lpend                int,
@w_tipocta_super        char(1),
@w_linea                smallint,
 /** Validacion saldo Maximo ***/
@w_saldo_max            money,
@w_aux_disponible       money,
@w_hora_ejecucion       smalldatetime,
@w_codigo_pais          char(3)

/*  Captura nombre de Stored Procedure  */
select @w_sp_name        ='sp_deposito_batch_ah'
select @w_hora_ejecucion = convert(varchar(5),getdate(),108)

-- Versionamiento del Programa --
if @t_show_version = 1
begin
   print 'Stored Procedure=' + @w_sp_name +  ' Version=' + '4.0.0.0'
   return 0
end

select @w_moneda_local = pa_tinyint    -- lgr
from cobis..cl_parametro
where pa_producto = 'ADM'
  and pa_nemonico = 'CMNAC'

select @w_mensaje = null

/* Encuentro Datos de la cuenta */
select  @w_remesas           = ah_remesas,
        @w_rem_hoy           = ah_rem_hoy,
        @w_suspensos         = ah_suspensos,
        @w_tipo_prom         = ah_tipo_promedio,
        @w_prod_banc         = ah_prod_banc,
        @w_categoria         = ah_categoria,
        @w_24h               = ah_24h,
        @w_12h               = ah_12h,
        @w_48h               = ah_48h,
        @w_disponible        = ah_disponible,
        @w_promedio1         = ah_promedio1,
        @w_promedio2         = ah_promedio2,
        @w_promedio3         = ah_promedio3,
        @w_promedio4         = ah_promedio4,
        @w_promedio5         = ah_promedio5,
        @w_promedio6         = ah_promedio6,
        @w_prom_disp         = ah_prom_disponible,
        @w_contador_trx      = ah_contador_trx,
        @w_fapert            = ah_fecha_aper,
        @w_fultmv            = ah_fecha_ult_mov,
        @w_credhoy           = ah_creditos_hoy,
        @w_debhoy            = ah_debitos_hoy, 
        @w_dep_ini           = ah_dep_ini,
        @w_oficina           = ah_oficina,
        @w_oficial           = ah_oficial,
        @w_estado            = ah_estado,
        @w_cred_rem          = ah_cred_rem,
        @w_bloqueos          = ah_bloqueos,
        @w_num_blqmonto      = ah_num_blqmonto,
        @w_producto          = ah_producto,
        @w_saldo_ayer        = ah_saldo_ayer,
        @w_cta_funcionario   = ah_cta_funcionario,
        @w_ced_ruc           = ah_ced_ruc,
        @w_cuenta            = ah_cuenta,
        @w_cliente           = ah_cliente,
        @w_tipocta_super     = ah_tipocta_super,
        @w_linea             = ah_linea
   from cob_ahorros..ah_cuenta 
  where ah_cta_banco = @i_cta
    and ah_estado <> 'G'              /* Cuenta de Gerencia */

if @@rowcount <> 1
begin
   select @w_return = 201004
   Goto Error
end
--print '1'
if @w_dep_ini <> 0
begin
   select @w_return = 201158
   Goto Error
end
--print '2'
/* Encuentra parametro de decimales */
select @w_usadeci = mo_decimales
  from cobis..cl_moneda
 where mo_moneda = @i_mon
if @w_usadeci = 'S'
begin
   select @w_numdeci = pa_tinyint
   from cobis..cl_parametro
   where pa_producto = 'CTE'
   and pa_nemonico = 'DCI'
   
   if @@rowcount <> 1
   begin
      select @w_return = 201196
      Goto Error
   end
--  print '3'
end
else select @w_numdeci = 0

select @w_codigo_pais = pa_char 
from  cobis..cl_parametro 
where pa_nemonico = 'ABPAIS' 
and   pa_producto = 'ADM'

if @w_codigo_pais is null
   select @w_codigo_pais = 'PA'	


/*  Determinacion de bloqueo de cuenta  */
select @w_tipo_bloqueo = cb_tipo_bloqueo
  from cob_ahorros..ah_ctabloqueada
 where cb_cuenta = @w_cuenta
   and cb_estado = 'V'
   and cb_tipo_bloqueo in ('1', '3')
   
if @@rowcount <> 0
begin
   select @w_mensaje = rtrim (valor)
   from  cobis..cl_catalogo
   where tabla = (select codigo from cobis..cl_tabla
                  where tabla = 'ah_tbloqueo')
   and   codigo = @w_tipo_bloqueo
   select @w_mensaje = 'Cuenta bloqueada: ' + @w_mensaje

   if @@rowcount <> 1
   begin
     select @w_return = 201008
     Goto Error
   end
--   print '4'
end

/*  Actualizacion de saldos  */
exec @w_return = cob_ahorros..sp_ahcalcula_saldo
@t_debug            = @t_debug,
@t_from             = @w_sp_name,
@i_cuenta           = @w_cuenta,
@i_fecha            = @i_fecha,
@i_ofi              = @i_ofi,
@o_saldo_para_girar = @w_saldo_para_girar out,
@o_saldo_contable   = @w_saldo_contable out,
@o_saldo_max        = @w_saldo_max out  /* Recibimos  el saldo Maximo para la cuenta */
--print '5'
if @w_return <> 0
begin
   select @w_return = @w_return
   Goto Error
end

/* Halla alicuota para el promedio */
select @w_alicuota = fp_alicuota
  from cob_ahorros..ah_fecha_promedio
 where fp_tipo_promedio = @w_tipo_prom
   and fp_fecha_inicio = @i_fecha

if @@rowcount = 0
begin
   select @w_return = 251013
   Goto Error
end
--print '6'

if @w_codigo_pais = 'CO'
   select @w_tot    = @i_efe + @i_prop + @i_loc 
else
   select @w_tot    = @i_efe + @i_prop + @i_loc + @i_plaz
   
select @w_credhoy  = @w_credhoy + (@w_tot * @i_factor)
select @w_tot_alic = convert (money, round((@w_tot * @w_alicuota), @w_numdeci)) 
select @w_dis_alic = convert (money, round((@i_efe * @w_alicuota), @w_numdeci)) 

if @i_factor = -1 and 
  (@i_loc    > @w_24h or 
   @i_plaz   > @w_rem_hoy)
begin
   select @w_return = 205002
   Goto Error
end
--print '7'

/* Regitrar los depositos por ciudad de cheques locales */

if @i_loc > 0
begin  
   --Determinar el codigo de la ciudad de la compensacion
   select @w_ciudad = of_ciudad
   from cobis..cl_oficina
   where of_oficina = @i_ofi

   if @i_loc > 0
   begin  /* Determinar el numero de dias de retencion para la ciudad */
      select @w_dias_ret = rl_dias
      from  cob_ahorros..ah_retencion_locales
      where rl_agencia = @i_ofi
      and   @w_hora_ejecucion between rl_hora_inicio and rl_hora_fin


      if @@rowcount = 0
      begin    /* Determinar el parametro general */
         select @w_dias_ret = pa_tinyint
         from  cobis..cl_parametro
         where pa_producto = 'AHO'
         and   pa_nemonico = 'DIRE'
         if @@rowcount = 0
         begin
             select @w_return = 205001
             Goto Error
         end
--         print '8'
      end

      /*** La determinacion del siguiente dia laboral  se              ****/
      /*** hace mediante el llamado al siguiente sp  - JLOYO           ****/
      exec @w_return = cob_remesas..sp_fecha_habil
      @i_val_dif       = 'N',
      @i_efec_dia      = 'S',
      @i_fecha         = @w_fecha_efe,       
      @i_oficina       =  @i_ofi,                      
      @i_dif           = 'N',               /**** Ingreso en  horario normal  ***/
      @w_dias_ret      = @w_dias_ret,       /***  Dia siguiente habil         ***/
      @o_ciudad        = @w_ciudad out,
      @o_fecha_sig     = @w_fecha_efe out

      if @w_return <> 0
          return @w_return
   end
end

begin tran
if @i_loc > 0
begin
   if exists (select cd_cuenta
                from cob_ahorros..ah_ciudad_deposito
               where cd_cuenta = @w_cuenta
                 and cd_ciudad = @w_ciudad
                 and cd_fecha_depo = @i_fecha
                 and cd_fecha_efe  = @w_fecha_efe)
   begin
       update cob_ahorros..ah_ciudad_deposito
          set cd_valor_efe  = cd_valor_efe + (@i_loc * @i_factor),
              cd_valor  = cd_valor + (@i_loc * @i_factor)
        where cd_cuenta     = @w_cuenta
          and cd_ciudad     = @w_ciudad
          and cd_fecha_depo = @i_fecha
          and cd_fecha_efe  = @w_fecha_efe
       if @@rowcount <> 1
          begin
           select @w_return = 205001
           Goto Error
          end
--       print '9'
   end
   else
   begin
       insert into cob_ahorros..ah_ciudad_deposito
              (cd_cuenta, cd_ciudad, cd_fecha_depo,
               cd_fecha_efe, cd_valor, cd_valor_efe)
       values (@w_cuenta, @w_ciudad, @i_fecha,
               @w_fecha_efe, @i_loc, @i_loc)
       if @@error <> 0
          begin
               select @w_return = 205001
               Goto Error
          end
---       print '10'
   end
end

select @w_nemo2 = tn_nemonico
  from cobis..cl_ttransaccion
 where tn_trn_code = @t_trn

/* Encontrar el seqnos para el numero de control y para la linea pendiente */
update cobis..cl_seqnos
   set siguiente = siguiente + 1
 where tabla = 'ah_control'

select @w_ncontrol = siguiente
  from cobis..cl_seqnos
 where tabla = 'ah_control'

if @w_ncontrol >= 9998
  begin
    select @w_ncontrol = 0
    update cobis..cl_seqnos
       set siguiente = 2
     where tabla = 'ah_control'
  end

update cobis..cl_seqnos
   set siguiente = siguiente + 1
 where tabla = 'ah_lpendiente'

select @w_lpend = siguiente
  from cobis..cl_seqnos
 where tabla = 'ah_lpendiente'

if @w_lpend >= 2147483639
begin
   select @w_lpend = 0
   update cobis..cl_seqnos
   set    siguiente = 2
   where  tabla = 'ah_lpendiente'
end

select @w_linea = @w_linea + 1
/* Inserta la linea pendiente por esta transaccion */
insert into cob_ahorros..ah_linea_pendiente
       (lp_cuenta, lp_linea, lp_nemonico, lp_valor,
        lp_fecha, lp_control, lp_signo, lp_enviada)
values (@w_cuenta, @w_lpend, @w_nemo2, @w_tot,
        @i_fecha, @w_ncontrol, 'D', 'N')

if @@error <> 0
begin
   select @w_return = 253002
   Goto Error
end

/* calcula nuevo saldo contable y disponible */
 select @w_disponible     = @w_disponible     + @i_efe * @i_factor
 select @w_saldo_contable = @w_saldo_contable + @w_tot * @i_factor
 
/*** Validamos el saldo maximo de la cuenta JLOYO *****/
select @w_aux_disponible = @w_disponible + ((@i_efe + @i_prop) * @i_factor)
if @w_saldo_max > 0 and @w_saldo_contable >  @w_saldo_max
begin
   exec cobis..sp_cerror
   @t_debug        = @t_debug,
   @t_file         = @t_file,
   @t_from         = @w_sp_name,
   @i_num          = 252077 /**** EL CREDITO ALA CUENTA EXCEDE EL SALDO MAXIMO PERMITIDO ***/
   return 1  
end    

 /* Actualizo tabla de cuentas de ahorros */
 update cob_ahorros..ah_cuenta
 set 
 ah_disponible      = @w_aux_disponible,
 ah_promedio1       = @w_promedio1    + (@i_factor * @w_dis_alic),
 ah_prom_disponible = @w_prom_disp    + (@i_factor * @w_dis_alic),
 --ah_12h           = @w_12h          + (@i_factor * @i_prop),
 ah_24h             = @w_24h          + (@i_factor * @i_loc ),
 ah_remesas         = @w_remesas      + (@i_factor * @i_plaz),
 ah_rem_hoy         = @w_rem_hoy      + (@i_factor * @i_plaz),
 ah_fecha_ult_mov   = @i_fecha,       
 ah_contador_trx    = @w_contador_trx + @i_factor,
 ah_linea           = @w_linea,
 ah_creditos_hoy    = @w_credhoy
 where ah_cuenta    = @w_cuenta

 select @w_return = @@rowcount

 if @w_return <> 1
 begin
    select @w_return = 205001
    Goto Error
 end
 --print '12'
  
 /* Transaccion Monetaria */
 insert into cob_ahorros..ah_tran_monet
      (tm_secuencial, tm_ssn_branch, tm_cod_alterno, tm_tipo_tran, tm_oficina,
       tm_usuario, tm_terminal, tm_correccion,
       tm_sec_correccion, tm_reentry, tm_origen,
       tm_nodo, tm_fecha, tm_cta_banco,
       tm_valor, tm_chq_propios, tm_chq_locales, tm_signo ,
       tm_chq_ot_plazas, tm_remoto_ssn, tm_moneda, 
       tm_saldo_contable, tm_saldo_disponible,
       tm_oficina_cta, tm_estado,
       tm_prod_banc, tm_categoria,
       tm_tipocta_super, tm_turno, tm_causa, tm_hora, tm_canal, tm_cliente)
  values 
      (@s_ssn, @s_ssn_branch, 0, @t_trn, @i_ofi,
       @s_user, @s_term, 'N',
       null, 'N', 'L',
       @s_srv, @i_fecha, @i_cta,
       @i_efe, @i_prop, @i_loc, 'C', 
       @i_plaz, null, @i_mon, @w_saldo_contable,
       @w_disponible, @w_oficina, null,
       @w_prod_banc, @w_categoria,
       @w_tipocta_super, null, @i_tipo, getdate(), @i_canal, @w_cliente)

   if @@error <> 0
   begin
       select @w_return = 203000
       Goto Error
   end
--        print '13'
commit tran

return 0
Error:
   while @@trancount <> 0 rollback tran

   if @w_mensaje is null
   begin
       select @w_mensaje = convert(varchar, @w_return)
   
       select @w_mensaje = @w_mensaje + ' ' + isnull(mensaje, 'No existe mensaje')
         from cobis..cl_errores
        where numero = @w_return
   end
   else
       select @w_mensaje = @w_mensaje + ' ' + convert(varchar, @w_return)

   insert into cob_remesas..re_error_batch values(@i_cta, @w_mensaje)

   return @w_return

go

