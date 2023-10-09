/************************************************************************/
/*	Archivo: 		corte1.sp				*/
/*	Stored procedure: 	sp_corte1  				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     27-octubre-1997				*/
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
/*	Genera temporal de cortes de un periodo de acuerdo al tipo      */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	27/oct/1997	Martha Gil      Emision Inicial                 */
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_corte1')
        drop proc sp_corte1

go
create proc sp_corte1       (
        @s_ssn          int = null,
        @s_date         datetime = null,
        @s_user         login = null,
        @s_term         descripcion = null,
        @s_corr         char(1) = null,
        @s_ssn_corr     int = null,
        @s_ofi          smallint = null,
        @t_rty          char(1) = null,
        @t_trn          smallint = null,
        @t_debug        char(1) = 'N',
        @t_file         varchar(14) = null,
        @t_from         varchar(30) = null,
        @i_operacion    char(1) = null,
        @i_modo         smallint = null,
        @i_periodo      int = null,
        @i_empresa      tinyint = null,
        @i_fecha_inicio datetime = null,
        @i_fecha_fin    datetime = null,
        @i_tipo_periodo char(1) = null,
        @i_corte        int = null,
        @i_fecha_ini    datetime = null,
        @i_fecha_finc   datetime = null,
        @i_estado       char(1)  = null,
        @i_formato_fecha tinyint = 1,
        @i_factor       tinyint  = null

)
as

declare
        @w_today        datetime,       /* fecha del dia */
        @w_return       int,            /* valor que retorna */
        @w_sp_name      varchar(32),    /* nombre del stored procedure*/
        @w_siguiente    tinyint,        /* siguiente codigo de periodo */
        @w_existe       int,            /* codigo existe = 1
                                               no existe = 0 */

        /* Variables utilizadas en la consulta de una periodo */
        @w_corte        int,
        @w_periodo      int ,       /* codigo de periodo */
        @w_empresa      tinyint,        /* codigo de empresa */
        @w_fecha_inicio datetime,       /* fecha inicio del periodo */
        @w_fecha_fin    datetime,       /* fecha final del perriodo */
        @w_estado       char(1),        /* codigo de estado  */
        @w_tipo_periodo char(1),        /* # de cortes del periodo  */
        @w_fecha_corte  datetime,
        @fecha          datetime,
	@w_mes          char(2),
        @w_dia          char(2),
        @w_ano          smallint,    
	@w_mes_c        char(2),
        @w_dia_c        char(2),
        @w_ano_c        char(4),
        @fecha_s        char(10),
        @fecnew1        datetime,
        @fecnew2        datetime,
        @w_enero        datetime,
        @w_febrero      datetime,
        @w_marzo        datetime,
        @w_abril        datetime,
        @w_mayo         datetime,
        @w_junio        datetime,
        @w_julio        datetime,
        @w_agosto       datetime,
        @w_septiembre   datetime,
        @w_octubre      datetime,
        @w_noviembre    datetime,
        @w_diciembre    datetime,
        @w_maxcorte     int,
        @fecq1          datetime,
        @fecq2          datetime,
        @partes         int,
        @i              int,
        @uno            int,
        @w_flag1        int,
        @w_nempresa     descripcion,
        @w_fecha_ini    datetime,
        @w_fecha_finc   datetime,
        @mes            int

select @w_today = getdate()
select @w_sp_name = 'sp_corte1'
select @uno = 1

/************************************************/
/*  Tipo de Transaccion = 610X                  */
/************************************************/

if (@t_trn <> 6329 and @i_operacion = 'I')
begin
        /* 'Tipo de transaccion no corresponde' */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 601077
        return 1
end
/************************************************/

truncate table corte_tmp

if @t_debug = 'S'
begin
        exec cobis..sp_begin_debug @t_file = @t_file
        select '/** Store Procedure **/ ' = @w_sp_name,
                t_file          = @t_file,
                t_from          = @t_from,
                i_operacion     = @i_operacion,
                i_periodo       = @i_periodo,
                i_empresa       = @i_empresa,
                i_fecha_inicio  = @i_fecha_inicio,
                i_fecha_fin     = @i_fecha_fin,
                i_tipo_periodo  = @i_tipo_periodo
        exec cobis..sp_end_debug
end

/* asignaciones para calculo de cortes  mensuales, trimestrales, semestrales*/

select @w_ano = datepart(yy,@i_fecha_inicio)    
select @w_ano_c = CONVERT(char(4),@w_ano)

select @w_enero = '01'+'/'+'31'+'/'+@w_ano_c 

/*es mejor consultarlo para evitar confusion con anio bisiesto */

select @w_maxcorte = max(co_corte)  
from cob_conta..cb_corte
where co_empresa = @i_empresa and
	co_periodo = @w_ano and
	co_corte > 0 and
	datepart(mm,co_fecha_ini) = 2

select @w_febrero = co_fecha_ini
from  cb_corte
where co_empresa = @i_empresa and
	co_periodo = @w_ano and
	co_corte = @w_maxcorte
 

select @w_marzo = '03'+'/'+'31'+'/'+@w_ano_c 
select @w_abril = '04'+'/'+'30'+'/'+@w_ano_c 
select @w_mayo = '05'+'/'+'31'+'/'+@w_ano_c 
select @w_junio = '06'+'/'+'30'+'/'+@w_ano_c 
select @w_julio = '07'+'/'+'31'+'/'+@w_ano_c 
select @w_agosto = '08'+'/'+'31'+'/'+@w_ano_c 
select @w_septiembre = '09'+'/'+'30'+'/'+@w_ano_c 
select @w_octubre = '10'+'/'+'31'+'/'+@w_ano_c 
select @w_noviembre = '11'+'/'+'30'+'/'+@w_ano_c 
select @w_diciembre = '12'+'/'+'31'+'/'+@w_ano_c 


if @i_operacion = 'I'
begin
  begin tran

   if @i_tipo_periodo = 'M'
   begin

      if @w_enero >= @i_fecha_inicio and @w_enero <= @i_fecha_fin
      begin
	select @fecnew2= dateadd(dd,-1,@w_enero)
	
	select @i = count(*) 
	from corte_tmp
	where tmp_periodo = @i_periodo and
	tmp_empresa = @i_empresa and
	tmp_tipo_corte = 'M' 
	
	select @i = @i + 1
	
	select @w_corte = co_corte 
	from cob_conta..cb_corte
	where co_empresa = @i_empresa and
	co_periodo = @i_periodo and
	co_fecha_fin = @w_enero

	insert into cob_conta..corte_tmp values 
	(@w_corte,@i_periodo,@i_empresa,@fecnew2,@w_enero,'N',@i_tipo_periodo) 

	if @@error <> 0
	begin
		/* 'Error en la Insercion de Cortes  ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 603018
		return 1
	end
     end

      if @w_febrero >= @i_fecha_inicio and @w_febrero <= @i_fecha_fin
      begin
          select @fecnew2= dateadd(dd,-1,@w_febrero)

          select @i = count(*) 
          from corte_tmp
          where tmp_periodo = @i_periodo and
		tmp_empresa = @i_empresa and
		tmp_tipo_corte = 'M' 

          select @i = @i + 1

          select @w_corte = co_corte 
          from cob_conta..cb_corte
          where  co_empresa = @i_empresa and
		co_periodo = @i_periodo and
		co_fecha_fin = @w_febrero

          insert into cob_conta..corte_tmp values 
            (@w_corte,@i_periodo,@i_empresa,@fecnew2,@w_febrero,'N',@i_tipo_periodo) 

          if @@error <> 0
          begin
             /* 'Error en la Insercion de Cortes  ' */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 603018
             return 1
          end
      end

      if @w_marzo >= @i_fecha_inicio and @w_marzo <= @i_fecha_fin
      begin
          select @fecnew2= dateadd(dd,-1,@w_marzo)

          select @i = count(*) 
          from corte_tmp
          where tmp_periodo = @i_periodo and
		tmp_empresa = @i_empresa and
		tmp_tipo_corte = 'M' 

          select @i = @i + 1

          select @w_corte = co_corte 
          from cob_conta..cb_corte
          where  co_empresa = @i_empresa and
		co_periodo  = @i_periodo and
		 co_fecha_fin = @w_marzo

          insert into cob_conta..corte_tmp values 
            (@w_corte,@i_periodo,@i_empresa,@fecnew2,@w_marzo,'N',@i_tipo_periodo) 

          if @@error <> 0
          begin
             /* 'Error en la Insercion de Cortes  ' */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 603018
             return 1
          end
      end

      if @w_abril >= @i_fecha_inicio and @w_abril <= @i_fecha_fin
      begin   

          select @fecnew2= dateadd(dd,-1,@w_abril)

          select @i = count(*) 
          from corte_tmp
          where tmp_periodo = @i_periodo and
		tmp_empresa = @i_empresa and
		tmp_tipo_corte = 'M' 

          select @i = @i + 1

          select @w_corte = co_corte 
          from cob_conta..cb_corte
          where  co_empresa = @i_empresa and
		co_periodo = @i_periodo and
		co_fecha_fin = @w_abril
                 

          insert into cob_conta..corte_tmp values 
            (@w_corte,@i_periodo,@i_empresa,@fecnew2,@w_abril,'N',@i_tipo_periodo) 

          if @@error <> 0
          begin
             /* 'Error en la Insercion de Cortes  ' */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 603018
             return 1
          end
      end

      if @w_mayo >= @i_fecha_inicio and @w_mayo <= @i_fecha_fin
      begin
          select @fecnew2= dateadd(dd,-1,@w_mayo)

          select @i = count(*) 
          from corte_tmp
          where tmp_periodo = @i_periodo and
            tmp_empresa = @i_empresa and
            tmp_tipo_corte = 'M' 

          select @i = @i + 1

          select @w_corte = co_corte 
          from cob_conta..cb_corte
          where  co_empresa = @i_empresa and
          	co_periodo = @i_periodo and
		co_fecha_fin = @w_mayo
                 

          insert into cob_conta..corte_tmp values 
            (@w_corte,@i_periodo,@i_empresa,@fecnew2,@w_mayo,'N',@i_tipo_periodo) 

          if @@error <> 0
          begin
             /* 'Error en la Insercion de Cortes  ' */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 603018
             return 1
          end
      end

      if @w_junio >= @i_fecha_inicio and @w_junio <= @i_fecha_fin
      begin   

          select @fecnew2= dateadd(dd,-1,@w_junio)

          select @i = count(*) 
          from corte_tmp
          where tmp_periodo = @i_periodo and
            tmp_empresa = @i_empresa and
            tmp_tipo_corte = 'M' 

          select @i = @i + 1

          select @w_corte = co_corte 
          from cob_conta..cb_corte
          where  co_empresa = @i_empresa and
          	co_periodo = @i_periodo and
		co_fecha_fin = @w_junio

          insert into cob_conta..corte_tmp values 
            (@w_corte,@i_periodo,@i_empresa,@fecnew2,@w_junio,'N',@i_tipo_periodo) 

          if @@error <> 0
          begin
             /* 'Error en la Insercion de Cortes  ' */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 603018
             return 1
          end
      end

      if @w_julio >= @i_fecha_inicio and @w_julio <= @i_fecha_fin
      begin   

          select @fecnew2= dateadd(dd,-1,@w_julio)

          select @i = count(*) 
          from corte_tmp
          where tmp_periodo = @i_periodo and
            tmp_empresa = @i_empresa and
            tmp_tipo_corte = 'M' 

          select @i = @i + 1

          select @w_corte = co_corte 
          from cob_conta..cb_corte
          where  co_empresa = @i_empresa and
		co_periodo = @i_periodo and
		 co_fecha_fin = @w_julio
                 

          insert into cob_conta..corte_tmp values 
            (@w_corte,@i_periodo,@i_empresa,@fecnew2,@w_julio,'N',@i_tipo_periodo) 

          if @@error <> 0
          begin
             /* 'Error en la Insercion de Cortes  ' */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 603018
             return 1
          end
      end

      if @w_agosto >= @i_fecha_inicio and @w_agosto <= @i_fecha_fin
      begin   

          select @fecnew2= dateadd(dd,-1,@w_agosto)

          select @i = count(*) 
          from corte_tmp
          where tmp_periodo = @i_periodo and
		tmp_empresa = @i_empresa and
		tmp_tipo_corte = 'M' 

          select @i = @i + 1

          select @w_corte = co_corte 
          from cob_conta..cb_corte
          where  co_empresa = @i_empresa and
          	co_periodo = @i_periodo and
		co_fecha_fin = @w_agosto
                 

          insert into cob_conta..corte_tmp values 
            (@w_corte,@i_periodo,@i_empresa,@fecnew2,@w_agosto,'N',@i_tipo_periodo) 

          if @@error <> 0
          begin
             /* 'Error en la Insercion de Cortes  ' */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 603018
             return 1
          end
      end

      if @w_septiembre >= @i_fecha_inicio and @w_septiembre <= @i_fecha_fin
      begin   

          select @fecnew2= dateadd(dd,-1,@w_septiembre)

          select @i = count(*) 
          from corte_tmp
          where
            tmp_periodo = @i_periodo and
            tmp_empresa = @i_empresa and
            tmp_tipo_corte = 'M' 

          select @i = @i + 1

          select @w_corte = co_corte 
          from cob_conta..cb_corte
          where  co_empresa = @i_empresa and
          	co_periodo = @i_periodo and
		 co_fecha_fin = @w_septiembre
                 

          insert into cob_conta..corte_tmp values 
          (@w_corte,@i_periodo,@i_empresa,@fecnew2,@w_septiembre,'N',@i_tipo_periodo) 

          if @@error <> 0
          begin
             /* 'Error en la Insercion de Cortes  ' */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 603018
             return 1
          end
      end

      if @w_octubre >= @i_fecha_inicio and @w_octubre <= @i_fecha_fin
      begin   

          select @fecnew2= dateadd(dd,-1,@w_octubre)

          select @i = count(*) 
          from corte_tmp
          where
            tmp_periodo = @i_periodo and
            tmp_empresa = @i_empresa and
            tmp_tipo_corte = 'M' 

          select @i = @i + 1

          select @w_corte = co_corte 
          from cob_conta..cb_corte
          where  co_empresa = @i_empresa and
          	co_periodo = @i_periodo and
		 co_fecha_fin = @w_octubre
                 

          insert into cob_conta..corte_tmp values 
            (@w_corte,@i_periodo,@i_empresa,@fecnew2,@w_octubre,'N',@i_tipo_periodo) 

          if @@error <> 0
          begin
             /* 'Error en la Insercion de Cortes  ' */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 603018
             return 1
          end
      end

      if @w_noviembre >= @i_fecha_inicio and @w_noviembre <= @i_fecha_fin
      begin   

          select @fecnew2= dateadd(dd,-1,@w_noviembre)

          select @i = count(*) 
          from corte_tmp
          where
            tmp_periodo = @i_periodo and
            tmp_empresa = @i_empresa and
            tmp_tipo_corte = 'M' 

          select @i = @i + 1

          select @w_corte = co_corte 
          from cob_conta..cb_corte
          where  co_empresa = @i_empresa and
		co_periodo = @i_periodo and
		 co_fecha_fin = @w_noviembre

          insert into cob_conta..corte_tmp values 
          (@w_corte,@i_periodo,@i_empresa,@fecnew2,@w_noviembre,'N',@i_tipo_periodo) 

          if @@error <> 0
          begin
             /* 'Error en la Insercion de Cortes  ' */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 603018
             return 1
          end
      end

      if @w_diciembre >= @i_fecha_inicio and @w_diciembre <= @i_fecha_fin
      begin   

          select @fecnew2= dateadd(dd,-1,@w_diciembre)

          select @i = count(*) 
          from corte_tmp
          where
            tmp_periodo = @i_periodo and
            tmp_empresa = @i_empresa and
            tmp_tipo_corte = 'M' 

          select @i = @i + 1

          select @w_corte = co_corte 
          from cob_conta..cb_corte
          where  co_empresa = @i_empresa and
          	co_periodo = @i_periodo and
		co_fecha_fin = @w_diciembre
                 

          insert into cob_conta..corte_tmp values 
          (@w_corte,@i_periodo,@i_empresa,@fecnew2,@w_diciembre,'N',@i_tipo_periodo) 

          if @@error <> 0
          begin
             /* 'Error en la Insercion de Cortes  ' */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 603018
             return 1
          end
      end
   end

   if @i_tipo_periodo = 'T'
   begin

      if @w_marzo >= @i_fecha_inicio and @w_marzo <= @i_fecha_fin
      begin   

          select @fecnew2= dateadd(dd,-1,@w_marzo)

          select @i = count(*) 
          from corte_tmp
          where
            tmp_periodo = @i_periodo and
            tmp_empresa = @i_empresa and
            tmp_tipo_corte = 'T' 

          select @i = @i + 1

          select @w_corte = co_corte 
          from cob_conta..cb_corte
          where  co_empresa = @i_empresa and
          	co_periodo = @i_periodo and
		co_fecha_fin = @w_marzo
                 

          insert into cob_conta..corte_tmp values 
          (@w_corte,@i_periodo,@i_empresa,@fecnew2,@w_marzo,'N',@i_tipo_periodo) 

          if @@error <> 0
          begin
             /* 'Error en la Insercion de Cortes  ' */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 603018
             return 1
          end
      end

      if @w_junio >= @i_fecha_inicio and @w_junio <= @i_fecha_fin
      begin   

          select @fecnew2= dateadd(dd,-1,@w_junio)

          select @i = count(*) 
          from corte_tmp
          where
            tmp_periodo = @i_periodo and
            tmp_empresa = @i_empresa and
            tmp_tipo_corte = 'T' 

          select @i = @i + 1

          select @w_corte = co_corte 
          from cob_conta..cb_corte
          where  co_empresa = @i_empresa and
          	co_periodo = @i_periodo and
		co_fecha_fin = @w_junio
                 

          insert into cob_conta..corte_tmp values 
          (@w_corte,@i_periodo,@i_empresa,@fecnew2,@w_junio,'N',@i_tipo_periodo) 

          if @@error <> 0
          begin
             /* 'Error en la Insercion de Cortes  ' */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 603018
             return 1
          end
      end

      if @w_septiembre >= @i_fecha_inicio and @w_septiembre <= @i_fecha_fin
      begin   

          select @fecnew2= dateadd(dd,-1,@w_septiembre)

          select @i = count(*) 
          from corte_tmp
          where
            tmp_periodo = @i_periodo and
            tmp_empresa = @i_empresa and
            tmp_tipo_corte = 'T' 

          select @i = @i + 1

          select @w_corte = co_corte 
          from cob_conta..cb_corte
          where  co_empresa = @i_empresa and
          	co_periodo = @i_periodo and
		co_fecha_fin = @w_septiembre

          insert into cob_conta..corte_tmp values 
          (@w_corte,@i_periodo,@i_empresa,@fecnew2,@w_septiembre,'N',@i_tipo_periodo) 

          if @@error <> 0
          begin
             /* 'Error en la Insercion de Cortes  ' */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 603018
             return 1
          end
      end

      if @w_diciembre >= @i_fecha_inicio and @w_diciembre <= @i_fecha_fin
      begin   

          select @fecnew2= dateadd(dd,-1,@w_diciembre)

          select @i = count(*) 
          from corte_tmp
          where
            tmp_periodo = @i_periodo and
            tmp_empresa = @i_empresa and
            tmp_tipo_corte = 'T' 

          select @i = @i + 1

          select @w_corte = co_corte 
          from cob_conta..cb_corte
          where  co_empresa = @i_empresa and
          	co_periodo = @i_periodo and
          	co_fecha_fin = @w_diciembre
                 

          insert into cob_conta..corte_tmp values 
          (@w_corte,@i_periodo,@i_empresa,@fecnew2,@w_diciembre,'N',@i_tipo_periodo) 

          if @@error <> 0
          begin
             /* 'Error en la Insercion de Cortes  ' */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 603018
             return 1
          end
      end
   end

   if @i_tipo_periodo = 'S'
   begin

      if @w_junio >= @i_fecha_inicio and @w_junio <= @i_fecha_fin
      begin   

          select @fecnew2= dateadd(dd,-1,@w_junio)

          select @i = count(*) 
          from corte_tmp
          where
            tmp_periodo = @i_periodo and
            tmp_empresa = @i_empresa and
            tmp_tipo_corte = 'S' 

          select @i = @i + 1

          select @w_corte = co_corte 
          from cob_conta..cb_corte
          where  co_empresa = @i_empresa and
          	co_periodo = @i_periodo and
		co_fecha_fin = @w_junio

          insert into cob_conta..corte_tmp values 
          (@w_corte,@i_periodo,@i_empresa,@fecnew2,@w_junio,'N',@i_tipo_periodo) 

          if @@error <> 0
          begin
             /* 'Error en la Insercion de Cortes  ' */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 603018
             return 1
          end
      end

      if @w_diciembre >= @i_fecha_inicio and @w_diciembre <= @i_fecha_fin
      begin   

          select @fecnew2= dateadd(dd,-1,@w_diciembre)

          select @i = count(*) 
          from corte_tmp
          where
            tmp_periodo = @i_periodo and
            tmp_empresa = @i_empresa and
            tmp_tipo_corte = 'S' 

          select @i = @i + 1

          select @w_corte = co_corte 
          from cob_conta..cb_corte
          where  co_empresa = @i_empresa and
          	co_periodo = @i_periodo and
		co_fecha_fin = @w_diciembre
                 

          insert into cob_conta..corte_tmp values 
          (@w_corte,@i_periodo,@i_empresa,@fecnew2,@w_diciembre,'N',@i_tipo_periodo) 

          if @@error <> 0
          begin
             /* 'Error en la Insercion de Cortes  ' */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 603018
             return 1
          end
      end
   end

   if @i_tipo_periodo = 'D'
   begin
      select @partes = datediff(dd,@i_fecha_inicio,@i_fecha_fin) + 1
      select @fecha = @i_fecha_inicio
      select @i = 1

      select @w_corte = co_corte 
      from cob_conta..cb_corte
      where  co_empresa = @i_empresa and
	co_periodo = @i_periodo and
	co_fecha_fin = @fecha
             

	if @@rowcount <> 0
	begin
	      insert into cob_conta..corte_tmp
	      values (@w_corte,@i_periodo,@i_empresa,@fecha,@fecha,'N',@i_tipo_periodo)
	end

      select @i = 2
      while @i <= @partes
      begin
        select @fecnew1 = dateadd(dd,1,@fecha)

        select @w_corte = co_corte 
        from cob_conta..cb_corte
        where  co_empresa = @i_empresa and
        	co_periodo = @i_periodo and
		co_fecha_fin = @fecnew1
               

	if @@rowcount <> 0
	begin
            insert into cob_conta..corte_tmp
            values (@w_corte,@i_periodo,@i_empresa,@fecnew1,@fecnew1,'N', @i_tipo_periodo)                        
	end
        select @i = @i + 1
        select @fecha = @fecnew1
      end
   end

   commit tran
   return 0
end

go
