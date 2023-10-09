/************************************************************************/
/*      Archivo:                pignoracion.sp                          */
/*      Stored procedure:       sp_pignoracion                          */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Miryam Davila                           */
/*      Fecha de documentacion: 24/Oct/94                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este script crea los procedimientos para las transacciones de   */
/*      adicion, modificacion, eliminacion, search y query de las       */
/*      pignoraciones en plazos fijos.                                  */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA        AUTOR            RAZON                             */
/*      24-Oct-1994  J. Lam           Creacion                          */
/*      23-Ago-1995  C. Alvarado      Cambios                           */
/*      11-Jul-1997  D. Guerrero      Control de pignoraciones          */
/*      26-Nov-2002  N. Silva         Cambio de logica                  */
/*      02-Sep-2016  N. Martillo      Fuente tomado de FIE              */
/************************************************************************/
use cob_pfijo
go

if exists (select * from sysobjects where type = 'P' and name = 'sp_pignoracion')
   drop proc sp_pignoracion
go

create proc sp_pignoracion(
       @s_ssn                  int             = null,
       @s_user                 login           = null,
       @s_term                 varchar(30)     = null,
       @s_date                 datetime        = null,
       @s_srv                  varchar(30)     = null,
       @s_lsrv                 varchar(30)     = null,
       @s_ofi                  smallint        = null,
       @s_rol                  smallint        = null,
       @t_debug                char(1)         = 'N',
       @t_file                 varchar(10)     = null,
       @t_from                 varchar(32)     = null,
       @t_trn                  smallint        = null,
       @i_operacion            char(1),
       @i_num_banco            cuenta          = null,
       @i_cuenta               cuenta          = null,
       @i_producto             catalogo        = null,
       @i_valor                money           = null,
       @i_tasa                 float           = null,
       @i_spread               float           = 0,
       @i_motivo               descripcion     = null,
       @i_formato_fecha        int             = 0,
       @i_cuenta_gar           cuenta          = null,
       @i_observacion          descripcion     = null
)     
as

SET NOCOUNT ON
 

declare @w_sp_name              descripcion,
        @w_return               int,
        @w_operacionpf          int,
        @w_cuenta               cuenta,
        @w_producto             catalogo,
        @w_valor                money,
        @w_tasa                 float,
        @w_funcionario          login,
        @w_oficina              smallint,
        @w_spread               float,
        @w_fecha_crea           datetime,
        @w_fecha_mod            datetime,
        @w_motivo               descripcion,
        @w_monto_garantia       money,           -- monto pignorado por codigo de garantia
        @w_monto_control        money,
        @v_operacionpf          int,
        @v_producto             catalogo,
        @v_cuenta               cuenta,
        @v_valor                money,
        @v_tasa                 float,
        @v_funcionario          login,
        @v_oficina              smallint,
        @v_spread               float, 
        @v_motivo               descripcion,
        @v_fecha_crea           datetime,
        @v_fecha_mod            datetime,
        @i_funcionario          login,
        @i_oficina              smallint,
        @i_fecha_crea           datetime,
        @i_fecha_mod            datetime,
        @p_monto_pgdo           money,
        @p_monto_blq            money,
        @p_monto_operacion      money,
        @p_valor                money,
        @p_historia             smallint,
        @p_clase                char(1),
        @p_pignorado            char(1),
        @p_clase_u              char(1),
        @w_observacion          descripcion,
        @v_observacion          descripcion,
        @w_linea_activas        char(1),
        @w_codtabla             int,
        @w_descripcion          descripcion,
        @w_producto_cobis       tinyint,
        @w_moneda               tinyint,
        @w_comprobante          int,
        @w_toperacion           catalogo,
        @w_tplazo               catalogo,
        @w_ente                 int,
        @w_afectacion           char(1),
        @w_error                int,
        @w_plazo_cont           catalogo,
        @w_pignorado            char(1),
        @w_msg                  varchar(80),
        @w_control              int,
        @w_blq_legal            char(1),
		@w_existe_cta_act       int,
		@w_desacople_cta        char(1)


select @w_sp_name     = 'sp_pignoracion',
       @i_funcionario = @s_user,
       @i_oficina     = @s_ofi,
       @i_fecha_mod   = @s_date,
       @w_error       = 0

if (@t_trn != 14107 or @i_operacion != 'I') and
   (@t_trn != 14207 or @i_operacion != 'U') and
   (@t_trn != 14307 or @i_operacion != 'D') and
   (@t_trn != 14407 or @i_operacion != 'Q') and
   (@t_trn != 14507 or @i_operacion != 'S') and
   (@t_trn != 14607 or @i_operacion != 'H')
begin
     exec cobis..sp_cerror
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_num       = 141112
     return 1
end        

--------------------
-- Seccion de Query
--------------------
if @i_operacion = 'Q'
begin

    select @w_codtabla = codigo
    from cobis..cl_tabla
    where tabla = 'pf_motivo_pig'

    select o_operacionpf = pi_operacion,
           o_producto    = isnull(pd_descripcion,pi_producto),
           o_cuenta      = pi_cuenta,
           o_valor       = pi_valor,
           o_tasa        = pi_tasa,
           o_funcionario = pi_funcionario,
           o_oficina     = pi_oficina,
           o_spread      = pi_spread,
           o_motivo      = codigo,
           o_fecha_crea  = convert(varchar,pi_fecha_crea,@i_formato_fecha),
           o_fecha_mod   = convert(varchar,pi_fecha_mod, @i_formato_fecha)
     from pf_pignoracion LEFT OUTER JOIN cobis..cl_producto ON (pi_producto  = pd_abreviatura)
                         LEFT OUTER JOIN cobis..cl_catalogo a ON (pi_motivo = a.codigo and a.tabla = @w_codtabla),
          pf_operacion
      where op_num_banco = @i_num_banco
        and pi_operacion = op_operacion
        and pi_producto  = @i_producto
        and pi_spread    = @i_spread
        and pi_cuenta    = @i_cuenta

    if @@rowcount = 0
    begin
        exec cobis..sp_cerror 
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,   
             @i_num   = 141065
        return 1
    end
    return 0
end


select @i_cuenta = isnull(@i_cuenta,' ')

---------------------
-- Seccion de Search
---------------------
if @i_operacion = 'S'
begin
    
    select @w_codtabla = codigo
    from cobis..cl_tabla
    where tabla = 'pf_motivo_pig'
    
    select 'PRODUCTO'    = pi_producto,
           'CUENTA'      = pi_cuenta,
           'MONTO'       = pi_valor,
           'SPREAD'      = pi_spread,
           'MOTIVO'      = a.valor,
           'FECHA CREA'  = convert(varchar,pi_fecha_crea,@i_formato_fecha),
           'FUNCIONARIO' = pi_funcionario,
           'OFICINA'     = pi_oficina,
           'TASA'        = pi_tasa,
           'OPERACION'   = pi_operacion,
           'OBSERVACION' = pi_observacion,
           'NOMBRE FUNCIONARIO' = (select fu_nombre from cobis..cl_funcionario where fu_login = b.pi_funcionario)  
    from pf_pignoracion b LEFT OUTER JOIN cobis..cl_catalogo a ON (pi_motivo = a.codigo and a.tabla = @w_codtabla),
         pf_operacion      
    where op_num_banco   = @i_num_banco 
      and pi_operacion   = op_operacion
    
   return 0
end
-------------------
-- Seccion de Help
-------------------
if @i_operacion = 'H'
begin

    select  'OPERACION'= pi_operacion,
            'PRODUCTO' = pi_producto,
            'CUENTA'   = pi_cuenta,
            'MONTO'    = pi_valor
    from pf_pignoracion,
         pf_operacion
    where op_num_banco = @i_num_banco
      and pi_operacion = op_operacion

    return 0
end

-----------------------------------------------------------
-- Verificar la existencia de la operacion en pf_operacion
-----------------------------------------------------------
select @w_operacionpf     = op_operacion,
       @p_monto_operacion = op_monto,
       @p_monto_pgdo      = op_monto_pgdo,
       @p_monto_blq       = op_monto_blq,
       @p_historia        = op_historia,
       @w_monto_control   = op_monto_pgdo,
       @w_producto_cobis  = op_producto,
       @w_moneda          = op_moneda,
       @w_oficina         = op_oficina,
       @w_toperacion      = op_toperacion,
       @w_tplazo          = op_tipo_plazo,
       @w_plazo_cont      = op_plazo_cont,
       @w_ente            = op_ente,
       @w_pignorado       = op_pignorado,
       @w_blq_legal       = op_bloqueo_legal
from pf_operacion
where op_num_banco = @i_num_banco

if @@rowcount = 0
begin
    exec cobis..sp_cerror 
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,   
         @i_num   = 141051
    return 1
end

---------------------------------------
-- Operaciones Insert, Update y Delete
---------------------------------------
if @i_operacion in ( 'I','U','D') 
begin

   if @i_operacion = 'I' and @w_blq_legal = 'S' --control fie bol por contabilizacion--
   begin
         exec cobis..sp_cerror 
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,   
              @i_num   = 141200
         return 1
   end

   if exists (select 1
              from cobis..cl_tabla    a,
                   cobis..cl_catalogo b
              where a.codigo = b.tabla
                and a.tabla  = 'pf_producto_custodia'
                and b.codigo = @i_producto) and exists (select 1 
                                                        from cobis..cl_tabla    a,
                                                             cobis..cl_catalogo b
                                                        where a.codigo = b.tabla
                                                          and a.tabla  = 'pf_motivo_pig'
                                                          and b.codigo = @i_motivo)      
      select @w_sp_name = @w_sp_name
   else begin
      select @w_msg = '['+@w_sp_name+'] ' + 'Producto no definido en catalogo pf_producto_custodia o motivo no definido en pf_motivo_pig'
      exec cobis..sp_cerror 
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_msg   = @w_msg,
           @i_num   = 141065
      return 1
   end
  
   select @w_linea_activas = pa_char
   from cobis..cl_parametro
   where pa_producto = 'PFI'
     and pa_nemonico = 'ACT'


   begin tran

   --------------------------------------------------------------------
   -- Carga de Valores para transacciones de Servicio y actualizacion 
   --------------------------------------------------------------------
   if @i_operacion in ('U','D')
   begin
      if @i_cuenta_gar is null
      begin
           select @v_operacionpf  = pi_operacion,       
                  @v_producto     = pi_producto,  
                  @v_cuenta       = pi_cuenta,  
                  @v_valor        = pi_valor,
                  @v_tasa         = pi_tasa,
                  @v_funcionario  = pi_funcionario,
                  @v_oficina      = pi_oficina,
                  @v_spread       = pi_spread,
                  @v_fecha_crea   = pi_fecha_crea,
                  @v_motivo       = pi_motivo,    
                  @v_fecha_mod    = pi_fecha_mod,
                  @v_observacion  = pi_observacion
            from pf_pignoracion 
            where pi_operacion = @w_operacionpf
              and pi_cuenta    = @i_cuenta
              and pi_producto  = @i_producto
              and pi_spread    = @i_spread
      end
      else begin
           select @v_operacionpf = pi_operacion,       
                  @v_producto    = pi_producto,  
                  @v_cuenta      = pi_cuenta,  
                  @v_valor       = pi_valor,
                  @v_tasa        = pi_tasa,
                  @v_funcionario = pi_funcionario,
                  @v_oficina     = pi_oficina,
                  @v_spread      = pi_spread,
                  @v_fecha_crea  = pi_fecha_crea,
                  @v_motivo      = pi_motivo,    
                  @v_fecha_mod   = pi_fecha_mod
           from pf_pignoracion 
           where pi_operacion  = @w_operacionpf
             and pi_cuenta     = @i_cuenta
             and pi_producto   = @i_producto
             and pi_cuenta_gar = @i_cuenta_gar
       end

      if @@rowcount = 0 or (@i_cuenta_gar is not null and @v_valor != @i_valor and @i_operacion = 'D')
      begin
         select @w_error = 141065
         goto ERROR
      end    
 
      if @i_operacion = 'D'
      begin
          select @p_clase_u = 'B',
                 @p_valor   = -@v_valor

          ----------------------------
          -- Evaluar valor a reversar
          ----------------------------
         if (@w_monto_control - @i_valor) > 0
            select @p_pignorado = 'S'
         else
            select @p_pignorado = 'N'
          
         -------------------------
         -- Borrar la pignoracion
         -------------------------
         if @i_cuenta_gar is not null
         begin
            if (@v_valor - @i_valor) <= 0
            begin
                 delete pf_pignoracion 
                 where pi_operacion   = @w_operacionpf
                   and pi_producto    = @i_producto
                   and pi_cuenta      = @i_cuenta
                   and pi_cuenta_gar  = @i_cuenta_gar
            end
            else begin
                 update pf_pignoracion
                 set pi_valor = pi_valor - @i_valor
                 where pi_operacion  = @w_operacionpf
                   and pi_producto   = @i_producto
                   and pi_cuenta     = @i_cuenta
                   and pi_cuenta_gar = @i_cuenta_gar
            end
         end
         else begin
              delete pf_pignoracion 
              where pi_operacion = @w_operacionpf
                and pi_producto  = @i_producto
                and pi_cuenta    = @i_cuenta
                and pi_spread    = @i_spread
         end

         if @@error != 0
         begin
            select @w_error = 147007  
            goto ERROR            
         end
         --------------------------------------------------------------
         -- Insercion previo de la transaccion de servicio y Eliminado
         --------------------------------------------------------------
         insert into ts_pignoracion 
                (secuencial,     tipo_transaccion, clase,
                 usuario,        terminal,         srv,
                 lsrv,           fecha,            operacion, 
                 producto,       cuenta,           valor, 
                 tasa,           funcionario,      oficina,
                 spread,         fecha_crea,       fecha_mod,
                 observacion,    ofi)
         values (@s_ssn,         @t_trn,           @p_clase_u,
                 @s_user,        @s_term,          @s_srv,
                 @s_lsrv,        @s_date,          @v_operacionpf,
                 @v_producto,    @v_cuenta,        @v_valor,
                 @v_tasa,        @v_funcionario,   @v_oficina, 
                 @v_spread,      @v_fecha_crea,    @v_fecha_mod,
                 @v_observacion, @s_ofi)
          if @@error != 0
          begin
               select @w_error = 143005 
               goto ERROR   
          end
      end     --D
   end        --('U','D')

   ----------------------------------------
   -- Proceso de insercion y actualizacion
   ----------------------------------------

   if @i_operacion in ('I','U')
   begin
      if @w_linea_activas = 'S' and @i_producto in ('CCA','CEX','GAR')
      begin
               if @i_producto = 'CCA'
			   begin
			      exec @w_return     = cob_interfase..sp_icartera
				       @i_operacion  = 'D',
					   @i_cuenta     = @i_cuenta,
					   @o_existe_cta = @w_control out
					   
                  if @w_return <> 0
				     return @w_return
               end

               if @i_producto = 'CEX'
			      exec @w_return     = cob_interfase..sp_icomext
                       @i_operacion  = 'I',
					   @i_cuenta     = @i_cuenta,
				       @o_control    = @w_control out
				  
               if @i_producto = 'GAR' 
                  select @w_control = case 
                                        when isnull(ltrim(rtrim(@i_cuenta)),'') = '' then 0
                                        else 1
                                      end 
              
               if isnull(@w_control,0) <> 1
                  select @w_error = case @i_producto  
                                      when 'CCA' then 141066
                                      when 'CEX' then 141214
                                      when 'GAR' then 141215
                                      else 0
                                    end 
      end 

      if @i_producto = 'CTE'
	  
         exec @w_return = cob_interfase..sp_icuentas
              @i_operacion      = 'A',
              @i_cta_ger        = @i_cuenta,
              @o_existe_cta_act = @w_existe_cta_act out,
			  @o_desacople_cta  = @w_desacople_cta  out
		
         if @w_existe_cta_act > 0 or @w_desacople_cta = 'S'
            select @w_sp_name = @w_sp_name
         else
            select @w_error = 141047
            
      
      if exists ( select 1 from cobis..cl_funcionario
                  where fu_login = @i_funcionario )
         select @w_sp_name = @w_sp_name
      else
         select @w_error = 141058    

      if @w_error != 0      
         goto ERROR             
      

      if isnull(@i_valor,0) <= 0
      begin
           select @w_error = 141011
           goto ERROR
      end
      
      ----------------------------------------------------------------
      -- Carga de Valores para transacciones de servicio en Insercion
      ----------------------------------------------------------------
      if @i_operacion = 'I'
      begin
         select @w_cuenta        = @i_cuenta,  
                @w_producto      = @i_producto,
                @w_valor         = @i_valor,
                @w_tasa          = @i_tasa,
                @w_funcionario   = @i_funcionario,                
                @w_spread        = @i_spread,
                @w_fecha_crea    = @s_date,
                @w_fecha_mod     = @s_date,
                @i_fecha_crea    = @s_date,
                @i_fecha_mod     = @s_date,
                @p_valor         = @i_valor,
                @p_pignorado     = 'S',
                @p_clase         = 'N',
                @v_observacion   = @i_observacion

          ---------------------------------
          -- Almacenamiento de pignoracion
          ---------------------------------
          select @w_spread = isnull(max(pi_spread),0) 
          from pf_pignoracion
          where pi_operacion = @w_operacionpf

          select @w_spread = @w_spread + 1      
    
          insert into pf_pignoracion 
                 (pi_operacion,   pi_producto, pi_cuenta,
                  pi_valor,       pi_tasa,     pi_funcionario,
                  pi_oficina,     pi_spread,   pi_fecha_crea, 
                  pi_fecha_mod,   pi_motivo,   pi_cuenta_gar,
                  pi_observacion)
          values( @w_operacionpf, @i_producto, @i_cuenta, 
                  @i_valor,       @i_tasa,     @i_funcionario,
                  @i_oficina,     @w_spread,   @i_fecha_crea,
                  @i_fecha_mod,   @i_motivo,   @i_cuenta_gar,
                  @i_observacion)

          if @@error != 0
          begin
               select @w_error = 143007
               goto ERROR              
          end

      end --if operacion = 'I'--

      --------------------------------
      -- Actualizacion de pignoracion
      --------------------------------
      if @i_operacion = 'U'
      begin
         select @w_producto    = @w_producto, 
                @w_cuenta      = @w_cuenta, 
                @w_fecha_mod   = @s_date,
                @i_fecha_mod   = @s_date,        
                @p_valor       = @i_valor - @v_valor,
                @p_pignorado   = 'S',
                @p_clase       = 'A',
                @p_clase_u     = 'P'
     
         if @v_valor = @i_valor
            select @v_valor = null, @w_valor = null
         else
            select @w_valor = @i_valor
         if @v_tasa = @i_tasa
            select @v_tasa = null, @w_tasa = null
         else
            select @w_tasa = @i_tasa
         if @v_funcionario = @i_funcionario
            select @v_funcionario = null, @w_funcionario = null
         else
            select @w_funcionario = @i_funcionario
         if @v_oficina = @i_oficina
            select @v_oficina = null, @w_oficina = null
         else
            select @w_oficina = @i_oficina
         if @v_spread = @i_spread
            select @v_spread = null, @w_spread = null
         else
            select @w_spread = @i_spread

         update pf_pignoracion
         set pi_valor       = @i_valor,
             pi_tasa        = @i_tasa,
             pi_funcionario = @i_funcionario,
             pi_oficina     = @i_oficina,
             pi_spread      = @i_spread,
             pi_motivo      = @i_motivo,
             pi_fecha_mod   = @i_fecha_mod
         where pi_operacion   = @w_operacionpf
           and pi_producto    = @i_producto
           and pi_cuenta      = @i_cuenta
           and (pi_cuenta_gar = @i_cuenta_gar or @i_cuenta_gar is null)
    
         if @@rowcount = 0 or @@error != 0
         begin
             select @w_error = 145007
             goto ERROR         
         end

      end


      if @p_monto_pgdo + @p_valor + @p_monto_blq > @p_monto_operacion
      begin
           select @w_error = 141067
           goto ERROR         
      end

      ----------------------------------------------------
      -- Insercion transaccion de servicio act. Insercion 
      ----------------------------------------------------
      insert into ts_pignoracion 
             (secuencial,     tipo_transaccion, clase,
              usuario,        terminal,         srv,
              lsrv,           fecha,            operacion, 
              producto,       cuenta,           valor,
              tasa,           funcionario,      oficina,
              spread,         fecha_crea,       fecha_mod,
              observacion,    ofi)
      values (@s_ssn,         @t_trn,           @p_clase,
              @s_user,        @s_term,          @s_srv,
              @s_lsrv,        @s_date,          @w_operacionpf,
              @w_producto,    @w_cuenta,        @w_valor,
              @w_tasa,        @w_funcionario,   isnull(@w_oficina,@i_oficina), 
              @w_spread,      @w_fecha_crea,    @w_fecha_mod,
              @i_observacion, @s_ofi)

      if @@error != 0
      begin
           select @w_error = 143005
           goto ERROR         
      end
   end    --('I','U')


   --Contabilizacion de pignoraciones--

   if (@w_pignorado = 'N' and @i_operacion = 'I') or 
      (@p_pignorado = 'N' and @i_operacion = 'D') --se contabiliza el monto total del deposito al registrar la primera pignoracion o eliminar la ultima
   begin

        select @w_descripcion = case @i_operacion 
                                  when 'I' then 'PIGNORACION (' + @i_num_banco + ')'
                                  when 'D' then 'LEVANTAMIENTO PIGNORACION (' + @i_num_banco + ')'
                                end
        select @w_afectacion  = case @i_operacion 
                                  when 'I' then 'N'
                                  when 'D' then 'R'
                                end
  
        exec @w_return = cob_pfijo..sp_aplica_conta
             @s_ssn              = @s_ssn,
             @s_user             = @s_user,
             @s_ofi              = @s_ofi,
             @s_date             = @s_date,
             @s_term             = @s_term,
             @t_debug            = @t_debug,
             @t_file             = @t_file,
             @t_from             = @t_from,
             @t_trn              = 14937,
             @i_empresa          = 1,
             @i_fecha            = @s_date,
             @i_tran             = @t_trn,
             @i_producto         = @w_producto_cobis,/* op_producto de pf_operacion */
             @i_moneda           = @w_moneda,
             @i_oficina          = @s_ofi,       
             @i_oficina_oper     = @w_oficina,    /* op_oficina de pf_operacion  */
             @i_toperacion       = @w_toperacion, /* op_toperacion de pf_operacion */
             @i_tplazo           = @w_plazo_cont, /* plazo contable */
             @i_operacionpf      = @w_operacionpf,
             @i_afectacion       = @w_afectacion, /* N=Normal , R=Reverso */
             @i_descripcion      = @w_descripcion,
             @i_secuencia        = 0,
             @i_monto            = @p_monto_operacion, ---@i_valor, todo el monto pignorado pasa a cuenta contable dep restringidos
             @i_ente             = @w_ente,
             @o_comprobante      = @w_comprobante out

        select @w_error = @@error

        if @w_return != 0 or @w_error != 0
        begin  
              select @w_error = 149032
              goto ERROR  
        end        
      
        insert into pf_relacion_comp
               (rc_num_banco, rc_comp,        rc_cod_tran, rc_tran,
                rc_estado,    rc_secuencia,   rc_numero,   rc_fecha_tran)
        values (@i_num_banco, @w_comprobante, @t_trn,      'PGE', 
                'N',          null,           0,           @s_date)

        if @@error != 0 or @@rowcount != 1
        begin
           select @w_error = 143054
           goto ERROR                    
        end
   end --condicion para contabilizar--


   update pf_operacion 
   set op_historia   = @p_historia + 1,
       op_monto_pgdo = op_monto_pgdo + @p_valor,
       op_fecha_mod  = @i_fecha_mod,
       op_pignorado  = @p_pignorado
   where op_operacion= @w_operacionpf
     and op_historia = @p_historia

   if @@error != 0
   begin
        select @w_error = 145001
        goto ERROR         
   end
    

   insert into pf_historia 
          (hi_operacion,   hi_secuencial,  hi_fecha,   hi_trn_code ,
           hi_valor,       hi_funcionario, hi_oficina, hi_observacion,
           hi_fecha_crea,  hi_fecha_mod) 
   values (@w_operacionpf, @p_historia,    @s_date,    @t_trn,
           abs(@p_valor),  @s_user,        @i_oficina, @i_motivo,
           @s_date,        @s_date)
   if @@error != 0
   begin
        select @w_error = 143006
        goto ERROR               
   end             

   commit tran

end

return 0

ERROR:
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = @w_error 

      if @@trancount > 0
         rollback tran

      return 1

go
