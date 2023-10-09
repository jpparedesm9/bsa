/************************************************************************/
/*	Archivo: 	        pagoaval.sp                             */
/*	Stored procedure:       sp_pago_avaluador                       */
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Milena Gonzalez                  	*/
/*	Fecha de escritura:     Diciembre-2000				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa permite realizar los pagos de a los avaluadores   */
/*      generando las cuentas por cobrar (cliente) y cuentas por cobrar */
/*      (avaluador).                                                    */
/************************************************************************/
/*      Nov/2002  JVelandia  incl i_registro  Banagrario                */
/*      Eliminar sidac cuentasxcobrar  efectuarlo a cartera Nov 2002/JVC*/   
/************************************************************************/

use cob_custodia
go
if exists (select 1 from sysobjects where name = 'sp_pago_avaluador')
    drop proc sp_pago_avaluador
go
create proc sp_pago_avaluador (
   @s_ssn                int          = null,
   @s_ssn_corr           int          = null,
   @s_date               datetime     = null,
   @s_user               login        = null,
   @s_term               varchar(64)  = null,
   @s_corr               char(1)      = null,
   @s_ofi                smallint     = null,
   @s_srv                varchar(30)  = null,
   @s_lsrv               varchar(30)  = null,
   @t_rty                char(1)      = null,
   @t_from               varchar(30)  = null,
   @t_trn                smallint     = null,
   @t_debug              char(1)      = 'N',
   @t_file               varchar(14)  = NULL,
   @i_operacion          char(1)      = null,
   @i_modo               smallint     = null,
   @i_filial             tinyint      = null,
   @i_oficina            smallint     = null,
   @i_pago               char(1)      = null,
   @i_inspector          int      = null, --boton siguientes
   @i_codigo_externo     varchar(64)  = null, --boton siguientes
   @i_valor_facturado    money        =  null,
   @i_registro           char(1)      = null  --JVC pago en Sidac 
)
as
declare
   @w_today              datetime,     
   @w_return             int,         
   @w_retorno            int,        
   @w_sp_name            varchar(32),
   @w_existe             tinyint,   
   @w_filial             tinyint,
   @w_sucursal           smallint,
   @w_error              int,
   @w_inspector          int,
   @w_fenvio_carta       datetime ,
   @w_frecep_reporte     datetime ,
   @w_valor_facturado    money,
   @w_valor_pagado       money,
   @w_fecha_pago         datetime,
   @w_fmaxrecep          datetime,
   @w_lote               tinyint ,
   @w_ente               int,
   @w_cliente            int,  --pga 14ago2001
   @w_area_custodia      smallint,     --pga 17ago2001
   @w_concepto           varchar(30),  --pga 17ago2001
   @w_tipo_referencia    varchar(30),  --pga 17ago2001
   @w_condicion          varchar(30),  --pga 17ago2001
   @w_producto           tinyint,      --pga 17ago2001 
   @w_ente_ins           int,
   @w_custodia           int,
   @w_codigo_externo     cuenta  ,            --varchar(64),
   @w_secservicio        int, 
   @w_pagado             money, 
   @w_facturado          money ,
   @w_banco              cuenta ,  -- operacion jvc 
   @w_moneda             tinyint,  -- moneda de la op jv  
   @w_linea              catalogo ,  -- linea
   @wro_tipo_rubro       char(1),
   @wdi_dividendo        smallint ,
   @w_operacion          int,
   @w_tramite            int,--emg dic-3-02
   @w_sec_tran           int,
   @w_referencia_sidac   descripcion,
   @w_rowcount           int

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_pago_avaluador'


if (@t_trn <> 19912 and @i_operacion = 'S') or
   (@t_trn <> 19913 and @i_operacion = 'A') 
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,

    @i_num   = 1901006
    return 1 
end

--pga 18may2001
select @w_secservicio = @@spid

--pga 17ago2001
/** SELECCION DEL AREA DE GARANTIAS**/
select @w_area_custodia = pa_smallint
from cobis..cl_parametro
where pa_producto = 'GAR'
and pa_nemonico = 'ARG'
set transaction isolation level read uncommitted

/* PARAMETRO DEL CONCEPTO DE PAGO AVALUADORES DEBE SER DEFINIDO COMO RUBRO PARA LA LINEA*/
select @w_concepto = pa_char
from cobis..cl_parametro
where pa_nemonico = 'PGAAV'
  and pa_producto = 'GAR'
set transaction isolation level read uncommitted

/* CODIGO DEL PRODUCTO GARANTIAS */
select @w_producto = pd_producto
from cobis..cl_producto
where pd_abreviatura = 'GAR'
set transaction isolation level read uncommitted

/* CONDICION */
select @w_condicion = pa_char
from cobis..cl_parametro
where pa_nemonico = 'PCONDI'
  and pa_producto = 'GAR'
set transaction isolation level read uncommitted

/* TIPO DE REFERENCIA */
select @w_tipo_referencia = pa_char
from cobis..cl_parametro
where pa_nemonico = 'PTIRE'
  and pa_producto = 'GAR'  
set transaction isolation level read uncommitted
--pga 17ago2001


/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'S' or @i_operacion = 'A' 
begin
   if @i_filial is NULL or @i_oficina is NULL  
   begin
    /* Campos NOT NULL con valores nulos */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901001
      return 1 
   end
end

if @i_operacion = 'S'
begin
   set rowcount 20
   if @i_modo = 0 
   begin
      select
       "INSPECTOR"          = ci_inspector,
       "NOMBRE"             = is_nombre,           
       "VALOR"              = in_valor_fact,            
       "GARANTIA"           = in_codigo_externo,            
       "FECHA DE PAGO"      = convert(char(10),ci_fecha_pago, 101),
       "PAGADA"             = ci_pago 
      from cu_control_inspector, cu_inspeccion, cu_inspector 
      where in_inspector = ci_inspector
        and is_inspector = ci_inspector
        and ci_lote = in_lote
        and in_pago = @i_pago
        and in_pago = ci_pago  --pag 4jul2001
        and in_registro   = '1'  --jvc nov 2002
        --and is_tipo_inspector = 'A' --emg
        order by ci_inspector, in_codigo_externo
     
      if @@rowcount = 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1901003 
         return 1 
      end
   end
   else 
   begin
      select
       "INSPECTOR"          = ci_inspector,
       "NOMBRE"             = is_nombre,           
       "VALOR"              = in_valor_fact,            
       "GARANTIA"           = in_codigo_externo,            
       "FECHA DE PAGO"      = convert(char(10),ci_fecha_pago,101),
       "PAGADA"             = ci_pago 
      from cu_control_inspector, cu_inspeccion, cu_inspector 
      where in_inspector = ci_inspector
        and is_inspector = ci_inspector
        --and is_tipo_inspector = 'A'
        and ci_lote = in_lote
        and in_pago = @i_pago 
        and in_pago = ci_pago  --pag 4jul2001
        and in_inspector >= @i_inspector
        and in_codigo_externo > @i_codigo_externo
        order by ci_inspector,in_codigo_externo
     if @@rowcount = 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1901003 
         return 1 
      end
   end
end

if @i_operacion = 'A' 
  begin
      Select  @w_inspector        = ci_inspector ,
             @w_fenvio_carta      = ci_fenvio_carta,
             @w_frecep_reporte    = ci_frecep_reporte, 
             @w_valor_facturado   = in_valor_fact, 
             @w_valor_pagado      = ci_valor_pagado, 
             @w_fecha_pago        = ci_fecha_pago,
             @w_fmaxrecep         = ci_fmaxrecep,
             @w_lote              = ci_lote,
             @w_ente_ins          = is_cliente_inspec,
             @w_custodia          = in_custodia,
             @w_codigo_externo    = in_codigo_externo
     from    cu_control_inspector, cu_inspeccion, cu_inspector 
     where   in_inspector         = ci_inspector
       --and   is_tipo_inspector    = 'A'
       and   is_inspector         = ci_inspector
       and   in_valor_fact   = @i_valor_facturado 
       and   ci_lote              = in_lote
       and   in_codigo_externo    = @i_codigo_externo
      -- and   ci_pago              = @i_pago -- indica si estan en Sidac o no 
       and   in_pago                = @i_pago 
       if @@rowcount = 0
        begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 1901003
         return 1
        end         
    
      -- pga 14ago2001


      select @w_cliente = cg_ente
      from   cob_custodia..cu_cliente_garantia
      where cg_codigo_externo = @w_codigo_externo
        and ( cg_tipo_garante = 'J' or cg_tipo_garante = 'C' ) --emg ene-18-03
      if @@rowcount = 0 
        begin
          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101146
         return 1
       end
      -- pga 14ago2001



       select @w_tramite = gp_tramite
       from   cob_credito..cr_gar_propuesta,cob_cartera..ca_operacion
       where  gp_garantia = @w_codigo_externo
       and    gp_tramite = op_tramite
         
       if @@rowcount = 0 
        begin

          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,

          @i_num   = 1901040
         return 1
       end  

      /*Buscar codigo del inspector en clientes*/
      select @w_ente = en_ente
      from   cobis..cl_ente
      where  en_ente = @w_ente_ins
      set transaction isolation level read uncommitted
      select @w_rowcount = @@rowcount
      if @w_rowcount = 0 
        begin

          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,

          @i_num   = 101146
         return 1
       end





       /*Buscar en cartera */
      select @w_banco      = op_banco ,
             @w_moneda     = op_moneda,
             @w_linea      = op_toperacion,
             @w_operacion  = op_operacion             
            from   cob_cartera..ca_operacion
      where  op_tramite = @w_tramite

     
      if @@rowcount = 0 
        begin

          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101146
         return 1
       end



      /* Cambio a otros cargos Banagrario Nov/2002  JVC

     exec cob_sidac.. sp_cuentaxcobrar	
       @s_ssn             = @s_ssn,
       @s_user            = @s_user,
       @s_date            = @s_date,
       @s_term            = @s_term,
       @s_ssn_corr        = @s_ssn_corr,
       @s_srv             = @s_srv,
       @s_ofi             = @s_ofi,
       @t_trn             = 32500,
       @i_operacion       = 'I',
       @i_empresa         = @i_filial,
       @i_fecha_rad       = @s_date,
       @i_modulo          = @w_producto,               --producto garantias    	
       @i_fecha_ven       = @s_date,
       @i_moneda          = 0, 
       @i_valor           = @i_valor_facturado,
       @i_concepto        = @w_concepto,        -- concepto 
       @i_condicion       = @w_condicion,
       @i_tipo_referencia = @w_tipo_referencia, -- tipo de documento catalogo    	
       @i_formato_fecha   = 101,                -- formato de fecha    	
       @i_ente            = @w_cliente,         -- pga 14ago2001
       @i_referencia      = @w_codigo_externo,  --  garantia codigo    	
       @i_area            = @w_area_custodia,               --  de la garantia	
       @i_oficina         = @i_oficina,
       @i_estado          = 'V'


      Cambio a otros cargos Banagrario Nov/2002  JVC  */

      /* Tipo de rubro se actualizara despues del desarrollo de Cartera */
      select @wro_tipo_rubro = ro_tipo_rubro
      from cob_cartera..ca_rubro_op
      where ro_concepto  =  @w_concepto  

      select  @wdi_dividendo = di_dividendo
      from cob_cartera..ca_dividendo 
      where di_operacion =   @w_operacion
      and di_estado =  1




     if @wro_tipo_rubro is null -- Elegir dividendo vencido 
     begin
      
       select  @wdi_dividendo = max(di_dividendo)
       from cob_cartera..ca_dividendo 
       where di_operacion =   @w_operacion
       and di_estado =  3


       if @@rowcount = 0 
         begin
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 701179
          return 1
        end
     end



       exec cob_cartera.. sp_otros_cargos
       @i_banco             = @w_banco,	
       @i_operacion         = 'I',
       @i_formato_fecha    =  103, 
       @i_toperacion        =  @w_linea  , 
       @i_moneda            = @w_moneda,
       @i_concepto          = @w_concepto,
       @i_monto             = @i_valor_facturado,
       @i_comentario        = 'PAGO A AVALUADORES',
       @i_tipo_rubro        = @wro_tipo_rubro ,
       @i_base_calculo      = null,
       @i_div_desde         = @wdi_dividendo ,
       @i_div_hasta         = @wdi_dividendo,
       @i_num_dec_tap1      = null,
       @o_sec_tran          = @w_sec_tran out             


       select @w_referencia_sidac = convert(varchar,@w_operacion) + ':' +  convert(varchar,@w_sec_tran)


 
  /*   exec cob_sidac.. sp_cuentaxpagar	
       @s_ssn               = @s_ssn,
       @s_user              = @s_user,
       @s_date              = @s_date,
       @s_term              = @s_term,
       @s_ssn_corr          = @s_ssn_corr,
       @s_srv               = @s_srv,
       @s_ofi               = @s_ofi,
       @t_trn               = 32550,
       @i_operacion         = 'I',
       @i_empresa           = @i_filial,         -- filial   1
       @i_fecha_rad         = @s_date,           -- fecha proceso  
       @i_modulo            = @w_producto,                -- 19  numero de garantias    	
       @i_fecha_ven         = @s_date,           -- fecha proceso
       @i_moneda            = 0,               
       @i_valor             = @i_valor_facturado,
       @i_concepto          = @w_concepto,         -- concepto 
       @i_condicion         = @w_condicion,        -- 1 es un caracter    
       @i_tipo_referencia   = @w_tipo_referencia,
       @i_formato_fecha     = 101,               --  formato de fecha  
       @i_ente              = @w_ente,           -- codigo del abog / aval    	
       @i_referencia        = @w_referencia_sidac, --  garantia codigo    	
       @i_area              = @w_area_custodia,              --  de la garantia	
       @i_oficina           = @i_oficina,
       @i_estado            = 'V'        */    
       
 
     select @w_facturado = sum(in_valor_fact)
     from   cu_inspeccion
     where  in_inspector = @w_inspector
       and  in_lote = @w_lote
      if @@rowcount = 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1901003 
         return 1 
      end
     

     select @w_pagado = sum(ci_valor_pagado)
     from   cu_control_inspector
     where ci_inspector  = @w_inspector
       and ci_fenvio_carta = @w_fenvio_carta
       and ci_frecep_reporte = @w_frecep_reporte
       and ci_fmaxrecep = @w_fmaxrecep      
       and ci_pago = 'N'
       and ci_lote = @w_lote
      if @@rowcount = 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1901003 
         return 1 
      end   

     update cu_inspeccion set in_pago = 'S',
            in_fecha_pago = @w_today
     where  in_inspector = @w_inspector
     and    in_valor_fact = @i_valor_facturado
     and    in_lote = @w_lote
     if @@error <> 0 
       begin
         -- Error en actualizacion de registro 
          exec cobis..sp_cerror
          @t_from  = @w_sp_name,
          @i_num   = 1905001
          return 1 
     end

     update cu_control_inspector
     set ci_fecha_pago = @w_today,
         ci_valor_pagado = isnull(ci_valor_pagado,0) + @i_valor_facturado
     where ci_inspector  = @w_inspector
       and ci_fenvio_carta = @w_fenvio_carta 
       and ci_frecep_reporte = @w_frecep_reporte 
       and ci_fmaxrecep = @w_fmaxrecep     
       and ci_lote = @w_lote           
       if @@error <> 0 
       begin
         -- Error en actualizacion de registro 
          exec cobis..sp_cerror
          @t_from  = @w_sp_name,
          @i_num   = 1905001
          return 1 
       end

         select @w_facturado = sum(in_valor_fact)
         from   cu_inspeccion
         where  in_inspector = @w_inspector
           and  in_lote = @w_lote
         if @@rowcount = 0
          begin
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1901003 
             return 1 
          end

         select @w_pagado = sum(ci_valor_pagado)   
         from   cu_control_inspector
         where ci_inspector  = @w_inspector
           and ci_fenvio_carta = @w_fenvio_carta
           and ci_frecep_reporte = @w_frecep_reporte
           and ci_fmaxrecep = @w_fmaxrecep      
        --   and ci_pago = 'N'
           and ci_lote = @w_lote
          if @@rowcount = 0
          begin
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1901003 
             return 1 
          end

         if @w_pagado <> @w_facturado
         begin
           update cu_control_inspector
           set ci_pago ='N' 
           where ci_inspector = @w_inspector
           and   ci_lote = @w_lote
           if @@error <> 0 
           begin
             /* Error en actualizacion de registro */
              exec cobis..sp_cerror
              @t_from  = @w_sp_name,
              @i_num   = 1905001
              return 1 
           end
         end

         if @w_pagado = @w_facturado 
         begin
          update cu_control_inspector
          set ci_pago = 'S',ci_fecha_pago = @w_today
          where ci_inspector  = @w_inspector
            and ci_fenvio_carta = @w_fenvio_carta
            and ci_frecep_reporte = @w_frecep_reporte
            and ci_fmaxrecep = @w_fmaxrecep      
	    and ci_lote = @w_lote           
            if @@error <> 0 
            begin
              /* Error en actualizacion de registro */
               exec cobis..sp_cerror
               @t_from  = @w_sp_name,
               @i_num   = 1905001
               return 1 
            end
         end
         insert into ts_control_inspector
         values (@w_secservicio,@t_trn,'P',@s_date,@s_user,
                 @s_term,@s_ofi,'cu_control_inspector', @w_inspector,
                 @w_fenvio_carta, @w_frecep_reporte, @w_valor_facturado,
                 @w_fecha_pago)

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1903003
             return 1 
         end

end

return 0
go
