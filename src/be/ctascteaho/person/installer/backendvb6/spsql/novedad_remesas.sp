use cob_remesas
/****************************************************************************/
/*     Archivo:     novedad_remesas.sp                                      */
/*     Stored procedure: sp_valor_contratado                                */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:    Jorge Baque                                         */
/*     Fecha de escritura: 13/May/2016                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*                                                                          */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     13/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_novedad_remesas')
  drop proc sp_novedad_remesas
go
SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

CREATE proc sp_novedad_remesas(
    @s_ssn      int,
    @s_srv      varchar(30),
    @s_lsrv     varchar(30),
    @s_user     varchar(30),
    @s_sesn     int=null,
    @s_term     varchar(30),
    @s_date     datetime,
    @s_ofi      smallint,   /* Localidad origen transaccion */
    @s_rol      smallint,
    @s_org_err  char(1) = null, /* Origen de error: [A], [S] */
    @s_error    int = null,
    @s_sev      tinyint = null,
    @s_msg      mensaje = null,
    @s_org      char(1),
    @t_debug    char(1) = 'N',
    @t_file     varchar(14) = null,
    @t_from     varchar(32) = null,
    @t_rty      char(1) = 'N',
    @t_trn      smallint,
    @i_corres   char(12)=null,
    @i_oficina  smallint,
    @i_propie   char(12)=null,
    @i_secuen   int,
    @i_mon      tinyint,
    @i_chq      int,
    @i_chq_sec  int,
    @i_val      money,
    @i_caubloq  varchar(2) = null,
    @i_bloq     char(1),
    @i_ctadep   cuenta = null,
    @i_ctagir   cuenta = null
)
as
declare @w_return   int,
    @w_sp_name  	varchar(30),
    @w_mensaje  	varchar(120),
    @w_fecha_aux    datetime,
    @w_oficina  	smallint,
    @w_dias_anio    smallint,
    @w_bco_c    	smallint,
    @w_ofi_c    	smallint,
    @w_par_c    	int,
    @w_bco_e    	smallint,   
    @w_ofi_e    	smallint,
    @w_par_e    	int, 
    @w_bco      	smallint,   
    @w_ofi      	smallint,
    @w_par      	int, 
    @w_val      	money,
    @w_cont     	smallint,
    @w_num_cheque   int,
    @w_ciudad   	int,
    @w_status       char,
    @w_sub_estado   char,
    @w_moneda       tinyint,
    @w_producto     tinyint,
    @w_ctadep       cuenta,
    @w_ctagir       cuenta,
    @w_tipo_rem     char(1),
    @w_prodban      smallint,
    @w_sucursal     smallint,
    @w_num_cheques  smallint,
    @w_carta        int,
    @w_valor        money,
    @w_causa        tinyint,
    @w_ofi_dest     smallint,
    @w_prod         smallint,
    @w_prddep       char(3),
    @w_remesas      money,
    @w_ctaho        int,
    @w_ctacte       int,
    @w_fecha_efe    datetime,
    @w_trn          smallint,
    @w_codbco       tinyint,
    @w_cliente      int

/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_novedad_remesas'

/* Validacion de la transaccion */
if @t_trn not in (601,604,605)
begin
   /* Error en numero de transaccion */
   exec cobis..sp_cerror
   @t_from    = @w_sp_name,
   @i_num     = 201048
   return 1
end

--Codigo propio de compensacion
select @w_codbco = pa_tinyint
from   cobis..cl_parametro 
where  pa_nemonico = 'CBCO' 
and    pa_producto = 'CTE'

if @@rowcount <> 1
begin
   exec cobis..sp_cerror
   @t_from     = @w_sp_name,
   @i_num      = 201196
   return 201196
end

/* Ciudad de oficina que procesa */
select @w_ciudad = of_ciudad
from   cobis..cl_oficina
where  of_oficina = @s_ofi

if @@rowcount <> 1
begin
   /* Error: no existe oficina */
   exec cobis..sp_cerror
   @t_from      = @w_sp_name,
   @i_num       = 201094
   return 1
end

/* Valida datos */
if @i_secuen = 0
begin
   exec cobis..sp_cerror
   @t_from     = @w_sp_name,
   @i_num      = 351002
   return 1
end

select  @w_oficina = ct_oficina,
    @w_bco_c   = ct_banco_c,
    @w_ofi_c   = ct_oficina_c,
    @w_par_c   = ct_ciudad_c,
    @w_bco_e   = ct_banco_e,
    @w_ofi_e   = ct_oficina_e,
    @w_par_e   = ct_ciudad_e,
    @w_par     = ct_ciudad_p,
    @w_fecha_efe = ct_fecha_efe 
from  cob_remesas..re_carta
where ct_carta = @i_secuen 

if @@rowcount != 1
begin
   exec cobis..sp_cerror
   @t_from     = @w_sp_name,
   @i_num      = 351002,
   @i_msg      = 'NO EXISTE CARTA REMESA'
   return 1
end

/* Seleciona el estado de la cuenta*/
select  
@w_status     = dc_status,
@w_sub_estado = dc_sub_estado,
@w_val        = dc_valor,
@w_moneda     = dc_moneda,
@w_producto   = dc_producto,
@w_ctadep     = dc_cta_depositada,
@w_ctagir     = dc_cta_girada,
@w_tipo_rem   = dc_tipo_rem
from  cob_remesas..re_det_carta
where dc_carta      = @i_secuen
and   dc_num_cheque = @i_chq
and   dc_cheque     = @i_chq_sec 
    
if @@rowcount != 1
begin
   exec cobis..sp_cerror
   @t_from     = @w_sp_name,
   @i_num      = 351002,
   @i_msg      = 'CHEQUE NO PERTENECE A CARTA REMESA'
   return 1
end

select @w_prodban = 0

/* Buscar producto Cte o Ahorro*/
if @w_producto = 3
begin
   select @w_prddep = 'CTE'
   select @w_prodban = cc_prod_banc, @w_ctacte = cc_ctacte
   from   cob_cuentas..cc_ctacte 
   where  cc_cta_banco = @w_ctadep
end
else
begin
   if @w_producto = 4
   begin
      select @w_prddep = 'AHO' 
      select @w_prodban = ah_prod_banc, 
             @w_ctaho = ah_cuenta,
             @w_cliente = ah_cliente
      from cob_ahorros..ah_cuenta 
      where ah_cta_banco = @w_ctadep
   end
end

if @w_prodban = 0
begin
   --CUENTA DEPOSITANTE NO EXISTE
   exec cobis..sp_cerror
   @t_from     = @w_sp_name,
   @i_num      = 351095
   return 351095
end


begin tran
if @i_bloq = 'B'
begin
    if @w_status in ('B', 'D')
    begin
       --CHEQUE YA HA SIDO BLOQUEADO
       exec cobis..sp_cerror
       @t_from         = @w_sp_name,
       @i_num          = 357014
       return 357014
    end

    if @w_status = 'C'
    begin
       exec cobis..sp_cerror
       @t_from         = @w_sp_name,
       @i_num          = 355017
       return 1
    end

    /* actualiza la fecha efectiva en Null cuando el cheque es Bloqueado */
    update cob_remesas..re_det_carta set
    dc_fecha_efe = null,
    dc_status    = @i_bloq,
    dc_causa_blo = @i_caubloq
    where dc_carta       = @i_secuen
    and   dc_num_cheque  = @i_chq
    and   dc_valor       = @i_val
    and   dc_cheque      = @i_chq_sec 
    if @@rowcount != 1
    begin
       exec cobis..sp_cerror
       @t_from         = @w_sp_name,
       @i_num          = 355019
       return 355019
    end
    
    update cob_remesas..re_cheque_rec set 
    cr_fecha_efe = null,
    cr_status    = @i_bloq  --cr_estado
    where cr_cheque_rec = @i_chq_sec 
    and   cr_num_cheque = @i_chq
    and   cr_valor      = @i_val
    if @@rowcount != 1
    begin
       exec cobis..sp_cerror
       @t_from         = @w_sp_name,
       @i_num          = 355000
       return 355000
    end
    select @w_mensaje = 'BLOQUEO DE CHEQUE REMESA'

    if @w_bco_c <> @w_codbco
    begin
       update cob_remesas..re_carta set
       ct_valor       = ct_valor - @i_val,
       ct_num_cheques = ct_num_cheques - 1
       where ct_carta = @i_secuen 

       if @@rowcount != 1
       begin
          exec cobis..sp_cerror
          @t_from         = @w_sp_name,
          @i_num          = 355000
          return 355000
       end
    end
end

if @i_bloq = 'D'
begin
   if @w_status in ('P', 'D')
   begin
      exec cobis..sp_cerror
      @t_from         = @w_sp_name,
      @i_num          = 351093
      return 351093
   end

   if @w_status = 'C'
   begin
      exec cobis..sp_cerror
      @t_from         = @w_sp_name,
      @i_num          = 355017
      return 355017
   end

   if @w_sub_estado = 'A'
   begin
      exec cobis..sp_cerror
      @t_from         = @w_sp_name,
      @i_num          = 357015
      return 357015
   end

   /* Separa codigo de banco del cheque en sus componentes */
   select @w_bco = convert(smallint, substring(@i_propie,1,4))
   select @w_ofi = convert(smallint, substring(@i_propie,5,4))
   select @w_par = convert(int, substring(@i_propie,9,4))

   /*Seleciona los dias en la tabla re_transito*/

   select @w_dias_anio = tn_num_dias
   from   cob_remesas..re_transito
   where  tn_banco_c      = @w_bco_c
   and    tn_oficina_c    = @w_ofi_c
   and    tn_ciudad_c  = @w_par_c

   /*Suma los dias de re_transito a la fecha efectiva del cheque*/

   if @w_dias_anio = 0
      select @w_fecha_aux = null
   else
   begin
      select @w_fecha_aux = dateadd(dd, @w_dias_anio, @s_date),
             @w_cont = 1
      while @w_cont <= (@w_dias_anio - 1)
      begin
         if exists (select df_fecha
                    from  cobis..cl_dias_feriados
                    where df_ciudad = @w_ciudad
                    and   df_fecha = @w_fecha_aux)
            select @w_fecha_aux = dateadd (dd, 1, @w_fecha_aux)
         else
            select @w_cont = @w_cont + 1
      end
   end

   /* actualiza la fecha efectiva con los dias de re_transito Desbloqueo */ 
   if @w_bco_c <> @w_codbco
   begin
      /* Busca carta remesa del dia y actualiza*/

      select  
      @w_num_cheques = ct_num_cheques,
      @w_valor       = ct_valor,
      @w_carta       = ct_carta
      from cob_remesas..re_carta
      where ct_banco_e      = @w_bco_e
      and   ct_oficina_e    = @w_ofi_e
      and   ct_ciudad_e  = @w_par_e
      and   ct_fecha_emi    = @s_date
      and   ct_moneda       = @i_mon
      and   ct_banco_c      = @w_bco_c
      and   ct_oficina_c    = @w_ofi_c
      and   ct_ciudad_c  = @w_par_c
      and   ct_estado       = 'A'
      and   ct_tipo_rem     = @w_tipo_rem

      if @@rowcount = 0 
      begin
         exec @w_return = cobis..sp_cseqnos
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_tabla = 're_carta',
         @o_siguiente = @w_carta out

         if @w_return != 0
            return @w_return

         insert into cob_remesas..re_carta
         (ct_banco_e,   ct_oficina_e, ct_ciudad_e,
          ct_banco_c,   ct_oficina_c, ct_ciudad_c,
          ct_banco_p,   ct_oficina_p, ct_ciudad_p,
          ct_fecha_emi, ct_moneda,
          ct_carta,     ct_fecha_efe, ct_num_cheques,
          ct_valor,     ct_oficina,   ct_estado, ct_tipo_rem)
         values 
         (@w_bco_e,     @w_ofi_e,     @w_par_e,
          @w_bco_c,     @w_ofi_c,     @w_par_c,
          @w_bco,       @w_ofi,       @w_par,
          @s_date,      @i_mon,
          @w_carta,     @w_fecha_aux, 1,
          @i_val,       @s_ofi,       'A', @w_tipo_rem)
         if @@error != 0
         begin
            exec cobis..sp_cerror
            @t_from         = @w_sp_name,
            @i_num          = 353000
            return 1
         end

         update cob_remesas..re_det_carta set
         dc_carta      = @w_carta,
         dc_fecha_efe  = @w_fecha_aux,
         dc_acuse      = null,
         dc_sub_estado = null,
         dc_status     = 'P',
         dc_causa_blo = null
         where dc_carta      = @i_secuen
         and   dc_num_cheque = @i_chq
         and   dc_cheque     = @i_chq_sec

         if @@rowcount != 1
         begin
              exec cobis..sp_cerror
              @t_from         = @w_sp_name,
              @i_num          = 355019
              return 355019
         end
      end
      else
      begin
         update cob_remesas..re_carta set
         ct_valor       = ct_valor + @i_val,
         ct_num_cheques = ct_num_cheques + 1
         where ct_carta = @w_carta

         if @@rowcount != 1
         begin
            exec cobis..sp_cerror
            @t_from         = @w_sp_name,
            @i_num          = 355001
            return 355001
         end

         update cob_remesas..re_det_carta set
         dc_carta      = @w_carta,
         dc_fecha_efe  = @w_fecha_aux,
         dc_acuse      = null,
         dc_sub_estado = null,
         dc_status     = 'P',
         dc_causa_blo  = null
         where dc_carta      = @i_secuen
         and   dc_num_cheque = @i_chq
         and   dc_cheque     = @i_chq_sec

         if @@rowcount != 1
         begin
            exec cobis..sp_cerror
            @t_from         = @w_sp_name,
            @i_num          = 355019
            return 355019
         end
      end
   end
   else
   begin
      update cob_remesas..re_det_carta
         set dc_fecha_efe  = @w_fecha_aux, -- @w_fecha_efe
             dc_acuse      = null,
             dc_sub_estado = null,
             dc_status     = 'P',
             dc_causa_blo = null
      where dc_carta      = @i_secuen
      and   dc_num_cheque = @i_chq
      and   dc_cheque     = @i_chq_sec
      and   dc_valor      = @i_val

      if @@rowcount != 1
      begin
         exec cobis..sp_cerror
         @t_from         = @w_sp_name,
         @i_num          = 355019
         return 355019
      end
   end
   update cob_remesas..re_cheque_rec set 
   cr_fecha_efe =  @w_fecha_aux, --@w_fecha_efe
   cr_estado    = 'P',
   cr_status    = 'P'  --cr_estado
   where cr_cheque_rec  = @i_chq_sec 
   and   cr_num_cheque  = @i_chq
   and   cr_valor       = @i_val
   if @@rowcount != 1
   begin
      exec cobis..sp_cerror
      @t_from         = @w_sp_name,
      @i_num          = 355000
      return 355000
   end
   select @w_mensaje = 'DESBLOQUEO DE CHEQUE REMESA'
end

if @i_bloq = 'A'
begin
   --select @w_sucursal = isnull(a_sucursal,of_oficina)
   --from cobis..cl_oficina
   --where of_oficina = @w_oficina
    
   select @w_sucursal = ca_oficina 
   from   cob_cuentas..cc_centro_canje, 
          cob_cuentas..cc_ofi_centro
   where  oc_oficina = @w_oficina
   and    oc_centro  = ca_sec
    
   if @w_sucursal <> @i_oficina
   begin
      exec cobis..sp_cerror
          @t_from         = @w_sp_name,
          @i_num          = 201283
      return 1
   end
 
   if  @w_status not in ('B', 'D')
   begin  
      --CHEQUE NO HA SIDO BLOQUEADO NI DEVUELTO
      exec cobis..sp_cerror
          @t_from         = @w_sp_name,
          @i_num          = 357016
      return 357016
   end 

   if @w_status = 'D'
      select @t_trn = 608

   if (@i_ctadep <> @w_ctadep) or (@i_ctagir <> @w_ctagir) or (@i_val <> @w_val)
   begin
      exec cobis..sp_cerror
      @t_from         = @w_sp_name,
      @i_num          = 351002
      return 351002
   end 

   update cob_remesas..re_det_carta set
   dc_acuse      = @w_status,
   dc_sub_estado = 'A'  --Se adiciono
   where dc_carta      = @i_secuen
   and   dc_cheque     = @i_chq_sec
   and   dc_num_cheque = @i_chq
   and   dc_valor      = @i_val
   
   if @@rowcount != 1
   begin
      exec cobis..sp_cerror
      @t_from         = @w_sp_name,
      @i_num          = 355019
      return 355019
   end

   update cob_remesas..re_cheque_rec set
   cr_estado  = 'A',
   cr_status  = @w_status
   where cr_cheque_rec  = @i_chq_sec 
   and   cr_num_cheque  = @i_chq
   and   cr_valor       = @i_val
   if @@rowcount != 1
   begin
      exec cobis..sp_cerror
      @t_from         = @w_sp_name,
      @i_num          = 355000
      return 355000
   end
   select @w_mensaje = 'ACUSE DE CHEQUE REMESA'

   /* Ubica la fecha de efectivizacion de la carta*/ 
   if not exists (select 1
                  from   cob_remesas..re_det_carta 
                  where  dc_carta       = @i_secuen
                  and    dc_status     in ('P','B')
                  and    dc_sub_estado is null)

   begin  
      update cob_remesas..re_carta
      set ct_fecha_efe = @s_date,
          ct_estado = 'C'
      where ct_carta = @i_secuen    
    
      if @@rowcount != 1
      begin
         exec cobis..sp_cerror
         @t_from         = @w_sp_name,
         @i_num          = 355000
         return 355000
      end
   end
   
   /* Actualizacion saldos de Ctacte y Ahorro por concepto de acuse de bloqueo */
   if @w_status = 'B'
   begin
      if @w_prddep = 'CTE'
      begin
         update cob_cuentas..cc_ctacte
         set cc_remesas  = cc_remesas - @i_val 
         where cc_ctacte = @w_ctacte

         if @@rowcount != 1
         begin
            exec cobis..sp_cerror
            @t_from         = @w_sp_name,
            @i_num          = 355002
            return 355002
         end
      end
      else
      begin
         update cob_ahorros..ah_cuenta
         set ah_remesas  = ah_remesas - @i_val 
         where ah_cuenta = @w_ctaho

         if @@rowcount != 1
         begin
            exec cobis..sp_cerror
            @t_from         = @w_sp_name,
            @i_num          = 355003
            return 355003
         end
      end
   end
end

if @w_bco_c = @w_codbco
   select @w_causa    = @w_codbco,
          @w_ofi_dest = @w_ofi_e
else
   select @w_causa    = 1,
          @w_ofi_dest = @s_ofi

if @w_producto = 3 --Ctas Ctes
begin
   /* Transaccion servicio */
   insert into cob_cuentas..cc_tran_servicio ( 
       ts_secuencial, ts_tipo_transaccion, ts_clase,
       ts_tsfecha,    ts_usuario,          ts_terminal,  ts_nodo, 
       ts_oficina,    ts_producto,         ts_cta_banco, ts_prod_banc,
       ts_cheque_rec, ts_descripcion_ec,   ts_oficina_cta,
       ts_valor,      ts_carta,            ts_cheque,    ts_referencia,
       ts_causa,      ts_indicador)
    values (
       @s_ssn,        @t_trn,              @i_bloq,
       @s_date,       @s_user,             @s_term,      @s_srv, 
       @s_ofi,        @w_producto,         @w_ctadep,    @w_prodban,
       @i_chq_sec,    @w_mensaje,          @w_ofi_dest,
       @i_val,        @i_secuen,           @i_chq,       @w_status,
       @w_tipo_rem,   @w_causa) 
   
   if @@error != 0
   begin
      /* Error en creacion de transaccion de servicio */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 203005
      return 203005
   end
end
else --Ctas Aho
begin
   select @w_trn = case @t_trn
           when 604 then 382 --Bloqueo cheque remesa
           when 605 then 383 --Bloqueo cheque
           when 608 then 384 -- Acuse devolucion   --pendiente cambio de trn
           when 601 then 388 --acuse bloqueo
   end
   
   insert into cob_ahorros..ah_tran_servicio(
       ts_secuencial, ts_tipo_transaccion, ts_clase,
       ts_tsfecha,    ts_usuario,          ts_terminal,   ts_nodo, 
       ts_oficina,    ts_producto,         ts_cta_banco,  ts_prod_banc,
       ts_cheque_rec, ts_descripcion_ec,   ts_oficina_cta,
       ts_valor,      ts_carta,            ts_cheque,     ts_autorizante,
       ts_causa,      ts_indicador,        ts_cliente)
   values
       (@s_ssn,       @w_trn,              @i_bloq,
       @s_date,       @s_user,             @s_term,     @s_srv, 
       @s_ofi,        @w_producto,         @w_ctadep,   @w_prodban,
       @i_chq_sec,    @w_mensaje,          @w_ofi_dest,
       @i_val,        @i_secuen,           @i_chq,      @w_status,
       @w_tipo_rem,   @w_causa,            @w_cliente)
   if @@error != 0
   begin
      /* Error en creacion de transaccion de servicio */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 203005
      return 203005
   end
end
commit tran
return 0


GO


