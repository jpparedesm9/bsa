/************************************************************************/
/*	Archivo: 	        cambval.sp                              */ 
/*	Stored procedure:       sp_cambio_valor                         */ 
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           					*/
/*	Fecha de escritura:     Abril-1997  				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa permite realizar cambios de valor de una garantia */
/*      es llamado a travez de Front End. Controla que la garantia no   */
/*      encuentre agotada para realizar el cambio de valor.             */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Mayo-1998       Laura Alvarado	Emision Inicial         	*/	
/*	Dic-07-1998     Nydia Velasco   Campo Nuevo'Autoriza'     	*/
/*      Dic/2002        JVelandia       Permite gravar con agotamiento  */	
/************************************************************************/

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_cambio_valor')
    drop proc sp_cambio_valor
go
create proc sp_cambio_valor (
   @s_ssn                int      = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_ofi                smallint  = null,
   @t_trn                smallint = null,
   @i_operacion          char(1)  = null,
   @i_filial             tinyint = null,
   @i_sucursal           smallint = null,
   @i_tipo_cust          varchar(64) = null,
   @i_custodia           int = null,
   @i_fecha_tran         datetime,
   @i_debcred            char(1) = null,
   @i_valor              float = 0,  	--NVR money por float "acciones"
   @i_num_acciones       float = 0,		--NVR int por float "ACCIONES"
   @i_valor_accion       money = 0,
   @i_valor_cobertura    float = 0,	--NVR money por float
   @i_descripcion        varchar(64) = null,
   @i_autoriza           varchar(25) = null,   --NVR1
   @i_nuevo_comercial    money = 0,
   @i_tipo_superior	     varchar(64) = null,
   @i_codigo_externo     varchar(64) = null,
   @i_afecta_prod        char(1) = 'N'

)
as
   declare
   @w_return int,
   @w_today              datetime,
   @w_sp_name            varchar(32),  /* nombre stored proc          */
   @w_secuencial  int,  --PGA 8mar2001
   @w_estado      char(1),  --PGA 11jul2001
   @w_agotada     char(1), --PGA 11jul2001
   @w_valor_actual money --emg

select @w_sp_name = 'sp_cambio_valor'
select @w_today = convert(varchar(10),@s_date,101)


if @i_operacion = 'I'
begin
   -- pga 11jul2001
   select
   @w_estado  = cu_estado,
   @w_agotada = cu_agotada,
   @w_valor_actual = cu_valor_inicial --emg
   from cu_custodia
   where cu_filial   = @i_filial
   and cu_sucursal = @i_sucursal 
   and cu_tipo     = @i_tipo_cust
   and cu_custodia = @i_custodia
   /* no puede hacer cambio de valor a garantias en estado V */
   /*  if (@w_estado = 'V' and @w_agotada = 'S')
   begin         
      select @w_return  = 1901039
      goto ERROR
   end  */
   -- pga 11jul2001


   
   /* si la garntia esta en 'V' y agotada se envia mensaje pero se deja gravar 
   if (@w_estado = 'V' and @w_agotada = 'S') and (@i_nuevo_comercial < @w_valor_actual  )
   begin         
      select @w_return  = 1911001
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = @w_return
   end  */



   begin tran
      exec @w_return = sp_modvalor
      @s_date = @s_date,    
      @i_operacion = @i_operacion,
      @i_filial =@i_filial ,
      @i_sucursal =@i_sucursal ,
      @i_tipo_cust =@i_tipo_cust ,
      @i_custodia = @i_custodia ,
      @i_fecha_tran = @i_fecha_tran,
      @i_debcred = @i_debcred ,
      @i_valor = @i_valor ,
      @i_num_acciones = @i_num_acciones ,
      @i_valor_accion = @i_valor_accion ,
      @i_valor_cobertura = @i_valor_cobertura ,
      @i_descripcion = @i_descripcion,
      @i_usuario = @s_user,
      @i_terminal = @s_term,
      @i_autoriza = @i_autoriza,
      @i_nuevo_comercial = @i_nuevo_comercial,
      @i_tipo_superior = @i_tipo_superior,
	  @i_codigo_externo = @i_codigo_externo,
	  @i_afecta_prod = @i_afecta_prod

   commit tran 
   if @w_return <> 0 
      goto ERROR

   
end
return 0
ERROR:
   exec cobis..sp_cerror
   @t_from  = @w_sp_name,
   @i_num   = @w_return
   return 1
go