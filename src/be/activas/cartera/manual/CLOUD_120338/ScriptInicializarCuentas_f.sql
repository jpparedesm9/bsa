use cob_cartera
go


declare @w_fecha_proceso datetime,
        @w_cta_gar_liq   cuenta  ,
        @w_cuenta        varchar(100),
        @w_fecha_fm      datetime,
        @w_corte         int ,
        @w_periodo       int ,
        @i_fecha         datetime,
        @w_cliente        int,
        @w_cotizacion     money ,
        @w_asiento        int,
        @w_comprobante    int,
        @w_max_oficina    int , 
        @w_max_area       int,
        @w_max_asientos   int,
        @w_msg            varchar(255),
        @w_oficina        int,  
        @w_tot_debito     money,  
        @w_tot_credito    money,
        @w_tot_debito_me  money,
        @w_tot_credito_me money,
        @w_operacioca     int, 
        @w_error          int,
        @w_commit         char(1) ,
        @w_diferencia     money,
        @w_cuenta_new     cuenta,
        @w_cuenta_ges     cuenta,
        @w_contrapartida  money


select @w_cta_gar_liq = pa_char
from   cobis..cl_parametro with (nolock)
where  pa_producto = 'CCA'
and    pa_nemonico = 'CTGARL'

select @w_fecha_proceso = '06/25/2019',
       @i_fecha         = '06/25/2019'


select @w_cuenta =  @w_cta_gar_liq  


while exists( select 1 from cobis..cl_dias_feriados where df_ciudad = 999 and df_fecha = @w_fecha_proceso) 
select @w_fecha_proceso =dateadd(dd,-1,@w_fecha_proceso)

select @w_fecha_fm = dateadd(dd,1-datepart(dd,@w_fecha_proceso),@w_fecha_proceso)
select @w_fecha_fm = dateadd(mm,1,@w_fecha_fm)
select @w_fecha_fm = dateadd(dd,-1,@w_fecha_fm)

select @w_corte = co_corte,
@w_periodo = co_periodo
from cob_conta..cb_corte
where co_fecha_ini = @w_fecha_fm

select 
'cliente'         = st_ente ,
'oficina'         = st_oficina,
'saldo_contable'  = st_saldo * (-1),
'saldo_operativo' = convert(money,0),
'marca' = 'C'
into #saldos_cuentas_garantias 
from cob_conta_tercero..ct_saldo_tercero
where st_cuenta   = @w_cuenta
and   st_periodo  = @w_periodo
and   st_corte    = @w_corte

insert into #saldos_cuentas_garantias 
select 
'cliente'        = dc_cliente, 
'oficina'        = convert(int, 0),
'saldo_contable' = convert(money,0),
'saldo_operativo'= sum(isnull(dc_gl_pag_valor,0)),
'marca' = 'O'
from cob_conta_super..sb_dato_custodia
where dc_fecha                     = @i_fecha
and   dc_gl_pag_estado             = 'CB'
and   isnull(dc_gl_dev_estado,'X') <> 'D'
group by dc_cliente



select 
mcliente      = op_cliente ,
max_operacion = max(op_operacion) 
into #max_operaciones 
from cob_cartera..ca_operacion a,
     cob_credito..cr_tramite_grupal
where op_cliente in ( select cliente from #saldos_cuentas_garantias )
and   op_operacion         = tg_operacion
and   tg_referencia_grupal <> tg_prestamo
and   tg_monto             > 0
group by op_cliente


update #saldos_cuentas_garantias set 
oficina = op_oficina 
from cob_cartera..ca_operacion , #max_operaciones 
where cliente = mcliente 
and op_operacion = max_operacion 
and marca = 'O'


select *
into #cb_boc
from cob_conta..cb_boc 
where 1 = 19


insert into #cb_boc( 
bo_fecha       , 
bo_cuenta      ,
bo_oficina     ,
bo_cliente     ,
bo_val_opera   ,
bo_val_conta   ,
bo_diferencia  ,
bo_producto )   
select 
'fecha'           = @w_fecha_proceso,
'cuenta'          = @w_cuenta,
'oficina'         = oficina,
'cliente'         = cliente,
'saldo_operativo' = sum(saldo_operativo),
'saldo_contable'  = sum(saldo_contable),
'diferencia'      = sum(saldo_contable) - sum(saldo_operativo),
'producto'        = 19
from #saldos_cuentas_garantias
where   cliente in (695   , 1734  , 2106  , 5153  , 5159  , 5163  , 5170  , 5183  , 5187  , 5856  , 5864  , 6313  , 6319  , 6320  , 6322  , 6324  , 7136  , 7141  , 7157  , 
 7385  , 10317 , 10749 , 13794 , 14841 , 16331 , 16771 , 16773 , 16777 , 16827 , 17005 , 17992 , 18204 , 18214 , 18386 , 18486 , 18788 , 19053 , 19126 , 
 19137 , 19176 , 19214 , 19220 , 19395 , 19670 , 20936 , 21220 , 21310 , 21857 , 22579 , 22916 , 22943 , 22947 , 23259 , 23765 , 24573 , 24580 , 24589 , 
 24602 , 24653 , 24710 , 26156 , 26162 , 26170 , 26183 , 26194 , 26421 , 26638 , 26843 , 27263 , 28071 , 28118 , 31659 , 32143 , 32344 , 34179 , 34187 , 
 34196 , 34437 , 34543 , 34546 , 38230 , 39391 , 42428 , 43456 , 43511 , 45592 , 46467 , 46482 , 46488 , 46499 , 47136 , 47264 , 48160 , 48225 , 48312 , 
 48313 , 48315 , 48361 , 48444 , 49132 , 49707 , 49736 , 50121 , 50320 , 50409 , 50997 , 51071 , 51375 , 51518 , 51528 , 52718 , 52744 , 52800 , 52802 , 
 53110 , 53601 , 53608 , 53634 , 53645 , 54833 , 54927 , 55056 , 55067 , 55082 , 55089 , 55181 , 55230 , 55234 , 55429 , 55445 , 55472 , 55543 , 55637 , 
 55848 , 55961 , 55994 , 56021 , 56267 , 56294 , 56340 , 56351 , 56727 , 56747 , 56898 , 56992 , 57363 , 62257 , 64310 , 64990 , 65070 , 65675 , 67893 , 
 69491 , 69624 , 70538 , 72440 , 72450 , 72532 , 72937 , 73486 , 74565 , 74613 , 78397 , 78403 , 81691 , 81751 , 82807 , 84159 , 84532 , 84790 , 84932 , 
 85457 , 85742 , 85832 , 86199 , 86276 , 86319 , 86714 , 86721 , 86853 , 87055 , 87098 , 87291 , 87295 , 87298 , 87299 , 87305 , 87307 , 87488 , 87498 , 
 87511 , 87520 , 87527 , 87531 , 87542 , 87633 , 87762 , 87765 , 87769 , 87784 , 87786 , 87860 , 87867 , 88931 , 88935 , 88939 , 88942 , 88944 , 88945 , 
 88949 , 88951 , 88953 , 88954 , 88958 , 89001 , 89005 , 89045 , 89316 , 89329 , 89343 , 89344 , 89349 , 89357 , 89429 , 89451 , 89457 , 89464 , 89472 , 
 89477 , 89691 , 89712 , 89728 , 89731 , 89804 , 89891 , 89901 , 89928 , 90035 , 90047 , 90061 , 90076 , 90608 , 90610 , 90613 , 90707 , 90873 , 91165 , 
 91358 , 91359 , 91438 , 91482 , 91616 , 91624 , 91626 , 91634 , 91639 , 91644 , 91708 , 91721 , 91723 , 91879 , 91883 , 91895 , 92094 , 92107 , 92110 , 
 92128 , 92135 , 92139 , 92153 , 92181 , 92564 , 92751 , 92754 , 92830 , 92854 , 92926 , 92953 , 93151 , 93187 , 93267 , 93747 , 93773 , 93926 , 93957 ,
 93958 , 93972 , 94108 , 94227 , 94229 , 94232 , 94247 , 94325 , 94406 , 94411 , 94437 , 94543 , 94546 , 94547 , 94554 , 94556 , 94617 , 94640 , 94787 , 94852 , 94859 ,
 94963 , 94986 , 95007 , 95081 , 96343 , 96850 , 96852 , 114543, 114556, 115601, 116992, 117027, 124200, 126640, 127544, 130399, 131524, 131528, 131534, 131695, 132094, 132198,
 132206, 132216, 132221, 132249, 132303, 132304, 132421, 132447, 132461, 132532, 132539, 132554, 132565, 132570, 132581, 133039, 133056, 134270, 134291, 134374, 134581, 134608,
 134614, 134620, 134679, 134889, 134891, 134937, 135052, 135194, 135211, 135300, 135301, 135336, 135373, 135383, 135710, 135727, 135841, 135916, 135944, 135945, 135950, 135966,
 135973, 135979, 135992, 136090, 136297, 136345, 136455, 136459, 136567, 136576, 136590, 136612, 136620, 136626, 136630, 136849, 136862, 136875, 136900, 136951, 136960, 137045,
 137058, 137122, 137179, 137256, 137258, 137261, 137337, 137348, 137490, 137499, 137595, 137601, 137674, 137690, 137691, 137696, 137743, 137749, 137753, 137773, 137823, 137846,
 137910, 137927, 137929, 137937, 137987, 138011, 138018, 138026, 138033, 138048, 138074, 138085, 138111, 138181, 138195, 138211, 138214, 138231, 138321, 138425, 138519, 138553,
 138591, 138596, 138618, 138652, 138659, 138662, 138676, 138682, 138754, 138793, 138832, 138842, 138885, 138904, 138935, 138936, 138943, 138945, 138955, 138972, 138989, 139008,
 139078, 139079, 139081, 139118, 139208, 139234, 139241, 139258, 139282, 139291, 139322, 139345, 139349, 139388, 139432, 139435, 139437, 139440, 139442, 139443, 139444, 139446,
 139448, 139450, 139454, 139458, 139465, 139468, 139523, 139529, 139532, 139541, 139615, 139630, 139635, 139642, 139663, 139667, 139672, 139767, 139769, 139771, 139773, 139777,
 139784, 139788, 139790, 139794, 139796, 139812, 139829, 139837, 139840, 139856, 139868, 139884, 139900, 139901, 139902, 139906, 139914, 139922, 139939, 139955, 139959, 139960,
 139968, 139976, 139986, 139990, 139991, 139995, 140005, 140030, 140037, 140062, 140067, 140114, 140118, 140160, 140198, 140225, 140248, 140280, 140294, 140319, 140348, 140364,
 140382, 140383, 140466, 140477, 140508, 140512, 140524, 140543, 140545, 140620, 140622, 140633, 140640, 140642, 140644, 140649, 140666, 140668, 140669, 140671, 140673, 140679,
 140684, 140691, 140755, 140773, 140823, 140862, 140869, 140878, 140976, 140997, 141006, 141120, 141200, 141260, 141273, 141283, 141421)
group by cliente,oficina



select st_cuenta, count(1)
from cob_conta_tercero..ct_saldo_tercero
where st_cuenta   in ('241302', '240191')
and   st_periodo  = @w_periodo
and   st_corte    = @w_corte
and   st_ente     in (select bo_cliente from #cb_boc)
group by st_cuenta

select count(1) 
from #cb_boc
where  bo_producto = 19
and    bo_val_opera>= 0.01

/* Asiento Contable */
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

--Cuenta de garantías
print 'INICIA CONTABILIZACION'

select 
@w_cuenta_new  = '240191',
@w_cuenta_ges  = '240190',
@w_cotizacion = 1,
@w_commit     = 'N'


select distinct 
oficina = bo_oficina
into #oficinas
from #cb_boc  
where  bo_producto = 19
and    bo_val_opera>= 0.01


select @w_oficina = 0 


select * into #asientos  from  cob_conta_tercero..ct_sasiento_tmp
where 1 = 2 



while (1=1) begin 


   select top 1 
   @w_oficina = oficina
   from #oficinas
   where oficina > @w_oficina 
   order by oficina 
   
   if @@rowcount = 0 break 
   
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
   select 
   7,                  @w_fecha_proceso,     @w_comprobante,
   1,                  0,                    @w_cuenta_new,    
   bo_oficina,         1090,            
   bo_val_opera,
   0,
   0,
   0,
   'ASIENTO INICIAL',     @w_cotizacion,        'N',
   'A',                 0,             0, 
   bo_cliente,         'N',                   0,
   0,                  'N',                   0, 
   0,                  'N',                   0, 
   'N',                0,                    'N',
   'N',                0,                    'ASIENTO INICIAL',
   'N',                null,                 null,
   'S',                
   '2',        
   null,               null,                 null,        
   null,               null,                'N'                                 
   from #cb_boc
   where  bo_producto =  19
   and    bo_val_opera>= 0.01
   and    bo_oficina   = @w_oficina
   
   if @@error <> 0 begin 
      select @w_msg = 'ERROR: AL INSERTAR LOS ASIENTOS'
      goto ERROR
   end 
   
   select @w_contrapartida = sum(bo_val_opera) 
   from   #cb_boc
   where  bo_producto =  19
   and    bo_val_opera>= 0.01
   and    bo_oficina   = @w_oficina
	 
	 
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
   0,
   @w_contrapartida,
   0,
   0,
   'ASIENTO INICIAL',   @w_cotizacion,        'N',
   'A',                 0,                    0, 
   3,                  'N',                   0,
   0,                  'N',                   0, 
   0,                  'N',                   0, 
   'N',                0,                    'N',
   'N',                0,                    'ASIENTO INICIAL',
   'N',                null,                 null,
   'S',                
   '1',        
   null,               null,                 null,        
   null,               null,                'N'  )
   
   if @@error <> 0 begin 
   select @w_msg = 'ERROR: AL INSERTAR LOS ASIENTOS'
   goto ERROR
   end 
   
   
   
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
   'CONSOLA',         'ASIENTO INICIAL',   getdate(),     
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
   
   
   goto SIGUIENTE 
   
   ERROR:
   print @w_msg 
   
   if @w_commit = 'S' begin 
      select @w_commit = 'N'
      rollback tran 
   end  
      
      SIGUIENTE:  
end ---1=1 

  
   
go

drop table  #asientos 

go 