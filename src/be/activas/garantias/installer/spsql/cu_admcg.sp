/************************************************************************/
/*      Archivo:                cu_admcg.sp                             */
/*      Stored procedure:       sp_adm_contragarantia                   */
/*      Base de datos:          cob_custodia                            */
/*      Producto:               Garantias                               */
/*      Disenado por:           Iván Jiménez                            */
/*      Fecha de escritura:     19/Sep/2006                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes  exclusivos  para el  Ecuador  de la   */
/*      "NCR CORPORATION".                                              */
/*      Su  uso no autorizado  queda expresamente  prohibido asi como   */
/*      cualquier   alteracion  o  agregado  hecho por  alguno de sus   */
/*      usuarios   sin el debido  consentimiento  por  escrito  de la   */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/* Crea las contragarantias de tarjetas de crédito y cuentas corrientes */
/* en Batch y en línea. Adicionalmente permite cancelar la garantía     */
/* cuando la cuenta corriente sea cancelada.                            */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*         FECHA              AUTOR                  RAZON              */
/*      19/Sep/2006        Iván Jiménez          Emision Inicial        */
/************************************************************************/
use cob_custodia 
go

if exists (select 1 from sysobjects where name = 'sp_adm_contragarantia')
   drop proc sp_adm_contragarantia
go


create proc sp_adm_contragarantia(
   @s_ssn                  int          = null,
   @s_date                 datetime     = null,
   @s_user                 login        = null,
   @s_term                 varchar(64)  = null,
   @s_corr                 char(1)      = null,
   @s_ssn_corr             int          = null,
   @s_ofi                  smallint     = null,
   @s_srv                  varchar(30)  = null,
   @s_lsrv                 varchar(30)  = null,
   @t_rty                  char(1)      = null,
   @t_from                 varchar(30)  = null,
   @t_trn                  smallint     = null,
   @i_operacion            char(1),
   @i_origen               char(3)      = null,
   @i_cuenta               descripcion  = null,
   @i_carta_instruccion    descripcion  = null,
   @i_instruccion          descripcion  = null,
   @i_filial               tinyint      = null,
   @i_sucursal             smallint     = null,
   @i_custodia             int          = null,
   @i_garante              int          = null,
   @i_tipo                 descripcion  = null,
   @i_oficial              int          = null,
   @i_nomcliente           varchar(64)  = null,
   @i_fecha                datetime     = null
   
)
as
declare
   @w_sp_name        varchar(60),
   @w_error          int,
   @w_error_des      varchar(100),
   @w_item1          tinyint,  
   @w_item2          tinyint,  
   @w_item3          tinyint,  
   @w_valor1         descripcion,
   @w_valor2         descripcion, 
   @w_valor3         descripcion, 
   @w_codigo_ext     varchar(64),
   @w_maximo         smallint,
   @w_tipo_cust      varchar(30),
   @w_cuenta         varchar(24)

select  @w_sp_name = 'sp_adm_contragarantia'


if @i_operacion = 'I'
begin
   if @i_origen in ('CTE','TCR')
   begin

      if @i_origen = 'CTE'
         select @w_item1  = 1,                     --CARTA DE INSTRUCCIONES  S/N
                @w_valor1 = @i_carta_instruccion,
                @w_item2  = 2,                     --NUMERO DE CUENTA CORRIENTE
                @w_valor2 = @i_cuenta,
                @w_item3  = 3,                     --NUMERO DE DOCUMENTO
                @w_valor3 = @i_instruccion
      else
         select @w_item1  = 1,                     --CARTA DE INSTRUCCIONES  S/N
                @w_valor1 = @i_carta_instruccion,
                @w_item2  = 2,                     --NUMERO DE DOCUMENTO
                @w_valor2 = @i_instruccion,
                @w_item3  = 3,                     --NUMERO DE TARJETA
                @w_valor3 = @i_cuenta

      exec sp_cliente_garantia 
         @t_trn          = 19040,
         @i_operacion    = 'I',
         @i_filial       = @i_filial,
         @i_sucursal     = @i_sucursal, 
         @i_tipo_cust    = @i_tipo,
         @i_custodia     = @i_custodia,
         @i_ente   = @i_garante,
         @i_principal    = 'D',
         @i_oficial      = @i_oficial  ,
         @i_tipo_garante = 'J',
         @i_nomcliente   = @i_nomcliente 

      select @w_codigo_ext = cu_codigo_externo
      from   cob_custodia..cu_custodia
      where  cu_custodia   = @i_custodia
      and    cu_sucursal   = @i_sucursal
      and    cu_tipo       = @i_tipo

      if @@rowcount = 0
      begin
         exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1901036
            return 1 
      end 

      select @w_maximo    = max(ic_secuencial) + 1
      from   cu_item_custodia
      where  ic_codigo_externo = @w_codigo_ext
           
      select @w_maximo = isnull(@w_maximo,1)
        
      insert into cu_item_custodia values(
      @i_filial,  @i_sucursal,   @i_tipo, @i_custodia,
      @w_item2,      @w_valor2,  @w_maximo,  @w_codigo_ext)

      if @@error <> 0 
      begin
         exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1912111
            return 1912111
      end 

      insert into cu_item_custodia values(
      @i_filial,  @i_sucursal,      @i_tipo, @i_custodia,
      @w_item1,      @w_valor1,  @w_maximo,  @w_codigo_ext)
      
      if @@error <> 0 
      begin
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1912111
            return 1912111
      end 

      insert into cu_item_custodia values (
      @i_filial,  @i_sucursal,      @i_tipo, @i_custodia,
      @w_item3,      @w_valor3,     @w_maximo,  @w_codigo_ext)
      
      if @@error <> 0 
      begin
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1912111
            return 1912111
      end 
           
      update cu_custodia 
      set    cu_fecha_modif        = @s_date,
             cu_fecha_modificacion = @s_date,
             cu_estado              = 'V'
      where  cu_codigo_externo     = @w_codigo_ext 

      if @@error !=0
         select @w_error = 1905001

   end  --@i_origen in ('CTE','TCR')
end  --@i_operacion = 'I'


if @i_operacion = 'D'  --CANCELACION DE LAS GARANTIAS
begin
   if @i_origen = 'CTE'
   begin

      select @w_tipo_cust = pa_char
      from cobis..cl_parametro
      where pa_producto = 'GAR'
      and pa_nemonico = 'COGCTE'

      select @w_item2 = 2
   end
   else
   begin
      select @w_tipo_cust = pa_char
      from cobis..cl_parametro
      where pa_producto = 'GAR'
      and pa_nemonico = 'COGTCR'

      select @w_item2 = 3

   end

   select @w_codigo_ext = ic_codigo_externo 
   from cob_custodia..cu_item_custodia
   where ic_tipo_cust = @w_tipo_cust
   and ic_item = @w_item2
   and ic_valor_item = @i_cuenta


   update cob_custodia..cu_custodia
   set cu_estado      = 'C',
       cu_descripcion = 'CANCELACION DE LA CONTRAGARANTIA',
       cu_fecha_modif = @s_date,
       cu_acum_ajuste = 0, 
       cu_fecha_modificacion = @s_date,
       cu_usuario_modifica = @s_user
   where cu_codigo_externo = @w_codigo_ext

end --@i_operacion = 'D'
/*
if @i_operacion = 'E'  --CANCELACION MASIVA TARJETA DE CREDITO
begin
   declare cur_cta_tar cursor for
   select dp_numero_operacion_banco 
   from  cobis..cl_det_producto_no_cobis
   where dp_tipo_reg                = 'D'
   and   dp_codigo_producto         = 58
   and   dp_numero_operacion_banco  > ''
   and   dp_tipo_bloqueo            = 'C'
   for read only
    
   open cur_cta_tar
   fetch cur_cta_tar into @w_cuenta
    
   while @@fetch_status = 0
   begin
      if @@fetch_status != -1
      begin
         
         exec @w_error = cob_custodia..sp_adm_contragarantia
              @i_operacion = 'D',
              @i_origen    = 'TCR',
              @i_cuenta    = @w_cuenta,
              @s_user      = 'garbatch',
              @s_date      = @i_fecha

         if @w_error <> 0 
         begin
            select @w_error_des = mensaje from cobis..cl_errores where numero = @w_error
            
            if @w_error_des = ''
               select  @w_error_des = 'ERROR EN CANCELACION MASIVA DE TARJETAS'
               
            Insert into cu_ecarcontrag	
            	(ec_fecha,   ec_cuenta,   ec_producto, ec_error, ec_tipo)
            Values
            	(@i_fecha, @w_cuenta, 58,@w_error_des,'C') 
         end
         
         goto SIGUIENTE

         SIGUIENTE:
         fetch cur_cta_tar into @w_cuenta
      end --@@fetch_status != -1
  end --@@fetch_status = 0

  close cur_cta_tar
  deallocate cur_cta_tar
end --@i_operacion = 'E'
*/
return 0
go