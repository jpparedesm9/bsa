/************************************************************************/
/*	Archivo: 		saldo.sp	    		        */
/*	Stored procedure: 	sp_saldo   				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               Contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     30-julio-1993 				*/
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
/*	Este programa procesa las transacciones de:			*/
/*	   Mantenimiento al catalogo de Saldos                          */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	30/Jul/1993	G. Jaramillo    Emision Inicial			*/
/*	21/Jun/1994	G. Jaramillo    Eliminacion de secciones	*/
/*      22/feb/1995     C. Bernal       Operacion sumatoria             */ 
/*	11/Mar/1997	F  Salgado	Personalizacion CajaCoop	*/
/*					FS001: Adicion opcion 'Q' para  */
/*					manejo de saldos actuales y	*/
/*					anteriores			*/
/*	26/Jun/1997			Estandarizacion version 3.0	*/
/*					Manejo opcion 'A' y 'S'		*/	
/*      22/Nov/1997                     MCM001: Inclusion opcion 'C'    */
/*                                      consulta saldos consolidados    */
/*	31/May/1999	O. Escandon     Ope = Q, realizar la consulta   */
/*					sobre ct_saldo_tercero..cb_saldo*/  
/*	01/Jun/1999	O. Escandon     Ope = P, realizar la consulta   */
/*					sobre ct_saldo_tercero..cb_saldo*/  
/*      14/Jul/2005     John Jairo Rendon Optimizacion                  */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_saldo')
   drop proc sp_saldo
go

create proc sp_saldo    (
   @s_ssn		int = null,
   @s_date		datetime = null,
   @s_user		login = null,
   @s_term		descripcion = null,
   @s_corr		char(1) = null,
   @s_ssn_corr	int = null,
   @s_ofi		smallint = null,
   @t_rty		char(1) = null,
   @t_trn		smallint = null,
   @t_debug	char(1) = 'N',
   @t_file		varchar(14) = null,
   @t_from		varchar(30) = null,
   @i_operacion	char(1),
   @i_modo		smallint = null,
   @i_empresa	tinyint  = null,
   @i_cuenta     	cuenta = null,
   @i_cuenta1    	cuenta = null,
   @i_nivel_cuenta  tinyint = null,
   @i_oficina 	smallint = null,
   @i_area		smallint = null,
   @i_periodo      int  = null,
   @i_mes		tinyint = null,		
   @i_anio		tinyint = null,
   @i_fecha_ant    datetime = null,
   @i_fecha	datetime = null,	
   @i_fecha_ini	datetime = null,
   @i_fecha_fin	datetime = null,
   @i_formato_fecha	tinyint = 1,
   @i_concepto     varchar(9) = null,
   @i_cod_declaracion     char(2) = null

)
as 
declare
   @w_today 	     	datetime,  	/* fecha del dia */
   @w_return	     	int,		    /* valor que retorna */
   @w_sp_name	     	varchar(32),	/* nombre del stored procedure*/
   @w_siguiente	 	tinyint,
   @w_empresa	     	tinyint,
   @w_cuenta  	     	cuenta,
   @w_secuencial	smallint,
   @w_operador	     	int,
   @w_tipo_dinamica 	char(1),
   @w_saldochar	 	char(30),	
   @w_texto	     	char(255),
   @w_disp_legal	char(255),
   @w_periodo	     	int,
   @w_periodo_ini   	int,
   @w_periodo_fin   	int,
   @w_corte	     	int,
   @w_corte_ini     	int,
   @w_corte_fin     	int,
   @w_periodo_ant	int,
   @w_corte_ant	 	int,
   @w_periodo_mid	int,
   @w_corte_mid	 	int,
   @w_max_corte     	int,
   @w_periodo1	     	int,
   @w_corte1	     	int,
   @w_existe	     	tinyint,	/* codigo existe = 1 
				                 no existe = 0 */
   @w_saldo         	money,
   @w_saldo_ini     	money,
   @w_saldo_fin     	money,
   @w_saldo_ant     	money, 
   @w_saldo1        	money, 
   @w_saldoacum	 	money,
   @w_saldoacum1	money,
   @w_credito       	money,
   @w_credito1      	money,
   @w_debito        	money,
   @w_debito1       	money, 
   @w_nombre        	descripcion ,
   @w_estado        	char(1),
   @w_estado_corte	char(1),
   @w_estado_corte_ini 	char(1),
   @w_estado_corte_fin 	char(1),
   @w_fecha_mes     	datetime,
   @w_mes_ant       	tinyint,
   @w_dia_ant       	tinyint,
   @w_ano_ant       	smallint,
   @w_mes_act       	tinyint,
   @w_dia_act       	tinyint,
   @w_ano_act       	smallint,
   @w_mes_ant1      	char(2),
   @w_dia_ant1      	char(2),
   @w_ano_ant1      	char(4),
   @w_fecha	     	datetime,
   @w_fecha_ant     	datetime,
   @w_fecha_mid     	datetime,
   @w_fecha_ini		datetime,
   @w_saldo2        	money,
   @w_cu_categoria  	char(1),
   @w_debito_ini        money,
   @w_debito_fin        money,
   @w_credito_ini       money,
   @w_credito_fin       money,
   @w_base              money,
   @sp_id		int,
   @w_oficina		smallint,
   @w_area		smallint,
   --@w_cuenta		cuenta_contable,
   @w_descripcion	varchar(255),
   @w_categoria	 	char(1),
   @w_cuenta_ant	cuenta_contable,
   @w_descripcion_ant	varchar(255),
   @w_categoria_ant	char(1),
   @w_registros	 	int,
   @w_encontro_saldos   char(1),
   @w_saldo_mn		money,
   @w_saldo_me		money,
   @w_saldo_aux		money


   select @w_today = getdate()
   select @w_sp_name = 'sp_saldo'

   select @sp_id = @@spid

/************************************************/
/*  Tipo de Transaccion =     			*/
if (@t_trn <> 6327 and @i_operacion = 'A') or
   (@t_trn <> 6325 and @i_operacion in ('S','C')) or /* MCMM001 */
   (@t_trn <> 6120 and @i_operacion = 'M') or
   (@t_trn <> 6005 and @i_operacion in ('P','R','N','O','Y','J')) or 
   (@t_trn <> 6005 and @i_operacion = 'E') or 
   (@t_trn <> 6007 and @i_operacion = 'T') or 
   (@t_trn <> 6709 and @i_operacion = 'Q')
begin
/* 'Tipo de transaccion no corresponde' */
   exec cobis..sp_cerror
           @t_debug = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 601077
	   return 1
end
/************************************************/

if @t_debug = 'S'
begin
   exec cobis..sp_begin_debug @t_file = @t_file
   select '/** Store Procedure **/ ' = @w_sp_name,
	  t_file		= @t_file,
	  t_from		= @t_from,
	  i_operacion	= @i_operacion,
	  i_empresa	= @i_empresa,
	  i_cuenta     	= @i_cuenta,
	  i_oficina	= @i_oficina,
	  i_periodo    	= @i_periodo
   exec cobis..sp_end_debug
end

if @i_operacion = 'T' or @i_operacion = 'C'
begin
   set rowcount 0

   delete
   from cb_oficina_saldo_tmp
   where sp_id = @sp_id
   and s_term = @s_term

   insert into cb_oficina_saldo_tmp
   select distinct 
	@sp_id,
	@s_term,
	je_oficina
   from cb_jerarquia
   where je_empresa = @i_empresa 
   and   je_oficina_padre = @i_oficina

   delete
   from cb_area_saldo_tmp
   where sp_id = @sp_id
   and s_term = @s_term

   insert into cb_area_saldo_tmp
   select distinct 
	@sp_id,
	@s_term,
	ja_area
   from cb_jerararea
   where ja_empresa = @i_empresa 
   and   ja_area_padre = @i_area
end


if @i_operacion in ('E', 'I', 'P')
begin
   set rowcount 0

   delete
   from cb_oficina_saldo_tmp
   where sp_id = @sp_id
   and s_term = @s_term

   insert into cb_oficina_saldo_tmp
   select distinct 
	@sp_id,
	@s_term,
	je_oficina
   from cb_jerarquia
   where je_empresa = @i_empresa 
   and   (je_oficina_padre = @i_oficina
   or 	 je_oficina = @i_oficina)

   delete
   from cb_area_saldo_tmp
   where sp_id = @sp_id
   and s_term = @s_term

   insert into cb_area_saldo_tmp
   select distinct 
	@sp_id,
	@s_term,
	ja_area
   from cb_jerararea
   where ja_empresa = @i_empresa 
   and (ja_area_padre = @i_area 
   or ja_area = @i_area)
end


if @i_operacion = 'S' or @i_operacion = 'C'
begin
   set rowcount 0

   delete
   from cb_saldo_tmp
   where sp_id = @sp_id
   and s_term = @s_term
end

if @i_operacion = 'Z' or @i_operacion = 'H'
begin
   set rowcount 0

   delete
   from cb_cuenta_saldo_tmp
   where sp_id = @sp_id
   and s_term = @s_term
end

select 	@w_corte = co_corte, 
	@w_periodo = co_periodo,
	@w_estado_corte = co_estado
  from 	cb_corte
where 	co_empresa = @i_empresa and
      	co_fecha_ini <= @i_fecha and
      	co_fecha_fin >= @i_fecha

if @i_operacion = 'M'
begin
	if @w_estado_corte = 'A'
	begin
		select	cu_nombre,
			sum(sa_saldo),
			sum(sa_debito),
			sum(sa_credito)
         from 	cb_cuenta,
		       	cb_saldo,
			cb_jerarquia,
			cb_jerararea 
		 where 	sa_empresa = @i_empresa
		   and  ja_empresa = @i_empresa
		   and  ja_area_padre = @i_area
		   and 	ja_area = sa_area
		   and  je_empresa = @i_empresa
		   and	je_oficina_padre = @i_oficina
		   and  je_oficina = sa_oficina	
		   and 	sa_periodo = @w_periodo
		   and 	sa_corte = @w_corte
		   and	sa_area = @i_area
		   and	sa_oficina = @i_oficina
		   and 	sa_cuenta = cu_cuenta
		   and 	sa_cuenta = @i_cuenta
		   and	cu_empresa = @i_empresa
	  	 group by cu_nombre

	end
	else
		select	cu_nombre,
			sum(hi_saldo),
			sum(hi_debito),
			sum(hi_credito)
         	  from 	cb_cuenta,
		       	cob_conta_his..cb_hist_saldo,
			cb_jerarquia,
			cb_jerararea 
		 where 	hi_empresa = @i_empresa
		   and  ja_empresa = @i_empresa
		   and  ja_area_padre = @i_area
		   and 	ja_area = hi_area
		   and  je_empresa = @i_empresa
		   and	je_oficina_padre = @i_oficina
		   and  je_oficina = hi_oficina	
		   and 	hi_periodo = @w_periodo
		   and 	hi_corte = @w_corte
		   and	hi_area = @i_area
		   and	hi_oficina = @i_oficina
		   and 	hi_cuenta = cu_cuenta
		   and 	hi_cuenta = @i_cuenta
		   and	cu_empresa = @i_empresa
	  	 group by cu_nombre
	
end

if @i_operacion = 'T'
begin
   select @w_fecha_mes = dateadd(mm,-1,@i_fecha)
   select @w_corte1 = co_corte,
	  @w_periodo1 = co_periodo
   from cb_corte
   where co_empresa = @i_empresa
   and @w_fecha_mes between co_fecha_ini and co_fecha_fin

   if @w_estado_corte = 'A'
   begin
      select @w_nombre = cu_nombre, 
             @w_cuenta = cu_cuenta,
             @w_saldo = sum(sa_saldo),
             @w_credito = sum(sa_credito),
             @w_debito = sum(sa_debito)
      from cb_cuenta, cb_saldo
      where cu_empresa = @i_empresa
      and cu_cuenta = @i_cuenta
      and sa_corte = @w_corte
      and sa_periodo = @w_periodo
      and sa_oficina in (select je_oficina from cb_oficina_saldo_tmp o where o.sp_id = @sp_id and o.s_term = @s_term)
      and sa_area in (select ja_area from cb_area_saldo_tmp a where a.sp_id = @sp_id and a.s_term = @s_term)
      and sa_cuenta = @i_cuenta
      and sa_empresa = @i_empresa
      group by cu_nombre, cu_cuenta

      select @w_credito1 = sum(hi_credito),
             @w_debito1 = sum(hi_debito),
             @w_saldo1 = sum(hi_saldo)
      from cb_cuenta, cob_conta_his..cb_hist_saldo
      where cu_empresa = @i_empresa
      and cu_cuenta = @i_cuenta 
      and hi_corte = @w_corte1
      and hi_periodo = @w_periodo1
      and hi_oficina in (select je_oficina from cb_oficina_saldo_tmp o where o.sp_id = @sp_id and o.s_term = @s_term)
      and hi_area in (select ja_area from cb_area_saldo_tmp a where a.sp_id = @sp_id and a.s_term = @s_term)
      and hi_cuenta = @i_cuenta
      and hi_empresa = @i_empresa

      select @w_cuenta,
             @w_nombre,
             @w_saldo1,
             @w_debito-@w_debito1,
             @w_credito-@w_credito1,
             @w_saldo,
             @w_debito1,
             @w_credito1
   end
   else
   begin
      select @w_nombre = cu_nombre, 
             @w_cuenta = cu_cuenta,
             @w_saldo = sum(isnull(hi_saldo,0)),
             @w_credito = sum(isnull(hi_credito,0)),
             @w_debito = sum(isnull(hi_debito,0))
      from cb_cuenta, cob_conta_his..cb_hist_saldo
      where cu_empresa = @i_empresa
      and cu_cuenta = @i_cuenta
      and hi_corte = @w_corte
      and hi_periodo = @w_periodo
      and hi_oficina in (select je_oficina from cb_oficina_saldo_tmp o where o.sp_id = @sp_id and o.s_term = @s_term)
      and hi_area in (select ja_area from cb_area_saldo_tmp a where a.sp_id = @sp_id and a.s_term = @s_term)
      and hi_cuenta = @i_cuenta
      and hi_empresa = @i_empresa
      group by cu_nombre, cu_cuenta

      select @w_credito1 = sum(isnull(hi_credito,0)),
             @w_debito1 = sum(isnull(hi_debito,0)),
             @w_saldo1 = sum(isnull(hi_saldo,0))
      from cob_conta_his..cb_hist_saldo
      where hi_corte = @w_corte1
      and hi_periodo = @w_periodo1
      and hi_oficina in (select je_oficina from cb_oficina_saldo_tmp o where o.sp_id = @sp_id and o.s_term = @s_term)
      and hi_area in (select ja_area from cb_area_saldo_tmp a where a.sp_id = @sp_id and a.s_term = @s_term)
      and hi_cuenta = @i_cuenta
      and hi_empresa = @i_empresa

      select @w_cuenta,
             @w_nombre,
             @w_saldo1,
             @w_debito-@w_debito1,
             @w_credito-@w_credito1,
             @w_saldo,
             @w_debito1,
             @w_credito1
   end
end

if @i_operacion = 'A'
   begin
       select (1) from cb_plan_general
		where pg_empresa = @i_empresa and
		      pg_oficina = @i_oficina and
		      pg_area = @i_area       and
		      pg_cuenta  = @i_cuenta
       if @@rowcount = 0
       begin
	    /* 'Cuenta consultada no existe    ' */
	    exec cobis..sp_cerror
	    @t_debug = @t_debug,
	    @t_file	 = @t_file,
	    @t_from	 = @w_sp_name,
	    @i_num	 = 601028
	    return 1
       end

	set rowcount 20
	if @i_modo = 0
	begin
		select  'Corte' = convert(char(10),co_fecha_fin,
                                  @i_formato_fecha),
                        'Saldo' = hi_saldo
                from cob_conta_his..cb_hist_saldo,cob_conta..cb_corte
                where
                        co_empresa = @i_empresa and
                        co_periodo = @i_periodo and
                        co_corte > 0 and
                        hi_empresa = @i_empresa and
                        hi_periodo = @i_periodo and
                        hi_corte = co_corte and
                        hi_oficina = @i_oficina and
                        hi_area    = @i_area and
                        hi_cuenta = @i_cuenta
                        order by co_fecha_fin

                if @@rowcount = 0
                begin
                           return 1
                end
	end
	if @i_modo = 1
        begin
                select  'Corte' = convert(char(10),co_fecha_fin,
                                          @i_formato_fecha),
                        'Saldo' = hi_saldo
                from cob_conta_his..cb_hist_saldo,cob_conta..cb_corte
                where
                        co_empresa = @i_empresa and
                        co_periodo = @i_periodo and
                        co_corte > 0 and
                        co_fecha_fin > @i_fecha_fin and
                        hi_empresa = @i_empresa and
                        hi_periodo = @i_periodo and
                        hi_corte = co_corte and
                        hi_oficina = @i_oficina and
                        hi_area = @i_area and
                        hi_cuenta = @i_cuenta and
                        hi_periodo = co_periodo
                        order by co_fecha_fin

                if @@rowcount = 0
                begin
                           return 1
		end
	end
	if @i_modo = 2
        begin
                select  'Corte' = convert(char(10),co_fecha_fin,
                                  @i_formato_fecha),
                        'Saldo' = sa_saldo
                from cob_conta..cb_saldo,cob_conta..cb_corte
                where
                        co_empresa = @i_empresa and
                        co_periodo = @i_periodo and
                        co_corte > 0 and
                        sa_empresa = @i_empresa and
                        sa_periodo = @i_periodo and
                        sa_corte = co_corte and
                        sa_oficina = @i_oficina and
                        sa_area    = @i_area and
                        sa_cuenta = @i_cuenta
                        order by co_fecha_fin

                if @@rowcount = 0
                begin
 		/*'No existen Saldos para Cuenta Especificada'*/
                           exec cobis..sp_cerror
                           @t_debug = @t_debug,
                           @t_file       = @t_file,
                           @t_from       = @w_sp_name,
                           @i_num        = 601065
                           return 1
                end
        end
end

if @i_operacion = 'C' or @i_operacion = 'S'
begin
   select @i_cuenta1 = isnull(@i_cuenta1, '')

   set rowcount 20

   select @w_corte = co_corte,
          @w_periodo = co_periodo,
          @w_estado = co_estado
   from cob_conta..cb_corte
   where @i_fecha_fin between co_fecha_ini and co_fecha_fin and
         co_empresa = @i_empresa

   set rowcount 0

   declare cur_cuentas cursor
   for select cu_cuenta, cu_descripcion, cu_categoria
       from cb_cuenta shared
       where cu_empresa = @i_empresa and 
       cu_cuenta like @i_cuenta and
       cu_cuenta > @i_cuenta1 and
       (cu_nivel_cuenta = @i_nivel_cuenta or @i_nivel_cuenta is null)
       order by cu_cuenta
   for read only

   open cur_cuentas

   fetch cur_cuentas
   into @w_cuenta, @w_descripcion, @w_categoria

   select @w_registros = 0

   while (@@fetch_status = 0) and (@w_registros < 20)
   begin    
      -- Consultar e Insertar

         if @i_operacion = 'C'
            if @w_estado = 'A'
               select @w_saldo_mn = sum(sa_saldo),
                      @w_saldo_me = sum(sa_saldo_me)
               from cob_conta..cb_saldo --(index cb_saldo_Key)
               where sa_corte = @w_corte and
                     sa_periodo = @w_periodo and
                     sa_oficina >= 0 and
                     sa_oficina in (select je_oficina from cb_oficina_saldo_tmp o where o.sp_id = @sp_id and o.s_term = @s_term) and 
                     sa_area >=0 and
                     sa_area in (select ja_area from cb_area_saldo_tmp a where a.sp_id = @sp_id and a.s_term = @s_term) and 
                     sa_cuenta = @w_cuenta and
                     sa_empresa = @i_empresa
            else
               select @w_saldo_mn = sum(hi_saldo),
                      @w_saldo_me = sum(hi_saldo_me)
               from cob_conta_his..cb_hist_saldo-- (index cb_hist_saldo_Key)
               where hi_corte = @w_corte and
                     hi_periodo = @w_periodo and
                     hi_oficina >= 0 and 
                     hi_oficina in (select je_oficina from cb_oficina_saldo_tmp o where o.sp_id = @sp_id and o.s_term = @s_term) and 
                     hi_area >= 0 and
                     hi_area in (select ja_area from cb_area_saldo_tmp a where a.sp_id = @sp_id and a.s_term = @s_term) and 
                     hi_cuenta = @w_cuenta and
                     hi_empresa = @i_empresa

         if @i_operacion = 'S'
            if @w_estado = 'A'
               select @w_saldo_mn = sum(sa_saldo),
                      @w_saldo_me = sum(sa_saldo_me)
               from cob_conta..cb_saldo
               where sa_corte = @w_corte and
                     sa_periodo = @w_periodo and
                     sa_oficina = @i_oficina and
                     sa_area = @i_area and
                     sa_cuenta = @w_cuenta and
                     sa_empresa = @i_empresa
            else
               select @w_saldo_mn = sum(hi_saldo),
                      @w_saldo_me = sum(hi_saldo_me)
               from cob_conta_his..cb_hist_saldo --(index cb_hist_saldo_Key)
               where hi_corte = @w_corte and
                     hi_periodo = @w_periodo and
                     hi_oficina = @i_oficina and
                     hi_area = @i_area and
                     hi_cuenta = @w_cuenta and
                     hi_empresa = @i_empresa

         if @w_saldo_mn is not null or @w_saldo_me is not null
         begin
            insert into cb_saldo_tmp values(@sp_id, @s_term, @w_cuenta, @w_descripcion, @w_saldo_mn, @w_saldo_me, @w_categoria)
   
            select @w_registros = @w_registros + 1
         end

         select @w_cuenta_ant = @w_cuenta,
                @w_descripcion_ant = @w_descripcion,
                @w_categoria_ant = @w_categoria

      fetch cur_cuentas
      into @w_cuenta,
           @w_descripcion,
           @w_categoria
   end
   close cur_cuentas
   deallocate cur_cuentas

   select 'Cuenta' = cuenta,
          'Nombre Cuenta'= nombre_cuenta,
          'Saldo MN' = saldo_mn,
          'Saldo ME' = saldo_me, 
          'Naturaleza' = naturaleza
   from cb_saldo_tmp
   where sp_id = @sp_id
   and s_term = @s_term
   order by cuenta

   if @@rowcount = 0
   begin -- 'No existen Saldos para la Cuenta Especificada' */
      exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 601065
      return 1
   end
end

if @i_operacion = 'Q' /* FS001 */
   begin

	/* encuentra el periodo en que se trabaja  la cuenta */
	select @w_periodo = pe_periodo
	from cob_conta..cb_periodo
	where	pe_empresa = @i_empresa and  
		datepart(yy, pe_fecha_inicio) = datepart(yy, @i_fecha)

	/* encuentra el corte a que corresponde la cuenta */
	select @w_corte = max(co_corte)
	from cob_conta..cb_corte
	where co_empresa = @i_empresa and
		co_periodo = @w_periodo and
		datepart(mm, co_fecha_fin) = datepart(mm, @i_fecha) and
		datepart(dd, co_fecha_fin) = datepart(dd, @i_fecha) 

	/* encuentra el saldo acumulado de la cuenta en el periodo correspondiente */	

/* OJE010 cambio de uso de cb_saldo a ct_saldo_tercero */

	select @w_saldoacum = st_saldo,
	       @w_debito = st_mov_debito,
	       @w_credito = st_mov_credito
        from cob_conta_tercero..ct_saldo_tercero 
        where st_empresa = @i_empresa and
                st_periodo = @w_periodo and
                st_oficina = @i_oficina and
                st_cuenta = @i_cuenta and
                st_corte = @w_corte		

	/* Trae los saldos del mes anterior */
	/* si el mes es febrero en adelante */
	if datepart(mm, @i_fecha) > 1
	begin
		/* encuentra el corte anterior */
		select @w_corte = max(co_corte)
		from cob_conta..cb_corte
		where co_empresa = @i_empresa and
		      co_periodo = @w_periodo and
		      datepart(mm, co_fecha_fin) = (datepart(mm, @i_fecha)-1) 

		select @w_saldoacum1 = hi_saldo,
	               @w_debito1 = hi_debito,
	       	       @w_credito1 = hi_credito
        	from cob_conta_his..cb_hist_saldo
        	where hi_empresa = @i_empresa and
               	      hi_periodo = @w_periodo and
                      hi_oficina = @i_oficina and
                      hi_cuenta = @i_cuenta and
                      hi_corte = @w_corte

		select @w_saldoacum, @w_debito, @w_credito, @w_saldoacum1, @w_debito1, @w_credito1
	end
	/* Si el mes es Enero */
	else
	begin
		select @w_saldoacum, @w_debito, @w_credito, @w_saldoacum, @w_debito, @w_credito
	end
end

-- I - consulta de movimientos para impuestos
-- P - retorna el saldo mensual y el acumulado de la cuenta en el anio dado

if @i_operacion in ('E', 'I', 'P')
begin
   set rowcount 0

   select @w_nombre = cu_nombre
   from cb_cuenta
   where cu_cuenta = @i_cuenta
   and cu_empresa = @i_empresa

   select @w_saldo = 0

   declare cur_cuentas cursor
   for select cu_cuenta
       from cb_cuenta
       where cu_empresa = @i_empresa and 
       cu_cuenta like @i_cuenta + '%'
   for read only

   open cur_cuentas

   fetch cur_cuentas
   into @w_cuenta

   while @@fetch_status = 0
   begin    
      if @i_operacion = 'E'
          select @w_saldo_aux = sum(hi_saldo)
          from  cob_conta_his..cb_hist_saldo
          where hi_corte = @w_corte
            and hi_periodo = @w_periodo
            and hi_oficina in (select je_oficina from cb_oficina_saldo_tmp o where o.sp_id = @sp_id and o.s_term = @s_term)
            and hi_area in (select ja_area from cb_area_saldo_tmp a where a.sp_id = @sp_id and a.s_term = @s_term)
            and hi_cuenta = @w_cuenta
            and hi_empresa = @i_empresa

      if @i_operacion = 'I'
         select @w_saldo_aux = sum(sa_credito)
         from cob_conta_tercero..ct_sasiento -- (index ct_sasiento_AKey1)
         where sa_cuenta = @w_cuenta
         and (sa_fecha_tran >= @i_fecha_ant and sa_fecha_tran <= @i_fecha)
         and sa_oficina_dest in (select je_oficina from cb_oficina_saldo_tmp o where o.sp_id = @sp_id and o.s_term = @s_term)
         and sa_area_dest in (select ja_area from cb_area_saldo_tmp a where a.sp_id = @sp_id and a.s_term = @s_term)
         and sa_empresa = @i_empresa
      
      if @i_operacion = 'P'
         select @w_saldo_aux = sum(st_saldo)
         from cob_conta_tercero..ct_saldo_tercero -- (index ct_saldo_tercero_Key)
         where st_corte   = @w_corte
         and st_periodo = @w_periodo
         and st_cuenta = @w_cuenta
         and st_oficina in (select je_oficina from cb_oficina_saldo_tmp o where o.sp_id = @sp_id and o.s_term = @s_term)
         and st_area in (select ja_area from cb_area_saldo_tmp a where a.sp_id = @sp_id and a.s_term = @s_term)
         and st_empresa = @i_empresa

      select @w_saldo = @w_saldo + isnull(@w_saldo_aux,0)

      fetch cur_cuentas
      into @w_cuenta
   end

   close cur_cuentas
   deallocate cur_cuentas

   /* Retorna datos a EXCEL */

   select @w_saldoacum = @w_saldo

   select @w_nombre,
          @w_saldoacum, 
          @w_saldo  /*,(@w_saldoacum - @w_saldo) */

end


if @i_operacion = 'X'
begin

select 	@w_corte = co_corte, 
	@w_periodo = co_periodo,
	@w_estado_corte = co_estado
from 	cb_corte
where 	co_empresa = @i_empresa and
      	co_fecha_ini <= @i_fecha_ant and
      	co_fecha_fin >= @i_fecha_ant      	


	select @w_saldo1 = isnull(sum(hi_saldo),0)
	from cob_conta_his..cb_hist_saldo
	where hi_empresa = @i_empresa 
	and   hi_periodo = @w_periodo
	and   hi_corte   = @w_corte
	and   hi_cuenta  = @i_cuenta 
    --and   hi_oficina = 9000


select 	@w_corte = co_corte, 
	@w_periodo = co_periodo,
	@w_estado_corte = co_estado
  from 	cb_corte
where 	co_empresa = @i_empresa and
      	co_fecha_ini <= @i_fecha and
      	co_fecha_fin >= @i_fecha      	

	select @w_saldo2 = isnull(sum(hi_saldo),0)
	from cob_conta_his..cb_hist_saldo
	where hi_empresa = @i_empresa 
	and   hi_periodo = @w_periodo
	and   hi_corte   = @w_corte
	and   hi_cuenta  = @i_cuenta 
        --and   hi_oficina = 9000


	select 	@w_saldo = @w_saldo2 - @w_saldo1	
	select 	@w_saldo

end

if @i_operacion = 'Y'
begin

	select @w_fecha_ant = dateadd(dd, -1,@i_fecha_ant)


	select @w_corte_ant = co_corte, 
	       @w_periodo_ant = co_periodo
  	from cb_corte
	where co_empresa = @i_empresa 
      	  and co_fecha_ini <= @w_fecha_ant 
      	  and co_fecha_fin >= @w_fecha_ant


	select  @w_max_corte = max(co_corte)
	from cb_corte
        where co_empresa = @i_empresa
          and co_periodo = @w_periodo_ant


        if @w_corte_ant = @w_max_corte
           select @w_corte_ant = @w_max_corte + 1	


        if @i_modo = 0
        begin

    	     select @w_saldo_ant = sum(hi_saldo)
   	     from cob_conta_his..cb_hist_saldo
   	     where hi_empresa = @i_empresa 
	       and hi_periodo = @w_periodo_ant
	       and hi_corte   = @w_corte_ant
    	       and hi_cuenta  = @i_cuenta


  	     select @w_saldo = sum(hi_saldo)
	     from cob_conta_his..cb_hist_saldo
	     where hi_empresa = @i_empresa 
  	       and hi_periodo = @w_periodo
	       and hi_corte   = @w_corte
	       and hi_cuenta  = @i_cuenta 


   	     select @w_saldo = case substring(@i_cuenta,1,1)
                                 when '2' then isnull(@w_saldo,0)
                                 else isnull(@w_saldo,0) - isnull(@w_saldo_ant,0) 
                               end
                          
   	     select @w_saldo
        end
     
        if @i_modo = 1
        begin 

    	     select @i_oficina,
                    (select substring(of_descripcion,1,30)
                     from cob_conta..cb_oficina
                     where of_empresa = @i_empresa
                       and of_oficina = @i_oficina),
                    @i_cuenta,
                    (select substring(cu_nombre,1,30)
                     from cob_conta..cb_cuenta
                     where cu_empresa = @i_empresa
                       and cu_cuenta  = @i_cuenta),               
                    isnull(sum(hi_saldo),0),  (select isnull(sum(hi_saldo),0)
   	                                       from cob_conta_his..cb_hist_saldo
           	                               where hi_empresa = @i_empresa 
 	                                         and hi_periodo = @w_periodo_ant
	                                         and hi_corte   = @w_corte_ant
      	                                         and hi_cuenta  = @i_cuenta
                                                 and hi_oficina = @i_oficina)
   	     from cob_conta_his..cb_hist_saldo
	     where hi_empresa = @i_empresa 
  	       and hi_periodo = @w_periodo
	       and hi_corte   = @w_corte
	       and hi_cuenta  = @i_cuenta 
               and hi_oficina = @i_oficina

        end

end


if @i_operacion = 'Z' --Consulta de saldos excel, Anexo IVA
begin
     --determina las fechas, final, inicial e intermedia de un bimestre
     select @w_fecha = dateadd(dd,-datepart(dd,dateadd(mm,1,@i_fecha)),dateadd(mm,1,@i_fecha)),
            @w_fecha_ant = dateadd(dd,-datepart(dd,dateadd(dd,-datepart(dd,@i_fecha),@i_fecha)),dateadd(dd,-datepart(dd,@i_fecha),@i_fecha)),
            @w_fecha_mid = dateadd(dd,-datepart(dd,@i_fecha),@i_fecha)

     set rowcount 20

     if @i_modo < 10 
     begin     
        
        if @i_modo = 0
           select @i_cuenta1 = null
          
        insert into cb_cuenta_saldo_tmp
        select sp_id = @sp_id,
               s_term = @s_term,
               cu_cuenta, 
               cu_nombre, 
               cu_movimiento
        from cob_conta..cb_cuenta
        where cu_empresa = @i_empresa
          and cu_cuenta like @i_cuenta
          and (cu_cuenta  > @i_cuenta1 or @i_cuenta1 is null)

        select @w_periodo = co_periodo,
               @w_corte   = co_corte
        from cob_conta..cb_corte
        where co_empresa   = @i_empresa
          and co_fecha_ini = @w_fecha

        select @w_periodo_ant = co_periodo,
               @w_corte_ant   = co_corte
        from cob_conta..cb_corte
        where co_empresa   = @i_empresa
          and co_fecha_ini = @w_fecha_ant

        select @w_periodo_mid = co_periodo,
               @w_corte_mid   = co_corte
        from cob_conta..cb_corte
        where co_empresa   = @i_empresa
          and co_fecha_ini = @w_fecha_mid
     end

     if @i_modo = 0 
     begin


     select 
       'Cuenta '   = cu_cuenta,
       'Nombre '   = (select substring(cu_nombre,1,40)
                     from cob_conta..cb_cuenta
                     where cu_empresa = @i_empresa
                       and cu_cuenta  = a.cu_cuenta),            
       'Mes1   '   = case substring(cu_cuenta,1,1)        -- Para las cuentas 4 determina el movimiento, 
                        when '4' then                     -- para las demas cuentas unicamente el saldo
                           isnull((select sum(isnull(hi_saldo,0))
                                   from cob_conta_his..cb_hist_saldo,
                                        cob_conta..cb_jerarquia
                                   where hi_empresa = @i_empresa
                                     and hi_periodo = @w_periodo_mid
                                     and hi_corte   = @w_corte_mid
                                     and hi_oficina = je_oficina
                                     and hi_cuenta  = a.cu_cuenta
                                     and je_empresa = hi_empresa
                                     and je_oficina_padre = @i_oficina),0) - 
                           isnull((select sum(isnull(hi_saldo,0))
                                   from cob_conta_his..cb_hist_saldo,
                                        cob_conta..cb_jerarquia
                                   where hi_empresa = @i_empresa
                                     and hi_periodo = @w_periodo_ant
                                     and hi_corte   = @w_corte_ant
                                     and hi_oficina = je_oficina
                                     and hi_cuenta  = a.cu_cuenta
                                     and je_empresa = hi_empresa
                                     and je_oficina_padre = @i_oficina),0)
                        else
                           isnull((select sum(isnull(hi_saldo,0))
                            from cob_conta_his..cb_hist_saldo,
                                 cob_conta..cb_jerarquia
                            where hi_empresa = @i_empresa
                              and hi_periodo = @w_periodo_mid
                              and hi_corte   = @w_corte_mid
                              and hi_oficina = je_oficina
                              and hi_cuenta  = a.cu_cuenta
                              and je_empresa = hi_empresa
                              and je_oficina_padre = @i_oficina),0)  
                     end,
       'Mes2   '   = case substring(cu_cuenta,1,1)
                       when '4' then 
                          sum(isnull(hi_saldo,0)) - 
                          isnull((select sum(isnull(hi_saldo,0))
                                  from cob_conta_his..cb_hist_saldo,
                                       cob_conta..cb_jerarquia
                                  where hi_empresa = @i_empresa
                                    and hi_periodo = @w_periodo_mid
                                    and hi_corte   = @w_corte_mid
                                    and hi_oficina = je_oficina
                                    and hi_cuenta  = a.cu_cuenta
                                    and je_empresa = hi_empresa
                                    and je_oficina_padre = @i_oficina),0)
                       else
                          sum(isnull(hi_saldo,0))
                     end,
       'Bimes  '   = case substring(cu_cuenta,1,1)
                       when '4' then
                          sum(isnull(hi_saldo,0)) - 
                          isnull((select sum(isnull(hi_saldo,0))
                                  from cob_conta_his..cb_hist_saldo,
                                       cob_conta..cb_jerarquia
                                  where hi_empresa = @i_empresa
                                    and hi_periodo = @w_periodo_ant
                                    and hi_corte   = @w_corte_ant
                                    and hi_oficina = je_oficina
                                    and hi_cuenta  = a.cu_cuenta
                                    and je_empresa = hi_empresa
                                    and je_oficina_padre = @i_oficina),0)
                        else
                          sum(isnull(hi_saldo,0))
                      end,
       'San A  '    = case substring(cu_cuenta,1,1)
                        when '4' then
                           isnull((select sum(isnull(hi_saldo,0))
                                   from cob_conta_his..cb_hist_saldo,
                                        cob_conta..cb_jerarquia
                                   where hi_empresa = @i_empresa
                                     and hi_periodo = @w_periodo
                                     and hi_corte   = @w_corte
                                     and hi_oficina = je_oficina
                                     and hi_cuenta  = a.cu_cuenta
                                     and je_empresa = hi_empresa
                                     and je_oficina_padre = 8103),0) - 
                            isnull((select sum(isnull(hi_saldo,0))
                                    from cob_conta_his..cb_hist_saldo,
                                         cob_conta..cb_jerarquia
                                    where hi_empresa = @i_empresa
                                      and hi_periodo = @w_periodo_ant
                                      and hi_corte   = @w_corte_ant
                                      and hi_oficina = je_oficina
                                      and hi_cuenta  = a.cu_cuenta
                                      and je_empresa = hi_empresa
                                      and je_oficina_padre = 8103),0)
                         else 
                           isnull((select sum(isnull(hi_saldo,0))
                                   from cob_conta_his..cb_hist_saldo,
                                        cob_conta..cb_jerarquia
                                   where hi_empresa = @i_empresa
                                     and hi_periodo = @w_periodo
                                     and hi_corte   = @w_corte
                                     and hi_oficina = je_oficina
                                     and hi_cuenta  = a.cu_cuenta
                                     and je_empresa = hi_empresa
                                     and je_oficina_padre = 8103),0)
                       end,
       'Provi  '    =  case substring(cu_cuenta,1,1)
                          when '4' then 
                             isnull((select sum(isnull(hi_saldo,0))
                                     from cob_conta_his..cb_hist_saldo,
                                          cob_conta..cb_jerarquia
                                     where hi_empresa = @i_empresa
                                       and hi_periodo = @w_periodo
                                       and hi_corte   = @w_corte
                                       and hi_oficina = je_oficina
                                       and hi_cuenta  = a.cu_cuenta
                                       and je_empresa = hi_empresa
                                       and je_oficina_padre = 8110),0) - 
                             isnull((select sum(isnull(hi_saldo,0))
                                     from cob_conta_his..cb_hist_saldo,
                                          cob_conta..cb_jerarquia
                                     where hi_empresa = @i_empresa
                                       and hi_periodo = @w_periodo_ant
                                       and hi_corte   = @w_corte_ant
                                       and hi_oficina = je_oficina
                                       and hi_cuenta  = a.cu_cuenta
                                       and je_empresa = hi_empresa
                                       and je_oficina_padre = 8110),0)
                          else
                             isnull((select sum(isnull(hi_saldo,0))
                                     from cob_conta_his..cb_hist_saldo,
                                          cob_conta..cb_jerarquia
                                     where hi_empresa = @i_empresa
                                       and hi_periodo = @w_periodo
                                       and hi_corte   = @w_corte
                                       and hi_oficina = je_oficina
                                       and hi_cuenta  = a.cu_cuenta
                                       and je_empresa = hi_empresa
                                       and je_oficina_padre = 8110),0)
                       end,
       'Letic  '    =  case substring(cu_cuenta,1,1)
                          when '4' then 
                             isnull((select sum(isnull(hi_saldo,0))
                                     from cob_conta_his..cb_hist_saldo,
                                          cob_conta..cb_jerarquia
                                     where hi_empresa = @i_empresa
                                       and hi_periodo = @w_periodo
                                       and hi_corte   = @w_corte
                                       and hi_oficina = je_oficina
                                       and hi_cuenta  = a.cu_cuenta
                                       and je_empresa = hi_empresa
                                       and je_oficina_padre = 7103),0) - 
                             isnull((select sum(isnull(hi_saldo,0))
                                     from cob_conta_his..cb_hist_saldo,
                                          cob_conta..cb_jerarquia
                                     where hi_empresa = @i_empresa
                                       and hi_periodo = @w_periodo_ant
                                       and hi_corte   = @w_corte_ant
                                       and hi_oficina = je_oficina
                                       and hi_cuenta  = a.cu_cuenta
                                       and je_empresa = hi_empresa
                                       and je_oficina_padre = 7103),0)
                          else
                             isnull((select sum(isnull(hi_saldo,0))
                                     from cob_conta_his..cb_hist_saldo,
                                          cob_conta..cb_jerarquia
                                     where hi_empresa = @i_empresa
                                       and hi_periodo = @w_periodo
                                       and hi_corte   = @w_corte
                                       and hi_oficina = je_oficina
                                       and hi_cuenta  = a.cu_cuenta
                                       and je_empresa = hi_empresa
                                       and je_oficina_padre = 7103),0)
                       end,
       'Movimiento'  = cu_movimiento
       from cob_conta_his..cb_hist_saldo
       left outer join cb_cuenta_saldo_tmp a on
              cu_cuenta = hi_cuenta
       where sp_id =  @sp_id
         and s_term = @s_term
         and hi_empresa = @i_empresa
         and hi_periodo = @w_periodo
         and hi_corte   = @w_corte
         and hi_oficina in (select je_oficina
                            from cob_conta..cb_jerarquia
                            where je_empresa = @i_empresa
                              and je_oficina_padre = @i_oficina)
       group by cu_cuenta, cu_nombre, cu_movimiento


     end


     if @i_modo = 1   
     begin

     select 
       'Cuenta '   = cu_cuenta,
       'Nombre '   = (select substring(cu_nombre,1,40)
                     from cob_conta..cb_cuenta
                     where cu_empresa = @i_empresa
                       and cu_cuenta  = a.cu_cuenta),            
       'Mes1   '   = case substring(cu_cuenta,1,1)
                        when '4' then
                           isnull((select sum(isnull(hi_saldo,0))
                                   from cob_conta_his..cb_hist_saldo,
                                        cob_conta..cb_jerarquia
                                   where hi_empresa = @i_empresa
                                     and hi_periodo = @w_periodo_mid
                                     and hi_corte   = @w_corte_mid
                                     and hi_oficina = je_oficina
                                     and hi_cuenta  = a.cu_cuenta
                                     and je_empresa = hi_empresa
                                     and je_oficina_padre = @i_oficina),0) - 
                           isnull((select sum(isnull(hi_saldo,0))
                                   from cob_conta_his..cb_hist_saldo,
                                        cob_conta..cb_jerarquia
                                   where hi_empresa = @i_empresa
                                     and hi_periodo = @w_periodo_ant
                                     and hi_corte   = @w_corte_ant
                                     and hi_oficina = je_oficina
                                     and hi_cuenta  = a.cu_cuenta
                                     and je_empresa = hi_empresa
                                     and je_oficina_padre = @i_oficina),0)
                        else
                           isnull((select sum(isnull(hi_saldo,0))
                            from cob_conta_his..cb_hist_saldo,
                                 cob_conta..cb_jerarquia
                            where hi_empresa = @i_empresa
                              and hi_periodo = @w_periodo_mid
                              and hi_corte   = @w_corte_mid
                              and hi_oficina = je_oficina
                              and hi_cuenta  = a.cu_cuenta
                              and je_empresa = hi_empresa
                              and je_oficina_padre = @i_oficina),0)  
                     end,
       'Mes2   '   = case substring(cu_cuenta,1,1)
                       when '4' then 
                          sum(isnull(hi_saldo,0)) - 
                          isnull((select sum(isnull(hi_saldo,0))
                                  from cob_conta_his..cb_hist_saldo,
                                       cob_conta..cb_jerarquia
                                  where hi_empresa = @i_empresa
                                    and hi_periodo = @w_periodo_mid
                                    and hi_corte   = @w_corte_mid
                                    and hi_oficina = je_oficina
                                    and hi_cuenta  = a.cu_cuenta
                                    and je_empresa = hi_empresa
                                    and je_oficina_padre = @i_oficina),0)
                       else
                          sum(isnull(hi_saldo,0))
                     end,
       'Bimes  '   = case substring(cu_cuenta,1,1)
                       when '4' then
                          sum(isnull(hi_saldo,0)) - 
                          isnull((select sum(isnull(hi_saldo,0))
                                  from cob_conta_his..cb_hist_saldo,
                                       cob_conta..cb_jerarquia
                                  where hi_empresa = @i_empresa
                                    and hi_periodo = @w_periodo_ant
                                    and hi_corte   = @w_corte_ant
                                    and hi_oficina = je_oficina
                                    and hi_cuenta  = a.cu_cuenta
                                    and je_empresa = hi_empresa
                                    and je_oficina_padre = @i_oficina),0)
                        else
                          sum(isnull(hi_saldo,0))
                      end,
       'San A  '    = case substring(cu_cuenta,1,1)
                        when '4' then
                           isnull((select sum(isnull(hi_saldo,0))
                                   from cob_conta_his..cb_hist_saldo,
                                        cob_conta..cb_jerarquia
                                   where hi_empresa = @i_empresa
                                     and hi_periodo = @w_periodo
                                     and hi_corte   = @w_corte
                                     and hi_oficina = je_oficina
                                     and hi_cuenta  = a.cu_cuenta
                                     and je_empresa = hi_empresa
                                     and je_oficina_padre = 8103),0) - 
                            isnull((select sum(isnull(hi_saldo,0))
                                    from cob_conta_his..cb_hist_saldo,
                                         cob_conta..cb_jerarquia
                                    where hi_empresa = @i_empresa
                                      and hi_periodo = @w_periodo_ant
                                      and hi_corte   = @w_corte_ant
                                      and hi_oficina = je_oficina
                                      and hi_cuenta  = a.cu_cuenta
                                      and je_empresa = hi_empresa
                                      and je_oficina_padre = 8103),0)
                         else 
                           isnull((select sum(isnull(hi_saldo,0))
                                   from cob_conta_his..cb_hist_saldo,
                                        cob_conta..cb_jerarquia
                                   where hi_empresa = @i_empresa
                                     and hi_periodo = @w_periodo
                                     and hi_corte   = @w_corte
                                     and hi_oficina = je_oficina
                                     and hi_cuenta  = a.cu_cuenta
                                     and je_empresa = hi_empresa
                                     and je_oficina_padre = 8103),0)
                       end,
       'Provi  '    =  case substring(cu_cuenta,1,1)
                          when '4' then 
                             isnull((select sum(isnull(hi_saldo,0))
                                     from cob_conta_his..cb_hist_saldo,
                                          cob_conta..cb_jerarquia
                                     where hi_empresa = @i_empresa
                                       and hi_periodo = @w_periodo
                                       and hi_corte   = @w_corte
                                       and hi_oficina = je_oficina
                                       and hi_cuenta  = a.cu_cuenta
                                       and je_empresa = hi_empresa
                                       and je_oficina_padre = 8110),0) - 
                             isnull((select sum(isnull(hi_saldo,0))
                                     from cob_conta_his..cb_hist_saldo,
                                          cob_conta..cb_jerarquia
                                     where hi_empresa = @i_empresa
                                       and hi_periodo = @w_periodo_ant
                                       and hi_corte   = @w_corte_ant
                                       and hi_oficina = je_oficina
                                       and hi_cuenta  = a.cu_cuenta
                                       and je_empresa = hi_empresa
                                       and je_oficina_padre = 8110),0)
                          else
                             isnull((select sum(isnull(hi_saldo,0))
                                     from cob_conta_his..cb_hist_saldo,
                                          cob_conta..cb_jerarquia
                                     where hi_empresa = @i_empresa
                                       and hi_periodo = @w_periodo
                                       and hi_corte   = @w_corte
                                       and hi_oficina = je_oficina
                                       and hi_cuenta  = a.cu_cuenta
                                       and je_empresa = hi_empresa
                                       and je_oficina_padre = 8110),0)
                       end,
       'Letic  '    =  case substring(cu_cuenta,1,1)
                          when '4' then 
                             isnull((select sum(isnull(hi_saldo,0))
                                     from cob_conta_his..cb_hist_saldo,
                                          cob_conta..cb_jerarquia
                                     where hi_empresa = @i_empresa
                                       and hi_periodo = @w_periodo
                                       and hi_corte   = @w_corte
                                       and hi_oficina = je_oficina
                                       and hi_cuenta  = a.cu_cuenta
                                       and je_empresa = hi_empresa
                                       and je_oficina_padre = 7103),0) - 
                             isnull((select sum(isnull(hi_saldo,0))
                                     from cob_conta_his..cb_hist_saldo,
                                          cob_conta..cb_jerarquia
                                     where hi_empresa = @i_empresa
                                       and hi_periodo = @w_periodo_ant
                                       and hi_corte   = @w_corte_ant
                                       and hi_oficina = je_oficina
                                       and hi_cuenta  = a.cu_cuenta
                                       and je_empresa = hi_empresa
                                       and je_oficina_padre = 7103),0)
                          else
                             isnull((select sum(isnull(hi_saldo,0))
                                     from cob_conta_his..cb_hist_saldo,
                                          cob_conta..cb_jerarquia
                                     where hi_empresa = @i_empresa
                                       and hi_periodo = @w_periodo
                                       and hi_corte   = @w_corte
                                       and hi_oficina = je_oficina
                                       and hi_cuenta  = a.cu_cuenta
                                       and je_empresa = hi_empresa
                                       and je_oficina_padre = 7103),0)
                       end,
       'Movimiento'  = cu_movimiento
       from cob_conta_his..cb_hist_saldo
       left outer join cb_cuenta_saldo_tmp a on
              cu_cuenta = hi_cuenta
       where sp_id =  @sp_id
         and s_term = @s_term
         and hi_empresa = @i_empresa
         and hi_periodo = @w_periodo
         and hi_corte   = @w_corte
         and cu_cuenta  > @i_cuenta1   
         and hi_oficina in (select je_oficina
                            from cob_conta..cb_jerarquia
                            where je_empresa = @i_empresa
                              and je_oficina_padre = @i_oficina)
       group by cu_cuenta, cu_nombre, cu_movimiento
      

     end

     if @i_modo = 10 --Consulta de los movimientos de una cuenta en un bimestre
     begin
           select @w_fecha_ant = dateadd(dd,1,@w_fecha_ant)
           
           select sa_producto,
                  (select substring(pd_descripcion,1,30)
		   from cobis..cl_producto
		   where pd_producto = a.sa_producto	
		  ),   
                  @i_cuenta1,
                  (select substring(cu_nombre,1,40)
                   from cob_conta..cb_cuenta
                   where cu_empresa = @i_empresa
                     and cu_cuenta  = @i_cuenta1),            
                  sum(sa_debito),
                  sum(sa_credito)
           from cob_conta_tercero..ct_sasiento a,
                cob_conta..cb_jerarquia
           where sa_empresa      = @i_empresa
             and sa_fecha_tran  >= @w_fecha_ant
             and sa_fecha_tran  <= @w_fecha
             and sa_cuenta       = @i_cuenta1
             and sa_oficina_dest = je_oficina
             and sa_area_dest   >= 0  
             and sa_mayorizado   ='S'
             and je_empresa      = sa_empresa
             and je_oficina_padre= @i_oficina
           group by sa_producto
      end

end




if @i_operacion = 'K'
begin

	select @w_fecha_ant = dateadd(dd, -1,@i_fecha_ant)


	select 	@w_corte_ant = co_corte, 
		@w_periodo_ant = co_periodo
  	from 	cb_corte
	where 	co_empresa = @i_empresa 
      	and	co_fecha_ini <= @w_fecha_ant 
      	and	co_fecha_fin >= @w_fecha_ant


	select  @w_max_corte = max(co_corte)
	from    cb_corte
        where   co_empresa = @i_empresa
        and     co_periodo = @w_periodo_ant


        if @w_corte_ant = @w_max_corte
	begin
        	select @w_corte_ant = @w_max_corte + 1	
	end


	select @w_saldo_ant = sum(hi_saldo)
	from cob_conta_his..cb_hist_saldo
	where hi_empresa = @i_empresa 
	and   hi_periodo = @w_periodo_ant
	and   hi_corte   = @w_corte_ant
	and   hi_cuenta  = @i_cuenta
        and   hi_oficina = @i_oficina


	select @w_saldo = sum(hi_saldo)
	from cob_conta_his..cb_hist_saldo
	where hi_empresa = @i_empresa 
	and   hi_periodo = @w_periodo
	and   hi_corte   = @w_corte
	and   hi_cuenta  = @i_cuenta 
        and   hi_oficina = @i_oficina


	select 	@w_saldo = isnull(@w_saldo,0)  - isnull(@w_saldo_ant,0)

	select 	@w_saldo

end



if @i_operacion = 'W'
begin
    select @w_corte = co_corte, 
	   @w_periodo = co_periodo,
	   @w_estado_corte = co_estado
    from cb_corte
    where co_empresa = @i_empresa
    and co_fecha_ini <= @i_fecha
    and co_fecha_fin >= @i_fecha      	

    select @w_cu_categoria  = cu_categoria 
    from cob_conta..cb_cuenta
    where cu_empresa = @i_empresa
    and cu_cuenta = @i_cuenta
 
    select @w_saldo2 = isnull(sum(hi_saldo),0)
    from cob_conta_his..cb_hist_saldo
    where hi_empresa = @i_empresa 
    and hi_periodo = @w_periodo
    and hi_corte = @w_corte
    and hi_cuenta = @i_cuenta 
    --and   hi_oficina = 9000

   if @w_cu_categoria = 'C'
   --if @w_saldo2 < 0 --para que no salgan valores negativos en la declaracion de renta
        select @w_saldo2 = @w_saldo2 * (-1)

	
	select 	round(@w_saldo2,0)

end



if @i_operacion = 'R'
begin

       select @w_nombre = cu_nombre
       from cb_cuenta
       where cu_cuenta  = @i_cuenta
         and cu_empresa = @i_empresa
	
       select @w_saldo = sum(hi_saldo) -- + sum(st_saldo_me) 
       from  cob_conta_his..cb_hist_saldo  --,  cb_cuenta
       where hi_empresa = @i_empresa
         and hi_corte   = @w_corte
         and hi_periodo = @w_periodo
         and hi_oficina in (select je_oficina 
                            from cb_jerarquia
                            where je_empresa = @i_empresa
                              and (je_oficina_padre = @i_oficina or
                                   je_oficina = @i_oficina))
         and hi_area    in (select ja_area 
                            from cb_jerararea
                            where ja_empresa = @i_empresa
                              and (ja_area_padre = @i_area or
                                   ja_area = @i_area))
         and hi_cuenta = @i_cuenta
         -- and cu_empresa = @i_empresa
         -- and cu_cuenta  = @i_cuenta
         --Group by cu_nombre

         /* Retorna datos a EXCEL */
         select @w_nombre,
                @w_saldo  /*,(@w_saldoacum - @w_saldo) */

end



if @i_operacion = 'H'
begin      

--print '*** OPERACION H ***'
--determina las fechas, final, inicial e intermedia de un bimestre
select @w_fecha      = dateadd(dd,-datepart(dd,dateadd(mm,1,@i_fecha)),dateadd(mm,1,@i_fecha)),
       @w_fecha_ant  = dateadd(dd,-datepart(dd,dateadd(dd,-datepart(dd,@i_fecha),@i_fecha)),dateadd(dd,-datepart(dd,@i_fecha),@i_fecha)),
       @w_fecha_mid  = dateadd(dd,-datepart(dd,@i_fecha),@i_fecha)
       
       
--print '*** FECHAS DE TRABAJO ***'
--print '@w_fecha FECHA DEL PROCESO:     %1!',@w_fecha
--print '@w_fecha_ant FECHA 1 MES:   %1!',@w_fecha_ant
--print '@w_fecha_mid FECHA 2 MES:  %1!',@w_fecha_mid  
--print '@w_fecha_ini FECHA INICIAL DEL BIMESTRE:    %1!',@w_fecha_ini 

if @i_modo = 0 
     BEGIN      
           if @i_modo = 0
              select @i_cuenta1 = null
              
              insert into cb_cuenta_saldo_tmp
              select sp_id = @sp_id,
                     s_term = @s_term,
                     cu_cuenta, 
                     cu_nombre, 
                     cu_movimiento
              from   cob_conta..cb_cuenta
              where  cu_empresa = @i_empresa
              and    cu_cuenta  like @i_cuenta + '%'
              and (cu_cuenta  > @i_cuenta1 or @i_cuenta1 is null)

             select @w_periodo = co_periodo,
                    @w_corte   = co_corte
             from cob_conta..cb_corte
             where co_empresa   = @i_empresa
             and   co_fecha_ini = @w_fecha

--PRINT 'PERIODO FECHA TRABAJO:   %1! ',@w_periodo
--PRINT 'CORTE FECHA TRABAJO:     %1! ',@w_corte 


             select @w_periodo_ant   = co_periodo,
                    @w_corte_ant     = co_corte
             from cob_conta..cb_corte
             where co_empresa   = @i_empresa
             and co_fecha_ini = @w_fecha_ant

--PRINT 'PERIODO FECHA MES 1:   %1! ',@w_periodo_ant
--PRINT 'CORTE FECHA MES 1:     %1! ',@w_corte_ant

             select @w_periodo_mid = co_periodo,
                    @w_corte_mid   = co_corte
             from cob_conta..cb_corte
             where co_empresa   = @i_empresa
             and co_fecha_ini = @w_fecha_mid

--PRINT 'PERIODO FECHA MES 2:   %1! ',@w_periodo_mid
--PRINT 'CORTE FECHA MES 2:     %1! ',@w_corte_mid

      
       END


      if @i_modo = 0 
      BEGIN
        
           truncate table saldoiva
           insert into saldoiva
           select 
                'Cuenta '   = cu_cuenta,
                
                'Nombre '   = (select substring(cu_nombre,1,40)
                               from cob_conta..cb_cuenta
                               where cu_empresa = @i_empresa
                               and cu_cuenta  = a.cu_cuenta),            
                'Mes1   '   = case substring(cu_cuenta,1,1)        -- Para las cuentas 4 determina el movimiento, 
                              when '4' then                     -- para las demas cuentas unicamente el saldo
                                           isnull((select sum(isnull(hi_saldo,0))
                                                   from cob_conta_his..cb_hist_saldo,
                                                        cob_conta..cb_jerarquia
                                                   where hi_empresa      = @i_empresa
                                                   and hi_periodo        = @w_periodo_mid
                                                   and hi_corte          = @w_corte_mid
                                                   and hi_oficina        = je_oficina
                                                   and hi_cuenta         = a.cu_cuenta
                                                   and je_empresa        = hi_empresa
                                                   and je_oficina_padre  = @i_oficina),0) 
                                                   
                             
                                              - -- *** RESTA ***  
                                                   
                                             isnull((select sum(isnull(hi_saldo,0))
                                                     from cob_conta_his..cb_hist_saldo,
                                                          cob_conta..cb_jerarquia
                                                     where hi_empresa     = @i_empresa
                                                     and hi_periodo       = @w_periodo_ant
                                                     and hi_corte         = @w_corte_ant
                                                     and hi_oficina       = je_oficina
                                                     and hi_cuenta        = a.cu_cuenta
                                                     and je_empresa       = hi_empresa
                                                     and je_oficina_padre = @i_oficina),0)
                                    else
                                            isnull((select sum(isnull(hi_saldo,0))
                                            from cob_conta_his..cb_hist_saldo,
                                                 cob_conta..cb_jerarquia
                                            where hi_empresa        = @i_empresa
                                            and hi_periodo          = @w_periodo_mid
                                            and hi_corte            = @w_corte_mid
                                            and hi_oficina          = je_oficina
                                            and hi_cuenta           = a.cu_cuenta
                                            and je_empresa          = hi_empresa
                                            and je_oficina_padre    = @i_oficina),0)  
                          end,
                 'Mes2   '= case substring(cu_cuenta,1,1)
                           when '4' then 
                                        sum(isnull(hi_saldo,0)) 
                                        - -- *** RESTA *** 
                                        isnull((select sum(isnull(hi_saldo,0))
                                                from cob_conta_his..cb_hist_saldo,
                                                     cob_conta..cb_jerarquia
                                                where hi_empresa      = @i_empresa
                                                and hi_periodo        = @w_periodo_mid
                                                and hi_corte          = @w_corte_mid
                                                and hi_oficina        = je_oficina
                                                and hi_cuenta         = a.cu_cuenta
                                                and je_empresa        = hi_empresa
                                                and je_oficina_padre  = @i_oficina),0)
                                   else
                                      sum(isnull(hi_saldo,0))
                       end,

                 'Bimes  '   = case substring(cu_cuenta,1,1)
                            when '4' then
                                         sum(isnull(hi_saldo,0)) 
                                         - -- *** RESTA *** 
                                         isnull((select sum(isnull(hi_saldo,0))
                                                 from cob_conta_his..cb_hist_saldo,
                                                      cob_conta..cb_jerarquia
                                                 where hi_empresa     = @i_empresa
                                                 and hi_periodo       = @w_periodo_ant
                                                 and hi_corte         = @w_corte_ant
                                                 and hi_oficina       = je_oficina
                                                 and hi_cuenta        = a.cu_cuenta
                                                 and je_empresa       = hi_empresa
                                                 and je_oficina_padre = @i_oficina),0)
                            else
                                sum(isnull(hi_saldo,0))
                      end,
       
                'San A  '= case substring(cu_cuenta,1,1)
                        when '4' then
                                     isnull((select sum(isnull(hi_saldo,0))
                                             from cob_conta_his..cb_hist_saldo,
                                                  cob_conta..cb_jerarquia
                                             where hi_empresa = @i_empresa
                                             and hi_periodo = @w_periodo
                                             and hi_corte   = @w_corte
                                             and hi_oficina = je_oficina
                                             and hi_cuenta  = a.cu_cuenta
                                             and je_empresa = hi_empresa
                                             and je_oficina_padre = 8103),0) 
                                             
                                             - -- *** RESTA ***
 
                                     isnull((select sum(isnull(hi_saldo,0))
                                             from cob_conta_his..cb_hist_saldo,
                                                  cob_conta..cb_jerarquia
                                             where hi_empresa     = @i_empresa
                                             and hi_periodo       = @w_periodo_ant
                                             and hi_corte         = @w_corte_ant
                                             and hi_oficina       = je_oficina
                                             and hi_cuenta        = a.cu_cuenta
                                             and je_empresa       = hi_empresa
                                             and je_oficina_padre = 8103),0)
                                  else 
                                     isnull((select sum(isnull(hi_saldo,0))
                                             from cob_conta_his..cb_hist_saldo,
                                                  cob_conta..cb_jerarquia
                                             where hi_empresa     = @i_empresa
                                             and hi_periodo       = @w_periodo
                                             and hi_corte         = @w_corte
                                             and hi_oficina       = je_oficina
                                             and hi_cuenta        = a.cu_cuenta
                                             and je_empresa       = hi_empresa
                                             and je_oficina_padre = 8103),0)
                      end,
                 'Provi  ' =  case substring(cu_cuenta,1,1)
                             when '4' then 
                                          isnull((select sum(isnull(hi_saldo,0))
                                          from cob_conta_his..cb_hist_saldo,
                                               cob_conta..cb_jerarquia
                                           where hi_empresa      = @i_empresa
                                           and hi_periodo        = @w_periodo
                                           and hi_corte          = @w_corte
                                           and hi_oficina        = je_oficina
                                           and hi_cuenta         = a.cu_cuenta
                                           and je_empresa        = hi_empresa
                                           and je_oficina_padre  = 8110),0) 
                                           
                                           - -- *** RESTA ***
 
                                          isnull((select sum(isnull(hi_saldo,0))
                                          from cob_conta_his..cb_hist_saldo,
                                               cob_conta..cb_jerarquia
                                          where hi_empresa      = @i_empresa
                                          and hi_periodo        = @w_periodo_ant
                                          and hi_corte          = @w_corte_ant
                                          and hi_oficina        = je_oficina
                                          and hi_cuenta         = a.cu_cuenta
                                          and je_empresa        = hi_empresa
                                          and je_oficina_padre  = 8110),0)
                                    else
                                          isnull((select sum(isnull(hi_saldo,0))
                                                  from cob_conta_his..cb_hist_saldo,
                                                       cob_conta..cb_jerarquia
                                                  where hi_empresa       = @i_empresa
                                                  and hi_periodo         = @w_periodo
                                                  and hi_corte           = @w_corte
                                                  and hi_oficina         = je_oficina
                                                  and hi_cuenta          = a.cu_cuenta
                                                  and je_empresa         = hi_empresa
                                                  and je_oficina_padre   = 8110),0)
                        end,
                 'Letic  ' =  case substring(cu_cuenta,1,1)
                                when '4' then 
                                          isnull((select sum(isnull(hi_saldo,0))
                                                  from cob_conta_his..cb_hist_saldo,
                                                       cob_conta..cb_jerarquia
                                                  where hi_empresa      = @i_empresa
                                                  and hi_periodo        = @w_periodo
                                                  and hi_corte          = @w_corte
                                                  and hi_oficina        = je_oficina
                                                  and hi_cuenta         = a.cu_cuenta
                                                  and je_empresa        = hi_empresa
                                                  and je_oficina_padre  = 7103),0) 
 
                                                  - -- *** RESTAS ***
 
                                          isnull((select sum(isnull(hi_saldo,0))
                                                  from cob_conta_his..cb_hist_saldo,
                                                       cob_conta..cb_jerarquia
                                                  where hi_empresa      = @i_empresa
                                                  and hi_periodo        = @w_periodo_ant
                                                  and hi_corte          = @w_corte_ant
                                                  and hi_oficina        = je_oficina
                                                  and hi_cuenta         = a.cu_cuenta
                                                  and je_empresa        = hi_empresa
                                                  and je_oficina_padre  = 7103),0)
                                 else
                                         isnull((select sum(isnull(hi_saldo,0))
                                                 from cob_conta_his..cb_hist_saldo,
                                                      cob_conta..cb_jerarquia
                                                 where hi_empresa       = @i_empresa
                                                 and hi_periodo         = @w_periodo
                                                 and hi_corte           = @w_corte
                                                 and hi_oficina         = je_oficina
                                                 and hi_cuenta          = a.cu_cuenta
                                                 and je_empresa         = hi_empresa
                                                 and je_oficina_padre   = 7103),0)
                          end,
                  'Movimiento '  = cu_movimiento,
      
                         'Producto  ' = null,

                         'Desproducto  ' = null

                   from cob_conta_his..cb_hist_saldo
                   left outer join cb_cuenta_saldo_tmp a on
                          cu_cuenta = hi_cuenta
                   where sp_id =  @sp_id
                     and s_term = @s_term
                     and hi_empresa = @i_empresa
                     and hi_periodo = @w_periodo
                     and hi_corte   = @w_corte
                     and hi_oficina in (select je_oficina
                                        from cob_conta..cb_jerarquia
                                        where je_empresa = @i_empresa
                                          and je_oficina_padre = @i_oficina)
                   group by cu_cuenta, cu_nombre, cu_movimiento
                    
                   -- *** ACTIALIZA CAMPOS NULL DE LA TABLA DE SALDOIVA ***
                  -- *** PRODUCTO ***
                   update cob_conta..saldoiva
                   set Producto = sa_producto 
                                  from cob_conta_tercero..ct_sasiento a,
                                       cob_conta..saldoiva b
                                  where a.sa_cuenta = b.Cuenta

                    -- *** DESCRIPCION DEL PRODUCTO ***
                    update cob_conta..saldoiva
                   set Desproducto = substring(pd_descripcion,1,30)
		                             from cobis..cl_producto a,
                                          cob_conta..saldoiva b
		                             where a.pd_producto = b.Producto
                                           
                       
                       

           END
     
     if @i_modo = 0 --Consulta de los movimientos de una cuenta en un bimestre
     begin --Consulta de los movimientos de una cuenta en un bimestre

          select @w_fecha_ant = dateadd(dd,1,@w_fecha_ant) 
          truncate table prodiva
     
          declare cuenta_cursor cursor
	      for select  Cuenta
	          from saldoiva
     	      where Movimiento = 'S'
     	      and Bimestre <> 0
	      open  cuenta_cursor
	      fetch cuenta_cursor
	      into  @i_cuenta1
          
          while(@@fetch_status = 0)
          begin -- *** CURSOR ***
                    
                select @w_fecha_ant = dateadd(dd,1,@w_fecha_ant)           
                --select @w_fecha_ant = '05/01/2004'

                insert into prodiva
                            select  
                            -- *** Cuenta  *** 
                             @i_cuenta1,
     	                    -- *** DesCuenta ***
                            /*(select substring(cu_nombre,1,40)
                             from cob_conta..cb_cuenta
                             where cu_empresa = @i_empresa
                             and cu_cuenta    = @i_cuenta1), */
                             NULL,
     	                    
                             -- *** Debitosm1 ***  
                             
                            /* isnull((select sum(isnull(hi_debito,0)) 
                                    from cob_conta_his..cb_hist_saldo
                                    where hi_empresa =  @i_empresa
                                    and   hi_cuenta  =  @i_cuenta1
                                    and   hi_corte   =  @w_corte_mid
                                    and   hi_periodo =  @w_periodo_mid),0)
                                    -  -- *** RESTA ***
                            isnull((select sum(isnull(hi_debito,0)) 
                                    from cob_conta_his..cb_hist_saldo
                                    where hi_empresa =  @i_empresa
                                    and   hi_cuenta  =  @i_cuenta1
                                    and   hi_corte   =  @w_corte_ant
                                    and   hi_periodo =  @w_periodo_ant),0),*/
                              NULL,

                             -- *** Creditosm1 *** 
                            
                             /*isnull((select sum(isnull(hi_credito,0)) 
                                    from cob_conta_his..cb_hist_saldo
                                    where hi_empresa =  @i_empresa
                                    and   hi_cuenta  =  @i_cuenta1
                                    and   hi_corte   =  @w_corte_mid
                                    and   hi_periodo =  @w_periodo_mid),0)
                                    -  -- *** RESTA ***
                             isnull((select sum(isnull(hi_credito,0)) 
                                    from cob_conta_his..cb_hist_saldo
                                    where hi_empresa =  @i_empresa
                                    and   hi_cuenta  =  @i_cuenta1
                                    and   hi_corte   =  @w_corte_ant
                                    and   hi_periodo =  @w_periodo_ant),0),*/
                             NULL,    
                             -- *** Debitosm2  *** 

                             /*isnull((select sum(isnull(hi_debito,0)) 
                                    from cob_conta_his..cb_hist_saldo
                                    where hi_empresa =  @i_empresa
                                    and   hi_cuenta  =  @i_cuenta1
                                    and   hi_corte   =  @w_corte
                                    and   hi_periodo =  @w_periodo),0)
                                    -  -- *** RESTA ***
                             isnull((select sum(isnull(hi_debito,0)) 
                                    from cob_conta_his..cb_hist_saldo
                                    where hi_empresa =  @i_empresa
                                    and   hi_cuenta  =  @i_cuenta1
                                    and   hi_corte   =  @w_corte_mid
                                    and   hi_periodo =  @w_periodo_mid),0),*/
     	                    NULL,
                             -- *** Creditosm2 ***   
                           
                             /*isnull((select sum(isnull(hi_credito,0)) 
                                    from cob_conta_his..cb_hist_saldo
                                    where hi_empresa =  @i_empresa
                                    and   hi_cuenta  =  @i_cuenta1
                                    and   hi_corte   =  @w_corte
                                    and   hi_periodo =  @w_periodo),0)
                                    -  -- *** RESTA ***
                             isnull((select sum(isnull(hi_credito,0)) 
                                    from cob_conta_his..cb_hist_saldo
                                    where hi_empresa =  @i_empresa
                                    and   hi_cuenta  =  @i_cuenta1
                                    and   hi_corte   =  @w_corte_mid
                                    and   hi_periodo =  @w_periodo_mid),0),*/
                            NULL,

                            -- *** Sandresdebm1 ***  
                           /*isnull((select sum(isnull(hi_debito,0))
                                    from cob_conta_his..cb_hist_saldo,
                                         cob_conta..cb_jerarquia
                                    where hi_empresa = @i_empresa
                                    and hi_periodo = @w_periodo_mid
                                    and hi_corte   = @w_corte_mid
                                    and hi_oficina = je_oficina
                                    and hi_cuenta  = @i_cuenta1
                                    and je_empresa = hi_empresa
                                    and je_oficina_padre = 8103),0) 
                                    - -- *** RESTA ***
                            isnull((select sum(isnull(hi_debito,0))
                                    from cob_conta_his..cb_hist_saldo,
                                         cob_conta..cb_jerarquia
                                    where hi_empresa     = @i_empresa
                                    and hi_periodo       = @w_periodo_ant
                                    and hi_corte         = @w_corte_ant
                                    and hi_oficina       = je_oficina
                                    and hi_cuenta        = @i_cuenta1
                                    and je_empresa       = hi_empresa
                                    and je_oficina_padre = 8103),0),*/
                            NULL,
                             
                            -- *** Sandrescredm1  ***
                           /*isnull((select sum(isnull(hi_credito,0))
                                    from cob_conta_his..cb_hist_saldo,
                                         cob_conta..cb_jerarquia
                                    where hi_empresa = @i_empresa
                                    and hi_periodo = @w_periodo_mid
                                    and hi_corte   = @w_corte_mid
                                    and hi_oficina = je_oficina
                                    and hi_cuenta  = @i_cuenta1
                                    and je_empresa = hi_empresa
                                    and je_oficina_padre = 8103),0) 
                                    - -- *** RESTA ***
                            isnull((select sum(isnull(hi_credito,0))
                                    from cob_conta_his..cb_hist_saldo,
                                         cob_conta..cb_jerarquia
                                    where hi_empresa     = @i_empresa
                                    and hi_periodo       = @w_periodo_ant
                                    and hi_corte         = @w_corte_ant
                                    and hi_oficina       = je_oficina
                                    and hi_cuenta        = @i_cuenta1
                                    and je_empresa       = hi_empresa
                                    and je_oficina_padre = 8103),0),*/
                             NULL,
                            
                             -- *** Sandresdebm2 ***
                             
                             /*isnull((select sum(isnull(hi_debito,0))
                                    from cob_conta_his..cb_hist_saldo,
                                         cob_conta..cb_jerarquia
                                    where hi_empresa = @i_empresa
                                    and hi_periodo = @w_periodo
                                    and hi_corte   = @w_corte
                                    and hi_oficina = je_oficina
                                    and hi_cuenta  = @i_cuenta1
                                    and je_empresa = hi_empresa
                                    and je_oficina_padre = 8103),0) 
                                    - -- *** RESTA ***
                            isnull((select sum(isnull(hi_debito,0))
                                    from cob_conta_his..cb_hist_saldo,
                                         cob_conta..cb_jerarquia
                                    where hi_empresa     = @i_empresa
                                    and hi_periodo       = @w_periodo_mid
                                    and hi_corte         = @w_corte_mid
                                    and hi_oficina       = je_oficina
                                    and hi_cuenta        = @i_cuenta1
                                    and je_empresa       = hi_empresa
                                    and je_oficina_padre = 8103),0),*/
                             NULL,

                            -- *** Sandrescredm2 ***   
                             /*isnull((select sum(isnull(hi_credito,0))
                                    from cob_conta_his..cb_hist_saldo,
                                         cob_conta..cb_jerarquia
                                    where hi_empresa = @i_empresa
                                    and hi_periodo = @w_periodo
                                    and hi_corte   = @w_corte
                                    and hi_oficina = je_oficina
                                    and hi_cuenta  = @i_cuenta1
                                    and je_empresa = hi_empresa
                                    and je_oficina_padre = 8103),0) 
                                    - -- *** RESTA ***
                            isnull((select sum(isnull(hi_credito,0))
                                    from cob_conta_his..cb_hist_saldo,
                                         cob_conta..cb_jerarquia
                                    where hi_empresa     = @i_empresa
                                    and hi_periodo       = @w_periodo_mid
                                    and hi_corte         = @w_corte_mid
                                    and hi_oficina       = je_oficina
                                    and hi_cuenta        = @i_cuenta1
                                    and je_empresa       = hi_empresa
                                    and je_oficina_padre = 8103),0),*/
                            NULL,
                            -- *** Provdebm1 ***   
                            /*
                            isnull((select sum(isnull(hi_debito,0))
                                          from cob_conta_his..cb_hist_saldo,
                                               cob_conta..cb_jerarquia
                                           where hi_empresa      = @i_empresa
                                           and hi_periodo        = @w_periodo_mid
                                           and hi_corte          = @w_corte_mid
                                           and hi_oficina        = je_oficina
                                           and hi_cuenta         = @i_cuenta1
                                           and je_empresa        = hi_empresa
                                           and je_oficina_padre  = 8110),0) 
                                           - -- *** RESTA ***
                              isnull((select sum(isnull(hi_debito,0))
                                          from cob_conta_his..cb_hist_saldo,
                                               cob_conta..cb_jerarquia
                                          where hi_empresa      = @i_empresa
                                          and hi_periodo        = @w_periodo_ant
                                          and hi_corte          = @w_corte_ant
                                          and hi_oficina        = je_oficina
                                          and hi_cuenta         = @i_cuenta1
                                          and je_empresa        = hi_empresa
                                          and je_oficina_padre  = 8110),0),*/
                                
                            NULL,
                           -- *** Provcred1  *** 

                           /*isnull((select sum(isnull(hi_credito,0))
                                          from cob_conta_his..cb_hist_saldo,
                                               cob_conta..cb_jerarquia
                                           where hi_empresa      = @i_empresa
                                           and hi_periodo        = @w_periodo_mid
                                           and hi_corte          = @w_corte_mid
                                           and hi_oficina        = je_oficina
                                           and hi_cuenta         = @i_cuenta1
                                           and je_empresa        = hi_empresa
                                           and je_oficina_padre  = 8110),0) 
                                           - -- *** RESTA ***
                             isnull((select sum(isnull(hi_credito,0))
                                          from cob_conta_his..cb_hist_saldo,
                                               cob_conta..cb_jerarquia
                                          where hi_empresa      = @i_empresa
                                          and hi_periodo        = @w_periodo_ant
                                          and hi_corte          = @w_corte_ant
                                          and hi_oficina        = je_oficina
                                          and hi_cuenta         = @i_cuenta1
                                          and je_empresa        = hi_empresa
                                          and je_oficina_padre  = 8110),0),
                           */NULL, 
                            -- *** Provdebm2  ***  
                            /*isnull((select sum(isnull(hi_debito,0))
                                          from cob_conta_his..cb_hist_saldo,
                                               cob_conta..cb_jerarquia
                                           where hi_empresa      = @i_empresa
                                           and hi_periodo        = @w_periodo
                                           and hi_corte          = @w_corte
                                           and hi_oficina        = je_oficina
                                           and hi_cuenta         = @i_cuenta1
                                           and je_empresa        = hi_empresa
                                           and je_oficina_padre  = 8110),0) 
                                           - -- *** RESTA ***
                             isnull((select sum(isnull(hi_debito,0))
                                          from cob_conta_his..cb_hist_saldo,
                                               cob_conta..cb_jerarquia
                                          where hi_empresa      = @i_empresa
                                          and hi_periodo        = @w_periodo_mid
                                          and hi_corte          = @w_corte_mid
                                          and hi_oficina        = je_oficina
                                          and hi_cuenta         = @i_cuenta1
                                          and je_empresa        = hi_empresa
                                          and je_oficina_padre  = 8110),0),
                           */
                            NULL,
                            -- *** Provcred2  ***  
                            
                            /*isnull((select sum(isnull(hi_credito,0))
                                          from cob_conta_his..cb_hist_saldo,
                                               cob_conta..cb_jerarquia
                                           where hi_empresa      = @i_empresa
                                           and hi_periodo        = @w_periodo
                                           and hi_corte          = @w_corte
                                           and hi_oficina        = je_oficina
                                           and hi_cuenta         = @i_cuenta1
                                           and je_empresa        = hi_empresa
                                           and je_oficina_padre  = 8110),0) 
                                           - -- *** RESTA ***
                             isnull((select sum(isnull(hi_credito,0))
                                          from cob_conta_his..cb_hist_saldo,
                                               cob_conta..cb_jerarquia
                                          where hi_empresa      = @i_empresa
                                          and hi_periodo        = @w_periodo_mid
                                          and hi_corte          = @w_corte_mid
                                          and hi_oficina        = je_oficina
                                          and hi_cuenta         = @i_cuenta1
                                          and je_empresa        = hi_empresa
                                          and je_oficina_padre  = 8110),0),
                           */
                            NULL,
                            -- *** letdebm1 ***  
                            /*
                            isnull((select sum(isnull(hi_debito,0))
                                                  from cob_conta_his..cb_hist_saldo,
                                                       cob_conta..cb_jerarquia
                                                  where hi_empresa      = @i_empresa
                                                  and hi_periodo        = @w_periodo_mid
                                                  and hi_corte          = @w_corte_mid
                                                  and hi_oficina        = je_oficina
                                                  and hi_cuenta         = @i_cuenta1
                                                  and je_empresa        = hi_empresa
                                                  and je_oficina_padre  = 7103),0) 
 
                                                  - -- *** RESTAS ***
 
                                          isnull((select sum(isnull(hi_debito,0))
                                                  from cob_conta_his..cb_hist_saldo,
                                                       cob_conta..cb_jerarquia
                                                  where hi_empresa      = @i_empresa
                                                  and hi_periodo        = @w_periodo_ant
                                                  and hi_corte          = @w_corte_ant
                                                  and hi_oficina        = je_oficina
                                                  and hi_cuenta         = @i_cuenta1
                                                  and je_empresa        = hi_empresa
                                                  and je_oficina_padre  = 7103),0)
                            */
                            NULL,
                            -- *** letcredm1  ***  
                              /*
                            isnull((select sum(isnull(hi_credito,0))
                                                  from cob_conta_his..cb_hist_saldo,
                                                       cob_conta..cb_jerarquia
                                                  where hi_empresa      = @i_empresa
                                                  and hi_periodo        = @w_periodo_mid
                                                  and hi_corte          = @w_corte_mid
                                                  and hi_oficina        = je_oficina
                                                  and hi_cuenta         = @i_cuenta1
                                                  and je_empresa        = hi_empresa
                                                  and je_oficina_padre  = 7103),0) 
 
                                                  - -- *** RESTAS ***
 
                                          isnull((select sum(isnull(hi_credito,0))
                                                  from cob_conta_his..cb_hist_saldo,
                                                       cob_conta..cb_jerarquia
                                                  where hi_empresa      = @i_empresa
                                                  and hi_periodo        = @w_periodo_ant
                                                  and hi_corte          = @w_corte_ant
                                                  and hi_oficina        = je_oficina
                                                  and hi_cuenta         = @i_cuenta1
                                                  and je_empresa        = hi_empresa
                                                  and je_oficina_padre  = 7103),0)
                            */
                            NULL,
                            -- *** letdebdm2  ***  
                              /*
                            isnull((select sum(isnull(hi_debito,0))
                                                  from cob_conta_his..cb_hist_saldo,
                                                       cob_conta..cb_jerarquia
                                                  where hi_empresa      = @i_empresa
                                                  and hi_periodo        = @w_periodo
                                                  and hi_corte          = @w_corte
                                                  and hi_oficina        = je_oficina
                                                  and hi_cuenta         = @i_cuenta1
                                                  and je_empresa        = hi_empresa
                                                  and je_oficina_padre  = 7103),0) 
 
                                                  - -- *** RESTAS ***
 
                                          isnull((select sum(isnull(hi_debito,0))
                                                  from cob_conta_his..cb_hist_saldo,
                                                       cob_conta..cb_jerarquia
                                                  where hi_empresa      = @i_empresa
                                                  and hi_periodo        = @w_periodo_mid
                                                  and hi_corte          = @w_corte_mid
                                                  and hi_oficina        = je_oficina
                                                  and hi_cuenta         = @i_cuenta1
                                                  and je_empresa        = hi_empresa
                                                  and je_oficina_padre  = 7103),0)
                            */
                            NULL,
                            -- *** letcredm2  ***  
                              /*
                            isnull((select sum(isnull(hi_credito,0))
                                                  from cob_conta_his..cb_hist_saldo,
                                                       cob_conta..cb_jerarquia
                                                  where hi_empresa      = @i_empresa
                                                  and hi_periodo        = @w_periodo
                                                  and hi_corte          = @w_corte
                                                  and hi_oficina        = je_oficina
                                                  and hi_cuenta         = @i_cuenta1
                                                  and je_empresa        = hi_empresa
                                                  and je_oficina_padre  = 7103),0) 
 
                                                  - -- *** RESTAS ***
 
                                          isnull((select sum(isnull(hi_credito,0))
                                                  from cob_conta_his..cb_hist_saldo,
                                                       cob_conta..cb_jerarquia
                                                  where hi_empresa      = @i_empresa
                                                  and hi_periodo        = @w_periodo_mid
                                                  and hi_corte          = @w_corte_mid
                                                  and hi_oficina        = je_oficina
                                                  and hi_cuenta         = @i_cuenta1
                                                  and je_empresa        = hi_empresa
                                                  and je_oficina_padre  = 7103),0)
                            */
                            NULL,
    	                    -- *** Producto	  ***   
                            sa_producto,
     	                    -- *** Desproducto ***	   
                            (select substring(pd_descripcion,1,30)
		                       from cobis..cl_producto
		                       where pd_producto = a.sa_producto) 

                             --sum(sa_debito),
                             --sum(sa_credito)
                      from cob_conta_tercero..ct_sasiento a,
                           cob_conta..cb_jerarquia
                       where sa_empresa      = @i_empresa
                       and sa_fecha_tran     >= @w_fecha_ant                          
                       and sa_fecha_tran     <= @w_fecha
                       and sa_cuenta         = @i_cuenta1
                       and sa_oficina_dest   = je_oficina
                       and sa_area_dest      >= 0  
                       --and sa_mayorizado   ='S'
                       and je_empresa        = sa_empresa
                       and je_oficina_padre  = @i_oficina
                       group by sa_producto                      


                      -- *** ACTUALIZACION DE CAMPOS DE TOTALES *** 
                      -- *** DesCuenta ***

                      update cob_conta..prodiva
                      set DesCuenta = (select substring(cu_nombre,1,40)
                             from cob_conta..cb_cuenta
                             where cu_empresa = @i_empresa
                             and   cu_cuenta    = @i_cuenta1)
                      where Cuenta = @i_cuenta1
                       
     	                    
                       -- *** Debitosm1 ***  
                       update cob_conta..prodiva
                       set Debitosm1 = isnull((select sum(isnull(hi_debito,0)) 
                                    from cob_conta_his..cb_hist_saldo
                                    where hi_empresa =  @i_empresa
                                    and   hi_cuenta  =  @i_cuenta1
                                    and   hi_corte   =  @w_corte_mid
                                    and   hi_periodo =  @w_periodo_mid),0)
                                    -  -- *** RESTA ***
                            isnull((select sum(isnull(hi_debito,0)) 
                                    from cob_conta_his..cb_hist_saldo
                                    where hi_empresa =  @i_empresa
                                    and   hi_cuenta  =  @i_cuenta1
                                    and   hi_corte   =  @w_corte_ant
                                    and   hi_periodo =  @w_periodo_ant),0)
                         where Cuenta = @i_cuenta1

                         -- *** Creditosm1 *** 
                         update cob_conta..prodiva
                         set Creditosm1 = isnull((select sum(isnull(hi_credito,0)) 
                                    from cob_conta_his..cb_hist_saldo
                                    where hi_empresa =  @i_empresa
                                    and   hi_cuenta  =  @i_cuenta1
                                    and   hi_corte   =  @w_corte_mid
                                    and   hi_periodo =  @w_periodo_mid),0)
                                    -  -- *** RESTA ***
                             isnull((select sum(isnull(hi_credito,0)) 
                                    from cob_conta_his..cb_hist_saldo
                                    where hi_empresa =  @i_empresa
                                    and   hi_cuenta  =  @i_cuenta1
                                    and   hi_corte   =  @w_corte_ant
                                    and   hi_periodo =  @w_periodo_ant),0)
                            where Cuenta = @i_cuenta1
                 
                             

                           -- *** Debitosm2  *** 
                         update cob_conta..prodiva
                         set Debitosm2 = isnull((select sum(isnull(hi_debito,0)) 
                                    from cob_conta_his..cb_hist_saldo
                                    where hi_empresa =  @i_empresa
                                    and   hi_cuenta  =  @i_cuenta1
                                    and   hi_corte   =  @w_corte
                                    and   hi_periodo =  @w_periodo),0)
                                    -  -- *** RESTA ***
                             isnull((select sum(isnull(hi_debito,0)) 
                                    from cob_conta_his..cb_hist_saldo
                                    where hi_empresa =  @i_empresa
                                    and   hi_cuenta  =  @i_cuenta1
                                    and   hi_corte   =  @w_corte_mid
                                    and   hi_periodo =  @w_periodo_mid),0)
                           where Cuenta = @i_cuenta1


                           -- *** Creditosm2 ***   
                         update cob_conta..prodiva
                         set Creditosm2 =isnull((select sum(isnull(hi_credito,0)) 
                                    from cob_conta_his..cb_hist_saldo
                                    where hi_empresa =  @i_empresa
                                    and   hi_cuenta  =  @i_cuenta1
                                    and   hi_corte   =  @w_corte
                                    and   hi_periodo =  @w_periodo),0)
                                    -  -- *** RESTA ***
                             isnull((select sum(isnull(hi_credito,0)) 
                                    from cob_conta_his..cb_hist_saldo
                                    where hi_empresa =  @i_empresa
                                    and   hi_cuenta  =  @i_cuenta1
                                    and   hi_corte   =  @w_corte_mid
                                    and   hi_periodo =  @w_periodo_mid),0)
                           where Cuenta = @i_cuenta1

                           -- *** Sandresdebm1 ***  
                           update cob_conta..prodiva
                           set Sandresdebm1 = isnull((select sum(isnull(hi_debito,0))
                                    from cob_conta_his..cb_hist_saldo,
                                         cob_conta..cb_jerarquia
                                    where hi_empresa = @i_empresa
                                    and hi_periodo = @w_periodo_mid
                                    and hi_corte   = @w_corte_mid
                                    and hi_oficina = je_oficina
                                    and hi_cuenta  = @i_cuenta1
                                    and je_empresa = hi_empresa
                                    and je_oficina_padre = 8103),0) 
                                    - -- *** RESTA ***
                            isnull((select sum(isnull(hi_debito,0))
                                    from cob_conta_his..cb_hist_saldo,
                                         cob_conta..cb_jerarquia
                                    where hi_empresa     = @i_empresa
                                    and hi_periodo       = @w_periodo_ant
                                    and hi_corte         = @w_corte_ant
                                    and hi_oficina       = je_oficina
                                    and hi_cuenta        = @i_cuenta1
                                    and je_empresa       = hi_empresa
                                    and je_oficina_padre = 8103),0)
                             where Cuenta = @i_cuenta1


                            -- *** Sandrescredm1  ***
                           update cob_conta..prodiva
                           set Sandrescredm1 = isnull((select sum(isnull(hi_credito,0))
                                    from cob_conta_his..cb_hist_saldo,
                                         cob_conta..cb_jerarquia
                                    where hi_empresa = @i_empresa
                                    and hi_periodo = @w_periodo_mid
                                    and hi_corte   = @w_corte_mid
                                    and hi_oficina = je_oficina
                                    and hi_cuenta  = @i_cuenta1
                                    and je_empresa = hi_empresa
                                    and je_oficina_padre = 8103),0) 
                                    - -- *** RESTA ***
                            isnull((select sum(isnull(hi_credito,0))
                                    from cob_conta_his..cb_hist_saldo,
                                         cob_conta..cb_jerarquia
                                    where hi_empresa     = @i_empresa
                                    and hi_periodo       = @w_periodo_ant
                                    and hi_corte         = @w_corte_ant
                                    and hi_oficina       = je_oficina
                                    and hi_cuenta        = @i_cuenta1
                                    and je_empresa       = hi_empresa
                                    and je_oficina_padre = 8103),0)
                             where Cuenta = @i_cuenta1
                            
                             -- *** Sandresdebm2 ***
                           update cob_conta..prodiva
                           set Sandresdebm2 = isnull((select sum(isnull(hi_debito,0))
                                    from cob_conta_his..cb_hist_saldo,
                                         cob_conta..cb_jerarquia
                                    where hi_empresa = @i_empresa
                                    and hi_periodo = @w_periodo
                                    and hi_corte   = @w_corte
                                    and hi_oficina = je_oficina
                                    and hi_cuenta  = @i_cuenta1
                                    and je_empresa = hi_empresa
                                    and je_oficina_padre = 8103),0) 
                                    - -- *** RESTA ***
                            isnull((select sum(isnull(hi_debito,0))
                                    from cob_conta_his..cb_hist_saldo,
                                         cob_conta..cb_jerarquia
                                    where hi_empresa     = @i_empresa
                                    and hi_periodo       = @w_periodo_mid
                                    and hi_corte         = @w_corte_mid
                                    and hi_oficina       = je_oficina
                                    and hi_cuenta        = @i_cuenta1
                                    and je_empresa       = hi_empresa
                                    and je_oficina_padre = 8103),0)
                             where Cuenta = @i_cuenta1

                           -- *** Sandrescredm2 ***
                             update cob_conta..prodiva
                             set Sandrescredm2 = isnull((select sum(isnull(hi_credito,0))
                                    from cob_conta_his..cb_hist_saldo,
                                         cob_conta..cb_jerarquia
                                    where hi_empresa = @i_empresa
                                    and hi_periodo = @w_periodo
                                    and hi_corte   = @w_corte
                                    and hi_oficina = je_oficina
                                    and hi_cuenta  = @i_cuenta1
                                    and je_empresa = hi_empresa
                                    and je_oficina_padre = 8103),0) 
                                    - -- *** RESTA ***
                            isnull((select sum(isnull(hi_credito,0))
                                    from cob_conta_his..cb_hist_saldo,
                                         cob_conta..cb_jerarquia
                                    where hi_empresa     = @i_empresa
                                    and hi_periodo       = @w_periodo_mid
                                    and hi_corte         = @w_corte_mid
                                    and hi_oficina       = je_oficina
                                    and hi_cuenta        = @i_cuenta1
                                    and je_empresa       = hi_empresa
                                    and je_oficina_padre = 8103),0)
                             where Cuenta = @i_cuenta1


                            -- *** Provdebm1 ***   
                             update cob_conta..prodiva
                            set Provdebm1 = isnull((select sum(isnull(hi_debito,0))
                                          from cob_conta_his..cb_hist_saldo,
                                               cob_conta..cb_jerarquia
                                           where hi_empresa      = @i_empresa
                                           and hi_periodo        = @w_periodo_mid
                                           and hi_corte          = @w_corte_mid
                                           and hi_oficina        = je_oficina
                                           and hi_cuenta         = @i_cuenta1
                                           and je_empresa        = hi_empresa
                                           and je_oficina_padre  = 8110),0) 
                                           - -- *** RESTA ***
                              isnull((select sum(isnull(hi_debito,0))
                                          from cob_conta_his..cb_hist_saldo,
                                               cob_conta..cb_jerarquia
                                          where hi_empresa      = @i_empresa
                                          and hi_periodo        = @w_periodo_ant
                                          and hi_corte          = @w_corte_ant
                                          and hi_oficina        = je_oficina
                                          and hi_cuenta         = @i_cuenta1
                                          and je_empresa        = hi_empresa
                                          and je_oficina_padre  = 8110),0)
                             where Cuenta = @i_cuenta1
                                
                             
                           -- *** Provcred1  *** 
                           update cob_conta..prodiva
                            set Provcred1 = isnull((select sum(isnull(hi_credito,0))
                                          from cob_conta_his..cb_hist_saldo,
                                               cob_conta..cb_jerarquia
                                           where hi_empresa      = @i_empresa
                                           and hi_periodo        = @w_periodo_mid
                                           and hi_corte          = @w_corte_mid
                                           and hi_oficina        = je_oficina
                                           and hi_cuenta         = @i_cuenta1
                                           and je_empresa        = hi_empresa
                                           and je_oficina_padre  = 8110),0) 
                                           - -- *** RESTA ***
                             isnull((select sum(isnull(hi_credito,0))
                                          from cob_conta_his..cb_hist_saldo,
                                               cob_conta..cb_jerarquia
                                          where hi_empresa      = @i_empresa
                                          and hi_periodo        = @w_periodo_ant
                                          and hi_corte          = @w_corte_ant
                                          and hi_oficina        = je_oficina
                                          and hi_cuenta         = @i_cuenta1
                                          and je_empresa        = hi_empresa
                                          and je_oficina_padre  = 8110),0)
                               where Cuenta = @i_cuenta1
                           
                            -- *** Provdebm2  ***  
                            update cob_conta..prodiva
                            set Provdebm2 = isnull((select sum(isnull(hi_debito,0))
                                          from cob_conta_his..cb_hist_saldo,
                                               cob_conta..cb_jerarquia
                                           where hi_empresa      = @i_empresa
                                           and hi_periodo        = @w_periodo
                                           and hi_corte          = @w_corte
                                           and hi_oficina        = je_oficina
                                           and hi_cuenta         = @i_cuenta1
                                           and je_empresa        = hi_empresa
                                           and je_oficina_padre  = 8110),0) 
                                           - -- *** RESTA ***
                             isnull((select sum(isnull(hi_debito,0))
                                          from cob_conta_his..cb_hist_saldo,
                                               cob_conta..cb_jerarquia
                                          where hi_empresa      = @i_empresa
                                          and hi_periodo        = @w_periodo_mid
                                          and hi_corte          = @w_corte_mid
                                          and hi_oficina        = je_oficina
                                          and hi_cuenta         = @i_cuenta1
                                          and je_empresa        = hi_empresa
                                          and je_oficina_padre  = 8110),0)
                             where Cuenta = @i_cuenta1
                           
                            -- *** Provcred2  ***  
                            update cob_conta..prodiva
                            set Provcred2 = isnull((select sum(isnull(hi_credito,0))
                                          from cob_conta_his..cb_hist_saldo,
                                               cob_conta..cb_jerarquia
                                           where hi_empresa      = @i_empresa
                                           and hi_periodo        = @w_periodo
                                           and hi_corte          = @w_corte
                                           and hi_oficina        = je_oficina
                                           and hi_cuenta         = @i_cuenta1
                                           and je_empresa        = hi_empresa
                                           and je_oficina_padre  = 8110),0) 
                                           - -- *** RESTA ***
                             isnull((select sum(isnull(hi_credito,0))
                                          from cob_conta_his..cb_hist_saldo,
                                               cob_conta..cb_jerarquia
                                          where hi_empresa      = @i_empresa
                                          and hi_periodo        = @w_periodo_mid
                                          and hi_corte          = @w_corte_mid
                                          and hi_oficina        = je_oficina
                                          and hi_cuenta         = @i_cuenta1
                                          and je_empresa        = hi_empresa
                                          and je_oficina_padre  = 8110),0)
                            where Cuenta = @i_cuenta1
                          
                            -- *** letdebm1 ***  
                             update cob_conta..prodiva
                            set letdebm1 = isnull((select sum(isnull(hi_debito,0))
                                                  from cob_conta_his..cb_hist_saldo,
                                                       cob_conta..cb_jerarquia
                                                  where hi_empresa      = @i_empresa
                                                  and hi_periodo        = @w_periodo_mid
                                                  and hi_corte          = @w_corte_mid
                                                  and hi_oficina        = je_oficina
                                                  and hi_cuenta         = @i_cuenta1
                                                  and je_empresa        = hi_empresa
                                                  and je_oficina_padre  = 7103),0) 
 
                                                  - -- *** RESTAS ***
 
                                          isnull((select sum(isnull(hi_debito,0))
                                                  from cob_conta_his..cb_hist_saldo,
                                                       cob_conta..cb_jerarquia
                                                  where hi_empresa      = @i_empresa
                                                  and hi_periodo        = @w_periodo_ant
                                                  and hi_corte          = @w_corte_ant
                                                  and hi_oficina        = je_oficina
                                                  and hi_cuenta         = @i_cuenta1
                                                  and je_empresa        = hi_empresa
                                                  and je_oficina_padre  = 7103),0)
                             where Cuenta = @i_cuenta1
                           
                            -- *** letcredm1  ***  
                            update cob_conta..prodiva
                            set letcredm1  = isnull((select sum(isnull(hi_credito,0))
                                                  from cob_conta_his..cb_hist_saldo,
                                                       cob_conta..cb_jerarquia
                                                  where hi_empresa      = @i_empresa
                                                  and hi_periodo        = @w_periodo_mid
                                                  and hi_corte          = @w_corte_mid
                                                  and hi_oficina        = je_oficina
                                                  and hi_cuenta         = @i_cuenta1
                                                  and je_empresa        = hi_empresa
                                                  and je_oficina_padre  = 7103),0) 
 
                                                  - -- *** RESTAS ***
 
                                          isnull((select sum(isnull(hi_credito,0))
                                                  from cob_conta_his..cb_hist_saldo,
                                                       cob_conta..cb_jerarquia
                                                  where hi_empresa      = @i_empresa
                                                  and hi_periodo        = @w_periodo_ant
                                                  and hi_corte          = @w_corte_ant
                                                  and hi_oficina        = je_oficina
                                                  and hi_cuenta         = @i_cuenta1
                                                  and je_empresa        = hi_empresa
                                                  and je_oficina_padre  = 7103),0)
                             where Cuenta = @i_cuenta1
                    
                            -- *** letdebdm2  ***  
                             update cob_conta..prodiva
                            set letdebdm2  = isnull((select sum(isnull(hi_debito,0))
                                                  from cob_conta_his..cb_hist_saldo,
                                                       cob_conta..cb_jerarquia
                                                  where hi_empresa      = @i_empresa
                                                  and hi_periodo        = @w_periodo
                                                  and hi_corte          = @w_corte
                                                  and hi_oficina        = je_oficina
                                                  and hi_cuenta         = @i_cuenta1
                                                  and je_empresa        = hi_empresa
                                                  and je_oficina_padre  = 7103),0) 
 
                                                  - -- *** RESTAS ***
 
                                          isnull((select sum(isnull(hi_debito,0))
                                                  from cob_conta_his..cb_hist_saldo,
                                                       cob_conta..cb_jerarquia
                                                  where hi_empresa      = @i_empresa
                                                  and hi_periodo        = @w_periodo_mid
                                                  and hi_corte          = @w_corte_mid
                                                  and hi_oficina        = je_oficina
                                                  and hi_cuenta         = @i_cuenta1
                                                  and je_empresa        = hi_empresa
                                                  and je_oficina_padre  = 7103),0)
                         where Cuenta = @i_cuenta1
                            
                            -- *** letcredm2  ***  
                              update cob_conta..prodiva
                            set letcredm2   = isnull((select sum(isnull(hi_credito,0))
                                                  from cob_conta_his..cb_hist_saldo,
                                                       cob_conta..cb_jerarquia
                                                  where hi_empresa      = @i_empresa
                                                  and hi_periodo        = @w_periodo
                                                  and hi_corte          = @w_corte
                                                  and hi_oficina        = je_oficina
                                                  and hi_cuenta         = @i_cuenta1
                                                  and je_empresa        = hi_empresa
                                                  and je_oficina_padre  = 7103),0) 
 
                                                  - -- *** RESTAS ***
 
                                          isnull((select sum(isnull(hi_credito,0))
                                                  from cob_conta_his..cb_hist_saldo,
                                                       cob_conta..cb_jerarquia
                                                  where hi_empresa      = @i_empresa
                                                  and hi_periodo        = @w_periodo_mid
                                                  and hi_corte          = @w_corte_mid
                                                  and hi_oficina        = je_oficina
                                                  and hi_cuenta         = @i_cuenta1
                                                  and je_empresa        = hi_empresa
                                                  and je_oficina_padre  = 7103),0)
                             where Cuenta = @i_cuenta1

               fetch cuenta_cursor
 	           into  @i_cuenta1
    
           end  -- *** CURSOR cuenta_cursor***  
        
                
     end--Consulta de los movimientos de una cuenta en un bimestre

end 

/*****************************************************************************************************/
/*  CONSULTA QUE TRAE DATOS DE SALDO PARA LA HOJA EXCEL DE IMPUESTOS DEPARTAMENTALES -WILLIAM HOYOS  */
/*****************************************************************************************************/

if @i_operacion = 'B'
begin
    --CALCULO CORTE INICIA
    select 	    @w_corte_ini = co_corte, 
	            @w_periodo_ini = co_periodo,
	            @w_estado_corte_ini = co_estado
        from 	cob_conta..cb_corte
        where 	co_empresa = @i_empresa and
      	    co_fecha_ini <= dateadd(dd,-1,@i_fecha) and
      	    co_fecha_fin >= dateadd(dd,-1,@i_fecha)

     --CALCULO CORTE FINAL
    select 	    @w_corte_fin = co_corte, 
	            @w_periodo_fin = co_periodo,
	            @w_estado_corte_fin  = co_estado
        from 	cob_conta..cb_corte
        where 	co_empresa = @i_empresa and
      	     co_fecha_ini <= @i_fecha_ant and
      	     co_fecha_fin >= @i_fecha_ant      	

     -- CATEGORIA DE LA CUENTA
    select @w_cu_categoria  = cu_categoria 
        from   cob_conta..cb_cuenta
        where  cu_empresa = @i_empresa and
               cu_cuenta = @i_cuenta

    --SALDO CORTE INICIAL
	   select @w_saldo_ini = isnull(sum(hi_saldo),0),
              @w_debito_ini = isnull(sum(hi_debito),0),
              @w_credito_ini = isnull(sum(hi_credito),0)
	   from cob_conta_his..cb_hist_saldo, cob_conta..cb_aso_oficonsol
	   where hi_empresa = @i_empresa 
	   and   hi_periodo = @w_periodo_ini
	   and   hi_corte   = @w_corte_ini
	   and   hi_cuenta  = @i_cuenta
       and   hi_oficina = ao_oficina_asociada
       and   ao_cod_declaracion = '03'
       and   ao_oficina_consolida = @i_oficina

    --SALDO CORTE FINAL
 	  select @w_saldo_fin = isnull(sum(hi_saldo),0),
              @w_debito_fin = isnull(sum(hi_debito),0),
              @w_credito_fin = isnull(sum(hi_credito),0)
	   from cob_conta_his..cb_hist_saldo,cob_conta..cb_aso_oficonsol
	   where hi_empresa = @i_empresa 
	   and   hi_periodo = @w_periodo_fin
	   and   hi_corte   = @w_corte_fin
	   and   hi_cuenta  = @i_cuenta
       and   hi_oficina = ao_oficina_asociada
       and   ao_cod_declaracion = '03'
       and   ao_oficina_consolida = @i_oficina

    -- CALCULO SALDO PERIODO DEFINIDO

   --select @w_saldo2 = - @w_saldo_fin - @w_saldo_ini 
   select 	@w_saldo_ini,
            isnull(@w_debito_fin,0)-isnull(@w_debito_ini,0),
            isnull(@w_credito_fin,0)-isnull(@w_credito_ini,0),
            isnull(@w_saldo_fin,0)-isnull(@w_saldo_ini,0),
            @w_saldo_fin

end


/******************************************************************************************************************/
/*  CONSULTA QUE TRAE DATOS DE SALDO PARA LA HOJA EXCEL DE IMPUESTOS DE RTE-ICA   Cobcon05.xls    -WILLIAM HOYOS  */
/******************************************************************************************************************/
if @i_operacion = 'G'
begin
      --CALCULO CORTE INICIA
    select 	    @w_corte_ini = co_corte, 
	            @w_periodo_ini = co_periodo,
	            @w_estado_corte_ini = co_estado
        from 	cob_conta..cb_corte
        where 	co_empresa = @i_empresa and
      	    co_fecha_ini <= @i_fecha and
      	    co_fecha_fin >= @i_fecha      	

     --CALCULO CORTE FINAL
    select 	    @w_corte_fin = co_corte, 
	            @w_periodo_fin = co_periodo,
	            @w_estado_corte_fin  = co_estado
        from 	cob_conta..cb_corte
        where 	co_empresa = @i_empresa and
      	     co_fecha_ini <= @i_fecha_ant and
      	     co_fecha_fin >= @i_fecha_ant      	

     -- CATEGORIA DE LA CUENTA
        select @w_cu_categoria  = cu_categoria 
            from   cob_conta..cb_cuenta
        where  cu_empresa = @i_empresa and
               cu_cuenta = @i_cuenta
    
        --SALDO CORTE INICIAL
	   select @w_saldo_ini = isnull(sum(hi_saldo),0),
              @w_debito_ini = isnull(sum(hi_debito),0),
              @w_credito_ini = isnull(sum(hi_credito),0)
	   from cob_conta_his..cb_hist_saldo,cob_conta..cb_aso_oficonsol
	   where hi_empresa = @i_empresa 
	   and   hi_periodo = @w_periodo_ini
	   and   hi_corte   = @w_corte_ini
	   and   hi_cuenta  = @i_cuenta
       and   hi_oficina = ao_oficina_asociada
       and   ao_cod_declaracion = @i_cod_declaracion
       and   ao_oficina_consolida = @i_oficina
 

    --SALDO CORTE FINAL
 	  select @w_saldo_fin = isnull(sum(hi_saldo),0),
             @w_debito_fin = isnull(sum(hi_debito),0),
             @w_credito_fin = isnull(sum(hi_credito),0)
	   from cob_conta_his..cb_hist_saldo,cob_conta..cb_aso_oficonsol
	   where hi_empresa = @i_empresa 
	   and   hi_periodo = @w_periodo_fin
	   and   hi_corte   = @w_corte_fin
	   and   hi_cuenta  = @i_cuenta
       and   hi_oficina = ao_oficina_asociada
       and   ao_cod_declaracion = @i_cod_declaracion
       and   ao_oficina_consolida = @i_oficina

       --select  @w_saldo_fin = - @w_saldo_fin - @w_saldo_ini

       --DEBITOS DEL PERIODO
       select @w_debito = @w_debito_fin - @w_debito_ini
       
       --CREDITOS DEL PERIODO
       select @w_credito = @w_credito_fin - @w_credito_ini

       -- CALCULO DE LA BASE PARA ESTE PERIODO
       select @w_base = isnull(sum(isnull(sa_base,0)),0) 
       from cob_conta_tercero..ct_sasiento,cob_conta..cb_aso_oficonsol
       where sa_empresa = @i_empresa
       and sa_cuenta        =  @i_cuenta
       and sa_fecha_tran    > @i_fecha
       and sa_fecha_tran    <= @i_fecha_ant
       and sa_oficina_dest = ao_oficina_asociada
       and ao_cod_declaracion = @i_cod_declaracion
       and ao_oficina_consolida = @i_oficina
       and sa_producto > 0

       select round(@w_base,0),round(@w_saldo_ini,0),round(@w_debito,0),round(@w_credito,0),round(@w_saldo_fin,0)
end --@i_operacion = 'G'

/************************************************************************************************************/
/*  CONSULTA QUE TRAE DATOS DE SALDO PARA LA HOJA EXCEL DECLARACION DE ICA Cobcon05.xls     -WILLIAM HOYOS  */
/************************************************************************************************************/

if @i_operacion = 'U'
begin
   --CALCULO CORTE INICIA
   select @w_corte_ini = co_corte, 
	  @w_periodo_ini = co_periodo,
	  @w_estado_corte_ini = co_estado
   from cob_conta..cb_corte
   where co_empresa = @i_empresa and
         co_fecha_ini <= @i_fecha and
         co_fecha_fin >= @i_fecha      	

   --CALCULO CORTE FINAL
   select @w_corte_fin = co_corte, 
	  @w_periodo_fin = co_periodo,
	  @w_estado_corte_fin  = co_estado
   from cob_conta..cb_corte
   where co_empresa = @i_empresa and
      	 co_fecha_ini <= @i_fecha_ant and
      	 co_fecha_fin >= @i_fecha_ant      	
     
   -- CATEGORIA DE LA CUENTA
   select @w_cu_categoria  = cu_categoria 
   from cob_conta..cb_cuenta
   where cu_empresa = @i_empresa and
         cu_cuenta = @i_cuenta
      
   --SALDO CORTE INICIAL
   select @w_saldo_ini = sum(hi_saldo)
   from cob_conta_his..cb_hist_saldo,cob_conta..cb_aso_oficonsol
   where hi_corte = @w_corte_ini
   and hi_periodo = @w_periodo_ini
   and hi_oficina = ao_oficina_asociada
   and ao_cod_declaracion = '02'
   and ao_oficina_consolida = @i_oficina
   and hi_cuenta = @i_cuenta
   and hi_empresa = @i_empresa
    
   select @w_saldo_ini = isnull(@w_saldo_ini, 0)

 
   --SALDO CORTE FINAL
   select @w_saldo_fin = sum(hi_saldo)
   from cob_conta_his..cb_hist_saldo,cob_conta..cb_aso_oficonsol
   where hi_empresa = @i_empresa 
   and hi_periodo = @w_periodo_fin
   and hi_corte   = @w_corte_fin
   and hi_cuenta  = @i_cuenta
   and hi_oficina = ao_oficina_asociada
   and ao_cod_declaracion = '02'
   and ao_oficina_consolida = @i_oficina

   select @w_saldo_fin = isnull(@w_saldo_fin, 0)
   
   --SALDOS DEL PERIODO
   --select @w_saldo2 = - @w_saldo_fin - @w_saldo_ini
   select @w_saldo2 = @w_saldo_fin 
   --print '%1!',@w_saldo2
   select round(@w_saldo2,0)

end --@i_operacion = 'U'

if @i_operacion = 'D'
begin
     select sum(sa_debito) - sum(sa_credito)
       from cob_conta_tercero..ct_sasiento -- (index ct_sasiento_AKey1)
      where sa_cuenta = @i_cuenta
        and (sa_fecha_tran >= @i_fecha and sa_fecha_tran <= @i_fecha_ant)
        and sa_oficina_dest in (select ao_oficina_asociada from cob_conta..cb_aso_oficonsol
                                 where ao_cod_declaracion = '03'
                                   and ao_oficina_consolida = @i_oficina)
        and sa_empresa = @i_empresa
        and sa_producto > 0
        and sa_comprobante > 0
        and sa_con_dptales = @i_concepto
end

if @i_operacion = 'F' /*** VALIDA FECHAS DE TRABAJO ***/
begin
                 	 
   select co_fecha_ini
   from cob_conta..cb_corte
   where co_empresa = @i_empresa
   and   @i_fecha_fin between co_fecha_ini and co_fecha_fin
   and   co_estado in ('A','V')

	
   if @@rowcount = 0
   begin	/* 'ES UN CORTE NO VIGENTE O ACTUAL' */
   exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 603023
	return 603023
  end 
end


/*
--------------------------------------------------------------------------
--CONSULTA QUE TRAE DATOS DE SALDO PARA LA HOJA EXCEL INDUSTRIA Y COMERCIO
--------------------------------------------------------------------------
if @i_operacion = 'N'
begin

   select 
         if_valor         
   from  cb_ifiduscomer
   where if_oficina =  @i_oficina   
   and 	 if_cuenta  =  @i_cuenta

end 

--------------------------------------------------------------------------
--CONSULTA QUE TRAE DATOS DEL ENTE PARA LA HOJA EXCEL INDUSTRIA Y COMERCIO
--------------------------------------------------------------------------
if @i_operacion = 'O'
begin

   select         
         if_cod_ente,
	 if_nom_ente
   from  cb_ifiduscomer
   where if_oficina =  @i_oficina   
   and 	 if_cuenta  =  @i_cuenta

end 

*/

if @i_operacion in('T', 'C', 'E', 'I', 'P')
begin
   set rowcount 0

   delete
   from cb_oficina_saldo_tmp
   where sp_id = @sp_id
   and s_term = @s_term

   delete
   from cb_area_saldo_tmp
   where sp_id = @sp_id
   and s_term = @s_term
end

if @i_operacion = 'S' or @i_operacion = 'C'
begin
   set rowcount 0

   delete
   from cb_saldo_tmp
   where sp_id = @sp_id
   and s_term = @s_term
end

if @i_operacion = 'Z' or @i_operacion = 'H'
begin
   set rowcount 0

   delete
   from cb_cuenta_saldo_tmp
   where sp_id = @sp_id
   and s_term = @s_term
end
    
if @i_operacion = 'J'
begin
      select @w_saldo = sum(isnull(hi_saldo,0))
      from cob_conta_his..cb_hist_saldo
      where hi_corte = @w_corte
      and hi_periodo = @w_periodo
      and hi_cuenta = @i_cuenta
      and hi_empresa = @i_empresa

      if @i_modo = 0
      begin
          select @w_periodo1 = co_periodo,
                 @w_corte1 = co_corte
            from cb_corte
           where co_empresa = @i_empresa
             and co_fecha_ini >= dateadd(dd,-1,Convert(varchar(2),Datepart(mm,@i_fecha))+'/01/'+Convert(varchar(4),Datepart(yy,@i_fecha)))
             and co_fecha_fin <= dateadd(dd,-1,Convert(varchar(2),Datepart(mm,@i_fecha))+'/01/'+Convert(varchar(4),Datepart(yy,@i_fecha)))
         
          select @w_saldo1 = sum(isnull(hi_saldo,0))
          from cob_conta_his..cb_hist_saldo
          where hi_corte = @w_corte1
          and hi_periodo = @w_periodo1
          and hi_cuenta = @i_cuenta
          and hi_empresa = @i_empresa
          
          --print 'saldo %1! saldo1 %2!',@w_saldo,@w_saldo1
          select isnull(@w_saldo,0)-isnull(@w_saldo1,0)
      end
      else
      begin
          select isnull(@w_saldo,0)
      end
end

return 0
go