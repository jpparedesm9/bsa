/************************************************************************/
/*      Archivo:                conssobregiradas.sp                     */
/*      Stored procedure:       sp_consulta_sobregiradas                */
/*      Base de datos:          cob_conta                               */
/*      Producto:               Contabilidad                            */
/*      Disenado por:           Jose Molano                             */
/*      Fecha de escritura:     27-nov-2012                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Generar reporte de cuentas contables sobregiradas, tanto saldo  */
/*      como movimientos.                                               */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*                                                                      */
/************************************************************************/
use cob_conta
go

if exists (select 1 from cob_conta..sysobjects where name = 'sp_consulta_sobregiradas' and type = 'P') begin
   drop proc sp_consulta_sobregiradas 
end
go

SET  ANSI_NULLS ON
go
SET ANSI_WARNINGS ON
go

create proc sp_consulta_sobregiradas (
@i_param1       varchar(2)     = ';',   --SEPARADOR
@i_param2       varchar(20)    = null,  --OPCION CUENTA (E: ESPECIFICA, R:RANGO)
@i_param3       varchar(20)    = null,  --CUENTA1
@i_param4       varchar(20)    = null,  --CUENTA2
@i_param5       varchar(1)     = 'N'    --DEBUG
)
as
declare 
@i_separador      varchar(2),
@i_opcion         char(1),
@i_cuenta         varchar(20),
@i_cuenta1        varchar(20),
@i_cuenta2        varchar(20),
@i_debug          char(1),
@w_tercero        smallint,
@w_ente           int,
@w_corte          smallint,
@w_periodo        smallint,
@w_fecha          datetime,
@w_fecha_fm       datetime,
@w_corte_fm       smallint,
@w_titulo         varchar(3000),
@w_s_app          varchar(255),
@w_archivo        varchar(50),
@w_path_listados  varchar(100),
@w_cmd            varchar(500),
@w_comando        varchar(1000),
@w_errores        varchar(100),
@w_error          int,
@w_plano          varchar(255),
@w_fecha_hoy      datetime,
@w_anio           smallint,
@w_mes            smallint,
@w_dia            smallint,
@w_cta_act        char(1),
@w_cta_ant        char(1),
@w_control        tinyint,
@w_categoria      varchar(20),
@w_final          tinyint,
@w_cadena1 		  varchar(300),
@w_cadena2 		  varchar(300),
@w_cadena3 		  varchar(300),
@w_cadena4 		  varchar(300),
@w_cadena5 		  varchar(300),
@w_cadena6 		  varchar(300),
@w_cadena7 		  varchar(300),
@w_cadena8 		  varchar(300),
@w_cadena9 		  varchar(300),
@w_cadena10       varchar(300),
@w_srv_his        varchar(10),
@w_mes_saldo      int,
@w_fecha_fin      datetime,
@w_fecha_ini      datetime,
@w_mes_saldo_h    int,
@w_fecha_fin_h    datetime,
@w_corte_cli      smallint,
@w_periodo_cli    smallint


select @i_separador = convert(varchar(2) , @i_param1)
select @i_opcion    = convert(char(1), @i_param2)
select @i_cuenta1   = convert(varchar(20), @i_param3)
select @i_cuenta2   = convert(varchar(20), @i_param4)
select @i_debug     = convert(char(1)    , @i_param5)

set nocount on 

select @w_tercero = 0
select @w_anio    = 0
select @w_mes     = 0
select @w_dia     = 0
select @w_cta_ant = ''
select @w_cta_act = ''
select @w_control = 0
select @w_final   = 0
--select @w_ente    = 0

select @w_fecha_hoy = getdate()

select @w_anio = datepart(yyyy, @w_fecha_hoy)
select @w_mes  = datepart(mm, @w_fecha_hoy)
select @w_dia  = datepart(dd, @w_fecha_hoy)

select @w_srv_his = pa_char
 from cobis..cl_parametro
 where pa_nemonico = 'SRVHIS'
   and   pa_producto = 'CCA'
   
if @@rowcount = 0
begin
  print 'No Existe Parametro de Servidor de Historicos'
  return 1
end      
   
create table #cuentas (
cuenta    varchar(21))

--Delimita las cuentas de acuerdo a la opción de ejecución
if @i_opcion = 'R' begin
   insert into #cuentas
   select cu_cuenta
   from cob_conta..cb_cuenta
   where cu_cuenta    >= @i_cuenta1
   and   cu_cuenta    <= @i_cuenta2
   and   cu_estado     = 'V'
   and   cu_movimiento = 'S'
   and   cu_cuenta in (select cp_cuenta
                       from cob_conta..cb_cuenta_proceso
                       where cp_proceso in (6003, 6095))
end
if @i_opcion = 'E' begin
   select 1
   from cob_conta..cb_cuenta_proceso
   where cp_proceso in (6003, 6095)
   and   cp_cuenta = @i_cuenta1
   
   if @@rowcount > 0 begin
      insert into #cuentas
      values (@i_cuenta1)
   end
   else begin
      print 'Cuenta no pertenece a terceros'
      return 1
   end
end

--Busca el periodo y el corte según la fecha actual en contabilidad
select 
@w_corte   = co_corte,
@w_periodo = co_periodo,
@w_fecha   = co_fecha_ini
from cob_conta..cb_corte
where co_estado = 'A'

--Busca el parametro del s_app
select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

--Busca el path para listados de contabilidad
select @w_plano = pp_path_destino
from cobis..ba_path_pro  
where pp_producto = 6

--Borra tablas de trabajo
if exists (select 1 from cob_conta..sysobjects where name = 'cta_sobregirada' and type = 'U') begin
   drop table cta_sobregirada 
end

if exists (select 1 from cob_conta..sysobjects where name = 'cb_reporte_sob' and type = 'U') begin
   drop table cb_reporte_sob
end

if exists (select 1 from sysobjects where name = 'cb_rep_cuenta' and type = 'U') begin
   drop table cb_rep_cuenta
end

--Crea tablas de trabajo
create table cb_reporte_sob (
texto   varchar(5000)
)

create table cta_sobregirada (
ente         int         not null,
cuenta       varchar(20) not null,
saldo        money       not null)
if @@error <> 0 begin
   print 'ERROR EN CREACION DE TABLA'
   GOTO FINAL
end

create table cb_rep_cuenta(
texto   varchar(5000)   null
)

select @w_fecha_fm = dateadd(dd, -1, dateadd(mm, 1, dateadd(dd, ((datepart(dd, @w_fecha)-1)*-1), @w_fecha)))

select 
@w_corte_fm  = co_corte,
@w_periodo   = co_periodo
from cob_conta..cb_corte
where co_fecha_ini = @w_fecha_fm

/******************/
   select @w_titulo = 'OFICINA_DEST' + @i_separador + 'AREA_DEST'+@i_separador+ 'COMPROBANTE'+@i_separador+'COMP_DEFINIT'+
      @i_separador + 'ASIENTO'+@i_separador+'CUENTA'+ @i_separador+'FECHA' +@i_separador+ 'CONCEPTO' + @i_separador +
      'DEBITO' + @i_separador + 'CREDITO' + @i_separador + 'ENTE' + @i_separador + 'TIPO_DOC' + @i_separador +
      'DOCUMENTO' + @i_separador + 'NOMBRE' + @i_separador + 'REFERENCIA' + @i_separador + 'OFICINA_ORIG' + @i_separador + 'FECHA_GRAB'
      + @i_separador + 'SALDO'
      
   if @@error <> 0 begin
      print 'ERROR EN INSERCION DE TABLA ENCABEZADO DE REPORTE' + convert(varchar(8), @w_ente)
      GOTO FINAL
   end
   
   insert into cb_reporte_sob values
     (@w_titulo)

while 1 = 1 begin --Ciclo por cuenta
   truncate table cta_sobregirada
   
   select top 1 @i_cuenta = cuenta
   from #cuentas
   order by cuenta
   
   if @@rowcount = 0 begin
      select @w_final = 1
      BREAK
   end
   
   delete #cuentas
   where cuenta = @i_cuenta
   if @@error <> 0 begin
      print 'ERROR EN BORRADO DE TABLA TEMPORAL'
      GOTO FINAL
   end
   
   select @w_tercero = count(1)
   from cob_conta..cb_cuenta_proceso
   where cp_proceso in (6003, 6095)
   and   cp_cuenta = @i_cuenta

   select @w_tercero = isnull(@w_tercero, 0)

   select @w_cta_ant = @w_cta_act
   select @w_cta_act = substring(@i_cuenta,1,1)
   
     
   --Extrae saldos por cuenta y ente
   insert into cta_sobregirada
   select 
   st_ente, 
   st_cuenta, 
   st_saldo = case cu_categoria when 'C' then sum(st_saldo * -1) else sum(st_saldo) end
   from cob_conta_tercero..ct_saldo_tercero,
        cob_conta..cb_cuenta
   where st_ente     > 0
   and   st_cuenta   = @i_cuenta
   and   st_corte    = @w_corte_fm
   and   st_periodo  = @w_periodo
   and   st_cuenta   = cu_cuenta
   group by st_ente, st_cuenta, cu_categoria
   having case cu_categoria when 'C' then sum(st_saldo * -1) else sum(st_saldo) end < 0
   
   if @@error <> 0 begin
      print 'ERROR EN INSERCION DE TABLA cta_sobregirada DE TERCEROS'
      GOTO FINAL
   end

   if @i_debug = 'S' begin
      print 'Rango Entes para la cuenta: ' + convert(varchar(11), @i_cuenta)
      select min(ente), max(ente), count(1)
      from cta_sobregirada
   end
   
   while 1 = 1   --ciclo por ente
   begin   
     if exists(select 1 from cob_conta..sysobjects where name = 'tmp_mincorte' and type = 'U')
         drop  table tmp_mincorte
         
      truncate table tmp_mincorte_cli   
      
      select top 1
      @w_ente   = ente
      from cta_sobregirada
      where ente > isnull(@w_ente, 0)
      order by ente

      if @@rowcount = 0 begin
         break
      end

      select  top 1  'ente' = st_ente,
      'corte' = min(st_corte),  'periodo' = st_periodo, 'saldo' = case cu_categoria when 'C' then sum(st_saldo * -1) else sum(st_saldo) end
       into tmp_mincorte
       from cob_conta_tercero..ct_saldo_tercero, cob_conta..cb_cuenta
	   where st_ente     = @w_ente 
	   and   st_cuenta   = @i_cuenta
	   and   st_corte    >= 0
	   and   st_periodo  <= @w_periodo
	   and   st_cuenta   = cu_cuenta
	   group by cu_categoria,  st_corte,  st_periodo, st_ente
	   having case cu_categoria when 'C' then sum(st_saldo * -1) else sum(st_saldo) end < 0
      
      select @w_mes_saldo = datepart(mm,co_fecha_ini), 
             @w_fecha_fin = co_fecha_ini
      from tmp_mincorte, cob_conta..cb_corte
      where co_corte = corte
      and co_periodo = periodo
  
           
      --consulta historico    
      if @w_mes_saldo = 1
      begin
	      if @w_srv_his <> 'NOHIST' 
		  begin
		    if exists (select 1 from sysobjects where name = 'tmp_saldo_hist' and type = 'U') 
		        drop table tmp_saldo_hist
		       
			--OBTENIENDO LOS CLIENTES Y CUENTAS CORRESPONDIENTES AL CORTE Y AL PERIODO
			select @w_comando = 'select top 1 ' +  '''' + 'ente' + '''' + '= st_ente, '
			select @w_comando = @w_comando + '''' + 'corte' + '''' + ' = min(st_corte), '
			select @w_comando = @w_comando + '''' + 'periodo' + '''' + '= st_periodo, '
			select @w_comando = @w_comando + '''' + 'saldo' + '''' + '= case cu_categoria when' + '''' + 'C'  + '''' + 'then sum(st_saldo * -1) else sum(st_saldo) end '
			select @w_comando = @w_comando + ' into tmp_saldo_hist' 
			select @w_comando = @w_comando + ' from ' + @w_srv_his + '.cob_conta_tercero.dbo.ct_saldo_tercero b, cob_conta.dbo.cb_cuenta a'
			select @w_comando = @w_comando + ' where b.st_periodo <= '  +  convert(varchar(4),@w_periodo)
			select @w_comando = @w_comando + ' and   b.st_corte   >= 0 '  
			select @w_comando = @w_comando + ' and   b.st_cuenta  = ' +  @i_cuenta  
			select @w_comando = @w_comando + ' and   b.st_ente    = '   +  convert(varchar(15),@w_ente)
			select @w_comando = @w_comando + ' group by cu_categoria,  st_corte,  st_periodo, st_ente '
			select @w_comando = @w_comando + ' having case cu_categoria when'  + '''' + 'C'  + '''' + ' then sum(st_saldo * -1) else sum(st_saldo) end < 0 '			
						
			    
			exec  @w_error = sp_sqlexec @w_comando
			select @w_comando = ''
				
			if @w_error <> 0 
			begin
			    print 'ERROR AL REALIZAR INSERCION EN LA TABLA #saldo_hist'
			    goto FINAL
			end
			
		    if exists (select 1 from sysobjects where name = 'tmp_saldo_hist' and type = 'U')
		    begin
			     insert into tmp_mincorte_cli
                 select * from   tmp_saldo_hist
            end     
            
            select @w_mes_saldo_h = datepart(mm,co_fecha_ini), 
                   @w_fecha_fin_h = co_fecha_ini
              from tmp_mincorte_cli, cob_conta..cb_corte
              where co_corte = corte
                and co_periodo = periodo
      
            if @w_mes_saldo_h = 1
            begin
            	if exists (select 1 from sysobjects where name = 'tmp_saldo_hist' and type = 'U') 
		             drop table tmp_saldo_hist_dw
		        
	            --OBTENIENDO LOS CLIENTES Y CUENTAS CORRESPONDIENTES AL CORTE Y AL PERIODO
				select @w_comando = 'select top 1 ' +  '''' + 'ente' + '''' + '= st_ente, '
				select @w_comando = @w_comando + '''' + 'corte' + '''' + ' = min(st_corte), '
				select @w_comando = @w_comando + '''' + 'periodo' + '''' + '= st_periodo, '
				select @w_comando = @w_comando + '''' + 'saldo' + '''' + '= case cu_categoria when' + '''' + 'C'  + '''' + 'then sum(st_saldo * -1) else sum(st_saldo) end '
				select @w_comando = @w_comando + ' into tmp_saldo_hist_dw' 
				select @w_comando = @w_comando + ' from ' + @w_srv_his + '.dw_cob_conta_tercero.dbo.ct_saldo_tercero c, cob_conta.dbo.cb_cuenta a'
				select @w_comando = @w_comando + ' where c.st_periodo <= '  +  convert(varchar(4),@w_periodo)
				select @w_comando = @w_comando + ' and   c.st_corte   >= 0 '  
				select @w_comando = @w_comando + ' and   c.st_cuenta  = ' +  @i_cuenta  
				select @w_comando = @w_comando + ' and   c.st_ente    = '   +  convert(varchar(15),@w_ente)
				select @w_comando = @w_comando + ' group by cu_categoria,  st_corte,  st_periodo, st_ente '
				select @w_comando = @w_comando + ' having case cu_categoria when'  + '''' + 'C'  + '''' + ' then sum(st_saldo * -1) else sum(st_saldo) end < 0 '			
							
				    
				exec  @w_error = sp_sqlexec @w_comando
				select @w_comando = ''
					
				if @w_error <> 0 
				begin
				    print 'ERROR AL REALIZAR INSERCION EN LA TABLA #saldo_hist'
				    goto FINAL
				end
				
		       if exists (select 1 from sysobjects where name = 'tmp_saldo_hist' and type = 'U')
		       begin
			        insert into tmp_mincorte_cli
                    select * from  tmp_#saldo_hist_dw
               end      
            end --saldo h
                
        end-- server no hist

      end --mes saldo
      else
      begin
          insert into tmp_mincorte_cli
          select * from  tmp_mincorte
      end

      select @w_fecha_ini = min(co_fecha_ini),
             @w_fecha_fin = min(co_fecha_fin)
       from tmp_mincorte_cli, cob_conta..cb_corte
       where co_corte = corte
        and co_periodo = periodo
        and ente = @w_ente
        group by ente
        
      select @w_corte_cli = co_corte,
             @w_periodo_cli = co_periodo
      from cob_conta..cb_corte
      where  co_fecha_ini =  @w_fecha_ini 
    

      insert into cb_reporte_sob
      select
      isnull (
      convert(varchar(5), sa_oficina_dest) + @i_separador +
      convert(varchar(5), sa_area_dest) + @i_separador +
      convert(varchar(8), sc_comprobante) + @i_separador +
      convert(varchar(8), sc_comp_definit) + @i_separador +
      convert(varchar(8), sa_asiento) + @i_separador +
      convert(varchar(20), sa_cuenta)+ @i_separador +
      convert(varchar(10), sc_fecha_tran, 103)+ @i_separador +
      convert(varchar(50), sa_concepto)+ @i_separador +
      convert(varchar(16), sa_debito)+ @i_separador +
      convert(varchar(16), sa_credito)+ @i_separador +
      isnull(convert(varchar(16), sa_ente), 0)+ @i_separador +
      isnull((select en_tipo_ced  from cobis..cl_ente where en_ente = sa_ente), '')+ @i_separador +
      isnull((select en_ced_ruc  from cobis..cl_ente where en_ente = sa_ente), '')+ @i_separador +
      isnull((select en_nomlar  from cobis..cl_ente where en_ente = sa_ente), '')+ @i_separador +
      convert(varchar(8), isnull(sa_cheque, ''))+ @i_separador +
      convert(varchar(8), sc_oficina_orig)+ @i_separador +
      convert(varchar(10), sc_fecha_gra, 103)+ @i_separador +
      (select convert(varchar(20),isnull(saldo,0)) from tmp_mincorte_cli where ente = @w_ente and corte = @w_corte_cli and periodo = @w_periodo_cli), convert(varchar(10), '')) 
      from cob_conta_tercero..ct_sasiento,
           cob_conta_tercero..ct_scomprobante
      where sa_fecha_tran >= @w_fecha_ini
      and   sa_fecha_tran <= @w_fecha_fin
      and   sa_cuenta      = @i_cuenta
      and   sa_ente        = @w_ente 
      and   sa_comprobante = sc_comprobante 
      and   sa_fecha_tran  = sc_fecha_tran
      and   sa_producto    = sc_producto
      and   sa_empresa     = sc_empresa
      if @@error <> 0 begin
         print 'ERROR EN INSERCION DE DETALLES DE REPORTE' + convert(varchar(8), @w_ente)
         GOTO FINAL
      end
       
      SET ANSI_NULLS ON
      SET ANSI_WARNINGS ON
      
      if isnull(@w_srv_his, 'NOHIST') <> 'NOHIST' begin
         select @w_cadena1 =  'insert into cb_reporte_sob ' + 
								'select ' +
								'convert(varchar(5), sa_oficina_dest) ' + '+ ' + '''' + @i_separador + '''' + ' + ' + 
								'convert(varchar(5), sa_area_dest) ' + '+ ' + '''' + @i_separador + '''' + ' + ' 

      	select @w_cadena2 = 'convert(varchar(8), sc_comprobante) ' + '+ ' + '''' + @i_separador + '''' + ' + ' +
							'convert(varchar(8), sc_comp_definit) ' + '+ ' + '''' + @i_separador + '''' + ' + ' +
							'convert(varchar(8), sa_asiento) ' + '+ ' + '''' + @i_separador + '''' + ' + ' 

		select @w_cadena3 = 'convert(varchar(20), sa_cuenta) ' + '+ ' + '''' + @i_separador + '''' + ' + ' +
							' convert(varchar(10), sc_fecha_tran, 103) ' + '+ ' + '''' + @i_separador + '''' + ' + ' +
							'convert(varchar(50), sa_concepto) ' + '+ ' + '''' + @i_separador + '''' + ' + ' 
							
		select @w_cadena4 = 'convert(varchar(16), sa_debito) ' + '+ ' + '''' + @i_separador + '''' + ' + ' +
							'convert(varchar(16), sa_credito) ' + '+ ' + '''' + @i_separador + '''' + ' + ' +
							'convert(varchar(16), sa_ente) ' + '+ ' + '''' + @i_separador + '''' + ' + ' 

		select @w_cadena5 = '(select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente) ' + '+ ' + '''' + @i_separador + '''' + ' + ' +
				'isnull((select en_ced_ruc from cobis..cl_ente where en_ente = sa_ente), '''') ' + '+ ' + '''' + @i_separador + '''' + ' + ' +
				'isnull((select en_nomlar from cobis..cl_ente where en_ente = sa_ente), '''') ' + '+ ' + '''' + @i_separador + '''' + ' + ' 

		select @w_cadena6 = 'convert(varchar(8), isnull(sa_cheque, '''')) ' + '+ ' + '''' + @i_separador + '''' + ' + ' +
				'convert(varchar(8), sc_oficina_orig) ' + '+ ' + '''' + @i_separador + '''' + ' + ' +
				'convert(varchar(10), sc_fecha_gra, 103) ' + '+ ' + '''' + @i_separador + '''' + ' + ' +
				'(select convert(varchar(20),isnull(saldo,0)) from tmp_mincorte_cli where ente = ' + convert(varchar,@w_ente) + ' and corte = ' + convert(varchar,@w_corte_cli) + ' and periodo = ' + convert(varchar,@w_periodo_cli) + ')'--+ ', convert(varchar(10), '')) '
				
		select @w_cadena7 = ' from ' + @w_srv_his + '.cob_conta_tercero.dbo.ct_sasiento ,' + 
			' cob_conta_tercero..ct_scomprobante ' + 
			' where sa_fecha_tran <= ' + '''' + convert(varchar(10),@w_fecha,101) + '''' 
		
		select @w_cadena8 = ' and sa_cuenta = ' + '''' + convert(varchar,@i_cuenta) + '''' + 
			' and (sa_ente = ' + convert(varchar,@w_ente) + ' or ' + convert(varchar,@w_ente) + ' is null) ' +
			'and sa_comprobante = sc_comprobante ' 
		
		select @w_cadena9 = 'and sa_fecha_tran = sc_fecha_tran ' +
			'and sa_producto = sc_producto ' +
			'and sa_empresa = sc_empresa '
	                  
                                                 
         exec (@w_cadena1 + @w_cadena2 + @w_cadena3 + @w_cadena4 + @w_cadena5 + @w_cadena6 + @w_cadena7 + @w_cadena8 + @w_cadena9)  
         
         
         if @@error <> 0 
         begin
            print 'ERROR EN INSERCION DE DETALLES HISTORICOS DE REPORTE' + convert(varchar(8), @w_ente)
            GOTO FINAL
         end
         
         --buscar en base de datos dw_cob_conta_tercero
         if @@rowcount = 0 
         begin
           select @w_cadena1 = 'insert into cb_reporte_sob ' + 
								'select ' +
								'convert(varchar(5), sa_oficina_dest) ' + '+ ' + '''' + @i_separador + '''' + ' + ' + 
								'convert(varchar(5), sa_area_dest) ' + '+ ' + '''' + @i_separador + '''' + ' + ' 

      	  select @w_cadena2 = 'convert(varchar(8), sc_comprobante) ' + '+ ' + '''' + @i_separador + '''' + ' + ' +
							'convert(varchar(8), sc_comp_definit) ' + '+ ' + '''' + @i_separador + '''' + ' + ' +
							'convert(varchar(8), sa_asiento) ' + '+ ' + '''' + @i_separador + '''' + ' + ' 

		  select @w_cadena3 = 'convert(varchar(20), sa_cuenta) ' + '+ ' + '''' + @i_separador + '''' + ' + ' +
							' convert(varchar(10), sc_fecha_tran, 103) ' + '+ ' + '''' + @i_separador + '''' + ' + ' +
							'convert(varchar(50), sa_concepto) ' + '+ ' + '''' + @i_separador + '''' + ' + ' 
							
		 select @w_cadena4 = 'convert(varchar(16), sa_debito) ' + '+ ' + '''' + @i_separador + '''' + ' + ' +
							'convert(varchar(16), sa_credito) ' + '+ ' + '''' + @i_separador + '''' + ' + ' +
							'convert(varchar(16), sa_ente) ' + '+ ' + '''' + @i_separador + '''' + ' + ' 

		 select @w_cadena5 = '(select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente) ' + '+ ' + '''' + @i_separador + '''' + ' + ' +
				'isnull((select en_ced_ruc from cobis..cl_ente where en_ente = sa_ente), '''') ' + '+ ' + '''' + @i_separador + '''' + ' + ' +
				'isnull((select en_nomlar from cobis..cl_ente where en_ente = sa_ente), '''') ' + '+ ' + '''' + @i_separador + '''' + ' + ' 

	     select @w_cadena6 = 'convert(varchar(8), isnull(sa_cheque, '''')) ' + '+ ' + '''' + @i_separador + '''' + ' + ' +
				'convert(varchar(8), sc_oficina_orig) ' + '+ ' + '''' + @i_separador + '''' + ' + ' +
				'convert(varchar(10), sc_fecha_gra, 103) ' + '+ ' + '''' + @i_separador + '''' + ' + ' +
				'(select convert(varchar(20),isnull(saldo,0)) from tmp_mincorte_cli where ente = ' + convert(varchar,@w_ente) + ' and corte = ' + convert(varchar,@w_corte_cli) + ' and periodo = ' + convert(varchar,@w_periodo_cli) + ')'--+ ', convert(varchar(10), '')) '
				
		 select @w_cadena7 = ' from ' + @w_srv_his + '.dw_cob_conta_tercero.dbo.ct_sasiento, '  + @w_srv_his + '.dw_cob_conta_tercero.dbo.ct_scomprobante ' + 
			' where sa_fecha_tran <= ' + '''' + convert(varchar(10),@w_fecha,101) + '''' 
		
		 select @w_cadena8 = ' and sa_cuenta = ' + '''' + convert(varchar,@i_cuenta) + '''' + 
			' and (sa_ente = ' + convert(varchar,@w_ente) + ' or ' + convert(varchar,@w_ente) + ' is null) ' +
			'and sa_comprobante = sc_comprobante ' 
		
		 select @w_cadena9 = 'and sa_fecha_tran = sc_fecha_tran ' +
			'and sa_producto = sc_producto ' +
			'and sa_empresa = sc_empresa '
	                  
                                                 
          exec (@w_cadena1 + @w_cadena2 + @w_cadena3 + @w_cadena4 + @w_cadena5 + @w_cadena6 + @w_cadena7 + @w_cadena8 + @w_cadena9)  
         
         
         if @@error <> 0 
         begin
            print 'ERROR EN INSERCION DE DETALLES HISTORICOS DE REPORTE' + convert(varchar(8), @w_ente)
            GOTO FINAL
         end
         end
         
      end

   end
   end -- cuentas
   --if (@i_opcion = 'E') or (@w_cta_act <> @w_cta_ant) begin
     -- TERMINA:
      insert into cb_rep_cuenta
      select *
      from cob_conta..cb_reporte_sob
      
      if @i_opcion = 'E' begin
         select @w_cta_ant = @w_cta_act
         select @w_final = 1
      end

      --Forma el nombre del plano
      select @w_categoria = replace(rtrim(ltrim(cu_nombre)), ' ', '_') from cob_conta..cb_cuenta where cu_cuenta = @w_cta_ant

      select @w_archivo = 'cb_cuentas_sobregiradas_'  + case when @w_dia < 10 then '0' + convert(varchar(2),@w_dia) else convert(varchar(2),@w_dia) end + 
                          case when @w_mes < 10 then '0' + convert(varchar(2),@w_mes) else convert(varchar(2),@w_mes) end + 
                          convert(varchar(4),@w_anio)

      select @w_errores  = @w_plano + @w_archivo + '.err'
      select @w_cmd      = @w_s_app + 's_app bcp cob_conta..cb_rep_cuenta out '
      select @w_comando  = @w_cmd + @w_plano + @w_archivo + '.csv' + ' -b5000 -c ' + ' -t' + '"' +'&&'+ '"' + ' -auto -login ' + '-config ' + @w_s_app + 's_app.ini'
      
      if @i_debug = 'S' begin
         print @w_cmd
         print @w_path_listados
         print @w_comando 
         print @w_errores
      end 
      
      --Genera plano por grupo de cuentas
      exec @w_error = xp_cmdshell @w_comando
      if @w_error <> 0 begin
          print 'Error cargando Archivo: ' + @w_archivo
          print @w_comando
      end

      truncate table cb_rep_cuenta
      truncate table cb_reporte_sob
      
FINAL:

set nocount off
return 0

SET  ANSI_NULLS OFF
go
SET ANSI_WARNINGS OFF
go

