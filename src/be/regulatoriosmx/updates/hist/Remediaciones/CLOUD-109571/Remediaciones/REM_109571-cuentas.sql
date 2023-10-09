use cob_conta_super
go


declare @w_cuentas table (
id             int identity,
cuenta         varchar(14),
nombre         varchar(80),
descripcion    varchar(255),
estado         varchar(1),
fecha_estado   datetime,
nivel_cuenta   tinyint)

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

insert into @w_cuentas
select 
cuenta       = cu_cuenta,
nombre       = cu_nombre,
descripcion  = cu_descripcion,
estado       = cu_estado,
fecha_estado = max(cu_fecha_estado),
nivel_cuenta = cu_nivel_cuenta
from cob_conta..cb_cuenta
where cu_empresa = 1
and   cu_movimiento = 'S'
group by cu_cuenta,cu_nombre,cu_descripcion,cu_estado,cu_nivel_cuenta

--select * from  @w_cuentas

select @w_id = 0
while 1 = 1 begin
print @w_id 

   select top 1
   @w_id                 = id,
   @w_cuenta             = ltrim(rtrim(cuenta)),
   @w_desc_cuenta        = nombre,
   @w_tipo_cuenta_altair = case substring(ltrim(rtrim(cuenta)), 1, 1)
                              when '1' then 'A'
                              when '2' then 'P'
							  when '4' then 'P'
                              when '5' then 'RG'
                              when '6' then 'RP'
                              when '7' then 'O'
                              when '8' then 'O'
                              else 'T'
                           end,
   @w_tipo_divisa_altair = 1,
   @w_cod_estado_altair  = '01',
   @w_cuenta_altair      = null,
   @w_desc_cta_altair    = descripcion
   from @w_cuentas
   where id > @w_id
   order by id asc
   
   
   if @@rowcount = 0 break
   
   select @w_cls_sdo_altair = case 
	                             when @w_tipo_cuenta_altair in ( 'A','P','O') then 'K'
								 when @w_tipo_cuenta_altair in ('RP','RG') then 'I'
							  end
   
   if exists (select 1 from sb_equivalencia_cuentas where sb_cuenta_cobis = @w_cuenta) begin								 
      update sb_equivalencia_cuentas set 
	  sb_cod_estado_altair  = @w_cod_estado_altair,
	  sb_tipo_cuenta_altair = @w_tipo_cuenta_altair,
	  sb_tipo_divisa_altair = @w_tipo_divisa_altair,
	  sb_cls_sdo_altair     = @w_cls_sdo_altair
	  from @w_cuentas
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


end