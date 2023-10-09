use cob_conta_super
go

declare 
@w_cuenta               varchar(14),
@w_desc_cuenta          varchar(80),
@w_tipo_cuenta_altair   varchar(2),
@w_tipo_divisa_altair   int,
@w_cls_sdo_altair       char(1),
@w_cod_estado_altair    varchar(2),
@w_cuenta_altair        varchar(25),
@w_desc_cta_altair      varchar(255),
@w_count                int,
@w_id                   int  

select @w_cuenta            = '180140'                      ,
       @w_desc_cuenta       = 'RESERVA DE IMPUESTO DIFERIDO',
       @w_desc_cta_altair   = @w_desc_cuenta,
       @w_cod_estado_altair = '01',
       @w_tipo_cuenta_altair= 'A',
       @w_tipo_divisa_altair= NULL,
       @w_cls_sdo_altair    = 'K',
       @w_tipo_divisa_altair= 1

if exists  (select 1 from sb_equivalencia_cuentas where sb_cuenta_cobis = @w_cuenta) begin								 
      update sb_equivalencia_cuentas set 
	  sb_cod_estado_altair  = @w_cod_estado_altair,
	  sb_tipo_cuenta_altair = @w_tipo_cuenta_altair,
	  sb_tipo_divisa_altair = @w_tipo_divisa_altair,
	  sb_cls_sdo_altair     = @w_cls_sdo_altair
	  where sb_cuenta_cobis = @w_cuenta
   end
   else begin
      insert into sb_equivalencia_cuentas
	  values (
	  @w_cuenta,
	  @w_desc_cuenta,
	  @w_tipo_cuenta_altair,
	  @w_tipo_divisa_altair,
	  @w_cls_sdo_altair,
	  @w_cod_estado_altair,
	  @w_cuenta_altair,
	  convert(varchar(80),@w_desc_cta_altair))	  
   end 

select * 
from sb_equivalencia_cuentas 
where sb_cuenta_cobis = @w_cuenta