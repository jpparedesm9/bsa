/************************************************************************/
/*  Archivo:                sp_pag_solidario_grp.sp                     */
/*  Stored procedure:       sp_pag_solidario_grp                        */
/*  Base de Datos:          cob_cartera                                 */
/*  Producto:               cob_cartera                                 */
/*  Disenado por:           PXSG                                        */
/*  Fecha de Documentacion: 13/01/2020                                  */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/* Devuelve la fecha para Eliminar las carpetas del FTP de Interfactura */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR                   RAZON                           */
/*06/01/2019    PXSG                  Emision Inicial                   */
/* **********************************************************************/
use cob_cartera
go


if exists(select 1 from sysobjects where name ='sp_pag_solidario_grp')
	drop proc sp_pag_solidario_grp
go

create proc sp_pag_solidario_grp (
@i_contrato           varchar(24),
@i_monto_total        varchar(24) =null,
@i_cliente            int=null,
@i_monto_cliente      varchar(24)=null,
@i_pago_canal         int,        
@t_show_version	    bit             = 0,
@i_operacion          char(1),
@t_debug              char(1)         = 'N',
@t_file               varchar(10)     = null,
@i_delete             char(1)          = 'N'
	
)

AS

Declare
@w_fecha_proceso        datetime,
@w_error                int,
@w_sp_name              varchar(32),
@w_monto_cobis          money,
@w_suma_pagos_cli       float,
@w_cliente_gr           int,
@w_contrato             varchar(24),
@w_pago_canal           int,
@w_cliente_grupo        int,
@w_numero_reve          varchar(14),
@w_monto_ind            varchar(50),
@w_numero_decimales     int,
@w_operacion            int,
@w_codigo_interno       int 


if @t_show_version = 1
begin
    print 'Stored procedure sp_pag_solidario_grp, Version 1.0.0'
    return 0
end
--------------------------------------------------------------------------------------
select  @w_sp_name = 'sp_pag_solidario_grp'

/*  Inicializacion de Variables  */
select @w_fecha_proceso=fp_fecha 
from   cobis..ba_fecha_proceso

IF(@i_operacion='I')
begin
if @i_delete='S'
begin
delete from cob_cartera..ca_pago_sol_grp_tmp
 where id_contrato=@i_contrato
 and @i_pago_canal=@i_pago_canal
end
 insert into cob_cartera..ca_pago_sol_grp_tmp
                (id_contrato,          id_cliente , pago_cliente   ,  monto_total,
                
                 canal_pago
                )
     values
                (@i_contrato,       @i_cliente   ,  @i_monto_cliente     , @i_monto_total,
                
                 @i_pago_canal 
                )
                
      if @@error != 0
        begin
            select @w_error = 70213 -- Error al insertar
            goto ERROR 
        end  

end

IF(@i_operacion='V')
begin

--1
--Que la operacion sea Grupal
if not exists (select 1 from cob_credito..cr_tramite_grupal
where tg_referencia_grupal=@i_contrato )
begin
    select @w_error = 720313 -- 'EL CONTRATO NO CORRESPONDE A UN CREDITO AGRUPADOR '
    goto ERROR
end

--2
select @w_suma_pagos_cli=isnull(sum (convert(float,pago_cliente)),0) from cob_cartera..ca_pago_sol_grp_tmp
where id_contrato = @i_contrato
and   canal_pago  = @i_pago_canal

if(convert(float,@i_monto_total)<>@w_suma_pagos_cli)
begin
    select @w_error = 720314 --'EL MONTO TOTAL NO ES IGUAL A LA SUMA DE LOS MONTOS INDIVIDUALES '
    goto ERROR

end

--3
if not exists(select 1 from cob_cartera..ca_corresponsal_trn
              where convert(int,co_trn_id_corresp)=@i_pago_canal
              and co_tipo='PG'
              and co_estado='P')
begin
    select @w_error = 720315 --'EL ID DE CANAL DEL PAGO NO EXISTE EN COBIS '
    goto ERROR
end

select @w_operacion = op_operacion 
from   cob_cartera..ca_operacion
where  op_banco     = @i_contrato


select @w_codigo_interno = co_codigo_interno 
from cob_cartera..ca_corresponsal_trn
where convert(int,co_trn_id_corresp)=@i_pago_canal
and co_tipo='PG'
and co_estado='P'
if(@w_operacion<>@w_codigo_interno)
begin
    select @w_error = 720320 --EL ID DE CANAL DEL PAGO NO CORRESPONDE AL CREDITO AGRUPADOR 
    goto ERROR
end

--4
select @w_monto_cobis=isnull(co_monto,0) from cob_cartera..ca_corresponsal_trn
where convert(int,co_trn_id_corresp)=@i_pago_canal
      and co_tipo='PG'
      and co_estado='P'

if(@w_monto_cobis<>convert(money,@i_monto_total))
begin

    select @w_error = 720316 --'EL MONTO INGRESADO NO CORRESPONDE AL MONTO REGISTRADO EN COBIS '
    goto ERROR
end
--5
if exists( select 1 from cob_credito..cr_tramite_grupal
where tg_referencia_grupal=@i_contrato
and tg_participa_ciclo='S'
and tg_cliente not in (SELECT id_cliente
                       FROM cob_cartera..ca_pago_sol_grp_tmp
                       where id_contrato = @i_contrato
                       and   canal_pago  = @i_pago_canal))
begin

    select @w_error = 720317 --'ALGUNO DE LOS CLIENTES NO PERTENECE A LOS CLIENTES DEL GRUPO '
    goto ERROR
end                       

if exists(select 1 FROM cob_cartera..ca_pago_sol_grp_tmp
where id_contrato = @i_contrato
and   canal_pago  = @i_pago_canal
and   id_cliente not in (select tg_cliente 
                         from cob_credito..cr_tramite_grupal
                         where tg_referencia_grupal=@i_contrato
                         and tg_participa_ciclo='S'))
begin

    select @w_error = 720317 --'ALGUNO DE LOS CLIENTES NO PERTENECE A LOS CLIENTES DEL GRUPO '
    goto ERROR
end                      

--6
if exists( select 1 from cob_cartera..ca_pago_sol_grp_tmp
			           where id_contrato  = @i_contrato 
			           and   canal_pago   = @i_pago_canal
			           and   convert(float,pago_cliente) <= 0)
begin
    select @w_error = 720318 --'LOS MONTOS DE LOS CLIENTES DEBE SER MAYOR A CERO '
    goto ERROR
end

--Numero de Decimales

SELECT @w_cliente_gr= 0

SELECT top 1 @w_cliente_gr=id_cliente
FROM cob_cartera..ca_pago_sol_grp_tmp
where id_contrato = @i_contrato
and   canal_pago  = @i_pago_canal
and   id_cliente>@w_cliente_gr
order by id_cliente ASC
WHILE @@rowcount > 0
  begin
    SELECT top 1  @w_monto_ind=pago_cliente
    FROM cob_cartera..ca_pago_sol_grp_tmp
    where id_contrato = @i_contrato
    and   canal_pago  = @i_pago_canal
    and   id_cliente  = @w_cliente_gr
     
     SET @w_numero_reve=reverse(@w_monto_ind) 
     
    SET @w_numero_decimales=CHARINDEX('.',@w_numero_reve)-1
    
    IF(@w_numero_decimales>2)
    BEGIN
         select @w_error = 720319 --'EL NUMERO DE DECIMALES DE LOS MONTOS INDIVIDUALES DEBE SER HASTA 2 '
         goto ERROR
    END
    
    SELECT top 1 @w_cliente_gr=id_cliente 
    FROM cob_cartera..ca_pago_sol_grp_tmp
    where id_contrato = @i_contrato
    and   canal_pago  = @i_pago_canal
    and   id_cliente  > @w_cliente_gr
    order by id_cliente ASC
  
  end


end

IF(@i_operacion='P')
begin
--inserto cabecera

if not exists (select 1 from cob_cartera..ca_pag_grp_sol
              where pg_grp_contrato=@i_contrato
              and pg_grp_id_pg_canal=@i_pago_canal)
begin              
	insert into cob_cartera..ca_pag_grp_sol(
	pg_grp_contrato,	   pg_grp_monto_total,	            pg_grp_id_pg_canal,
	pg_fecha_proc_pago,	pg_fecha_real_pago )
	values(
	@i_contrato,			convert(money,@i_monto_total),	@i_pago_canal,
	@w_fecha_proceso,   getdate() )
	
	if @@error != 0
		begin
		    select @w_error = 208902 -- Error al guardar la cabecera del pago 
	    goto ERROR
	end
end
                                        
--inserto detalle

	SELECT @w_cliente_gr= 0
	
	SELECT top 1 @w_cliente_gr=id_cliente
	FROM cob_cartera..ca_pago_sol_grp_tmp
	where id_contrato = @i_contrato
	and   canal_pago  = @i_pago_canal
	and   id_cliente>@w_cliente_gr
	order by id_cliente ASC
	WHILE @@rowcount > 0
	begin
	
	if not exists (select 1 from cob_cartera..ca_pag_grp_sol_det
	               where pgs_contrato_det= @i_contrato
	               and pgs_cliente_det   = @w_cliente_gr
	               and pgs_grp_id_pg_canal=@i_pago_canal)
	begin
	               
		insert into  cob_cartera..ca_pag_grp_sol_det(
		pgs_contrato_det,		pgs_cliente_det, 		pgs_cliente_monto,
		pgs_grp_id_pg_canal )
		select 
		id_contrato,			id_cliente,				convert(money,pago_cliente),
		canal_pago
		from ca_pago_sol_grp_tmp 
		where id_contrato = @i_contrato
		and   canal_pago  = @i_pago_canal
		and   id_cliente  = @w_cliente_gr
		
		if @@error != 0
		begin
		    select @w_error = 208902 -- Error al guardar el detalle de pagos del cliente
		    goto ERROR
   	end

   end
    
    SELECT top 1 @w_cliente_gr=id_cliente 
    FROM cob_cartera..ca_pago_sol_grp_tmp
    where id_contrato = @i_contrato
    and   canal_pago  = @i_pago_canal
    and   id_cliente  > @w_cliente_gr
    order by id_cliente ASC
  
	end
														                                    
end

return 0

ERROR:
    begin --Devolver mensaje de Error
       -- select @w_error
        exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = @w_error
             

        return @w_error
    end
return @w_error
go
