/*******************************************************************/
/*  Archivo:          cccineg.sp                                   */
/*  Stored procedure: sp_causa_ingegr                              */
/*  Base de datos:    cob_cuentas                                  */
/*  Producto:         Cuentas de Ahorros                           */
/*******************************************************************/
/*                         IMPORTANTE                              */
/* Esta aplicacion es parte de los paquetes bancarios propiedad    */
/* de COBISCorp.                                                   */
/* Su uso no autorizado queda expresamente prohibido asi como      */
/* cualquier alteracion o agregado  hecho por alguno de sus        */
/* usuarios sin el debido consentimiento por escrito de COBISCorp. */
/* Este programa esta protegido por la ley de derechos de autor    */
/* y por las convenciones  internacionales   de  propiedad inte-   */
/* lectual.    Su uso no  autorizado dara  derecho a COBISCorp para*/
/* obtener ordenes  de secuestro o retencion y para  perseguir     */
/* penalmente a los autores de cualquier infraccion.               */
/*******************************************************************/
/*                           PROPOSITO                             */
/*  Este programa procesa la transaccion de:                       */
/*  Paramterización Causales Otros Ingresos/Egresos                */
/*******************************************************************/
/*                        MODIFICACIONES                           */
/*  FECHA                 AUTOR           RAZON                    */
/* 12/Jul/2016          J. Tagle        Migración a CEN            */
/*******************************************************************/

use cob_cuentas
go

SET ANSI_NULLS OFF
go

IF OBJECT_ID('dbo.sp_causa_ingegr') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.sp_causa_ingegr
END
go
create proc sp_causa_ingegr (
    @s_ssn                int,
    @s_srv                varchar(30),
    @s_lsrv               varchar(30),
    @s_user               varchar(30),
    @s_sesn               int,
    @s_term               varchar(10),
    @s_date               datetime,
    @s_ofi                smallint,
    @s_rol                smallint     = 1,
    @s_org_err            char(1)      = null,
    @s_error              int          = null,
    @s_sev                tinyint      = null,
    @s_msg                varchar(264) = null,
    @s_org                char(1),
    @t_debug              char(1)      = 'N',
    @t_file               varchar(14)  = null,
    @t_from               varchar(32)  = null,
    @t_rty                char(1)      = 'N',
    @t_trn                smallint,
    @i_operacion          char(1)      = 'S',     -- Tipo operacion I(Insert), D(Delete), S(Select), U(Update)
    @i_tipo               char(1),                -- I(Ingreso), E(Egreso) 
    @i_causal             varchar(3),             -- Causa
    @i_cobro_iva          char(1)      = 'N',     -- (S) Cobra IVA, (N) No cobra IVA
    @i_costo              money        = null,    -- Costo para el servicio
    @i_gasto_banco        char(1)      = null,    -- (S) Es gasto banco y cobra GMF, (N) no marcado
    @i_efectivo           char(1)      = null,    -- Tipos de medio de pago permitidos
    @i_chq_propio         char(1)      = null,
    @i_chq_local          char(1)      = null,
    @i_ndnc_cte           char(1)      = null,     -- Nota debito/credito corrientes
    @i_ndnc_aho           char(1)      = null,     -- Nota debito/credito ahorros
    @i_causa_cte          char(3)      = null,     -- Causa ndnc corrientes
    @i_caurev_cte         char(3)      = null,     -- Causa reversion ndnc corrientes        
    @i_causa_aho          char(3)      = null,     -- Causa ndnc ahorros
    @i_caurev_aho         char(3)      = null,     -- Causa reversion ndnc ahorros
    @i_programa           varchar(40)  = null,
    @i_vigencia           smallint     = null
)
as

declare
    @w_return     int,
    @w_sp_name    varchar(30),
    @w_estado     char(1),
    @v_estado     char(1),
    @w_tabla      varchar(25),
    @w_oficial    smallint,  --ARV ENE/02/2001
    @w_prod_ndnc  tinyint,
    @w_causa_ndnc char(3),
    @w_comision   char(1)
 
/*  Captura nombre de Stored Procedure  */

select  @w_sp_name = 'sp_causa_ingegr'


if @t_trn = 2916                /*    Consulta de Registros    */ 
begin
   if @i_tipo = 'I'
      select @w_tabla = 'cc_causa_oioe'
   else
      select @w_tabla = 'cc_causa_oe'

   if @i_operacion = 'S'
   begin
      set rowcount 20
      
      if @i_tipo = 'I'
      begin 
         select 
         'CAUSAL'              = ci_causal,
         'DESC. CAUSAL'        = substring(valor,1,45),
         'COB. IVA'            = ci_cobro_iva,
         'COSTO'               = ci_costo, 
         'GASTO B.'            = ci_gasto_banco,  
         'EFEC.'               = ci_efectivo,
         'CHQ. PROP.'          = ci_chq_propio,
         'CHQ. LOC.'           = ci_chq_local,
         'ND/NC AH'            = ci_ndnc_aho,
         'CAUSA ND/NC AH'      = ci_causa_aho,
         'CAUSA REV ND/NC AH.' = ci_caurev_aho,                 
         'ND/NC CC'            = ci_ndnc_cte,
         'CAUSA ND/NC CC.'     = ci_causa_cte,
         'CAUSA REV ND/NC CC.' = ci_caurev_cte,
         'PROGRAMA INTERFAZ'   = ci_programa,
         'VIGENCIA ORDEN'      = ci_vigencia
         from cob_cuentas..cc_causa_ingegr,
              cobis..cl_tabla x, 
              cobis..cl_catalogo y
         where ci_tipo   = @i_tipo 
         and x.tabla   = @w_tabla 
         and x.codigo  = y.tabla 
         and y.codigo  = ci_causal
         and ci_causal >= isnull(@i_causal,'')
         order by ci_causal
      end
      else
      begin
         select 
         'CAUSAL'              = ci_causal,
         'DESC. CAUSAL'        = substring(valor,1,45),
         'COB. IVA'            = ci_cobro_iva,
         'COSTO'               = ci_costo, 
         'GASTO B.'            = ci_gasto_banco,  
         'EFEC.'               = ci_efectivo,
         'CHQ. PROP.'          = ci_chq_propio,
         'CHQ. LOC.'           = ci_chq_local,
         'ND/NC AH'            = ci_ndnc_aho,
         'CAUSA ND/NC AH'      = ci_causa_aho,
         'CAUSA REV ND/NC AH.' = ci_caurev_aho,                 
         'ND/NC CC'            =  ci_ndnc_cte,
         'CAUSA ND/NC CC.'     = ci_causa_cte,
         'CAUSA REV ND/NC CC.' = ci_caurev_cte,
         'PROGRAMA INTERFAZ'   = ci_programa,
         'VIGENCIA ORDEN'      = ci_vigencia               
         from cob_cuentas..cc_causa_ingegr,
              cobis..cl_tabla x, 
              cobis..cl_catalogo y
         where ci_tipo   = @i_tipo 
         and   x.tabla   = @w_tabla 
         and   x.codigo  = y.tabla 
         and   y.codigo  = ci_causal
         and   ci_causal >= isnull(@i_causal,'')
         order by ci_causal        
      end

      if @@rowcount = 0
      begin
         exec cobis..sp_cerror
         @t_debug  = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 351048
         return 351048
      end
      
      set rowcount 0
   end   
end


if  ( (@t_trn = 2913 or @t_trn = 2914) )
begin

    if ((@i_ndnc_cte = 'S' and (@i_causa_cte is null or @i_caurev_cte is null)) or
        (@i_ndnc_aho = 'S' and (@i_causa_aho is null or @i_caurev_aho is null )))
    begin  
       exec cobis..sp_cerror  -- Campos NOT NULL con valores Nulos
       @t_debug  = @t_debug,
       @t_file   = @t_file,
       @t_from   = @w_sp_name,
       @i_num    = 2101001
       return 2101001          
    end

    /* verifica que la causa de ND No tenga cobro de IVA */

    if  @i_tipo = 'I'
    begin
       -- ND ahorros
       if @i_ndnc_aho = 'S'
       begin
          select  @w_prod_ndnc  = 4
          select  @w_causa_ndnc = @i_causa_aho
           
          select @w_comision = 'N'       
          select @w_comision = an_comision
          from   cob_remesas..re_accion_nd
          where  an_producto = @w_prod_ndnc
          and    an_causa    = @w_causa_ndnc 
             
          if @w_comision  = 'S'  
          begin
             exec cobis..sp_cerror1
             @t_debug     = @t_debug,
             @t_file      = @t_file,
             @t_from      = @w_sp_name, 
             @i_num       = 201300,
             @i_msg       = 'Para  causal de ND Ahorros en OI/E no se permite cobro de IVA'
             return    201300   /* Causal ND/NC de OI/OE no permite cobro de IVA */                    
          end  
       end -- aho      
       
       -- ND corrientes
       if @i_ndnc_cte = 'S' 
       begin
          select  @w_prod_ndnc  = 3
          select  @w_causa_ndnc = @i_causa_cte 
              
          select @w_comision  = 'N'       
          select @w_comision = an_comision
          from  cob_remesas..re_accion_nd
          where an_producto = @w_prod_ndnc
          and   an_causa    = @w_causa_ndnc 
       
          if @w_comision  = 'S'  
          begin
             exec cobis..sp_cerror1
             @t_debug     = @t_debug,
             @t_file      = @t_file,
             @t_from      = @w_sp_name, 
             @i_num       = 201300,
             @i_msg       = 'Para  causal de ND Corrientes en OI/E no se permite cobro de IVA'
             return    201300   /* Causal ND/NC de OI/OE no permite cobro de IVA */                    
          end  
       end   -- cta cte
    end -- tipo = 'I'
    else  -- egreso
    begin
       -- valida el cobro de iva para el reverso de la nota credito, que es una nota debito
       -- ND ahorros
       if @i_ndnc_aho = 'S'
       begin
          select  @w_prod_ndnc  = 4
          select  @w_causa_ndnc = @i_caurev_aho
        
          select @w_comision  = 'N'       
          select @w_comision = an_comision
          from  cob_remesas..re_accion_nd
          where  an_producto = @w_prod_ndnc
          and  an_causa    = @w_causa_ndnc 
           
          if @w_comision  = 'S'  
          begin
             exec cobis..sp_cerror1
             @t_debug     = @t_debug,
             @t_file      = @t_file,
             @t_from      = @w_sp_name, 
             @i_num       = 201300,
             @i_msg       = 'Para  causal de ND Ahorros en OI/E no se permite cobro de IVA'
             return    201300   /* Causal ND/NC de OI/OE no permite cobro de IVA */                    
          end  
       end -- aho      
    
       -- ND corrientes
       if @i_ndnc_cte = 'S' 
       begin
          select  @w_prod_ndnc  = 3
          select  @w_causa_ndnc = @i_caurev_cte
           
          select @w_comision  = 'N'       
          select @w_comision = an_comision
          from   cob_remesas..re_accion_nd
          where  an_producto = @w_prod_ndnc
          and    an_causa    = @w_causa_ndnc 

          if @w_comision  = 'S'  
          begin
             exec cobis..sp_cerror1
             @t_debug     = @t_debug,
             @t_file      = @t_file,
             @t_from      = @w_sp_name, 
             @i_num       = 201300,
             @i_msg       = 'Para  causal de ND Corrientes en OI/E no se permite cobro de IVA'
             return    201300   /* Causal ND/NC de OI/OE no permite cobro de IVA */                    
          end  
       end   -- cta cte
   end
end

if @t_trn = 2913                /*   Creacion del registro    */
begin
   begin tran
      /* Valida Duplicados */
      if exists (select 1
                 from  cob_cuentas..cc_causa_ingegr
                 where ci_tipo      = @i_tipo
                 and   ci_causal    = @i_causal)
      begin 
         exec cobis..sp_cerror
         @t_debug   = @t_debug,
         @t_file    = @t_file,
         @t_from    = @w_sp_name,
         @i_num     = 351047
         return 351047
      end
 
      /* Registro en la Tabla */ 
      insert into cob_cuentas..cc_causa_ingegr(
      ci_tipo,        ci_causal,     ci_cobro_iva,  ci_costo,  
      ci_gasto_banco, ci_efectivo,   ci_chq_propio, ci_chq_local,
      ci_ndnc_cte,    ci_causa_cte,  ci_caurev_cte, ci_ndnc_aho, 
      ci_causa_aho,   ci_caurev_aho, ci_programa,   ci_vigencia)
      values (
      @i_tipo,        @i_causal,     @i_cobro_iva,  @i_costo,  
      @i_gasto_banco, @i_efectivo,   @i_chq_propio, @i_chq_local,
      @i_ndnc_cte,    @i_causa_cte,  @i_caurev_cte, @i_ndnc_aho, 
      @i_causa_aho,   @i_caurev_aho, @i_programa,   @i_vigencia)
      
      if @@error != 0
      begin
         exec cobis..sp_cerror
         @t_debug  = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 201273
         return 201273
      end
      
      /* Creacion de Transaccion de Servicio */
      insert into cob_cuentas..cc_tran_servicio(
      ts_secuencial, ts_tipo_transaccion, ts_tsfecha, ts_causa,    ts_referencia,
      ts_usuario,    ts_terminal,         ts_oficina, ts_producto, ts_hora,
      ts_nombre,     ts_numero)
      values (
      @s_ssn,        @t_trn,              @s_date,     @i_causal,  @i_tipo + ',' + @i_cobro_iva + ',' + @i_efectivo,  
      @s_user,       @s_term,             @s_ofi,      3,          getdate(),
      @i_programa,   @i_vigencia)
      
      /* Error en creacion de transaccion de servicio */
      if @@error != 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 203005
         return 203005
      end
   commit tran
end

if @t_trn = 2915                   /*  Eliminacion del  Registro  */
begin
   select 1
   from  cob_cuentas..cc_causa_ingegr
   where ci_tipo     = @i_tipo
   and   ci_causal   = @i_causal
          
   if @@rowcount != 1
   begin
      /* Causal Ingresos_Egreso no existe */
      exec cobis..sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num  = 208106
      return 208106
   end

   begin tran

      delete cob_cuentas..cc_causa_ingegr
      where  ci_tipo     = @i_tipo
      and    ci_causal   = @i_causal
      
      if @@rowcount != 1
      begin
         /* Error en eliminacion causal Ing_Egr Varios */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 201274
         return 201274
      end

      /* Creacion de Transaccion de Servicio */
      insert into cob_cuentas..cc_tran_servicio (
      ts_secuencial, ts_tipo_transaccion, ts_tsfecha, ts_causa,    ts_referencia,
      ts_usuario,    ts_terminal,         ts_oficina, ts_producto, ts_hora)
      values (
      @s_ssn,        @t_trn,              @s_date,    @i_causal,   @i_tipo + ',' + @i_cobro_iva + ',' + @i_efectivo,
      @s_user,       @s_term,             @s_ofi,     3,           getdate())
                                  

      /* Error en creacion de transaccion de servicio */
      if @@error != 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 203005
         return 203005
      end
   commit tran
end

if @t_trn = 2914                   /*  Actualizacion Registro  */
begin
   select 1
   from  cob_cuentas..cc_causa_ingegr
   where ci_tipo     = @i_tipo
   and   ci_causal   = @i_causal
          
   if @@rowcount != 1
   begin
      /* Causal Ingresos_Egreso no existe */
      exec cobis..sp_cerror
      @t_debug    = @t_debug,
      @t_file     = @t_file,
      @t_from     = @w_sp_name,
      @i_num      = 208106
      return 208106
   end

   begin tran
      update cob_cuentas..cc_causa_ingegr set
      ci_cobro_iva   = @i_cobro_iva,
      ci_costo       = @i_costo,
      ci_gasto_banco = @i_gasto_banco,
      ci_efectivo    = @i_efectivo,
      ci_chq_propio  = @i_chq_propio,
      ci_chq_local   = @i_chq_local,
      ci_ndnc_cte    = @i_ndnc_cte,
      ci_causa_cte   = @i_causa_cte,
      ci_caurev_cte  = @i_caurev_cte,
      ci_ndnc_aho    = @i_ndnc_aho,
      ci_causa_aho   = @i_causa_aho,
      ci_caurev_aho  = @i_caurev_aho,
      ci_programa    = @i_programa,
      ci_vigencia    = @i_vigencia
      where ci_tipo     = @i_tipo
      and   ci_causal   = @i_causal
      
      if @@rowcount != 1
      begin
         /* Error en actualizar Ing_Egr varios */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 201273
         return 201273
      end
      
      /* Creacion de Transaccion de Servicio */
      insert into cob_cuentas..cc_tran_servicio(
      ts_secuencial, ts_tipo_transaccion, ts_tsfecha, ts_causa,    ts_referencia,
      ts_usuario,    ts_terminal,         ts_oficina, ts_producto, ts_hora,
      ts_nombre,     ts_numero)
      values (
      @s_ssn,        @t_trn,              @s_date,     @i_causal,  @i_tipo + ',' + @i_cobro_iva + ',' + @i_efectivo,  
      @s_user,       @s_term,             @s_ofi,      3,          getdate(),
      @i_programa,   @i_vigencia)

      /* Error en creacion de transaccion de servicio */
      if @@error != 0
      begin
         exec cobis..sp_cerror
         @t_debug     = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 203005
         return 203005
      end
   commit tran
end
return 0
go
