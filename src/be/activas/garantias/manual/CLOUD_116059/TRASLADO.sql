use cob_conta 
go

declare 
@w_cliente        int,
@w_cotizacion     money ,
@w_asiento        int,
@w_comprobante    int,
@w_max_oficina    int , 
@w_max_area       int,
@w_max_asientos   int,
@w_msg            varchar(255),
@w_fecha_proceso  datetime ,
@w_oficina        int,  
@w_tot_debito     money,  
@w_tot_credito    money,
@w_tot_debito_me  money,
@w_tot_credito_me money,
@w_operacioca     int, 
@w_error          int,
@w_commit         char(1) ,
@w_diferencia     money,
@w_cuenta_act     cuenta,
@w_cuenta_new     cuenta,
@w_cuenta_ges     cuenta,
@w_saldo          money  





--Cuenta de garantías  --'240190'--CUENTA DE LA CONTABILIDAD GESBAN
--crear cuenta hermana 240191  CONTROL OPERATIVO CONTABLE DE GARANTIAS  (NUEVA) 
---select @w_cuenta = '241302'  --CUENTA ACTUAL




   
   
--Cuenta de garantías
select 
@w_cuenta_act   = '241302',
@w_cuenta_new   = '240191',
@w_cuenta_ges   = '240190',
@w_cotizacion = 1,
@w_commit     = 'N'





--- AQUI COLOCAR LA LISTA DE CLIENTES A ALINEAR PREVIO A ANALISIS DE CADA CASO

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select  @w_saldo = sum(sa_saldo)  from cob_conta..cb_saldo where sa_cuenta =  '241302'


select @w_cliente = 0 

select * into #asientos  from  cob_conta_tercero..ct_sasiento_tmp
where 1 = 2 



    


  
truncate table #asientos

/* RESERVAR UN RANGO DE COMPROBANTES */
exec @w_error = cob_conta..sp_cseqcomp
@i_tabla     = 'cb_scomprobante', 
@i_empresa   = 1,
@i_fecha     = @w_fecha_proceso,
@i_modulo    = 7,
@i_modo      = 0, -- Numera por EMPRESA-FECHA-PRODUCTO
@o_siguiente = @w_comprobante out

if @w_error <> 0 begin
select @w_msg = 'ERROR: AL GENERAR NUMERO DE COMPROBANTE'
goto ERROR
end 


insert into #asientos(                                                                                                 
sa_producto,        sa_fecha_tran,        sa_comprobante,
sa_empresa,         sa_asiento,           sa_cuenta,
sa_oficina_dest,    sa_area_dest,         
sa_credito,
sa_debito,          
sa_credito_me,
sa_debito_me,       
sa_concepto,        sa_cotizacion,        sa_tipo_doc,
sa_tipo_tran,       sa_moneda,            sa_opcion,
sa_ente,            sa_con_rete,          sa_base,
sa_valret,          sa_con_iva,           sa_valor_iva,
sa_iva_retenido,    sa_con_ica,           sa_valor_ica,
sa_con_timbre,      sa_valor_timbre,      sa_con_iva_reten,
sa_con_ivapagado,   sa_valor_ivapagado,   sa_documento,
sa_mayorizado,      sa_con_dptales,       sa_valor_dptales,
sa_posicion,        
sa_debcred,           
sa_oper_banco,      sa_cheque,           sa_doc_banco, 
sa_fecha_est,       sa_detalle,          sa_error)
values ( 
7,                  @w_fecha_proceso,     @w_comprobante,
1,                  0,                    @w_cuenta_act ,    
9002,               1010,            
case when @w_saldo      < 0 then abs(@w_saldo) else 0 end,
case when @w_saldo      > 0 then abs(@w_saldo) else 0 end,
0,
0,
'TRASLADO A CUENTA 240190',     @w_cotizacion,        'N',
'A',                 0,             0, 
3         ,         'N',                   0,
0,                  'N',                   0, 
0,                  'N',                   0, 
'N',                0,                    'N',
'N',                0,                    'TRASLADO A CUENTA 240190',
'N',                null,                 null,
'S',                
case when @w_saldo < 0 then '2' else '1' end,        
null,               null,                 null,        
null,               null,                'N'                                 
)

if @@error <> 0 begin 
select @w_msg = 'ERROR: AL INSERTAR LOS ASIENTOS'
goto ERROR
end 

--PASAR LA PLATA A LA CUENTA DE GESBAN 
insert into #asientos(                                                                                                 
sa_producto,        sa_fecha_tran,        sa_comprobante,
sa_empresa,         sa_asiento,           sa_cuenta,
sa_oficina_dest,    sa_area_dest,         
sa_credito,
sa_debito,          
sa_credito_me,
sa_debito_me,       
sa_concepto,        sa_cotizacion,        sa_tipo_doc,
sa_tipo_tran,       sa_moneda,            sa_opcion,
sa_ente,            sa_con_rete,          sa_base,
sa_valret,          sa_con_iva,           sa_valor_iva,
sa_iva_retenido,    sa_con_ica,           sa_valor_ica,
sa_con_timbre,      sa_valor_timbre,      sa_con_iva_reten,
sa_con_ivapagado,   sa_valor_ivapagado,   sa_documento,
sa_mayorizado,      sa_con_dptales,       sa_valor_dptales,
sa_posicion,        
sa_debcred,           
sa_oper_banco,      sa_cheque,           sa_doc_banco, 
sa_fecha_est,       sa_detalle,          sa_error)
values ( 
7,                  @w_fecha_proceso,     @w_comprobante,
1,                  0,                    @w_cuenta_ges,    
9002,               1010,            
case when @w_saldo      > 0 then abs(@w_saldo) else 0 end,
case when @w_saldo      < 0 then abs(@w_saldo) else 0 end,
0,
0,
'TRASLADO DESDE 241302',     @w_cotizacion,        'N',
'A',                 0,             0, 
3,                  'N',                   0,
0,                  'N',                   0, 
0,                  'N',                   0, 
'N',                0,                    'N',
'N',                0,                    'TRASLADO DESDE 241302',
'N',                null,                 null,
'S',                
case when @w_saldo > 0 then '2' else '1' end,        
null,               null,                 null,        
null,               null,                'N'                                 
)




select @w_asiento = 0

update #asientos set 
sa_asiento = @w_asiento, 
@w_asiento = @w_asiento +1


--datos 
select 
@w_max_oficina    = max(sa_oficina_dest),
@w_max_area       = max(sa_area_dest),
@w_max_asientos   = max(sa_asiento),
@w_tot_debito     = sum(sa_debito),
@w_tot_credito    = sum(sa_credito),
@w_tot_debito_me  = sum(sa_debito_me),
@w_tot_credito_me = sum(sa_credito_me)
from #asientos

---	 

if @@trancount = 0 begin 
select @w_commit = 'S'
begin tran 
end    

insert into cob_conta_tercero..ct_scomprobante_tmp with (rowlock) (
sc_producto,       sc_comprobante,   sc_empresa,
sc_fecha_tran,     sc_oficina_orig,  sc_area_orig,
sc_digitador,      sc_descripcion,   sc_fecha_gra,      
sc_perfil,         sc_detalles,      sc_tot_debito,
sc_tot_credito,    sc_tot_debito_me, sc_tot_credito_me,
sc_automatico,     sc_reversado,     sc_estado,
sc_mayorizado,     sc_observaciones, sc_comp_definit,
sc_usuario_modulo, sc_tran_modulo,   sc_error)
values (
7,                 @w_comprobante,   1,
@w_fecha_proceso,  @w_max_oficina,   @w_max_area,
'CONSOLA',         'TRASLADO DE CUENTA ACT A CUENTA GESBAN',   getdate(),     
'CCA_EST',         @w_max_asientos,  @w_tot_debito,
@w_tot_credito,    @w_tot_debito_me, @w_tot_credito_me,
7,                 'N',              'I',
'N',               null,             null,
'sa',              0,   'N')

if @@error <> 0 begin 
select @w_msg = 'ERROR: AL INSERTAR DETALLE DE COMPROBANTES'
goto ERROR
end 



insert into  cob_conta_tercero..ct_sasiento_tmp
select * from #asientos
   
  
   
if @w_commit = 'S' begin 
  select @w_commit = 'N'
  commit tran 
end  
   


ERROR:
print @w_msg 

if @w_commit = 'S' begin 
  select @w_commit = 'N'
  rollback tran 
end  


drop table  #asientos 

go 