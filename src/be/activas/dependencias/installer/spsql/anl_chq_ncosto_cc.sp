use cob_cuentas
go
if exists (select 1 from sysobjects where name = 'sp_anl_chq_ncosto_cc')
   drop proc sp_anl_chq_ncosto_cc
go
create proc sp_anl_chq_ncosto_cc (
    @s_ssn                int,
    @s_srv                varchar(30),
    @s_lsrv               varchar(30),
    @s_user               varchar(30),
    @s_sesn               int,
    @s_term               varchar(10),
    @s_date               datetime,
    @s_org                char(1),
    @s_ofi                smallint,    /* Localidad origen transaccion */
    @s_rol                smallint,
    @s_org_err            char(1) = null, /* Origen de error:[A], [S] */
    @s_error              int = null,
    @s_sev                tinyint = null,
    @s_msg                varchar(240) = null,
    @t_debug              char(1) = 'N',
    @t_file               varchar(14) = null,
    @t_from               varchar(32) = null,
    @t_rty                char(1) = 'N',
    @t_trn                smallint,
    @i_cta                varchar(24),
    @i_mon                tinyint,
    @i_desde              int,
    @i_hasta              int,
    @i_clase              char(1) = 'P',
    @i_causa              char(1),
    @i_valor              money = null,
    @i_aut                varchar(64),
    @i_alt                int = 0, /*CHM 01-mar-2000*/
    @i_pit                char(1) = 'N',
    @i_tipo               char(3) = '',
    @i_modulo             char(3) = 'TAD',
    @o_oficina            smallint = null out
)
as
declare @w_return               int,
        @w_sp_name              varchar(30),
        @w_est                  char(1),
        @w_ctacte               int,
        @w_filial               tinyint,
        @w_indice               int,
        @w_rango_cheques        int,
        @w_rango                int,
        @w_ch_estado            char(1),
        @w_clase                char(1),
        @w_estado_actual        char(1),
        @w_val_cheq             char(1),
        @w_categoria            char(1),  /*CHM 01-mar-2000*/
        @w_valor                money,    /*CHM 01-mar-2000*/
        @w_causa                char(1),   /*CHM 01-mar-2000*/
        @w_oficial              smallint,
        @w_valger               money,
        @w_cliente              int,
        @w_clase_clte           char(1),
        @w_prodbanc             smallint


/* Captura del nombre del Store Procedure */
select @w_sp_name = 'sp_anl_chq_ncosto_cc',
       @w_val_cheq = 'S'

/* Modo de debug */

if  @t_trn <> 2507            
begin
  /* Error en codigo de transaccion */
   exec cobis..sp_cerror1
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num   = 201048,
           @i_pit       = @i_pit
   return 201048
end                             

select @w_ctacte     = cc_ctacte,
       @w_est        = cc_estado,
       @o_oficina    = cc_oficina,
       @w_oficial    = cc_oficial,
       @w_cliente    = cc_cliente,
       @w_clase_clte = cc_clase_clte,
       @w_prodbanc   = cc_prod_banc
  from cob_cuentas..cc_ctacte
 where cc_cta_banco = @i_cta
   and cc_moneda    = @i_mon

if @@rowcount = 0
begin
   /* No existe cuenta_banco */
   exec cobis..sp_cerror1
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_num       = 201004,
      @i_pit       = @i_pit
   return 201004
end

/* Validaciones */
if @w_est not in ('A','G')
begin
   /* Cuenta no activa o cancelada */
   exec cobis..sp_cerror1
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_num       = 201005,
      @i_pit       = @i_pit
   return 201005
end


if @i_tipo = 'CTE' and @w_est = 'G' and  @i_modulo = 'TAD'
begin
   exec cobis..sp_cerror1
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_num   = 2902574,
      @i_pit       = @i_pit
   return 2902574 
end 


/* Validacion de la Causa de Anulacion */
exec @w_return = cobis..sp_catalogo
     @t_debug      = @t_debug,
     @t_file       = @t_file,
     @t_from       = @w_sp_name,
     @i_tabla      = 'cc_causa_np',
     @i_operacion  = 'E',
     @i_codigo     = @i_causa
     
if @w_return <> 0
begin
   /* No existe causa de no pago */
   exec cobis..sp_cerror1
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_num   = 201039,
      @i_pit       = @i_pit
   return 201039
end

if  @i_desde = 0 OR
    @i_hasta = 0
begin
   /* Numeros de cheque no pueden ser igual a cero */
   exec cobis..sp_cerror1
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_num   = 201040,
      @i_pit       = @i_pit
   return 201040
end

if @i_desde > @i_hasta
begin
    /* Cheque desde no puede ser mayor a cheque hasta */
    exec cobis..sp_cerror1
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num   = 201041,
       @i_pit       = @i_pit
    return 201041
end

select  @w_rango_cheques = @i_hasta - @i_desde + 1

if @w_rango_cheques > 50
begin
   /* No se pueden anular mas de 50 cheques */
   exec cobis..sp_cerror1
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_num   = 201042,
      @i_pit       = @i_pit
   return 201042
end

/* Se obtiene la filial */
select @w_filial = of_filial 
  from cobis..cl_oficina
 where of_oficina = @s_ofi

/* Validacion de que los cheques a anular sean de chequeras emitidas */
/* Cheque inicial del rango a anular */

select @w_ch_estado  = ch_estado
  from cob_cuentas..cc_chequera
 where ch_cuenta = @w_ctacte
   and ch_inicial <= @i_desde
   and (ch_inicial + ch_numero) > @i_desde

if @@rowcount = 0
begin
   select @w_val_cheq = 'N'

   /*  No Existe chequera para la Cuenta */
   exec cobis..sp_cerror1
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 201006,
      @i_pit       = @i_pit
   return 201006
end

if @w_ch_estado <> 'E' and  @w_ch_estado <> 'C'  and @w_val_cheq = 'S'
begin
   /* Chequera no entregada a cliente */
   exec cobis..sp_cerror1
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 201110,
      @i_pit       = @i_pit
   return 201110
end

/* Cheque final del rango a anular */

select @w_ch_estado  = ch_estado
  from cob_cuentas..cc_chequera
 where ch_cuenta = @w_ctacte
   and ch_inicial <= @i_hasta
   and (ch_inicial + ch_numero) > @i_hasta

if @@rowcount = 0
begin
   
   select @w_val_cheq = 'N'
   
   /* No Existe chequera para la Cuenta */
   exec cobis..sp_cerror1 
        @t_debug  = @t_debug,
        @t_file   = @t_file,
        @t_from   = @w_sp_name,
        @i_num    = 201006,
        @i_pit       = @i_pit
   return 201006
end

if @w_ch_estado <> 'E' and @w_ch_estado <> 'C'  and @w_val_cheq = 'S'
begin
   /* Chequera no Emitida */
   exec cobis..sp_cerror1 
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 201110,
      @i_pit       = @i_pit
   return 201110
end

if @i_clase = 'C'
   if exists (select 1 from cob_cuentas..cc_rango_anulados
               where ra_ctacte = @w_ctacte
                 and ra_cheque_inicial <= @i_desde
                 and ra_cheque_final   >= @i_hasta
                 and (ra_cheque_inicial <> @i_desde
                  or  ra_cheque_final   <> @i_hasta)
                 and ra_estado = 'V')
   begin
      /* No se puede anular cheques si no existe rango con op. C */
      exec cobis..sp_cerror1
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 201175,
         @i_pit       = @i_pit
      return 201175
   end

/* Verificacion de que los cheques a anular no se encuentren anulados */

select @w_indice = @i_desde

while @w_indice <= @i_hasta
begin
   select @w_estado_actual = cq_estado_actual,
          @w_clase = np_clase
     from cob_cuentas..cc_cheque
    where cq_cuenta = @w_ctacte
      and cq_cheque = @w_indice

   if @@rowcount = 0
      select @w_estado_actual = 'N'

   /*CHM 01-mar-2000*/
   /*if @w_estado_actual = 'N' and @i_clase = 'C'*/
   if @w_estado_actual in ('N','G') and @i_clase = 'C'
   begin
      /* No se puede anular cheque no anulado temporalmente */
      exec cobis..sp_cerror1
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 201172,
         @i_pit       = @i_pit
      return 201172
   end

   if @w_estado_actual in ('N','G') or
      (@w_estado_actual = 'A' and @w_clase = 'T' and @i_clase = 'C')
      select @w_indice = @w_indice + 1
   else
   begin
      if @w_estado_actual = 'A'
      begin
         /* No se puede anular cheque anulado permanente */
         exec cobis..sp_cerror1
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 201171,
            @i_pit       = @i_pit
         return 201171
      end
      else
         if @w_estado_actual = 'P'
         begin
            /* No se puede anular cheques ya pagados */
            exec cobis..sp_cerror1
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 201011,
               @i_pit       = @i_pit
            return 201011
         end
         else
         begin
            /* No se puede anular cheque con orden de no pago */
            exec cobis..sp_cerror1
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 201131,
                  @i_pit       = @i_pit
            return 201131
         end
   end
end

select @w_clase = @i_clase

if @i_clase = 'C'
   select @w_clase = 'P'

begin tran

select @w_rango = ra_rango
  from cob_cuentas..cc_rango_anulados
 where ra_ctacte = @w_ctacte
   and ra_cheque_inicial = @i_desde
   and ra_cheque_final = @i_hasta
   and ra_estado = 'V'

if @w_rango is not null
begin
   update cob_cuentas..cc_rango_anulados
      set ra_fecha_anulacion = @s_date,
          ra_autorizante = @s_user,
          ra_cobro = 'N'
    where ra_ctacte = @w_ctacte
      and ra_cheque_inicial = @i_desde
      and ra_cheque_final = @i_hasta
      and ra_estado = 'V'
   if @@error <> 0
   begin
      /* Error en creacion de rango de cheques anulados */
      exec cobis..sp_cerror1
         @t_debug        = @t_debug,
         @t_file         = @t_file,
         @t_from         = @w_sp_name,
         @i_num          = 203023,
         @i_pit       = @i_pit
      return 203023
   end
end
else
begin
   /* Generacion del numero del numero de rango */ 
   exec @w_return = cobis..sp_cseqnos
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_tabla    = 'cc_rango_anulados',
       @o_siguiente    = @w_rango out
   
   if @w_return <> 0
      return @w_return

   /* Insercion en la tabla de rangos de cheques anulados */
   insert into cob_cuentas..cc_rango_anulados
          (ra_ctacte, ra_rango, ra_estado,
           ra_cheque_inicial, ra_cheque_final, ra_fecha_anulacion,
           ra_cobro, ra_autorizante)
    values (@w_ctacte, @w_rango, 'V',
            @i_desde, @i_hasta, @s_date,
            'N', @s_user)

   if @@error <> 0
   begin
      /* Error en creacion de rango de cheques anulados */
      exec cobis..sp_cerror1
         @t_debug    = @t_debug,
         @t_file         = @t_file,
         @t_from         = @w_sp_name,
         @i_num          = 203023,
         @i_pit       = @i_pit
      return 203023
   end
end

select @w_indice = @i_desde

while @w_indice <= @i_hasta
begin
   select @w_estado_actual = cq_estado_actual,
          @w_valor      = cq_valor,
          @w_causa      = np_acreditado
   from  cob_cuentas..cc_cheque
   where cq_cuenta = @w_ctacte
   and   cq_cheque = @w_indice
   and  (cq_estado_actual in ('N','G') or (cq_estado_actual = 'A' and np_clase = 'T'))
      
   if @@rowcount = 1 /*CHM 01-mar-2000*/
   begin
      if @w_estado_actual = 'G'
         select @w_valger = isnull(@w_valger,0) + isnull(@w_valor,0)
         
      if @w_clase = 'P'
      begin
         /* Insercion en la tabla cc_his_cheque */
         insert into cob_cuentas..cc_his_cheque
                     (hc_ssn, hc_cuenta, hc_cheque, hc_estado_actual,
                      hc_estado_anterior, hc_fecha_anulacion, hc_hora,
                      hc_origen, hc_valor,
                      hc_causa, hc_clase, hc_filial, hc_oficina, hc_usuario,
                      hc_fecha_levantamiento)
              values (@s_ssn, @w_ctacte, @w_indice, 'A',
                     @w_estado_actual, @s_date, getdate(), 'V', @i_valor,
                     @i_causa, @i_clase, @w_filial, @s_ofi, @s_user,
                     @s_date)
                     
         if @@error <> 0
         begin
            /* Error en creacion de registro en cc_his_cheque */
            exec cobis..sp_cerror1
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 203013,
               @i_pit       = @i_pit
            return 203013
         end
      end
                  
      update cob_cuentas..cc_cheque
         set cq_estado_anterior = @w_estado_actual,
             cq_estado_actual   = 'A',
             cq_fecha_reg       = @s_date,
             np_clase           = @i_clase,
             np_causa           = @i_causa,
             np_filial          = @w_filial,
             np_oficina         = @s_ofi,
             cq_hora            = getdate(),
             cq_usuario         = @s_user
       where cq_cuenta = @w_ctacte
         and cq_cheque = @w_indice
             /*CHM 01-Mar-2000*/
             /*and  (cq_estado_actual = 'N'*/
         and (cq_estado_actual in ('N','G')
          or (cq_estado_actual = 'A'
         and np_clase = 'T'))
         
      if @@rowcount <> 1
      begin
         /* Error en actualizacion de registro en cc_ctacte */
         exec cobis..sp_cerror1
            @t_debug      = @t_debug,
            @t_file       = @t_file,
            @t_from       = @w_sp_name,
            @i_num        = 205001,
            @i_pit       = @i_pit
         return 205001
      end
      else
      begin
            select @w_indice = @w_indice + 1
            continue
      end
   end   /* If exists */
   else
   begin
      if @w_clase = 'P'
      begin
         /* Insercion en la tabla cc_his_cheque */
         insert into cob_cuentas..cc_his_cheque
                     (hc_ssn, hc_cuenta, hc_cheque, hc_estado_actual,
                      hc_estado_anterior, hc_fecha_anulacion, hc_hora,
                      hc_origen, hc_valor,
                      hc_causa, hc_clase, hc_filial, hc_oficina, hc_usuario,
               hc_fecha_levantamiento)
              values (@s_ssn, @w_ctacte, @w_indice, 'A',
                     @w_estado_actual, @s_date, getdate(), 'V', @i_valor,
                     @i_causa, @i_clase, @w_filial, @s_ofi, @s_user,
                     @s_date)
                     
         if @@error <> 0
         begin
            /* Error en creacion de registro en cc_his_cheque */
            exec cobis..sp_cerror1
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 203013,
               @i_pit       = @i_pit
            return 203013
         end                                                       
      end
      
      /* Insercion en la tabla cc_cheque */
      insert into cob_cuentas..cc_cheque
             (cq_cuenta,          cq_cheque,      cq_estado_actual,
              cq_estado_anterior, cq_fecha_reg,   cq_valor,
              np_causa,           np_clase,       np_filial, np_oficina,
              np_fecha_can,       np_fecha_tope,  cq_hora,
              cq_origen,          cq_transferido, cq_usuario)
      values (@w_ctacte,          @w_indice,      'A',
              @w_estado_actual,   @s_date,        @i_valor,
              @i_causa,           @i_clase,       @w_filial, @s_ofi,
              null,               null,           getdate(), 'V', 
              'N',                @s_user)
                  
      if @@error <> 0
      begin
         /* Error en creacion de registro en cc_nopago */
         exec cobis..sp_cerror
         @t_debug    = @t_debug,
         @t_file     = @t_file,
         @t_from     = @w_sp_name,
         @i_num      = 203013
         return 203013
      end
      else
      begin    
         select @w_indice = @w_indice + 1
         continue
      end
   end   /* Else del If exists */
end

update  cob_cuentas..cc_ctacte
set     cc_anulados = cc_anulados + @w_rango_cheques
where   cc_ctacte   = @w_ctacte

if @@rowcount <> 1
begin
   /* Error en actualizacion de registro en cc_ctacte */
   exec cobis..sp_cerror
      @t_debug      = @t_debug,
      @t_file       = @t_file,
      @t_from       = @w_sp_name,
      @i_num        = 205001
   return 205001
end

if exists (select 1 from cob_cuentas..cc_tran_servicio where ts_tipo_transaccion = @t_trn and ts_clase = @i_clase and ts_secuencial = @s_ssn and ts_cod_alterno = @i_alt)
   select @i_alt = @i_alt + 1

/* Creacion de transaccion de servicio */
insert into cob_cuentas..cc_tsnopago(
secuencial,                 tipo_transaccion,    tsfecha,        usuario,
terminal,                   oficina,             reentry,        origen,
cta_banco,                  cheque_desde,        cheque_hasta,   estado_actual,
estado_anterior,            fecha_reg,           causa_np,       clase_np,  
moneda,                     oficina_cta,         alterno,        oficial,
clase_clte,                 prod_banc,           cliente,        valor)
values(                                                          
@s_ssn,                     @t_trn,              @s_date,        @s_user,
@s_term,                    @s_ofi,              @t_rty,         @s_org,
isnull(@i_cta,@w_indice),   @i_desde,            @i_hasta,       'A',
@w_estado_actual,           @s_date,             @i_causa,       @i_clase,
@i_mon,                     @o_oficina,          @i_alt,         @w_oficial,
@w_clase_clte,              @w_prodbanc,         @w_cliente,     isnull(@w_valger,0))

if @@error <> 0 begin
   /* Error en creacion de transaccion de servicio */
   exec cobis..sp_cerror1
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 203005,
   @i_pit   = @i_pit
   return 203005
end

commit tran
return 0
go
