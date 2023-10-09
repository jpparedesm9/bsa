use cob_externos
go

if exists (select 1 from sysobjects where name = 'sp_util_03_descuadre_cuenta')
   drop proc sp_util_03_descuadre_cuenta
go

create proc sp_util_03_descuadre_cuenta
as

declare @w_cliente int,
		@w_cotizacion money ,
		@w_asiento int,
		@w_comprobante int,
		@w_max_oficina int ,
		@w_max_area int,
		@w_max_asientos int,
		@w_msg varchar(255),
		@w_fecha_proceso datetime ,
		@w_oficina int,
		@w_tot_debito money,
		@w_tot_credito money,
		@w_tot_debito_me money,
		@w_tot_credito_me money,
		@w_operacioca int,
		@w_error int,
		@w_commit char(1),
		@w_diferencia_boc money,
		@w_boproducto int,
        @w_descripcion varchar(20)
	
select cliente = bo_cliente
into #cliente_dos_registros
from cob_conta..cb_boc
where bo_producto = 7
and   bo_diferencia <> 0
group by bo_cliente

delete #cliente_dos_registros
where exists (select 1 from cob_conta..cb_boc where bo_cliente = cliente and bo_diferencia <> 0 and bo_cuenta like '7%') 

select @w_boproducto=0

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

create table #tpmppproducto  (
	producto    varchar(20) null,
    descripcion varchar(64) null,
	bo_producto int null
)

insert into #tpmppproducto values('garantias', 'ALINEAMIENTO GL' ,  19),('cartera','ALINEAMIENTO CCA', 7)
select * into #asientos from cob_conta_tercero..ct_sasiento_tmp    where 1 = 2
while (1=1) begin
	select top 1 @w_boproducto=bo_producto, @w_descripcion=descripcion from #tpmppproducto where bo_producto>@w_boproducto  order by bo_producto

    if @@rowcount = 0  break

	print '--N1 @w_boproducto: ' +  convert(varchar(10),@w_boproducto)

	--inicializo variables
    select @w_cliente=0, @w_commit = 'N',@w_cotizacion = 1

    -----------------------------------------------------------------------------------------------------------------------------
    ----PROCESO POR PRODUCTO
    while (1=1) begin
        select top 1 @w_cliente = bo_cliente
        from  cob_conta..cb_boc,
        #cliente_dos_registros
        where bo_cliente    = cliente
        and   bo_producto   =  @w_boproducto
        and   bo_cliente    >  @w_cliente
        and   bo_diferencia <> 0
        order by bo_cliente

        if @@rowcount = 0 break


        --verificar suma de las diferencia den cero
        select @w_diferencia_boc = sum(bo_diferencia)
          from cob_conta..cb_boc
         where bo_producto = @w_boproducto  and bo_cliente = @w_cliente

        if @w_diferencia_boc <> 0 goto SIGUIENTE

		print 'N2 @w_boproducto ' + convert(varchar(10), @w_boproducto)  +', @w_cliente ' + convert(varchar(10), @w_cliente)

        truncate table #asientos

        /* RESERVAR UN RANGO DE COMPROBANTES */
        exec @w_error = cob_conta..sp_cseqcomp
			 @i_tabla = 'cb_scomprobante',
			 @i_empresa = 1,
			 @i_fecha = @w_fecha_proceso,
			 @i_modulo = 7,
			 @i_modo = 0, -- Numera por EMPRESA-FECHA-PRODUCTO
			 @o_siguiente = @w_comprobante out

        if @w_error <> 0 begin
           select @w_msg = 'ERROR: AL GENERAR NUMERO DE COMPROBANTE'
           goto ERROR
        end

        insert into #asientos(
					sa_producto, sa_fecha_tran, sa_comprobante,
					sa_empresa, sa_asiento, sa_cuenta,
					sa_oficina_dest, sa_area_dest,
					sa_credito,
					sa_debito,
					sa_credito_me,
					sa_debito_me,
					sa_concepto, sa_cotizacion, sa_tipo_doc,
					sa_tipo_tran, sa_moneda, sa_opcion,
					sa_ente, sa_con_rete, sa_base,
					sa_valret, sa_con_iva, sa_valor_iva,
					sa_iva_retenido, sa_con_ica, sa_valor_ica,
					sa_con_timbre, sa_valor_timbre, sa_con_iva_reten,
					sa_con_ivapagado, sa_valor_ivapagado, sa_documento,
					sa_mayorizado, sa_con_dptales, sa_valor_dptales,
					sa_posicion,
					sa_debcred,
					sa_oper_banco, sa_cheque, sa_doc_banco,
					sa_fecha_est, sa_detalle, sa_error)
        select  7, @w_fecha_proceso, @w_comprobante,
				1, 0, bo_cuenta,
				bo_oficina, 1090,
				case when bo_diferencia < 0 then abs(bo_diferencia) else 0 end,
				case when bo_diferencia > 0 then abs(bo_diferencia) else 0 end,
				0,
				0,
				@w_descripcion, @w_cotizacion, 'N',
				'A', cu_moneda, 0,
				bo_cliente, 'N', 0,
				0, 'N', 0,
				0, 'N', 0,
				'N', 0, 'N',
				'N', 0, @w_descripcion,
				'N', null, null,
				'S',
				case when bo_diferencia < 0 then '2' else '1' end,
				null, null, null,
				null, null, 'N'
        from cob_conta..cb_boc, cob_conta..cb_cuenta
        where bo_cuenta        = cu_cuenta
        and   bo_producto      = @w_boproducto
        and abs(bo_diferencia) >= 0.01
        and bo_cliente         = @w_cliente

        if @@error <> 0 begin
           select @w_msg = 'ERROR: AL INSERTAR LOS ASIENTOS'
           goto ERROR
        end

        select @w_asiento = 0

        update #asientos set
        sa_asiento = @w_asiento,
        @w_asiento = @w_asiento +1

        --datos
        select  @w_max_oficina = max(sa_oficina_dest),
				@w_max_area = max(sa_area_dest),
				@w_max_asientos = max(sa_asiento),
				@w_tot_debito = sum(sa_debito),
				@w_tot_credito = sum(sa_credito),
				@w_tot_debito_me = sum(sa_debito_me),
				@w_tot_credito_me = sum(sa_credito_me)
        from #asientos

        if @@trancount = 0 begin
           select @w_commit = 'S'
           begin tran
        end

        insert into cob_conta_tercero..ct_scomprobante_tmp with (rowlock) (
					sc_producto, sc_comprobante, sc_empresa,
					sc_fecha_tran, sc_oficina_orig, sc_area_orig,
					sc_digitador, sc_descripcion, sc_fecha_gra,
					sc_perfil, sc_detalles, sc_tot_debito,
					sc_tot_credito, sc_tot_debito_me, sc_tot_credito_me,
					sc_automatico, sc_reversado, sc_estado,
					sc_mayorizado, sc_observaciones, sc_comp_definit,
					sc_usuario_modulo, sc_tran_modulo, sc_error)
        values     (7, @w_comprobante, 1,
					@w_fecha_proceso, @w_max_oficina, @w_max_area,
					'CONSOLA', @w_descripcion, getdate(),
					'CCA_EST', @w_max_asientos, @w_tot_debito,
					@w_tot_credito, @w_tot_debito_me, @w_tot_credito_me,
					7, 'N', 'I',
					'N', null, null,
					'sa', 0, 'N')

        if @@error <> 0 begin
           select @w_msg = 'ERROR: AL INSERTAR DETALLE DE COMPROBANTES'
           goto ERROR
        end

        insert into cob_conta_tercero..ct_sasiento_tmp
        select * from #asientos

        if(@w_boproducto=7)
        begin
            select top 1  @w_operacioca= op_operacion,
							@w_oficina =op_oficina
            from cob_cartera..ca_operacion
            where op_cliente = @w_cliente
            and op_estado in ( 1,2,4)

            update cob_cartera..ca_transaccion
			    set tr_ofi_oper = @w_oficina
            where tr_operacion = @w_operacioca
            and tr_ofi_oper <> @w_oficina

            if @@error <> 0 begin
				select @w_msg = 'ERROR: AL ACTUALIZAR LA OFICINA EN LA TRANSACCION'
				goto ERROR
            end
        end

        if @w_commit = 'S' begin
            select @w_commit = 'N'
            commit tran
        end

        goto SIGUIENTE

        ERROR:
             print @w_msg

        if @w_commit = 'S' begin
           select @w_commit = 'N'
           rollback tran
        end

        SIGUIENTE:
    end --end while N2
    -----------------------------------------------------------------------------------------------------------------------------
    --Actualizar las oficinas que estan en 9001 y 9002
    IF(@w_boproducto=7)
    BEGIN
        print 'update DOS'
        SELECT tr_ofi_usu, * FROM cob_cartera..ca_transaccion  WHERE  tr_ofi_usu IN (9002, 9001) AND tr_estado = 'ING'
        UPDATE cob_cartera..ca_transaccion
		   SET tr_ofi_usu = tr_ofi_oper
        WHERE  tr_ofi_usu IN (9002, 9001) AND tr_estado = 'ING'
    END


end

drop table #tpmppproducto
drop table #asientos

return 0

go

